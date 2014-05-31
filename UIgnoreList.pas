unit UIgnoreList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFCategoryList = class(TForm)
    lstIgnoreList: TListBox;
    pnl: TPanel;
    btnSave: TBitBtn;
    btnDelete: TBitBtn;
    btnClose: TBitBtn;
    cbbCategory: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cbbCategoryChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCategoryList: TFCategoryList;
  blSaveCheck: Boolean;
implementation

uses UMain;

{$R *.dfm}

procedure TFCategoryList.btnCloseClick(Sender: TObject);
begin
  if blSaveCheck = False then
  if  MessageBox(handle, PChar('������ �� ����������. ��������?'),
    PChar(''), MB_YESNO+MB_ICONQUESTION) = mrYes then
  begin
    btnSave.Click;
  end;
  FCategoryList.Close;
end;

procedure TFCategoryList.btnDeleteClick(Sender: TObject);
begin
  lstIgnoreList.DeleteSelected;
  lstIgnoreList.ItemIndex := 0;
  blSaveCheck := False;
end;

procedure TFCategoryList.btnSaveClick(Sender: TObject);
begin
  if blSaveCheck = False then
  begin
    lstIgnoreList.Items.SaveToFile('data\Ignore.lst');
    blSaveCheck := True;
    MessageBox(handle, PChar('������ ����������.'),
      PChar(''), MB_OK+MB_ICONWARNING);
  end;
end;

procedure TFCategoryList.cbbCategoryChange(Sender: TObject);
begin
  btnSave.Click;

  if cbbCategory.ItemIndex = 0 then
    lstIgnoreList.Items.LoadFromFile('data\Ignore.lst')
  else
    lstIgnoreList.Items.LoadFromFile('data\category\' +
      cbbCategory.Items[cbbCategory.ItemIndex] + '.txt');
end;

procedure TFCategoryList.FormShow;
var
  sr: TSearchRec;
begin
  lstIgnoreList.Items.LoadFromFile('data\Ignore.lst');
  cbbCategory.Items.Add('���������� ���������');
  cbbCategory.ItemIndex := 0;

  if FindFirst('data\category\*.txt', faAnyFile, sr) = 0 then
  begin
    repeat
      cbbCategory.Items.Add(FMain.ExtractFileNameEX(sr.Name));
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;

  blSaveCheck := True;
end;

end.
