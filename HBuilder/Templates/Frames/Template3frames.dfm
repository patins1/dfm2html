object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Width = 1032
  Height = 519
  Caption = 'Template3frames.dfm'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Arial'
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
    Width = 1024
    Height = 492
    Style.BackgroundColor = 16777162
    AutoSizeXY = asNone
    UseIFrame = False
    Scrolling = scNo
    DesignSize = (
      1024
      492)
    object Panel3: TdhPanel
      Top = 0
      Width = 120
      Height = 492
      Use = Label2
      AutoSizeXY = asNone
      Align = alRight
      Right = 0
      object Link7: TdhLink
        Left = 26
        Top = 120
        Width = 55
        Height = 28
        Text = 'Home'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page2
      end
      object Link8: TdhLink
        Left = 26
        Top = 152
        Width = 54
        Height = 28
        Text = 'News'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page4
      end
      object Link9: TdhLink
        Left = 26
        Top = 184
        Width = 50
        Height = 28
        Text = 'Links'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page5
      end
      object Link10: TdhLink
        Left = 26
        Top = 216
        Width = 61
        Height = 28
        Text = 'Photos'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page6
      end
      object Link11: TdhLink
        Left = 26
        Top = 248
        Width = 71
        Height = 28
        Text = 'Contact'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page7
      end
    end
    object Panel2: TdhPanel
      Left = 0
      Top = 0
      Width = 120
      Height = 492
      Use = Label2
      AutoSizeXY = asNone
      Align = alLeft
      DesignSize = (
        120
        492)
      object Link1: TdhLink
        Top = 120
        Width = 55
        Height = 28
        Text = 'Home'
        Use = Link2
        AutoSizeXY = asXY
        Anchors = [akTop, akRight]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page2
        Right = 25
      end
      object Link3: TdhLink
        Top = 152
        Width = 54
        Height = 28
        Text = 'News'
        Use = Link2
        AutoSizeXY = asXY
        Anchors = [akTop, akRight]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page4
        Right = 25
      end
      object Link4: TdhLink
        Top = 184
        Width = 50
        Height = 28
        Text = 'Links'
        Use = Link2
        AutoSizeXY = asXY
        Anchors = [akTop, akRight]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page5
        Right = 25
      end
      object Link5: TdhLink
        Top = 216
        Width = 61
        Height = 28
        Text = 'Photos'
        Use = Link2
        AutoSizeXY = asXY
        Anchors = [akTop, akRight]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page6
        Right = 25
      end
      object Link6: TdhLink
        Top = 248
        Width = 71
        Height = 28
        Text = 'Contact'
        Use = Link2
        AutoSizeXY = asXY
        Anchors = [akTop, akRight]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page7
        Right = 25
      end
    end
    object Panel1: TdhPanel
      Left = 64
      Top = -56
      Width = 895
      Height = 152
      Style.Border.Width = 4
      Style.Border.Color = 8404992
      Style.Border.Style = cbsSolid
      Style.Margin = '8'
      Style.BackgroundColor = Aqua
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.TextOnly = False
      Style.Effects.OuterShadow.Enabled = True
      Style.BorderRadius.All = '54'
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight]
      DesignSize = (
        895
        152)
      Right = 65
      object Label1: TdhLabel
        Top = 72
        Width = 353
        Height = 45
        Text = 'Welcome to my<i><big><big> homepage</big></big></i>'
        Style.PaddingRight = 30
        Style.FontSize = '18'
        Style.Margin = '3'
        Style.Color = 8404992
        Style.FontWeight = cfwBold
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.TextOnly = False
        AutoSizeXY = asXY
        Anchors = [akTop]
      end
    end
    object StyleSheet1: TdhStyleSheet
      Left = 150
      Top = 149
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 216
      ExpandedHeight = 112
      Expanded = False
      object Link2: TdhLink
        Left = 0
        Top = 0
        Width = 198
        Height = 28
        Text = 'Link'
        Style.Padding = 2
        Style.FontSize = '18'
        Style.MarginRight = '4'
        Style.Cursor = ccuPointer
        Style.FontFamily = 'Comic Sans MS'
        Style.Color = 13434879
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.TextOnly = False
        Style.Effects.OuterGlow.Enabled = True
        Style.Effects.OuterGlow.Alpha = 255
        Style.Effects.OuterGlow.Radius = 2
        Style.Effects.OuterGlow.Color = 856176
        Style.Effects.OuterGlow.Flood = 87
        AutoSizeXY = asXY
        Align = alTop
        StyleOver.FontWeight = cfwBold
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Label2: TdhLabel
        Left = 0
        Top = 28
        Width = 198
        Height = 18
        Text = 'Sidebars'
        Style.Border.Width = 5
        Style.Border.Color = 8404992
        Style.BorderLeft.Style = cbsSolid
        Style.BorderRight.Style = cbsSolid
        Style.BackgroundColor = Blue
        AutoSizeXY = asY
        Align = alTop
      end
      object Label10: TdhLabel
        Left = 0
        Top = 46
        Width = 198
        Height = 21
        Text = 'Section'
        Style.FontSize = '18'
        Style.Color = 8404992
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
        Align = alTop
      end
    end
    object Page3: TdhPage
      Left = 120
      Top = 104
      Width = 784
      Height = 388
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight, akBottom]
      UseIFrame = False
      DesignSize = (
        784
        388)
      Right = 120
      Bottom = 0
      object PageControl1: TdhPageControl
        Left = 96
        Top = 0
        Width = 24
        Height = 24
        ActivePage = Page2
        FixedHeight = False
        object Page2: TdhPage
          Top = 0
          Width = 520
          Height = 780
          AutoSizeXY = asNone
          Anchors = [akTop]
          UseIFrame = False
          object Label5: TdhLabel
            Left = 16
            Top = 56
            Width = 472
            Height = 180
            Text = 
              'The pages of this template are linked by two navigation bars, on' +
              'e on the left and one on the right side. This template includes ' +
              'no pictures, so you can change any color of any object.'#10'<br>'#10'<br' +
              '>'#10'The single pages and the Welcome message are centered to bette' +
              'r fill out the space. If you think one navigation bar is enough ' +
              'you can delete the right or left one.'#10'<br><br>'#10'The stylesheet in' +
              'cludes styles for the navigation bars'#39' links and'#10'for the navigat' +
              'ion bars themselves.'
            AutoSizeXY = asY
          end
          object Label3: TdhLabel
            Left = 16
            Top = 16
            Width = 123
            Height = 21
            Text = 'Home Section'
            Use = Label10
            AutoSizeXY = asXY
          end
        end
        object Page4: TdhPage
          Top = 0
          Width = 520
          Height = 280
          AutoSizeXY = asNone
          Anchors = [akTop]
          UseIFrame = False
          object Label6: TdhLabel
            Left = 16
            Top = 16
            Width = 120
            Height = 21
            Text = 'News Section'
            Use = Label10
            AutoSizeXY = asXY
          end
        end
        object Page5: TdhPage
          Top = 0
          Width = 520
          Height = 296
          AutoSizeXY = asNone
          Anchors = [akTop]
          UseIFrame = False
          object Label7: TdhLabel
            Left = 16
            Top = 16
            Width = 118
            Height = 21
            Text = 'Links Section'
            Use = Label10
            AutoSizeXY = asXY
          end
        end
        object Page6: TdhPage
          Top = 0
          Width = 520
          Height = 980
          AutoSizeXY = asNone
          Anchors = [akTop]
          UseIFrame = False
          object Label8: TdhLabel
            Left = 16
            Top = 16
            Width = 132
            Height = 21
            Text = 'Photos Section'
            Use = Label10
            AutoSizeXY = asXY
          end
        end
        object Page7: TdhPage
          Top = 0
          Width = 520
          Height = 304
          AutoSizeXY = asNone
          Anchors = [akTop]
          UseIFrame = False
          object Label9: TdhLabel
            Left = 16
            Top = 16
            Width = 138
            Height = 21
            Text = 'Contact Section'
            Use = Label10
            AutoSizeXY = asXY
          end
        end
      end
    end
  end
end
