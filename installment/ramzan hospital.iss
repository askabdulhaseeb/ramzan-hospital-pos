; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "ramzan clinic"
#define MyAppVersion "1"
#define MyAppPublisher "Dev markaz"
#define MyAppURL "https://www.devmarkaz.com/"
#define MyAppExeName "MyProg.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{7EFE6B4D-A029-45DA-820E-9A554B3E6796}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=C:\Users\usman\OneDrive\Documents\GitHub\ramzan-hospital-pos\installment
OutputBaseFilename=Ramzan Clinic
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Program Files (x86)\Inno Setup 6\Examples\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\usman\OneDrive\Documents\GitHub\ramzan-hospital-pos\build\windows\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\usman\OneDrive\Documents\GitHub\ramzan-hospital-pos\build\windows\runner\Release\pdfium.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\usman\OneDrive\Documents\GitHub\ramzan-hospital-pos\build\windows\runner\Release\printing_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\usman\OneDrive\Documents\GitHub\ramzan-hospital-pos\build\windows\runner\Release\ramzanhospital_pos.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\usman\OneDrive\Documents\GitHub\ramzan-hospital-pos\build\windows\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

