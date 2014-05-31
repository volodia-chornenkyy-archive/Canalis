program CANALIS;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FMain},
  USettings in 'USettings.pas' {FSettings},
  UStatistic in 'UStatistic.pas' {FStatistic},
  USecurity in 'USecurity.pas',
  UPassChange in 'UPassChange.pas' {FPassChange},
  UIgnoreList in 'UIgnoreList.pas' {FCategoryList},
  UPassCheck in 'UPassCheck.pas' {FPassCheck},
  UAddToCategory in 'UAddToCategory.pas' {FAddToCategory},
  UCategoryMaster in 'UCategoryMaster.pas' {FCategoryMaster},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := False;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFSettings, FSettings);
  Application.CreateForm(TFPassCheck, FPassCheck);
  Application.CreateForm(TFAddToCategory, FAddToCategory);
  Application.CreateForm(TFCategoryMaster, FCategoryMaster);
  Application.CreateForm(TFStatistic, FStatistic);
  Application.Run;
end.
