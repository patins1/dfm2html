object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Width = 808
  Height = 350
  Caption = 'kieghomepage.dfm'
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
    Width = 800
    Height = 323
    AutoSizeXY = asNone
    FTPURL = 'ftp://p8288468:5yMTPDtZ@kiegeland.com/'
    HTTPURL = 'http://www.kiegeland.com/'
    object Label5: TdhLabel
      Left = 48
      Top = 120
      Width = 139
      Height = 190
      Text = 
        'Copyright '#169' 2005<br/>'#10'J'#246'rg Kiegeland<br/>'#10'Software Development<b' +
        'r/>'#10'<br/>'#10'Auerstr. 7 C<br/>'#10'27574 Bremerhaven<br/>'#10'Germany<br/>'#10 +
        '<br/>'#10#10'E-mail:<br/>'#10'admin@kiegeland.com<br/>'
      Style.FontFamily = 'Times New Roman'
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.TextOnly = False
      AutoSizeXY = asXY
    end
    object Label1: TdhLabel
      Left = 40
      Top = 24
      Width = 721
      Height = 43
      Text = 'Dies ist die Homepage von J'#246'rg Kiegeland'
      Style.FontSize = '36'
      Style.FontFamily = 'Arial'
      Style.FontWeight = cfwBold
      AutoSizeXY = asXY
    end
  end
end
