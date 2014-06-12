unit USettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IniFiles,
  Vcl.Buttons, Vcl.CheckLst, Vcl.ExtCtrls, System.Win.Registry;

type
  TFSettings = class(TForm)
    pnlSettings: TPanel;
    btnApply: TBitBtn;
    btnRestore: TBitBtn;
    btnPassChange: TBitBtn;
    btnIgnoreListShow: TBitBtn;
    chbBrowserHistory: TCheckBox;
    chklstBrowser: TCheckListBox;
    chkFiltered: TCheckBox;
    chkAutorun: TCheckBox;
    btnClose: TBitBtn;
    rgStatisticTime: TRadioGroup;
    chkGraph3d: TCheckBox;
    procedure btnRestoreClick(Sender: TObject);
    procedure chbBrowserHistoryClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure chkClick(Sender: TObject);
    procedure btnIgnoreListShowClick(Sender: TObject);
    procedure btnPassChangeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

uses UPassChange, UMain, USecurity, UStatistic, UIgnoreList;

{$R *.dfm}

procedure TFSettings.SetIniSettings;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Settings.ini');
  with IniFile do
  begin
    WriteBool('SkipedBrowsers','enabled',chbBrowserHistory.Checked);
    WriteBool('SkipedBrowsers','chrome',chklstBrowser.Checked[0]);
    WriteBool('SkipedBrowsers','firefox',chklstBrowser.Checked[1]);
    WriteBool('SkipedBrowsers','opera',chklstBrowser.Checked[2]);
    WriteBool('SkipedBrowsers','ie',chklstBrowser.Checked[3]);
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
  chbBrowserHistory.Checked := IniFile.ReadBool('SkipedBrowsers','enabled',False);
  chklstBrowser.Checked[0] := IniFile.ReadBool('SkipedBrowsers','chrome',False);
  chklstBrowser.Checked[1] := IniFile.ReadBool('SkipedBrowsers','chrome',False);
  chklstBrowser.Checked[2] := IniFile.ReadBool('SkipedBrowsers','chrome',False);
  chklstBrowser.Checked[3] := IniFile.ReadBool('SkipedBrowsers','chrome',False);
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

procedure TFSettings.chbBrowserHistoryClick(Sender: TObject);
var
  i: integer;
begin
  if chbBrowserHistory.Checked then
  begin
    chklstBrowser.Enabled := True;
  end
  else
    chklstBrowser.Enabled := False;
  boolSettingsChange := True;
end;

procedure TFSettings.chkClick(Sender: TObject);
begin
  boolSettingsChange := True;
end;

procedure TFSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if boolSettingsChange then
  if MessageDlg('�������� �����������?',mtConfirmation,mbYesNo,0) = mrYes then
    btnApply.Click
  else
    GetIniSettings;
  if chkAutorun.Checked then
    Autorun(True,'Canalis',Application.ExeName)
  else
    Autorun(False,'Canalis',Application.ExeName);
end;

procedure TFSettings.FormShow(Sender: TObject);
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'Settings.ini') then
    GetIniSettings
  else
    SetIniSettings;
end;

procedure TFSettings.btnCloseClick(Sender: TObject);
begin
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

procedure TFSettings.btnApplyClick(Sender: TObject);
begin
  SetIniSettings;
  if Assigned(FStatistic) then
    FStatistic.cbbVisionChoiceChange(nil);
  MessageBox(handle, PChar('������������ ������ ���������'),PChar(''), MB_ICONINFORMATION+MB_OK);
  Close;
end;

procedure TFSettings.btnRestoreClick(Sender: TObject);
begin
  if PasswordCheck then
    GetIniSettings
  else
    MessageBox(handle, PChar('�������� ������ �����'),PChar('������� ������'), MB_ICONERROR+MB_OK);
end;

end.
