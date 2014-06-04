object FStatistic: TFStatistic
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'CANALIS - Statistic'
  ClientHeight = 465
  ClientWidth = 772
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBar: TPanel
    Left = 0
    Top = 419
    Width = 772
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    Color = clBtnHighlight
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 704
    DesignSize = (
      772
      46)
    object lblDate: TLabel
      Left = 4
      Top = 2
      Width = 26
      Height = 13
      Caption = #1044#1072#1090#1072
    end
    object lblVisionChoice: TLabel
      Left = 110
      Top = 2
      Width = 45
      Height = 13
      Caption = #1044#1110#1072#1075#1088#1072#1084#1072
      Visible = False
    end
    object lblUsers: TLabel
      Left = 252
      Top = 2
      Width = 60
      Height = 13
      Caption = #1050#1086#1088#1080#1089#1090#1091#1074#1072#1095
    end
    object dtpMain: TDateTimePicker
      Left = 4
      Top = 18
      Width = 100
      Height = 21
      Date = 41715.627116956020000000
      Time = 41715.627116956020000000
      TabOrder = 0
      OnChange = dtpMainChange
    end
    object cbbVisionChoice: TComboBox
      Left = 110
      Top = 18
      Width = 136
      Height = 21
      TabOrder = 1
      Text = #1047#1072#1075#1072#1083#1100#1085#1072
      Visible = False
      OnChange = cbbVisionChoiceChange
      Items.Strings = (
        #1047#1072#1075#1072#1083#1100#1085#1072)
    end
    object btnSettings: TBitBtn
      Left = 676
      Top = 16
      Width = 87
      Height = 25
      Anchors = [akTop]
      Caption = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103
      TabOrder = 2
      OnClick = btnSettingsClick
      ExplicitLeft = 613
    end
    object cbbUsers: TComboBox
      Left = 252
      Top = 18
      Width = 145
      Height = 21
      TabOrder = 3
      OnChange = cbbUsersChange
    end
    object edtSearch: TEdit
      Left = 110
      Top = 18
      Width = 136
      Height = 21
      TabOrder = 4
      TextHint = #1055#1086#1096#1091#1082
      OnChange = edtSearchChange
    end
  end
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 772
    Height = 419
    ActivePage = tsGraphics
    Align = alClient
    TabOrder = 1
    OnChange = pgcMainChange
    ExplicitWidth = 704
    object tsList: TTabSheet
      Caption = #1057#1087#1080#1089#1086#1082
      ExplicitWidth = 696
      object dbgrdStatistic: TDBGrid
        Left = 0
        Top = 0
        Width = 764
        Height = 391
        Align = alClient
        BorderStyle = bsNone
        DataSource = FMain.dsStatistic
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = pmTable
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'S_ID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'S_Title'
            Title.Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'S_Time'
            Title.Caption = #1063#1072#1089
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'S_StartDate'
            Title.Caption = #1044#1072#1090#1072' '#1079#1072#1087#1091#1089#1082#1091
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'S_StartTime'
            Title.Caption = #1063#1072#1089' '#1079#1072#1087#1091#1089#1082#1091
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'S_UserName'
            Title.Caption = #1050#1086#1088#1080#1089#1090#1091#1074#1072#1095
            Width = 100
            Visible = True
          end>
      end
    end
    object tsGraphics: TTabSheet
      Caption = #1043#1088#1072#1092#1110#1082#1080
      ImageIndex = 1
      ExplicitWidth = 696
      object chtMain: TChart
        Left = 0
        Top = 0
        Width = 764
        Height = 350
        AllowPanning = pmNone
        BackWall.Pen.Visible = False
        BottomWall.Brush.Gradient.EndColor = clSilver
        BottomWall.Brush.Gradient.StartColor = clGray
        BottomWall.Brush.Gradient.Visible = True
        BottomWall.Pen.Color = clGray
        BottomWall.Size = 4
        Gradient.Direction = gdFromTopLeft
        Gradient.EndColor = clWhite
        Gradient.StartColor = clSilver
        LeftWall.Brush.Gradient.EndColor = clSilver
        LeftWall.Brush.Gradient.StartColor = clGray
        LeftWall.Brush.Gradient.Visible = True
        LeftWall.Color = clWhite
        LeftWall.Pen.Color = clGray
        LeftWall.Size = 4
        Legend.DividingLines.Color = -520093696
        Legend.DividingLines.Visible = True
        Legend.GlobalTransparency = 82
        Legend.PositionUnits = muPercent
        Legend.TextStyle = ltsXAndText
        Legend.TopPos = 35
        Legend.Visible = False
        Title.Font.Color = clBlack
        Title.Font.Height = -21
        Title.Font.Style = [fsBold]
        Title.Font.Shadow.Color = clGray
        Title.Font.Shadow.HorizSize = 1
        Title.Font.Shadow.SmoothBlur = 2
        Title.Font.Shadow.VertSize = 1
        Title.Text.Strings = (
          #1053#1072#1081#1076#1086#1074#1096#1077' '#1074#1080#1082#1086#1088#1080#1089#1090#1072#1085#1085#1103' '#1087#1088#1086#1075#1088#1072#1084)
        BottomAxis.Grid.Color = 14540253
        BottomAxis.LabelsFormat.Font.Color = clGray
        BottomAxis.LabelsFormat.Font.Height = -9
        BottomAxis.LabelsFormat.TextAlignment = taCenter
        BottomAxis.LabelStyle = talValue
        Chart3DPercent = 56
        ClipPoints = False
        DepthAxis.LabelsFormat.TextAlignment = taCenter
        DepthTopAxis.LabelsFormat.TextAlignment = taCenter
        Frame.Visible = False
        LeftAxis.Grid.Color = 14540253
        LeftAxis.LabelsFormat.Font.Color = clGray
        LeftAxis.LabelsFormat.Font.Height = -9
        LeftAxis.LabelsFormat.TextAlignment = taCenter
        LeftAxis.LabelStyle = talValue
        LeftAxis.Title.Caption = #1057#1077#1082#1091#1085#1076#1080
        LeftAxis.Title.Visible = False
        RightAxis.LabelsFormat.TextAlignment = taCenter
        TopAxis.LabelsFormat.TextAlignment = taCenter
        View3DOptions.Elevation = 350
        View3DOptions.OrthoAngle = 30
        View3DOptions.Perspective = 55
        View3DOptions.Zoom = 90
        Zoom.Allow = False
        Zoom.Animated = True
        Zoom.Pen.Mode = pmNotXor
        Align = alClient
        BevelOuter = bvNone
        BevelWidth = 2
        Color = clWhite
        TabOrder = 0
        ExplicitWidth = 696
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 19
        object brsrsFavouriteWebPages: TBarSeries
          LegendTitle = '1'
          BarBrush.Gradient.Balance = 100
          BarBrush.Gradient.EndColor = 13408512
          BarBrush.Gradient.Visible = True
          BarPen.Color = clDefault
          BarPen.SmallSpace = 1
          ColorEachPoint = True
          Marks.Visible = True
          Marks.Arrow.SmallSpace = 1
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.SmallSpace = 1
          Marks.Callout.Arrow.Visible = False
          Marks.Callout.ArrowHead = ahLine
          ShowInLegend = False
          Title = 'brsrFavouriteWebPages'
          Gradient.Balance = 100
          Gradient.EndColor = 13408512
          Gradient.Visible = True
          MultiBar = mbNone
          Shadow.Transparency = 38
          TickLines.Color = -889192448
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
          Data = {
            0206000000000000000028744000FF00000000000000187A4000000020000000
            0000807640000000200000000000007E40000000200000000000A88140000000
            200000000000D07B4000000020}
        end
        object psrsUserTime: TPieSeries
          Marks.Visible = True
          Marks.Style = smsLabelPercent
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          Shadow.Visible = False
          Active = False
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          Gradient.Direction = gdDiagonalDown
          Gradient.EndColor = 4474111
          Gradient.StartColor = 3750388
          Gradient.Visible = True
          GradientBright = -11
          OtherSlice.Legend.Visible = False
          PieMarks.EmptySlice = True
          PiePen.SmallSpace = 1
        end
        object brsrsLongestUsageApp: TBarSeries
          LegendTitle = '1'
          Active = False
          BarBrush.Gradient.Balance = 100
          BarBrush.Gradient.EndColor = 13408512
          BarBrush.Gradient.Visible = True
          BarPen.Color = clDefault
          BarPen.SmallSpace = 1
          ColorEachPoint = True
          Marks.Visible = True
          Marks.Arrow.SmallSpace = 1
          Marks.Arrow.Visible = False
          Marks.Callout.Arrow.SmallSpace = 1
          Marks.Callout.Arrow.Visible = False
          Marks.Callout.ArrowHead = ahLine
          SeriesColor = 15054131
          ShowInLegend = False
          Title = 'brsrLongestUsageApp'
          Gradient.Balance = 100
          Gradient.EndColor = 13408512
          Gradient.Visible = True
          MultiBar = mbNone
          Shadow.Transparency = 38
          TickLines.Color = -889192448
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
          Data = {
            0206000000000000000028744000FF00000000000000187A4000000020000000
            0000807640000000200000000000007E40000000200000000000A88140000000
            200000000000D07B4000000020}
        end
      end
      object pnlLegend: TPanel
        Left = 0
        Top = 350
        Width = 764
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 696
        DesignSize = (
          764
          41)
        object imgLegend1: TImage
          Left = 11
          Top = 12
          Width = 15
          Height = 15
          Anchors = [akTop]
        end
        object imgLegend2: TImage
          Left = 147
          Top = 14
          Width = 15
          Height = 15
          Anchors = [akTop]
        end
        object imgLegend3: TImage
          Left = 305
          Top = 12
          Width = 15
          Height = 15
          Anchors = [akTop]
        end
        object imgLegend4: TImage
          Left = 460
          Top = 14
          Width = 15
          Height = 15
          Anchors = [akTop]
        end
        object imgLegend5: TImage
          Left = 615
          Top = 12
          Width = 15
          Height = 15
          Anchors = [akTop]
        end
        object lblLegend1: TLabel
          Left = 32
          Top = 14
          Width = 29
          Height = 13
          Anchors = [akTop]
          Caption = #1087#1091#1089#1090#1086
          OnMouseMove = lblLegendMouseMove
        end
        object lblLegend2: TLabel
          Left = 168
          Top = 14
          Width = 29
          Height = 13
          Anchors = [akTop]
          Caption = #1087#1091#1089#1090#1086
          OnMouseMove = lblLegendMouseMove
        end
        object lblLegend3: TLabel
          Left = 326
          Top = 14
          Width = 29
          Height = 13
          Anchors = [akTop]
          Caption = #1087#1091#1089#1090#1086
          OnMouseMove = lblLegendMouseMove
        end
        object lblLegend4: TLabel
          Left = 481
          Top = 14
          Width = 29
          Height = 13
          Anchors = [akTop]
          Caption = #1087#1091#1089#1090#1086
          OnMouseMove = lblLegendMouseMove
        end
        object lblLegend5: TLabel
          Left = 636
          Top = 14
          Width = 29
          Height = 13
          Anchors = [akTop]
          Caption = #1087#1091#1089#1090#1086
          OnMouseMove = lblLegendMouseMove
        end
      end
    end
  end
  object pmTable: TPopupMenu
    Alignment = paCenter
    Left = 8
    Top = 40
    object pmiAddToSkipList: TMenuItem
      Caption = #1044#1086#1076#1072#1090#1080' '#1074' '#1074#1080#1082#1083#1102#1095#1077#1085#1085#1103
      OnClick = pmiAddToSkipListClick
    end
    object pmiAddToCategory: TMenuItem
      Caption = #1044#1086#1076#1072#1090#1080' '#1074' '#1082#1072#1090#1077#1075#1086#1088#1110#1102
      object pmiCategoryMaster: TMenuItem
        Caption = #1052#1072#1081#1089#1090#1077#1088
        OnClick = pmiCategoryMasterClick
      end
      object pmiCategoryManual: TMenuItem
        Caption = #1042#1088#1091#1095#1085#1091
        OnClick = pmiCategoryManualClick
      end
    end
  end
end
