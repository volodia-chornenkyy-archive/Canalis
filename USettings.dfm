object FSettings: TFSettings
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Canalis - Settings'
  ClientHeight = 352
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlSettings: TPanel
    Left = 0
    Top = 290
    Width = 323
    Height = 62
    Align = alBottom
    TabOrder = 0
    object btnApply: TBitBtn
      Left = 8
      Top = 34
      Width = 65
      Height = 25
      Caption = #1047#1073#1077#1088#1077#1075#1090#1080
      TabOrder = 0
      OnClick = btnApplyClick
    end
    object btnRestore: TBitBtn
      Left = 79
      Top = 34
      Width = 66
      Height = 25
      Caption = #1042#1110#1076#1085#1086#1074#1080#1090#1080
      TabOrder = 1
      OnClick = btnRestoreClick
    end
    object btnPassChange: TBitBtn
      Left = 151
      Top = 34
      Width = 90
      Height = 25
      Caption = #1047#1084#1110#1085#1080#1090#1080' '#1087#1072#1088#1086#1083#1100
      TabOrder = 2
      OnClick = btnPassChangeClick
    end
    object btnIgnoreListShow: TBitBtn
      Left = 48
      Top = 3
      Width = 233
      Height = 25
      Caption = #1057#1087#1080#1089#1086#1082' '#1082#1072#1090#1077#1075#1086#1088#1110#1081
      TabOrder = 3
      OnClick = btnIgnoreListShowClick
    end
    object btnClose: TBitBtn
      Left = 247
      Top = 34
      Width = 75
      Height = 25
      Caption = #1047#1072#1082#1088#1080#1090#1080
      TabOrder = 4
      OnClick = btnCloseClick
    end
  end
  object chbBrowserHistory: TCheckBox
    Left = 71
    Top = 16
    Width = 182
    Height = 17
    Caption = #1055#1088#1080#1093#1086#1074#1091#1074#1072#1090#1080' '#1110#1089#1090#1086#1088#1110#1102' '#1073#1088#1072#1091#1079#1077#1088#1072
    TabOrder = 1
    OnClick = chbBrowserHistoryClick
  end
  object chklstBrowser: TCheckListBox
    Left = 71
    Top = 39
    Width = 105
    Height = 58
    Enabled = False
    ItemHeight = 13
    Items.Strings = (
      'Google Chrome'
      'Mozilla Firefox'
      'Opera'
      'Internet Explorer')
    TabOrder = 2
  end
  object chkFiltered: TCheckBox
    Left = 71
    Top = 237
    Width = 153
    Height = 17
    Caption = #1060#1110#1083#1100#1090#1088#1091#1074#1072#1090#1080' '#1076#1072#1085#1110
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = chkClick
  end
  object chkAutorun: TCheckBox
    Left = 71
    Top = 260
    Width = 97
    Height = 17
    Caption = #1040#1074#1090#1086#1079#1072#1087#1091#1089#1082
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = chkClick
  end
  object rgStatisticTime: TRadioGroup
    Left = 71
    Top = 103
    Width = 185
    Height = 105
    Caption = #1042#1088#1072#1093#1086#1074#1091#1074#1072#1090#1080' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1091' '#1079#1072':'
    ItemIndex = 1
    Items.Strings = (
      #1044#1077#1085#1100
      #1058#1080#1078#1076#1077#1085#1100
      #1052#1110#1089#1103#1094#1100
      #1056#1110#1082)
    TabOrder = 5
    OnClick = rgStatisticTimeClick
  end
  object chkGraph3d: TCheckBox
    Left = 71
    Top = 214
    Width = 97
    Height = 17
    Caption = #1054#1073#39#1108#1084#1085#1110' '#1076#1110#1072#1075#1088#1072#1084#1080
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = chkClick
  end
end