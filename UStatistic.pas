unit UStatistic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ExtCtrls, System.DateUtils, Vcl.StdCtrls, System.IniFiles,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.Series, Vcl.Buttons, Vcl.DBGrids, Vcl.AppEvnts,
  VCLTee.DBChart, VCLTee.TeeDBCrossTab, VCLTee.BubbleCh, VCLTee.TeeFunci;

type
  TFStatistic = class(TForm)
    pnlBar: TPanel;
    dtpMain: TDateTimePicker;
    pgcMain: TPageControl;
    tsList: TTabSheet;
    tsGraphics: TTabSheet;
    chtMain: TChart;
    pmTable: TPopupMenu;
    pmiAddToSkipList: TMenuItem;
    dbgrdStatistic: TDBGrid;
    lblDate: TLabel;
    pnlLegend: TPanel;
    imgLegend1: TImage;
    imgLegend2: TImage;
    imgLegend3: TImage;
    imgLegend4: TImage;
    imgLegend5: TImage;
    lblLegend1: TLabel;
    lblLegend2: TLabel;
    lblLegend3: TLabel;
    lblLegend4: TLabel;
    lblLegend5: TLabel;
    cbbVisionChoice: TComboBox;
    lblVisionChoice: TLabel;
    brsrsFavouriteWebPages: TBarSeries;
    psrsUserTime: TPieSeries;
    brsrsLongestUsageApp: TBarSeries;
    btnSettings: TBitBtn;
    cbbUsers: TComboBox;
    lblUsers: TLabel;
    pmiAddToCategory: TMenuItem;
    pmiCategoryMaster: TMenuItem;
    pmiCategoryManual: TMenuItem;
    edtSearch: TEdit;
    procedure dtpMainChange(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pmiAddToSkipListClick(Sender: TObject);
    procedure BetweenQuery;
    procedure ShowFiveLongestUsageApp;
    procedure lblLegendMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cbbVisionChoiceChange(Sender: TObject);
    procedure ShowFiveFavouriteWebPages(browserName: string);
    procedure ShowUserTimeUsed;
    procedure StatisticStartup;
    procedure btnSettingsClick(Sender: TObject);
    procedure cbbUsersChange(Sender: TObject);
    procedure pmiCategoryManualClick(Sender: TObject);
    procedure pmiCategoryMasterClick(Sender: TObject);
    function CustomDateDecode(date: TDate; resultType:Byte):Word;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtSearchChange(Sender: TObject);
    procedure RemoveStringListDuplicates(const stringList : TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FStatistic: TFStatistic;
type
  TGraphData = record
    FTitle: string[255];
    FTime: integer;
  end;
var
  AData: array of TGraphData;
  boolChanges: Boolean = True;

implementation

uses UMain, USettings, UAddToCategory, UCategoryMaster;

{$R *.dfm}

procedure TFStatistic.btnSettingsClick(Sender: TObject);
begin
  FSettings.ShowModal;
end;

// Convert time variable to seconds.
function TimeToSecond(t: TDateTime):Integer;
var
  hh,mm,ss,sss: Word;
begin
  DecodeTime(t,hh,mm,ss,sss);
  Result := ss + (mm * 60) + (hh * 3600);
end;

function SecondToStr(ss: Integer): string;
var
  d,h,m,s:Integer;
begin
  Result := '';
  d := ss div 86400;
  h := (ss - d * 86400) div 3600;
  m := (ss - d * 86400 - h * 3600) div 60;
  s := ss - d * 86400 - h * 3600 - m * 60;
  Result := IntToStr(d)+'д'+IntToStr(h)+'год'+IntToStr(m)+'хв'+IntToStr(s)+'сек';
end;

// Convert seconds to time variable.
function SecondToTime(ss: Integer): TTime;
var
  hh, mm: integer;
begin
  hh := ss div 3600;
  mm := (ss - hh * 3600) div 60;
  ss := ss - hh * 3600 - mm * 60;
  Result := EncodeTime(hh,mm,ss,0);
end;

// Improved bubble sort.
procedure BoobleSort(min, max: Integer);
var
  i, n: Integer;
  vSort: Boolean;
  tmp: TGraphData;
begin
  vSort:=True;
  n:=0;
  while vSort do
  begin
    vSort:=False;
    for i:=min to max-1-n do
      if AData[i].FTime < AData[i+1].FTime then
      begin
        vSort:=True;
        tmp:=AData[i];
        AData[i]:=AData[i+1];
        AData[i+1]:=tmp;
      end;
    n:=n+1;
  end;
end;

function GetRandomColor: TColor;
begin
  Result := RGB(Random(255), Random(255), Random(255));
end;

// Fill legend captions.
procedure FillLegend(img: TImage; color: TColor; lbl:TLabel; title:string);
var
  vSpaceBarPos: Byte;
  vCategoryPos: Byte;
begin
  img.Canvas.Brush.Color := color;
  img.Canvas.FillRect(img.ClientRect);

  vCategoryPos := Pos(' - Google',title);
  if vCategoryPos <> 0 then
    Delete(title, vCategoryPos, Length(title));

  lbl.Hint := title;
  if Length(title) > 15 then
  begin
    Delete(title, 15, Length(title) - 16);
    lbl.Caption := title + '...';
  end
  else
    lbl.Caption := title;
end;

// Chart of 5 longest usage title/categorys.
procedure TFStatistic.ShowFiveLongestUsageApp;
var
  vGridLength: integer;
  i,j: integer;
  r: TGraphData;
  vLegendColor: TColor;
  vCategoryList: TStringList;
  sr: TSearchRec;
  vCategoryFile: TextFile;
  vTitle: string;
begin
  brsrsLongestUsageApp.Visible := True;
  brsrsFavouriteWebPages.Visible := False;
  psrsUserTime.Visible := False;
  chtMain.Title.Text.Clear;
  chtMain.Title.Text.Append('Найдовше використання програм');
  if FSettings.chkGraph3d.Checked then
  begin
    chtMain.View3D := True;
    chtMain.View3DOptions.Orthogonal := True;
  end
  else
    chtMain.View3D := False;

  SetLength(AData,0);
  FMain.qryStatistic.First;

  vGridLength := dbgrdStatistic.DataSource.DataSet.RecordCount-1;
  if vGridLength > 0 then
  begin
    // Find all *.txt-files in data\category\.
    vCategoryList := TStringList.Create;
    if FindFirst('data\category\*.txt', faAnyFile, sr) = 0 then
    begin
      repeat
        vCategoryList.Add(sr.Name);
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;

    SetLength(AData, vGridLength+1);
    // Change title to program-category.
    for i := 0 to vGridLength do
    begin
      AData[i].FTitle := FMain.qryStatistic.FieldByName('S_Title').AsString;
      if Pos('Google Chrome',AData[i].FTitle) <> 0 then
        AData[i].FTitle := 'Google Chrome'
      else if Pos('Mozilla Firefox',AData[i].FTitle) <> 0 then
        AData[i].FTitle := 'Mozilla Firefox'
      else if Pos('Opera',AData[i].FTitle) <> 0 then
        AData[i].FTitle := 'Opera'
      else if Pos('Internet Explorer',AData[i].FTitle) <> 0 then
        AData[i].FTitle := 'Internet Explorer'
      else
      // Change title to user-category.
        for j := 0 to vCategoryList.Count - 1 do
        begin
          AssignFile(vCategoryFile,
            ExtractFilePath(ParamStr(0)) + 'data\category\' + vCategoryList[j]);
          Reset(vCategoryFile);
          while not(Eof(vCategoryFile)) do
          begin
            Readln(vCategoryFile, vTitle);
            if vTitle = AData[i].FTitle then
              AData[i].FTitle := FMain.ExtractFileNameEX(vCategoryList[j]);
          end;
          CloseFile(vCategoryFile);
        end;

      AData[i].FTime := TimeToSecond(FMain.qryStatistic.FieldByName('S_Time').AsDateTime);
      FMain.qryStatistic.Next;
    end;

    vCategoryList.Free;

    // Sum same titles.
    for i := 0 to vGridLength-1 do
    for j := i+1 to vGridLength do
    begin
      if (AData[i].FTitle = AData[j].FTitle)
        and (AData[j].FTime <> 0) then
      begin
        AData[i].FTime := AData[i].FTime + AData[j].FTime;
        AData[j].FTime := 0;
      end;
    end;

    BoobleSort(0,vGridLength);

    // Create graph and legend.
    if vGridLength > 5 then
    begin
      SetLength(AData, 5);

      brsrsLongestUsageApp.Clear;
      j := Length(AData)-1;
      for i:=0 to j do
      begin
        vLegendColor := GetRandomColor();
        brsrsLongestUsageApp.AddBar(AData[i].FTime,
          (SecondToStr(AData[i].FTime) + #13+'(' +
            IntToStr(AData[i].FTime) +'cек)'),vLegendColor);
        case i of
          0: FillLegend(imgLegend1,vLegendColor,lblLegend1,AData[i].FTitle);
          1: FillLegend(imgLegend2,vLegendColor,lblLegend2,AData[i].FTitle);
          2: FillLegend(imgLegend3,vLegendColor,lblLegend3,AData[i].FTitle);
          3: FillLegend(imgLegend4,vLegendColor,lblLegend4,AData[i].FTitle);
          4: FillLegend(imgLegend5,vLegendColor,lblLegend5,AData[i].FTitle);
        end;
      end;
    end
    else
      MessageBox(handle, PChar('Не достатньо даних.'),
        PChar(''), MB_ICONWARNING+MB_OK);
  end
  else
    //no data
end;

// Chart of 5 longest usage web-title.
procedure TFStatistic.ShowFiveFavouriteWebPages(browserName: string);
var
  vGridLength: integer;
  i,j: integer;
  r: TGraphData;
  vLegendColor: TColor;
  vArrayLength: Integer;
begin
  brsrsLongestUsageApp.Visible := False;
  brsrsFavouriteWebPages.Visible := True;
  chtMain.Title.Text.Clear;
  chtMain.Title.Text.Append('Найбільш популярні вкладки ' +
    cbbVisionChoice.Items[cbbVisionChoice.ItemIndex]);
  psrsUserTime.Visible := False;
  if FSettings.chkGraph3d.Checked then
  begin
    chtMain.View3D := True;
    chtMain.View3DOptions.Orthogonal := True;
  end
  else
    chtMain.View3D := False;

  // Array with browser titles.
  vArrayLength := 0;
  SetLength(AData,vArrayLength);
  FMain.qryStatistic.First;
  vGridLength := dbgrdStatistic.DataSource.DataSet.RecordCount-1;
  for i := 0 to vGridLength do
  begin
    if Pos(browserName,FMain.qryStatistic.FieldByName('S_Title').AsString) <> 0 then
    begin
      Inc(vArrayLength);
      SetLength(AData, vArrayLength);
      AData[vArrayLength-1].FTitle := FMain.qryStatistic.FieldByName('S_Title').AsString;
      AData[vArrayLength-1].FTime := TimeToSecond(FMain.qryStatistic.FieldByName('S_Time').AsDateTime);
    end;
    FMain.qryStatistic.Next;
  end;

  // Sum same titles.
  Dec(vArrayLength);
  for i := 0 to vArrayLength-1 do
  for j := i+1 to vArrayLength do
  begin
    if (AData[i].FTitle = AData[j].FTitle)
      and (AData[j].FTime <> 0) then
    begin
      AData[i].FTime := AData[i].FTime + AData[j].FTime;
      AData[j].FTime := 0;
    end;
  end;

  BoobleSort(0,vArrayLength);

  // Create graph and legend.
  if vArrayLength > 5 then
  begin
    SetLength(AData, 5);

    brsrsFavouriteWebPages.Clear;
    j := Length(AData)-1;
    for i:=0 to j do
    begin
      vLegendColor := GetRandomColor();
      brsrsFavouriteWebPages.AddBar(AData[i].FTime,
        (SecondToStr(AData[i].FTime) + #13 + '(' +
          IntToStr(AData[i].FTime) +'cек)'),vLegendColor);
      case i of
        0: FillLegend(imgLegend1,vLegendColor,lblLegend1,AData[i].FTitle);
        1: FillLegend(imgLegend2,vLegendColor,lblLegend2,AData[i].FTitle);
        2: FillLegend(imgLegend3,vLegendColor,lblLegend3,AData[i].FTitle);
        3: FillLegend(imgLegend4,vLegendColor,lblLegend4,AData[i].FTitle);
        4: FillLegend(imgLegend5,vLegendColor,lblLegend5,AData[i].FTitle);
      end;
    end;
  end
    else
      MessageBox(handle, PChar('Не достатньо даних.'),
        PChar(''), MB_ICONWARNING+MB_OK);
end;

// Pie chart of user PC time usage.
procedure TFStatistic.ShowUserTimeUsed;
var
  vGridLength: integer;
  i,j: integer;
  r: TGraphData;
  vLegendColor: TColor;
begin
  brsrsLongestUsageApp.Visible := False;
  brsrsFavouriteWebPages.Visible := False;
  psrsUserTime.Visible := True;
  chtMain.Title.Text.Clear;
  chtMain.Title.Text.Append('Час використання комп''ютера користувачами');
  if FSettings.chkGraph3d.Checked then
  begin
    chtMain.View3D := True;
    chtMain.View3DOptions.Orthogonal := False;
  end
  else
    chtMain.View3D := False;

  SetLength(AData,0);
  FMain.qryStatistic.First;
  vGridLength := dbgrdStatistic.DataSource.DataSet.RecordCount-1;
  if vGridLength > 0 then
  begin
    SetLength(AData, vGridLength+1);
    for i := 0 to vGridLength do
    begin
      AData[i].FTitle := FMain.qryStatistic.FieldByName('S_UserName').AsString;
      AData[i].FTime := TimeToSecond(FMain.qryStatistic.FieldByName('S_Time').AsDateTime);
      FMain.qryStatistic.Next;
    end;

    for i := 0 to vGridLength-1 do
    for j := i+1 to vGridLength do
    begin
      if (AData[i].FTitle = AData[j].FTitle)
        and (AData[j].FTime <> 0) then
      begin
        AData[i].FTime := AData[i].FTime + AData[j].FTime;
        AData[j].FTime := 0;
      end;
    end;

    BoobleSort(0,vGridLength);

    if vGridLength > 5 then
    begin
      SetLength(AData, 5);

      psrsUserTime.Clear;
      vGridLength := Length(AData)-1;
      j := 0;
      for i:=0 to vGridLength do
      begin
        if AData[i].FTime <> 0 then
        begin
          vLegendColor := GetRandomColor();
          psrsUserTime.AddPie(AData[i].FTime,
          (SecondToStr(AData[i].FTime) + #13 + '(' +
            IntToStr(AData[i].FTime) +'cек)'),vLegendColor);
          case j of
            0: FillLegend(imgLegend1,vLegendColor,lblLegend1,AData[i].FTitle);
            1: FillLegend(imgLegend2,vLegendColor,lblLegend2,AData[i].FTitle);
            2: FillLegend(imgLegend3,vLegendColor,lblLegend3,AData[i].FTitle);
            3: FillLegend(imgLegend4,vLegendColor,lblLegend4,AData[i].FTitle);
            4: FillLegend(imgLegend5,vLegendColor,lblLegend5,AData[i].FTitle);
          end;
          Inc(j);
        end;
      end;
    end
    else
      MessageBox(handle, PChar('Не достатньо даних.'),
        PChar(''), MB_ICONWARNING+MB_OK);
  end;
end;

procedure TFStatistic.lblLegendMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Sender as TLabel).Parent = pnlLegend then
    (Sender as TLabel).ShowHint := True;
end;

// Load and create SQL-query ignore titles.
function IgnoreListToSql():string;
var
  i: integer;
  vListLength: Integer;
  vStringList: TStringList;
  vSqlQuery: string;
begin
  if FileExists(ExtractFilePath(ParamStr(0)) + 'data\Ignore.lst') then
  begin
    vStringList := TStringList.Create;
    vStringList.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'data\Ignore.lst');
    vListLength := vStringList.Count-1;
    for i:=0 to vListLength do
    begin
      Result := Result + ' AND (S_title NOT LIKE '''+vStringList[i]+''')';
    end;
    vStringList.Free;
  end;
end;

// Return year (0), month(1), day(2);
function TFStatistic.CustomDateDecode(date: TDate; resultType:Byte):Word;
var
  y,m,d:Word;
begin
  DecodeDate(date,y,m,d);
  case resultType of
    0: Result := y;
    1: Result := m;
    2: Result := d;
  end;
end;

procedure TFStatistic.BetweenQuery;
var
  vDate: TDate;
  i:Integer;
  vOldFormTitle: string;
begin
  boolChanges := True;
  vOldFormTitle := FStatistic.Caption;
  FStatistic.Caption := 'Обробка даних';
  FStatistic.Enabled := False;
  if FMain.qryStatistic.Active then
    FMain.qryStatistic.Active := False;
  FMain.qryStatistic.SQL.Clear;
  FMain.qryStatistic.SQL.Add('SELECT * FROM Statistic');
  FMain.qryStatistic.SQL.Add('WHERE (S_StartDate BETWEEN :SDate AND :FDate)');
  if FSettings.chkFiltered.Checked then
    FMain.qryStatistic.SQL.Add(IgnoreListToSql());
  if (FStatistic.cbbUsers.Items.Count <> 0)
    and (FStatistic.cbbVisionChoice.Items[FStatistic.cbbVisionChoice.ItemIndex] <> 'Користувачі') then
    FMain.qryStatistic.SQL.Add(' AND (S_UserName LIKE '''+
      Fstatistic.cbbUsers.Items[FStatistic.cbbUsers.ItemIndex]+''')');
  // User filter from edit.
  if Length(edtSearch.Text) <> 0 then
    FMain.qryStatistic.SQL.Add(' AND (S_Title LIKE ''%' + edtSearch.Text + '%'')');
  FMain.qryStatistic.SQL.Add('ORDER BY S_StartDate DESC');
  vDate := dtpMain.Date;
  // Start-End date filter.
  if FSettings.rgStatisticTime.ItemIndex = 0 then
  begin
    // Term - day.
    Fmain.qryStatistic.Parameters.ParamByName('SDate').Value := DateToStr(vDate);
    Fmain.qryStatistic.Parameters.ParamByName('FDate').Value :=
      DateToStr(IncDay(vDate,1));
  end
  else if FSettings.rgStatisticTime.ItemIndex = 1 then
  begin
    // Term - week.
    FMain.qryStatistic.Parameters.ParamByName('SDate').Value :=
      DateToStr(IncDay(vDate,(DayOfTheWeek(vDate)-1) * (-1)));
    Fmain.qryStatistic.Parameters.ParamByName('FDate').Value :=
      DateToStr(IncDay(vDate, (8-DayOfTheWeek(vDate))));
  end
  else if FSettings.rgStatisticTime.ItemIndex = 2 then
  begin
    // Term - month.
    FMain.qryStatistic.Parameters.ParamByName('SDate').Value :=
      DateToStr(EncodeDate(CustomDateDecode(vDate,0),
        CustomDateDecode(vDate,1),1));
    if CustomDateDecode(vDate,1) <> 12 then
      Fmain.qryStatistic.Parameters.ParamByName('FDate').Value :=
        DateToStr(EncodeDate(CustomDateDecode(vDate,0),
          CustomDateDecode(vDate,1)+1,1))
    else
      FMain.qryStatistic.Parameters.ParamByName('SDate').Value :=
        DateToStr(EncodeDate(CustomDateDecode(vDate,0)+1,1,1));
  end;
  FMain.qryStatistic.Prepared := True;
  FMain.qryStatistic.Active := True;

  if (dbgrdStatistic.DataSource.DataSet.RecordCount = 0)
    and (FSettings.Visible = False) then
    MessageBox(handle, PChar('Даних за вибраний проміжок немає'),
      PChar(''), MB_ICONWARNING+MB_OK);
  FMain.qryStatistic.First;
  FStatistic.Caption := vOldFormTitle;
  FStatistic.Enabled := True;
end;

procedure TFStatistic.RemoveStringListDuplicates(const stringList : TStringList);
var
  buffer: TStringList;
  cnt: Integer;
begin
  stringList.Sort;
  buffer := TStringList.Create;
  try
    buffer.Sorted := True;
    buffer.Duplicates := dupIgnore;
    buffer.BeginUpdate;
    for cnt := 0 to stringList.Count - 1 do
      buffer.Add(stringList[cnt]) ;
    buffer.EndUpdate;
    stringList.Assign(buffer) ;
  finally
    FreeandNil(buffer) ;
  end;
end;

procedure TFStatistic.StatisticStartup();
var
  vBrowserList:TStringList;
  vUserList:TStringList;
  vGridLength: integer;
  vAppTitle: string;
  vUserName: string;
  i,j:Integer;
begin
  FMain.qryStatistic.First;
  vGridLength := dbgrdStatistic.DataSource.DataSet.RecordCount-1;
  vBrowserList := TStringList.Create;
  vBrowserList.Duplicates:=dupIgnore;
  vUserList := TStringList.Create;
  vUserlist.Duplicates:=dupIgnore;

  for i:=0 to vGridLength do
  begin
    vAppTitle := FMain.qryStatistic.FieldByName('S_Title').AsString;
    if (Pos('Google Chrome',vAppTitle) <> 0) then
      vBrowserList.Add('Google Chrome');
    if (Pos('Mozilla Firefox',vAppTitle) <> 0) then
      vBrowserList.Add('Mozilla Firefox');
    if (Pos('Opera',vAppTitle) <> 0) then
      vBrowserList.Add('Opera');
    if (Pos('Internet Explorer',vAppTitle) <> 0) then
      vBrowserList.Add('Internet Explorer');

    vUserName := FMain.qryStatistic.FieldByName('S_UserName').AsString;
    vUserList.Add(vUserName);
    Fmain.qryStatistic.Next;
  end;

  RemoveStringListDuplicates(vUserList);
  for i:=0 to cbbUsers.Items.Count-1 do
  begin
    cbbUsers.ItemIndex:= 0;
    cbbUsers.DeleteSelected;
  end;
  if vUserList.Count <> 1 then
  begin
    j:=2;
    cbbVisionChoice.Items[1] := 'Користувачі';
    for i:=0 to vUserList.Count-1 do
      cbbUsers.Items.Add(vUserList[i]);
    cbbUsers.ItemIndex := 0;
    dbgrdStatistic.Columns[5].Visible := True;
  end
  else
  begin
    j:=1;
    dbgrdStatistic.Columns[5].Visible := False;
  end;

  RemoveStringListDuplicates(vBrowserList);
  for i:=cbbVisionChoice.Items.Count-1 downto j do
  begin
    cbbVisionChoice.ItemIndex := i;
    cbbVisionChoice.DeleteSelected;
  end;
  if vBrowserList.Count <> 0 then
  begin
    for i:=0 to vBrowserList.Count-1 do
    begin
      cbbVisionChoice.Items.Add('Браузер - ' + vBrowserList[i]);
    end;
  end;

  vBrowserList.Free;
  vUserList.Free;
end;

procedure TFStatistic.cbbVisionChoiceChange(Sender: TObject);
var
  vItemChoice:Byte;
  vOldFormTitle: string;
begin
  MessageBox(handle, PChar('Виконуються обробка даних.'+#13+
    'Зачекайте будь-ласка.'),PChar(''), MB_ICONWARNING+MB_OK);
  vOldFormTitle := FStatistic.Caption;
  FStatistic.Caption := 'Обробка даних';
  FStatistic.Enabled := False;
  vItemChoice := cbbVisionChoice.ItemIndex;
  if (cbbUsers.Items.Count <> 0)
    and (cbbVisionChoice.Items[vItemChoice] <> 'Користувачі') then
  begin
    cbbUsers.Visible := True;
    lblUsers.Visible := True;
  end
  else
  begin
    cbbUsers.Visible := False;
    lblUsers.Visible := False;
  end;
  case vItemChoice of
    0: ShowFiveLongestUsageApp;
    1:
      if cbbVisionChoice.Items[1] = 'Користувачі' then
        ShowUserTimeUsed
      else
        ShowFiveFavouriteWebPages(Copy(cbbVisionChoice.Items[1],
          Pos('- ',cbbVisionChoice.Items[1])+2,
            Length(cbbVisionChoice.Items[1])-Pos('- ',cbbVisionChoice.Items[1])+1));
    2: ShowFiveFavouriteWebPages(Copy(cbbVisionChoice.Items[2],
        Pos('- ',cbbVisionChoice.Items[2])+2,
          Length(cbbVisionChoice.Items[2])-Pos('- ',cbbVisionChoice.Items[2])+1));
    3: ShowFiveFavouriteWebPages(Copy(cbbVisionChoice.Items[3],
        Pos('- ',cbbVisionChoice.Items[3])+2,
          Length(cbbVisionChoice.Items[3])-Pos('- ',cbbVisionChoice.Items[3])+1));
    4: ShowFiveFavouriteWebPages(Copy(cbbVisionChoice.Items[4],
        Pos('- ',cbbVisionChoice.Items[4])+2,
          Length(cbbVisionChoice.Items[4])-Pos('- ',cbbVisionChoice.Items[4])+1));
    5: ShowFiveFavouriteWebPages(Copy(cbbVisionChoice.Items[5],
        Pos('- ',cbbVisionChoice.Items[5])+2,
          Length(cbbVisionChoice.Items[5])-Pos('- ',cbbVisionChoice.Items[5])+1));
  end;
  if Length(edtSearch.Text) <> 0 then
  begin
    chtMain.Title.Text.Clear;
    chtMain.Title.Text.Append('Найбільш популярні вкладки по запиту' +
      edtSearch.Text);
  end;
  cbbVisionChoice.ItemIndex := vItemChoice;
  FStatistic.Caption := vOldFormTitle;
  FStatistic.Enabled := True;
end;

procedure TFStatistic.cbbUsersChange(Sender: TObject);
begin
  cbbVisionChoice.ItemIndex := 0;
  cbbVisionChoiceChange(nil);
end;

procedure TFStatistic.dtpMainChange(Sender: TObject);
begin
  case pgcMain.TabIndex of
    0: BetweenQuery();
    1:
    begin
      cbbVisionChoice.ItemIndex := 0;
      cbbVisionChoiceChange(nil);
    end;
  end;
end;

procedure TFStatistic.edtSearchChange(Sender: TObject);
begin
  BetweenQuery;
end;

procedure TFStatistic.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WorkEnabled := True;
end;

procedure TFStatistic.FormShow(Sender: TObject);
begin
  dtpMain.Date := System.SysUtils.Date;
  if FileExists(ExtractFilePath(ParamStr(0))+'Settings.ini') then
    FSettings.GetIniSettings
  else
    FSettings.SetIniSettings;
  StatisticStartup();
  cbbVisionChoice.ItemIndex := 0;
  BetweenQuery();
end;

procedure TFStatistic.pmiAddToSkipListClick(Sender: TObject);
var
  vFileIgnoreList: TextFile;
begin
  AssignFile(vFileIgnoreList, ExtractFilePath(ParamStr(0)) + 'data\Ignore.lst');
  if FileExists(ExtractFilePath(ParamStr(0)) + 'data\Ignore.lst') then
    Append(vFileIgnoreList)
  else
  begin
    Rewrite(vFileIgnoreList);
    Writeln(vFileIgnoreList, '');
    Writeln(vFileIgnoreList, 'Program Manager');
  end;
  writeln(vFileIgnoreList, dbgrdStatistic.DataSource.DataSet.FieldByName('S_Title').AsString);
  CloseFile(vFileIgnoreList);
  if FSettings.chkFiltered.Checked then
    BetweenQuery;
end;

procedure TFStatistic.pmiCategoryManualClick(Sender: TObject);
begin
  FAddToCategory.ShowModal;
end;

procedure TFStatistic.pmiCategoryMasterClick(Sender: TObject);
begin
  FCategoryMaster.lbledtKeyWord.Text := FMain.qryStatistic.FieldByName('S_Title').AsString;
  FCategoryMaster.Show;
end;

procedure TFStatistic.pgcMainChange(Sender: TObject);
begin
  case pgcMain.TabIndex of
    0:
    begin
      cbbVisionChoice.Visible := False;
      lblVisionChoice.Visible := False;
      edtSearch.Visible := True;
    end;
    1:
    if dbgrdStatistic.DataSource.DataSet.RecordCount <> 0 then
    begin
      cbbVisionChoice.Visible := True;
      lblVisionChoice.Visible := True;
      edtSearch.Visible := False;
      if boolChanges then
      begin
        boolChanges := False;
        cbbVisionChoiceChange(nil);
      end;
    end;
  end;
end;

end.
