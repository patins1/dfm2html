object PageContainer1: TPageContainer1
  Left = -4
  Top = -23
  Width = 1608
  Height = 751
  Caption = 'Template2.dfm'
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
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    DesignSize = (
      1600
      724)
    object PageControl1: TdhPageControl
      Left = 8
      Top = 105
      Width = 24
      Height = 24
      ActivePage = Page1
      FixedHeight = False
      object Page1: TdhPage
        Left = 40
        Top = 120
        Width = 560
        Height = 800
        AutoSizeXY = asNone
        UseIFrame = False
        object Label4: TdhLabel
          Left = 16
          Top = 24
          Width = 52
          Height = 21
          Text = 'Home'
          Use = Label10
          AutoSizeXY = asXY
        end
        object Label3: TdhLabel
          Left = 16
          Top = 67
          Width = 504
          Height = 656
          Text = 
            'The alternative pages of this template are linked by the right n' +
            'avigation bar. '#10'This template includes no pictures, so you can c' +
            'hange any color of any object.'#10'<br><br>'#10'The navigation bar has a' +
            ' fixed distance to the right edge, while the '#10'distance to the le' +
            'ft edge varies when resizing the browser window.'#10'This can be con' +
            'figured in the <b>Pos</b> tab / <nobr><b>Keep distance constant ' +
            'to</b></nobr>.'#10'If you want the navigation bar on the left side,'#10 +
            'check <b>Left parent edge</b>, uncheck <b>Right parent edge</b>'#10 +
            'and position the object <b>Menu1</b>'#10'to the left side and the cu' +
            'rrently active Page object to the right side.'#10#10'<br><br>'#10'To add a' +
            ' link to the navigation bar:'#10'<ol>'#10'<li>'#10'Select an existing link, ' +
            'copy it to clipboard (Ctrl-C) and '#10'paste it again (Ctrl-V).'#10'Adju' +
            'st the text and link to some destination (like a new Page object' +
            ').'#10'</li>'#10'<li>'#10'Because <b>Menu1</b> has automatic height enabled,' +
            ' you do not need to adjust its height to include the new link (a' +
            'nd in fact, you cannot).'#10'</li>'#10'</ol>'#10'<br>'#10'To create a new Page o' +
            'bject, select an existing page or object <b>PageControl1</b>'#10'and' +
            ' choose <b>New Page</b> from the context menu.'#10'<br><br>'#10'The link' +
            's in the navigation bar are styled by object <b>Link2</b>.'#10'The o' +
            'ver-style of object <b>Link2</b> (active when the mouse is over ' +
            'the object)'#10'contributes a yellow background color to every link ' +
            'and the'#10'down-style (when the down-state is active) contributes a' +
            ' blue background.'#10'The down-state is active for a link when the p' +
            'age which it links is active, '#10'but not when the mouse is pressed' +
            ' down on the link (which is the default). '#10'This can be configure' +
            'd in the <b>Link</b> tab / <b>Down State Conditions</b>.'#10'If you ' +
            'want the red background to appear for a link when the mouse is o' +
            'ver the link <i>and</i> this link is already active,'#10'you can che' +
            'ck <b>Prefer Over styles to Down styles</b> in the <b>Main</b> t' +
            'ab'#10'for object <b>Link2</b>.'#10#10'<br><br>'#10'Further on, the stylesheet' +
            ' contains styles for the top and right bar (<b>Label2</b>)'#10'and f' +
            'or the section headings (<b>Label10</b>).'
          AutoSizeXY = asY
        end
      end
      object Page2: TdhPage
        Left = 40
        Top = 120
        Width = 560
        Height = 256
        AutoSizeXY = asNone
        UseIFrame = False
        object Label5: TdhLabel
          Left = 16
          Top = 24
          Width = 144
          Height = 21
          Text = 'News & Updates'
          Use = Label10
          AutoSizeXY = asXY
        end
      end
      object Page3: TdhPage
        Left = 40
        Top = 120
        Width = 560
        Height = 256
        AutoSizeXY = asNone
        UseIFrame = False
        object Label6: TdhLabel
          Left = 16
          Top = 24
          Width = 148
          Height = 21
          Text = 'Family & Friends'
          Use = Label10
          AutoSizeXY = asXY
        end
      end
      object Page4: TdhPage
        Left = 40
        Top = 120
        Width = 560
        Height = 256
        AutoSizeXY = asNone
        UseIFrame = False
        object Label7: TdhLabel
          Left = 16
          Top = 24
          Width = 164
          Height = 21
          Text = 'Television & Radio'
          Use = Label10
          AutoSizeXY = asXY
        end
      end
      object Page5: TdhPage
        Left = 40
        Top = 120
        Width = 560
        Height = 256
        AutoSizeXY = asNone
        UseIFrame = False
        object Label8: TdhLabel
          Left = 16
          Top = 24
          Width = 67
          Height = 21
          Text = 'Contact'
          Use = Label10
          AutoSizeXY = asXY
        end
      end
      object Page6: TdhPage
        Left = 40
        Top = 120
        Width = 560
        Height = 707
        AutoSizeXY = asNone
        UseIFrame = False
      end
    end
    object Panel1: TdhPanel
      Left = 0
      Top = 16
      Height = 80
      Style.BorderLeft.Style = cbsNone
      Style.BorderRight.Style = cbsNone
      Use = Label2
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight]
      Right = 0
      object Label1: TdhLabel
        Left = 16
        Top = 16
        Width = 331
        Height = 45
        Text = 'Welcome to my<i><big><big> homepage</big></big></i>'
        Style.FontSize = '18'
        Style.Margin = '3'
        Style.Color = Red
        Style.FontWeight = cfwBold
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        AutoSizeXY = asXY
      end
    end
    object Menu1: TdhMenu
      Top = 95
      Width = 144
      Height = 395
      Style.BorderTop.Style = cbsNone
      Use = Label2
      AutoSizeXY = asY
      Anchors = [akTop, akRight]
      Right = 40
      MenuOptions = []
      ReactionTime = 400
      object Link3: TdhLink
        Left = 1
        Top = 0
        Height = 84
        Text = 'Home'
        Use = Link2
        AutoSizeXY = asXY
        Align = alTop
        Right = 1
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page1
      end
      object Link4: TdhLink
        Left = 1
        Top = 64
        Height = 102
        Text = 'News & Updates'
        Use = Link2
        AutoSizeXY = asXY
        Align = alTop
        Right = 1
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page2
      end
      object Link5: TdhLink
        Left = 1
        Top = 146
        Height = 102
        Text = 'Family & Friends'
        Use = Link2
        AutoSizeXY = asXY
        Align = alTop
        Right = 1
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page3
      end
      object Link6: TdhLink
        Left = 1
        Top = 310
        Height = 84
        Text = 'Contact'
        Use = Link2
        AutoSizeXY = asXY
        Align = alTop
        Right = 1
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page5
      end
      object Link1: TdhLink
        Left = 1
        Top = 228
        Height = 102
        Text = 'Television & Radio'
        Use = Link2
        AutoSizeXY = asXY
        Align = alTop
        Right = 1
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page4
      end
    end
    object StyleSheet1: TdhStyleSheet
      Left = 408
      Top = 40
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 184
      ExpandedHeight = 200
      Expanded = False
      object Label2: TdhLabel
        Left = 0
        Top = 0
        Height = 20
        Text = 'Label2'
        Style.Border.Width = 1
        Style.Border.Color = Silver
        Style.Border.Style = cbsSolid
        Style.BackgroundColor = 15724527
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
      object Link2: TdhLink
        Left = 0
        Top = 20
        Height = 84
        Text = 'Link2'
        Style.Border.Color = Silver
        Style.Border.Style = cbsSolid
        Style.Padding = 12
        Style.Margin = '20'
        Style.TextAlign = ctaCenter
        Style.Cursor = ccuPointer
        AutoSizeXY = asXY
        Align = alTop
        Right = -40
        StyleDown.BackgroundColor = 11579647
        StyleOver.BackgroundColor = 13828095
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfURL]
      end
      object Label10: TdhLabel
        Left = 0
        Top = 104
        Height = 21
        Text = 'Section'
        Style.FontSize = '18'
        Style.Color = 8404992
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
    end
  end
end
