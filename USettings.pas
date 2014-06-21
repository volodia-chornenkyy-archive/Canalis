unit USettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IniFiles,
  Vcl.Buttons, Vcl.ExtCtrls, System.Win.Registry;

type
  TFSettings = class(TForm)
    pnlSettings: TPanel;
    btnPassChange: TBitBtn;
    btnIgnoreListShow: TBitBtn;
    chkFiltered: TCheckBox;
    chkAutorun: TCheckBox;
    btnClose: TBitBtn;
    rgStatisticTime: TRadioGroup;
    chkGraph3d: TCheckBox;
    procedure chkClick(Sender: TObject);
    procedure btnIgnoreListShowClick(Sender: TObject);
    procedure btnPassChangeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure Autorun(Flag:boolean; NameParam, Path:String);
    procedure rgStatisticTimeClick(Sender: TObject);
    procedure SetIniSettings;
    procedure GetIniSettings;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSettings: TFSettings;
  boolSettingsChange: Boolean = False;
implementation

uses UPassChange, UStatistic, UIgnoreList;

{$R *.dfm}

procedure TFSettings.SetIniSettings;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Settings.ini');
  with IniFile do
  begin
    WriteBool('Settings','IgnoreList',chkFiltered.Checked);
    WriteBool('Settings','Autorun',chkAutorun.Checked);
    WriteInteger('Settings','StatisticTime',rgStatisticTime.ItemIndex);
    WriteBool('Settings','3DGraphs',chkGraph3d.Checked);
  end;
  IniFile.Free;
  boolSettingsChange := False;
end;

procedure TFSettings.GetIniSettings;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Settings.ini');
  chkFiltered.Checked := IniFile.ReadBool('Settings','IgnoreList',True);
  chkAutorun.Checked := IniFile.ReadBool('Settings','Autorun',True);
  rgStatisticTime.ItemIndex := IniFile.ReadInteger('Settings','StatisticTime',1);
  chkGraph3d.Checked := IniFile.ReadBool('Settings','3DGraphs',False);
  IniFile.Free;
  boolSettingsChange := False;
end;

procedure TFSettings.rgStatisticTimeClick(Sender: TObject);
begin
  boolSettingsChange := True;
end;

procedure TFSettings.Autorun(Flag:boolean; NameParam, Path:String);
var Reg:TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', false);
  if Flag then
    Reg.WriteString(NameParam, Path)
  else
    Reg.DeleteValue(NameParam);
  Reg.Free;
end;

procedure TFSettings.chkClick(Sender: TObject);
begin
  boolSettingsChange := True;
end;

procedure TFSettings.FormShow(Sender: TObject);
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'Settings.ini') then
    GetIniSettings()
  else
    SetIniSettings();
end;

procedure TFSettings.btnCloseClick(Sender: TObject);
begin
  if boolSettingsChange then
    if MessageDlg('Зберегти налашування?',mtConfirmation,mbYesNo,0) = mrYes then
    begin
      SetIniSettings();
      if chkAutorun.Checked then
        Autorun(True,'Canalis',Application.ExeName)
      else
        Autorun(False,'Canalis',Application.ExeName);
      MessageBox(handle, PChar('Налаштування успішно збережені'),
      PChar(''), MB_ICONINFORMATION+MB_OK);
      FStatistic.StatisticStartup();
      FStatistic.BetweenQuery();
      if FStatistic.pgcMain.TabIndex = 1 then
        FStatistic.cbbVisionChoiceChange(nil);
    end
    else
      GetIniSettings();
  Close;
end;

procedure TFSettings.btnIgnoreListShowClick(Sender: TObject);
begin
  if not (Assigned(FCategoryList)) then
    FCategoryList := TFCategoryList.Create(Self);
  FCategoryList.Show;
end;

procedure TFSettings.btnPassChangeClick(Sender: TObject);
begin
  if not (Assigned(FPassChange)) then
    FPassChange := TFPassChange.Create(Self);
  FPassChange.ShowModal;
end;

end.
