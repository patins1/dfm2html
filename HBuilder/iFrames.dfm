object PageContainer1: TPageContainer1
  Left = -4
  Top = -30
  Caption = 'iFrames.dfm'
  ClientHeight = 735
  ClientWidth = 1280
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -21
  Font.Name = 'Rockwell'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 23
  object index: TdhPage
    Left = 0
    Top = 0
    Style.BackgroundImage.Data = {
      0A54504E474F626A65637489504E470D0A1A0A0000000D49484452000004F000
      0000010802000000DF20C7FB000000454944415478DADDCE2102001000C040FE
      FF689220E8376BD736D71AA739AE400A0F450A0F450A0F450A0F1F5078285278
      285278285278F880C24391C24391C24391C2C3931BFFB902FF3D3AFD04000000
      0049454E44AE426082}
    Style.BackgroundRepeat = cbrRepeatY
    Style.FontFamily = 'Arial'
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Title = 'iframes'
    OutputDirectory = 'dfm2html_iframes\'
    object Page1: TdhPage
      Top = 344
      Width = 990
      Height = 414
      Style.Border.Style = cbsSolid
      Style.BackgroundImage.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
        00000108060000001F15C4890000000D4944415478DA63FCDFC0F01F00068502
        80ED3084ED0000000049454E44AE426082}
      Style.BackgroundRepeat = cbrRepeat
      AutoSizeXY = asNone
      Anchors = [akTop]
      UseIFrame = False
      object Page2: TdhPage
        Left = 5
        Top = 5
        Width = 600
        Height = 400
        HTMLAttributes = 'src="http://dfm2html.de"'
        AutoSizeXY = asNone
        UseIFrame = True
      end
      object Memo1: TdhMemo
        Left = 609
        Top = 4
        Width = 376
        Height = 154
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
          00000108060000001F15C4890000000D4944415478DA633C70E0C06A00077502
          ED9A1395570000000049454E44AE426082}
        Style.BackgroundRepeat = cbrRepeat
        AutoSizeXY = asNone
        ReadOnly = True
        Text = 
          'object Page2: TdhPage '#10'Left = 5 '#10'Top = 5'#10'Width = 600'#10'Height = 40' +
          '0'#10'HTMLAttributes = '#8216'src='#8220'http://dfm2html.de'#8220#8217#10'AutoSizeXY = asNon' +
          'e '#10'UseIFrame = True '#10'end '
      end
    end
    object Page3: TdhPage
      Top = 5
      Width = 990
      Height = 338
      AutoSizeXY = asNone
      Anchors = [akTop]
      UseIFrame = False
      object Label1: TdhLabel
        Top = 6
        Width = 916
        Height = 323
        Text = 
          '<b><center>Der Trick mit den '#8222'iFrames'#8220':</center></b><br/>'#10'Man ka' +
          'nn entweder eine Text Webseite oder eine Fotoshow, ein G'#228'stebuch' +
          ' oder eine v'#246'llig andere '#10'homepage von jedem x-beliebigen Server' +
          'platz in der eigenen Seite anzeigen lassen. '#10'Auch wenn die eigen' +
          'e Seite sehr umfangreiche und/oder h'#228'ufig zu '#228'ndernde Inhalte ha' +
          't, '#10'lassen diese sich so '#8211' quasi als '#8222'sub-page'#8220' - elegant '#8222'ausla' +
          'gern'#8220' und getrennt bearbeiten.<br/>'#10'Und so geht'#39's:'#10'<blockquote><' +
          'b>1. Ein Objekt (page, panel od. DHTML-Men'#252') erstellen, auf der ' +
          'das Ziel zu sehen sein soll.<br/>'#10'2. Unten stehendes Script als ' +
          'Text kopieren.<br/>'#10'3. '#220'ber "Bearbeiten" -> "Einf'#252'gen" in Objekt' +
          ' einf'#252'gen.<br/>'#10'4. H'#246'he, Breite und Position k'#246'nnen nun noch, wi' +
          'e gewohnt, im "Pos."-Tab editiert werden.<br/>'#10'5. Die Ziel-URL k' +
          'ann '#252'ber "Mehr"-Tab -> "Spezielle Stile" im "zus'#228'tzliche HTML-At' +
          'tribute"-Feld '#10'ge'#228'ndert werden.<br/></b></blockquote>'#10'Das war'#8217's ' +
          'schon.<br/><br/>'#10#10'Im Zuge der Komplettpaket Angebote der Anbiete' +
          'r erh'#228'lt man oft eine kostenlose Domain'#10' dazu. Die ist aber meis' +
          't nicht php-f'#228'hig. Man kann also weder Formulare,'#10'noch G'#228'steb'#252'ch' +
          'er verwenden, h'#246'chstens die von den jeweiligen Anbietern '#10'angebo' +
          'tenen CGI-Programme, die aber ein v'#246'llig anderes Erscheinungsbil' +
          'd haben. '#10'Hat man aber die M'#246'glichkeit/Erlaubnis auf irgendeinem' +
          ' php-f'#228'higen Server seine Dateien'#10' abzulegen '#8211' Bingo, dank '#8222'iFra' +
          'mes'#8220'.'
        Style.FontSize = '14'
        Style.FontFamily = 'Rockwell'
        AutoSizeXY = asY
        Anchors = [akTop]
      end
    end
  end
end
