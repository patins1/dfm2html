object Tabs: TTabs
  Left = 207
  Top = 622
  Caption = 'Object Properties'
  ClientHeight = 138
  ClientWidth = 925
  Color = clRed
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  ScreenSnap = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TdhPanel
    Left = 0
    Top = 0
    Style.BorderTop.Width = 1
    Style.BorderTop.Color = White
    Style.BorderTop.Style = cbsSolid
    Style.BorderLeft.Width = 1
    Style.BorderLeft.Color = White
    Style.BorderLeft.Style = cbsNone
    Style.BorderRight.Width = 1
    Style.BorderRight.Color = Black
    Style.BorderRight.Style = cbsNone
    Style.PaddingTop = 1
    Style.BackgroundColor = ButtonFace
    AutoSizeXY = asNone
    Align = alClient
    Right = 0
    Bottom = 0
    ExplicitWidth = 100
    ExplicitHeight = 100
    object PageControl1: TMyPageControl
      Tag = 2
      Left = 0
      Top = 2
      Width = 925
      Height = 204
      ActivePage = AnchorName
      TabOrder = 0
      TabStop = False
      TabWidth = 43
      OnChange = PageControl1Change
      OnChanging = PageControl1Changing
      Color = clBtnFace
      ParentColor = False
      object AnchorFont: TTntTabSheet
        Hint = 'Font'
        Caption = 'Font'
        OnShow = AnchorFontShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox3: TMyGroupBox
          Left = 16
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Font'
          TabOrder = 0
          object cBold: TTntCheckBox
            Left = 112
            Top = 40
            Width = 81
            Height = 17
            Caption = 'Bold'
            TabOrder = 1
            OnClick = cBoldClick
          end
          object cItalic: TTntCheckBox
            Left = 112
            Top = 56
            Width = 81
            Height = 17
            Caption = 'Italic'
            TabOrder = 2
            OnClick = cBoldClick
          end
          object cOverline: TTntCheckBox
            Left = 8
            Top = 40
            Width = 97
            Height = 17
            Caption = 'Overline'
            TabOrder = 5
            OnClick = cBoldClick
          end
          object cLineThrough: TTntCheckBox
            Left = 8
            Top = 56
            Width = 97
            Height = 17
            Caption = 'Line-Through'
            TabOrder = 4
            OnClick = cBoldClick
          end
          object cUnderline: TTntCheckBox
            Left = 8
            Top = 72
            Width = 97
            Height = 17
            Caption = 'Underline'
            TabOrder = 3
            OnClick = cBoldClick
          end
          object IGNORE_Button1: TTntButton
            Left = 168
            Top = 56
            Width = 81
            Height = 25
            Caption = 'Choose font..'
            TabOrder = 0
            Visible = False
            OnClick = IGNORE_Button1Click
          end
          object cFontFamily: ThComboBox
            Left = 8
            Top = 16
            Width = 137
            Height = 21
            ItemHeight = 13
            TabOrder = 6
            ValueChange = cFontFamilyValueChange
            ChangeReason = 'Change Font Family'
          end
          object cFontSize: ThComboBox
            Left = 152
            Top = 16
            Width = 49
            Height = 21
            ItemHeight = 13
            TabOrder = 7
            Items.Strings = (
              '9'
              '10'
              '11'
              '12'
              '13'
              '14'
              '16'
              '18'
              '24'
              '36'
              '48')
            ValueChange = cFontSizeValueChange
            ChangeReason = 'Change Font Size'
          end
        end
        object GroupBox5: TMyGroupBox
          Left = 240
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Colors'
          TabOrder = 2
          object cpBackgroundColor: TdhColorPicker
            Left = 16
            Top = 51
            Width = 97
            Height = 21
            Caption = 'Background'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Margin = 5
            ParentFont = False
            PopupMenu = ColorPicker.PopupMenu1
            OnColorChanged = cTransparentClick
            Color = clRed
          end
          object cpFontColor: TdhColorPicker
            Left = 16
            Top = 19
            Width = 97
            Height = 21
            Caption = 'Font'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Margin = 5
            ParentFont = False
            PopupMenu = ColorPicker.PopupMenu1
            OnColorChanged = cpFontColorColorChanged
            Color = clRed
          end
          object cTransparent: TTntCheckBox
            Left = 120
            Top = 54
            Width = 81
            Height = 17
            Caption = 'Transparent'
            TabOrder = 0
            OnClick = cTransparentClick
          end
        end
        object IGNORE_SampleFont: TdhLabel
          Left = 456
          Top = 6
          Width = 209
          Height = 85
          Text = 'AaBbCc'
          Style.Border.Width = 1
          Style.Border.Style = cbsDotted
          Style.FontSize = '10'
          Style.TextAlign = ctaCenter
          Style.FontFamily = 'Arial Black'
          Style.LineHeight = '80'
          AutoSizeXY = asNone
          Constraints.MaxHeight = 96
        end
        object bClearFont: TTntButton
          Left = 696
          Top = 0
          Width = 51
          Height = 25
          Caption = 'Reset'
          TabOrder = 3
          OnClick = ClearFontClick
        end
      end
      object AnchorBorder: TTntTabSheet
        Hint = 'Edge'
        Caption = 'Edge'
        ImageIndex = 1
        OnShow = AnchorBorderShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object EdgeNavigation: TdhPanel
          Left = 8
          Top = 1
          Width = 209
          Height = 99
          Style.MarginRight = '10'
          AutoSizeXY = asNone
          object cEdgeRight: TdhLink
            Left = 77
            Top = 23
            Width = 22
            Height = 52
            Text = 'Right'
            Style.BorderBottom.Width = 0
            Style.PaddingTop = 4
            Style.MarginBottom = '1'
            Style.Effects.Rotation = 90
            Style.Effects.Enabled = True
            Style.Effects.AntiAliasing = False
            Style.Effects.Text = etInclude
            Style.Effects.Alpha = 120
            Style.BorderRadius.BottomRight = '0'
            Style.BorderRadius.BottomLeft = '0'
            Use = STYLE_Link2
            AutoSizeXY = asNone
            OnClick = cEdgeAllClick
            StyleDown.BorderBottom.Width = 1
            StyleDown.MarginBottom = '0'
            StyleDown.Effects.Rotation = 90
            StyleDown.Effects.Enabled = True
            StyleDown.Effects.AntiAliasing = False
            StyleDown.Effects.Text = etInclude
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object cEdgeBottom: TdhLink
            Left = 25
            Top = 75
            Width = 52
            Height = 23
            Text = 'Bottom'
            Style.BorderTop.Width = 0
            Style.PaddingTop = 1
            Style.MarginTop = '1'
            Style.TextAlign = ctaCenter
            Style.BorderRadius.TopLeft = '0'
            Style.BorderRadius.TopRight = '0'
            Use = STYLE_Link2
            AutoSizeXY = asNone
            OnClick = cEdgeAllClick
            StyleDown.BorderTop.Width = 1
            StyleDown.MarginTop = '0'
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object cEdgeTop: TdhLink
            Left = 25
            Top = 1
            Width = 52
            Height = 22
            Text = 'Top'
            Style.BorderBottom.Width = 0
            Style.PaddingTop = 3
            Style.MarginBottom = '1'
            Style.TextAlign = ctaCenter
            Style.BorderRadius.BottomRight = '0'
            Style.BorderRadius.BottomLeft = '0'
            Use = STYLE_Link2
            AutoSizeXY = asNone
            OnClick = cEdgeAllClick
            StyleDown.BorderBottom.Width = 1
            StyleDown.MarginBottom = '0'
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object cEdgeLeft: TdhLink
            Left = 3
            Top = 23
            Width = 22
            Height = 52
            Text = 'Left'
            Style.BorderBottom.Width = 0
            Style.PaddingTop = 4
            Style.MarginBottom = '1'
            Style.TextAlign = ctaCenter
            Style.Effects.Rotation = 270
            Style.Effects.Enabled = True
            Style.Effects.AntiAliasing = False
            Style.Effects.Text = etInclude
            Style.Effects.Alpha = 120
            Style.BorderRadius.BottomRight = '0'
            Style.BorderRadius.BottomLeft = '0'
            Use = STYLE_Link2
            AutoSizeXY = asNone
            OnClick = cEdgeAllClick
            StyleDown.BorderBottom.Width = 1
            StyleDown.MarginBottom = '0'
            StyleDown.Effects.Rotation = 270
            StyleDown.Effects.Enabled = True
            StyleDown.Effects.AntiAliasing = False
            StyleDown.Effects.Text = etInclude
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object cEdgeAll: TdhLink
            Left = 24
            Top = 22
            Width = 54
            Height = 54
            Text = 'All'
            Style.PaddingTop = 19
            Style.ZIndex = -1
            Style.BorderRadius.All = '3'
            Use = STYLE_Link2
            AutoSizeXY = asNone
            OnClick = cEdgeAllClick
            StyleDown.BorderRadius.All = '4'
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object dhPanel3: TdhPanel
            Left = 107
            Top = 0
            Width = 96
            Height = 96
            Style.BackgroundImage.Data = {
              07544269746D617036030000424D360300000000000036000000280000001000
              0000100000000100180000000000000300000000000000000000000000000000
              0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0}
            AutoSizeXY = asNone
            object SampleBorder: TdhPanel
              Left = 0
              Top = 0
              Style.BackgroundImage.Data = {
                0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
                00000108060000001F15C4890000000D4944415478DA63FCCFC0E00000044601
                412A00AB6B0000000049454E44AE426082}
              Style.Effects.Alpha = 30
              AutoSizeXY = asNone
              Align = alClient
              Right = 0
              Bottom = 0
              object dhPanel5: TdhPanel
                Left = 0
                Top = 0
                Style.BackgroundImage.Data = {
                  0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
                  00000108060000001F15C4890000000D4944415478DA636460F8DF0000028801
                  81EE5C951E0000000049454E44AE426082}
                AutoSizeXY = asNone
                Align = alClient
                Right = 0
                Bottom = 0
              end
            end
          end
        end
        object GroupBox6: TMyGroupBox
          Left = 256
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Margin / Padding'
          TabOrder = 0
          object slMargin: TMyTrackBar
            Left = 104
            Top = 23
            Width = 100
            Height = 26
            Max = 20
            PageSize = 1
            TabOrder = 0
          end
          object slPadding: TMyTrackBar
            Left = 104
            Top = 55
            Width = 100
            Height = 26
            Max = 20
            PageSize = 1
            TabOrder = 1
          end
          object spPadding: TMySpinEdit
            Left = 56
            Top = 56
            Width = 48
            Height = 22
            MaxValue = 3000
            MinValue = 0
            TabOrder = 2
            Value = 0
            Alignment = taRightJustify
            ValueChange = spPaddingValueChange
            TrackBar = slPadding
            ChangeReason = 'Change Padding'
          end
          object spMargin: TMySpinEdit
            Left = 56
            Top = 24
            Width = 48
            Height = 22
            MaxValue = 3000
            MinValue = 0
            TabOrder = 3
            Value = 0
            Alignment = taRightJustify
            ValueChange = spMarginValueChange
            TrackBar = slMargin
            ChangeReason = 'Change Margin'
          end
          object dhLabel2: TdhLabel
            Left = 8
            Top = 32
            Width = 35
            Height = 13
            Text = 'Margin:'
            AutoSizeXY = asXY
            ParentShowHint = False
            ShowHint = False
          end
          object dhLabel6: TdhLabel
            Left = 8
            Top = 64
            Width = 42
            Height = 13
            Text = 'Padding:'
            AutoSizeXY = asXY
          end
        end
        object GroupBox7: TMyGroupBox
          Left = 456
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Border'
          TabOrder = 1
          object cpBorderColor: TdhColorPicker
            Left = 168
            Top = 24
            Width = 27
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Margin = 5
            ParentFont = False
            PopupMenu = ColorPicker.PopupMenu1
            OnColorChanged = cpBorderColorColorChanged
            Color = clRed
          end
          object slBorder: TMyTrackBar
            Left = 104
            Top = 53
            Width = 100
            Height = 28
            Max = 20
            PageSize = 1
            TabOrder = 0
          end
          object dhLabel3: TdhLabel
            Left = 8
            Top = 64
            Width = 31
            Height = 13
            Text = 'Width:'
            AutoSizeXY = asXY
          end
          object spBorder: TMySpinEdit
            Left = 56
            Top = 56
            Width = 48
            Height = 22
            MaxValue = 3000
            MinValue = 0
            TabOrder = 2
            Value = 0
            Alignment = taRightJustify
            ValueChange = spBorderValueChange
            TrackBar = slBorder
            ChangeReason = 'Border Width'
          end
          object dhComboBox1: ThComboBox
            Left = 8
            Top = 24
            Width = 153
            Height = 21
            Style = csDropDownList
            DropDownCount = 10
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 3
            Items.Strings = (
              'none'
              'hidden'
              'dotted'
              'dashed'
              'solid'
              'double'
              'groove'
              'ridge'
              'inset'
              'outset')
            ValueChange = dhComboBox1ValueChange
            ChangeReason = 'Border Style'
          end
        end
        object bClearEdge: TTntButton
          Left = 672
          Top = 0
          Width = 51
          Height = 25
          Caption = 'Reset'
          TabOrder = 2
          OnClick = bClearEdgeClick
        end
        object bBorderRadius: TTntButton
          Left = 672
          Top = 32
          Width = 120
          Height = 25
          Caption = 'Edit Border Radius'
          TabOrder = 4
          OnClick = bBorderRadiusClick
        end
        object dhStyleSheet2: TdhStyleSheet
          Left = 232
          Top = 6
          Width = 28
          Height = 28
          Expanded = False
          VertPosition = 25
          ExpandedWidth = 129
          ExpandedHeight = 100
          Expanded = False
          object STYLE_Link2: TdhLink
            Left = 0
            Top = 25
            Height = 24
            Text = 'STYLE_Link2'
            ImageType = bitTile
            Style.Border.Color = 5197647
            Style.Border.Style = cbsSolid
            Style.Margin = '0'
            Style.BackgroundColor = 9868950
            Style.TextAlign = ctaCenter
            Style.Effects.Enabled = True
            Style.Effects.AntiAliasing = False
            Style.Effects.Text = etInclude
            Style.Effects.Alpha = 100
            Style.BorderRadius.All = '100 100'
            AutoSizeXY = asNone
            Align = alTop
            Right = 2147483647
            StyleDown.Effects.Enabled = True
            StyleDown.Effects.AntiAliasing = False
            StyleDown.Effects.Text = etInclude
            Layout = ltText
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object STYLE_dhLabel10: TdhLabel
            Left = 0
            Top = 12
            Height = 13
            Text = 'Label10'
            Style.FontSize = '3'
            AutoSizeXY = asY
            Align = alTop
            Right = 2147483647
          end
          object STYLE_Link14: TdhLink
            Left = 0
            Top = -7
            Height = 19
            Text = 'STYLE_Link14'
            Style.Border.Width = 1
            Style.Border.Color = White
            Style.Border.Style = cbsSolid
            Style.BorderBottom.Color = ThreeDDarkShadow
            Style.BorderRight.Color = ThreeDDarkShadow
            Style.PaddingLeft = 2
            Style.PaddingTop = 1
            Style.PaddingRight = 2
            Style.PaddingBottom = 2
            Style.FontSize = '11'
            Style.BackgroundColor = 13160660
            Style.TextAlign = ctaCenter
            Style.FontFamily = 'Arial'
            Style.BorderRadius.All = '115'
            AutoSizeXY = asXY
            Align = alTop
            Right = 2147483647
            StyleDown.BorderTop.Color = ThreeDDarkShadow
            StyleDown.BorderBottom.Color = White
            StyleDown.BorderLeft.Color = ThreeDDarkShadow
            StyleDown.BorderRight.Color = White
            StyleDown.PaddingLeft = 3
            StyleDown.PaddingTop = 2
            StyleDown.PaddingRight = 1
            StyleDown.PaddingBottom = 1
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object STYLE_Label28: TdhLabel
            Left = 0
            Top = 49
            Height = 23
            Text = 'STYLE_Label28'
            Style.PaddingTop = 10
            Style.Display = cdsBlock
            AutoSizeXY = asY
            Align = alTop
            Right = 2147483647
          end
          object STYLE_dhLink2: TdhLink
            Left = 0
            Top = -25
            Height = 18
            Text = 'Link1'
            Style.Border.Color = ThreeDShadow
            Style.Border.Style = cbsSolid
            Style.BackgroundImage.Data = {
              0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
              00000108060000001F15C4890000000D4944415478DA63ECEAEA720000052401
              E087171FB10000000049454E44AE426082}
            Style.PaddingLeft = 2
            Style.PaddingTop = 1
            Style.PaddingRight = 2
            Style.PaddingBottom = 1
            Style.FontSize = '11'
            Style.MarginBottom = '1'
            Style.TextAlign = ctaCenter
            Style.BorderRadius.All = '5'
            AutoSizeXY = asXY
            Align = alTop
            Right = 2147483647
            StyleDown.Border.Color = ThreeDShadow
            StyleDown.Border.Style = cbsSolid
            StyleDown.BackgroundImage.Data = {
              0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
              00000108060000001F15C4890000000D4944415478DA63FCFF9F810100070302
              0020B8DC270000000049454E44AE426082}
            StyleDown.PaddingLeft = 3
            StyleDown.PaddingRight = 1
            StyleDown.BackgroundColor = Transparent
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
      object AnchorBackground: TTntTabSheet
        Hint = 'Image'
        Caption = 'Image'
        ImageIndex = 2
        OnShow = AnchorBackgroundShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox9: TMyGroupBox
          Left = 8
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Image'
          TabOrder = 1
          object Button11: TTntButton
            Left = 8
            Top = 16
            Width = 113
            Height = 20
            Caption = 'File..'
            TabOrder = 0
            OnClick = dhAnchor3Click
          end
          object Button12: TTntButton
            Left = 8
            Top = 40
            Width = 113
            Height = 20
            Caption = 'From gradient..'
            TabOrder = 1
            OnClick = dhAnchor4Click
          end
          object Button17: TTntButton
            Left = 8
            Top = 64
            Width = 113
            Height = 20
            Caption = 'From color..'
            TabOrder = 2
            OnClick = Button17Click
          end
          object dhPanel1: TdhPanel
            Left = 128
            Top = 12
            Width = 73
            Height = 73
            ImageType = bitStretch
            Style.Border.Width = 1
            Style.Border.Color = Gray
            Style.Border.Style = cbsDotted
            AutoSizeXY = asNone
            OnMouseUp = dhPanel1MouseUp
          end
        end
        object GroupBox23: TMyGroupBox
          Left = 224
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Type'
          TabOrder = 3
          object ComboBox1: ThComboBox
            Left = 16
            Top = 21
            Width = 105
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              'Tile'
              'Stretch'
              'Image'
              'Split')
            ValueChange = ComboBox1ValueChange
            ChangeReason = 'Change Image Type'
          end
          object cBGFixed: ThCheckBox
            Left = 16
            Top = 59
            Width = 173
            Height = 15
            Caption = 'Never scroll image'
            TabOrder = 1
            ValueChange = cBGFixedValueChange
            ChangeReason = 'Change Image Type'
          end
        end
        object GroupBox8: TMyGroupBox
          Left = 440
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Tile'
          TabOrder = 0
          DesignSize = (
            209
            91)
          object Label17: TdhLabel
            Top = 18
            Width = 52
            Height = 13
            Text = 'In direction'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 143
          end
          object dhLabel8: TdhLabel
            Left = 8
            Top = 48
            Width = 10
            Height = 13
            Text = 'X:'
            AutoSizeXY = asY
          end
          object slBGX: TMyTrackBar
            Left = 64
            Top = 38
            Width = 97
            Height = 24
            Max = 100
            TabOrder = 2
          end
          object IGNORE_dhComboBoxX: ThComboBox
            Left = 160
            Top = 40
            Width = 41
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ItemIndex = 1
            ParentFont = False
            TabOrder = 3
            Text = '%'
            Items.Strings = (
              'px'
              '%')
            ValueChange = spBGXValueChange
            ChangeReason = 'Image Position'
          end
          object slBGY: TMyTrackBar
            Left = 64
            Top = 62
            Width = 97
            Height = 24
            Max = 100
            TabOrder = 5
          end
          object spBGY: TMySpinEdit
            Left = 24
            Top = 64
            Width = 41
            Height = 22
            MaxValue = 3000
            MinValue = -3000
            TabOrder = 6
            Value = 0
            Alignment = taRightJustify
            ValueChange = spBGXValueChange
            TrackBar = slBGY
            ChangeReason = 'Image Position'
          end
          object dhLabel9: TdhLabel
            Left = 8
            Top = 72
            Width = 10
            Height = 13
            Text = 'Y:'
            AutoSizeXY = asY
          end
          object dhComboBox4: ThComboBox
            Left = 72
            Top = 14
            Width = 129
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 8
            Items.Strings = (
              'X and Y'
              'Only X'
              'Only Y'
              'None')
            ValueChange = dhComboBox4ValueChange
            ChangeReason = 'Change Tile Directions'
          end
          object spBGX: TMySpinEdit
            Left = 24
            Top = 40
            Width = 41
            Height = 22
            MaxValue = 3000
            MinValue = -3000
            TabOrder = 1
            Value = 0
            Alignment = taRightJustify
            ValueChange = spBGXValueChange
            TrackBar = slBGX
            ChangeReason = 'Image Position'
          end
          object IGNORE_dhComboBoxY: ThComboBox
            Left = 160
            Top = 64
            Width = 41
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ItemIndex = 1
            ParentFont = False
            TabOrder = 4
            Text = '%'
            Items.Strings = (
              'px'
              '%')
            ValueChange = spBGXValueChange
            ChangeReason = 'Image Position'
          end
        end
        object bClearImage: TTntButton
          Left = 696
          Top = 0
          Width = 51
          Height = 25
          Caption = 'Reset'
          TabOrder = 2
          OnClick = bClearBackgroundClick
        end
      end
      object AnchorEffects: TTntTabSheet
        Hint = 'Effect'
        Caption = 'Effect'
        ImageIndex = 4
        OnShow = AnchorEffectsShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object cEffectsEnabled: TTntCheckBox
          Left = 8
          Top = 8
          Width = 65
          Height = 17
          Caption = 'Enabled'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = cEffectsEnabledClick
        end
        object pcnav_vert: TdhPanel
          Left = 86
          Top = 0
          Width = 98
          Height = 104
          Style.ZIndex = 111
          AutoSizeXY = asNone
          object EffectsMain: TdhLink
            Left = 0
            Top = 0
            Width = 92
            Height = 18
            Text = 'Text'
            OnStateTransition = EffectsMainStateTransition
            Use = STYLE_dhLink7
            AutoSizeXY = asNone
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfURL]
            LinkPage = TabSheet3
          end
          object EffectsBlur: TdhLink
            Left = 0
            Top = 18
            Width = 92
            Height = 18
            Text = 'Blur'
            OnStateTransition = EffectsMainStateTransition
            Use = STYLE_dhLink7
            AutoSizeXY = asNone
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfURL]
            LinkPage = TabSheet8
          end
          object EffectsTransformations: TdhLink
            Left = 0
            Top = 36
            Width = 92
            Height = 18
            Text = 'Transform'
            OnStateTransition = EffectsMainStateTransition
            Use = STYLE_dhLink7
            AutoSizeXY = asNone
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfURL]
            LinkPage = TabSheet7
          end
          object EffectsTransformations_Border: TdhLabel
            Left = 91
            Top = 34
            Width = 1
            Height = 19
            Style.BorderTop.Width = 0
            Style.BorderBottom.Width = 0
            Style.BorderRight.Width = 0
            Style.BorderRadius.All = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asX
          end
          object dhLabel12: TdhLabel
            Left = 91
            Top = 52
            Width = 6
            Height = 48
            Style.BorderTop.Width = 0
            Style.BorderRight.Width = 0
            Style.BorderRadius.TopLeft = '0'
            Style.BorderRadius.BottomRight = '0'
            Style.BorderRadius.TopRight = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
          object EffectsBlur_Border: TdhLabel
            Left = 91
            Top = 16
            Width = 1
            Height = 21
            Style.BorderTop.Width = 0
            Style.BorderBottom.Width = 0
            Style.BorderLeft.Style = cbsSolid
            Style.BorderRight.Width = 0
            Style.BorderRadius.All = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
          object EffectsMain_Border: TdhLabel
            Left = 91
            Top = 0
            Width = 6
            Height = 19
            Style.BorderBottom.Width = 0
            Style.BorderRight.Width = 0
            Style.BorderRadius.BottomRight = '0'
            Style.BorderRadius.BottomLeft = '0'
            Style.BorderRadius.TopRight = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
          object EffectsMain_top: TdhLabel
            Left = 92
            Top = 0
            Width = 5
            Height = 19
            Style.BorderBottom.Width = 0
            Style.BorderLeft.Width = 0
            Style.BorderRight.Width = 0
            Style.BorderRadius.All = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
          object dhLabel13: TdhLabel
            Left = 92
            Top = 19
            Width = 5
            Height = 33
            Style.Border.Width = 0
            Style.BorderRadius.All = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
        end
        object pcnav_horz: TdhPanel
          Left = 128
          Top = 94
          Width = 241
          Height = 24
          Style.ZIndex = 111
          AutoSizeXY = asNone
          object EffectsMain2: TdhLink
            Left = 0
            Top = 0
            Width = 41
            Height = 19
            Text = 'Text'
            OnStateTransition = EffectsMainStateTransition
            Use = STYLE_Link1
            AutoSizeXY = asNone
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfURL]
            LinkPage = TabSheet3
          end
          object EffectsBlur2: TdhLink
            Left = 40
            Top = 0
            Width = 75
            Height = 19
            Text = 'Blur'
            OnStateTransition = EffectsMainStateTransition
            Use = STYLE_Link1
            AutoSizeXY = asNone
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfURL]
            LinkPage = TabSheet8
          end
          object EffectsTransformations2: TdhLink
            Left = 114
            Top = 0
            Width = 96
            Height = 19
            Text = 'Transform'
            OnStateTransition = EffectsMainStateTransition
            Use = STYLE_Link1
            AutoSizeXY = asNone
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfURL]
            LinkPage = TabSheet7
          end
          object EffectsBlur2_Border: TdhLabel
            Left = 41
            Top = 17
            Width = 73
            Height = 1
            Style.BorderBottom.Width = 0
            Style.BorderLeft.Width = 0
            Style.BorderRight.Width = 0
            Style.BorderRadius.All = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asY
          end
          object EffectsTransformations2_Border: TdhLabel
            Left = 115
            Top = 17
            Width = 95
            Height = 6
            Style.BorderBottom.Width = 0
            Style.BorderLeft.Width = 0
            Style.BorderRadius.TopLeft = '0'
            Style.BorderRadius.BottomRight = '0'
            Style.BorderRadius.BottomLeft = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
          object EffectsMain2_Border: TdhLabel
            Left = 0
            Top = 17
            Width = 41
            Height = 6
            Style.BorderBottom.Width = 0
            Style.BorderRight.Width = 0
            Style.BorderRadius.BottomRight = '0'
            Style.BorderRadius.BottomLeft = '0'
            Style.BorderRadius.TopRight = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
          object EffectsMain2_top: TdhLabel
            Left = 0
            Top = 18
            Width = 41
            Height = 5
            Style.BorderTop.Width = 0
            Style.BorderBottom.Width = 0
            Style.BorderRight.Width = 0
            Style.BorderRadius.All = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
          object dhLabel17: TdhLabel
            Left = 45
            Top = 18
            Width = 164
            Height = 5
            Style.Border.Width = 0
            Style.BorderRadius.All = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
          object EffectsTransformations2_top: TdhLabel
            Left = 112
            Top = 18
            Width = 98
            Height = 5
            Style.BorderTop.Width = 0
            Style.BorderBottom.Width = 0
            Style.BorderLeft.Width = 0
            Style.BorderRadius.All = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asNone
          end
        end
        object panelpc2: TdhPanel
          Left = 208
          Top = 0
          Width = 497
          Height = 100
          Use = STYLE_Label33
          AutoSizeXY = asNone
          object PageControl2: TdhPageControl
            Left = 261
            Top = 19
            Width = 24
            Height = 24
            ActivePage = TabSheet7
            FixedHeight = True
            object TabSheet3: TdhPage
              Left = 1
              Top = 1
              AutoSizeXY = asNone
              Align = alClient
              Right = 2147483647
              Bottom = 2147483647
              UseIFrame = False
              object cAntiAliasing: TTntCheckBox
                Left = 16
                Top = 8
                Width = 185
                Height = 17
                Caption = 'Anti-Aliasing'
                Checked = True
                Color = clBtnFace
                ParentColor = False
                State = cbChecked
                TabOrder = 0
                OnClick = cRenderClick
              end
              object cTextOnly: TTntCheckBox
                Left = 16
                Top = 32
                Width = 193
                Height = 17
                Caption = 'Apply effects only to text'
                Color = clBtnFace
                ParentColor = False
                TabOrder = 1
                OnClick = cTextOnlyClick
              end
              object cExcludeText: TTntCheckBox
                Left = 16
                Top = 56
                Width = 193
                Height = 17
                Caption = 'Do not apply effects to text'
                Color = clBtnFace
                ParentColor = False
                TabOrder = 2
                OnClick = cExcludeTextClick
              end
            end
            object TabSheet8: TdhPage
              Left = 1
              Top = 1
              AutoSizeXY = asNone
              Align = alClient
              Right = 2147483647
              Bottom = 2147483647
              UseIFrame = False
              ExplicitWidth = 100
              ExplicitHeight = 100
              object dhPanel4: TdhPanel
                Left = 3
                Top = 4
                Width = 126
                Height = 94
                Style.MarginRight = '20'
                AutoSizeXY = asNone
                object dhLink9: TdhLink
                  Left = 0
                  Top = 0
                  Height = 18
                  Text = 'Outer shadow'
                  Use = STYLE_dhLink2
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 20
                  OnClick = dhLink9Click
                  Layout = ltText
                  PreferDownStyles = False
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  Down = True
                end
                object dhLink12: TdhLink
                  Left = 0
                  Top = 18
                  Height = 18
                  Text = 'Inner shadow'
                  Use = STYLE_dhLink2
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 20
                  OnClick = dhLink9Click
                  Layout = ltText
                  PreferDownStyles = False
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                end
                object dhLink11: TdhLink
                  Left = 0
                  Top = 36
                  Height = 18
                  Text = 'Outer glow'
                  Use = STYLE_dhLink2
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 20
                  OnClick = dhLink9Click
                  Layout = ltText
                  PreferDownStyles = False
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                end
                object dhLink10: TdhLink
                  Left = 0
                  Top = 54
                  Height = 18
                  Text = 'Inner glow'
                  Use = STYLE_dhLink2
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 20
                  OnClick = dhLink9Click
                  Layout = ltText
                  PreferDownStyles = False
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                end
                object dhLink13: TdhLink
                  Left = 0
                  Top = 72
                  Height = 18
                  Text = 'Blur'
                  Use = STYLE_dhLink2
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 20
                  OnClick = dhLink9Click
                  Layout = ltText
                  PreferDownStyles = False
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                end
              end
              object Panel5: TMyPanel
                Left = 306
                Top = 2
                Width = 196
                Height = 94
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  196
                  94)
                object lOpacity: TdhLabel
                  Top = 10
                  Width = 36
                  Height = 13
                  Text = 'Opacity'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 149
                end
                object lFlood: TdhLabel
                  Top = 33
                  Width = 42
                  Height = 13
                  Text = 'Overflow'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 149
                end
                object lDistance: TdhLabel
                  Top = 56
                  Width = 42
                  Height = 13
                  Text = 'Distance'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 149
                end
                object lDegree: TdhLabel
                  Top = 79
                  Width = 35
                  Height = 13
                  Text = 'Degree'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 149
                end
                object spBlurAlpha: TMySpinEdit
                  Left = 51
                  Top = 2
                  Width = 42
                  Height = 22
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slBlurAlpha
                  ChangeReason = 'Blur effects'
                end
                object spBlurFlood: TMySpinEdit
                  Left = 51
                  Top = 25
                  Width = 42
                  Height = 22
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slBlurFlood
                  ChangeReason = 'Blur effects'
                end
                object spBlurDistance: TMySpinEdit
                  Left = 51
                  Top = 48
                  Width = 42
                  Height = 22
                  MaxValue = 2147483647
                  MinValue = 0
                  TabOrder = 2
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slBlurDistance
                  ChangeReason = 'Blur effects'
                end
                object spBlurDegree: TMySpinEdit
                  Left = 51
                  Top = 71
                  Width = 42
                  Height = 22
                  MaxValue = 360
                  MinValue = 0
                  TabOrder = 3
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slBlurDegree
                  ChangeReason = 'Blur effects'
                end
                object slBlurFlood: TMyTrackBar
                  Left = 93
                  Top = 24
                  Width = 98
                  Height = 22
                  Max = 100
                  TabOrder = 4
                end
                object slBlurDistance: TMyTrackBar
                  Left = 93
                  Top = 47
                  Width = 98
                  Height = 22
                  Max = 20
                  TabOrder = 5
                end
                object slBlurDegree: TMyTrackBar
                  Left = 93
                  Top = 70
                  Width = 98
                  Height = 22
                  Max = 360
                  TabOrder = 6
                end
                object slBlurAlpha: TMyTrackBar
                  Left = 93
                  Top = 1
                  Width = 98
                  Height = 22
                  Max = 100
                  TabOrder = 7
                end
              end
              object Panel6: TMyPanel
                Left = 117
                Top = 8
                Width = 188
                Height = 89
                BevelOuter = bvNone
                TabOrder = 2
                DesignSize = (
                  188
                  89)
                object cpBlurColor: TdhColorPicker
                  Left = 10
                  Top = 34
                  Width = 82
                  Height = 21
                  Caption = 'Color'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  Margin = 5
                  ParentFont = False
                  PopupMenu = ColorPicker.PopupMenu1
                  OnColorChanged = cRenderClick
                  Color = clRed
                end
                object Label11: TdhLabel
                  Top = 76
                  Width = 33
                  Height = 13
                  Text = 'Radius'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 141
                end
                object spBlurRadius: TMySpinEdit
                  Left = 51
                  Top = 67
                  Width = 42
                  Height = 22
                  MaxValue = 250
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slBlurRadius
                  ChangeReason = 'Blur effects'
                end
                object slBlurRadius: TMyTrackBar
                  Left = 93
                  Top = 67
                  Width = 98
                  Height = 22
                  Max = 20
                  TabOrder = 1
                end
                object cBlurEnabled: TTntCheckBox
                  Left = 9
                  Top = 9
                  Width = 65
                  Height = 17
                  Caption = 'Enabled'
                  Color = clBtnFace
                  ParentColor = False
                  TabOrder = 2
                  OnClick = cRenderClick
                end
              end
            end
            object TabSheet7: TdhPage
              Left = 0
              Top = 0
              AutoSizeXY = asNone
              Align = alClient
              Right = 0
              Bottom = 0
              UseIFrame = False
              object Panel3: TMyPanel
                Left = 256
                Top = 2
                Width = 209
                Height = 95
                BevelOuter = bvNone
                TabOrder = 1
                DesignSize = (
                  209
                  95)
                object Label7: TdhLabel
                  Top = 10
                  Width = 31
                  Height = 13
                  Text = 'Shift X'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 150
                end
                object Label8: TdhLabel
                  Top = 33
                  Width = 31
                  Height = 13
                  Text = 'Shift Y'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 150
                end
                object Label6: TdhLabel
                  Top = 56
                  Width = 40
                  Height = 13
                  Text = 'Rotation'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 150
                end
                object Label5: TdhLabel
                  Top = 79
                  Width = 36
                  Height = 13
                  Text = 'Opacity'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 150
                end
                object slShiftX: TMyTrackBar
                  Left = 111
                  Top = 2
                  Width = 98
                  Height = 22
                  Max = 50
                  Min = -50
                  TabOrder = 0
                end
                object spShiftX: TMySpinEdit
                  Left = 64
                  Top = 2
                  Width = 47
                  Height = 22
                  MaxValue = 5000
                  MinValue = -5000
                  TabOrder = 1
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slShiftX
                  ChangeReason = 'Transformations'
                end
                object spShiftY: TMySpinEdit
                  Left = 64
                  Top = 25
                  Width = 47
                  Height = 22
                  MaxValue = 5000
                  MinValue = -5000
                  TabOrder = 2
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slShiftY
                  ChangeReason = 'Transformations'
                end
                object slShiftY: TMyTrackBar
                  Left = 111
                  Top = 25
                  Width = 98
                  Height = 22
                  Max = 50
                  Min = -50
                  TabOrder = 3
                end
                object slAngle: TMyTrackBar
                  Left = 111
                  Top = 48
                  Width = 98
                  Height = 22
                  Max = 359
                  PageSize = 45
                  TabOrder = 4
                end
                object spAngle: TMySpinEdit
                  Left = 64
                  Top = 48
                  Width = 47
                  Height = 22
                  MaxValue = 5000
                  MinValue = -5000
                  TabOrder = 5
                  Value = 0
                  OnChange = spAngleChange
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slAngle
                  ChangeReason = 'Transformations'
                end
                object slMasterAlpha: TMyTrackBar
                  Left = 111
                  Top = 71
                  Width = 98
                  Height = 22
                  Max = 100
                  PageSize = 25
                  TabOrder = 6
                end
                object spMasterAlpha: TMySpinEdit
                  Left = 64
                  Top = 71
                  Width = 47
                  Height = 22
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 7
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slMasterAlpha
                  ChangeReason = 'Transformations'
                end
              end
              object Panel31: TMyPanel
                Left = 26
                Top = 2
                Width = 207
                Height = 93
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  207
                  93)
                object Label9: TdhLabel
                  Top = 10
                  Width = 37
                  Height = 13
                  Text = 'Skew X'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 149
                end
                object Label10: TdhLabel
                  Top = 33
                  Width = 37
                  Height = 13
                  Text = 'Skew Y'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 149
                end
                object Label3: TdhLabel
                  Top = 56
                  Width = 37
                  Height = 13
                  Text = 'Scale X'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 149
                end
                object Label4: TdhLabel
                  Top = 79
                  Width = 37
                  Height = 13
                  Text = 'Scale Y'
                  AutoSizeXY = asXY
                  Anchors = [akTop, akRight]
                  Right = 149
                end
                object slSkewX: TMyTrackBar
                  Left = 111
                  Top = 2
                  Width = 98
                  Height = 22
                  Max = 200
                  Min = -200
                  PageSize = 50
                  TabOrder = 0
                end
                object spSkewX: TMySpinEdit
                  Left = 64
                  Top = 2
                  Width = 47
                  Height = 22
                  MaxValue = 10000
                  MinValue = -10000
                  TabOrder = 1
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slSkewX
                  ChangeReason = 'Transformations'
                end
                object spSkewY: TMySpinEdit
                  Left = 64
                  Top = 25
                  Width = 47
                  Height = 22
                  MaxValue = 10000
                  MinValue = -10000
                  TabOrder = 2
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slSkewY
                  ChangeReason = 'Transformations'
                end
                object slSkewY: TMyTrackBar
                  Left = 111
                  Top = 25
                  Width = 98
                  Height = 22
                  Max = 200
                  Min = -200
                  PageSize = 50
                  TabOrder = 3
                end
                object slScaleX: TMyTrackBar
                  Left = 111
                  Top = 48
                  Width = 98
                  Height = 22
                  Max = 200
                  PageSize = 50
                  TabOrder = 4
                end
                object spScaleX: TMySpinEdit
                  Left = 64
                  Top = 48
                  Width = 47
                  Height = 22
                  MaxValue = 10000
                  MinValue = -10000
                  TabOrder = 5
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slScaleX
                  ChangeReason = 'Transformations'
                end
                object spScaleY: TMySpinEdit
                  Left = 64
                  Top = 71
                  Width = 47
                  Height = 22
                  MaxValue = 10000
                  MinValue = -10000
                  TabOrder = 6
                  Value = 0
                  Alignment = taRightJustify
                  ValueChange = spSkewXValueChange
                  TrackBar = slScaleY
                  ChangeReason = 'Transformations'
                end
                object slScaleY: TMyTrackBar
                  Left = 111
                  Top = 71
                  Width = 98
                  Height = 22
                  Max = 200
                  PageSize = 50
                  TabOrder = 7
                end
              end
            end
          end
        end
        object dhStyleSheet1: TdhStyleSheet
          Left = 0
          Top = -2
          Width = 28
          Height = 28
          Expanded = False
          VertPosition = 1
          ExpandedWidth = 92
          ExpandedHeight = 107
          Expanded = False
          object STYLE_Label14: TdhLabel
            Left = 0
            Top = -1
            Height = 15
            Text = 'STYLE_Label14'
            Style.Border.Width = 1
            Style.Border.Color = White
            Style.Border.Style = cbsSolid
            Style.BorderBottom.Color = 7237230
            Style.BorderRight.Color = 7237230
            Style.ZIndex = -1
            AutoSizeXY = asY
            Align = alTop
            Right = 2147483647
          end
          object STYLE_Link1: TdhLink
            Left = 0
            Top = 32
            Height = 17
            Text = 'STYLE_horz'
            ImageType = bitSplit
            Style.BorderBottom.Style = cbsNone
            Style.BorderRadius.BottomRight = '0'
            Style.BorderRadius.BottomLeft = '0'
            Use = STYLE_dhLink2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2147483647
            StyleDown.BorderBottom.Style = cbsNone
            StyleDown.ZIndex = 10
            StyleDown.BorderRadius.BottomRight = '0'
            StyleDown.BorderRadius.BottomLeft = '0'
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfURL]
          end
          object STYLE_dhLink7: TdhLink
            Left = 0
            Top = 14
            Height = 18
            Text = 'STYLE_vert'
            ImageType = bitSplit
            Style.BorderRight.Style = cbsNone
            Style.TextAlign = ctaCenter
            Style.BorderRadius.BottomRight = '0'
            Style.BorderRadius.TopRight = '0'
            Use = STYLE_dhLink2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2147483647
            StyleDown.BorderRight.Style = cbsNone
            StyleDown.ZIndex = 10
            StyleDown.BorderRadius.BottomRight = '0'
            StyleDown.BorderRadius.TopRight = '0'
            Layout = ltText
            PreferDownStyles = False
            Options = [loDownIfMenu, loDownIfURL]
          end
          object STYLE_Label33: TdhLabel
            Left = 0
            Top = 49
            Height = 15
            Text = 'STYLE_Label33'
            Style.BorderRadius.TopLeft = '0'
            Use = STYLE_dhLabel11
            AutoSizeXY = asY
            Align = alTop
            Right = 2147483647
          end
          object STYLE_dhLabel11: TdhLabel
            Left = 0
            Top = 64
            Height = 15
            Text = 'STYLE_dhLabel11'
            Style.Border.Width = 1
            Style.Border.Color = Red
            Style.Border.Style = cbsSolid
            Style.BorderRadius.All = '5'
            AutoSizeXY = asY
            Align = alTop
            Right = 2147483647
          end
        end
        object IGNORE_dhDirectHTML1: TdhDirectHTML
          Left = 248
          Top = 104
          Width = 20
          Height = 19
          AutoSizeXY = asXY
          InnerHTML = 
            '/*'#13#10'------------------------------------------------------------' +
            '-------------'#13#10'DFM2HTML v1.9 JavaScript Library'#13#10#13#10'Copyright 200' +
            '3-2007 J'#246'rg Kiegeland. All rights reserved.'#13#10#13#10'This javascript l' +
            'ibrary is generated by the DFM2HTML tool.'#13#10'You may adapt this sc' +
            'ript for your Web pages, provided these opening credit'#13#10'lines (d' +
            'own to the lower dividing line) are kept intact.'#13#10'You may not re' +
            'print or redistribute this code without permission.'#13#10#13#10'Visit htt' +
            'p://www.dfm2html.com'#13#10'------------------------------------------' +
            '-------------------------------  '#13#10'*/'#13#10#13#10'var LinkTimer; //used f' +
            'or delayed menu popup'#13#10'var ToOpen; //menuitem for which to open ' +
            'submenu next'#13#10'var glSelCompo; //element over which mouse is over' +
            #13#10'var TailSubMenu; //deepest opened submenu'#13#10'var glEventObj; //m' +
            'anage event bubbling'#13#10'var IE=navigator.appName=="Microsoft Inter' +
            'net Explorer";'#13#10#13#10'function UpdateImm(Self) {'#13#10#9'var oldvis=Self.s' +
            'tyle.visibility; //IE doesnt update immediately, force update'#13#10#9 +
            'Self.style.visibility="hidden";'#13#10#9'Self.style.visibility=oldvis;'#13 +
            #10'}'#13#10#13#10'function OpenMenu() {'#13#10#9'var Self=ToOpen;'#13#10#9'ToOpen=null;'#13#10#9 +
            'if (Self.style.display!="none") return;'#13#10#9'TailSubMenu=Self;'#13#10#9'if' +
            ' (!Self.IsInline) {'#13#10#9#9'var ox=Number(Self.getAttribute("menuleft' +
            '"));;'#13#10#9#9'var oy=Number(Self.getAttribute("menutop"));'#13#10#9#9'for (va' +
            'r p=Self.FParentMenuItem; p && p!=Self.offsetParent; p=p.offsetP' +
            'arent) {'#13#10#9#9#9'oy+=p.offsetTop;'#13#10#9#9#9'ox+=p.offsetLeft;'#13#10#9#9'}'#13#10#9#9'Self' +
            '.style.top=oy+"px";'#13#10#9#9'Self.style.left=ox+"px";'#13#10#9#9'Self.style.po' +
            'sition="absolute";'#13#10#9'}'#13#10#9'if (Self.filters) {'#13#10#9#9'if (Self.filters' +
            '.blendTrans) Self.filters.blendTrans.Apply();'#13#10#9#9'if (Self.filter' +
            's.revealTrans) Self.filters.revealTrans.Apply();'#13#10#9'}'#13#10#9'Self.styl' +
            'e.display = "";'#13#10#9'setTimeout("if (TailSubMenu) UpdateImm(TailSub' +
            'Menu);",1);'#13#10#9'if (Self.filters) {'#13#10#9#9'if (Self.filters.blendTrans' +
            ') Self.filters.blendTrans.Play();'#13#10#9#9'if (Self.filters.revealTran' +
            's) Self.filters.revealTrans.Play();'#13#10#9'}'#13#10#9'Self.FParentMenuItem.p' +
            'arentNode.FOpenMenuItem=Self.FParentMenuItem;'#13#10#9'CheckDesignState' +
            '(Self.FParentMenuItem);'#13#10'}'#13#10#13#10'function glCheckClose(CloseItem) {' +
            #13#10#9'var p=TailSubMenu;'#13#10#9'while (p) {'#13#10#9#9'TailSubMenu=p;'#13#10#9#9'if (Vir' +
            'Parent(TailSubMenu,ToOpen)) break;'#13#10#9#9'if (!ToOpen && VirParent(T' +
            'ailSubMenu,glSelCompo) && !(CloseItem && VirParent(CloseItem,Tai' +
            'lSubMenu))) break;'#13#10#9#9'p.style.display = "none";'#13#10#9#9'TailSubMenu=n' +
            'ull;'#13#10#9#9'p.FParentMenuItem.parentNode.FOpenMenuItem=null;'#13#10#9#9'Chec' +
            'kDesignState(p.FParentMenuItem);'#13#10#9#9'p=p.FParentMenuItem.parentNo' +
            'de;'#13#10#9#9'for (p; p && !p.FParentMenuItem ; p=p.parentNode);'#13#10#9'}'#13#10#9 +
            'if (ToOpen) OpenMenu();'#13#10'}'#13#10#13#10'function UpdateOver(Self,IsOver,Cl' +
            'icked) {'#13#10'if (!(glEventObj && RealParent(Self,glEventObj))) {'#13#10#9 +
            'var _glSelCompo=glSelCompo;'#13#10#9'glSelCompo=null;'#13#10#9'if (IsOver) glS' +
            'elCompo=Self;'#13#10#9'if (Self.FSubMenu && Self.FSubMenu.getAttribute(' +
            '"clicktoopen")) {'#13#10#9#9'if (Self.FSubMenu && Self.FSubMenu.style.di' +
            'splay!="none") {'#13#10#9#9#9'if (Clicked) glCheckClose(Self);'#13#10#9#9'} else'#13 +
            #10#9#9'if (Clicked && !Self.FSubMenu.getAttribute("onlybyurl") || Is' +
            'Over && Self.FSubMenu && Self.FSubMenu.getAttribute("resumeopen"' +
            ') && Self.parentNode.FOpenMenuItem) {'#13#10#9#9#9'ToOpen=Self.FSubMenu;'#13 +
            #10#9#9#9'glCheckClose();'#13#10#9#9'}'#13#10#9'} else {'#13#10#9#9'Self.IsDown=Clicked;'#13#10#9#9'i' +
            'f (IsOver) ToOpen=Self.FSubMenu;'#13#10#9#9'if (Clicked) glCheckClose();' +
            ' else'#13#10#9#9'if (IsOver && glSelCompo.FSubMenu)'#13#10#9#9'if (Self.FSubMenu' +
            '.getAttribute("resumeopen") && Self.parentNode.FOpenMenuItem) {g' +
            'lCheckClose();} else  {'#13#10#9#9#9'clearTimeout(LinkTimer);'#13#10#9#9#9'LinkTim' +
            'er=setTimeout("glCheckClose();",glSelCompo.FSubMenu.FReactionTim' +
            'e);'#13#10#9#9'}'#13#10#9'}'#13#10#9'if (_glSelCompo==glSelCompo) _glSelCompo=null;'#13#10#9 +
            'if (_glSelCompo) CheckDesignState(_glSelCompo);'#13#10#13#10#9'if (Self.par' +
            'entNode.FOpenMenuItem) CheckDesignState(Self.parentNode.FOpenMen' +
            'uItem);'#13#10#9'CheckDesignState(Self);'#13#10'}'#13#10'glEventObj=Self;'#13#10'}'#13#10#13#10'fun' +
            'ction CheckDesignState(Self) {'#13#10#9'var base=Self.getAttribute("cba' +
            'se");'#13#10'    if (base==null || base=="") return;'#13#10#9'var s=base+"_nm' +
            '";'#13#10#9'IsDown=(Self.getAttribute("down") ||'#13#10#9#9'Self.FPC && Self.FP' +
            'C.FURLAnchor==Self && !Self.getAttribute("notifurl") || '#13#10#9#9'Self' +
            '.getAttribute("ifover") && Self==glSelCompo ||'#13#10#9#9'!Self.FSubMenu' +
            ' && Self.IsDown && !Self.getAttribute("notifmouse") || '#13#10#9#9'Self.' +
            'FSubMenu && Self.FSubMenu.style.display!="none" && !Self.getAttr' +
            'ibute("notifmenu"));'#9#9#13#10#9'if (Self==glSelCompo && !(IsDown && Sel' +
            'f.getAttribute("noover"))) {'#13#10#9#9' if (IsDown) '#13#10#9#9' '#9#9's+=" "+base+' +
            '"_dn"+" "+base+"_ov"+" "+base+"_od"+" dn ov od"; else'#13#10#9#9#9#9's+=" ' +
            '"+base+"_ov"+" ov";'#13#10#9'} else'#13#10#9'if (IsDown) s+=" "+base+"_dn"+" d' +
            'n";'#13#10#9'if (s==Self.className) return;'#13#10#9'var blend= Self.filters &' +
            '& s!=base+"_nm" && Self.childNodes.length<=1;'#13#10#9'if (blend) {'#13#10#9#9 +
            'if (Self.filters.blendTrans) Self.filters.blendTrans.Apply();'#13#10#9 +
            #9'if (Self.filters.revealTrans) Self.filters.revealTrans.Apply();' +
            #13#10#9'}'#13#10#9'Self.className=s;'#13#10#9'if (blend) {'#13#10#9#9'if (Self.filters.blen' +
            'dTrans) Self.filters.blendTrans.Play();'#13#10#9#9'if (Self.filters.reve' +
            'alTrans) Self.filters.revealTrans.Play();'#13#10#9'} '#13#10#9'adjPos(Self);'#13#10 +
            '}'#13#10#13#10'function GotoSlide(n) {'#13#10#9'n.style.display="block";'#13#10#9'var ac' +
            't=n.parentNode.act;'#13#10#9'if (act && act!=n) {'#13#10#9#9'n.offsetHeight;act' +
            '.offsetHeight;//for KHTML'#13#10#9#9'var diff=n.offsetHeight-act.offsetH' +
            'eight;'#13#10#9#9'act.style.display="none";'#13#10#9#9'var h;'#13#10#9#9'for (var p=n.of' +
            'fsetParent; p && p.style && !(p.style.top && p.style.bottom) && ' +
            '!(p.style.overflow=="scroll" || p.style.overflow=="auto"); p=p.o' +
            'ffsetParent)'#13#10#9#9'{h=p.style.height.replace(/px/,""); if (isNaN(h)' +
            ' || !h) break; p.style.height=Number(h)+diff+"px";}'#13#10#9'}'#13#10#9'n.pare' +
            'ntNode.act=n;'#13#10'}'#13#10#13#10'function MouseOutEvent() {'#13#10#9'UpdateOver(this' +
            ',false,false);'#13#10'}'#13#10#13#10'function MouseOverEvent() {'#13#10#9'if (glSelComp' +
            'o!=this) UpdateOver(this,true,false);'#13#10'}'#13#10#13#10'function MouseDownEv' +
            'ent() {'#13#10#9'if (IE && (this.style.overflow=="scroll" || this.style' +
            '.overflow=="auto")){'#13#10#9#9'var t=document.body.createTextRange();'#13#10 +
            #9#9't.moveToElementText(this);'#13#10#9#9'var d=document.selection.createR' +
            'ange();'#13#10#9#9'if (d.parentElement().tagName!="INPUT" && d.parentEle' +
            'ment().tagName!="TEXTAREA" && d.compareEndPoints("StartToStart",' +
            't)==-1) document.selection.empty();'#13#10#9'}'#13#10#9'UpdateOver(this,true,t' +
            'rue);'#13#10#9'return true;'#13#10'}'#13#10#13#10#13#10'function ChildPos(c) {'#13#10#9'for (var i' +
            '=0; i<=c.parentNode.childNodes.length-1; i++) if (c.parentNode.c' +
            'hildNodes[i]==c) return i;'#13#10'} '#13#10#13#10'function VirParent(p,c) {'#13#10#9'fo' +
            'r (c; c ; c=(c.FParentMenuItem?c.FParentMenuItem:c.parentNode)) ' +
            'if (p==c) return true;'#13#10#9'return false;'#13#10'} '#13#10'function RealParent(' +
            'p,c) {'#13#10#9'for (c=c.parentNode; c ; c=c.parentNode) if (p==c) retu' +
            'rn true;'#13#10#9'return false;'#13#10'} '#13#10#13#10'function MouseUpEvent() {'#13#10#9'if (' +
            'this.FLinkPage) GotoSlide(this.FLinkPage);'#13#10#9'Linked(this);'#13#10#9'Upd' +
            'ateOver(this,true,false);'#13#10'}'#13#10#13#10'function adjChildPos(p) {'#13#10#9'for ' +
            '(var c=p.firstChild; c!=null; c=c.nextSibling) adjPos(c);'#13#10'}'#13#10#13#10 +
            'function adjFullChildPos(p) {'#13#10#9'adjPos(p);'#13#10#9'for (var c=p.firstC' +
            'hild; c!=null; c=c.nextSibling) adjFullChildPos(c);'#13#10#9'adjBody(p)' +
            ';'#13#10'}'#13#10#13#10'function ResizeEvent() {'#13#10#9'var p=(this==window?document.' +
            'body:this);'#13#10#9'adjPos(p);'#13#10#9'adjChildPos(p);'#13#10#9'adjBody(p);'#13#10'}'#13#10#13#10'f' +
            'unction adjBody(p) {'#13#10#9'if (p==document.body) {'#13#10#9#9'var x=0;'#13#10#9#9'va' +
            'r y=0;'#9#13#10#9#9'for (var c=p.firstChild; c!=null; c=c.nextSibling) if' +
            ' (c.offsetLeft!=null) {'#13#10#9#9#9'x=Math.max(x,c.offsetLeft+c.offsetWi' +
            'dth);'#13#10#9#9#9'y=Math.max(y,c.offsetTop+c.offsetHeight);'#13#10#9#9'}'#13#10#9#9'docu' +
            'ment.body.style.width=Math.max(0,x-getNumber(document.body.curre' +
            'ntStyle.paddingRight)-getNumber(document.body.currentStyle.paddi' +
            'ngLeft))+"px";'#13#10#9#9'document.body.style.height=Math.max(0,y-getNum' +
            'ber(document.body.currentStyle.paddingTop)-getNumber(document.bo' +
            'dy.currentStyle.paddingBottom))+"px";'#13#10#9'}'#13#10'}'#13#10#13#10'function adjPos(' +
            'e) {'#13#10#9'if (!e.style) return;'#13#10#9'var p=(e.parentNode==document.bod' +
            'y?e.parentNode.parentNode:e.parentNode);'#13#10#9'if (e.centerH) e.styl' +
            'e.left=Math.max(0,p.clientWidth/2-(e.offsetWidth+mb(e,'#39'Left'#39')+mb' +
            '(e,'#39'Right'#39'))/2);'#13#10#9'if (e.dynWidth) e.style.width=Math.max(1,p.cl' +
            'ientWidth-mb(e,'#39'Left'#39',true)-mb(e,'#39'Right'#39',true)+(-getNumber(e.cur' +
            'rentStyle.left)-getNumber(e.currentStyle.right)));'#13#10#9'if (e.dynBl' +
            'ockWidth) e.style.width=Math.max(1,p.clientWidth-mb(e,'#39'Left'#39',tru' +
            'e)-mb(e,'#39'Right'#39',true)+(-getNumber(e.parentNode.currentStyle.padd' +
            'ingLeft)-getNumber(e.parentNode.currentStyle.paddingRight)));'#13#10#9 +
            'if (e.dynHeight) e.style.height=Math.max(1,p.clientHeight-mb(e,'#39 +
            'Top'#39',true)-mb(e,'#39'Bottom'#39',true)+(-getNumber(e.currentStyle.top)-g' +
            'etNumber(e.currentStyle.bottom)));'#13#10#9'if (e.dynLeft) e.style.left' +
            '=p.clientWidth-mb(e,'#39'Left'#39')-mb(e,'#39'Right'#39')-e.offsetWidth+(-getNum' +
            'ber(e.currentStyle.right));'#13#10#9'if (e.dynTop) e.style.top=p.client' +
            'Height-mb(e,'#39'Top'#39')-mb(e,'#39'Bottom'#39')-e.offsetHeight+(-getNumber(e.c' +
            'urrentStyle.bottom));'#13#10'}'#13#10#13#10'function Linked(Self){'#13#10#9'if (Self.FP' +
            'C) {'#13#10#9#9'var OldAnchor=Self.FPC.FURLAnchor;'#13#10#9#9'Self.FPC.FURLAncho' +
            'r=Self;'#13#10#9#9'if (OldAnchor) CheckDesignState(OldAnchor);'#13#10#9'}'#13#10#9'Che' +
            'ckDesignState(Self);'#13#10'}'#13#10#13#10'function scrollFragment(sv) {'#13#10#9'var v' +
            '=document.getElementById(sv.substr(sv.indexOf("#")+1));'#13#10#9'if (v)' +
            ' {v.scrollIntoView(true); if (v.parentNode==document.body) windo' +
            'w.scrollTo(v.offsetLeft,v.offsetTop); }'#13#10'}'#13#10#13#10'function getNumber' +
            '(n) {'#13#10#9'var h=n.replace(/px/,""); if (isNaN(h) || !h) return 0; ' +
            'return Number(h);'#13#10'}'#13#10#13#10'function isPx(n) {'#13#10#9'var h=n.replace(/px' +
            '/,""); return !isNaN(h) && h;'#13#10'}'#13#10#13#10'function mb(e,s,p) {'#13#10#9'retur' +
            'n getNumber(e.currentStyle.getAttribute("margin"+s))+(!p||e.type' +
            '=="button"||e.type=="submit"||e.type=="reset"||e.tagName=="SELEC' +
            'T"?0:(e.currentStyle.getAttribute("border"+s+"Style")!="none"?ge' +
            'tNumber(e.currentStyle.getAttribute("border"+s+"Width")):0)+getN' +
            'umber(e.currentStyle.getAttribute("padding"+s)));'#13#10'}'#13#10#13#10'function' +
            ' getRelativeBefore(e) {'#13#10#9'for (var p=e.previousSibling; p; p=p.p' +
            'reviousSibling) if (p.style!=null && p.style.position=="relative' +
            '") return p;'#13#10#9'return null;'#13#10'}'#13#10#13#10'function dhtml() {'#13#10#13#10'var ever' +
            'ything=document.all;'#13#10'if (!everything) everything=document.getEl' +
            'ementsByTagName("*");'#13#10'for(var i=0; i<everything.length; i++) {'#13 +
            #10#9'var e=everything[i];'#13#10#9'if (e.nodeType!=1) continue;'#13#10#9'var s=e.' +
            'tagName;'#13#10#9'if (!IE && (e.getAttribute("scroll")=="yes" || e.getA' +
            'ttribute("scrolling")=="yes")) {'#13#10#9#9'e.style.overflowX="auto";'#13#10#9 +
            #9'e.style.overflowY="scroll";'#13#10#9'}'#13#10#9'if (IE) {'#13#10#9#9'e.onresize=Resiz' +
            'eEvent; '#13#10#9#9'e.centerH=e.style.marginLeft=="auto" && e.style.marg' +
            'inRight=="auto";'#13#10#9#9'e.dynWidth=!e.centerH && isPx(e.currentStyle' +
            '.left) && isPx(e.currentStyle.right);'#13#10#9#9'e.dynBlockWidth=e.style' +
            '.position=="relative" && !isPx(e.currentStyle.width) && e.parent' +
            'Node && (e.tagName=="A" || e.tagName=="DIV");'#13#10#9#9'e.dynHeight=isP' +
            'x(e.currentStyle.top) && isPx(e.currentStyle.bottom);'#13#10#9#9'e.dynLe' +
            'ft=!isPx(e.currentStyle.left) && isPx(e.currentStyle.right);'#13#10#9#9 +
            'e.dynTop=!isPx(e.currentStyle.top) && isPx(e.currentStyle.bottom' +
            ');'#13#10#9#9'if (e.style.position=="relative" && !getRelativeBefore(e))' +
            ' {var d=document.createElement("div"); d.style.position="relativ' +
            'e"; d.style.overflow="hidden";  d.style.height="0px"; e.parentNo' +
            'de.insertBefore(d,e); }'#13#10#9'}'#13#10#9'if (!(s=="IMG" || s=="img" || s=="' +
            'A" || s=="a" || s=="DIV" || s=="div" || s=="BODY" || s=="body" |' +
            '| s=="BUTTON" || s=="button" || s=="INPUT" || s=="input")) conti' +
            'nue;'#13#10#9'if (s=e.getAttribute("cbottom")) e.style.bottom=Number(s)' +
            ';'#13#10#9'if (s=e.getAttribute("parentmenuitem")) {'#13#10#9#9'e.FParentMenuIt' +
            'em=document.getElementById(s);'#13#10#9#9'if (!e.FParentMenuItem) contin' +
            'ue;'#13#10#9#9'e.FParentMenuItem.FSubMenu=e;'#13#10#9#9'e.IsInline=e.FParentMenu' +
            'Item && e.parentNode==e.FParentMenuItem.parentNode && e.parentNo' +
            'de!=document.body;'#13#10#9#9'if (s=e.getAttribute("reactiontime")) e.FR' +
            'eactionTime=Number(s); else e.FReactionTime=1;'#13#10#9'}'#13#10'       '#9'e.on' +
            'mouseout=MouseOutEvent;'#13#10#9'e.onmouseover=MouseOverEvent;'#13#10#9'e.onmo' +
            'usedown=MouseDownEvent;'#13#10#9'e.onmouseup=MouseUpEvent;'#13#10#9'if ((s=e.g' +
            'etAttribute("target")) && s.substr(0,1)!="_") e.FPC=document.get' +
            'ElementById(s);'#13#10#9'if (s=e.getAttribute("linkpage")) { e.FLinkPag' +
            'e=document.getElementById(s); e.FPC=e.FLinkPage.parentNode;}'#13#10#9'i' +
            'f (e.getAttribute("pageselected")) GotoSlide(e);'#13#10#9'if (e.getAttr' +
            'ibute("linked")) Linked(e);'#13#10'}'#13#10#13#10'if (window.opera){'#13#10#9'var ori_o' +
            'nload=document.body.onload;'#13#10#9'document.body.onload = function ()' +
            '{'#13#10#9#9'top.document.body.style.display="none";'#13#10#9#9'top.document.bod' +
            'y.style.display="";'#13#10#9#9'if (ori_onload) ori_onload();'#13#10#9'}'#13#10#9'docum' +
            'ent.body.onresize = function (){'#13#10#9#9'document.body.style.display=' +
            '"none";'#13#10#9#9'document.body.style.display="";'#13#10#9'}'#13#10'}'#13#10#13#10#13#10'if (IE) d' +
            'ocument.body.style.display="";'#13#10#13#10'scrollFragment(document.URL);'#13 +
            #10#13#10'if (IE) adjFullChildPos(document.body);'#13#10'if (IE) setTimeout("' +
            'adjFullChildPos(document.body);",0);'#13#10#13#10'}'#13#10#13#10'function preload() ' +
            '{'#13#10#9'var p=document.prel; if(!p){p=new Array();document.prel=p}va' +
            'r i;for(i=0; i<preload.arguments.length; i++) {p[i]=new Image; p' +
            '[i].src=preload.arguments[i]; }'#13#10'}'#13#10#13#10'if (IE) { document.body.st' +
            'yle.display="none"; }'
        end
        object bClearEffects: TTntButton
          Left = 728
          Top = 0
          Width = 51
          Height = 25
          Caption = 'Reset'
          TabOrder = 0
          OnClick = bClearEffectsClick
        end
      end
      object AnchorMisc: TTntTabSheet
        Hint = 'Misc'
        Caption = 'Misc'
        ImageIndex = 3
        OnShow = AnchorMiscShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox26: TMyGroupBox
          Left = 8
          Top = 0
          Width = 209
          Height = 91
          Caption = 'General'
          TabOrder = 3
          DesignSize = (
            209
            91)
          object Label15: TdhLabel
            Top = 24
            Width = 29
            Height = 13
            Text = 'cursor'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 119
          end
          object Label24: TdhLabel
            Top = 48
            Width = 33
            Height = 13
            Text = 'z-index'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 119
          end
          object Label30: TdhLabel
            Top = 72
            Width = 40
            Height = 13
            Text = 'direction'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 119
          end
          object cbCursor: ThComboBox
            Left = 96
            Top = 16
            Width = 105
            Height = 21
            Style = csDropDownList
            DropDownCount = 20
            ItemHeight = 13
            TabOrder = 0
            OnDropDown = cbCursorDropDown
            Items.Strings = (
              '*CLEAR VALUE*'
              'auto'
              'crosshair'
              'default'
              'pointer'
              'move'
              'e-resize'
              'ne-resize'
              'nw-resize'
              'n-resize'
              'se-resize'
              'sw-resize'
              's-resize'
              'w-resize'
              'text'
              'wait'
              'help')
            ValueChange = cbCursorValueChange
            ChangeReason = 'Change Cursor'
          end
          object cbZIndex: ThComboBox
            Left = 96
            Top = 40
            Width = 105
            Height = 21
            DropDownCount = 11
            ItemHeight = 13
            TabOrder = 1
            Items.Strings = (
              '-5'
              '-4'
              '-3'
              '-2'
              '-1'
              '0'
              '1'
              '2'
              '3'
              '4'
              '5')
            ValueChange = cbZIndexValueChange
            ChangeReason = 'Change Z-Index'
          end
          object cbDirection: ThComboBox
            Left = 96
            Top = 64
            Width = 105
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 2
            Items.Strings = (
              '*CLEAR VALUE*'
              'left to right'
              'right to left')
            ValueChange = cbDirectionValueChange
            ChangeReason = 'Change Direction'
          end
        end
        object GroupBox25: TMyGroupBox
          Left = 224
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Text Alignment'
          TabOrder = 2
          DesignSize = (
            209
            91)
          object Label16: TdhLabel
            Top = 24
            Width = 59
            Height = 13
            Text = 'vertical-align'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 119
          end
          object Label18: TdhLabel
            Top = 72
            Width = 49
            Height = 13
            Text = 'text-indent'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 119
          end
          object Label12: TdhLabel
            Top = 48
            Width = 42
            Height = 13
            Text = 'text-align'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 119
          end
          object CODE_cbVerticalAlign: ThComboBox
            Left = 96
            Top = 16
            Width = 105
            Height = 21
            DropDownCount = 10
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              'baseline'
              'text-top'
              'middle'
              'text-bottom'
              '10px'
              '-10px'
              '20%'
              '-20%')
            ValueChange = CODE_cbVerticalAlignValueChange
            ChangeReason = 'Change Vertical-Align'
          end
          object CODE_cbTextIndent: ThComboBox
            Left = 96
            Top = 64
            Width = 105
            Height = 21
            ItemHeight = 13
            TabOrder = 1
            Items.Strings = (
              '50px'
              '10px'
              '-10px'
              '-50px')
            ValueChange = CODE_cbTextIndentValueChange
            ChangeReason = 'Change Text-Indent'
          end
          object cbTextAlign: ThComboBox
            Left = 96
            Top = 40
            Width = 105
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 2
            Items.Strings = (
              '*CLEAR VALUE*'
              'left'
              'right'
              'center'
              'justify')
            ValueChange = cbTextAlignValueChange
            ChangeReason = 'Change Text-Align'
          end
        end
        object GroupBox24: TMyGroupBox
          Left = 440
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Text Interpretation'
          TabOrder = 1
          DesignSize = (
            209
            91)
          object Label25: TdhLabel
            Top = 24
            Width = 63
            Height = 13
            Text = 'text-transform'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 119
          end
          object Label26: TdhLabel
            Top = 72
            Width = 53
            Height = 13
            Text = 'font-variant'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 119
          end
          object Label13: TdhLabel
            Top = 48
            Width = 57
            Height = 13
            Text = 'white-space'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 119
          end
          object cbTextTransform: ThComboBox
            Left = 96
            Top = 16
            Width = 105
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              '*CLEAR VALUE*'
              'capitalize'
              'uppercase'
              'lowercase'
              'none')
            ValueChange = cbTextTransformValueChange
            ChangeReason = 'Change Text-Transform'
          end
          object cbWhiteSpace: ThComboBox
            Left = 96
            Top = 40
            Width = 105
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 1
            Items.Strings = (
              '*CLEAR VALUE*'
              'normal'
              'pre'
              'nowrap')
            ValueChange = cbWhiteSpaceValueChange
            ChangeReason = 'Change White-Space'
          end
          object cbFontVariant: ThComboBox
            Left = 96
            Top = 64
            Width = 105
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 2
            Items.Strings = (
              '*CLEAR VALUE*'
              'normal'
              'small-caps')
            ValueChange = cbFontVariantValueChange
            ChangeReason = 'Change Font-Variant'
          end
        end
        object bClearMore: TTntButton
          Left = 672
          Top = 8
          Width = 51
          Height = 25
          Caption = 'Reset'
          TabOrder = 0
          OnClick = bClearMoreClick
        end
        object bMoreMisc: TTntButton
          Left = 672
          Top = 40
          Width = 105
          Height = 25
          Caption = 'Special Styles..'
          TabOrder = 4
          OnClick = bMoreMiscClick
        end
      end
      object AnchorName: TTntTabSheet
        Caption = 'Object'
        ImageIndex = -1
        OnShow = AnchorNameShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox21: TMyGroupBox
          Left = 8
          Top = 0
          Width = 209
          Height = 91
          Caption = 'General'
          TabOrder = 0
          DesignSize = (
            209
            91)
          object Image1: TImage
            Left = 80
            Top = 64
            Width = 25
            Height = 25
            Transparent = True
          end
          object Label19: TdhLabel
            Top = 24
            Width = 11
            Height = 13
            Text = 'ID'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 137
          end
          object Label37: TdhLabel
            Top = 48
            Width = 32
            Height = 13
            Text = 'Tooltip'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 137
          end
          object Label38: TdhLabel
            Top = 71
            Width = 24
            Height = 13
            Text = 'Type'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 137
          end
          object IGNORE_Label39: TdhLabel
            Left = 107
            Top = 71
            Width = 49
            Height = 13
            Text = 'objecttype'
            AutoSizeXY = asXY
          end
          object eName: ThEdit
            Left = 80
            Top = 16
            Width = 113
            Height = 21
            TabOrder = 0
            ValueChange = eNameValueChange
            LateChange = True
            ChangeReason = 'Rename'
          end
          object eTooltip: ThEdit
            Left = 80
            Top = 40
            Width = 113
            Height = 21
            TabOrder = 1
            ValueChange = eTooltipValueChange
            LateChange = True
            ChangeReason = 'Edit Tooltip'
          end
        end
        object GroupBox18: TMyGroupBox
          Left = 224
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Style Management'
          TabOrder = 1
          DesignSize = (
            209
            91)
          object Label2: TdhLabel
            Top = 24
            Width = 71
            Height = 13
            Text = 'Use styles from'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 103
          end
          object cbUse: ThComboBox
            Left = 112
            Top = 16
            Width = 89
            Height = 21
            ItemHeight = 13
            TabOrder = 0
            ValueChange = cbUseValueChange
            ChangeReason = 'Change Use'
          end
          object cDownOverlayOver: TTntRadioButton
            Left = 8
            Top = 45
            Width = 193
            Height = 17
            Caption = 'Prefer Down styles to Over styles'
            TabOrder = 1
            OnClick = cDownOverlayOverClick
          end
          object cOverOverlayDown: TTntRadioButton
            Left = 8
            Top = 64
            Width = 193
            Height = 17
            Caption = 'Prefer Over styles to Down styles'
            TabOrder = 2
            OnClick = cDownOverlayOverClick
          end
        end
        object cImageFormat: TTntRadioGroup
          Left = 440
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Image Generation Format'
          Items.Strings = (
            'Automatic'
            'GIF'
            'Semi-transparent PNG')
          TabOrder = 2
          OnClick = cImageFormatClick
        end
        object IGNORE_cDoAction: ThComboBox
          Left = 664
          Top = 8
          Width = 129
          Height = 21
          Style = csDropDownList
          DropDownCount = 12
          ItemHeight = 13
          ItemIndex = 9
          TabOrder = 3
          Text = 'Copy from over/down styles including Use'
          Visible = False
          Items.Strings = (
            'Clear'
            'Copy from main styles'
            'Copy from down styles'
            'Copy from over styles'
            'Copy from over/down styles'
            'Clear including Use'
            'Copy from main styles including Use'
            'Copy from down styles including Use'
            'Copy from over styles including Use'
            'Copy from over/down styles including Use')
        end
        object IGNORE_Button9: TTntButton
          Left = 664
          Top = 32
          Width = 27
          Height = 17
          Caption = 'Do!'
          TabOrder = 4
          Visible = False
          OnClick = IGNORE_Button9Click
        end
      end
      object AnchorPosition: TTntTabSheet
        Caption = 'Pos.'
        ImageIndex = -1
        OnShow = AnchorPositionShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox4: TMyGroupBox
          Left = 8
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Bounds'
          TabOrder = 3
          DesignSize = (
            209
            91)
          object spLeft: TMySpinEdit
            Left = 46
            Top = 16
            Width = 51
            Height = 22
            MaxValue = 999999
            MinValue = -999999
            TabOrder = 0
            Value = 0
            Alignment = taRightJustify
            ValueChange = spLeftValueChange
            ChangeReason = 'Left'
          end
          object spTop: TMySpinEdit
            Left = 150
            Top = 16
            Width = 51
            Height = 22
            MaxValue = 999999
            MinValue = -999999
            TabOrder = 1
            Value = 0
            Alignment = taRightJustify
            ValueChange = spLeftValueChange
            ChangeReason = 'Top'
          end
          object dhLabel29: TdhLabel
            Top = 22
            Width = 19
            Height = 13
            Text = 'Top'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 64
            OnClick = cAutoXClick
          end
          object dhLabel30: TdhLabel
            Top = 22
            Width = 18
            Height = 13
            Text = 'Left'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 168
            OnClick = cAutoXClick
          end
          object dhLabel31: TdhLabel
            Top = 46
            Width = 28
            Height = 13
            Text = 'Width'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 168
            OnClick = cAutoXClick
          end
          object spWidth: TMySpinEdit
            Left = 46
            Top = 40
            Width = 51
            Height = 22
            MaxValue = 999999
            MinValue = 0
            TabOrder = 5
            Value = 0
            Alignment = taRightJustify
            ValueChange = spLeftValueChange
            ChangeReason = 'Width'
          end
          object dhLabel32: TdhLabel
            Top = 46
            Width = 31
            Height = 13
            Text = 'Height'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 64
            OnClick = cAutoXClick
          end
          object spHeight: TMySpinEdit
            Left = 150
            Top = 40
            Width = 51
            Height = 22
            MaxValue = 999999
            MinValue = 0
            TabOrder = 7
            Value = 0
            Alignment = taRightJustify
            ValueChange = spLeftValueChange
            ChangeReason = 'Height'
          end
          object cAutoX: TTntCheckBox
            Left = 14
            Top = 64
            Width = 91
            Height = 20
            Caption = 'Auto Width'
            TabOrder = 8
            OnClick = cAutoXClick
          end
          object cAutoY: TTntCheckBox
            Left = 107
            Top = 64
            Width = 94
            Height = 20
            Caption = 'Auto Height'
            TabOrder = 9
            OnClick = cAutoXClick
          end
        end
        object GroupBox1: TMyGroupBox
          Left = 224
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Alignment'
          TabOrder = 0
          object cNone: TTntRadioButton
            Left = 8
            Top = 16
            Width = 97
            Height = 17
            Caption = 'None'
            TabOrder = 1
            OnClick = cNoneClick
          end
          object cTop: TTntRadioButton
            Left = 112
            Top = 16
            Width = 89
            Height = 17
            Caption = 'Top'
            TabOrder = 3
            OnClick = cNoneClick
          end
          object cRight: TTntRadioButton
            Left = 112
            Top = 32
            Width = 89
            Height = 17
            Caption = 'Right'
            TabOrder = 4
            OnClick = cNoneClick
          end
          object cBottom: TTntRadioButton
            Left = 112
            Top = 48
            Width = 89
            Height = 17
            Caption = 'Bottom'
            TabOrder = 5
            OnClick = cNoneClick
          end
          object cClient: TTntRadioButton
            Left = 8
            Top = 32
            Width = 97
            Height = 17
            Caption = 'Full Parent'
            TabOrder = 0
            OnClick = cNoneClick
          end
          object cLeft: TTntRadioButton
            Left = 112
            Top = 64
            Width = 89
            Height = 17
            Caption = 'Left'
            TabOrder = 2
            OnClick = cNoneClick
          end
        end
        object GroupBox2: TMyGroupBox
          Left = 448
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Keep distance constant to'
          TabOrder = 1
          object caTop: TTntCheckBox
            Left = 16
            Top = 16
            Width = 185
            Height = 17
            Caption = 'Top parent edge'
            TabOrder = 1
            OnClick = cNoneClick
          end
          object caRight: TTntCheckBox
            Left = 16
            Top = 32
            Width = 185
            Height = 17
            Caption = 'Right parent edge'
            TabOrder = 2
            OnClick = cNoneClick
          end
          object caBottom: TTntCheckBox
            Left = 16
            Top = 48
            Width = 185
            Height = 17
            Caption = 'Bottom parent edge'
            TabOrder = 3
            OnClick = cNoneClick
          end
          object caLeft: TTntCheckBox
            Left = 16
            Top = 64
            Width = 185
            Height = 17
            Caption = 'Left parent edge'
            TabOrder = 0
            OnClick = cNoneClick
          end
        end
        object dhPanel2: TdhPanel
          Left = 660
          Top = 8
          Width = 88
          Height = 88
          Style.BackgroundColor = White
          AutoSizeXY = asNone
          Visible = False
          Constraints.MaxHeight = 88
          Constraints.MaxWidth = 88
          Constraints.MinHeight = 88
          Constraints.MinWidth = 88
          object SamplePosition: TdhPanel
            Left = 24
            Top = 24
            Width = 33
            Height = 33
            Style.BackgroundColor = Lime
            AutoSizeXY = asNone
          end
        end
      end
      object AnchorText: TTntTabSheet
        Caption = 'Text'
        ImageIndex = -1
        OnShow = AnchorTextShow
        object Label31: TdhLabel
          Left = 24
          Top = 16
          Width = 51
          Height = 13
          Text = 'Quick edit:'
          AutoSizeXY = asXY
        end
        object eText: ThEdit
          Left = 88
          Top = 8
          Width = 209
          Height = 21
          TabOrder = 1
          ValueChange = eTextValueChange
          ChangeReason = 'Edit Text'
        end
        object Button8: TTntButton
          Left = 312
          Top = 1
          Width = 113
          Height = 25
          Caption = 'Edit with formatting'
          TabOrder = 0
          OnClick = Button8Click
        end
      end
      object AnchorPageControl: TTntTabSheet
        Caption = 'Pages'
        ImageIndex = -1
        OnShow = AnchorPageControlShow
        object Label36: TdhLabel
          Left = 0
          Top = 0
          Width = 81
          Height = 13
          Text = 'Managed Pages:'
          AutoSizeXY = asXY
        end
        object vs: TListBox
          Left = 88
          Top = 0
          Width = 177
          Height = 95
          ItemHeight = 13
          TabOrder = 2
          OnClick = vsClick
        end
        object Panel2: TPanel
          Left = 312
          Top = 0
          Width = 113
          Height = 111
          BevelOuter = bvNone
          TabOrder = 1
          object Button14: TTntButton
            Left = 0
            Top = 0
            Width = 97
            Height = 17
            Caption = 'Create new page'
            TabOrder = 0
            OnClick = dhAnchor8Click
          end
          object bDeletePage: TTntButton
            Left = 0
            Top = 24
            Width = 97
            Height = 17
            Caption = 'Delete page'
            TabOrder = 1
            OnClick = dhAnchor11Click
          end
          object bMovePageUp: TTntButton
            Left = 0
            Top = 48
            Width = 97
            Height = 17
            Caption = 'Move up'
            TabOrder = 2
            OnClick = dhAnchor9Click
          end
          object bMovePageDown: TTntButton
            Left = 0
            Top = 72
            Width = 97
            Height = 17
            Caption = 'Move Down'
            TabOrder = 3
            OnClick = dhAnchor9Click
          end
        end
        object GroupBox16: TMyGroupBox
          Left = 472
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Page Control Options'
          TabOrder = 0
          object cDynamicNavigation: TTntCheckBox
            Left = 16
            Top = 48
            Width = 185
            Height = 17
            Caption = 'One HTML page per Page object'
            TabOrder = 0
            OnClick = cDynamicNavigationClick
          end
          object cFixedHeight: TTntCheckBox
            Left = 16
            Top = 24
            Width = 185
            Height = 17
            Caption = 'Same height for all pages'
            TabOrder = 1
            OnClick = cFixedHeightClick
          end
        end
      end
      object AnchorPage: TTntTabSheet
        Caption = 'Page'
        ImageIndex = -1
        OnShow = AnchorPageShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox22: TMyGroupBox
          Left = 16
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Page Properties'
          TabOrder = 0
          object dhLabel16: TdhLabel
            Left = 16
            Top = 32
            Width = 23
            Height = 13
            Text = 'Title:'
            AutoSizeXY = asY
          end
          object eTitle: ThEdit
            Left = 56
            Top = 24
            Width = 137
            Height = 21
            TabOrder = 1
            ValueChange = eTitleValueChange
            LateChange = True
            ChangeReason = 'Edit Title'
          end
          object eOutputDirectory: ThEdit
            Left = 56
            Top = 56
            Width = 137
            Height = 21
            TabOrder = 2
            ValueChange = eOutputDirectoryValueChange
            LateChange = True
            ChangeReason = 'Change Output Directory'
          end
          object dhLabel4: TdhLabel
            Left = 8
            Top = 52
            Width = 49
            Height = 26
            Text = 'Local directory:'
            AutoSizeXY = asY
          end
        end
        object gScrolling: TTntRadioGroup
          Left = 240
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Show Scrollbars'
          Items.Strings = (
            'auto'
            'yes'
            'no')
          TabOrder = 2
          OnClick = gScrollingClick
        end
        object gHTMLFrame: TTntRadioGroup
          Left = 456
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Implementation'
          Items.Strings = (
            '<div>'
            '<iframe> (without margin/border)')
          TabOrder = 3
          OnClick = gHTMLFrameClick
        end
        object Button3: TTntButton
          Left = 672
          Top = 8
          Width = 73
          Height = 25
          Caption = 'More..'
          TabOrder = 1
          OnClick = mPagePropertiesClick
        end
      end
      object AnchorEdit: TTntTabSheet
        Caption = 'Edit'
        ImageIndex = -1
        OnShow = AnchorEditShow
        object GroupBox15: TMyGroupBox
          Left = 8
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Initial Text'
          TabOrder = 0
          object eEdit: ThEdit
            Left = 16
            Top = 32
            Width = 177
            Height = 21
            TabOrder = 0
            ValueChange = eEditValueChange
            ChangeReason = 'Input Text'
          end
        end
        object GroupBox20: TMyGroupBox
          Left = 232
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Options'
          TabOrder = 1
          object cReadOnly: TTntCheckBox
            Left = 16
            Top = 24
            Width = 177
            Height = 17
            Caption = 'Read only'
            TabOrder = 0
            OnClick = cReadOnlyClick
          end
          object cPassword: TTntCheckBox
            Left = 16
            Top = 56
            Width = 177
            Height = 17
            Caption = 'Password'
            TabOrder = 1
            OnClick = cPasswordClick
          end
        end
      end
      object AnchorMemo: TTntTabSheet
        Caption = 'Memo'
        ImageIndex = -1
        OnShow = AnchorMemoShow
        object Label35: TdhLabel
          Left = 8
          Top = 16
          Width = 51
          Height = 13
          Text = 'Initial Text:'
          AutoSizeXY = asXY
        end
        object eMemo: ThMemo
          Left = 72
          Top = 8
          Width = 209
          Height = 89
          ScrollBars = ssVertical
          TabOrder = 0
          WantTabs = True
          ChangeReason = 'Edit Memo Text'
          ValueChange = eMemoValueChange
        end
        object GroupBox29: TMyGroupBox
          Left = 296
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Options'
          TabOrder = 1
          object cMemoReadOnly: TTntCheckBox
            Left = 16
            Top = 24
            Width = 177
            Height = 17
            Caption = 'Read only'
            TabOrder = 0
            OnClick = cMemoReadOnlyClick
          end
          object cWrap: TTntCheckBox
            Left = 16
            Top = 56
            Width = 177
            Height = 17
            Caption = 'Wrap'
            TabOrder = 1
            OnClick = cWrapClick
          end
        end
      end
      object AnchorCheckBox: TTntTabSheet
        Caption = 'Check'
        ImageIndex = -1
        OnShow = AnchorCheckBoxShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object IGNORE_cRightJustify: TTntCheckBox
          Left = 512
          Top = 32
          Width = 257
          Height = 17
          Caption = 'Caption appears to the right of the check box'
          TabOrder = 0
          Visible = False
          OnClick = IGNORE_cRightJustifyClick
        end
        object rgChecked: TTntRadioGroup
          Left = 16
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Initial State'
          Items.Strings = (
            'Checked'
            'Unchecked')
          TabOrder = 1
          OnClick = cCheckedClick
        end
        object GroupBox33: TMyGroupBox
          Left = 240
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Submitted Value'
          TabOrder = 2
          object eCheckValue: ThEdit
            Left = 16
            Top = 32
            Width = 177
            Height = 21
            TabOrder = 0
            ValueChange = eCheckValueValueChange
            LateChange = True
            ChangeReason = 'Value'
          end
        end
      end
      object AnchorForm: TTntTabSheet
        Caption = 'Form'
        ImageIndex = -1
        OnShow = AnchorFormShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object cbMethod: TTntRadioGroup
          Left = 8
          Top = 0
          Width = 209
          Height = 89
          Caption = 'Request Method'
          Items.Strings = (
            'Get'
            'Post')
          TabOrder = 1
          OnClick = cbMethodClick
        end
        object GroupBox30: TMyGroupBox
          Left = 224
          Top = 0
          Width = 209
          Height = 91
          Caption = 'External Link'
          TabOrder = 0
          DesignSize = (
            209
            91)
          object dhLabel26: TdhLabel
            Top = 27
            Width = 22
            Height = 13
            Text = 'URL'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 160
          end
          object eAction: ThEdit
            Left = 56
            Top = 19
            Width = 145
            Height = 21
            TabOrder = 3
            ValueChange = eActionValueChange
            ChangeReason = 'Edit HTML Form'
          end
          object dhLabel7: TdhLabel
            Top = 59
            Width = 31
            Height = 13
            Text = 'Target'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 144
          end
          object CODE_eFormTarget: ThComboBox
            Left = 72
            Top = 51
            Width = 97
            Height = 21
            DropDownCount = 10
            ItemHeight = 13
            TabOrder = 1
            Items.Strings = (
              '_blank'
              '_parent'
              '_search'
              '_self'
              '_top')
            ValueChange = CODE_eFormTargetValueChange
            ChangeReason = 'Edit HTML Form'
          end
        end
      end
      object AnchorMenu: TTntTabSheet
        Caption = 'Menu'
        ImageIndex = -1
        OnShow = AnchorMenuShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object CheckGroupBox1: TMyGroupBox
          Left = 296
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Menu Sliding'
          TabOrder = 2
          Visible = False
          DesignSize = (
            209
            91)
          object IGNORE_Label20: TdhLabel
            Left = 136
            Top = 64
            Width = 11
            Height = 13
            Text = 'px'
            AutoSizeXY = asY
            Enabled = False
          end
          object Label21: TdhLabel
            Top = 64
            Width = 58
            Height = 13
            Text = 'Pixel to slide'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Enabled = False
            Right = 124
          end
          object spSlidePixel: TMySpinEdit
            Left = 88
            Top = 56
            Width = 42
            Height = 22
            Enabled = False
            MaxValue = 9999
            MinValue = 1
            TabOrder = 0
            Value = 1
            Alignment = taRightJustify
            ValueChange = spReactionTimeValueChange
            ChangeReason = 'Slide Pixel'
          end
          object cSlide: TTntCheckBox
            Left = 16
            Top = 24
            Width = 87
            Height = 17
            Caption = 'Enable'
            TabOrder = 1
            OnClick = cSlideClick
          end
        end
        object GroupBox32: TMyGroupBox
          Left = 512
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Open Menu By'
          TabOrder = 3
          object IGNORE_Label22: TdhLabel
            Left = 120
            Top = 64
            Width = 25
            Height = 13
            Text = 'msec'
            AutoSizeXY = asY
          end
          object cbParentMenuItem: ThComboBox
            Left = 16
            Top = 24
            Width = 121
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            ValueChange = cbParentMenuItemValueChange
            ChangeReason = 'Opened By'
          end
          object cOpenByOver: TTntCheckBox
            Left = 16
            Top = 64
            Width = 65
            Height = 17
            Caption = 'after'
            TabOrder = 1
            OnClick = cOpenByOverClick
          end
          object spReactionTime: TMySpinEdit
            Left = 67
            Top = 56
            Width = 42
            Height = 22
            Enabled = False
            MaxValue = 9999
            MinValue = 0
            TabOrder = 2
            Value = 0
            Alignment = taRightJustify
            ValueChange = spReactionTimeValueChange
            ChangeReason = 'Edit Delay'
          end
        end
        object Button10: TTntButton
          Left = 656
          Top = -8
          Width = 105
          Height = 25
          Caption = 'Add menu item'
          TabOrder = 0
          Visible = False
          OnClick = Button10Click
        end
        object GroupBox14: TMyGroupBox
          Left = 80
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Options'
          TabOrder = 1
          object cHorizontalLayout: TTntCheckBox
            Left = 8
            Top = 78
            Width = 193
            Height = 17
            Caption = 'Horizontal Orientation'
            TabOrder = 3
            Visible = False
            OnClick = cHorizontalLayoutClick
          end
          object cInline: TTntCheckBox
            Left = 8
            Top = 30
            Width = 193
            Height = 17
            Caption = 'Inline Menu'
            TabOrder = 0
            OnClick = cHorizontalLayoutClick
          end
          object cResumeOpen: TTntCheckBox
            Left = 8
            Top = 46
            Width = 193
            Height = 17
            Caption = 'Continue Opened Menu'
            TabOrder = 1
            OnClick = cHorizontalLayoutClick
          end
          object cStatic: TTntCheckBox
            Left = 8
            Top = 62
            Width = 193
            Height = 17
            Caption = 'Static Menu'
            TabOrder = 2
            Visible = False
            OnClick = cHorizontalLayoutClick
          end
          object cMenuAuto: TTntCheckBox
            Left = 8
            Top = 15
            Width = 81
            Height = 16
            Caption = 'Automatic'
            TabOrder = 4
            OnClick = cMenuAutoClick
          end
        end
      end
      object AnchorLink: TTntTabSheet
        Caption = 'Link'
        ImageIndex = -1
        OnShow = AnchorLinkShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox11: TMyGroupBox
          Left = 8
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Link'
          TabOrder = 0
          DesignSize = (
            209
            91)
          object dhLabel14: TdhLabel
            Top = 27
            Width = 59
            Height = 13
            Text = 'Link to page'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 136
          end
          object cbLinkPage: ThComboBox
            Left = 80
            Top = 19
            Width = 121
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 1
            ValueChange = cbLinkPageValueChange
            ChangeReason = 'Edit Link'
          end
          object cbLinkAnchor: ThComboBox
            Left = 80
            Top = 51
            Width = 121
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 2
            ValueChange = cbLinkPageValueChange
            ChangeReason = 'Edit Link'
          end
          object dhLabel15: TdhLabel
            Top = 59
            Width = 57
            Height = 13
            Text = 'Within page'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 137
          end
        end
        object GroupBox28: TMyGroupBox
          Left = 224
          Top = 0
          Width = 209
          Height = 91
          Caption = 'External Link'
          TabOrder = 2
          DesignSize = (
            209
            91)
          object dhLabel19: TdhLabel
            Top = 27
            Width = 22
            Height = 13
            Text = 'URL'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 160
          end
          object dhLabel1: TdhLabel
            Top = 59
            Width = 31
            Height = 13
            Text = 'Target'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 144
          end
          object CODE_eTarget: ThComboBox
            Left = 72
            Top = 51
            Width = 97
            Height = 21
            DropDownCount = 10
            ItemHeight = 13
            TabOrder = 2
            Items.Strings = (
              '_blank'
              '_parent'
              '_search'
              '_self'
              '_top')
            ValueChange = CODE_eTargetValueChange
            ChangeReason = 'Custom Link Change'
          end
          object CODE_eLink: ThComboBox
            Left = 56
            Top = 19
            Width = 145
            Height = 21
            DropDownCount = 10
            ItemHeight = 13
            TabOrder = 3
            Items.Strings = (
              'http://'
              'ftp://'
              'mailto:'
              'javascript:alert('#39'hi'#39')')
            ValueChange = CODE_eLinkValueChange
            ChangeReason = 'Custom Link Change'
          end
        end
        object GroupBox13: TMyGroupBox
          Left = 440
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Down State Conditions'
          TabOrder = 1
          object cDownIfMenu: TTntCheckBox
            Left = 112
            Top = 43
            Width = 95
            Height = 16
            Caption = 'Active Menu'
            TabOrder = 0
            Visible = False
            OnClick = cDownIfUrlClick
          end
          object cDownIfMouseDown: TTntCheckBox
            Left = 8
            Top = 43
            Width = 95
            Height = 16
            Caption = 'Mouse Click'
            TabOrder = 1
            OnClick = cDownIfUrlClick
          end
          object cDownIfOver: TTntCheckBox
            Left = 72
            Top = 75
            Width = 177
            Height = 16
            Caption = 'Mouse Over'
            TabOrder = 2
            Visible = False
            OnClick = cDownIfUrlClick
          end
          object cDown: TTntCheckBox
            Left = 112
            Top = 19
            Width = 95
            Height = 16
            Caption = 'Always Down'
            TabOrder = 3
            OnClick = cDownIfUrlClick
          end
          object cDownIfUrl: TTntCheckBox
            Left = 8
            Top = 67
            Width = 177
            Height = 16
            Caption = 'Link was activated'
            TabOrder = 4
            OnClick = cDownIfUrlClick
          end
          object cLinkAuto: TTntCheckBox
            Left = 8
            Top = 19
            Width = 95
            Height = 16
            Caption = 'Automatic'
            TabOrder = 5
            OnClick = cDownIfUrlClick
          end
        end
        object ppp: TPanel
          Left = 656
          Top = 0
          Width = 209
          Height = 97
          BevelOuter = bvNone
          TabOrder = 3
          object cLinkLayout: TTntRadioGroup
            Left = 0
            Top = 0
            Width = 105
            Height = 91
            Caption = 'Layout'
            Items.Strings = (
              'Automatic'
              'Text'
              'Link'
              'Button')
            TabOrder = 0
            OnClick = cLinkLayoutClick
          end
          object cLinkForm: TTntRadioGroup
            Left = 112
            Top = 0
            Width = 97
            Height = 91
            Caption = 'Form'
            Items.Strings = (
              'None'
              'Submit'
              'Reset')
            TabOrder = 1
            OnClick = cLinkFormClick
          end
        end
      end
      object AnchorHidden: TTntTabSheet
        Caption = 'Hidden'
        ImageIndex = -1
        OnShow = AnchorHiddenShow
        object GroupBox31: TMyGroupBox
          Left = 8
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Hidden field value'
          TabOrder = 0
          object eHiddenField: ThEdit
            Left = 16
            Top = 32
            Width = 177
            Height = 21
            TabOrder = 0
            ValueChange = eHiddenFieldValueChange
            ChangeReason = 'Edit Hidden Field'
          end
        end
      end
      object AnchorOle: TTntTabSheet
        Caption = 'OLE '
        ImageIndex = -1
        OnShow = AnchorOleShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Button2: TTntButton
          Left = 8
          Top = 8
          Width = 113
          Height = 25
          Caption = 'Edit OLE Content'
          TabOrder = 0
          OnClick = Button2Click
        end
        object Button4: TTntButton
          Left = 136
          Top = 8
          Width = 105
          Height = 25
          Caption = 'Properties'
          TabOrder = 1
          OnClick = Button4Click
        end
        object cTransparentWhite: TTntCheckBox
          Left = 272
          Top = 16
          Width = 161
          Height = 17
          Caption = 'White area is transparent'
          TabOrder = 2
          OnClick = cTransparentWhiteClick
        end
        object IGNORE_cUsage: TTntRadioGroup
          Left = 456
          Top = 8
          Width = 209
          Height = 91
          Caption = 'Usage'
          Items.Strings = (
            'Display (browser plugin required)'
            'Reference (by a link'#39's "Within page")'
            'Graphic (rendered as image)')
          TabOrder = 3
          OnClick = IGNORE_cUsageClick
        end
        object Button6: TTntButton
          Left = 104
          Top = 56
          Width = 75
          Height = 25
          Caption = 'Save'
          TabOrder = 4
          OnClick = Button6Click
        end
      end
      object AnchorSelect: TTntTabSheet
        Caption = 'List'
        ImageIndex = -1
        OnShow = AnchorSelectShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox19: TMyGroupBox
          Left = 544
          Top = -1
          Width = 209
          Height = 91
          Caption = 'Options'
          TabOrder = 3
          object cMultiple: TTntCheckBox
            Left = 8
            Top = 64
            Width = 193
            Height = 19
            Caption = 'Allow multiple selection'
            TabOrder = 0
            OnClick = cMultipleClick
          end
          object cDropDown: TTntRadioButton
            Left = 8
            Top = 16
            Width = 193
            Height = 17
            Caption = 'As drop-down list'
            TabOrder = 1
            OnClick = cDropDownClick
          end
          object cList: TTntRadioButton
            Left = 8
            Top = 40
            Width = 193
            Height = 17
            Caption = 'As list box'
            TabOrder = 2
            OnClick = cDropDownClick
          end
        end
        object Panel4: TPanel
          Left = 216
          Top = 0
          Width = 96
          Height = 89
          BevelOuter = bvNone
          TabOrder = 1
          object Button5: TTntButton
            Left = 0
            Top = 0
            Width = 89
            Height = 17
            Caption = 'New item'
            TabOrder = 0
            OnClick = Button5Click
          end
          object bMoveItemUp: TTntButton
            Left = 0
            Top = 48
            Width = 89
            Height = 17
            Caption = 'Move up'
            TabOrder = 1
            OnClick = bMoveItemUpClick
          end
          object bMoveItemDown: TTntButton
            Left = 0
            Top = 72
            Width = 89
            Height = 17
            Caption = 'Move down'
            TabOrder = 2
            OnClick = bMoveItemDownClick
          end
          object bDeleteItem: TTntButton
            Left = 0
            Top = 24
            Width = 89
            Height = 17
            Caption = 'Delete item'
            TabOrder = 3
            OnClick = bDeleteItemClick
          end
        end
        object dhSelect1: TdhSelect
          Left = 0
          Top = 0
          Width = 209
          Height = 86
          AutoSizeXY = asY
          OnClick = dhSelect1Click
          Items = <>
          SelectType = stList
          OnGetDisplayText = dhSelect1GetDisplayText
        end
        object GroupBox12: TMyGroupBox
          Left = 328
          Top = 0
          Width = 209
          Height = 91
          Caption = 'Item properties'
          TabOrder = 0
          DesignSize = (
            209
            91)
          object Label29: TdhLabel
            Top = 24
            Width = 26
            Height = 13
            Text = 'Label'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 143
          end
          object Label34: TdhLabel
            Top = 50
            Width = 27
            Height = 13
            Text = 'Value'
            AutoSizeXY = asXY
            Anchors = [akTop, akRight]
            Right = 143
          end
          object cSelectSelected: TTntCheckBox
            Left = 72
            Top = 69
            Width = 129
            Height = 15
            Caption = 'Initially selected'
            TabOrder = 0
            OnClick = cSelectSelectedClick
          end
          object eSelectLabel: ThEdit
            Left = 72
            Top = 16
            Width = 121
            Height = 21
            TabOrder = 1
            ValueChange = eSelectLabelValueChange
            ChangeReason = 'Edit Label'
          end
          object eSelectValue: ThEdit
            Left = 72
            Top = 42
            Width = 121
            Height = 21
            TabOrder = 2
            ValueChange = eSelectValueValueChange
            ChangeReason = 'Edit Value'
          end
        end
      end
      object AnchorPureHTML: TTntTabSheet
        Caption = 'HTML'
        ImageIndex = -1
        OnShow = AnchorPureHTMLShow
        object Label32: TdhLabel
          Left = 8
          Top = 16
          Width = 60
          Height = 13
          Text = 'Type HTML:'
          AutoSizeXY = asXY
        end
        object ePureHTML: ThMemo
          Left = 80
          Top = 8
          Width = 209
          Height = 89
          ScrollBars = ssBoth
          TabOrder = 0
          WantTabs = True
          ChangeReason = 'Edit Direct HTML'
          ValueChange = ePureHTMLValueChange
        end
        object cGenerateContainingElement: TTntCheckBox
          Left = 312
          Top = 8
          Width = 209
          Height = 17
          Caption = 'Generate containing HTML element'
          TabOrder = 1
          OnClick = cGenerateContainingElementClick
        end
      end
      object AnchorFile: TTntTabSheet
        Caption = 'File'
        ImageIndex = -1
        OnShow = AnchorFileShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel7: TPanel
          Left = 8
          Top = 8
          Width = 113
          Height = 81
          TabOrder = 3
          object Button15: TTntButton
            Left = 8
            Top = 8
            Width = 97
            Height = 25
            Caption = 'Load from file'
            TabOrder = 0
            OnClick = Button15Click
          end
          object cLinked: TTntCheckBox
            Left = 8
            Top = 40
            Width = 97
            Height = 17
            Caption = 'Linked'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = cLinkedClick
          end
        end
        object cFileUsage: TTntRadioGroup
          Left = 296
          Top = 16
          Width = 209
          Height = 91
          Caption = 'Use as'
          Items.Strings = (
            'Linkable File'
            'Flash'
            'Background Music'
            'Javascript')
          TabOrder = 0
          OnClick = cFileUsageClick
        end
        object lFileInfo: TdhLabel
          Left = 536
          Top = 8
          Width = 209
          Height = 89
          Style.Border.Style = cbsSolid
          Style.BorderTop.Color = 13160660
          Style.BorderBottom.Color = 4210752
          Style.BorderLeft.Color = 13160660
          Style.BorderRight.Color = 4210752
          Style.Padding = 3
          Style.MarginLeft = '2'
          Style.MarginRight = '7'
          Style.MarginBottom = '7'
          Style.BackgroundColor = 14811135
          Style.Effects.Enabled = True
          Style.Effects.AntiAliasing = False
          Style.Effects.Text = etInclude
          Style.Effects.OuterShadow.Enabled = True
          Style.Effects.OuterShadow.Alpha = 122
          Style.Effects.OuterShadow.Radius = 3
          Style.Effects.OuterShadow.Distance = 4
          AutoSizeXY = asNone
        end
        object dhStyleSheet3: TdhStyleSheet
          Left = 744
          Top = 8
          Width = 28
          Height = 28
          Expanded = False
          ExpandedWidth = 100
          ExpandedHeight = 100
          Expanded = False
          object STYLE_FileInfo: TdhLabel
            Left = 0
            Top = 0
            Height = 12
            Text = 'STYLE_FileInfo'
            Style.FontSize = '10'
            Style.FontFamily = 'Times New Roman, Times, serif'
            AutoSizeXY = asY
            Align = alTop
            Right = 2147483647
          end
        end
        object cLoop: TTntCheckBox
          Left = 768
          Top = 24
          Width = 209
          Height = 17
          Caption = 'Loop'
          TabOrder = 4
          OnClick = cLoopClick
        end
      end
    end
  end
  object FontDialog1: TMyFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 656
    Top = 144
  end
  object OpenPictureDialog1: TMyOpenPictureDialog
    Left = 624
    Top = 144
  end
  object IGNORE_SavePictureDialog1: TMySavePictureDialog
    DefaultExt = 'png'
    Filter = 
      'Portable Network Graphics (*.png)|*.png|GIF Image (*.gif)|*.gif|' +
      'JPEG Image File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bi' +
      'tmaps (*.bmp)|*.bmp'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 528
    Top = 144
  end
  object PopupMenu2: TTntPopupMenu
    Left = 560
    Top = 144
    object mLoadFromFile: TTntMenuItem
      Caption = 'Load from file'
      OnClick = Button15Click
    end
    object mOle: TTntMenuItem
      Caption = 'Edit OLE Content'
      OnClick = mOleClick
    end
    object mPageProperties: TTntMenuItem
      Caption = 'Page Properties'
      OnClick = mPagePropertiesClick
    end
    object mNewPage: TTntMenuItem
      Caption = 'New Page'
      OnClick = dhAnchor8Click
    end
    object mText: TTntMenuItem
      Caption = 'Edit Text'
      OnClick = Button8Click
    end
    object mMenu: TTntMenuItem
      Caption = 'Add menu item'
      OnClick = Button10Click
    end
    object mSubMenu: TTntMenuItem
      Caption = 'Create Submenu'
      Visible = False
      OnClick = mSubMenuClick
    end
    object N6: TTntMenuItem
      Caption = '-'
    end
    object mEdit: TTntMenuItem
      Caption = 'Edit'
      object mCut: TTntMenuItem
        Caption = 'Cut'
        OnClick = mCutClick
      end
      object mCopy: TTntMenuItem
        Caption = 'Copy'
        OnClick = mCopyClick
      end
      object mPaste: TTntMenuItem
        Caption = 'Paste'
        OnClick = mPasteClick
      end
      object mDelete: TTntMenuItem
        Caption = 'Delete'
        OnClick = mDeleteClick
      end
      object mFullCopy: TTntMenuItem
        Caption = 'Full Copy'
        OnClick = mFullCopyClick
      end
    end
    object mAlign: TTntMenuItem
      Caption = 'Align'
      object mAlignToGrid: TTntMenuItem
        Caption = 'Align to Grid'
        OnClick = mAlignToGridClick
      end
      object N8: TTntMenuItem
        Caption = '-'
      end
      object mLeftEdges: TTntMenuItem
        Caption = 'Align to Left Edges'
        OnClick = mLeftEdgesClick
      end
      object mRightEdges: TTntMenuItem
        Caption = 'Align to Right Edges'
        OnClick = mLeftEdgesClick
      end
      object mTopEdges: TTntMenuItem
        Caption = 'Align to Top Edges'
        OnClick = mLeftEdgesClick
      end
      object mBottomEdges: TTntMenuItem
        Caption = 'Align to Bottom Edges'
        OnClick = mLeftEdgesClick
      end
      object N9: TTntMenuItem
        Caption = '-'
      end
      object mEqualHorizontal: TTntMenuItem
        Caption = 'Equal Horizontal Distances'
        OnClick = mEqualHorizontalClick
      end
      object mEqualVertical: TTntMenuItem
        Caption = 'Equal Vertical Distances'
        OnClick = mEqualHorizontalClick
      end
    end
    object mOrder: TTntMenuItem
      Caption = 'Order'
      object mBringToFront: TTntMenuItem
        Caption = 'Bring to front'
        OnClick = mBringToFrontClick
      end
      object mSendToBack: TTntMenuItem
        Caption = 'Send to back'
        OnClick = mSendToBackClick
      end
    end
    object N5: TTntMenuItem
      Caption = '-'
    end
    object mGoto: TTntMenuItem
      Caption = 'Go to'
      object mGotoUse: TTntMenuItem
        Caption = 'Use object'
        OnClick = mGotoUseClick
      end
      object mGotoLink: TTntMenuItem
        Caption = 'Linked page'
        OnClick = mGotoLinkClick
      end
      object mGotoFragment: TTntMenuItem
        Caption = 'Linked fragment'
        OnClick = mGotoFragmentClick
      end
      object mGotoMenu: TTntMenuItem
        Caption = 'Menu'
        OnClick = mGotoMenuClick
      end
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object mSaveImage: TTntMenuItem
      Caption = 'Save As Image'
      OnClick = mSaveImageClick
    end
    object N3: TTntMenuItem
      Caption = '-'
    end
    object mStyles: TTntMenuItem
      Caption = 'Styles'
      object mGetUseStyles: TTntMenuItem
        Caption = 'Get styles from Use object'
        OnClick = mGetUseStylesClick
      end
      object mGetClipboardStyles: TTntMenuItem
        Caption = 'Get styles from object in clipboard'
        OnClick = mGetClipboardStylesClick
      end
      object mPushStylesToUse: TTntMenuItem
        Caption = 'Push styles to Use object'
        OnClick = mPushStylesToUseClick
      end
      object MClearAllStyles: TTntMenuItem
        Caption = 'Clear all styles'
        OnClick = MClearAllStylesClick
      end
      object mExchangeDownAndOverStyles: TTntMenuItem
        Caption = 'Exchange Down<->Over Styles'
        OnClick = mExchangeDownAndOverStylesClick
      end
      object mCopyOverStylesToDownStyles: TTntMenuItem
        Caption = 'Copy Over Styles to Down Styles'
        OnClick = mCopyOverStylesToDownStylesClick
      end
      object N4: TTntMenuItem
        Caption = '-'
      end
      object mStyleInfo: TTntMenuItem
        Caption = 'Show style information'
        OnClick = mStyleInfoClick
      end
    end
  end
  object PopupMenu1: TTntPopupMenu
    Left = 688
    Top = 144
    object mLoadfromHTTPaddress: TTntMenuItem
      Caption = 'Load from HTTP address'
      OnClick = mLoadfromHTTPaddressClick
    end
    object N10: TTntMenuItem
      Caption = '-'
    end
    object mSaveImageToFile: TTntMenuItem
      Caption = 'Save to File'
      OnClick = mSaveImageToFileClick
    end
    object mCopyImage: TTntMenuItem
      Caption = 'Copy Image'
      Visible = False
      OnClick = mCopyImageClick
    end
    object mPasteImage: TTntMenuItem
      Caption = 'Paste Image'
      Visible = False
    end
    object N7: TTntMenuItem
      Caption = '-'
    end
    object mChangeColors: TTntMenuItem
      Caption = 'Change Colors'
      OnClick = mChangeColorsClick
    end
    object MakeTransparent1: TTntMenuItem
      Caption = 'Make background color transparent'
      OnClick = MakeTransparent1Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 464
    Top = 144
  end
  object OpenDialog1: TOpenDialog
    Left = 496
    Top = 144
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      '*.ChangeReason'
      'CODE_*'
      'IGNORE_*'
      'STYLE_*')
    Left = 432
    Top = 144
    LangData = {
      040054616273010100000025010000070043617074696F6E019C010000060050
      616E656C3100000C0050616765436F6E74726F6C3100000A00416E63686F7246
      6F6E74010200000001000000070043617074696F6E2D010000040048696E7400
      090047726F7570426F7833010100000002000000070043617074696F6E000500
      63426F6C64010100000003000000070043617074696F6E000700634974616C69
      63010100000004000000070043617074696F6E000900634F7665726C696E6501
      0100000005000000070043617074696F6E000C00634C696E655468726F756768
      010100000006000000070043617074696F6E000A0063556E6465726C696E6501
      0100000007000000070043617074696F6E000E0049474E4F52455F427574746F
      6E3100000B0063466F6E7446616D696C790000090063466F6E7453697A650000
      090047726F7570426F7835010100000008000000070043617074696F6E001100
      63704261636B67726F756E64436F6C6F72010100000009000000070043617074
      696F6E000B006370466F6E74436F6C6F7201010000000A000000070043617074
      696F6E000C00635472616E73706172656E7401010000000B0000000700436170
      74696F6E00110049474E4F52455F53616D706C65466F6E7400000A0062436C65
      6172466F6E7401010000000C000000070043617074696F6E000C00416E63686F
      72426F7264657201020000000D000000070043617074696F6E2E010000040048
      696E74000E00456467654E617669676174696F6E00000A006345646765526967
      687401010000000E000000040054657874000B006345646765426F74746F6D01
      010000000F0000000400546578740008006345646765546F7001010000001000
      000004005465787400090063456467654C656674010100000011000000040054
      6578740008006345646765416C6C010100000012000000040054657874000800
      646850616E656C3300000C0053616D706C65426F726465720000080064685061
      6E656C350000090047726F7570426F7836010100000013000000070043617074
      696F6E000800736C4D617267696E00000900736C50616464696E670000090073
      7050616464696E670000080073704D617267696E0000080064684C6162656C32
      01010000001400000004005465787400080064684C6162656C36010100000015
      00000004005465787400090047726F7570426F78370101000000160000000700
      43617074696F6E000D006370426F72646572436F6C6F7200000800736C426F72
      6465720000080064684C6162656C330101000000170000000400546578740008
      007370426F7264657200000B006468436F6D626F426F78310101000000180000
      0005004974656D73000A0062436C656172456467650101000000190000000700
      43617074696F6E000D0062426F7264657252616469757301010000001A000000
      070043617074696F6E000D0064685374796C6553686565743200000B00535459
      4C455F4C696E6B3200000F005354594C455F64684C6162656C313000000C0053
      54594C455F4C696E6B313400000D005354594C455F4C6162656C323800000D00
      5354594C455F64684C696E6B3200001000416E63686F724261636B67726F756E
      6401020000001B000000070043617074696F6E2F010000040048696E74000900
      47726F7570426F783901010000001C000000070043617074696F6E0008004275
      74746F6E313101010000001D000000070043617074696F6E000800427574746F
      6E313201010000001E000000070043617074696F6E000800427574746F6E3137
      01010000001F000000070043617074696F6E000800646850616E656C3100000A
      0047726F7570426F783233010100000020000000070043617074696F6E000900
      436F6D626F426F783101010000002200000005004974656D7300080063424746
      69786564010100000023000000070043617074696F6E00090047726F7570426F
      7838010100000024000000070043617074696F6E0007004C6162656C31370101
      0000002500000004005465787400080064684C6162656C380101000000260000
      00040054657874000500736C4247580000120049474E4F52455F6468436F6D62
      6F426F785800000500736C4247590000050073704247590000080064684C6162
      656C39010100000027000000040054657874000B006468436F6D626F426F7834
      01010000002800000005004974656D7300050073704247580000120049474E4F
      52455F6468436F6D626F426F785900000B0062436C656172496D616765010100
      000029000000070043617074696F6E000A00416E63686F724D69736301020000
      002A000000070043617074696F6E31010000040048696E74000A0047726F7570
      426F78323601010000002B000000070043617074696F6E0007004C6162656C31
      3501010000002C0000000400546578740007004C6162656C323401010000002D
      0000000400546578740007004C6162656C333001010000002E00000004005465
      78740008006362437572736F7201010000002F00000005004974656D73000800
      63625A496E64657800000B006362446972656374696F6E010100000030000000
      05004974656D73000A0047726F7570426F783235010100000031000000070043
      617074696F6E0007004C6162656C313601010000003200000004005465787400
      07004C6162656C31380101000000330000000400546578740007004C6162656C
      3132010100000034000000040054657874001400434F44455F63625665727469
      63616C416C69676E00001100434F44455F636254657874496E64656E7400000B
      00636254657874416C69676E01010000003700000005004974656D73000A0047
      726F7570426F783234010100000038000000070043617074696F6E0007004C61
      62656C32350101000000390000000400546578740007004C6162656C32360101
      0000003A0000000400546578740007004C6162656C313301010000003B000000
      040054657874000F006362546578745472616E73666F726D01010000003C0000
      0005004974656D73000C0063625768697465537061636501010000003D000000
      05004974656D73000D006362466F6E7456617269616E7401010000003E000000
      05004974656D73000A0062436C6561724D6F726501010000003F000000070043
      617074696F6E000900624D6F72654D6973630101000000400000000700436170
      74696F6E000D00416E63686F7245666665637473010200000041000000070043
      617074696F6E30010000040048696E74000F006345666665637473456E61626C
      6564010100000042000000070043617074696F6E000A0070636E61765F766572
      7400000B00456666656374734D61696E01010000004300000004005465787400
      0B0045666665637473426C757201010000004400000004005465787400160045
      6666656374735472616E73666F726D6174696F6E730101000000450000000400
      54657874001D00456666656374735472616E73666F726D6174696F6E735F426F
      726465720000090064684C6162656C31320000120045666665637473426C7572
      5F426F7264657200001200456666656374734D61696E5F426F7264657200000F
      00456666656374734D61696E5F746F700000090064684C6162656C313300000A
      0070636E61765F686F727A00000C00456666656374734D61696E320101000000
      46000000040054657874000C0045666665637473426C75723201010000004700
      0000040054657874001700456666656374735472616E73666F726D6174696F6E
      733201010000004800000004005465787400130045666665637473426C757232
      5F426F7264657200001E00456666656374735472616E73666F726D6174696F6E
      73325F426F7264657200001300456666656374734D61696E325F426F72646572
      00001000456666656374734D61696E325F746F700000090064684C6162656C31
      3700001B00456666656374735472616E73666F726D6174696F6E73325F746F70
      0000080070616E656C70633200000C0050616765436F6E74726F6C3200000900
      54616253686565743300000D0063416E7469416C696173696E67010100000049
      000000070043617074696F6E00090063546578744F6E6C7901010000004A0000
      00070043617074696F6E000C00634578636C7564655465787401010000004B00
      0000070043617074696F6E00090054616253686565743800000800646850616E
      656C340000070064684C696E6B3901010000004C000000040054657874000800
      64684C696E6B313201010000004D00000004005465787400080064684C696E6B
      313101010000004E00000004005465787400080064684C696E6B313001010000
      004F00000004005465787400080064684C696E6B313301010000005000000004
      005465787400060050616E656C35000008006C4F706163697479010100000051
      0000000400546578740006006C466C6F6F640101000000520000000400546578
      740009006C44697374616E63650101000000530000000400546578740007006C
      446567726565010100000054000000040054657874000B007370426C7572416C
      70686100000B007370426C7572466C6F6F6400000E007370426C757244697374
      616E636500000C007370426C757244656772656500000B00736C426C7572466C
      6F6F6400000E00736C426C757244697374616E636500000C00736C426C757244
      656772656500000B00736C426C7572416C7068610000060050616E656C360000
      0B006370426C7572436F6C6F72010100000055000000070043617074696F6E00
      07004C6162656C3131010100000056000000040054657874000C007370426C75
      7252616469757300000C00736C426C757252616469757300000C0063426C7572
      456E61626C6564010100000057000000070043617074696F6E00090054616253
      68656574370000060050616E656C33000006004C6162656C3701010000005800
      00000400546578740006004C6162656C38010100000059000000040054657874
      0006004C6162656C3601010000005A0000000400546578740006004C6162656C
      3501010000005B000000040054657874000800736C5368696674580000080073
      7053686966745800000800737053686966745900000800736C53686966745900
      000700736C416E676C65000007007370416E676C6500000D00736C4D61737465
      72416C70686100000D0073704D6173746572416C7068610000070050616E656C
      3331000006004C6162656C3901010000005C0000000400546578740007004C61
      62656C313001010000005D0000000400546578740006004C6162656C33010100
      00005E0000000400546578740006004C6162656C3401010000005F0000000400
      54657874000700736C536B657758000007007370536B65775800000700737053
      6B65775900000700736C536B65775900000800736C5363616C65580000080073
      705363616C65580000080073705363616C655900000800736C5363616C655900
      000D0064685374796C6553686565743100000D005354594C455F4C6162656C31
      3400000B005354594C455F4C696E6B3100000D005354594C455F64684C696E6B
      3700000D005354594C455F4C6162656C333300000F005354594C455F64684C61
      62656C31310000140049474E4F52455F646844697265637448544D4C3100000D
      0062436C65617245666665637473010100000060000000070043617074696F6E
      000A00416E63686F724E616D65010100000061000000070043617074696F6E00
      0A0047726F7570426F783231010100000062000000070043617074696F6E0006
      00496D61676531000007004C6162656C31390101000000630000000400546578
      740007004C6162656C33370101000000640000000400546578740007004C6162
      656C3338010100000065000000040054657874000E0049474E4F52455F4C6162
      656C333900000500654E616D650000080065546F6F6C74697000000A0047726F
      7570426F783138010100000066000000070043617074696F6E0006004C616265
      6C3201010000006700000004005465787400050063625573650000100063446F
      776E4F7665726C61794F766572010100000068000000070043617074696F6E00
      1000634F7665724F7665726C6179446F776E0101000000690000000700436170
      74696F6E000C0063496D616765466F726D617401020000006A00000007004361
      7074696F6E6B00000005004974656D7300100049474E4F52455F63446F416374
      696F6E00000E0049474E4F52455F427574746F6E3900000E00416E63686F7250
      6F736974696F6E01010000006C000000070043617074696F6E00090047726F75
      70426F783401010000006D000000070043617074696F6E00060073704C656674
      000005007370546F700000090064684C6162656C323901010000006E00000004
      005465787400090064684C6162656C333001010000006F000000040054657874
      00090064684C6162656C33310101000000700000000400546578740007007370
      57696474680000090064684C6162656C33320101000000710000000400546578
      74000800737048656967687400000600634175746F5801010000007200000007
      0043617074696F6E000600634175746F59010100000073000000070043617074
      696F6E00090047726F7570426F7831010100000074000000070043617074696F
      6E000500634E6F6E65010100000075000000070043617074696F6E0004006354
      6F70010100000076000000070043617074696F6E000600635269676874010100
      000077000000070043617074696F6E00070063426F74746F6D01010000007800
      0000070043617074696F6E00070063436C69656E740101000000790000000700
      43617074696F6E000500634C65667401010000007A000000070043617074696F
      6E00090047726F7570426F783201010000007B000000070043617074696F6E00
      05006361546F7001010000007C000000070043617074696F6E00070063615269
      67687401010000007D000000070043617074696F6E0008006361426F74746F6D
      01010000007E000000070043617074696F6E00060063614C6566740101000000
      7F000000070043617074696F6E000800646850616E656C3200000E0053616D70
      6C65506F736974696F6E00000A00416E63686F72546578740101000000800000
      00070043617074696F6E0007004C6162656C3331010100000081000000040054
      657874000500655465787400000700427574746F6E3801010000008200000007
      0043617074696F6E001100416E63686F7250616765436F6E74726F6C01010000
      0083000000070043617074696F6E0007004C6162656C33360101000000840000
      0004005465787400020076730000060050616E656C3200000800427574746F6E
      3134010100000085000000070043617074696F6E000B006244656C6574655061
      6765010100000086000000070043617074696F6E000B00624D6F766550616765
      5570010100000087000000070043617074696F6E000D00624D6F766550616765
      446F776E010100000088000000070043617074696F6E000A0047726F7570426F
      783136010100000089000000070043617074696F6E0012006344796E616D6963
      4E617669676174696F6E01010000008A000000070043617074696F6E000C0063
      466978656448656967687401010000008B000000070043617074696F6E000A00
      416E63686F725061676501010000008C000000070043617074696F6E000A0047
      726F7570426F78323201010000008D000000070043617074696F6E0009006468
      4C6162656C313601010000008E000000040054657874000600655469746C6500
      001000654F75747075744469726563746F72790000080064684C6162656C3401
      010000008F000000040054657874000A00675363726F6C6C696E670102000000
      90000000070043617074696F6E9100000005004974656D73000A006748544D4C
      4672616D65010200000092000000070043617074696F6E930000000500497465
      6D73000700427574746F6E33010100000094000000070043617074696F6E000A
      00416E63686F7245646974010100000095000000070043617074696F6E000A00
      47726F7570426F783135010100000096000000070043617074696F6E00050065
      4564697400000A0047726F7570426F7832300101000000970000000700436170
      74696F6E00090063526561644F6E6C7901010000009800000007004361707469
      6F6E0009006350617373776F7264010100000099000000070043617074696F6E
      000A00416E63686F724D656D6F01010000009A000000070043617074696F6E00
      07004C6162656C333501010000009B000000040054657874000500654D656D6F
      00000A0047726F7570426F78323901010000009C000000070043617074696F6E
      000D00634D656D6F526561644F6E6C7901010000009D00000007004361707469
      6F6E000500635772617001010000009E000000070043617074696F6E000E0041
      6E63686F72436865636B426F7801010000009F000000070043617074696F6E00
      140049474E4F52455F6352696768744A75737469667900000900726743686563
      6B65640102000000A1000000070043617074696F6EA200000005004974656D73
      000A0047726F7570426F7833330101000000A3000000070043617074696F6E00
      0B0065436865636B56616C756500000A00416E63686F72466F726D0101000000
      AD000000070043617074696F6E00080063624D6574686F640102000000AE0000
      00070043617074696F6EAF00000005004974656D73000A0047726F7570426F78
      33300101000000B0000000070043617074696F6E00090064684C6162656C3236
      0101000000B100000004005465787400070065416374696F6E0000080064684C
      6162656C370101000000B2000000040054657874001000434F44455F65466F72
      6D54617267657400000A00416E63686F724D656E750101000000B40000000700
      43617074696F6E000A0047726F7570426F7831340101000000B6000000070043
      617074696F6E00070063496E6C696E650101000000B700000007004361707469
      6F6E000B0063526573756D654F70656E0101000000B800000007004361707469
      6F6E000700635374617469630101000000B9000000070043617074696F6E0011
      0063486F72697A6F6E74616C4C61796F75740101000000BA0000000700436170
      74696F6E000E00436865636B47726F7570426F78310101000000BB0000000700
      43617074696F6E000E0049474E4F52455F4C6162656C3230000007004C616265
      6C32310101000000BD000000040054657874000C007370536C69646550697865
      6C0000060063536C6964650101000000BE000000070043617074696F6E000A00
      47726F7570426F7833320101000000BF000000070043617074696F6E000E0049
      474E4F52455F4C6162656C3232000010006362506172656E744D656E75497465
      6D00000B00634F70656E42794F7665720101000000C100000007004361707469
      6F6E000E0073705265616374696F6E54696D6500000800427574746F6E313001
      01000000C2000000070043617074696F6E000A00416E63686F724C696E6B0101
      000000C3000000070043617074696F6E000A0047726F7570426F783131010100
      0000C4000000070043617074696F6E00090064684C6162656C31340101000000
      C5000000040054657874000A0063624C696E6B5061676500000C0063624C696E
      6B416E63686F720000090064684C6162656C31350101000000C6000000040054
      657874000A0047726F7570426F7832380101000000C700000007004361707469
      6F6E00090064684C6162656C31390101000000C8000000040054657874000800
      64684C6162656C310101000000C9000000040054657874000C00434F44455F65
      54617267657400000A00434F44455F654C696E6B00000A0047726F7570426F78
      31330101000000CC000000070043617074696F6E000B0063446F776E49664D65
      6E750101000000CD000000070043617074696F6E00100063446F776E49664D6F
      757365446F776E0101000000CE000000070043617074696F6E000B0063446F77
      6E49664F7665720101000000CF000000070043617074696F6E00050063446F77
      6E0101000000D0000000070043617074696F6E000A0063446F776E496655726C
      0101000000D1000000070043617074696F6E000900634C696E6B4175746F0101
      000000D2000000070043617074696F6E00030070707000000B00634C696E6B4C
      61796F75740102000000D3000000070043617074696F6ED40000000500497465
      6D73000900634C696E6B466F726D0102000000D5000000070043617074696F6E
      D600000005004974656D73000C00416E63686F7248696464656E0101000000DD
      000000070043617074696F6E000A0047726F7570426F7833310101000000DE00
      0000070043617074696F6E000C006548696464656E4669656C6400000900416E
      63686F724F6C650101000000DF000000070043617074696F6E00070042757474
      6F6E320101000000E0000000070043617074696F6E000700427574746F6E3401
      01000000E1000000070043617074696F6E001100635472616E73706172656E74
      57686974650101000000E2000000070043617074696F6E000D0049474E4F5245
      5F63557361676500000700427574746F6E360101000000E50000000700436170
      74696F6E000C00416E63686F7253656C6563740101000000E600000007004361
      7074696F6E000A0047726F7570426F7831390101000000E70000000700436170
      74696F6E000900634D756C7469706C650101000000E800000007004361707469
      6F6E0009006344726F70446F776E0101000000E9000000070043617074696F6E
      000500634C6973740101000000EA000000070043617074696F6E00060050616E
      656C3400000700427574746F6E350101000000EB000000070043617074696F6E
      000B00624D6F76654974656D55700101000000EC000000070043617074696F6E
      000D00624D6F76654974656D446F776E0101000000ED00000007004361707469
      6F6E000B006244656C6574654974656D0101000000EE00000007004361707469
      6F6E000900646853656C6563743100000A0047726F7570426F78313201010000
      00EF000000070043617074696F6E0007004C6162656C32390101000000F00000
      000400546578740007004C6162656C33340101000000F1000000040054657874
      000F006353656C65637453656C65637465640101000000F20000000700436170
      74696F6E000C006553656C6563744C6162656C00000C006553656C6563745661
      6C756500000E00416E63686F725075726548544D4C0101000000F30000000700
      43617074696F6E0007004C6162656C33320101000000F4000000040054657874
      000900655075726548544D4C00001A006347656E6572617465436F6E7461696E
      696E67456C656D656E740101000000F5000000070043617074696F6E000A0041
      6E63686F7246696C650101000000F6000000070043617074696F6E0006005061
      6E656C3700000800427574746F6E31350101000000F700000007004361707469
      6F6E000700634C696E6B65640101000000F8000000070043617074696F6E000A
      006346696C6555736167650102000000F9000000070043617074696F6EFA0000
      0005004974656D730009006C46696C65496E666F00000D0064685374796C6553
      686565743300000E005354594C455F46696C65496E666F00000500634C6F6F70
      0101000000FE000000070043617074696F6E000B00466F6E744469616C6F6731
      000012004F70656E506963747572654469616C6F67310001050000000C005069
      637475726550616E656C00000C00506963747572654C6162656C00000D005072
      6576696577427574746F6E0101000000FF000000040048696E74000A00506169
      6E7450616E656C000008005061696E74426F780000190049474E4F52455F5361
      7665506963747572654469616C6F67310001050000000C005069637475726550
      616E656C00000C00506963747572654C6162656C00000D005072657669657742
      7574746F6E00000A005061696E7450616E656C000008005061696E74426F7800
      000A00506F7075704D656E753200000D006D4C6F616446726F6D46696C650101
      00000003010000070043617074696F6E0004006D4F6C65010100000004010000
      070043617074696F6E000F006D5061676550726F706572746965730101000000
      05010000070043617074696F6E0008006D4E6577506167650101000000060100
      00070043617074696F6E0005006D546578740101000000070100000700436170
      74696F6E0005006D4D656E75010100000008010000070043617074696F6E0008
      006D5375624D656E75010100000009010000070043617074696F6E0002004E36
      000006006D416C69676E01010000000A010000070043617074696F6E000C006D
      416C69676E546F4772696401010000000B010000070043617074696F6E000200
      4E3800000A006D4C656674456467657301010000000C01000007004361707469
      6F6E000B006D5269676874456467657301010000000D01000007004361707469
      6F6E0009006D546F70456467657301010000000E010000070043617074696F6E
      000C006D426F74746F6D456467657301010000000F010000070043617074696F
      6E0002004E39000010006D457175616C486F72697A6F6E74616C010100000010
      010000070043617074696F6E000E006D457175616C566572746963616C010100
      000011010000070043617074696F6E0002004E3500000D006D4272696E67546F
      46726F6E74010100000012010000070043617074696F6E000B006D53656E6454
      6F4261636B010100000013010000070043617074696F6E0005006D476F746F01
      0100000014010000070043617074696F6E0008006D476F746F55736501010000
      0015010000070043617074696F6E0009006D476F746F4C696E6B010100000016
      010000070043617074696F6E000D006D476F746F467261676D656E7401010000
      0017010000070043617074696F6E0002004E3200000A006D53617665496D6167
      65010100000018010000070043617074696F6E0002004E33000007006D537479
      6C6573010100000019010000070043617074696F6E000D006D47657455736553
      74796C657301010000001A010000070043617074696F6E0013006D476574436C
      6970626F6172645374796C657301010000001B010000070043617074696F6E00
      10006D507573685374796C6573546F55736501010000001C0100000700436170
      74696F6E000F004D436C656172416C6C5374796C657301010000001D01000007
      0043617074696F6E001A006D45786368616E6765446F776E416E644F76657253
      74796C657301010000001E010000070043617074696F6E0002004E3400000A00
      6D5374796C65496E666F01010000001F010000070043617074696F6E000A0050
      6F7075704D656E7531000014006D4C6F616466726F6D48545450616464726573
      73010100000020010000070043617074696F6E0003004E3130000010006D5361
      7665496D616765546F46696C65010100000021010000070043617074696F6E00
      0A006D436F7079496D616765010100000022010000070043617074696F6E000B
      006D5061737465496D616765010100000023010000070043617074696F6E0002
      004E3700000D006D4368616E6765436F6C6F7273010100000024010000070043
      617074696F6E000B00536176654469616C6F673100000B004F70656E4469616C
      6F6731000006006D4F72646572010100000026010000070043617074696F6E00
      05006D45646974010100000027010000070043617074696F6E0004006D437574
      010100000028010000070043617074696F6E0005006D436F7079010100000029
      010000070043617074696F6E0007006D44656C65746501010000002A01000007
      0043617074696F6E0006006D506173746501010000002B010000070043617074
      696F6E0009006D46756C6C436F707901010000002C010000070043617074696F
      6E0009006D476F746F4D656E75010100000033010000070043617074696F6E00
      0900634D656E754175746F010100000034010000070043617074696F6E001000
      4D616B655472616E73706172656E743101010000003501000007004361707469
      6F6E001B006D436F70794F7665725374796C6573546F446F776E5374796C6573
      010100000036010000070043617074696F6E00}
  end
end
