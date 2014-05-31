unit UCategoryMaster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.DateUtils;

type
  TFCategoryMaster = class(TForm)
    lbledtName: TLabeledEdit;
    lbledtKeyWord: TLabeledEdit;
    btnCreate: TBitBtn;
    procedure btnCreateClick(Sender: TObject);
    procedure CategoryCreate(operationWithFile: string; pathFile: string);
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
  vCategoryFile: TextFile;
  vDate: TDate;
  i: integer;
begin
  FMain.qryStatistic.Active := False;

  FMain.qryStatistic.SQL.Clear;
  FMain.qryStatistic.SQL.Add('SELECT * FROM Statistic');
  FMain.qryStatistic.SQL.Add('WHERE S_Title LIKE ''%' + lbledtKeyWord.Text + '%''');

  FMain.qryStatistic.Prepared := True;
  FMain.qryStatistic.Active := True;

  AssignFile(vCategoryFile, pathFile);
  if operationWithFile = 'rewrite' then
    Rewrite(vCategoryFile)
  else if operationWithFile = 'append' then
    Append(vCategoryFile);

  FMain.qryStatistic.First;
  for i:=0  to  FStatistic.dbgrdStatistic.DataSource.DataSet.RecordCount-1 do
  begin
    Writeln(vCategoryFile,
      FMain.qryStatistic.FieldByName('S_Title').AsString);
    FMain.qryStatistic.Next;
  end;

  CloseFile(vCategoryFile);

  FStatistic.BetweenQuery;

  FCategoryMaster.Close;
end;

procedure TFCategoryMaster.btnCreateClick(Sender: TObject);
var
  vFilePath: string;
begin
  if (Length(lbledtName.Text) <> 0) and (Length(lbledtKeyWord.Text) <> 0) then
  begin 
    vFilePath := 'data\category\' + lbledtName.Text + '.txt';
    if FileExists(vFilePath) = True then
    begin
      if MessageBox(handle, PChar('�������� ��� ��������.' + #13 + '������?'),
        PChar('�������'), MB_ICONWARNING+MB_YESNO) = IDYES then 
        CategoryCreate('append',vFilePath) 
      else if MessageBox(handle, PChar('�������� ���� ������������.'),
        PChar('������������'), MB_ICONWARNING+MB_YESNO) = IDYES then 
        CategoryCreate('rewrite',vFilePath);
    end
    else
      CategoryCreate('rewrite', vFilePath);
  end
  else
    MessageBox(handle, PChar('���������� �� ����'),
      PChar('�������'), MB_ICONWARNING+MB_OK);
end;

end.
