object FCategoryList: TFCategoryList
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1057#1087#1080#1089#1086#1082' '#1110#1075#1085#1086#1088#1086#1074#1072#1085#1080#1093' '#1079#1072#1075#1086#1083#1086#1074#1082#1110#1074
  ClientHeight = 356
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lstIgnoreList: TListBox
    Left = 0
    Top = 21
    Width = 361
    Height = 306
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object pnl: TPanel
    Left = 0
    Top = 327
    Width = 361
    Height = 29
    Align = alBottom
    TabOrder = 1
    object btnSave: TBitBtn
      Left = 1
      Top = 1
      Width = 112
      Height = 27
      Align = alLeft
      Caption = #1047#1073#1077#1088#1077#1075#1090#1080
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnDelete: TBitBtn
      Left = 113
      Top = 1
      Width = 135
      Height = 27
      Align = alClient
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080
      TabOrder = 1
      OnClick = btnDeleteClick
    end
    object btnClose: TBitBtn
      Left = 248
      Top = 1
      Width = 112
      Height = 27
      Align = alRight
      Caption = #1047#1072#1082#1088#1080#1090#1080
      TabOrder = 2
      OnClick = btnCloseClick
    end
  end
  object cbbCategory: TComboBox
    Left = 0
    Top = 0
    Width = 361
    Height = 21
    Align = alTop
    TabOrder = 2
    OnChange = cbbCategoryChange
  end
end