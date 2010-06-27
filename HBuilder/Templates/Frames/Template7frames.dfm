object PageContainer3: TPageContainer3
  Left = -4
  Top = -23
  Width = 1032
  Height = 519
  Caption = 'Template7frames.dfm'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 19
  object index: TdhPage
    Left = 0
    Top = 0
    Style.BackgroundColor = Black
    Style.FontFamily = 'Times New Roman'
    Style.Color = White
    AutoSizeXY = asNone
    UseIFrame = False
    Scrolling = scNo
    DesignSize = (
      1024
      492)
    Right = 0
    Bottom = 0
    GeneratedCSSFile = 'dfm2html.css'
    object Panel1: TdhPanel
      Top = 64
      Width = 760
      Style.Border.Width = 2
      Style.Border.Color = Yellow
      Style.Border.Style = cbsSolid
      Style.Margin = '20'
      Style.BackgroundColor = 3223857
      Style.BorderRadius.All = '31'
      AutoSizeXY = asNone
      Anchors = [akTop, akBottom]
      DesignSize = (
        760
        416)
      Bottom = 12
      object Link3: TdhLink
        Left = 88
        Top = 0
        Width = 150
        Height = 83
        Text = 'Home'
        Use = Link2
        AutoSizeXY = asY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page1
      end
      object Link4: TdhLink
        Left = 192
        Top = 0
        Width = 150
        Height = 83
        Text = 'News'
        Use = Link2
        AutoSizeXY = asY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page2
      end
      object Link5: TdhLink
        Left = 296
        Top = 0
        Width = 150
        Height = 83
        Text = 'Links'
        Use = Link2
        AutoSizeXY = asY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page3
      end
      object Link6: TdhLink
        Left = 400
        Top = 0
        Width = 150
        Height = 83
        Text = 'Photos'
        Use = Link2
        AutoSizeXY = asY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page4
      end
      object Link7: TdhLink
        Left = 504
        Top = 0
        Width = 150
        Height = 83
        Text = 'Contact'
        Use = Link2
        AutoSizeXY = asY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page5
      end
      object StyleSheet1: TdhStyleSheet
        Left = 448
        Top = 72
        Width = 28
        Height = 28
        Expanded = False
        ExpandedWidth = 248
        ExpandedHeight = 176
        Expanded = False
        object Link2: TdhLink
          Left = 0
          Top = 0
          Height = 106
          Text = 'menu item'
          Style.Border.Width = 2
          Style.Border.Color = Yellow
          Style.BorderBottom.Style = cbsSolid
          Style.BorderLeft.Style = cbsSolid
          Style.BorderRight.Style = cbsSolid
          Style.Padding = 20
          Style.PaddingTop = 9
          Style.PaddingBottom = 9
          Style.Margin = '20'
          Style.MarginLeft = '15'
          Style.MarginRight = '15'
          Style.BackgroundColor = Black
          Style.TextAlign = ctaCenter
          Style.Cursor = ccuPointer
          Style.FontFamily = 'Whimsy TT, Comic Sans MS'
          Style.Color = Yellow
          Style.FontWeight = cfwBold
          Style.ZIndex = 0
          Style.Effects.Enabled = True
          Style.Effects.AntiAliasing = True
          Style.Effects.Text = etInclude
          Style.Effects.OuterShadow.Enabled = True
          Style.BorderRadius.BottomRight = '26'
          Style.BorderRadius.BottomLeft = '26'
          AutoSizeXY = asXY
          Align = alTop
          StyleDown.BackgroundColor = Yellow
          StyleDown.Color = Black
          StyleDown.ZIndex = 1
          StyleDown.Effects.Enabled = True
          StyleDown.Effects.AntiAliasing = True
          StyleDown.Effects.Text = etInclude
          StyleDown.Effects.OuterShadow.Enabled = True
          StyleDown.Effects.InnerGlow.Enabled = True
          StyleDown.Effects.InnerGlow.Radius = 2
          StyleDown.Effects.InnerGlow.Flood = 100
          StyleDown.Effects.OuterGlow.Enabled = True
          StyleDown.Effects.OuterGlow.Alpha = 255
          StyleDown.Effects.OuterGlow.Radius = 20
          StyleDown.Effects.OuterGlow.Flood = 28
          StyleDown.BorderRadius.TopLeft = '3'
          StyleDown.BorderRadius.TopRight = '3'
          Layout = ltText
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfURL]
          Right = -48
        end
        object Label1: TdhLabel
          Left = 0
          Top = 83
          Height = 33
          Text = 'Caption'
          Style.FontSize = '24'
          Style.FontFamily = 'Whimsy TT, Comic Sans MS'
          AutoSizeXY = asY
          Align = alTop
          Right = 2147483647
        end
      end
      object Page6: TdhPage
        Left = 33
        Top = 83
        Width = 688
        AutoSizeXY = asNone
        Anchors = [akLeft, akTop, akBottom]
        UseIFrame = False
        Bottom = 40
        object PageControl1: TdhPageControl
          Left = 56
          Top = 72
          Width = 24
          Height = 24
          ActivePage = Page1
          FixedHeight = False
          object Page1: TdhPage
            Left = 0
            Top = 0
            Width = 590
            Height = 536
            AutoSizeXY = asNone
            UseIFrame = False
            object Label2: TdhLabel
              Left = 96
              Top = 16
              Width = 73
              Height = 33
              Text = 'HOME'
              Use = Label1
              AutoSizeXY = asXY
            end
            object Label3: TdhLabel
              Left = 96
              Top = 64
              Width = 416
              Height = 399
              Text = 
                'This template uses a frame layout, the scrollable container is o' +
                'bject <b>Page6</b>. The height of the rounded yellow outer recta' +
                'ngle, <b>Panel1</b>, adjusts to the height of the browser window' +
                ' and is horizontally centered (see settings in the <nobr><b>Pos.' +
                '</b> tab &rarr; <b>Keep distance constant to</b></nobr>). '#10'The c' +
                'ontained object <b>Page6</b> adjust its height in the same way. ' +
                #10'<br/><br/>'#10'The menu items are styled by object <b>Link2</b>. Th' +
                'e yellow glow effects are set in the <b>Effects </b> tab for the' +
                ' <b>Down</b> state of <b>Link2</b>. When a menu item is in a <b>' +
                'Down </b>state, it is pushed in front of the other menu items vi' +
                'a a z-index value of 1 in the <b>Misc </b>tab.'#10'<br/><br/>'#10'Anothe' +
                'r visual menu effect can be achieved by setting the z-index valu' +
                'e to -1 (or to 0) instead of 1 for <b>Link2</b> in the <b>Down</' +
                'b> state. This variation requires additionally the option <b>Sem' +
                'i-transparent PNG</b> to be selected for <b>Link2</b> in the <b>' +
                'Main</b> tab to correctly display the menu items in generated HT' +
                'ML pages.'#10'GIF is the default format for generated images, but a ' +
                'GIF image cannot be semi-transparent. So a glowing menu item app' +
                'earing behind other menu items is not visible in the shadow area' +
                ' of the menu items to the left and to the right side unless shin' +
                'ing-through semi-transparent PNG images are used.'
              AutoSizeXY = asY
            end
          end
          object Page2: TdhPage
            Left = 0
            Top = 0
            Width = 590
            Height = 136
            AutoSizeXY = asNone
            UseIFrame = False
            object Label5: TdhLabel
              Left = 96
              Top = 16
              Width = 66
              Height = 29
              Text = 'News'
              Use = Label1
              AutoSizeXY = asXY
            end
          end
          object Page3: TdhPage
            Left = 0
            Top = 0
            Width = 590
            Height = 136
            AutoSizeXY = asNone
            UseIFrame = False
            object Label6: TdhLabel
              Left = 96
              Top = 16
              Width = 63
              Height = 29
              Text = 'Links'
              Use = Label1
              AutoSizeXY = asXY
            end
          end
          object Page4: TdhPage
            Left = 0
            Top = 0
            Width = 590
            Height = 136
            AutoSizeXY = asNone
            UseIFrame = False
            object Label7: TdhLabel
              Left = 96
              Top = 16
              Width = 87
              Height = 29
              Text = 'Photos'
              Use = Label1
              AutoSizeXY = asXY
            end
          end
          object Page5: TdhPage
            Left = 0
            Top = 0
            Width = 590
            Height = 152
            AutoSizeXY = asNone
            UseIFrame = False
            object Label8: TdhLabel
              Left = 96
              Top = 16
              Width = 100
              Height = 29
              Text = 'Contact'
              Use = Label1
              AutoSizeXY = asXY
            end
          end
        end
      end
    end
    object Label26: TdhLabel
      Top = 10
      Width = 321
      Height = 54
      Text = 'Welcome to my<i><big><big> homepage</big></big></i>'
      Style.FontSize = '18'
      Style.Margin = '3'
      Style.FontFamily = 'Whimsy TT, Comic Sans MS'
      Style.Color = Red
      Style.FontWeight = cfwBold
      Style.ZIndex = 11
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
      Anchors = [akTop]
    end
  end
end
