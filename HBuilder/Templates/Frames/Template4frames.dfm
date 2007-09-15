object PageContainer4: TPageContainer4
  Left = -4
  Top = -23
  Width = 1032
  Height = 519
  Caption = 'Template4frames.dfm'
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
    UseIFrame = False
    Scrolling = scNo
    DesignSize = (
      1024
      492)
    Right = 0
    Bottom = 0
    object Panel1: TdhPanel
      Left = -16
      Top = -16
      Style.Border.Width = 120
      Style.Border.Color = Navy
      Style.BorderTop.Width = 4
      Style.BorderTop.Style = cbsSolid
      Style.BorderLeft.Width = 100
      Style.BorderLeft.Style = cbsSolid
      Style.MarginLeft = '0'
      Style.MarginTop = '0'
      Style.MarginBottom = '0'
      Style.Effects.ShiftX = 16
      Style.Effects.ShiftY = 16
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      Style.Effects.InnerShadow.Enabled = True
      Style.Effects.InnerShadow.Alpha = 255
      Style.Effects.InnerShadow.Radius = 10
      Style.Effects.InnerShadow.Color = Yellow
      Style.Effects.InnerShadow.Flood = 52
      Style.Effects.InnerShadow.Distance = 0
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 161
      Style.Effects.OuterShadow.Radius = 7
      Style.Effects.OuterShadow.Degree = 162
      Style.Effects.InnerGlow.Alpha = 255
      Style.Effects.InnerGlow.Radius = 6
      Style.Effects.InnerGlow.Flood = 17
      Style.BorderRadius.TopLeft = '167'
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight, akBottom]
      DesignSize = (
        1040
        508)
      Right = 0
      Bottom = 0
      object Page2: TdhPage
        Left = 152
        Top = 96
        AutoSizeXY = asNone
        Anchors = [akLeft, akTop, akRight, akBottom]
        UseIFrame = False
        Right = 0
        Bottom = 0
        object PageControl1: TdhPageControl
          Left = 191
          Top = 56
          Width = 24
          Height = 24
          ActivePage = Page1
          FixedHeight = False
          object Page1: TdhPage
            Left = 8
            Top = 40
            Width = 624
            Height = 792
            AutoSizeXY = asNone
            UseIFrame = False
            object Label2: TdhLabel
              Left = 24
              Top = 24
              Width = 112
              Height = 21
              Text = 'Home Section'
              Use = Label3
              AutoSizeXY = asXY
            end
            object Label5: TdhLabel
              Left = 24
              Top = 72
              Width = 584
              Height = 315
              Text = 
                'The alternative pages of this template are contained in the scro' +
                'llable Page object <b>Page2</b>.'#10'The links of the navigation bar' +
                ' are variable sized and aligned to the top (see <b>Pos</b> tab).' +
                #10'If the mouse is over one link, a top and bottom yellow border i' +
                's added to the link (defined for the <b>Over</b> state), '#10'pushin' +
                'g following links down by the space of the borders. '#10'This only w' +
                'orks for a top alignment, which is natively supported by HTML. O' +
                'ther alignment directions would not allow the shifting of follow' +
                'ing links.'#10'<br>'#10'<br>'#10'Note that no graphics are used, every color' +
                ' can be customized. The arc in the top left corner is'#10'a rounded ' +
                'corner of object <b>Panel1</b> configurable in the <b>Edges</b> ' +
                'tab.'#10'You will notice that this object is shifted in the <b>Effec' +
                'ts</b> tab to bottom and down by 16 pixels.'#10'This ensures a clean' +
                ' cut in the top/right and bottom/left corner'#10'(reset this shiftin' +
                'g to have a different appearance). This shifting is compensated'#10 +
                'by setting <b>Panel1</b> to the position (-16,-16) in the <b>Pos' +
                '</b> tab.'#10'<br/><br/>'#10'The stylesheet contains styles for navigati' +
                'on bar links (<b>Link2</b>)'#10'and for the section headings (<b>Lab' +
                'el3</b>). Note that <b>Link2</b> is'#10'completely white because the' +
                ' font color is white (as the background color).'
              AutoSizeXY = asY
            end
          end
          object Page3: TdhPage
            Left = 8
            Top = 40
            Width = 624
            Height = 292
            AutoSizeXY = asNone
            UseIFrame = False
            object Label4: TdhLabel
              Left = 24
              Top = 24
              Width = 110
              Height = 21
              Text = 'News Section'
              Use = Label3
              AutoSizeXY = asXY
            end
          end
          object Page4: TdhPage
            Left = 8
            Top = 40
            Width = 624
            Height = 292
            AutoSizeXY = asNone
            UseIFrame = False
            object Label6: TdhLabel
              Left = 24
              Top = 24
              Width = 107
              Height = 21
              Text = 'Links Section'
              Use = Label3
              AutoSizeXY = asXY
            end
          end
          object Page5: TdhPage
            Left = 8
            Top = 40
            Width = 624
            Height = 1092
            AutoSizeXY = asNone
            UseIFrame = False
            object Label7: TdhLabel
              Left = 24
              Top = 24
              Width = 121
              Height = 21
              Text = 'Photos Section'
              Use = Label3
              AutoSizeXY = asXY
            end
          end
          object Page6: TdhPage
            Left = 8
            Top = 40
            Width = 624
            Height = 292
            AutoSizeXY = asNone
            UseIFrame = False
            object Label8: TdhLabel
              Left = 24
              Top = 24
              Width = 127
              Height = 21
              Text = 'Contact Section'
              Use = Label3
              AutoSizeXY = asXY
            end
          end
        end
      end
      object Label1: TdhLabel
        Left = 176
        Top = 53
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
      object Panel2: TdhPanel
        Left = 17
        Top = 187
        Width = 98
        Height = 184
        AutoSizeXY = asNone
        object Link1: TdhLink
          Left = 0
          Top = 0
          Height = 29
          Text = 'Home'
          Use = Link2
          AutoSizeXY = asXY
          Align = alTop
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page1
          Right = 0
        end
        object Link3: TdhLink
          Left = 0
          Top = 87
          Height = 29
          Text = 'Photos'
          Use = Link2
          AutoSizeXY = asXY
          Align = alTop
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page5
          Right = 0
        end
        object Link4: TdhLink
          Left = 0
          Top = 58
          Height = 29
          Text = 'Links'
          Use = Link2
          AutoSizeXY = asXY
          Align = alTop
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page4
          Right = 0
        end
        object Link5: TdhLink
          Left = 0
          Top = 29
          Height = 29
          Text = 'News'
          Use = Link2
          AutoSizeXY = asXY
          Align = alTop
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page3
          Right = 0
        end
        object Link6: TdhLink
          Left = 0
          Top = 116
          Height = 29
          Text = 'Contact'
          Use = Link2
          AutoSizeXY = asXY
          Align = alTop
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page6
          Right = 0
        end
      end
      object StyleSheet1: TdhStyleSheet
        Left = 584
        Top = 32
        Width = 28
        Height = 28
        Expanded = False
        ExpandedWidth = 152
        ExpandedHeight = 100
        Expanded = False
        object Link2: TdhLink
          Left = 0
          Top = 0
          Height = 29
          Text = 'Link2'
          Style.Padding = 5
          Style.TextAlign = ctaCenter
          Style.Cursor = ccuPointer
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          Align = alTop
          StyleOver.Border.Width = 3
          StyleOver.Border.Color = Yellow
          StyleOver.BorderTop.Style = cbsSolid
          StyleOver.BorderBottom.Style = cbsSolid
          Layout = ltText
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          Right = 16
        end
        object Label3: TdhLabel
          Left = 0
          Top = 29
          Height = 21
          Text = 'Section'
          Style.FontSize = '18'
          AutoSizeXY = asY
          Align = alTop
          Right = 2147483647
        end
      end
    end
  end
end
