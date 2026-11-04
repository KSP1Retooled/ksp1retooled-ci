; Built by package.sh with /DAppVersion and /DPublishDir.

[Setup]
AppId={{6F2C1E7A-4B3D-4E19-9A58-2D7C0B8E5F31}
AppName=KSP Retooled Launcher
AppVersion={#AppVersion}
AppPublisher=KSP Retooled
DefaultDirName={autopf}\KSP Retooled Launcher
DefaultGroupName=KSP Retooled
DisableProgramGroupPage=yes
; A per-user install: the launcher itself never needs elevation.
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputBaseFilename=RetooledLauncher-{#AppVersion}-win-x64-setup
UninstallDisplayIcon={app}\RetooledLauncher.exe
Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Files]
Source: "{#PublishDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\KSP Retooled Launcher"; Filename: "{app}\RetooledLauncher.exe"
Name: "{autodesktop}\KSP Retooled Launcher"; Filename: "{app}\RetooledLauncher.exe"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"

[Run]
Filename: "{app}\RetooledLauncher.exe"; Description: "Start KSP Retooled Launcher"; Flags: nowait postinstall skipifsilent
