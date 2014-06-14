unit UCategoryMaster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.DateUtils;

type
  TFCategoryMaster = class(TForm)
    lbledtName: TLabeledEdit;
    btnCreate: TBitBtn;
    mmoKeyWords: TMemo;
    lblKeyWords: TLabel;
    procedure btnCreateClick(Sender: TObject);
    procedure CategoryCreate(operationWithFile: string; pathFile: string);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCategoryMaster: TFCategoryMaster;

implementation

uses UMain, UStatistic;

{$R *.dfm}

procedure TFCategoryMaster.CategoryCreate(operationWithFile: string;
                                          pathFile: string);
var
  vDate: TDate;
  i,j: integer;
  vCategoryList: TStringList;
  vFileContent: TStringList;
  vWriteCheck: Boolean;
begin
  vCategoryList := TStringList.Create;
  vCategoryList.Assign(mmoKeyWords.Lines);
  FStatistic.RemoveStringListDuplicates(vCategoryList);

  if operationWithFile = 'rewrite' then
    vCategoryList.SaveToFile(pathFile)
  else if operationWithFile = 'append' then
  begin
    vFileContent := TStringList.Create;
    vFileContent.LoadFromFile(pathFile);
    for i := 0 to vCategoryList.Count-1 do
    begin
      vWriteCheck := True;
      for j := 0 to vFileContent.Count-1 do
      begin
        if vCategoryList[i] = vFileContent[j] then
          vWriteCheck := False;
      end;
      if vWriteCheck then
        vFileContent.Add(vCategoryList[i]);
    end;
    vFileContent.SaveToFile(pathFile);
    vFileContent.Free;
  end;

  vCategoryList.Free;
  boolChanges := True;
  FCategoryMaster.Close;
end;

procedure TFCategoryMaster.FormShow(Sender: TObject);
begin
  mmoKeyWords.Clear;
end;

procedure TFCategoryMaster.btnCreateClick(Sender: TObject);
var
  vFilePath: string;
begin
  if (Length(lbledtName.Text) <> 0) and (Length(mmoKeyWords.Lines[0]) <> 0) then
  begin 
    vFilePath := ExtractFilePath(ParamStr(0)) + 'data\category\' +
      lbledtName.Text + '.txt';
    if FileExists(vFilePath) = True then
    begin
      if MessageBox(handle, PChar('Категорія уже створена.' + #13 + 'Додати?'),
        PChar('Помилка'), MB_ICONWARNING+MB_YESNO) = IDYES then
        CategoryCreate('append',vFilePath)
      else if MessageBox(handle, PChar('Категорія буде перезаписана.'),
        PChar('Попередження'), MB_ICONWARNING+MB_YESNO) = IDYES then
        CategoryCreate('rewrite',vFilePath);
    end
    else
      CategoryCreate('rewrite',vFilePath);
  end
  else
    MessageBox(handle, PChar('Заповність усі поля'),
      PChar('Помилка'), MB_ICONWARNING+MB_OK);
end;

end.
