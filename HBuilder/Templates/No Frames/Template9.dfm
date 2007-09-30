object PageContainer10: TPageContainer10
  Left = -4
  Top = -23
  Width = 1608
  Height = 751
  Caption = 'Template9.dfm'
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
    Style.BackgroundColor = 7098686
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    DesignSize = (
      1600
      724)
    object Panel4: TdhPanel
      Left = 232
      Top = 224
      Width = 160
      Height = 168
      Style.BackgroundColor = White
      Style.BorderRadius.All = '21'
      AutoSizeXY = asNone
    end
    object Panel3: TdhPanel
      Left = 256
      Top = 8
      Width = 192
      Height = 152
      Style.BackgroundColor = 4259584
      Style.BorderRadius.All = '21'
      AutoSizeXY = asNone
    end
    object Panel1: TdhPanel
      Left = 24
      Top = 8
      Width = 352
      Height = 304
      Style.Border.Width = 16
      Style.Border.Color = Red
      Style.Border.Style = cbsDashed
      Style.Margin = '20'
      Style.BackgroundColor = Yellow
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      Style.Effects.Alpha = 140
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 255
      Style.Effects.OuterShadow.Radius = 18
      Style.Effects.OuterShadow.Flood = 34
      Style.Effects.OuterShadow.Distance = 8
      Style.BorderRadius.All = '80'
      AutoSizeXY = asNone
    end
    object Panel2: TdhPanel
      Left = 280
      Top = 72
      Height = 656
      Style.Margin = '15'
      Style.BackgroundColor = 13086100
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      Style.Effects.Alpha = 133
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 255
      Style.Effects.OuterShadow.Radius = 8
      Style.Effects.OuterShadow.Flood = 23
      Style.Effects.OuterShadow.Distance = 6
      Style.BorderRadius.All = '45'
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight]
      Right = 32
      object PageControl1: TdhPageControl
        Left = 120
        Top = 48
        Width = 24
        Height = 24
        ActivePage = Page1
        FixedHeight = False
        object Page1: TdhPage
          Left = 120
          Top = 48
          Width = 552
          Height = 560
          AutoSizeXY = asNone
          UseIFrame = False
          object Label1: TdhLabel
            Left = 40
            Top = 24
            Width = 100
            Height = 18
            Text = 'Home'
            AutoSizeXY = asY
          end
          object Label4: TdhLabel
            Left = 40
            Top = 64
            Width = 480
            Height = 162
            Text = 
              'This template demonstrates the semi-transparency feature of DFM2' +
              'HTML. '#10'<br/><br/>'#10'By default, generated images for HTML pages ar' +
              'e GIF images, which are not semi-transparent. You can choose to ' +
              'use PNG as image format in the Object tab. However in most cases' +
              ' (esp. when there is no much semi-transparency) , generated GIF ' +
              'images are smaller in size than generated 32-bit PNG images.'
            AutoSizeXY = asY
          end
        end
        object Page2: TdhPage
          Left = 120
          Top = 48
          Width = 552
          Height = 460
          AutoSizeXY = asNone
          UseIFrame = False
          object Label2: TdhLabel
            Left = 40
            Top = 24
            Width = 100
            Height = 18
            Text = 'Links'
            AutoSizeXY = asY
          end
        end
        object Page3: TdhPage
          Left = 120
          Top = 48
          Width = 552
          Height = 360
          AutoSizeXY = asNone
          UseIFrame = False
          object Label3: TdhLabel
            Left = 40
            Top = 24
            Width = 100
            Height = 18
            Text = 'Contact'
            AutoSizeXY = asY
          end
        end
      end
    end
    object Link1: TdhLink
      Left = 240
      Top = 312
      Width = 51
      Height = 18
      Text = 'Home'
      Style.FontWeight = cfwBold
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page1
    end
    object Link2: TdhLink
      Left = 240
      Top = 336
      Width = 44
      Height = 18
      Text = 'Links'
      Style.FontWeight = cfwBold
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page2
    end
    object Link3: TdhLink
      Left = 240
      Top = 360
      Width = 68
      Height = 18
      Text = 'Contact'
      Style.FontWeight = cfwBold
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page3
    end
  end
end
