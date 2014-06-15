unit UIgnoreList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFCategoryList = class(TForm)
    pnl: TPanel;
    btnSave: TBitBtn;
    btnDelete: TBitBtn;
    lbl1: TLabel;
    lbl3: TLabel;
    mmoContent: TMemo;
    btnClose: TBitBtn;
    cbbCategory: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mmoContentKeyPress(Sender: TObject; var Key: Char);
    procedure FindFiles(pathFile: string; typeFile: string);
    procedure cbbCategoryChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCategoryList: TFCategoryList;

implementation

uses UMain, UStatistic;

{$R *.dfm}

procedure TFCategoryList.btnCloseClick(Sender: TObject);
begin
  if cbbCategory.Enabled = False then
    btnSave.Click;
  mmoContent.Lines.Clear;
  cbbCategory.Items.Clear;
  mmoContent.Tag := 0;
  Close;
end;

procedure TFCategoryList.btnDeleteClick(Sender: TObject);
begin
  if MessageBox(handle, PChar('Ви впевнені що хочете видалити категорію ' +
    cbbCategory.Items[cbbCategory.ItemIndex]), PChar(''),
    MB_YESNO + MB_ICONWARNING) = IDYES then
  begin
    DeleteFile('data\category\' + cbbCategory.Items[cbbCategory.ItemIndex]
      + '.txt');
    cbbCategory.Items.Clear;
    FindFiles('data\category\', '*.txt');
  end;
end;

procedure TFCategoryList.FindFiles(pathFile: string; typeFile: string);
var
  sr: TSearchRec;
begin
  if FindFirst(ExtractFilePath(ParamStr(0)) + pathFile + typeFile, faAnyFile,
    sr) = 0 then
  begin
    repeat
      cbbCategory.Items.Add(FMain.ExtractFileNameEX(sr.Name));
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

procedure TFCategoryList.btnSaveClick(Sender: TObject);
var
  msgRsult: Byte;
begin
  msgRsult := MessageBox(handle,
    PChar('Зберегти категорію ' + cbbCategory.Items[cbbCategory.ItemIndex] +
    '? (Yes)' + #13 + 'Створити нове ім''я? (No)' + #13 +
    'Відмінити налаштування? (Cancel)'), PChar(''),
    MB_YESNOCANCEL + MB_ICONWARNING);
  if msgRsult = IDYES then
    mmoContent.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'data\category\'
      + cbbCategory.Items[cbbCategory.ItemIndex] + '.txt')
  else if msgRsult = IDNO then
    mmoContent.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'data\category\'
      + InputBox('', 'Введіть ім''я категорії', mmoContent.Lines[0]) + '.txt');
  if msgRsult <> IDCANCEL then
  begin
    cbbCategory.Items.Clear;
    FindFiles('data\category\', '*.txt');
    FStatistic.StatisticStartup();
  end;
  cbbCategory.Enabled := True;
  mmoContent.Tag := 0;
end;

procedure TFCategoryList.cbbCategoryChange(Sender: TObject);
var
  temp: TStringList;
begin
  if mmoContent.Tag = 0 then
    mmoContent.Lines.LoadFromFile('data\category\' + cbbCategory.Items
      [cbbCategory.ItemIndex] + '.txt')
  else
  begin
    temp := TStringList.Create;
    temp.LoadFromFile('data\category\' + cbbCategory.Items
      [cbbCategory.ItemIndex] + '.txt');
    mmoContent.Lines.AddStrings(temp);
    temp.Free;
  end;
end;

procedure TFCategoryList.FormShow;
begin
  FindFiles('data\category\', '*.txt');
  cbbCategory.ItemIndex := -1;
  mmoContent.Lines.Add('Виберіть категорію з випадаючого списку');
end;

procedure TFCategoryList.mmoContentKeyPress(Sender: TObject; var Key: Char);
begin
  if mmoContent.Tag = 0 then
    cbbCategory.Enabled := False;
end;

end.
