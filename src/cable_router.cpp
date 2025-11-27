#include <obs-module.h>
#include "../obs-studio/UI/obs-frontend-api/obs-frontend-api.h"

#include <QDialog>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QComboBox>
#include <QPushButton>
#include <QLabel>
#include <QString>
#include <QVariant>

OBS_DECLARE_MODULE();
OBS_MODULE_USE_DEFAULT_LOCALE("easy-sound-bypass", "en-US");

static void open_dialog(void *data);
static bool enum_monitoring_devices(void *data, const char *name, const char *id);

class CableRouterDialog : public QDialog {
public:
    explicit CableRouterDialog(QWidget *parent = nullptr)
        : QDialog(parent)
    {
        setWindowTitle("Easy Sound Bypass");

        auto *layout = new QVBoxLayout(this);

        auto *sourceLayout = new QHBoxLayout();
        auto *label = new QLabel("音声ソース:", this);
        sourceCombo = new QComboBox(this);

        sourceLayout->addWidget(label);
        sourceLayout->addWidget(sourceCombo);
        layout->addLayout(sourceLayout);

        auto *deviceLayout = new QHBoxLayout();
        auto *deviceLabel = new QLabel("出力デバイス:", this);
        deviceCombo = new QComboBox(this);

        deviceLayout->addWidget(deviceLabel);
        deviceLayout->addWidget(deviceCombo);
        layout->addLayout(deviceLayout);

        auto *btnLayout = new QHBoxLayout();
        btnApply = new QPushButton("保存 / 適用", this);
        btnLayout->addStretch();
        btnLayout->addWidget(btnApply);
        layout->addLayout(btnLayout);

        populateSources();
        populateDevices();

        QObject::connect(btnApply, &QPushButton::clicked, this, [this]() {
            onApplyClicked();
        });
    }

private:
    void onApplyClicked()
    {
        QString name = sourceCombo->currentText();
        if (name.isEmpty())
            return;

        int deviceIndex = deviceCombo->currentIndex();
        if (deviceIndex >= 0) {
            QVariant deviceIdVar = deviceCombo->itemData(deviceIndex);
            QString deviceId = deviceIdVar.toString();
            if (!deviceId.isEmpty()) {
                QByteArray idUtf8 = deviceId.toUtf8();
                obs_set_audio_monitoring_device(idUtf8.constData());
            }
        }

        obs_source_t *source = obs_get_source_by_name(name.toUtf8().constData());
        if (!source)
            return;

        obs_source_set_monitoring_type(source, OBS_MONITORING_TYPE_MONITOR_ONLY);

        obs_source_release(source);
    }

    void populateSources()
    {
        obs_source_t **sources = nullptr;
        size_t count = 0;
        obs_enum_sources(&sources, &count);

        for (size_t i = 0; i < count; ++i) {
            obs_source_t *src = sources[i];
            uint32_t flags = obs_source_get_output_flags(src);
            if (flags & OBS_SOURCE_AUDIO) {
                const char *name = obs_source_get_name(src);
                sourceCombo->addItem(QString::fromUtf8(name));
            }
        }

        bfree(sources);
    }

    void populateDevices();

    QComboBox *sourceCombo = nullptr;
    QComboBox *deviceCombo = nullptr;
    QPushButton *btnApply = nullptr;
};

static CableRouterDialog *g_dialog = nullptr;

bool obs_module_load(void)
{
    obs_frontend_add_tools_menu_item("Easy Sound Bypass", open_dialog, nullptr);
    return true;
}

void obs_module_unload(void)
{
    if (g_dialog) {
        g_dialog->close();
        delete g_dialog;
        g_dialog = nullptr;
    }
}

static void open_dialog(void *)
{
    if (!g_dialog) {
        QWidget *parent = static_cast<QWidget *>(obs_frontend_get_main_window());
        g_dialog = new CableRouterDialog(parent);
    }

    g_dialog->show();
    g_dialog->raise();
    g_dialog->activateWindow();
}

static bool enum_monitoring_devices(void *data, const char *name, const char *id)
{
    QComboBox *combo = static_cast<QComboBox *>(data);
    if (!combo)
        return false;

    combo->addItem(QString::fromUtf8(name), QString::fromUtf8(id));
    return true;
}

void CableRouterDialog::populateDevices()
{
    if (!deviceCombo)
        return;

    deviceCombo->clear();
    obs_enum_audio_monitoring_devices(enum_monitoring_devices, deviceCombo);
}
