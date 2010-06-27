object PageContainer1: TPageContainer1
  Left = -4
  Top = -23
  Caption = 'Template11.dfm'
  ClientHeight = 726
  ClientWidth = 1600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
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
      00000108060000001F15C4890000000B4944415478DA63FC0F04000A0003FEDE
      9D70530000000049454E44AE426082}
    Style.BackgroundRepeat = cbrRepeat
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    GeneratedCSSFile = 'dfm2html.css'
    object Panel1: TdhPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 552
      Style.BorderRadius.TopRight = '48'
      AutoSizeXY = asNone
      object Label13: TdhLabel
        Left = 26
        Top = 18
        Width = 124
        Height = 112
        Text = 
          'The Old Sawmill<br/>'#10'Camserney<br/>'#10'By Aberfeldy<br/>'#10'Perth & Ki' +
          'nross PH15 2JF<br/>'#10'Scotland<br/>'#10'<b>T</b> +44 1887 820 100<br/>' +
          #10'<b>F</b> +44 1887 820 524'
        Use = StyleAddress
        AutoSizeXY = asY
      end
    end
    object PageControl1: TdhPageControl
      Left = 224
      Top = 8
      Width = 24
      Height = 24
      ActivePage = Page1
      FixedHeight = False
      object Page1: TdhPage
        Left = 184
        Top = 160
        Width = 592
        Height = 388
        Style.Border.Color = Silver
        Style.Border.Style = cbsSolid
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
          00000108060000001F15C4890000000B4944415478DA63FC0F04000A0003FEDE
          9D70530000000049454E44AE426082}
        Style.BackgroundRepeat = cbrRepeat
        AutoSizeXY = asNone
        UseIFrame = False
        object Label1: TdhLabel
          Left = 12
          Top = 204
          Width = 64
          Height = 22
          Text = 'Page 1'
          Use = StyleBodycopy
          AutoSizeXY = asY
        end
        object PageControl3: TdhPageControl
          Left = 188
          Top = 48
          Width = 24
          Height = 24
          ActivePage = Page9
          FixedHeight = False
          object Page7: TdhPage
            Left = 276
            Top = 56
            Width = 304
            Height = 284
            AutoSizeXY = asNone
            UseIFrame = False
            object Label7: TdhLabel
              Left = 32
              Top = 36
              Width = 100
              Height = 22
              Text = 'Page 7'
              Use = StyleBodycopy
              AutoSizeXY = asY
            end
          end
          object Page8: TdhPage
            Left = 276
            Top = 56
            Width = 304
            Height = 284
            AutoSizeXY = asNone
            UseIFrame = False
            object Label8: TdhLabel
              Left = 32
              Top = 36
              Width = 100
              Height = 22
              Text = 'Page 8'
              Use = StyleBodycopy
              AutoSizeXY = asY
            end
          end
          object Page9: TdhPage
            Left = 276
            Top = 56
            Width = 304
            Height = 304
            Style.Border.Color = Gray
            Style.Border.Style = cbsSolid
            AutoSizeXY = asNone
            UseIFrame = False
            object Label9: TdhLabel
              Left = 4
              Top = 260
              Width = 100
              Height = 22
              Text = 'Page 9'
              Use = StyleBodycopy
              AutoSizeXY = asY
            end
            object Menu4: TdhMenu
              Left = 2
              Top = 2
              Width = 300
              Height = 20
              AutoSizeXY = asNone
              MenuOptions = []
              ReactionTime = 400
              object Accordion1: TdhLink
                Left = 0
                Top = 0
                Width = 150
                Height = 20
                Text = '<center>Accordion1</center>'
                Use = TabStyle1
                AutoSizeXY = asNone
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page10
              end
              object Accordion2: TdhLink
                Top = 0
                Width = 150
                Height = 20
                Text = '<center>Accordion2</center>'
                Use = TabStyle1
                AutoSizeXY = asNone
                Anchors = [akTop, akRight]
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page11
              end
            end
            object PageControl4: TdhPageControl
              Left = 4
              Top = 44
              Width = 24
              Height = 24
              ActivePage = Page10
              FixedHeight = False
              object Page10: TdhPage
                Left = 2
                Top = 23
                Width = 300
                Height = 160
                Style.Border.Width = 0
                Style.BorderBottom.Style = cbsSolid
                Style.BorderLeft.Style = cbsSolid
                Style.BorderRight.Style = cbsSolid
                AutoSizeXY = asNone
                UseIFrame = False
                object Label10: TdhLabel
                  Left = 44
                  Top = 12
                  Width = 100
                  Height = 22
                  Text = 'Page10'
                  Use = StyleBodycopy
                  AutoSizeXY = asY
                end
              end
              object Page11: TdhPage
                Left = 2
                Top = 23
                Width = 300
                Height = 160
                Style.Border.Width = 0
                Style.BorderBottom.Color = Gray
                Style.BorderBottom.Style = cbsSolid
                Style.BorderLeft.Color = Gray
                Style.BorderLeft.Style = cbsSolid
                Style.BorderRight.Color = Gray
                Style.BorderRight.Style = cbsSolid
                AutoSizeXY = asNone
                UseIFrame = False
                object Label11: TdhLabel
                  Left = 44
                  Top = 12
                  Width = 100
                  Height = 22
                  Text = 'Page11'
                  Use = StyleBodycopy
                  AutoSizeXY = asY
                end
              end
            end
          end
        end
        object Label12: TdhLabel
          Left = 12
          Top = 12
          Width = 568
          Height = 33
          Text = '<center>making your words work '#8211' worldwide</center>'
          Use = HeaderStyle
          AutoSizeXY = asY
        end
      end
      object Page2: TdhPage
        Left = 184
        Top = 160
        Width = 592
        Height = 572
        AutoSizeXY = asNone
        UseIFrame = False
        object Label2: TdhLabel
          Left = 12
          Top = 20
          Width = 64
          Height = 22
          Text = 'Page 2'
          Use = StyleBodycopy
          AutoSizeXY = asY
        end
        object Panel2: TdhPanel
          Left = 112
          Top = 0
          Width = 480
          Height = 504
          Style.Border.Color = Silver
          Style.Border.Style = cbsSolid
          AutoSizeXY = asNone
          object PageControl5: TdhPageControl
            Left = 16
            Top = 52
            Width = 24
            Height = 24
            ActivePage = Page13
            FixedHeight = False
            object Page12: TdhPage
              Left = 2
              Top = 2
              Width = 476
              Height = 500
              AutoSizeXY = asNone
              UseIFrame = False
              Title = 'Page 12'
              object Link10: TdhLink
                Left = 0
                Top = 0
                Width = 476
                Height = 20
                Text = 'Translation'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page12
              end
              object Link11: TdhLink
                Left = 0
                Top = 440
                Width = 476
                Height = 22
                Text = 'Writing'
                Use = TabStyle3
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page13
              end
              object Link12: TdhLink
                Left = 0
                Top = 460
                Width = 476
                Height = 20
                Text = 'Brand stewardship'
                Use = TabStyle3
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page14
              end
              object Link13: TdhLink
                Left = 0
                Top = 480
                Width = 476
                Height = 20
                Text = 'Support services'
                Use = TabStyle3
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page15
              end
            end
            object Page13: TdhPage
              Left = 2
              Top = 2
              Width = 476
              Height = 500
              AutoSizeXY = asNone
              UseIFrame = False
              object Link14: TdhLink
                Left = 0
                Top = 0
                Width = 476
                Height = 20
                Text = 'Translation'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page12
              end
              object Link15: TdhLink
                Left = 0
                Top = 20
                Width = 476
                Height = 20
                Text = 'Writing'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page13
              end
              object Link16: TdhLink
                Left = 0
                Top = 460
                Width = 476
                Height = 20
                Text = 'Brand stewardship'
                Use = TabStyle3
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page14
              end
              object Link17: TdhLink
                Left = 0
                Top = 480
                Width = 476
                Height = 20
                Text = 'Support services'
                Use = TabStyle3
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page15
              end
            end
            object Page14: TdhPage
              Left = 2
              Top = 2
              Width = 476
              Height = 500
              AutoSizeXY = asNone
              UseIFrame = False
              object Link18: TdhLink
                Left = 0
                Top = 0
                Width = 476
                Height = 20
                Text = 'Translation'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page12
              end
              object Link19: TdhLink
                Left = 0
                Top = 20
                Width = 476
                Height = 22
                Text = 'Writing'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page13
              end
              object Link20: TdhLink
                Left = 0
                Top = 40
                Width = 476
                Height = 20
                Text = 'Brand stewardship'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page14
              end
              object Link21: TdhLink
                Left = 0
                Top = 480
                Width = 476
                Height = 20
                Text = 'Support services'
                Use = TabStyle3
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page15
              end
            end
            object Page15: TdhPage
              Left = 2
              Top = 2
              Width = 476
              Height = 500
              AutoSizeXY = asNone
              UseIFrame = False
              object Link22: TdhLink
                Left = 0
                Top = 0
                Width = 476
                Height = 20
                Text = 'Translation'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page12
              end
              object Link23: TdhLink
                Left = 0
                Top = 20
                Width = 476
                Height = 22
                Text = 'Writing'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page13
              end
              object Link24: TdhLink
                Left = 0
                Top = 40
                Width = 476
                Height = 20
                Text = 'Brand stewardship'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page14
              end
              object Link25: TdhLink
                Left = 0
                Top = 60
                Width = 476
                Height = 20
                Text = 'Support services'
                Use = TabStyle2
                AutoSizeXY = asY
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page15
              end
            end
          end
        end
      end
      object Page3: TdhPage
        Left = 184
        Top = 160
        Width = 592
        Height = 440
        AutoSizeXY = asNone
        UseIFrame = False
        object Label3: TdhLabel
          Left = 12
          Top = 20
          Width = 64
          Height = 22
          Text = 'Page 3'
          Use = StyleBodycopy
          AutoSizeXY = asY
        end
        object PageControl2: TdhPageControl
          Left = 236
          Top = 164
          Width = 24
          Height = 24
          ActivePage = Page6
          FixedHeight = False
          object Page4: TdhPage
            Left = 236
            Top = 164
            Width = 168
            Height = 184
            AutoSizeXY = asNone
            UseIFrame = False
            object Label4: TdhLabel
              Left = 40
              Top = 40
              Width = 84
              Height = 22
              Text = 'Page 4'
              Use = StyleBodycopy
              AutoSizeXY = asY
            end
          end
          object Page5: TdhPage
            Left = 236
            Top = 164
            Width = 168
            Height = 184
            AutoSizeXY = asNone
            UseIFrame = False
            object Label5: TdhLabel
              Left = 40
              Top = 40
              Width = 84
              Height = 22
              Text = 'Page 5'
              Use = StyleBodycopy
              AutoSizeXY = asY
            end
          end
          object Page6: TdhPage
            Left = 236
            Top = 164
            Width = 168
            Height = 184
            AutoSizeXY = asNone
            UseIFrame = False
            object Label6: TdhLabel
              Left = 40
              Top = 40
              Width = 84
              Height = 22
              Text = 'Page 6'
              Use = StyleBodycopy
              AutoSizeXY = asY
            end
          end
        end
      end
    end
    object StyleSheet1: TdhStyleSheet
      Left = 892
      Top = 84
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 216
      ExpandedHeight = 128
      Expanded = False
      object MenuStyle1: TdhLink
        Left = 0
        Top = 0
        Height = 23
        Text = 'MenuStyle1'
        Style.BorderBottom.Color = Silver
        Style.BorderBottom.Style = cbsSolid
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
          00000108060000001F15C4890000000D4944415478DA63FCFFFF3F0300090102
          FF0388A5BA0000000049454E44AE426082}
        Style.BackgroundRepeat = cbrRepeat
        Style.PaddingLeft = 1
        Style.FontSize = '12'
        Style.MarginLeft = '0'
        Style.MarginBottom = '0'
        Style.BackgroundColor = White
        Style.Cursor = ccuPointer
        Style.LineHeight = '22'
        Style.Display = cdsListItem
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etOnly
        AutoSizeXY = asY
        Align = alTop
        Right = 0
        StyleDown.BorderRight.Width = 4
        StyleDown.BorderRight.Color = 4194304
        StyleDown.BorderRight.Style = cbsSolid
        StyleDown.MarginRight = '0'
        StyleDown.Color = Black
        StyleDown.FontWeight = cfwBold
        StyleOver.BorderBottom.Color = Black
        StyleOver.BorderBottom.Style = cbsSolid
        StyleOver.Color = Black
        StyleOver.FontWeight = cfwBold
        StyleOverDown.BorderBottom.Color = Silver
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object MenuStyle2: TdhLink
        Left = 0
        Top = 63
        Height = 23
        Text = 'MenuStyle2'
        Style.PaddingLeft = 1
        Style.MarginLeft = '10'
        Style.Cursor = ccuPointer
        Style.BorderRadius.TopLeft = '0'
        Style.BorderRadius.BottomLeft = '0'
        Use = MenuStyle1
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        StyleDown.BorderRight.Color = 12615680
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object TabStyle1: TdhLink
        Left = 0
        Top = 86
        Height = 18
        Text = '<center>TabStyle1</center>'
        ImageType = bitStretch
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
          0000120802000000153523EB000000514944415478DA63646838C0C850B18391
          A170232343E64A4686A4458C0C51B318198227333278773332B8B43032D8D430
          3298963232E8E63232A8A53132C8C5313288873332F0FB333270783032303800
          0051B20D934E1339BD0000000049454E44AE426082}
        Style.BackgroundRepeat = cbrRepeatX
        Style.Padding = 2
        Style.FontSize = '11'
        Style.TextAlign = ctaCenter
        Style.Cursor = ccuPointer
        Style.Color = White
        Style.Effects.AntiAliasing = True
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        StyleDown.Border.Color = Silver
        StyleDown.Border.Style = cbsSolid
        StyleDown.BorderBottom.Color = White
        StyleDown.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
          00000108060000001F15C4890000000B4944415478DA63FC0F04000A0003FEDE
          9D70530000000049454E44AE426082}
        StyleDown.BackgroundRepeat = cbrRepeat
        StyleDown.FontSize = '12'
        StyleDown.Color = Black
        StyleDown.FontWeight = cfwBold
        StyleOver.FontWeight = cfwBold
        StyleOverDown.Cursor = ccuDefault
        StyleOverDown.Color = Black
        StyleOverDown.TextDecoration = [ctdNone]
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object TabStyle2: TdhLink
        Left = 0
        Top = 43
        Height = 20
        Text = 'TabStyle2'
        ImageType = bitStretch
        Style.Border.Color = White
        Style.Border.Style = cbsSolid
        Style.BorderBottom.Color = 64
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D49484452000000C400
          00000108020000000EE1963B000000244944415478DA63FC7FFFFE7F38F8F7EF
          3F26205A908132EDB410A4BE93069B7B069393008F4C4560520A692E00000000
          49454E44AE426082}
        Style.BackgroundRepeat = cbrRepeatY
        Style.Padding = 2
        Style.FontSize = '11'
        Style.TextAlign = ctaRight
        Style.Cursor = ccuPointer
        Style.Color = White
        Style.FontWeight = cfwBold
        Style.Effects.AntiAliasing = True
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        StyleDown.BorderBottom.Color = 64
        StyleDown.BorderBottom.Style = cbsSolid
        StyleDown.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
          00000108060000001F15C4890000000B4944415478DA63FC0F04000A0003FEDE
          9D70530000000049454E44AE426082}
        StyleDown.BackgroundRepeat = cbrRepeat
        StyleDown.FontSize = '13'
        StyleDown.TextAlign = ctaRight
        StyleDown.Color = Black
        StyleDown.FontWeight = cfwBold
        StyleOver.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
          00000108060000001F15C4890000000D4944415478DA63746060F80F00020901
          41B548BD720000000049454E44AE426082}
        StyleOver.BackgroundRepeat = cbrRepeat
        StyleOver.PaddingRight = 6
        StyleOver.Color = 8454143
        StyleOver.FontWeight = cfwBold
        StyleOver.BorderRadius.TopLeft = '8'
        StyleOver.BorderRadius.TopRight = '8'
        StyleOverDown.BorderBottom.Color = Silver
        StyleOverDown.PaddingRight = 2
        StyleOverDown.Cursor = ccuDefault
        StyleOverDown.Color = Black
        StyleOverDown.TextDecoration = [ctdNone]
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object TabStyle3: TdhLink
        Left = 0
        Top = 23
        Height = 20
        Text = 'TabStyle3'
        ImageType = bitStretch
        Style.Border.Color = White
        Style.Border.Style = cbsSolid
        Style.BorderBottom.Color = 64
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D49484452000000C400
          00000108020000000EE1963B000000244944415478DA63FC7FFFFE7F38F8F7EF
          3F26205A908132EDB410A4BE93069B7B069393008F4C4560520A692E00000000
          49454E44AE426082}
        Style.BackgroundRepeat = cbrRepeatY
        Style.Padding = 2
        Style.FontSize = '11'
        Style.TextAlign = ctaRight
        Style.Cursor = ccuPointer
        Style.Color = White
        Style.FontWeight = cfwBold
        Style.Effects.AntiAliasing = True
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        StyleDown.BorderBottom.Color = 64
        StyleDown.BorderBottom.Style = cbsSolid
        StyleDown.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
          00000108060000001F15C4890000000B4944415478DA63FC0F04000A0003FEDE
          9D70530000000049454E44AE426082}
        StyleDown.BackgroundRepeat = cbrRepeat
        StyleDown.FontSize = '13'
        StyleDown.TextAlign = ctaRight
        StyleDown.Color = Black
        StyleDown.FontWeight = cfwBold
        StyleOver.Border.Color = White
        StyleOver.BorderBottom.Color = 64
        StyleOver.BorderLeft.Color = 64
        StyleOver.BorderRight.Color = 64
        StyleOver.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
          00000108060000001F15C4890000000D4944415478DA63746060F80F00020901
          41B548BD720000000049454E44AE426082}
        StyleOver.BackgroundRepeat = cbrRepeat
        StyleOver.PaddingRight = 6
        StyleOver.MarginLeft = '1'
        StyleOver.MarginRight = '1'
        StyleOver.Color = 8454143
        StyleOver.FontWeight = cfwBold
        StyleOver.BorderRadius.BottomRight = '8'
        StyleOver.BorderRadius.BottomLeft = '8'
        StyleOverDown.BorderBottom.Color = Silver
        StyleOverDown.PaddingRight = 2
        StyleOverDown.Cursor = ccuDefault
        StyleOverDown.Color = Black
        StyleOverDown.TextDecoration = [ctdNone]
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object StyleSheet2: TdhStyleSheet
      Left = 892
      Top = 248
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 216
      ExpandedHeight = 136
      Expanded = False
      object StyleBodycopy: TdhLabel
        Left = 0
        Top = 0
        Height = 22
        Text = 'StyleBodycopy'
        Style.FontSize = '11'
        Style.FontFamily = 'Verdana'
        Style.LineHeight = '22'
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
      object StyleAddress: TdhLabel
        Left = 0
        Top = 22
        Height = 16
        Text = 'StyleAddress'
        Style.FontSize = '11'
        Style.FontFamily = 'Arial'
        Style.LineHeight = '16'
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
    end
    object Menu1: TdhMenu
      Left = 25
      Top = 160
      Width = 160
      Height = 69
      Style.BackgroundImage.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
        00000108060000001F15C4890000000B4944415478DA63FC0F04000A0003FEDE
        9D70530000000049454E44AE426082}
      Style.BackgroundRepeat = cbrRepeat
      AutoSizeXY = asY
      MenuOptions = [moInline, moClickToOpen]
      ReactionTime = 400
      object Link1: TdhLink
        Left = 0
        Top = 0
        Height = 23
        Text = 'Link1'
        Use = MenuStyle1
        AutoSizeXY = asY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page1
        object Menu3: TdhMenu
          Left = 0
          Top = 23
          Height = 69
          Style.BackgroundImage.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
            00000108060000001F15C4890000000B4944415478DA63FC0F04000A0003FEDE
            9D70530000000049454E44AE426082}
          Style.BackgroundRepeat = cbrRepeat
          AutoSizeXY = asY
          Align = alTop
          Right = 0
          MenuOptions = [moInline, moClickToOpen, moResumeOpen]
          ReactionTime = 400
          object Link7: TdhLink
            Left = 0
            Top = 0
            Height = 23
            Text = 'Link7'
            Use = MenuStyle2
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page7
          end
          object Link8: TdhLink
            Left = 0
            Top = 23
            Height = 23
            Text = 'Link8'
            Use = MenuStyle2
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            Layout = ltText
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page8
          end
          object Link9: TdhLink
            Left = 0
            Top = 46
            Height = 23
            Text = 'Link9'
            Use = MenuStyle2
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            Layout = ltText
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page9
          end
        end
      end
      object Link2: TdhLink
        Left = 0
        Top = 23
        Height = 23
        Text = 'Link2'
        Use = MenuStyle1
        AutoSizeXY = asY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page2
      end
      object Link3: TdhLink
        Left = 0
        Top = 46
        Height = 23
        Text = 'Link3'
        Use = MenuStyle1
        AutoSizeXY = asY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page3
        object Menu2: TdhMenu
          Left = 0
          Top = 69
          Height = 69
          Style.BackgroundImage.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
            00000108060000001F15C4890000000B4944415478DA63FC0F04000A0003FEDE
            9D70530000000049454E44AE426082}
          Style.BackgroundRepeat = cbrRepeat
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          MenuOptions = [moInline, moClickToOpen]
          ReactionTime = 400
          object Link4: TdhLink
            Left = 0
            Top = 0
            Height = 23
            Text = 'Link4'
            Use = MenuStyle2
            AutoSizeXY = asY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page4
          end
          object Link5: TdhLink
            Left = 0
            Top = 23
            Height = 23
            Text = 'Link5'
            Use = MenuStyle2
            AutoSizeXY = asY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page5
          end
          object Link6: TdhLink
            Left = 0
            Top = 46
            Height = 23
            Text = 'Link6'
            Use = MenuStyle2
            AutoSizeXY = asY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page6
          end
        end
      end
    end
    object StyleSheet3: TdhStyleSheet
      Left = 896
      Top = 440
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 296
      ExpandedHeight = 104
      Expanded = False
      object HeaderStyle: TdhLabel
        Left = 0
        Top = 0
        Height = 33
        Text = 'HeaderStyle'
        ImageType = bitStretch
        Style.BorderBottom.Color = Silver
        Style.BorderBottom.Style = cbsSolid
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000011600
          0000010802000000948B168F0000002D4944415478DA63646070606060044230
          09A2C0244C048F1444849E5210117A4A110C043A05DDB0F1C8304C0300CC0B01
          775E497C250000000049454E44AE426082}
        Style.BackgroundRepeat = cbrRepeatY
        Style.Padding = 4
        Style.PaddingLeft = 8
        Style.FontSize = '14'
        Style.MarginLeft = '0'
        Style.MarginBottom = '8'
        Style.Color = White
        Style.FontWeight = cfwBold
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        Style.Effects.OuterShadow.Enabled = True
        Style.Effects.OuterShadow.Radius = 4
        Style.Effects.OuterShadow.Color = Gray
        Style.Effects.OuterShadow.Flood = 16
        Style.Effects.OuterShadow.Degree = 86
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
    end
    object Image1: TdhLink
      Left = 513
      Top = 20
      Width = 283
      Height = 117
      Text = 'Your logo'
      ImageType = bitTile
      Style.BackgroundImage.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000011B00
        000001080200000061759D3F000000234944415478DA633C70E0000318303232
        32C000327B90480D42278D7A7F904B0D88BD00B3C102FF81969EA40000000049
        454E44AE426082}
      Style.BackgroundRepeat = cbrRepeatY
      Style.Padding = 20
      Style.FontSize = '36'
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
  end
end
