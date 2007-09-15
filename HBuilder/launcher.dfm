object PageContainer1: TPageContainer1
  Left = -4
  Top = -23
  Width = 1032
  Height = 518
  Caption = 'launcher.dfm'
  Color = clBtnFace
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
    Height = 491
    AutoSizeXY = asNone
    OutputDirectory = 'www\launch\'
    FTPURL = 'ftp://p8288468:5yMTPDtZ@kiegeland.com/dfm2html/launch/'
    HTTPURL = 'http://www.dfm2html.com/launch'
    object PageControl1: TdhPageControl
      Left = 32
      Top = 136
      Width = 24
      Height = 24
      ActivePage = presets
      FixedHeight = False
      object Page1: TdhPage
        Left = 24
        Top = 24
        Width = 416
        Height = 100
        AutoSizeXY = asNone
        ForwardingURL = '../'
        object Label1: TdhLabel
          Left = 16
          Top = 24
          Width = 342
          Height = 18
          Text = 'You are redirected to the DFM2HTML start page..'
          AutoSizeXY = asXY
        end
      end
      object forum: TdhPage
        Left = 24
        Top = 24
        Width = 416
        Height = 100
        AutoSizeXY = asNone
        ForwardingURL = 'http://p105.ezboard.com/bdfm2html'
        object Label2: TdhLabel
          Left = 16
          Top = 24
          Width = 311
          Height = 18
          Text = 'You are redirected to the DFM2HTML forum..'
          AutoSizeXY = asXY
        end
      end
      object register: TdhPage
        Left = 24
        Top = 24
        Width = 416
        Height = 100
        AutoSizeXY = asNone
        ForwardingURL = '../register.html'
        object Label3: TdhLabel
          Left = 16
          Top = 24
          Width = 365
          Height = 18
          Text = 'You are redirected to the DFM2HTML register page..'
          AutoSizeXY = asXY
        end
      end
      object presets: TdhPage
        Left = 24
        Top = 24
        Width = 416
        Height = 100
        AutoSizeXY = asNone
        ForwardingURL = 'http://www.freebits.co.uk/mouseover.html'
        object Label4: TdhLabel
          Left = 16
          Top = 24
          Width = 366
          Height = 18
          Text = 'You are redirected to the DFM2HTML Presets page..'
          AutoSizeXY = asXY
        end
      end
    end
  end
end
