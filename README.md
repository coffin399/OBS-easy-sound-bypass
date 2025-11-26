# Easy Sound Bypass

OBS Studio 用の簡単なオーディオバイパス用プラグインです。

- OBS 内の **音声ソース** を1つ選ぶ
- PC 上の **出力デバイス（例: CABLE Input などの仮想デバイス）** を1つ選ぶ
- 「保存 / 適用」ボタンを押す

だけで、「その音声ソースの音だけを、選んだデバイスへモニタリング出力」できます。

> **想定ユースケース**
> - OBSの特定ソースだけを Discord / Zoom / ゲーム などに送りたい
> - VB-Audio CABLE などの仮想デバイスへ簡単にルーティングしたい

---

## インストール方法（ユーザー向け）

1. GitHub の Releases ページから最新リリース `Easy Sound Bypass (latest)` を開く
2. アセットから `easy-sound-bypass.dll` をダウンロード
3. DLL を OBS のプラグインフォルダに配置
   - 例: `C:\Program Files\obs-studio\obs-plugins\64bit\`
4. OBS を再起動
5. メニューの `ツール > Easy Sound Bypass` が表示されていればインストール成功

### 使い方

1. OBS で通常どおりシーン／ソースを設定
2. メニューから `ツール > Easy Sound Bypass` を開く
3. ダイアログで次の2つを選択
   - `音声ソース` : OBS 内の音声ソース一覧から選択
   - `出力デバイス` : システム上のオーディオデバイス一覧から選択（CABLE Input など）
4. `保存 / 適用` ボタンを押す

これで、選んだソースの音が、選んだ出力デバイスへ **モニタリング出力** されます。

> 注意: モニタリングデバイスは OBS 全体の設定なので、他の「モニタリングON」のソースも同じデバイスに出力されます。

---

## 開発者・メンテナ向け情報

GitHub Actions を使って、Windows 向け DLL のビルドと `latest` リリースの自動更新を行います。
ローカル環境に Qt や OBS を入れなくても、push だけで CI から DLL を配布できます（Plan A）。

### 1. OBS dev パッケージの用意

CI では、あらかじめ作成した「OBS dev パッケージ(zip)」をダウンロードして利用します。
この zip には、OBS のヘッダとライブラリだけをまとめて含めておきます。

#### ディレクトリ構成（zip 展開後）

zip を展開したときに、次のような構成になるようにします。

```text
obs-dev/                # ← ルートディレクトリ（固定名想定）
  include/
    libobs/
      obs.h など libobs のヘッダ一式
    obs-frontend-api/
      obs-frontend-api.h など
  lib/
    obs.lib
    obs-frontend-api.lib
    (必要に応じて他の依存 .lib)
```

このディレクトリ全体を zip にして、例えば `obs-dev-windows.zip` のような名前で任意の場所にホスティングします。

#### どこにホスティングするか

- 自前の CDN / オブジェクトストレージ (S3, Cloudflare R2 など)
- 別リポジトリの Release アセット

など、**HTTP(S) でダウンロード可能な場所**であれば問題ありません。

URL を決めたら、ワークフローの `OBS_DEV_URL` を書き換えます。

```yaml
env:
  OBS_DEV_URL: https://your.host/path/to/obs-dev-windows.zip
```

### 2. GitHub Actions の挙動

`.github/workflows/build.yml` は、次の流れで動作します。

1. コードを checkout
2. `jurplel/install-qt-action` を使って Qt 6 をインストール
3. `OBS_DEV_URL` から OBS dev パッケージ(zip)をダウンロードして展開
4. 展開したヘッダ/ライブラリパスを使って CMake を構成
5. Visual Studio 2022 (MSVC) で Release ビルド
6. `easy-sound-bypass.dll` を artifact としてアップロード
7. push イベント時: `latest` タグの GitHub Release を自動作成/更新し、DLL をアセットとして登録

### 3. CMake / ビルド構成

`CMakeLists.txt` は Qt6 + 事前用意した OBS dev パスを前提としています。

- Qt6 検出:

```cmake
find_package(Qt6 COMPONENTS Widgets Core Gui REQUIRED)
```

- OBS / Qt のリンク:

```cmake
add_library(easy-sound-bypass MODULE
    src/cable_router.cpp
)

# これらの変数は CI から渡される
# OBS_INCLUDE_DIR           -> obs-dev/include/libobs
# OBS_FRONTEND_INCLUDE_DIR  -> obs-dev/include/obs-frontend-api
# OBS_LIB_DIR               -> obs-dev/lib
# OBS_FRONTEND_LIB_DIR      -> obs-dev/lib

target_include_directories(easy-sound-bypass PRIVATE
    ${OBS_INCLUDE_DIR}
    ${OBS_FRONTEND_INCLUDE_DIR}
)

link_directories(
    ${OBS_LIB_DIR}
    ${OBS_FRONTEND_LIB_DIR}
)

target_link_libraries(easy-sound-bypass PRIVATE
    obs
    obs-frontend-api
    Qt6::Widgets
    Qt6::Core
    Qt6::Gui
)

set_target_properties(easy-sound-bypass PROPERTIES
    PREFIX ""
    OUTPUT_NAME "easy-sound-bypass"
)
```

ローカルでビルドする場合は、適切な Qt6 と OBS dev パスを自分で指定して `cmake` コマンドを実行すれば同じようにビルドできます。

---

## ライセンス

※ まだ未定の場合はここにライセンス表記を追加してください（例: MIT, GPL など）。
