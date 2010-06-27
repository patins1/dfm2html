object PageContainer1: TPageContainer1
  Left = -4
  Top = -23
  Width = 1032
  Height = 519
  Caption = 'Template8.dfm'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Verdana'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 18
  object index: TdhPage
    Left = 0
    Top = 0
    Style.BackgroundImage.Data = {
      0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
      0001EC08020000009CDA5036000000F24944415478DA7DC3D91281600080D1F1
      FE2F65C95A21B4D382EC51DAECDCBAF9BF33736AF57ABDF6BFD168E066B3895B
      AD16962409B7DB6DE14EA783BBDD2EEEF57AB8DFEFE3C160202CCB32561405AB
      AA8A87C3211E8D46C2E3F1186B9A862793099E4EA7C2B3D90CEBBA8E0DC3C0A6
      6962CBB2846DDBC68EE360D775F17C3EC78BC542D8F33CECFB3E0E8200876188
      97CBA5F06AB5C2EBF51A475184379B0DDE6EB7C2BBDD0EEFF77B7C381CF0F178
      C4A7D349388E637C3E9FF1E572C1499208A7698AAFD72BCEB20CE7798E8BA210
      2ECB125755856FB71BBEDFEFF8F178083F9F4FFC7ABDF0FBFDC69FCF077FBFDF
      FF3F70800AD68ACB41F50000000049454E44AE426082}
    Style.BackgroundRepeat = cbrRepeatX
    AutoSizeXY = asNone
    UseIFrame = False
    Scrolling = scYes
    DesignSize = (
      1024
      492)
    Right = 0
    Bottom = 0
    GeneratedCSSFile = 'dfm2html.css'
    object StyleSheet1: TdhStyleSheet
      Left = 24
      Top = 168
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 208
      ExpandedHeight = 152
      Expanded = False
      object Label1: TdhLabel
        Left = 0
        Top = 0
        Height = 69
        Text = 'Label1'
        Style.Border.Width = 12
        Style.Border.Color = Yellow
        Style.Border.Style = cbsSolid
        Style.Margin = '27'
        Style.MarginLeft = '0'
        Style.MarginTop = '0'
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        Style.Effects.OuterShadow.Enabled = True
        Style.Effects.OuterShadow.Alpha = 143
        Style.Effects.OuterShadow.Degree = 127
        Style.Effects.OuterShadow.Distance = 9
        Style.BorderRadius.All = '200'
        AutoSizeXY = asY
        Align = alTop
        Right = -25
      end
      object Link1: TdhLink
        Left = 0
        Top = 69
        Height = 79
        Text = 'Link1'
        Style.Padding = 5
        Style.PaddingLeft = 20
        Style.PaddingRight = 19
        Style.BackgroundColor = Red
        Style.Cursor = ccuPointer
        Style.Color = Yellow
        Style.BorderRadius.BottomLeft = '0'
        Style.BorderRadius.TopRight = '0'
        Use = Label1
        AutoSizeXY = asXY
        Align = alTop
        StyleDown.Border.Color = Red
        StyleDown.BackgroundColor = Yellow
        StyleDown.Cursor = ccuDefault
        StyleDown.Color = Red
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfURL]
        Right = -64
      end
      object Label4: TdhLabel
        Left = 0
        Top = 148
        Height = 29
        Text = 'Section'
        Style.FontSize = '24'
        Style.Color = Red
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
        Align = alTop
        Right = 2147483647
      end
    end
    object Panel2: TdhPanel
      Top = 24
      Width = 776
      Height = 732
      AutoSizeXY = asNone
      Anchors = [akTop]
      object Link2: TdhLink
        Left = 16
        Top = 8
        Width = 137
        Height = 79
        Text = 'Home'
        Use = Link1
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page1
      end
      object Link3: TdhLink
        Left = 122
        Top = 8
        Width = 134
        Height = 79
        Text = 'News'
        Use = Link1
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page2
      end
      object Link4: TdhLink
        Left = 225
        Top = 8
        Width = 132
        Height = 79
        Text = 'Links'
        Use = Link1
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page3
      end
      object Panel1: TdhPanel
        Left = 16
        Top = 61
        Width = 752
        Height = 664
        Style.ZIndex = 1
        Style.BorderRadius.TopLeft = '0'
        Style.BorderRadius.BottomRight = '0'
        Use = Label1
        AutoSizeXY = asNone
        object PageControl1: TdhPageControl
          Left = 72
          Top = 56
          Width = 24
          Height = 24
          ActivePage = Page1
          FixedHeight = False
          object Page1: TdhPage
            Left = 80
            Top = 64
            Width = 568
            Height = 512
            AutoSizeXY = asNone
            UseIFrame = False
            object Label3: TdhLabel
              Left = 16
              Top = 16
              Width = 77
              Height = 29
              Text = 'Home'
              Use = Label4
              AutoSizeXY = asXY
            end
            object Label5: TdhLabel
              Left = 16
              Top = 72
              Width = 528
              Height = 396
              Text = 
                'This template has a frameless layout. It makes use of rounded co' +
                'rners for the navigation links and for object <b>Panel1</b>. The' +
                ' rounded corners and the shadow effect is defined by object <b>L' +
                'abel1</b>. Object <b>Link1</b> refine these styles to be used by' +
                ' the menu items.'#10'<br/><br/>'#10'Object <b>Panel1</b> contains altern' +
                'ative pages managed by <b>PageControl1</b>. Object <b>Panel1</b>' +
                ' defines a z-index value of 1 in the <b>Misc</b> tab, so that th' +
                'e shadows of the navigation links appear behind <b>Panel1</b>.'#10'<' +
                'br/><br/>'#10'You can add a new navigation link by copying&pasting a' +
                'n existing navigation link.'#10'Note that when you reorder the navig' +
                'ation links horizontally, a shadow may be dropped from one link ' +
                'object onto another. If this is the case, you can perform <nobr>' +
                '<b>Bring to front</b></nobr> from the context menu of the shadow' +
                'ed link.'#10'<br/><br/>'#10'In order to center both the navigation items' +
                ' and object <b>Panel1</b>, they are put into the parent object <' +
                'b>Panel2</b>, for which <nobr><b>Left parent edge</b></nobr> and' +
                ' <nobr><b>Right parent edge</b></nobr> are unchecked in the <b>P' +
                'os</b> tab.'
              AutoSizeXY = asY
            end
          end
          object Page2: TdhPage
            Left = 80
            Top = 64
            Width = 568
            Height = 240
            AutoSizeXY = asNone
            UseIFrame = False
            object Label6: TdhLabel
              Left = 16
              Top = 16
              Width = 74
              Height = 29
              Text = 'News'
              Use = Label4
              AutoSizeXY = asXY
            end
          end
          object Page3: TdhPage
            Left = 80
            Top = 64
            Width = 568
            Height = 240
            AutoSizeXY = asNone
            UseIFrame = False
            object Label7: TdhLabel
              Left = 16
              Top = 16
              Width = 70
              Height = 29
              Text = 'Links'
              Use = Label4
              AutoSizeXY = asXY
            end
          end
          object Page4: TdhPage
            Left = 80
            Top = 64
            Width = 568
            Height = 1240
            AutoSizeXY = asNone
            UseIFrame = False
            object Label8: TdhLabel
              Left = 16
              Top = 16
              Width = 92
              Height = 29
              Text = 'Photos'
              Use = Label4
              AutoSizeXY = asXY
            end
          end
          object Page5: TdhPage
            Left = 80
            Top = 64
            Width = 568
            Height = 240
            AutoSizeXY = asNone
            UseIFrame = False
            object Label9: TdhLabel
              Left = 16
              Top = 16
              Width = 102
              Height = 29
              Text = 'Contact'
              Use = Label4
              AutoSizeXY = asXY
            end
          end
        end
      end
      object Link5: TdhLink
        Left = 326
        Top = 8
        Width = 146
        Height = 79
        Text = 'Photos'
        Use = Link1
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page4
      end
      object Link6: TdhLink
        Left = 441
        Top = 8
        Width = 153
        Height = 79
        Text = 'Contact'
        Use = Link1
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page5
      end
    end
  end
end
