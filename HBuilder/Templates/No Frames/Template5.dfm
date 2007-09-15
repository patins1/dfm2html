object PageContainer5: TPageContainer5
  Left = -4
  Top = -23
  Width = 1032
  Height = 519
  Caption = 'Template5.dfm'
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
    Style.BackgroundColor = Black
    Style.Color = White
    AutoSizeXY = asNone
    UseIFrame = False
    DesignSize = (
      1024
      492)
    Right = 0
    Bottom = 0
    object Panel1: TdhPanel
      Top = 25
      Width = 761
      Height = 729
      Style.Border.Width = 1
      Style.Margin = '20'
      Use = Label3
      AutoSizeXY = asNone
      Anchors = [akTop]
      DesignSize = (
        761
        729)
      object Panel2: TdhPanel
        Left = 21
        Top = 69
        Height = 32
        Style.Border.Width = 1
        Style.BorderLeft.Width = 0
        Style.BorderRight.Width = 0
        Use = Label3
        AutoSizeXY = asNone
        Align = alTop
        Right = 21
        object Link1: TdhLink
          Left = 0
          Top = 1
          Width = 79
          Text = 'Home'
          Use = Link2
          AutoSizeXY = asXY
          Align = alLeft
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page1
          Bottom = 1
        end
        object Link3: TdhLink
          Left = 79
          Top = 1
          Width = 77
          Text = 'News'
          Use = Link2
          AutoSizeXY = asXY
          Align = alLeft
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page2
          Bottom = 1
        end
        object Link4: TdhLink
          Left = 156
          Top = 1
          Width = 76
          Text = 'Links'
          Use = Link2
          AutoSizeXY = asXY
          Align = alLeft
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page3
          Bottom = 1
        end
        object Link5: TdhLink
          Left = 232
          Top = 1
          Width = 86
          Text = 'Photos'
          Use = Link2
          AutoSizeXY = asXY
          Align = alLeft
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page4
          Bottom = 1
        end
        object Link6: TdhLink
          Left = 318
          Top = 1
          Width = 92
          Text = 'Contact'
          Use = Link2
          AutoSizeXY = asXY
          Align = alLeft
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page5
          Bottom = 1
        end
      end
      object Panel3: TdhPanel
        Left = 21
        Top = 21
        Height = 48
        Style.BackgroundColor = 8744526
        AutoSizeXY = asNone
        Align = alTop
        SUse = 'Label1'
        Right = 21
        object Label2: TdhLabel
          Left = 9
          Top = -2
          Width = 331
          Height = 45
          Text = 'Welcome to my<i><big><big> homepage</big></big></i>'
          Style.FontSize = '18'
          Style.Margin = '3'
          Style.Color = White
          Style.FontWeight = cfwBold
          Style.Effects.Enabled = True
          Style.Effects.AntiAliasing = True
          Style.Effects.Text = etInclude
          AutoSizeXY = asXY
        end
      end
      object Panel4: TdhPanel
        Left = 21
        Top = 101
        Height = 19
        Style.BorderTop.Width = 0
        Style.BorderLeft.Width = 0
        Style.BorderRight.Width = 0
        Style.BackgroundColor = 8744526
        Use = Label3
        AutoSizeXY = asNone
        Align = alTop
        Right = 21
      end
      object PageControl1: TdhPageControl
        Left = 32
        Top = 130
        Width = 24
        Height = 24
        ActivePage = Page1
        FixedHeight = False
        object Page1: TdhPage
          Left = 23
          Top = 122
          Height = 584
          Use = Label3
          AutoSizeXY = asNone
          Anchors = [akLeft, akTop, akRight]
          UseIFrame = False
          Right = 23
          object Label4: TdhLabel
            Left = 24
            Top = 72
            Width = 602
            Height = 399
            Text = 
              'Object <b>Panel1</b> cares for centering the contents (see the <' +
              'b>Pos</b> tab) and '#10'for providing a margin between the outer whi' +
              'te rectangle and the browser window (see the <b>Edges</b> tab fo' +
              'r the margin value).'#10'<br>'#10'<br>'#10'The links in the navigation bar a' +
              're aligned to the left side (see the <b>Pos</b> tab). To add a l' +
              'ink'#10'two approaches are recommended:'#10'<ul>'#10'<li>'#10'Select one existin' +
              'g link, copy it into the clipboard (Ctrl-C), and paste it (Ctrl-' +
              'V).'#10'Now you can customize the text and the page link.'#10'</li>'#10'<li>' +
              #10'Add a new link to the object <b>Panel2</b> via drag&drop from t' +
              'he palette,'#10'set <b>Alignment</b> to <b>Left</b> in the <b>Pos</b' +
              '> tab and set <b>Use</b> to <b>Link2</b> in the <b>Main</b> tab.' +
              #10'Now you can customize the text and the page link.'#10'</li>'#10'</ul>'#10'<' +
              'br>'#10'To add a new page, select an exitings page or the object <b>' +
              'PageControl1</b> and click "New Page" in the context menu.'#10'Note ' +
              'that the <b>Use</b> field in the <b>Pos</b> tab is automatically' +
              ' assigned'#10'the value of the last active page, assuming'#10'that the n' +
              'ew page should have a similar layout (namely the inner white rec' +
              'tangle).'#10'<br>'#10'<br>'#10'<br>'#10'The stylesheet contains styles for the c' +
              'olor of the rectangles (white), '#10'for the links in the navigation' +
              ' bar, and for the section headings.'
            AutoSizeXY = asY
          end
          object Label6: TdhLabel
            Left = 24
            Top = 24
            Width = 150
            Height = 27
            Text = 'Home Section'
            Use = Label5
            AutoSizeXY = asXY
          end
        end
        object Page2: TdhPage
          Left = 23
          Top = 122
          Height = 320
          Use = Label3
          AutoSizeXY = asNone
          Anchors = [akLeft, akTop, akRight]
          UseIFrame = False
          Right = 23
          object Label7: TdhLabel
            Left = 24
            Top = 24
            Width = 146
            Height = 27
            Text = 'News Section'
            Use = Label5
            AutoSizeXY = asXY
          end
        end
        object Page3: TdhPage
          Left = 23
          Top = 122
          Height = 320
          Use = Label3
          AutoSizeXY = asNone
          Anchors = [akLeft, akTop, akRight]
          UseIFrame = False
          Right = 23
          object Label8: TdhLabel
            Left = 24
            Top = 24
            Width = 143
            Height = 27
            Text = 'Links Section'
            Use = Label5
            AutoSizeXY = asXY
          end
        end
        object Page4: TdhPage
          Left = 23
          Top = 122
          Height = 1000
          Use = Label3
          AutoSizeXY = asNone
          Anchors = [akLeft, akTop, akRight]
          UseIFrame = False
          Right = 23
          object Label9: TdhLabel
            Left = 24
            Top = 24
            Width = 162
            Height = 27
            Text = 'Photos Section'
            Use = Label5
            AutoSizeXY = asXY
          end
        end
        object Page5: TdhPage
          Left = 23
          Top = 122
          Height = 320
          Use = Label3
          AutoSizeXY = asNone
          Anchors = [akLeft, akTop, akRight]
          UseIFrame = False
          Right = 23
          object Label10: TdhLabel
            Left = 24
            Top = 24
            Width = 170
            Height = 27
            Text = 'Contact Section'
            Use = Label5
            AutoSizeXY = asXY
          end
        end
      end
    end
    object StyleSheet1: TdhStyleSheet
      Left = 16
      Top = 17
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 128
      ExpandedHeight = 112
      Expanded = False
      object Link2: TdhLink
        Left = 0
        Top = 20
        Height = 23
        Text = 'Link2'
        Style.BorderTop.Width = 0
        Style.BorderBottom.Width = 0
        Style.BorderLeft.Width = 0
        Style.BorderRight.Width = 1
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000006D00
          00000108020000005BACB720000000444944415478DA63F4CB6BFDFFFF3F0310
          FFFFF71F0CE06C06081F850DE2C2D90C302D28EC7FF84DF88764144217560760
          730C9A09B81C43C801FFB0EAC2E5003C5E80B2015B872611D0E4367E00000000
          49454E44AE426082}
        Style.BackgroundRepeat = cbrRepeatY
        Style.PaddingLeft = 20
        Style.PaddingTop = 6
        Style.PaddingRight = 20
        Style.FontSize = '12'
        Style.TextAlign = ctaCenter
        Style.Cursor = ccuPointer
        Style.FontFamily = 'Arial Black'
        Style.Color = White
        Use = Label3
        AutoSizeXY = asXY
        Align = alTop
        StyleOver.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000006D00
          00000108020000005BACB7200000003E4944415478DA8D8ED10A00200803B7FD
          FF47878596609620DC1E368E0048DA539C178C95135B0C865712AB5FD031B55B
          A5C0A5A50F999780CA5627D0CB0CCE1A01438E60A0730000000049454E44AE42
          6082}
        StyleOver.BackgroundPosition = '100% 0%'
        StyleOver.BackgroundRepeat = cbrRepeatY
        StyleOver.Color = Lime
        StyleOver.TextDecoration = [ctdUnderline, ctdOverline]
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Right = -15
      end
      object Label3: TdhLabel
        Left = 0
        Top = 0
        Height = 20
        Text = 'Label3'
        Style.Border.Width = 1
        Style.Border.Color = White
        Style.Border.Style = cbsSolid
        AutoSizeXY = asY
        Align = alTop
        Right = 24
      end
      object Label5: TdhLabel
        Left = 0
        Top = 43
        Height = 27
        Text = 'Label5'
        Style.FontSize = '24'
        Style.Color = Lime
        AutoSizeXY = asY
        Align = alTop
        Right = 2147483647
      end
    end
  end
end
