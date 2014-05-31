unit UIniFile;

interface

uses System.IniFiles,
      USettings;

procedure SetDefaultIniSetting;
procedure SetIniSetting;
procedure GetIniSetting;

implementation

procedure SetDefaultIniSetting;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('Settings');
  with IniFile do
  begin
    WriteBool('SkipedBrowsers','enabled',False);
    WriteBool('SkipedBrowsers','chrome',False);
    WriteBool('SkipedBrowsers','firefox',False);
    WriteBool('SkipedBrowsers','opera',False);
    WriteBool('SkipedBrowsers','ie',False);
    WriteBool('Settings','IgnoreList',True);
    WriteBool('Settings','Autorun',True);
  end;
  IniFile.Free;
end;

procedure SetIniSetting;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('Settings');
  with FSettings do
  begin
    chbBrowserHistory.Enabled := IniFile.ReadBool('SkipedBrowsers','enabled',False);
    chklstBrowser.Checked[0] := IniFile.ReadBool('SkipedBrowsers','chrome',False);
    chklstBrowser.Checked[1] := IniFile.ReadBool('SkipedBrowsers','chrome',False);
    chklstBrowser.Checked[2] := IniFile.ReadBool('SkipedBrowsers','chrome',False);
    chklstBrowser.Checked[3] := IniFile.ReadBool('SkipedBrowsers','chrome',False);
    chkFiltered.Enabled := IniFile.ReadBool('Settings','IgnoreList',True);
    chkAutorun.Enabled := IniFile.ReadBool('Settings','Autorun',True);
  end;
  IniFile.Free;
end;

procedure GetIniSetting;
begin
  //
end;

end.
