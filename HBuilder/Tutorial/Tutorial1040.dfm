object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Caption = 'Tutorial1040.dfm'
  ClientHeight = 726
  ClientWidth = 1600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Times New Roman'
  Font.Pitch = fpVariable
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 15
  object tutorial: TdhPage
    Left = 0
    Top = 0
    Style.Border.Width = 0
    Style.Border.Style = cbsSolid
    Style.BackgroundImage.Path = 'Images\tutorial_nm.png'
    Style.BackgroundImage.State = isAnalyzed
    Style.BackgroundImage.Width = 796
    Style.BackgroundImage.Height = 1
    Style.BackgroundRepeat = cbrRepeatY
    Style.Padding = 10
    Style.Margin = '20'
    Style.FontFamily = 'Arial'
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Title = 'Tutorial'
    OutputDirectory = 'tutorial\'
    MetaAuthor = 'J'#246'rg Kiegeland'
    MetaDescription = 'DFM2HTML Tutorial'
    object Panel6: TdhPanel
      Left = 16
      Top = 88
      Width = 296
      Height = 416
      Style.Border.Width = 18
      Style.Border.Color = 33023
      Style.Border.Style = cbsDouble
      Style.Margin = '11'
      Style.BackgroundColor = 33023
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.InnerShadow.Alpha = 128
      Style.Effects.InnerShadow.Radius = 2
      Style.Effects.InnerShadow.Color = White
      Style.Effects.InnerShadow.Degree = 131
      Style.Effects.InnerShadow.Distance = 1
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Degree = 131
      Style.Effects.OuterShadow.Distance = 4
      Style.BorderRadius.All = '11'
      AutoSizeXY = asNone
      object TdhAnchor7: TdhLink
        Left = 48
        Top = 128
        Width = 59
        Height = 16
        Text = 'Moduli'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor12
      end
      object TdhAnchor6: TdhLink
        Left = 48
        Top = 272
        Width = 71
        Height = 16
        Text = 'Stili Vari'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor10
      end
      object TdhAnchor5: TdhLink
        Left = 48
        Top = 256
        Width = 52
        Height = 16
        Text = 'Effetti'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor9
      end
      object TdhAnchor4: TdhLink
        Left = 48
        Top = 224
        Width = 76
        Height = 16
        Text = 'Immagini'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor8
      end
      object TdhAnchor3: TdhLink
        Left = 48
        Top = 192
        Width = 40
        Height = 16
        Text = 'Lati'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor7
      end
      object TdhAnchor2: TdhLink
        Left = 48
        Top = 176
        Width = 142
        Height = 16
        Text = 'Formattazione testo'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor4
      end
      object TdhAnchor1: TdhLink
        Left = 32
        Top = 64
        Width = 159
        Height = 16
        Text = 'Posizionare gli oggetti'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor5
      end
      object TdhAnchor9: TdhLink
        Left = 48
        Top = 144
        Width = 95
        Height = 16
        Text = 'Navigazione'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = TdhAnchor8
      end
      object TdhLink1: TdhLink
        Left = 48
        Top = 304
        Width = 129
        Height = 16
        Text = 'Gestire stili e stati'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor11
      end
      object TdhLink2: TdhLink
        Left = 32
        Top = 48
        Width = 62
        Height = 16
        Text = 'Oggetti'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = TdhLabel5
      end
      object Link1: TdhLink
        Left = 32
        Top = 80
        Width = 108
        Height = 16
        Text = 'Tipi di oggetto'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label13
      end
      object Link4: TdhLink
        Left = 32
        Top = 32
        Width = 209
        Height = 16
        Text = 'Informazioni su questo tutorial'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label15
      end
      object Link5: TdhLink
        Left = 48
        Top = 288
        Width = 114
        Height = 16
        Text = 'Ri-usare gli stili'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label18
      end
      object Link6: TdhLink
        Left = 32
        Top = 160
        Width = 129
        Height = 16
        Text = 'Stile degli oggetti'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label20
      end
      object Link9: TdhLink
        Left = 48
        Top = 112
        Width = 43
        Height = 16
        Text = 'Link'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label23
      end
      object Link14: TdhLink
        Left = 48
        Top = 240
        Width = 54
        Height = 16
        Text = 'Colori'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label26
      end
      object Link16: TdhLink
        Left = 48
        Top = 96
        Width = 71
        Height = 16
        Text = 'Etichette'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label32
      end
      object Link17: TdhLink
        Left = 32
        Top = 336
        Width = 188
        Height = 16
        Text = 'Pubblicazione del progetto'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label43
      end
      object Link18: TdhLink
        Left = 48
        Top = 208
        Width = 132
        Height = 16
        Text = 'Angoli Arrotondati'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label37
      end
      object Link19: TdhLink
        Left = 32
        Top = 352
        Width = 219
        Height = 16
        Text = 'Condivisione risorse DFM2HTML'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label35
      end
      object Link20: TdhLink
        Left = 32
        Top = 320
        Width = 43
        Height = 16
        Text = 'PHP'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label45
      end
    end
    object StyleSheet2: TdhStyleSheet
      Left = 439
      Top = 56
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 224
      ExpandedHeight = 232
      Expanded = False
      object tab: TdhLabel
        Left = 0
        Top = 0
        Height = 22
        Text = 'tab'
        Style.BackgroundImage.Path = 'Images\tab_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 47
        Style.BackgroundImage.Height = 18
        Style.BackgroundRepeat = cbrNoRepeat
        Style.Padding = 3
        Style.FontSize = '11'
        Style.FontFamily = 'Microsoft Sans Serif'
        Style.LineHeight = '150%'
        Style.Effects.Rotation = 120
        AutoSizeXY = asY
        Align = alTop
        Right = 20
      end
      object chapter: TdhLink
        Left = 0
        Top = 22
        Height = 16
        Text = 'chapter'
        Style.Color = Black
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object pad: TdhLabel
        Left = 0
        Top = 38
        Height = 26
        Text = 'pad'
        Style.Padding = 5
        AutoSizeXY = asY
        Align = alTop
        Right = 16
      end
      object Label3: TdhLabel
        Left = 0
        Top = 64
        Height = 16
        Text = 'Label3'
        Style.Color = Red
        AutoSizeXY = asY
        Align = alTop
      end
      object Link2: TdhLink
        Left = 0
        Top = 80
        Height = 16
        Text = 'Link2'
        Style.BackgroundImage.Path = 'Images\Link2_nm.png'
        Style.BackgroundImage.State = isSemiTransparent
        Style.BackgroundImage.Width = 50
        Style.BackgroundImage.Height = 50
        Style.BackgroundRepeat = cbrNoRepeat
        Style.Padding = 0
        Style.PaddingLeft = 16
        Style.Color = Black
        Style.FontWeight = cfwBold
        Style.TextDecoration = [ctdNone]
        AutoSizeXY = asXY
        Align = alTop
        Right = 10
        StyleOver.BackgroundImage.Path = 'Images\Link2_ov.png'
        StyleOver.BackgroundPosition = '0% 0%'
        StyleOver.TextDecoration = [ctdUnderline]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Link7: TdhLink
        Left = 0
        Top = 96
        Height = 16
        Text = 'Link7'
        Style.BackgroundImage.Path = 'Images\Link7_nm.png'
        Style.BackgroundImage.State = isSemiTransparent
        Style.BackgroundImage.Width = 50
        Style.BackgroundImage.Height = 50
        Use = Link2
        AutoSizeXY = asXY
        Align = alTop
        Right = 10
        StyleOver.BackgroundImage.Path = 'Images\Link7_ov.png'
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object Text5: TdhLabel
      Left = 24
      Top = 760
      Width = 624
      Height = 395
      Text = 
        'Per posizionare un oggetto selezionalo con il mouse e trascinalo' +
        ' nella posizione desiderata. Per opzione predefinita l'#39'oggetto v' +
        'iene allineato alla griglia, questo si pu'#242' evitare tenendo premu' +
        'to il tasto ALT. <br/><br/>'#10'Nella scheda <tab>&nbsp;&nbsp;&nbsp;' +
        '&nbsp;Pos.&nbsp;&nbsp;&nbsp;</tab> puoi impostare parametri di p' +
        'osizionamento pi'#249' accurati.'#10'Nella sezione <b>Coordinate</b> puoi' +
        ' impostare le coordinate X/Y dell'#39'oggetto (valori <b>sinistra</b' +
        '> e <b>alto</b>).'#10'<br/><br/>'#10'Per opzione predefinita, la distanz' +
        'a di un oggetto dai lati alto e sinistro dell'#39'oggetto genitore '#232 +
        ' fissa.'#10'Pertanto se, per esempio, la larghezza dell'#39'oggetto geni' +
        'tore viene aumentata, la distanza dell'#39'oggetto figlio dal lato s' +
        'inistro dell'#39'oggetto genitore non cambia, mentre la distanza dal' +
        ' lato destro dell'#39'oggetto genitore aumenta di conseguenza.'#10'Nella' +
        ' sezione <nobr><b>Tieni distanza costante da</b></nobr> puoi imp' +
        'ostare il lato del genitore da cui la distanza verr'#224' mantenuta c' +
        'ostante.'#10'Un caso speciale si ha se non viene stabilita alcuna di' +
        'stanza fissa dal lato genitore sinistro n'#232' da quello destro. In ' +
        'tal caso, l'#39'oggetto sar'#224' centrato orizzontalmente.'#10'<br>'#10'<br>'#10'Puo' +
        'i allineare un oggetto ad un lato del genitore o alla sua intera' +
        ' area nella sezione <b>Allineamento</b>.'#10'Il valore predefinito '#232 +
        ' <b>Nessuno</b>, e significa che l'#39'oggetto viene posizionato in ' +
        'modo assoluto (posizionato tramite coordinate).'#10'In caso contrari' +
        'o, tutti gli oggetti figlio con un valore pari ad <b>Alto</b> ve' +
        'ngono staccati, a partire dal lato genitore alto in giu. In HTML' +
        ', questo corrisponde al normale flow of block elements.'#10'Comunque' +
        ', in DFM2HTML puoi anche distanziare gli oggetti figlio partendo' +
        ' dal lato genitore sinistro, destro, o basso.'#10'<br/><br/>'#10'Nella s' +
        'ezione <b>Coordinate</b> puoi impostare larghezza ed altezza di ' +
        'un oggetto.'#10'Alcuni oggetti possono adattare le loro dimensioni a' +
        'l contenuto, pertanto non sar'#224' necessario impostare valori di la' +
        'rghezza ed altezza dell'#39'oggetto. Controlla il ridimensionamento ' +
        'automatico usando le opzioni <b>Largh. auto</b></nobr> ed <nobr>' +
        '<b>Alt. auto</b></nobr>.'
      Use = pad
      AutoSizeXY = asY
    end
    object TdhLabel2: TdhLabel
      Left = 24
      Top = 3816
      Width = 777
      Height = 59
      Text = 
        'Nella scheda <tab>&nbsp;&nbsp;&nbsp;Font&nbsp;&nbsp;&nbsp;&nbsp;' +
        '</tab> puoi formattare il testo scegliendo un font'#10'ed un colore ' +
        'di sfondo.<br/>'#10'Modificando il font di un oggetto, i figli di qu' +
        'ell'#39'oggetto ereditano le impostazioni del font (se non hanno una' +
        ' propria definizione di font).<br/>'#10'Esempi per diversi font:'
      Use = pad
      AutoSizeXY = asXY
    end
    object Text6: TdhLabel
      Left = 24
      Top = 3888
      Width = 154
      Height = 27
      Text = 'Courier New'
      Style.FontSize = '24'
      Style.FontFamily = 'Courier New'
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
    end
    object TdhLabel3: TdhLabel
      Left = 24
      Top = 3912
      Width = 179
      Height = 35
      Text = 'Comic Sans MS'
      Style.FontSize = '24'
      Style.FontFamily = 'Comic Sans MS'
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
    end
    object TdhLabel4: TdhLabel
      Left = 24
      Top = 3952
      Width = 193
      Height = 28
      Text = 'Times New Roman'
      Style.FontSize = '24'
      Style.Margin = '1'
      Style.FontFamily = 'Times New Roman'
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
    end
    object Panel1: TdhPanel
      Left = 304
      Top = 3880
      Width = 240
      Height = 108
      Style.Border.Width = 2
      Style.Border.Color = White
      Style.Border.Style = cbsOutset
      Style.FontSize = '16'
      Style.BackgroundColor = Silver
      Style.FontFamily = 'Comic Sans MS'
      Style.FontStyle = cfsItalic
      Style.FontWeight = cfwBold
      AutoSizeXY = asNone
      object Text7: TdhLabel
        Left = 8
        Top = 8
        Width = 112
        Height = 23
        Text = 'Questo font'
        Style.BackgroundColor = 65408
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        AutoSizeXY = asY
      end
      object Text8: TdhLabel
        Left = 24
        Top = 32
        Width = 120
        Height = 23
        Text = '.. '#232' definito'
        Style.BackgroundColor = Yellow
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        AutoSizeXY = asY
      end
      object Text9: TdhLabel
        Left = 40
        Top = 56
        Width = 144
        Height = 23
        Text = '.. dal genitore'
        Style.BackgroundColor = Red
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        AutoSizeXY = asY
      end
      object Text10: TdhLabel
        Left = 56
        Top = 80
        Width = 168
        Height = 23
        Text = '.. oggetto container'
        Style.BackgroundColor = Aqua
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        AutoSizeXY = asY
      end
    end
    object TdhLabel6: TdhLabel
      Left = 24
      Top = 4006
      Width = 688
      Height = 27
      Text = 
        'Nota che in questi esempi il font ha l'#39'anti-aliasing. Questa fun' +
        'zione si pu'#242' attivare nella scheda <tab>&nbsp;&nbsp;Effetto&nbsp' +
        ';&nbsp;&nbsp;</tab>'
      Use = pad
      AutoSizeXY = asY
    end
    object TdhLabel8: TdhLabel
      Left = 24
      Top = 4093
      Width = 552
      Height = 75
      Text = 
        'Nella scheda <tab>&nbsp;&nbsp;&nbsp;Lato&nbsp;&nbsp;&nbsp;</tab>' +
        ' puoi impostare margine, bordo, e valore di padding per <b>tutti' +
        '</b> i lati, o per il lato <b>sinistro</b> / <b>alto</b> / <b>ba' +
        'sso</b> / <b>destro</b> separatamente. Il grafico seguente mostr' +
        'a dove vengono collocati margine, bordo e area padding di un ogg' +
        'etto (l'#39'area margine include l'#39'area bordo, l'#39'area bordo include ' +
        'l'#39'area padding, e l'#39'area padding include l'#39'area del contenuto):'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet3: TdhStyleSheet
      Left = 608
      Top = 4264
      Width = 28
      Height = 28
      Expanded = False
      VertPosition = 18
      ExpandedWidth = 144
      ExpandedHeight = 160
      Expanded = False
      object Label4: TdhLabel
        Left = 0
        Top = -18
        Height = 18
        Text = 'Label4'
        Style.Border.Width = 1
        Style.Border.Style = cbsNone
        Style.BorderLeft.Style = cbsNone
        Style.BorderRight.Style = cbsNone
        Style.Padding = 1
        Style.Margin = '0'
        Style.TextAlign = ctaLeft
        Style.FontWeight = cfwBold
        Style.Effects.Alpha = 194
        AutoSizeXY = asY
        Align = alTop
        Right = 24
      end
    end
    object Panel4: TdhPanel
      Left = 48
      Top = 4224
      Width = 504
      Height = 216
      Style.Border.Width = 1
      Style.Border.Style = cbsDotted
      AutoSizeXY = asNone
      object Panel2: TdhPanel
        Left = 1
        Top = 1
        Style.Border.Width = 20
        Style.Border.Color = Red
        Style.Border.Style = cbsDashed
        Style.Padding = 20
        Style.Margin = '20'
        Style.BackgroundColor = Aqua
        AutoSizeXY = asNone
        Align = alClient
        Right = 1
        Bottom = 1
        object Panel3: TdhPanel
          Left = 60
          Top = 60
          Style.BackgroundColor = White
          AutoSizeXY = asNone
          Align = alClient
          Right = 60
          Bottom = 60
        end
      end
      object TdhLabel11: TdhLabel
        Left = 67
        Top = 62
        Width = 362
        Height = 18
        Text = 'contenuto: testo o oggetti figlio vengono renderizzati qui'
        Style.BackgroundColor = Transparent
        Style.Effects.Rotation = 120
        Use = Label4
        AutoSizeXY = asXY
      end
      object TdhLabel10: TdhLabel
        Left = 51
        Top = 42
        Width = 405
        Height = 18
        Text = 'padding: colore o immagine di sfondo compaiono in quest'#39'area'
        Style.BackgroundColor = Transparent
        Use = Label4
        AutoSizeXY = asXY
      end
      object Text11: TdhLabel
        Left = 51
        Top = 22
        Width = 336
        Height = 18
        Text = 'bordo: ogni lato pu'#242' avere uno stile di bordo diverso'
        Style.BackgroundColor = Transparent
        Use = Label4
        AutoSizeXY = asXY
      end
      object TdhLabel9: TdhLabel
        Left = 51
        Top = 2
        Width = 223
        Height = 18
        Text = 'margine: '#233' trasparente per l'#39'utente'
        Style.BackgroundColor = Transparent
        Style.Effects.Rotation = 120
        Use = Label4
        AutoSizeXY = asXY
      end
    end
    object Text12: TdhLabel
      Left = 558
      Top = 4219
      Width = 27
      Height = 234
      Text = 
        '&lt;------altezza, vedi pagina <tab>&nbsp;&nbsp;Pos.&nbsp;&nbsp;' +
        '&nbsp;</tab> -----&gt;'
      Style.Effects.Rotation = 90
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      Use = pad
      AutoSizeXY = asXY
    end
    object TdhLabel12: TdhLabel
      Left = 38
      Top = 4442
      Width = 546
      Height = 27
      Text = 
        '&lt;-----------------------------------------larghezza, vedi pag' +
        'ina <tab>&nbsp;&nbsp;&nbsp;Pos.&nbsp;&nbsp;&nbsp;&nbsp;</tab> --' +
        '-----------------------------------------&gt;'
      Use = pad
      AutoSizeXY = asXY
    end
    object TdhLabel14: TdhLabel
      Left = 24
      Top = 4730
      Width = 680
      Height = 91
      Text = 
        'Puoi assegnare uno sfondo a qualsiasi oggetto visuale nella sche' +
        'da <tab>&nbsp;&nbsp;Immag.&nbsp;&nbsp;</tab> Lo sfondo compare d' +
        'ietro qualsiasi contenuto testuale o oggetto figlio. '#10'Puoi affia' +
        'ncare l'#39'immagine di sfondo (<b>tipo=affiancato</b>), adattare l'#39 +
        'immagine di sfondo (<b>tipo=adattato</b>), o dividere l'#39'immagine' +
        ' di sfondo (<b>tipo=diviso</b>). Oppure pu'#242' essere '#10'l'#39'immagine s' +
        'celta come sfondo che determina la dimensione '#10'dell'#39'oggetto (<b>' +
        'tipo=immagine</b>). '#10'Se scegli il tipo <b>affiancato</b> puoi de' +
        'finire il punto in cui inizia l'#39'affiancamento e la direzione in ' +
        'cui affiancare. Esempi:'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet4: TdhStyleSheet
      Left = 592
      Top = 4656
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 144
      ExpandedHeight = 100
      Expanded = False
      object Label8: TdhLabel
        Left = 0
        Top = 0
        Height = 36
        Text = 'Label8'
        Style.Border.Width = 1
        Style.Border.Style = cbsSolid
        Style.BackgroundImage.Path = 'Images\Label8_nm.gif'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 110
        Style.BackgroundImage.Height = 40
        Style.BackgroundPosition = '0% 0%'
        Style.Padding = 8
        Style.FontSize = '16'
        Style.TextAlign = ctaCenter
        Style.Color = White
        Style.FontStyle = cfsItalic
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
        Align = alTop
        Right = 8
      end
      object Link13: TdhLink
        Left = 0
        Top = 36
        Height = 24
        Text = 'Link13'
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        Right = 4
        Layout = ltButton
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object Text13: TdhLabel
      Left = 32
      Top = 4840
      Width = 144
      Height = 128
      Text = 'affiancato in <nobr>direzione x/y</nobr>'
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object TdhLabel15: TdhLabel
      Left = 184
      Top = 4840
      Width = 144
      Height = 128
      Text = 'affiancato in <nobr>direzione y</nobr>, centrato'
      Style.BackgroundPosition = '50% 0%'
      Style.BackgroundRepeat = cbrRepeatY
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object TdhLabel16: TdhLabel
      Left = 456
      Top = 4840
      Width = 144
      Height = 128
      Text = 'adattato'
      ImageType = bitStretch
      Style.BackgroundPosition = '52% 52%'
      Style.BackgroundRepeat = cbrRepeatY
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object TdhLabel17: TdhLabel
      Left = 24
      Top = 5376
      Width = 568
      Height = 59
      Text = 
        'Se hai attivato gli effetti nella scheda <tab>&nbsp;&nbsp;Effett' +
        'o&nbsp;&nbsp;&nbsp;</tab> '#10'l'#39'oggetto viene rasterizzato e salvat' +
        'o come immagine nel file HTML. Ora puoi applicare diversi effett' +
        'i'#10'come rotazione / scalatura / opacit'#224' / sfocatura / ombreggiatu' +
        'ra / emissione, provali tutti. Ecco alcuni effetti:'
      Use = pad
      AutoSizeXY = asY
    end
    object Pulsante1: TdhLink
      Left = 40
      Top = 5496
      Width = 74
      Height = 74
      Text = 'Pulsante1'
      Style.Cursor = ccuDefault
      Style.Effects.Rotation = 315
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
      Layout = ltButton
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'javascript:alert(this.id+'#39' '#232' stato premuto'#39')'
    end
    object Text14: TdhLabel
      Left = 40
      Top = 5456
      Width = 96
      Height = 32
      Text = 'Un pulsante, ruotato di 45'#176
      AutoSizeXY = asY
    end
    object Text16: TdhLabel
      Left = 312
      Top = 5456
      Width = 120
      Height = 32
      Text = 'Un link, che dice "Ciao" se cliccato:'
      AutoSizeXY = asY
    end
    object Link3: TdhLink
      Left = 312
      Top = 5496
      Width = 76
      Height = 53
      Text = 'Ciao'
      Style.FontSize = '24'
      Style.Margin = '12'
      Style.Color = White
      Style.FontWeight = cfwBold
      Style.TextDecoration = [ctdNone]
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 196
      Style.Effects.OuterShadow.Radius = 7
      Style.Effects.OuterShadow.Distance = 9
      Style.Effects.OuterGlow.Enabled = True
      Style.Effects.OuterGlow.Alpha = 186
      Style.Effects.OuterGlow.Radius = 2
      Style.Effects.OuterGlow.Color = Black
      Style.Effects.OuterGlow.Flood = 54
      AutoSizeXY = asXY
      StyleDown.Padding = 2
      StyleDown.Effects.Enabled = True
      StyleDown.Effects.AntiAliasing = True
      StyleDown.Effects.Text = etInclude
      StyleDown.Effects.OuterShadow.Enabled = True
      StyleDown.Effects.OuterShadow.Alpha = 196
      StyleDown.Effects.OuterShadow.Radius = 7
      StyleDown.Effects.OuterShadow.Distance = 7
      StyleDown.Effects.OuterGlow.Enabled = True
      StyleDown.Effects.OuterGlow.Alpha = 186
      StyleDown.Effects.OuterGlow.Radius = 2
      StyleDown.Effects.OuterGlow.Color = Black
      StyleDown.Effects.OuterGlow.Flood = 54
      StyleOver.TextDecoration = [ctdUnderline]
      StyleOver.Effects.OuterShadow.Enabled = True
      StyleOver.Effects.OuterShadow.Alpha = 255
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'javascript:alert('#39'Ciao'#39')'
    end
    object Panel5: TdhPanel
      Left = 136
      Top = 5488
      Width = 104
      Height = 88
      Style.Border.Width = 2
      Style.Border.Color = White
      Style.Border.Style = cbsOutset
      Style.Margin = '12'
      Style.BackgroundColor = Silver
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 212
      Style.Effects.OuterShadow.Radius = 7
      AutoSizeXY = asNone
    end
    object TdhLabel19: TdhLabel
      Left = 144
      Top = 5456
      Width = 152
      Height = 32
      Text = 'Un contenitore con bordo, dotato di ombreggiatura'
      AutoSizeXY = asY
    end
    object TdhLabel21: TdhLabel
      Left = 24
      Top = 5634
      Width = 480
      Height = 43
      Text = 
        'Molti diversi stili sono disponibili nella scheda <tab>&nbsp;&nb' +
        'sp;&nbsp;Varie&nbsp;&nbsp;&nbsp;&nbsp;</tab> prevalentemente rel' +
        'ativi alla formattazione del testo. Per ognuno viene fornito un ' +
        'breve esempio:'
      Use = pad
      AutoSizeXY = asY
    end
    object Text15: TdhLabel
      Left = 32
      Top = 5688
      Width = 80
      Height = 16
      Text = 'variante-font:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object Text17: TdhLabel
      Left = 120
      Top = 5688
      Width = 372
      Height = 16
      Text = 'Testo formattato con la variante-font = maiuscolo piccolo'
      Style.FontVariant = cfvSmallCaps
      AutoSizeXY = asXY
    end
    object TdhLabel22: TdhLabel
      Left = 16
      Top = 5720
      Width = 96
      Height = 16
      Text = 'trasforma-testo:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel23: TdhLabel
      Left = 120
      Top = 5720
      Width = 338
      Height = 16
      Text = 'Testo formattato con trasforma-testo = iniziali maiuscole'
      Style.TextTransform = cttCapitalize
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
    end
    object TdhLabel24: TdhLabel
      Left = 32
      Top = 5752
      Width = 80
      Height = 16
      Text = 'spazi-bianchi:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel25: TdhLabel
      Left = 120
      Top = 5752
      Width = 519
      Height = 16
      Text = 
        'Testo formattato con spazi-bianchi = pre        gli spazi vuoti ' +
        '   non   vengono       eliminati.'
      Style.WhiteSpace = cwsPre
      AutoSizeXY = asXY
    end
    object TdhLabel26: TdhLabel
      Left = 32
      Top = 5784
      Width = 80
      Height = 16
      Text = 'direzione:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object Edit1: TdhEdit
      Left = 120
      Top = 5784
      Width = 208
      Height = 23
      Style.Direction = cdiRtl
      AutoSizeXY = asY
      Text = 'da destra a sinistra'
    end
    object TdhLabel27: TdhLabel
      Left = 32
      Top = 5824
      Width = 80
      Height = 16
      Text = 'allinea-testo:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel28: TdhLabel
      Left = 120
      Top = 5824
      Width = 160
      Height = 66
      Text = 
        'Testo formattato con la propriet'#224' allineamento testo impostata s' +
        'u "giustificato".'
      Style.Border.Width = 1
      Style.Border.Style = cbsSolid
      Style.TextAlign = ctaJustify
      AutoSizeXY = asY
    end
    object TdhLabel29: TdhLabel
      Left = 32
      Top = 5904
      Width = 80
      Height = 16
      Text = 'cursore:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel30: TdhLabel
      Left = 120
      Top = 5904
      Width = 383
      Height = 16
      Text = 
        'Muovendo il cursore su questo testo appare un punto interrogativ' +
        'o.'
      Style.Cursor = ccuHelp
      AutoSizeXY = asXY
    end
    object TdhLabel31: TdhLabel
      Left = 32
      Top = 5936
      Width = 80
      Height = 16
      Text = 'z-index:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object dhAnchor112: TdhLink
      Left = 288
      Top = 6008
      Width = 116
      Height = 56
      Text = 'dhAnchor112'
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor113: TdhLink
      Left = 160
      Top = 6040
      Width = 116
      Height = 56
      Text = 'dhAnchor113'
      Style.BackgroundColor = Blue
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor114: TdhLink
      Left = 264
      Top = 6048
      Width = 116
      Height = 56
      Text = 'dhAnchor114'
      Style.BackgroundColor = Lime
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor115: TdhLink
      Left = 336
      Top = 6040
      Width = 116
      Height = 56
      Text = 'dhAnchor115'
      Style.BackgroundColor = Fuchsia
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor116: TdhLink
      Left = 208
      Top = 6032
      Width = 116
      Height = 56
      Text = 'dhAnchor116'
      Style.BackgroundColor = Green
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor117: TdhLink
      Left = 192
      Top = 6000
      Width = 116
      Height = 56
      Text = 'dhAnchor117'
      Style.BackgroundColor = Aqua
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhStyleSheet6: TdhStyleSheet
      Left = 520
      Top = 5976
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 169
      ExpandedHeight = 105
      Expanded = False
      object dhRule27: TdhLink
        Left = 0
        Top = 0
        Height = 56
        Text = 'dhRule27'
        ImageFormat = ifSimple
        Style.Padding = 20
        Style.BackgroundColor = Red
        Style.Cursor = ccuDefault
        Style.ZIndex = 0
        Style.BorderRadius.All = '11'
        AutoSizeXY = asY
        Align = alTop
        Right = -14
        StyleOver.ZIndex = 4
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object TdhLabel32: TdhLabel
      Left = 120
      Top = 5936
      Width = 504
      Height = 48
      Text = 
        'Soffermando il mouse su uno di questi oggetti, viene visualizzat' +
        'o in primo piano rispetto agli altri oggetti, dato che z-index '#232 +
        ' impostato su 1 mentre gli altri riquadri hanno il valore predef' +
        'inito di 0:'
      AutoSizeXY = asY
    end
    object TdhLabel33: TdhLabel
      Left = 32
      Top = 6136
      Width = 112
      Height = 16
      Text = 'indentazione-testo:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel34: TdhLabel
      Left = 168
      Top = 6136
      Width = 136
      Height = 82
      Text = 
        'In questo esempio la prima riga '#232' indentata di 15px. Le righe se' +
        'guenti non sono influenzate.'
      Style.Border.Width = 1
      Style.Border.Style = cbsSolid
      Style.TextIndent = '15'
      AutoSizeXY = asY
    end
    object TdhLabel35: TdhLabel
      Left = 360
      Top = 6136
      Width = 160
      Height = 98
      Text = 
        'Questo esempio mostra un'#39'indentazione negativa di -15px. Per non' +
        ' uscire dalle coordinate, '#232' definito un padding sinistro di 15px' +
        '.'
      Style.Border.Width = 1
      Style.Border.Style = cbsSolid
      Style.PaddingLeft = 15
      Style.TextIndent = '-15'
      AutoSizeXY = asY
    end
    object TdhLabel36: TdhLabel
      Left = 32
      Top = 6248
      Width = 96
      Height = 16
      Text = 'allinea-verticale:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel37: TdhLabel
      Left = 136
      Top = 6248
      Width = 368
      Height = 77
      Text = 
        'Questa propriet'#224' '#232' molto utile per immagini incluse in un testo.' +
        ' Esempi di valori:<br/>baseline (predefinito):<Label9></Label9> ' +
        ',  middle:<TdhLabel39></TdhLabel39> , 5px:<TdhLabel40></TdhLabel' +
        '40>'
      AutoSizeXY = asY
    end
    object TdhStyleSheet1: TdhStyleSheet
      Left = 552
      Top = 6094
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 152
      ExpandedHeight = 256
      Expanded = False
      object Label9: TdhLabel
        Left = 0
        Top = 0
        Width = 30
        Height = 30
        Style.VerticalAlign = 'baseline'
        Use = Label42
        AutoSizeXY = asY
        Align = alTop
      end
      object TdhLabel39: TdhLabel
        Left = 0
        Top = 30
        Width = 30
        Height = 30
        Style.VerticalAlign = 'middle'
        Use = Label42
        AutoSizeXY = asY
        Align = alTop
      end
      object TdhLabel40: TdhLabel
        Left = 0
        Top = 60
        Width = 30
        Height = 30
        Style.VerticalAlign = '5'
        Use = Label42
        AutoSizeXY = asY
        Align = alTop
      end
      object Label42: TdhLabel
        Left = 0
        Top = 90
        Width = 30
        Height = 30
        Text = 'Label42'
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label42_nm.gif'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 30
        Style.BackgroundImage.Height = 30
        AutoSizeXY = asY
        Align = alTop
      end
    end
    object TdhLabel42: TdhLabel
      Left = 24
      Top = 6706
      Width = 736
      Height = 453
      Text = 
        #10'Un link si pu'#242' trovare esattamente in uno tra quattro diversi s' +
        'tati di oggetto, per i quali puoi definire gli stili separatamen' +
        'te: '#10'<ul>'#10'<li>lo stato "normale" (lo stato normale di un oggetto' +
        ')</li>'#10'<li>lo stato "over" (quando il mouse si sofferma sull'#39'ogg' +
        'etto)</li>'#10'<li>lo stato "down" (quando il mouse viene cliccato, ' +
        'o ad altre condizioni configurabili nella scheda <tab>&nbsp;&nbs' +
        'p;&nbsp;Link&nbsp;&nbsp;&nbsp;&nbsp;</tab> ) </li>'#10'<li>lo stato ' +
        '"over/down" (quando il mouse si sofferma su un oggetto <b>e</b> ' +
        'il tasto viene cliccato)</li>'#10'</ul>'#10'Lo stato per il quale deside' +
        'ri modificare gli stili si pu'#242' impostare nella Barra Strumenti.<' +
        'br><br>'#10'Gli stili che sono attivi per un determinato stato sono ' +
        'elencati di seguito (l'#39'ordine dato mostra la precedenza se lo st' +
        'esso stile '#232' definito per pi'#249' di uno stato dello stesso oggetto)' +
        ':<br>'#10'<Label11>stili "normale"</Label11> nello stato "normale"<b' +
        'r>'#10'<Label11>stili "down" &rarr; stili "normale"</Label11> nello ' +
        'stato "down"<br>'#10'<Label11>stili "over" &rarr; stili "normale"</L' +
        'abel11> nello stato "over"<br>'#10'<Label11>stili "over/down" &rarr;' +
        ' stili "down" &rarr; stili "over" &rarr; stili "normale"</Label1' +
        '1> nello stato "over/down"'#10'<br/><br/>'#10'Se hai spuntato l'#39'opzione ' +
        '<b>Preferisci stili Over a stili Down</b> nella scheda <tab>&nbs' +
        'p;Oggetto&nbsp;&nbsp;</tab> l'#39'ultima riga cambia in:<br/>'#10'<Label' +
        '11>stili "over/down" &rarr; stili "over" &rarr; stili "down" &ra' +
        'rr; stili "normale"</Label11> nello stato "over/down"<br>'#10'Questa' +
        ' opzione si pu'#242' impostare solo se nessun oggetto <b>Usa</b> '#232' de' +
        'finito per l'#39'oggetto corrente.<br/>'#10'<br/>'#10'Esistono alcuni stili ' +
        'che sono specifici per le classi di oggetto:'#10'<ul>'#10'<li>Per i link' +
        ', puoi scegliere di attribuire l'#39'aspetto di un testo, di un puls' +
        'ante o di un link.</li>'#10'<li>Per i link, puoi definire pi'#249' dettag' +
        'liatamente quando lo stato "down" sar'#224' attivo (come sopracitato)' +
        '</li>'#10'<li>Per gli oggetti visuali, puoi definire il formato dell' +
        #39'immagine dell'#39'oggetto rasterizzato nella scheda <tab>&nbsp;Ogge' +
        'tto&nbsp;&nbsp;</tab></li>'#10'</ul>'#10'Se un certo stile viene imposta' +
        'to come &lt;Automatico&gt;, '#10'viene invece adottato lo stile da <' +
        'b>Usa</b> oggetto (se definito).'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet6: TdhStyleSheet
      Left = 680
      Top = 6608
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Label10: TdhLabel
        Left = 0
        Top = 0
        Width = 24
        Height = 24
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label10_nm.gif'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 24
        Style.BackgroundImage.Height = 24
        Style.BackgroundRepeat = cbrRepeat
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label11: TdhLabel
        Left = 0
        Top = 24
        Height = 22
        Text = 'Label11'
        Style.Border.Width = 1
        Style.Border.Style = cbsDotted
        Style.Margin = '0'
        Style.WhiteSpace = cwsNowrap
        Style.LineHeight = '150%'
        AutoSizeXY = asY
        Align = alTop
        Right = 24
      end
    end
    object Text2: TdhLabel
      Left = 456
      Top = 8160
      Width = 288
      Height = 32
      Text = 
        '(La pagina '#233' sufficientemente alta per mostrare tutti i componen' +
        'ti, questo '#232' il livello pi'#249' profondo)'
      Style.Color = 55769
      AutoSizeXY = asY
    end
    object StyleSheet5: TdhStyleSheet
      Left = 680
      Top = 6880
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 104
      Expanded = False
      object Image1: TdhLink
        Left = 0
        Top = 0
        Width = 24
        Height = 24
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Image1_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 24
        Style.BackgroundImage.Height = 24
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Image2: TdhLink
        Left = 0
        Top = 24
        Width = 24
        Height = 24
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Image2_nm.bmp'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 24
        Style.BackgroundImage.Height = 24
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object TdhLabel52: TdhLabel
      Left = 32
      Top = 6472
      Width = 80
      Height = 32
      Text = 'CSS aggiuntivo:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel53: TdhLabel
      Left = 120
      Top = 6464
      Width = 568
      Height = 42
      Text = 
        'Se hai dimestichezza con gli stili CSS, puoi definire i tuoi sti' +
        'li, che sono inseriti senza analisi nel file HTML. Il seguente e' +
        'sempio usa un filtro di IE che si applica solo ad Internet Explo' +
        'rer:'
      Use = pad
      AutoSizeXY = asY
    end
    object Anchor18: TdhLink
      Left = 128
      Top = 6520
      Width = 256
      Height = 22
      Text = 'Sposta il mouse su questo link'
      Style.FontSize = '19'
      Style.Other = 'filter:blendTrans(Duration=0.2)'
      Style.Color = Red
      AutoSizeXY = asXY
      StyleOver.BackgroundColor = Red
      StyleOver.Color = Aqua
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'javascript:alert('#39'hello'#39')'
    end
    object TdhLabel55: TdhLabel
      Left = 464
      Top = 5456
      Width = 224
      Height = 32
      Text = 
        'Applicazione effetti di ombra interna, emissione interna ed ombr' +
        'a esterna:'
      AutoSizeXY = asY
    end
    object TdhLabel57: TdhLabel
      Left = 487
      Top = 5473
      Width = 130
      Height = 88
      Text = 'Apri'
      Style.BackgroundRepeat = cbrNoRepeat
      Style.FontSize = '48'
      Style.Margin = '10'
      Style.FontFamily = 'Arial Black'
      Style.Color = Olive
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.InnerShadow.Enabled = True
      Style.Effects.InnerShadow.Alpha = 255
      Style.Effects.InnerShadow.Radius = 2
      Style.Effects.InnerShadow.Degree = 285
      Style.Effects.InnerShadow.Distance = 2
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 255
      Style.Effects.InnerGlow.Enabled = True
      Style.Effects.InnerGlow.Alpha = 255
      Style.Effects.InnerGlow.Radius = 2
      Style.Effects.InnerGlow.Flood = 83
      Style.Effects.OuterGlow.Alpha = 255
      Style.Effects.OuterGlow.Radius = 3
      Style.Effects.OuterGlow.Color = Red
      Style.Effects.OuterGlow.Flood = 63
      Style.Effects.Blur.Radius = 1
      AutoSizeXY = asXY
    end
    object Anchor5: TdhLabel
      Left = 24
      Top = 736
      Width = 143
      Height = 16
      Text = 'Posizionare gli oggetti'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor4: TdhLabel
      Left = 24
      Top = 3784
      Width = 150
      Height = 16
      Text = 'Formattazione del testo'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor7: TdhLabel
      Left = 24
      Top = 4056
      Width = 24
      Height = 16
      Text = 'Lati'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor8: TdhLabel
      Left = 24
      Top = 4712
      Width = 117
      Height = 16
      Text = 'Sfondi e Immagini'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor9: TdhLabel
      Left = 24
      Top = 5360
      Width = 36
      Height = 16
      Text = 'Effetti'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor10: TdhLabel
      Left = 24
      Top = 5600
      Width = 60
      Height = 16
      Text = 'Varie stili'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor11: TdhLabel
      Left = 24
      Top = 6680
      Width = 140
      Height = 16
      Text = 'Gestione di stili e stati'
      Use = chapter
      AutoSizeXY = asXY
    end
    object TdhLabel5: TdhLabel
      Left = 24
      Top = 616
      Width = 46
      Height = 16
      Text = 'Oggetti'
      Use = chapter
      AutoSizeXY = asXY
    end
    object TdhLabel7: TdhLabel
      Left = 24
      Top = 648
      Width = 648
      Height = 75
      Text = 
        'Clicca e trascina gli oggetti dalla Barra Strumenti nel document' +
        'o. '#10'Modifica le propriet'#224' degli oggetti nelle schede delle propr' +
        'iet'#224' sottostanti. '#10'Per esempio, cambia nome ad un oggetto nella ' +
        'scheda <tab>&nbsp;Oggetto&nbsp;&nbsp;</tab> '#10'Gli oggetti devono ' +
        'avere un nome univoco. Ogni oggetto, escluso quello principale, ' +
        'ha un oggetto genitore.'#10'Selezionando l'#39'oggetto e premendo una vo' +
        'lta il tasto ESCAPE viene selezionato l'#39'oggetto genitore.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label13: TdhLabel
      Left = 24
      Top = 1176
      Width = 92
      Height = 16
      Text = 'Tipi di oggetto'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label14: TdhLabel
      Left = 24
      Top = 1208
      Width = 640
      Height = 357
      Text = 
        'I tipi di oggetto sono:'#10'<ul>'#10'<li><b>Etichette</b>: mostrano test' +
        'o statico</li>'#10'<li><b>Link</b>: sono come le etichette, ma si po' +
        'ssono linkare ad una destinazione; possono assumere quattro dive' +
        'rsi stati</li>'#10'<li><b>Pannelli</b>: Si possono usare come oggett' +
        'i genitori per altri oggetti</li>'#10'<li><b>Pagina</b>: Come un pan' +
        'nello. Se non '#233' collegata ad un oggetto di controllo pagina, pu'#242 +
        ' mostrare delle barre di scorrimento.</li>'#10'<li><b>Oggetti modulo' +
        '</b>: gli oggetti modulo servono per costruire moduli HTML, che ' +
        'possano essere valutati da un server web</li>'#10'<li><b>Controllo p' +
        'agina</b>: un controllo pagina '#232' un oggetto con il quale '#232' possi' +
        'bile gestire diversi oggetti pagina. Si pu'#242' visualizzare solo un' +
        'a di tali pagine per volta. Possono essere linkate ad oggetti li' +
        'nk.</li>'#10'<li><b>Foglio di Stile</b>: un oggetto foglio di stile ' +
        #233' un semplice contenitore per oggetti che definiscono stili di v' +
        'isualizzazione da usare in altri oggetti.</li>'#10'<li><b>HTML diret' +
        'to</b>: per inserire direttamente del codice HTML/Javascript nel' +
        ' documento HTML generato</li>'#10'<li><b>Oggetti file</b>: File link' +
        'ati esterni o incorporati. Durante la pubblicazione verranno anc' +
        'h'#39'essi caricati. Il nome del file generato '#232' formato da <nobr><i' +
        '>object id + . + l'#39'estensione di file del file prescelto</i></no' +
        'br>.</li>'#10'<li><b>Oggetti menu</b>: Puoi costruire menu popup DHT' +
        'ML con gli oggetti menu. Vengono spiegati in un tutorial separat' +
        'o (vedi <b>Strumenti | Tutorial Menu</b>).</li>'#10'</ul>'#10'Nota che '#232 +
        ' possibile assegnare un'#39'immagine a qualsiasi tipo di oggetto vis' +
        'uale nella scheda <tab>&nbsp;&nbsp;Immag.&nbsp;&nbsp;</tab>, per' +
        'tanto non esiste un oggetto immagine a s'#232' stante.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label17: TdhLabel
      Left = 6
      Top = 19
      Width = 364
      Height = 68
      Text = 'Tutorial per DFM2HTML'
      Style.Padding = 17
      Style.FontSize = '29'
      Style.Color = White
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.InnerShadow.Degree = 119
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 255
      Style.Effects.OuterShadow.Radius = 3
      Style.Effects.OuterShadow.Flood = 100
      Style.Effects.OuterShadow.Distance = 0
      AutoSizeXY = asXY
    end
    object Label15: TdhLabel
      Left = 24
      Top = 536
      Width = 193
      Height = 16
      Text = 'Informazioni su questo tutorial'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label16: TdhLabel
      Left = 24
      Top = 560
      Width = 544
      Height = 42
      Text = 
        'Questo tutorial spiega come creare una pagina web con DFM2HTML. ' +
        '<br/>Per iniziare un nuovo documento, clicca <b>File | Nuovo</b>' +
        '.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label18: TdhLabel
      Left = 24
      Top = 6568
      Width = 98
      Height = 16
      Text = 'Ri-usare gli stili'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label19: TdhLabel
      Left = 24
      Top = 6586
      Width = 736
      Height = 67
      Text = 
        'Nelle sezioni precedenti hai visto molti stili visuali che si po' +
        'ssono applicare ad un oggetto.<br/>'#10'Per condividere gli stili tr' +
        'a oggetti, puoi inserire un oggetto foglio di stile <Label10></L' +
        'abel10> nel documento ed aggiungervi oggetti. <br/>'#10'Ora altri og' +
        'getti possono usare gli stili definiti da questi oggetti nella s' +
        'cheda <b>Usa</b> propriet'#224' nella scheda <tab>&nbsp;Oggetto&nbsp;' +
        '&nbsp;</tab>.'
      Use = pad
      AutoSizeXY = asY
    end
    object Anchor12: TdhLabel
      Left = 24
      Top = 1994
      Width = 43
      Height = 16
      Text = 'Moduli'
      Use = chapter
      AutoSizeXY = asXY
    end
    object TdhLabel47: TdhLabel
      Left = 32
      Top = 2012
      Width = 416
      Height = 50
      Text = 
        'Quando costruisci moduli HTML, devi posizionare tutti gli oggett' +
        'i di input, come i pulsanti radio <Image1></Image1>all'#39'interno d' +
        'i un oggetto <b>Modulo</b> <Image2></Image2>:'
      Use = pad
      AutoSizeXY = asY
    end
    object Form1: TdhHTMLForm
      Left = 32
      Top = 2082
      Height = 512
      Style.Border.Width = 6
      Style.Border.Color = 14540253
      Style.Border.Style = cbsSolid
      Style.BackgroundImage.Path = 'Images\Form1_nm.gif'
      Style.FontFamily = 'Verdana'
      Style.FontWeight = cfwBold
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight]
      Right = 44
      Action = 'javascript:alert('#39'Il modulo '#232' stato inviato!'#39')'
      Target = '_self'
      object Text18: TdhLabel
        Left = 72
        Top = 32
        Width = 100
        Height = 16
        Text = 'Cognome:'
        Use = Label1
        AutoSizeXY = asY
      end
      object Text19: TdhLabel
        Left = 72
        Top = 68
        Width = 100
        Height = 16
        Text = 'Nome:'
        Use = Label1
        AutoSizeXY = asY
      end
      object Text20: TdhLabel
        Left = 72
        Top = 104
        Width = 100
        Height = 16
        Text = 'Sesso:'
        Use = Label1
        AutoSizeXY = asY
      end
      object TdhLabel43: TdhLabel
        Left = 40
        Top = 152
        Width = 132
        Height = 16
        Text = 'Caratteristiche:'
        Use = Label1
        AutoSizeXY = asY
      end
      object Smoker: TdhCheckBox
        Left = 176
        Top = 152
        Width = 160
        Height = 22
        Text = 'fumatore'
        Use = Label2
        AutoSizeXY = asNone
      end
      object Driver: TdhCheckBox
        Left = 176
        Top = 174
        Width = 160
        Height = 22
        Text = 'bevitore'
        Use = Label2
        AutoSizeXY = asNone
      end
      object HTMLFreak: TdhCheckBox
        Left = 176
        Top = 196
        Width = 160
        Height = 22
        Text = 'esperto in HTML'
        Use = Label2
        AutoSizeXY = asNone
      end
      object TdhLabel44: TdhLabel
        Left = 40
        Top = 224
        Width = 132
        Height = 16
        Text = 'Citt'#224' pi'#249' vicina:'
        Use = Label1
        AutoSizeXY = asY
      end
      object FirstName: TdhEdit
        Left = 176
        Top = 24
        Width = 312
        Height = 32
        Use = Edit3
        AutoSizeXY = asY
      end
      object SureName: TdhEdit
        Left = 176
        Top = 60
        Width = 312
        Height = 32
        Use = Edit3
        AutoSizeXY = asY
      end
      object Comment: TdhMemo
        Left = 176
        Top = 256
        Width = 309
        Height = 176
        Use = Edit3
        AutoSizeXY = asNone
      end
      object TdhLabel45: TdhLabel
        Left = 40
        Top = 256
        Width = 132
        Height = 16
        Text = 'Commenti:'
        Use = Label1
        AutoSizeXY = asY
      end
      object TdhLabel46: TdhLabel
        Left = 40
        Top = 448
        Width = 132
        Height = 16
        Text = 'Modulo:'
        Use = Label1
        AutoSizeXY = asY
      end
      object Submit: TdhLink
        Left = 176
        Top = 440
        Width = 176
        Height = 32
        Text = 'Invia'
        Style.Cursor = ccuDefault
        Style.Effects.InnerShadow.Enabled = True
        Use = Submit3
        AutoSizeXY = asY
        Layout = ltButton
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        FormButtonType = fbSubmit
      end
      object Reset: TdhLink
        Left = 360
        Top = 440
        Width = 176
        Height = 32
        Text = 'Reimposta'
        Style.Cursor = ccuDefault
        Use = Submit3
        AutoSizeXY = asY
        Layout = ltButton
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        FormButtonType = fbReset
      end
      object StyleSheet1: TdhStyleSheet
        Left = 520
        Top = 28
        Width = 28
        Height = 28
        Expanded = False
        ExpandedWidth = 200
        ExpandedHeight = 168
        Expanded = False
        object Label1: TdhLabel
          Left = 0
          Top = 0
          Height = 16
          Text = 'Label1'
          Style.TextAlign = ctaRight
          AutoSizeXY = asY
          Align = alTop
        end
        object Label2: TdhLabel
          Left = 0
          Top = 16
          Height = 18
          Text = 'Label2'
          Style.Border.Width = 1
          Style.Border.Color = 14540253
          Style.Border.Style = cbsSolid
          Style.BackgroundColor = 16777181
          AutoSizeXY = asY
          Align = alTop
          Right = 24
        end
        object Edit3: TdhEdit
          Left = 0
          Top = 34
          Height = 32
          HTMLAttributes = 'wrap="off"'
          Style.Border.Width = 6
          Style.Border.Color = 14540253
          Style.Border.Style = cbsSolid
          Style.FontSize = '15'
          Style.BackgroundColor = 11206655
          Style.Color = 13369344
          Style.FontWeight = cfwBold
          AutoSizeXY = asY
          Align = alTop
          Right = 12
          Text = 'Next large city:'
        end
        object Submit3: TdhLink
          Left = 0
          Top = 88
          Height = 32
          Text = 'Submit3'
          Style.Border.Width = 6
          Style.Border.Color = 14540253
          Style.Border.Style = cbsSolid
          Style.BackgroundColor = 11184810
          Style.Cursor = ccuDefault
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          Align = alTop
          Right = -4
          Layout = ltButton
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          FormButtonType = fbSubmit
        end
        object TdhComboBox1: TdhSelect
          Left = 0
          Top = 66
          Height = 22
          Style.BackgroundColor = 16777181
          Style.Color = 13369344
          Style.FontWeight = cfwBold
          AutoSizeXY = asY
          Align = alTop
          Right = 6
          Items = <>
          SelectType = stDropDown
        end
      end
      object BigCity: TdhSelect
        Left = 176
        Top = 224
        Width = 312
        Height = 22
        Use = TdhComboBox1
        AutoSizeXY = asY
        Items = <
          item
            Text = 'Roma'
          end
          item
            Text = 'New York'
            Selected = True
          end>
        SelectType = stDropDown
      end
      object Gender: TdhPanel
        Left = 176
        Top = 96
        Width = 200
        Height = 49
        AutoSizeXY = asNone
        object Male: TdhRadioButton
          Left = 0
          Top = 0
          Width = 104
          Height = 22
          Text = 'maschio'
          Use = Label2
          AutoSizeXY = asNone
        end
        object Female: TdhRadioButton
          Left = 0
          Top = 22
          Width = 104
          Height = 22
          Text = 'femmina'
          Use = Label2
          AutoSizeXY = asNone
        end
      end
    end
    object Label12: TdhLabel
      Left = 32
      Top = 2602
      Width = 640
      Height = 108
      Text = 
        'Nota che i nomi degli oggetti di input (definibili nella scheda ' +
        '<tab>&nbsp;Oggetto&nbsp;&nbsp;</tab>) vengono usati quando i dat' +
        'i del modulo vengono trasmessi.'#10'Quando un utente invia un modulo' +
        ', i dati del modulo vengono inviati alla URL specificata nel cam' +
        'po <b>URL</b> della scheda <tab>&nbsp;Modulo&nbsp;&nbsp;&nbsp;</' +
        'tab> per l'#39'oggetto <b>Modulo</b>.'#10'In alternativa, la URL si pu'#242' ' +
        'specificare direttamente nel pulsante <b>Invia</b>, usando il su' +
        'oi campi <b>URL</b> o <b>Link a pagina</b>. I dati del modulo ve' +
        'ngono accodati nella URL di destinazione se viene '#10'scelto il met' +
        'odo <b>Get</b>, altrimenti vengono trasmessi in background (meto' +
        'do <b>Post</b>).'
      Use = pad
      AutoSizeXY = asY
    end
    object TdhAnchor8: TdhLabel
      Left = 24
      Top = 2727
      Width = 79
      Height = 16
      Text = 'Navigazione'
      Use = chapter
      AutoSizeXY = asXY
    end
    object TdhLabel1: TdhLabel
      Left = 24
      Top = 2750
      Width = 640
      Height = 31
      Text = 
        'Un oggetto per controllo pagina <Image3></Image3> pu'#242' gestire di' +
        'verse pagine, a cui pu'#242' collegarsi mediante oggetti link:'
      Use = pad
      AutoSizeXY = asY
    end
    object PageControl1: TdhPageControl
      Left = 32
      Top = 2816
      Width = 24
      Height = 24
      ActivePage = Page3
      FixedHeight = True
      DynamicNavigation = True
      object Page1: TdhPage
        Left = 32
        Top = 2808
        Width = 696
        Height = 264
        Style.BackgroundImage.Path = 'Images\Page1_nm.png'
        Style.BackgroundRepeat = cbrRepeat
        Style.BackgroundColor = Transparent
        Use = Panel7
        AutoSizeXY = asNone
        UseIFrame = False
        object Label5: TdhLabel
          Left = 32
          Top = 40
          Width = 144
          Height = 96
          Text = 
            'Ogni pagina pu'#242' avere contenuti diversi. Le pagine possono avere' +
            ' altezze diverse ma larghezza e posizione sono le stesse.'
          Style.Color = Red
          AutoSizeXY = asY
        end
      end
      object Page2: TdhPage
        Left = 32
        Top = 2808
        Width = 696
        Height = 264
        Style.Border.Color = Lime
        Style.Border.Style = cbsSolid
        Style.BackgroundColor = Transparent
        Use = Panel7
        AutoSizeXY = asNone
        UseIFrame = False
        object Label6: TdhLabel
          Left = 32
          Top = 48
          Width = 128
          Height = 87
          Text = 
            'Questa '#232' la seconda pagina. Tutte e tre le pagine sono gestite d' +
            'al Controllo Pagine <Image3></Image3>'
          Style.Padding = 1
          AutoSizeXY = asY
        end
      end
      object Page3: TdhPage
        Left = 32
        Top = 2808
        Width = 696
        Height = 264
        Style.BackgroundImage.Path = 'Images\Page3_nm.png'
        Style.BackgroundRepeat = cbrRepeat
        Style.BackgroundColor = Transparent
        Use = Panel7
        AutoSizeXY = asNone
        UseIFrame = False
        object Label7: TdhLabel
          Left = 48
          Top = 40
          Width = 176
          Height = 96
          Text = 
            'Questa '#232' l'#39'ultima pagina. Le pagine si possono incorporare in pa' +
            'gine web staticamente o possono essere intercambiate tra loro di' +
            'namicamente tramite JavaScript.'
          AutoSizeXY = asY
        end
      end
    end
    object StyleSheet7: TdhStyleSheet
      Left = 496
      Top = 2672
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 88
      Expanded = False
      object Image3: TdhLink
        Left = 0
        Top = 0
        Width = 21
        Height = 21
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Image3_nm.gif'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 21
        Style.BackgroundImage.Height = 21
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Panel7: TdhPanel
        Left = 0
        Top = 21
        Height = 32
        Style.BackgroundColor = 65408
        Style.BorderRadius.All = '14'
        AutoSizeXY = asNone
        Align = alTop
      end
    end
    object Anchor2: TdhLink
      Left = 32
      Top = 2792
      Width = 90
      Height = 16
      Text = 'Link a Pagina 1'
      Style.Color = Red
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page1
      LinkAnchor = TdhAnchor8
    end
    object Anchor6: TdhLink
      Left = 144
      Top = 2792
      Width = 90
      Height = 16
      Text = 'Link a Pagina 2'
      Style.Color = Lime
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page2
      LinkAnchor = TdhAnchor8
    end
    object Anchor13: TdhLink
      Left = 264
      Top = 2792
      Width = 90
      Height = 16
      Text = 'Link a Pagina 3'
      Style.Color = 16744448
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page3
      LinkAnchor = TdhAnchor8
    end
    object Label20: TdhLabel
      Left = 24
      Top = 3683
      Width = 73
      Height = 16
      Text = 'Stili oggetti'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label21: TdhLabel
      Left = 24
      Top = 3707
      Width = 528
      Height = 59
      Text = 
        'Si possono assegnare vari stili agli oggetti visuali, come illus' +
        'trato nelle sezioni seguenti. '#10'Un oggetto pu'#242' ri-usare gli stili' +
        ' di un altro oggetto scegliendo quell'#39'oggetto nel campo'#10'<b>Usa s' +
        'tili da</b> della scheda <tab>&nbsp;Oggetto&nbsp;&nbsp;</tab>.'
      Use = pad
      AutoSizeXY = asY
    end
    object Link8: TdhLink
      Left = 32
      Top = 4600
      Width = 200
      Height = 88
      Text = 
        '<br/><br/><br/>Questo '#232' un pulsante <br/>con <b>angoli radius</b' +
        '>'
      Style.BorderRadius.All = '20'
      AutoSizeXY = asNone
      Layout = ltButton
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object Label23: TdhLabel
      Left = 24
      Top = 1840
      Width = 27
      Height = 16
      Text = 'Link'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label24: TdhLabel
      Left = 22
      Top = 1856
      Width = 608
      Height = 74
      Text = 
        'I link sono oggetti che determinano la struttura di navigazione ' +
        'della tua pagina.'#10'Un link pu'#242' essere collegato ad una posizione ' +
        'esterna, come '#10'<googlelink>http://www.google.com</googlelink>, o' +
        ' ad un oggetto <b>Pagina</b> (<nav_example>vedi qui</nav_example' +
        '>).<br/>'#10'Facendo doppio clic su un link in modalit'#224' disegno, puo' +
        'i navigare alla sua destinazione.<br/>'#10'Un link pu'#242' assumere tre ' +
        'aspetti differenti:'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet8: TdhStyleSheet
      Left = 524
      Top = 1887
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 168
      ExpandedHeight = 100
      Expanded = False
      object googlelink: TdhLink
        Left = 0
        Top = 0
        Height = 16
        Text = 'googlelink'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.google.de'
      end
      object nav_example: TdhLink
        Left = 0
        Top = 16
        Height = 16
        Text = 'nav_example'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = TdhAnchor8
      end
    end
    object Link10: TdhLink
      Left = 26
      Top = 1952
      Width = 38
      Height = 16
      Text = 'google'
      AutoSizeXY = asXY
      Layout = ltLink
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'http://www.google.it'
    end
    object Link11: TdhLink
      Left = 74
      Top = 1952
      Width = 38
      Height = 16
      Text = 'google'
      AutoSizeXY = asXY
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'http://www.google.it'
    end
    object Link12: TdhLink
      Left = 122
      Top = 1952
      Width = 65
      Height = 24
      Text = 'google'
      AutoSizeXY = asXY
      Layout = ltButton
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'http://www.google.it'
    end
    object Label25: TdhLabel
      Left = 24
      Top = 4986
      Width = 600
      Height = 227
      Text = 
        'Con il pulsante&nbsp;<Link13>Da file..</Link13> puoi caricare un' +
        #39'immagine dal tuo file system locale.<br/> '#10'Puoi anche trascinar' +
        'e (drag&drop) un file di immagine dal file system o da una fines' +
        'tra di Esplora Risorse '#10'nella casella immagine nella scheda <tab' +
        '>&nbsp;Immag.&nbsp;&nbsp;</tab> o direttamente in qualche oggett' +
        'o. '#10'E'#39' possibile creare un'#39'immagine da un colore semi-trasparent' +
        'e o da un gradiente.'#10'Facendo clic destro sulla casella dell'#39'imma' +
        'gine, appare un menu contestuale che ti permette di modificare'#10'a' +
        'lcuni parametri del colore, salvare l'#39'immagine su disco, o cattu' +
        'rare il colore del pixel pi'#249' in basso a sinistra '#10'(che si presum' +
        'e corrisponda al colore di sfondo dell'#39'immagine) trasparente.'#10'<b' +
        'r/><br/>'#10'Il documento DFM2HTML salva solo i link alle immagini. ' +
        ' '#10'Dato che precedenti versioni di DFM2HTML salvavano le immagini' +
        ' direttamente nel documento, '#10'puoi usare il comando <b>Strumenti' +
        ' | Esternalizza Immagini</b> per trasferire le immagini dal tuo ' +
        'documento ad una cartella.'#10'Puoi usare lo stesso comando per spos' +
        'tare immagini gi'#224' linkate in un'#39'altra cartella. '#10'Puoi vedere la ' +
        'posizione di un'#39'immagine tramite <nobr><b>Stili | Mostra informa' +
        'zioni sullo stile</b></nobr>.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label26: TdhLabel
      Left = 24
      Top = 5224
      Width = 38
      Height = 16
      Text = 'Colori'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label27: TdhLabel
      Left = 24
      Top = 5240
      Width = 576
      Height = 95
      Text = 
        'Un colore, come il colore del font, il colore dello sfondo o il ' +
        'colore del bordo,'#10'si pu'#242' modificare con un pulsante colore (es. ' +
        '<Link15>&nbsp;Colore &nbsp;&nbsp;&nbsp;<Label28>&nbsp;&nbsp;&nbs' +
        'p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</Label28></Link15> ).'#10'Ogni puls' +
        'ante colore possiede un menu contestuale, grazie al quale '#232' poss' +
        'ibile copiare o estrarre dagli Appunti il valore del colore nel ' +
        'comune formato colore HTML #RRGGBB. '#10'Usando la finestra Raccogli' +
        ' Colore puoi catturare il colore di un pixel in qualsiasi punto ' +
        'dello schermo.'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet9: TdhStyleSheet
      Left = 632
      Top = 5208
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Link15: TdhLink
        Left = 0
        Top = 0
        Height = 21
        Text = 'Link15'
        Style.Padding = 2
        Style.FontSize = '11'
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        Right = 18
        Layout = ltButton
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Label28: TdhLabel
        Left = 0
        Top = 21
        Height = 16
        Text = 'Label28'
        Style.BackgroundColor = Red
        AutoSizeXY = asY
        Align = alTop
      end
    end
    object Label29: TdhLabel
      Left = 32
      Top = 6344
      Width = 80
      Height = 16
      Text = 'altezza-riga:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object Label30: TdhLabel
      Left = 120
      Top = 6344
      Width = 236
      Height = 16
      Text = 'Puoi definire l'#39'altezza delle righe di testo:'
      AutoSizeXY = asXY
    end
    object Label31: TdhLabel
      Left = 360
      Top = 6345
      Width = 152
      Height = 106
      Text = 
        'In questo esempio l'#39'altezza della riga '#232' impostata al 200% della' +
        ' dimensione font corrente.'
      Style.Border.Width = 1
      Style.Border.Style = cbsSolid
      Style.LineHeight = '200%'
      AutoSizeXY = asY
    end
    object Label32: TdhLabel
      Left = 24
      Top = 1584
      Width = 55
      Height = 16
      Text = 'Etichette'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label33: TdhLabel
      Left = 22
      Top = 1600
      Width = 640
      Height = 229
      Text = 
        'Un'#39'etichetta '#232' un semplice oggetto contenente del testo.'#10'Il test' +
        'o si pu'#242' modificare nella scheda <tab>&nbsp;&nbsp;&nbsp;Testo&nb' +
        'sp;&nbsp;&nbsp;&nbsp;</tab>, '#10'oppure usando la finestra dell'#39'edi' +
        'tor di testo, la quale permette di formattare il testo seleziona' +
        'to con le tag'#10'HTML standard, o con stili definiti nei tuoi ogget' +
        'ti Fogli di Stile.'#10'Puoi aprire questa finestra dal menu contestu' +
        'ale, oppure cliccando l'#39'oggetto tenendo premuto il tasto ALT, '#10'c' +
        'he apre l'#39'editor alla posizione di testo cliccata con il mouse.'#10 +
        #10'Una sezione di testo formattata inizia con una tag di apertura ' +
        'in formato <b><code>&lt;X&gt;</code></b>'#10'e termina con una tag d' +
        'i chiusura in formato <b><code>&lt;/X&gt;</code></b>.'#10'In contras' +
        'to alle reali tag HTML, non sono permessi attributi.'#10'Puoi rimuov' +
        'ere una coppia di tag usando il pulsante <Label34>UNTAG</Label34' +
        '>'#10'<br/><br/>'#10'Puoi inserire qualsiasi carattere Unicode supportat' +
        'o dal font in uso usando il pulsante <Label34>UNICODE</Label34><' +
        'br><br>'#10#10'Dato che, per esempio, i caratteri speciali <b>&lt;</b>' +
        ' e <b>&gt;</b> vengono usati per contrassegnare le tag,'#10'premi il' +
        ' pulsante <Label34>MASK</Label34> per inserire un carattere di e' +
        'scape davanti ai caratteri speciali <b>&lt;</b>, <b>&gt;</b>, <b' +
        '>&quot;</b> e <b>&amp;</b>'#10'all'#39'interno del testo selezionato.'#10#10#10 +
        'Per inserire un'#39'interruzione di riga usa il pulsante <Label34>BR' +
        '</Label34>'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet10: TdhStyleSheet
      Left = 656
      Top = 1440
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Label34: TdhLabel
        Left = 0
        Top = 0
        Height = 27
        Text = 'Label34'
        Style.Border.Width = 2
        Style.Border.Color = White
        Style.Border.Style = cbsOutset
        Style.Padding = 4
        Style.PaddingLeft = 8
        Style.PaddingRight = 8
        Style.FontSize = '9'
        Style.BackgroundColor = 13160660
        Style.FontFamily = 'Lucida Console'
        Style.FontWeight = cfwBold
        Style.LineHeight = '15'
        AutoSizeXY = asY
        Align = alTop
        Right = 6
      end
    end
    object Label35: TdhLabel
      Left = 24
      Top = 7893
      Width = 255
      Height = 16
      Text = 'Condivisione delle risorse di DFM2HTML'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label36: TdhLabel
      Left = 24
      Top = 7546
      Width = 672
      Height = 314
      Text = 
        'Da un progetto di DFM2HTML si pu'#242' generare una serie di pagine H' +
        'TML e file di immagini, che si possono visualizzare in un browse' +
        'r. Prima di pubblicare il tuo progetto in Internet, '#10'dovresti ri' +
        'vedere il risultato in una anteprima in locale sul tuo computer ' +
        'usando <b>Pubblica</b> | <b>Anteprima</b>. Viene generata e salv' +
        'ata in una directory del tuo disco locale una serie di pagine HT' +
        'ML. '#10'La directory locale si pu'#242' scegliere in <b>Pubblica </b>| <' +
        'b>Propriet'#224' Pagina</b> &rarr; <b>Directory Locale</b>. Un percor' +
        'so relativo viene interpretato come relativo alla directory in c' +
        'ui '#232' salvato il file del tuo progetto DFM2HTML.'#10'<br/><br/>'#10'Le pa' +
        'gine HTML, a cui si accede online usando un indirizzo HTTP, veng' +
        'ono solitamente salvate su un server FTP.'#10'DFM2HTML '#232' in grado di' +
        ' caricare automaticamente i file generati in una directory FTP, ' +
        'che puoi impostare in <b>Pubblica </b>| <b>Propriet'#224' Pagina</b> ' +
        '&rarr; <b>Directory FTP</b> (chiedi i parametri della connession' +
        'e FTP '#10'al tuo fornitore di hosting). '#10'Dopo aver compilato i para' +
        'metri della connessione FTP, potrai pubblicare il progetto usand' +
        'o <b>Pubblica </b>| <b>Pubblica</b>. '#10'Per aprire il browser dall' +
        #39'interfaccia di DFM2HTML e navigare nel sito web online, puoi im' +
        'postare l'#39'indirizzo HTTP in <b>Pubblica </b>| <b>Propriet'#224' Pagin' +
        'a</b> &rarr; <b>URL HTTP</b> scegliendo quindi <b>Pubblica </b>|' +
        ' <b>Visualizza Online</b>.'#10'<br/><br/>'#10'Gli stessi file HTML vengo' +
        'no generati sia per l'#39'anteprima che per la pubblicazione FTP.'#10'So' +
        'lo i file che hanno subito modifiche dall'#39'ultimo upload vengono ' +
        'caricati sul server FTP (questa opzione si pu'#242' disattivare in <b' +
        '>Strumenti</b> | <b>Opzioni</b> &rarr; <b>Pubblica</b> &rarr; <b' +
        '>Usa Pubblicazione Smart</b>).'#10'I file che sono stati generati pe' +
        'r l'#39'anteprima si possono ugualmente caricare su un server FTP us' +
        'ando programmi FTP esterni, o possono essere genericamente salva' +
        'ti su qualsiasi supporto multimediale dotato di una struttura a ' +
        'directory (come un CD-ROM).'
      Use = pad
      AutoSizeXY = asY
    end
    object Label38: TdhLabel
      Left = 32
      Top = 3102
      Width = 688
      Height = 567
      Text = 
        'Tra le pagine di un oggetto controllo pagina, solo una pagina pe' +
        'r volta pu'#242' essere visualizzata.<br> '#10'Tali pagine sono infatti c' +
        'hiamate <u>pagine alternative</u>.'#10'<br/>'#10'Puoi aggiungere una pag' +
        'ina ad un oggetto di controllo pagina'#10'<ul>'#10'<li>dal menu contestu' +
        'ale</li>'#10'<li>da <b>Crea nuova pagina</b> nella scheda <tab>&nbsp' +
        ';&nbsp;Pagina&nbsp;&nbsp;</tab></li>'#10'<li>trascinando un oggetto ' +
        'pagina dalla Barra Strumenti nell'#39'oggetto di controllo pagina</l' +
        'i>'#10'<li>incollando un oggetto pagina dagli Appunti nell'#39'oggetto d' +
        'i controllo pagina (<b>Modifica | Incolla</b>).</li>'#10'</ul>'#10'Le pa' +
        'gine alternative vengono inserite in pagine HTML diverse per opz' +
        'ione predefinita.'#10'Togliendo la spunta da <nobr><b>Una pagina HTM' +
        'L per oggetto pagina</b></nobr> nella scheda '#10'<tab>&nbsp;&nbsp;P' +
        'agina&nbsp;&nbsp;</tab>, le pagine vengono contenute all'#39'interno' +
        ' di un'#39'unica pagina HTML. '#10'Questo offre il vantaggio di evitare ' +
        'il caricamento di una nuova pagina HTML nel browser quando l'#39'ute' +
        'nte attiva '#10'un'#39'altra pagina alternativa tramite link, cos'#236' la nu' +
        'ova pagina verr'#224' visualizzata immediatamente.<br> Lo svantaggio'#10 +
        #232' che tutte le pagine vengono contenute in un unico file HTML.'#10'A' +
        'vendo molte pagine con molte immagini, questo pu'#242' aumentare il t' +
        'empo di caricamento dal server.'#10'<br/><br/>'#10'Puoi definire vari pa' +
        'rametri per un oggetto pagina, quando '#232' implementato in una nuov' +
        'a pagina HTML separata,'#10'usando la finestra <nobr><b>Propriet'#224' Pa' +
        'gina</b></nobr> (raggiungibile dal menu contestuale).'#10'Puoi defin' +
        'ire, per esempio, un titolo, o parole chiave per la pagina HTML.' +
        #10'Il nome del file HTML risultante '#233' formato dal nome dell'#39'oggett' +
        'o pagina e dall'#39'estensione &quot;.html&quot;.'#10'<br/><br/>'#10#10'<u>Pag' +
        'ine indipendenti</u><br/><br/>'#10'Un oggetto pagina non deve essere' +
        ' necessariamente controllato da un oggetto di controllo pagina. ' +
        #10'Oggetti pagina indipendenti si possono creare trascinando un og' +
        'getto pagina dalla Barra Strumenti dentro ad un oggetto che non ' +
        #232' un oggetto di controllo pagina.'#10'Le pagine indipendenti possono' +
        ' avere barre di scorrimento.'#10'Ogni documento DFM2HTML ha almeno u' +
        'n oggetto pagina indipendente, o oggetto pagina principale genit' +
        'ore (chiamato sempre "index" per opzione predefinita).'#10'<br/>'#10'<br' +
        '/>'#10'Per opzione predefinita una pagina indipendente non produce u' +
        'n file HTML separato (ad eccezione della pagina principale).'#10'Se ' +
        'metti la spunta su <b>&lt;IFRAME&gt;</b> nella scheda <tab>&nbsp' +
        ';&nbsp;Pagina&nbsp;&nbsp;&nbsp;</tab>,'#10'il contenuto dell'#39'oggetto' +
        ' pagina viene inserito in una pagina HTML separata, che viene in' +
        'corporata da un elemento IFRAME '#10'nella pagina HTML principale. '#10 +
        'Il vantaggio consiste nel fatto che soltanto questa pagina HTML ' +
        'interna viene ricaricata quando si attiva una pagina alternativa' +
        ' contenuta. '#10'D'#39'altra parte questo significa che la URL (l'#39'indiri' +
        'zzo internet) di queste pagine alternative non viene visualizzat' +
        'a nella barra indirizzi del browser '#10'e quindi le pagine non poss' +
        'ono avere riferimenti con pagine web esterne.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label37: TdhLabel
      Left = 24
      Top = 4480
      Width = 116
      Height = 16
      Text = 'Angoli Arrotondati'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label39: TdhLabel
      Left = 24
      Top = 4509
      Width = 624
      Height = 75
      Text = 
        'Premendo il pulsante Radius Bordo nella scheda'#10'<tab>&nbsp;&nbsp;' +
        '&nbsp;Lato&nbsp;&nbsp;&nbsp;</tab> '#10'puoi arrotondare ogni angolo' +
        ' singolarmente o i quattro angoli insieme, '#10'definendo un paramet' +
        'ro radius di arrotondamento. '#10'I radius verticale ed orizzontale ' +
        'si possono regolare separatamente. '#10'L'#39'esempio che segue ha un ra' +
        'dius di arrotondamento di 20 pixel in entrambe le direzioni:'
      Use = pad
      AutoSizeXY = asY
    end
    object Panel8: TdhPanel
      Left = 33
      Top = 4601
      Width = 40
      Height = 40
      Style.Border.Style = cbsDashed
      Style.BorderRadius.All = '20'
      AutoSizeXY = asNone
    end
    object Panel9: TdhPanel
      Left = 34
      Top = 4602
      Width = 20
      Height = 20
      Style.Border.Color = Red
      Style.Border.Style = cbsSolid
      Style.BorderTop.Style = cbsNone
      Style.BorderLeft.Style = cbsNone
      AutoSizeXY = asNone
    end
    object Label22: TdhLabel
      Left = 58
      Top = 4606
      Width = 41
      Height = 14
      Text = '20 pixel'
      Style.FontSize = '11'
      Style.Color = Red
      Style.FontWeight = cfwBold
      AutoSizeXY = asXY
    end
    object Label40: TdhLabel
      Left = 608
      Top = 4840
      Width = 144
      Height = 128
      Text = 'diviso'
      ImageType = bitSplit
      Style.BackgroundPosition = '52% 52%'
      Style.BackgroundRepeat = cbrRepeatY
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object Label41: TdhLabel
      Left = 336
      Top = 4840
      Width = 112
      Height = 42
      Text = 'immagine'
      ImageType = bitImage
      Style.BackgroundPosition = '50% 0%'
      Style.BackgroundRepeat = cbrRepeatY
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object Label43: TdhLabel
      Left = 24
      Top = 7525
      Width = 172
      Height = 16
      Text = 'Pubblicazione del progetto'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label44: TdhLabel
      Left = 24
      Top = 7922
      Width = 672
      Height = 123
      Text = 
        'Puoi trascinare i file di DFM2HTML (<code>*.dfm</code>) linkati ' +
        'in una finestra del browser dentro DFM2HTML.'#10'In tal modo gli ute' +
        'nti di DFM2HTML possono scambiarsi le risorse di DFM2HTML costru' +
        'endo dei link nelle loro pagine web.<br/>'#10'<br/>'#10'Il formato DFM2H' +
        'TML si basa su semplice testo ASCII, pertanto '#232' possibile copiar' +
        'e gli oggetti negli appunti, '#10'salvarli in qualsiasi file di test' +
        'o (come una pagina web o una email),'#10'ed incollarli in seguito in' +
        ' qualche altro documento DFM2HTML. '#10'Usa <nobr><b>Modifica | Copi' +
        'a Completa</b></nobr> anzich'#232' <nobr><b>Modifica | Copia</b></nob' +
        'r> per copiare negli Appunti non solo gli oggetti selezionati, m' +
        'a anche eventuali oggetti fogli di stile usati .'
      Use = pad
      AutoSizeXY = asY
    end
    object Label45: TdhLabel
      Left = 24
      Top = 7173
      Width = 27
      Height = 16
      Text = 'PHP'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label46: TdhLabel
      Left = 24
      Top = 7194
      Width = 672
      Height = 319
      Text = 
        'Puoi usare le tag PHP nei contenuti testuali o, per esempio, in ' +
        'un oggetto <b>DirectHTML</b>.'#10'<br/><br/>Un esempio di tag PHP ch' +
        'e stampa un <code>ciao</code> '#232'<br/>'#10#10'<code>&lt;?php echo "ciao"' +
        '; ?&gt;</code>'#10'<br/><br/>'#10#10'Le tag PHP vengono processate dal ser' +
        'ver e sono invisibili ai client. Usando il PHP potresti creare, ' +
        'per esempio, un contatore delle visite o un modulo per i contatt' +
        'i.'#10'Questi due esempi sono inclusi nella sezione PHP della finest' +
        'ra <b>Strumenti | Preimpostazioni</b>. Per sapere se il tuo serv' +
        'er supporta il PHP, potresti aggiungere per esempio il contatore' +
        ' delle visite alla tua pagina web, pubblicarla sul tuo server e ' +
        'navigarla. Se il contatore delle visite mostra un numero il PHP ' +
        #232' supportato dal tuo server. Nota che, normalmente, il PHP non f' +
        'unziona visualizzando l'#39'anteprima delle pagine web in locale.'#10'<b' +
        'r/><br/>'#10'DFM2HTML stesso visualizza un punto interrogativo quand' +
        'o rileva tag PHP.'#10'Questa non vengono ulteriormente considerate d' +
        'a DFM2HTML, comunque ai i file HTML generati viene assegnata l'#39'e' +
        'stensione <code>.php</code> quando vengono rilevate tag PHP.'#10'Not' +
        'a che questo potrebbe cambiare il nome della tua pagina iniziale' +
        ' da <code>index.html</code> a <code>index.php</code>.'#10'<br/><br/>' +
        #10'Nota che le tag PHP vengono eseguite sul server nell'#39'ordine in ' +
        'cui appaiono nel file HTML. Questo implica che le tag PHP di un ' +
        'gruppo di oggetti allineati in alto vengono eseguite nell'#39'ordine' +
        ' visuale dall'#39'alto al basso. '
      Use = pad
      AutoSizeXY = asY
    end
  end
end
