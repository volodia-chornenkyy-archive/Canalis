object FSettings: TFSettings
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsToolWindow
  Caption = 'Canalis - Settings'
  ClientHeight = 263
  ClientWidth = 166
  Color = clBtnHighlight
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
    Top = 186
    Width = 166
    Height = 77
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 193
    ExplicitWidth = 193
    object btnRestore: TBitBtn
      Left = 5
      Top = 27
      Width = 68
      Height = 25
      Caption = #1042#1110#1076#1085#1086#1074#1080#1090#1080
      TabOrder = 0
      OnClick = btnRestoreClick
    end
    object btnPassChange: TBitBtn
      Left = 71
      Top = 27
      Width = 90
      Height = 25
      Caption = #1047#1084#1110#1085#1080#1090#1080' '#1087#1072#1088#1086#1083#1100
      TabOrder = 1
      OnClick = btnPassChangeClick
    end
    object btnIgnoreListShow: TBitBtn
      Left = 5
      Top = 3
      Width = 156
      Height = 25
      Caption = #1057#1087#1080#1089#1086#1082' '#1082#1072#1090#1077#1075#1086#1088#1110#1081
      TabOrder = 2
      OnClick = btnIgnoreListShowClick
    end
    object btnClose: TBitBtn
      Left = 5
      Top = 51
      Width = 156
      Height = 25
      Caption = #1047#1072#1082#1088#1080#1090#1080
      TabOrder = 3
      OnClick = btnCloseClick
    end
  end
  object chkFiltered: TCheckBox
    Left = 8
    Top = 142
    Width = 153
    Height = 17
    Caption = #1060#1110#1083#1100#1090#1088#1091#1074#1072#1090#1080' '#1076#1072#1085#1110
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = chkClick
  end
  object chkAutorun: TCheckBox
    Left = 8
    Top = 165
    Width = 97
    Height = 17
    Caption = #1040#1074#1090#1086#1079#1072#1087#1091#1089#1082
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = chkClick
  end
  object rgStatisticTime: TRadioGroup
    Left = 8
    Top = 8
    Width = 153
    Height = 105
    Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1091' '#1079#1072':'
    ItemIndex = 1
    Items.Strings = (
      #1044#1077#1085#1100
      #1058#1080#1078#1076#1077#1085#1100
      #1052#1110#1089#1103#1094#1100)
    TabOrder = 3
    OnClick = rgStatisticTimeClick
  end
  object chkGraph3d: TCheckBox
    Left = 8
    Top = 119
    Width = 97
    Height = 17
    Caption = #1054#1073#39#1108#1084#1085#1110' '#1076#1110#1072#1075#1088#1072#1084#1080
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = chkClick
  end
end
