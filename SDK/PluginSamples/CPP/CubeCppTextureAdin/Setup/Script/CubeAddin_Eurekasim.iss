; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "CubeTextureAddin"
#define MyAppVersion "1.0.3"
#define MyAppPublisher "Eurekasim"
#define MyAppURL "https://www.eurekasim.com/"
#define MyAppExeName "CubeTextureAddin.dll"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt ".myp"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{2569E2A3-A1B6-4D39-8A3B-E3E2AD3A8D50}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\CubeTextureAddin_Eurekasim
ChangesAssociations=yes
DisableProgramGroupPage=yes
LicenseFile=D:\Developer World\CubeTextureAddin\Setup\Script\Resource\License.txt
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=D:\Developer World\CubeTextureAddin\Setup\Output
OutputBaseFilename=CubeTextureAddin_Eurekasim
SetupIconFile=D:\Developer World\CubeTextureAddin\Setup\Script\Resource\dice.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
WizardSmallImageFile="D:\Developer World\CubeTextureAddin\Setup\Script\Resource\EurekaSimSetupBanner.bmp"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]    
Source: "D:\Developer World\CubeTextureAddin\Source\Release\{#MyAppExeName}"; DestDir: "{app}\x86"; Flags:restartreplace ignoreversion regserver 32bit; 
Source: "D:\Developer World\CubeTextureAddin\Source\x64\Release\{#MyAppExeName}"; DestDir: "{app}\x64";  Flags: regserver; Check: IsWin64
Source: "D:\Developer World\CubeTextureAddin\Source\*"; DestDir: "{app}\CubeCppTextureAdin"; Flags: restartreplace ignoreversion recursesubdirs createallsubdirs; Components: source
Source: "D:\Developer World\CubeTextureAddin\Source\Release\CubeTextureAddin.dll"; DestDir: "{app}"; Flags:  ignoreversion

; NOTE: Don't use "Flags: ignoreversion" on any shared system files
   [Components]
Name: "CubeTextureAddin"; Description: "Program Files"; Types: full compact custom; Flags: fixed
Name: "source"; Description: "Source Files"; Types: full
[Registry]
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""

[Code]
 function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := IsAdminInstallMode and (PageID = wpUserInfo);
end;
var 
  CancelWithoutPrompt: boolean;

function InitializeSetup(): Boolean;
var
  ErrCode: integer;
begin
  // check for .NET Framework
  Result := True;
  if not IsDotNetInstalled(net452, 0) then
  begin
    if MsgBox('The required .NET Framework version 4.5.2 or above is not installed. Would you like to download .NET now?', mbConfirmation, MB_YESNO) = IDYES
      then begin
        ShellExec('open', 'https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net452-web-installer',
        '', '', SW_SHOW, ewNoWait, ErrCode);
    end;
    Result := False;
  end
  else
  begin
    // check for registry key
    if not RegKeyExists(HKCU, 'SOFTWARE\KTS Innovation Labs\EurekaSim') then
    begin
      Result := False;
      MsgBox('please install EurekaSim first!!', mbError, MB_OK);
    end;
  end;
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  if CurPageID=wpInstalling then
    Confirm := not CancelWithoutPrompt;
end;
[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

;[Run]
;Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: shellexec postinstall skipifsilent
[Run]
; Register 32-bit DLL
Filename: "{syswow64}\regsvr32.exe"; Parameters: /codebase CubeTextureAddin.dll;WorkingDir:{app}\x86\; Flags: runminimized; StatusMsg: "Registering 32-bit Visual C++ DLL..."; Check: not IsWin64

; Register 64-bit DLL
Filename: "{sys}\regsvr32.exe"; Parameters: /codebase CubeTextureAddin.dll;WorkingDir:{app}\x64\; Flags: runminimized; StatusMsg: "Registering 64-bit Visual C++ DLL..."; Check: IsWin64

[UninstallRun]
; Unregister 32-bit DLL
Filename: "{syswow64}\regsvr32.exe";Parameters: /unregister CubeTextureAddin.dll;WorkingDir:{app}\x86\; Flags: runminimized; RunOnceId: "Unregistering 32-bit Visual C++ DLL..."; Check: not IsWin64

; Unregister 64-bit DLL
Filename: "{sys}\regsvr32.exe";Parameters: /unregister CubeTextureAddin.dll;WorkingDir:{app}\x64\; Flags: runminimized; RunOnceId: "Unregistering 64-bit Visual C++ DLL..."; Check: IsWin64
