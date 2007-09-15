object PageContainer1: TPageContainer1
  Left = -4
  Top = -23
  Width = 1608
  Height = 751
  Caption = 'Template1frames.dfm'
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
    Style.BackgroundColor = 7098686
    Style.Color = White
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Scrolling = scNo
    DesignSize = (
      1600
      724)
    object Panel5: TdhPanel
      Left = 194
      Top = 8
      Style.Border.Width = 0
      Style.Border.Color = 4737096
      Style.Border.Style = cbsSolid
      Style.Margin = '10'
      Style.BackgroundColor = 8808006
      Style.BorderRadius.All = '18'
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight, akBottom]
      Right = 6
      Bottom = 9
      DesignSize = (
        1400
        707)
      object Label1: TdhLabel
        Left = 40
        Top = 24
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
      object Page2: TdhPage
        Left = 33
        Top = 84
        AutoSizeXY = asNone
        Anchors = [akLeft, akTop, akRight, akBottom]
        Right = 28
        Bottom = 31
        UseIFrame = False
        object PageControl1: TdhPageControl
          Left = 0
          Top = 0
          Width = 24
          Height = 24
          ActivePage = Page3
          FixedHeight = False
          object Page3: TdhPage
            Left = 0
            Top = 0
            Width = 517
            Height = 780
            AutoSizeXY = asNone
            UseIFrame = False
            object Label2: TdhLabel
              Left = 16
              Top = 64
              Width = 472
              Height = 238
              Text = 
                'The alternative pages of this template are linked by the left na' +
                'vigation bar and are contained in the scrollable Page object <b>' +
                'Page2</b>. This template includes no pictures, so you can change' +
                ' any color of any object.'#10'<br>'#10'<br>'#10'The navigation bar is also i' +
                'ncluded in the Presets (<i>Tools</i> | <i>Presets</i>).'#10'Note tha' +
                't the first and the last entry in the navigation bar have round ' +
                'corners and thus use'#10'different styles than the others. So if you' +
                ' reorder links in the navigation bar,'#10'you have to choose the cor' +
                'rect styles to use (configurable in the <b>Use</b> field of the ' +
                '<b>Main</b> tab). '#10'Choose among <b>Link9</b>, <b>Link3</b> and <' +
                'b>Link10</b>.'#10'<br><br>'#10'The second stylesheet contains a style fo' +
                'r the section headings.'
              AutoSizeXY = asY
            end
            object Label4: TdhLabel
              Left = 16
              Top = 24
              Width = 107
              Height = 19
              Text = 'Home Section'
              Use = Label5
              AutoSizeXY = asXY
            end
            object Label11: TdhLabel
              Left = 16
              Top = 312
              Width = 472
              Height = 435
              Text = 
                'There is also a version of this template using a frameless layou' +
                't.<br/>'#10'The following steps explain, how to convert this templat' +
                'e into a frameless layout:'#10#10'<ol>'#10'<li>Select object <b>index</b> ' +
                '(the outermost object) and set <nobr>Show Scrollbars</nobr> to <' +
                'b>auto</b>.'#10'If now the content is bigger than the browser window' +
                ' (represented by the outermost object), scrollbars are shown.'#10'</' +
                'li>'#10'<li>'#10'Select object <b>PageControl1</b>, copy it into the cli' +
                'pboard (Ctrl-C)'#10'and delete it (select "Yes" if a confirmation di' +
                'alog appears; this is due to that'#10'the links on the left side sti' +
                'll reference the pages which will be deleted together with the p' +
                'age control).'#10'</li>'#10'<li>Now delete the object <b>Page2</b>. We d' +
                'on'#39't need this scrollable container object any more.</li>'#10'<li>Se' +
                'lect <b>Panel5</b> and paste the objects from the clipboard into' +
                ' it (Ctrl-V).'#10'Position one page to appear under the Welcome mess' +
                'age, all other hidden'#10'pages are set to the same position.'#10'</li>'#10 +
                '<li>Select <b>Panel5</b>, go to the <b>Pos</b> tab and uncheck <' +
                'b>Bottom parent edge</b>. This was responsible for resizing the ' +
                'height when the browser window'#39's height changed. But now the hei' +
                'ght shall only adapt to different heights of the contained alter' +
                'native pages. Finally set the height big enough to include the c' +
                'urrently visible Page object.</li>'#10'</ol>'
              AutoSizeXY = asY
            end
          end
          object Page4: TdhPage
            Left = 0
            Top = 0
            Width = 517
            Height = 304
            AutoSizeXY = asNone
            UseIFrame = False
            object Label6: TdhLabel
              Left = 16
              Top = 24
              Width = 122
              Height = 19
              Text = 'Contact Section'
              Use = Label5
              AutoSizeXY = asXY
            end
          end
          object Page5: TdhPage
            Left = 0
            Top = 0
            Width = 517
            Height = 344
            AutoSizeXY = asNone
            UseIFrame = False
            object Label7: TdhLabel
              Left = 16
              Top = 24
              Width = 149
              Height = 19
              Text = 'Information Section'
              Use = Label5
              AutoSizeXY = asXY
            end
          end
          object Page6: TdhPage
            Left = 0
            Top = 0
            Width = 517
            Height = 592
            AutoSizeXY = asNone
            UseIFrame = False
            object Label8: TdhLabel
              Left = 16
              Top = 24
              Width = 105
              Height = 19
              Text = 'News Section'
              Use = Label5
              AutoSizeXY = asXY
            end
          end
          object Page7: TdhPage
            Left = 0
            Top = 0
            Width = 517
            Height = 288
            AutoSizeXY = asNone
            UseIFrame = False
            object Label9: TdhLabel
              Left = 16
              Top = 24
              Width = 104
              Height = 19
              Text = 'Links Section'
              Use = Label5
              AutoSizeXY = asXY
            end
          end
          object Page8: TdhPage
            Left = 0
            Top = 0
            Width = 517
            Height = 900
            AutoSizeXY = asNone
            UseIFrame = False
            object Label10: TdhLabel
              Left = 16
              Top = 24
              Width = 117
              Height = 19
              Text = 'Photos Section'
              Use = Label5
              AutoSizeXY = asXY
            end
          end
        end
      end
      object StyleSheet2: TdhStyleSheet
        Left = 427
        Top = 26
        Width = 28
        Height = 28
        Expanded = False
        ExpandedWidth = 160
        ExpandedHeight = 100
        Expanded = False
        object Label5: TdhLabel
          Left = 0
          Top = 0
          Height = 19
          Text = 'Section'
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asY
          Align = alTop
          Right = 0
        end
      end
    end
    object Menu2: TdhMenu
      Left = 27
      Top = 38
      Width = 147
      Height = 166
      Use = Menu1
      AutoSizeXY = asY
      MenuOptions = []
      ReactionTime = 400
      object Link30: TdhLink
        Left = 7
        Top = 132
        Height = 27
        Text = 'Contact'
        Use = Link28
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page4
      end
      object Link31: TdhLink
        Left = 7
        Top = 32
        Height = 27
        Text = 'Information'
        Use = Link27
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page5
      end
      object Link32: TdhLink
        Left = 7
        Top = 57
        Height = 27
        Text = 'News'
        Use = Link27
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page6
      end
      object Link33: TdhLink
        Left = 7
        Top = 82
        Height = 27
        Text = 'Links'
        Use = Link27
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page7
      end
      object Link37: TdhLink
        Left = 7
        Top = 7
        Height = 27
        Text = 'Home'
        Use = Link29
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page3
      end
      object Link38: TdhLink
        Left = 7
        Top = 107
        Height = 27
        Text = 'Photos'
        Use = Link27
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page8
      end
    end
    object StyleSheet3: TdhStyleSheet
      Left = 33
      Top = 43
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 208
      ExpandedHeight = 176
      Expanded = False
      object Menu1: TdhMenu
        Left = 0
        Top = 0
        Height = 142
        Style.Border.Width = 2
        Style.Border.Color = 8808006
        Style.Border.Style = cbsSolid
        Style.Margin = '5'
        Style.BorderRadius.All = '13'
        AutoSizeXY = asXY
        Align = alTop
        Right = -4
        MenuOptions = []
        ReactionTime = 400
        object Link27: TdhLink
          Left = 7
          Top = 49
          Height = 44
          Text = 'Middle Link'
          Style.Padding = 3
          Style.FontSize = '14'
          Style.Margin = '2'
          Style.BackgroundColor = 8808006
          Style.TextAlign = ctaCenter
          Style.Cursor = ccuPointer
          Style.FontFamily = 'Verdana'
          Style.Color = Silver
          Style.FontVariant = cfvSmallCaps
          Style.TextDecoration = [ctdNone]
          AutoSizeXY = asXY
          Align = alTop
          Right = -3
          StyleOver.Color = White
          StyleOver.FontWeight = cfwBold
          Layout = ltText
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        end
        object Link28: TdhLink
          Left = 7
          Top = 91
          Height = 44
          Text = 'Bottom Link'
          Style.BorderRadius.BottomRight = '9'
          Style.BorderRadius.BottomLeft = '9'
          Use = Link27
          AutoSizeXY = asXY
          Align = alTop
          Right = -3
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        end
        object Link29: TdhLink
          Left = 7
          Top = 7
          Height = 44
          Text = 'Top Link'
          Style.BorderRadius.TopLeft = '9'
          Style.BorderRadius.TopRight = '9'
          Use = Link27
          AutoSizeXY = asXY
          Align = alTop
          Right = -3
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        end
      end
      object Label3: TdhLabel
        Left = 0
        Top = 91
        Height = 18
        Text = 'Label1'
        Style.FontFamily = 'Arial'
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
    end
  end
end
