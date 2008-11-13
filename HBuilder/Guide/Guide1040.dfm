object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Caption = 'Guide1040.dfm'
  ClientHeight = 726
  ClientWidth = 1600
  Font.Charset = GREEK_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 19
  object index: TdhPage
    Left = 0
    Top = 0
    Style.FontSize = '13'
    Style.FontFamily = 'Arial'
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    object Label1: TdhLabel
      Left = 30
      Top = 24
      Width = 350
      Height = 51
      Text = 'Guida DFM2HTML'
      Style.FontSize = '36'
      Style.FontFamily = 'Arial Black'
      AutoSizeXY = asXY
    end
    object Label2: TdhLabel
      Left = 32
      Top = 104
      Width = 632
      Height = 32
      Text = 
        'Con questa guida imparerai in pochi minuti come si imposta un si' +
        'to con diverse pagine in un layout senza cornice.'
      AutoSizeXY = asY
    end
    object Label3: TdhLabel
      Left = 32
      Top = 160
      Width = 346
      Height = 16
      Text = '1. Aggiungere un oggetto per il controllo della pagina.'
      Use = Label4
      AutoSizeXY = asXY
    end
    object StyleSheet1: TdhStyleSheet
      Left = 535
      Top = 40
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Label4: TdhLabel
        Left = 0
        Top = 22
        Height = 16
        Text = 'Step'
        Style.Color = 206
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
        Align = alTop
      end
      object Image3: TdhLink
        Left = 0
        Top = 38
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Image3_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Label13: TdhLabel
        Left = 0
        Top = 188
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label13_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label20: TdhLabel
        Left = 0
        Top = 158
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label20_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label23: TdhLabel
        Left = 0
        Top = 68
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label23_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label30: TdhLabel
        Left = 0
        Top = 98
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label30_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label38: TdhLabel
        Left = 0
        Top = 128
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label38_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
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
    end
    object Label5: TdhLabel
      Left = 40
      Top = 192
      Width = 632
      Height = 78
      Text = 
        'Prima crea un nuovo documento DFM2HTML usando il menu <b>File</b' +
        '>. Per disegnare diverse pagine in un documento DFM2HTML dovrai ' +
        'aggiungere al documento un oggetto per il controllo delle pagine' +
        '. Per fare questo clicca il pulsante <Image3></Image3> sulla Bar' +
        'ra Strumenti e poi clicca nel documento.'#10'Hai aggiunto l'#39'oggetto ' +
        'chiamato <b>PageControl1</b> come oggetto figlio all'#39'oggetto <b>' +
        'index</b> (che '#232' l'#39'oggetto primario del documento).'
      AutoSizeXY = asY
    end
    object Label6: TdhLabel
      Left = 32
      Top = 288
      Width = 213
      Height = 16
      Text = '2. Aggiungere oggetti alla pagina'
      Use = Label4
      AutoSizeXY = asXY
    end
    object Label8: TdhLabel
      Left = 32
      Top = 432
      Width = 251
      Height = 16
      Text = '3. Modificare gli Stili di Visualizzazione'
      Use = Label4
      AutoSizeXY = asXY
    end
    object Label9: TdhLabel
      Left = 40
      Top = 320
      Width = 632
      Height = 82
      Text = 
        'Ora aggiungiamo pagine alternative all'#39'oggetto di controllo dell' +
        'e pagine. Si pu'#242' visualizzare solo una pagina alternativa per vo' +
        'lta. Nella zona in basso ci sono le schede delle propriet'#224', in c' +
        'ui '#232' possibile modificare gli oggetti selezionati. Vai alla sche' +
        'da <tab>&nbsp;Pagina&nbsp;&nbsp;</tab> del controllo pagina. Dat' +
        'o che una pagina alternativa, <b>Page1</b>, viene creata per opz' +
        'ione predefinita, aggiungi una seconda pagina alternativa, <b>Pa' +
        'ge2</b>, cliccando il pulsante <b>Crea nuova pagina</b>. E'#39' poss' +
        'ibile modificare il nome di un oggetto nella scheda <tab>&nbsp;O' +
        'ggetto&nbsp;&nbsp;</tab>'
      AutoSizeXY = asY
    end
    object Label10: TdhLabel
      Left = 40
      Top = 464
      Width = 632
      Height = 67
      Text = 
        'Prima seleziona <b>Page1</b>. Puoi farlo usando la casella combo' +
        ' sulla Barra Strumenti. Vai alla sua scheda <tab>&nbsp;&nbsp;&nb' +
        'sp;Font&nbsp;&nbsp;&nbsp;&nbsp;</tab> ed assegna un colore di sf' +
        'ondo rosso.'#10'Seleziona <b>Page2</b> ed assegna un colore di sfond' +
        'o giallo. Le pagine di un oggetto di controllo pagine possono av' +
        'ere diverse altezze, ma la posizione '#232' sempre la stessa. Assegna' +
        ' un'#39'altezza di 1000 pixel nella scheda <tab>&nbsp;&nbsp;&nbsp;Po' +
        's.&nbsp;&nbsp;&nbsp;&nbsp;</tab>'#10'di <b>Page2</b>.'
      Style.PaddingTop = 1
      AutoSizeXY = asY
    end
    object Label7: TdhLabel
      Left = 32
      Top = 568
      Width = 166
      Height = 16
      Text = '4. Creare Link alle Pagine'
      Use = Label4
      AutoSizeXY = asXY
    end
    object Label12: TdhLabel
      Left = 40
      Top = 600
      Width = 632
      Height = 78
      Text = 
        'Aggiungi due oggetti link <Label13></Label13> all'#39'oggetto <b>ind' +
        'ex</b>, <b>Link1</b> e <b>Link2</b>.'#10'Nella scheda <tab>&nbsp;&nb' +
        'sp;&nbsp;Link&nbsp;&nbsp;&nbsp;&nbsp;</tab> di <b>Link1</b>, sel' +
        'eziona <b>Page1</b> nella casella combo <i>Link a pagina</i>. Se' +
        'leziona <b>Page2</b> e <b>Link2</b> per accordarla.'#10'Con un doppi' +
        'o clic su un link puoi navigare velocemente all'#39'oggetto pagina l' +
        'inkato. Ora l'#39'utente potr'#224' attivare le due pagine alternative us' +
        'ando i link.'
      AutoSizeXY = asY
    end
    object Label14: TdhLabel
      Left = 32
      Top = 704
      Width = 115
      Height = 16
      Text = '5. Generare HTML'
      Use = Label4
      AutoSizeXY = asXY
    end
    object Label15: TdhLabel
      Left = 40
      Top = 736
      Width = 632
      Height = 64
      Text = 
        'Puoi provare il sito restando all'#39'interno di DFM2HTML grazie al ' +
        'pulsante <b>prova</b> sulla Barra degli Strumenti.'#10'Per vedere un' +
        #39'anteprima del sito nel browser usa <b>Pubblica | Anteprima</b>.' +
        ' Puoi caricare il sito in una directory FTP compilando i paramet' +
        'ri in <b>Pubblica</b> | <b>Propriet'#224' Pagina</b> &rarr; <b>Direct' +
        'ory FTP</b> e premendo infine <b>Pubblica</b> | <b>Pubblica</b>.'
      AutoSizeXY = asY
    end
    object Label16: TdhLabel
      Left = 32
      Top = 848
      Width = 279
      Height = 16
      Text = '<b>Argomenti avanzati (fai doppio clic sui link):</b>'
      AutoSizeXY = asXY
    end
    object PageControl1: TdhPageControl
      Left = 32
      Top = 912
      Width = 24
      Height = 24
      ActivePage = Page2
      FixedHeight = False
      object Page1: TdhPage
        Left = 32
        Top = 904
        Width = 656
        Height = 48
        AutoSizeXY = asNone
        UseIFrame = False
      end
      object Page2: TdhPage
        Left = 32
        Top = 904
        Width = 656
        Height = 536
        Use = Label41
        AutoSizeXY = asNone
        UseIFrame = False
        object Label17: TdhLabel
          Left = 32
          Top = 89
          Width = 223
          Height = 16
          Text = '1. Inserire le pagine in un pannello'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label18: TdhLabel
          Left = 40
          Top = 121
          Width = 561
          Height = 126
          Text = 
            'Prima dobbiamo creare un nuovo oggetto genitore per le pagine al' +
            'ternative.'#10'Seleziona <b>PageControl1</b> ed esegui <nobr><b>Modi' +
            'fica</b> | <b>Taglia</b></nobr> (conferma l'#39'avviso). Ora il cont' +
            'rollo pagina e tutte le sue pagine si trovano negli Appunti.'#10'Agg' +
            'iungi un oggetto pannello <Label20></Label20> all'#39'oggetto <b>ind' +
            'ex</b> ed incolla in esso tutti gli oggetti dagli Appunti (<b>Mo' +
            'difica | Incolla</b>). Imposta l'#39'altezza di <b>Panel1</b> in mod' +
            'o che sia sufficiente per contenere la pagina visibile di <b>Pag' +
            'eControl1</b>, pi'#249' uno spazio extra in cui posizionare l'#39'oggetto' +
            ' Pi'#232' di Pagina che andremo ad aggiungere nella fase successiva.'#10 +
            'Per visualizzare pi'#249' agevolmente <b>Panel1</b> puoi definire un ' +
            'colore di sfondo.'
          AutoSizeXY = asY
        end
        object Label19: TdhLabel
          Left = 40
          Top = 33
          Width = 561
          Height = 32
          Text = 
            'Nelle istruzioni seguenti viene spiegato come creare un Pi'#232' di P' +
            'agina, cio'#232' un oggetto che verr'#224' visualizzato in fondo ad ogni p' +
            'agina HTML generata.'
          AutoSizeXY = asY
        end
        object Label21: TdhLabel
          Left = 32
          Top = 265
          Width = 231
          Height = 16
          Text = '2. Aggiungere oggetto Pi'#232' di Pagina'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label22: TdhLabel
          Left = 40
          Top = 297
          Width = 561
          Height = 111
          Text = 
            'Ora inserisci un oggetto etichetta <Label23></Label23> nello spa' +
            'zio riservato di <b>Panel1</b> e chiamalo <b>Label1</b>. '#10'Inseri' +
            'sci un testo per il Pi'#232' di Pagina (per es. informazioni sul copy' +
            'right) nella finestra dell'#39'editor raggiungibile dal menu contest' +
            'uale di <b>Label1</b>. Il simbolo di copyright '#169' si pu'#242' selezion' +
            'are nella tabella Unicode raggiungibile dal pulsante <b>UNICODE<' +
            '/b>. Infine metti la spunta su <b>Lato basso genitore</b> e togl' +
            'i la spunta da <b>Lato alto genitore</b> nelle impostazioni <b>T' +
            'ieni distanza costante da</b> della scheda <tab>&nbsp;&nbsp;&nbs' +
            'p;Pos.&nbsp;&nbsp;&nbsp;&nbsp;</tab> per <b>Label1</b>.'
          AutoSizeXY = asY
        end
        object Label11: TdhLabel
          Left = 40
          Top = 424
          Width = 561
          Height = 90
          Text = 
            'Osservando l'#39'anteprima del sito nel browser potrai constatare ch' +
            'e:'#10'<ul>'#10'<li>Cambiando la pagina alternativa, la differenza di al' +
            'tezza viene estesa a <b>Panel1</b>.</li>'#10'<li>L'#39'oggetto Pi'#232' di Pa' +
            'gina mantiene una distanza costante dal lato basso di <b>Panel1<' +
            '/b>, continuando ad apparire in fondo ad ogni pagina alternativa' +
            '.</li>'#10'</ul>'
          AutoSizeXY = asY
        end
      end
      object Page3: TdhPage
        Left = 32
        Top = 904
        Width = 656
        Height = 536
        Use = Label41
        AutoSizeXY = asNone
        UseIFrame = False
        object Label24: TdhLabel
          Left = 40
          Top = 33
          Width = 561
          Height = 48
          Text = 
            'Nelle istruzioni seguenti viene spiegato come ri-usare gli stili' +
            ' tramite gli oggetti fogli di stile. Lo scopo '#233' dotare <b>Page1<' +
            '/b> e <b>Page2</b> di un bordo nero con angoli arrotondati, defi' +
            'nendo gli stili su un solo oggetto.'
          AutoSizeXY = asY
        end
        object Label25: TdhLabel
          Left = 32
          Top = 89
          Width = 300
          Height = 16
          Text = '1. Creare un Foglio di Stile con un oggetto stile'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label26: TdhLabel
          Left = 40
          Top = 121
          Width = 561
          Height = 46
          Text = 
            'Aggiungi un oggetto Foglio di Stile <Label30></Label30> all'#39'ogge' +
            'tto <b>index</b>. Premi sul segno <big>+</big> nero per aggiunge' +
            're un semplice oggetto etichetta e chiamalo <b>Style1</b>.'
          AutoSizeXY = asY
        end
        object Label27: TdhLabel
          Left = 32
          Top = 193
          Width = 111
          Height = 16
          Text = '2. Definire gli stili'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label28: TdhLabel
          Left = 40
          Top = 225
          Width = 561
          Height = 50
          Text = 
            'Seleziona <b>Style1</b>, vai alla scheda <tab>&nbsp;&nbsp;Lato&n' +
            'bsp;&nbsp;&nbsp;</tab> e definisci un bordo nero di 10 pixel (se' +
            'leziona il valore <b>Solid</b> per lo stile del bordo). Ora arro' +
            'tonda gli angoli: Premi il pulsante <b>Modifica Radius Bordo</b>' +
            ' e definisci un radius del bordo di 20 pixel.'
          Style.PaddingTop = 1
          AutoSizeXY = asY
        end
        object Label29: TdhLabel
          Left = 40
          Top = 400
          Width = 561
          Height = 64
          Text = 
            'Nota che un oggetto Foglio di Stile serve solo come semplice ogg' +
            'etto contenitore, nel quale puoi inserire qualsiasi tipo di ogge' +
            'tto dalla Barra Strumenti. Comunque solo gli oggetti contenuti i' +
            'n un foglio di stile possono essere ri-usati da altri oggetti.'#10'S' +
            'e aggiungi una terza pagina al controllo pagine, questa verr'#224' in' +
            'izializzata usando lo <b>Style1</b>.'
          AutoSizeXY = asY
        end
        object Label31: TdhLabel
          Left = 32
          Top = 297
          Width = 113
          Height = 16
          Text = '3. Ri-usare gli stili'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label32: TdhLabel
          Left = 40
          Top = 329
          Width = 561
          Height = 34
          Text = 
            'Seleziona <b>Page1</b>, vai alla scheda <tab>&nbsp;Oggetto&nbsp;' +
            '&nbsp;</tab> e scegli <b>Style1</b> nel campo <b>Usa</b>. Fai la' +
            ' stessa cosa per <b>Page2</b>.'
          Style.PaddingTop = 1
          AutoSizeXY = asY
        end
      end
      object Page4: TdhPage
        Left = 32
        Top = 904
        Width = 656
        Height = 536
        Use = Label41
        AutoSizeXY = asNone
        UseIFrame = False
        object Label33: TdhLabel
          Left = 40
          Top = 33
          Width = 561
          Height = 32
          Text = 
            'Se vuoi convertire l'#39'esempio soprariportato in un layout a frame' +
            ', in cui il contenuto inner della pagina si pu'#242' far scorrere men' +
            'tre i link rimangono fissi, segui le fasi seguenti:'
          AutoSizeXY = asY
        end
        object Label34: TdhLabel
          Left = 32
          Top = 89
          Width = 333
          Height = 16
          Text = '1. Inserire le pagine in un oggetto pagina scorrevole'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label35: TdhLabel
          Left = 40
          Top = 121
          Width = 597
          Height = 126
          Text = 
            'Mentre <b>Page1</b> e <b>Page2</b> sono gestite da un controllo ' +
            'pagine, puoi aggiungere oggetti indipendenti dalla pagina dalla ' +
            'Barra Strumenti <Label38></Label38>, anche in un documento. Una ' +
            'pagina indipendente pu'#242' avere barre di scorrimento, come l'#39'ogget' +
            'to pagina principale <b>index</b>.'#10'Ora, prima seleziona <b>PageC' +
            'ontrol1</b> ed esegui <nobr><b>Modifica</b> | <b>Taglia</b></nob' +
            'r> (conferma l'#39'avviso). Il controllo pagina e tutte le sue pagin' +
            'e sono adesso negli Appunti.'#10'Quindi aggiungi un nuovo oggetto pa' +
            'gina all'#39'oggetto <b>index</b> e chiamalo <b>Page3</b>.'#10'Incolla i' +
            'n esso gli oggetti dagli Appunti (<b>Modifica | Incolla</b>). Pe' +
            'r visualizzare meglio <b>Page3</b>, puoi definire un colore di s' +
            'fondo.'
          AutoSizeXY = asY
        end
        object Label36: TdhLabel
          Left = 32
          Top = 257
          Width = 246
          Height = 16
          Text = '2. Impostazioni Regolazione Posizione'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label37: TdhLabel
          Left = 40
          Top = 289
          Width = 597
          Height = 66
          Text = 
            'Nella scheda <tab>&nbsp;&nbsp;&nbsp;Pos.&nbsp;&nbsp;&nbsp;&nbsp;' +
            '</tab> per <b>Page3</b>, spunta le opzioni <b>Lato destro genito' +
            're</b> e <b>Lato basso genitore</b>.'#10'L'#39'oggetto <b>index</b> rapp' +
            'resenta la finestra del browser e, se l'#39'utente ridimensiona l'#39'og' +
            'getto figlio, <b>Page3</b> si ridimensiona nello stesso modo, ma' +
            'ntenendo costante la distanza dei suoi lati dai corrispondenti l' +
            'ati dell'#39'oggetto <b>index</b>.'
          Style.PaddingTop = 1
          AutoSizeXY = asY
        end
        object Label39: TdhLabel
          Left = 32
          Top = 377
          Width = 239
          Height = 16
          Text = '3. Nascondere le barre di scorrimento'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label40: TdhLabel
          Left = 40
          Top = 417
          Width = 597
          Height = 49
          Text = 
            'Dovresti posizionare l'#39'oggetto <b>Page3</b> in modo che occupi u' +
            'na vasta area dell'#39'oggetto <b>index</b>. Puoi nascondere qualsia' +
            'si barra di scorrimento usando la scheda <tab>&nbsp;Pagina&nbsp;' +
            '&nbsp;&nbsp;</tab>dell'#39'oggetto <b>index</b> (seleziona <b>no</b>' +
            '), dato che le pagine alternative vengono gi'#224' fatte scorrere all' +
            #39'interno dell'#39'oggetto <b>Page3</b>.'
          AutoSizeXY = asY
        end
      end
    end
    object Link2: TdhLink
      Left = 32
      Top = 876
      Width = 152
      Height = 22
      Text = 'Aggiungere Pi'#232' di Pagina'
      Use = Link4
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page2
      LinkAnchor = Link2
    end
    object Link1: TdhLink
      Left = 216
      Top = 876
      Width = 123
      Height = 22
      Text = 'Usare i Fogli di Stile'
      Use = Link4
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page3
      LinkAnchor = Link1
    end
    object Link3: TdhLink
      Left = 368
      Top = 876
      Width = 185
      Height = 22
      Text = 'Passare ad un Layout a Frame'
      Use = Link4
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page4
      LinkAnchor = Link3
    end
    object StyleSheet2: TdhStyleSheet
      Left = 496
      Top = 848
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Link4: TdhLink
        Left = 0
        Top = 0
        Height = 22
        Text = 'Link4'
        Style.Padding = 3
        AutoSizeXY = asXY
        Align = alTop
        Right = 20
        StyleDown.Border.Color = Blue
        StyleDown.Border.Style = cbsSolid
        StyleDown.Padding = 2
        StyleDown.TextDecoration = [ctdNone]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Label41: TdhLabel
        Left = 0
        Top = 22
        Height = 18
        Text = 'Label41'
        Style.Border.Color = Blue
        Style.Border.Style = cbsSolid
        AutoSizeXY = asY
        Align = alTop
        Right = 24
      end
    end
  end
end
