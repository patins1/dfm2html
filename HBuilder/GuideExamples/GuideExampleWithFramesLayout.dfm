object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Width = 1032
  Height = 519
  Caption = 'GuideExampleWithFramesLayout.dfm'
  Font.Charset = GREEK_CHARSET
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
    Tooltip = 'moreto'
    AutoSizeXY = asNone
    UseIFrame = False
    Scrolling = scNo
    DesignSize = (
      1024
      492)
    Right = 0
    Bottom = 0
    object Link1: TdhLink
      Left = 64
      Top = 56
      Width = 35
      Height = 19
      Text = 'Link1'
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page1
    end
    object Link2: TdhLink
      Left = 64
      Top = 80
      Width = 35
      Height = 19
      Tooltip = 'aaadfddlink'
      Text = 'Link2'
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page2
    end
    object Page3: TdhPage
      Left = 232
      Top = 56
      Style.BackgroundColor = Aqua
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight, akBottom]
      UseIFrame = False
      Right = 48
      Bottom = 53
      object PageControl1: TdhPageControl
        Left = 24
        Top = 32
        Width = 24
        Height = 24
        ActivePage = Page1
        FixedHeight = False
        object Page1: TdhPage
          Left = 40
          Top = 72
          Width = 512
          Height = 100
          Style.BackgroundColor = Red
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page2: TdhPage
          Left = 40
          Top = 72
          Width = 512
          Height = 1000
          Style.BackgroundColor = Yellow
          AutoSizeXY = asNone
          UseIFrame = False
        end
      end
    end
  end
end
