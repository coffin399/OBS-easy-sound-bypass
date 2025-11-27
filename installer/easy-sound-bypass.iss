; Inno Setup script for Easy Sound Bypass
#define MyAppName "Easy Sound Bypass"
#define MyAppVersion "0.1.0"
#define MyAppPublisher "Easy Sound Bypass"
#define MyAppURL "https://github.com/coffin399/OBS-easy-sound-bypass"

[Setup]
AppId={{E4E1A8F4-1B9D-4F73-9F0D-ESB000000001}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
DefaultDirName={code:GetDefaultObsDir}
DisableDirPage=no
OutputDir=Output
OutputBaseFilename=easy-sound-bypass-setup
ArchitecturesInstallIn64BitMode=x64
DisableProgramGroupPage=yes
Compression=lzma
SolidCompression=yes

[Languages]
Name: "japanese"; MessagesFile: "compiler:Languages/Japanese.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
; Copy 64bit plugin DLL into OBS plugin folder under the chosen OBS root
Source: "..\\build\\Release\\easy-sound-bypass.dll"; DestDir: "{app}\\obs-plugins\\64bit"; Flags: ignoreversion

[Icons]
Name: "{app}\\Easy Sound Bypass - README"; Filename: "{#MyAppURL}"

[Code]
// Try to detect a reasonable default OBS Studio installation directory
function GetDefaultObsDir(Param: string): string;
begin
  if DirExists(ExpandConstant('{pf}\\obs-studio')) then
    Result := ExpandConstant('{pf}\\obs-studio')
  else if IsWin64 and DirExists(ExpandConstant('{pf32}\\obs-studio')) then
    Result := ExpandConstant('{pf32}\\obs-studio')
  else
    Result := ExpandConstant('{pf}\\obs-studio');
end;
