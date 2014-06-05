object FPassChange: TFPassChange
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  ClientHeight = 132
  ClientWidth = 153
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object edtOldPass: TEdit
    Left = 8
    Top = 16
    Width = 137
    Height = 21
    TabOrder = 0
    TextHint = #1057#1090#1072#1088#1080#1081' '#1087#1072#1088#1086#1083#1100
  end
  object edtNewPass: TEdit
    Left = 8
    Top = 43
    Width = 137
    Height = 21
    TabOrder = 1
    TextHint = #1053#1086#1074#1080#1081' '#1087#1072#1088#1086#1083#1100
  end
  object edtReEnterNewPass: TEdit
    Left = 8
    Top = 72
    Width = 137
    Height = 21
    TabOrder = 2
    TextHint = #1055#1086#1074#1090#1086#1088#1110#1090#1100' '#1085#1086#1074#1080#1081' '#1087#1072#1088#1086#1083#1100
  end
  object btnAccept: TBitBtn
    Left = 39
    Top = 99
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1081#1085#1103#1090#1080
    TabOrder = 3
    OnClick = btnAcceptClick
  end
end
