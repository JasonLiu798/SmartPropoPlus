; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "SmartPropoPlus"
#define MyAppVersion "3.3.10"
#define MyAppURL "http://www.smartpropoplus.com/"
#define MyAppExeName "SppConsole.exe"


[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppID={{2E84A5A4-351E-4B00-9926-F50DBD7481E9}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=true
OutputDir=C:\Users\Shaul\Desktop
OutputBaseFilename=setup
;SetupIconFile=..\inno\Setup.ico
Compression=zip/7
SolidCompression=true
ShowLanguageDialog=no
DisableWelcomePage=true
FlatComponentsList=false
MinVersion=,5.1.2600sp1
UserInfoPage=false
SourceDir=..
OnlyBelowVersion=0,0
UninstallLogMode=append
VersionInfoVersion=3.3.10.1
VersionInfoCompany=Shaul Eizikovich
AppCopyright=Copyright (c) 2005-2011 by Shaul Eizikovich
DisableDirPage=auto

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: ..\SppConsole\Release\SppConsole.exe; DestDir: {app}; Flags: recursesubdirs promptifolder createallsubdirs; 
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}" ; WorkingDir: "{app}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon
Name: ..\; Filename: ..\..\SppConsole\res\SppConsole.ico; IconFilename: {app}\SppConsole.exe; Tasks: "desktopicon quicklaunchicon"; 

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, "&", "&&")}}"; Flags: nowait postinstall skipifsilent

[Types]
;Name: "full"; Description: "Full installation"
;Name: "compact"; Description: "Compact installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom


[Components]
;Name: SmartPropoPlus; Description: "Top App"; Flags: dontinheritcheck; MinVersion: 0,5.1.2600; Languages: english hebrew; 
Name: FMS; Description: "SmartPropoPlus For Fms"; Flags: exclusive checkablealone; Check: isFmsInstalled; Types: custom; 
Name: Generic; Description: "Generic SmartPropoPlus"; Flags: exclusive; 
Name: Generic/vJoy; Description: vJoy; Check: DisplayvJoyComponent and ( isFmsInstalled); Flags: checkablealone;
Name: Generic/vJoy; Description: vJoy; Check: DisplayvJoyComponent and ( not isFmsInstalled) ; Flags: checkablealone; Types: custom; 

[code]
function IsX64: Boolean;
begin
  Result := Is64BitInstallMode and (ProcessorArchitecture = paX64);
end;

function IsIA64: Boolean;
begin
  Result := Is64BitInstallMode and (ProcessorArchitecture = paIA64);
end;

function IsOtherArch: Boolean;
begin
  Result := not IsX64 and not IsIA64;
end;

function DisplayvJoyComponent(): Boolean;
begin
  Result := True;
end;

function isFmsInstalled: Boolean;
var
  RegValFms, Fms: String;
  S: String;
  FmsLen: Longint;
  
begin  
  RegValFms := 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FMS';
  if RegQueryStringValue(HKEY_LOCAL_MACHINE, RegValFms, 'DisplayName', Fms) then
   begin
    FmsLen := Length(Fms);
    if FmsLen = 0 then Result := False
    else begin
      Result := True;
      S := Format('Length of == %s== is %d', [Fms, FmsLen]); 
      //MsgBox(S, mbInformation, MB_OK);
    end;
   end
   else
    Result := False;
end;

[InnoIDE_Settings]
LogFile=C:\Users\Shaul\Documents\SmartPropoPlus\HEAD\SPP33x\branches\3310\Installer\Inno\SppInstall.log
LogFileOverwrite=false
