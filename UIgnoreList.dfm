object FCategoryList: TFCategoryList
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsToolWindow
  Caption = #1042#1084#1110#1089#1090' '#1082#1072#1090#1077#1075#1086#1088#1110#1081
  ClientHeight = 328
  ClientWidth = 252
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
  object lbl1: TLabel
    Left = 1
    Top = 3
    Width = 93
    Height = 13
    Caption = #1057#1090#1074#1086#1088#1077#1085#1110' '#1082#1072#1090#1077#1075#1086#1088#1110#1111
  end
  object lbl3: TLabel
    Left = 1
    Top = 45
    Width = 74
    Height = 13
    Caption = #1050#1083#1102#1095#1086#1074#1110' '#1089#1083#1086#1074#1072
  end
  object pnl: TPanel
    Left = 0
    Top = 299
    Width = 252
    Height = 29
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 296
    ExplicitWidth = 231
    object btnSave: TBitBtn
      Left = 1
      Top = 1
      Width = 73
      Height = 27
      Align = alLeft
      Caption = #1047#1073#1077#1088#1077#1075#1090#1080
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnClose: TBitBtn
      Left = 187
      Top = 1
      Width = 63
      Height = 27
      Align = alCustom
      Caption = #1047#1072#1082#1088#1080#1090#1080
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object btnDelete: TBitBtn
      Left = 75
      Top = 1
      Width = 112
      Height = 27
      Align = alCustom
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080' '#1082#1072#1090#1077#1075#1086#1088#1110#1102
      TabOrder = 2
      OnClick = btnDeleteClick
    end
  end
  object mmoContent: TMemo
    Left = 0
    Top = 59
    Width = 252
    Height = 240
    Align = alBottom
    TabOrder = 1
    OnKeyPress = mmoContentKeyPress
    ExplicitLeft = 1
    ExplicitTop = 88
    ExplicitWidth = 251
  end
  object cbbCategory: TComboBox
    Left = 0
    Top = 18
    Width = 252
    Height = 21
    Hint = #1047#1073#1077#1088#1077#1078#1110#1090#1100' '#1079#1084#1110#1085#1080
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
    OnChange = cbbCategoryChange
  end
end
