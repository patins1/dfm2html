object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Caption = 'TutorialMenusItalian.dfm'
  ClientHeight = 519
  ClientWidth = 1280
  Font.Charset = DEFAULT_CHARSET
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
      Left = 0
      Top = 0
      Width = 681
      Height = 43
      Text = 
        '<Label4><nobr>&nbsp;Tutorial DFM2HTML&nbsp;</nobr></Label4><Labe' +
        'l3>&nbsp;per </Label3><Label2><nobr>&nbsp;Menu DHTML&nbsp;</nobr' +
        '></Label2>'
      Style.FontSize = '36'
      Style.FontFamily = 'Pump Demi Bold LET'
      Style.FontWeight = cfwBold
      Style.Effects.AntiAliasing = True
      AutoSizeXY = asXY
    end
    object StyleSheet1: TdhStyleSheet
      Left = 844
      Top = 80
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Label2: TdhLabel
        Left = 0
        Top = 0
        Height = 16
        Text = 'Label2'
        Style.BackgroundColor = Red
        Style.Color = Yellow
        AutoSizeXY = asY
        Align = alTop
      end
      object Label3: TdhLabel
        Left = 0
        Top = 19
        Height = 16
        Text = 'Label3'
        Style.BackgroundColor = Yellow
        AutoSizeXY = asY
        Align = alTop
      end
      object Label4: TdhLabel
        Left = 0
        Top = 38
        Height = 16
        Text = 'Label4'
        Style.BackgroundColor = Blue
        Style.Color = White
        AutoSizeXY = asY
        Align = alTop
      end
    end
    object StyleSheet2: TdhStyleSheet
      Left = 846
      Top = 128
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 224
      ExpandedHeight = 232
      Expanded = False
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
      object Label6: TdhLabel
        Left = 0
        Top = 64
        Height = 16
        Text = 'Label3'
        Style.Color = Red
        AutoSizeXY = asY
        Align = alTop
      end
      object tab: TdhLabel
        Left = 0
        Top = 0
        Height = 22
        Text = 'tab'
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000002F00
          000012080200000044A110880000000467414D410000B18F0BFC61050000004D
          4944415478DAEDD00109C0400C43D156533CC553ABA9D174BBC13C9441BE82C7
          CF734612D48AD5400039539712D8B5442804E6D4452D7FF93C425615C96DC95B
          775B638D35D658638D35FFD43CCBCA5BBE1D42F3BE0000000049454E44AE4260
          82}
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
    object Link1: TdhLink
      Left = 404
      Top = 317
      Width = 153
      Height = 18
      Text = 'Paragrafi di questo tutorial '
      Style.Border.Style = cbsSolid
      Style.BackgroundColor = Yellow
      Style.Cursor = ccuPointer
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      object Menu1: TdhMenu
        Left = 419
        Top = 338
        Width = 131
        Height = 62
        Style.Border.Width = 1
        Style.Border.Color = Silver
        Style.Border.Style = cbsSolid
        Style.Padding = 6
        Style.Margin = '0'
        Style.BackgroundColor = 14540253
        AutoSizeXY = asXY
        MenuOptions = []
        ReactionTime = 400
        MenuLeft = -131
        MenuTop = 28
        object Link24: TdhLink
          Left = 7
          Top = 7
          Height = 16
          Text = 'Informazioni di Base'
          AutoSizeXY = asXY
          Align = alTop
          Right = 7
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkAnchor = Label8
        end
        object Link6: TdhLink
          Left = 7
          Top = 23
          Height = 16
          Text = 'Gestione dello stile'
          AutoSizeXY = asXY
          Align = alTop
          Right = 7
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkAnchor = Label9
        end
        object Link23: TdhLink
          Left = 7
          Top = 39
          Height = 16
          Text = 'Opzioni Menu'
          AutoSizeXY = asXY
          Align = alTop
          Right = 7
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkAnchor = Label5
        end
      end
    end
    object Label8: TdhLabel
      Left = 28
      Top = 64
      Width = 131
      Height = 16
      Text = 'Informazioni di Base'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label9: TdhLabel
      Left = 28
      Top = 552
      Width = 122
      Height = 16
      Text = 'Gestione dello stile'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label10: TdhLabel
      Left = 36
      Top = 592
      Width = 632
      Height = 65
      Text = 
        'Se un menu ri-usa gli stili di un altro menu ed <b>Automatico</b' +
        '> '#232' spuntata, vengono ri-usate anche tutte le impostazioni nella' +
        ' scheda <tab>&nbsp;&nbsp;Menu&nbsp;&nbsp;&nbsp;</tab> dell'#39'altro' +
        ' menu. Nell'#39'esempio che segue tutti gli stili per le voci di men' +
        'u e sottomenu sono definite nel foglio di stile <b>FoglioStileMe' +
        'nu</b>, mentre le attuali voci di menu ri-usano soltanto questi ' +
        'stili:'
      AutoSizeXY = asY
    end
    object Label7: TdhLabel
      Left = 28
      Top = 88
      Width = 720
      Height = 129
      Text = 
        'A partire dalla versione 1.9 '#232' stato introdotto un nuovo tipo di' +
        ' oggetto, l'#39'oggetto menu. '#10'Un oggetto menu '#232' un contenitore per ' +
        'voci di menu che si pu'#242' aprire esattamente con un oggetto link d' +
        'efinibile in <b>Apri Menu Con</b> nella scheda <tab>&nbsp;&nbsp;' +
        'Menu&nbsp;&nbsp;&nbsp;</tab>'#10'L'#39'oggetto menu viene quindi gestito' +
        ' dall'#39'oggetto link, per esempio eliminando l'#39'oggetto link si eli' +
        'mina l'#39'oggetto menu, e copiando l'#39'oggetto link si ottiene anche ' +
        'la copiatura dell'#39'oggetto menu.'#10'<br/><br/>'#10'Tramite <b>Crea Sotto' +
        'menu</b> dal menu contestuale di un link, puoi creare un nuovo m' +
        'enu che viene aperto da questo link. '#10'In modalit'#224' disegno, il me' +
        'nu di un link si pu'#242' aprire con un doppio clic sul link, o scegl' +
        'iendo <nobr><b>Vai a | Menu</b></nobr> nel suo menu contestuale.' +
        #10'Puoi aggiungere una voce di menu (un semplice oggetto link) al ' +
        'menu dal menu contestuale del menu.'
      AutoSizeXY = asY
    end
    object Label11: TdhLabel
      Left = 140
      Top = 312
      Width = 248
      Height = 127
      Text = 
        'Quando il mouse si sofferma per almeno <nobr> 400 msec</nobr> so' +
        'pra il link a destra, il sottomenu assegnato si apre. L'#39'interval' +
        'lo di tempo si pu'#242' personalizzare nella scheda <tab>&nbsp;&nbsp;' +
        'Menu&nbsp;&nbsp;&nbsp;</tab> '#10'Se disattivato (casella <b>dopo</b' +
        '> non spuntata), il menu si aprir'#224' con il clic del mouse.'
      Style.Border.Color = Silver
      Style.Border.Style = cbsSolid
      Style.Padding = 6
      Style.Margin = '0'
      Style.TextAlign = ctaJustify
      AutoSizeXY = asY
    end
    object Label5: TdhLabel
      Left = 28
      Top = 1208
      Width = 88
      Height = 16
      Text = 'Opzioni Menu'
      Use = chapter
      AutoSizeXY = asXY
    end
    object MenuStylesheet: TdhStyleSheet
      Left = 772
      Top = 672
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 248
      ExpandedHeight = 160
      Expanded = False
      object Menu2: TdhMenu
        Left = 0
        Top = 0
        Height = 38
        Style.Border.Width = 2
        Style.Border.Color = 10485760
        Style.Border.Style = cbsSolid
        Style.Margin = '0'
        Style.BorderRadius.All = '20'
        AutoSizeXY = asXY
        Align = alTop
        Right = 22
        MenuOptions = []
        ReactionTime = 400
        object Link2: TdhLink
          Left = 2
          Top = 2
          Height = 34
          Text = 'Link'
          Style.Padding = 5
          Style.PaddingLeft = 10
          Style.PaddingRight = 10
          Style.Margin = '4'
          Style.BackgroundColor = 10485760
          Style.Cursor = ccuPointer
          Style.FontFamily = 'Verdana'
          Style.Color = White
          Style.BorderRadius.All = '135'
          AutoSizeXY = asXY
          Align = alTop
          Right = -26
          StyleDown.BackgroundColor = Blue
          StyleOver.BackgroundColor = Aqua
          StyleOver.Color = Black
          PreferDownStyles = False
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        end
      end
    end
    object Menu3: TdhMenu
      Left = 60
      Top = 672
      Width = 467
      Height = 38
      Use = Menu2
      AutoSizeXY = asXY
      MenuOptions = []
      ReactionTime = 400
      object Link3: TdhLink
        Left = 2
        Top = 2
        Width = 157
        Text = 'Link con sottomenu'
        Use = Link2
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 2
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu4: TdhMenu
          Left = 63
          Top = 711
          Width = 161
          Height = 98
          Use = Menu2
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 5
          object Link7: TdhLink
            Left = 2
            Top = 32
            Height = 34
            Text = 'Link con sottomenu'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu7: TdhMenu
              Left = 225
              Top = 741
              Width = 57
              Height = 68
              Use = Menu2
              AutoSizeXY = asXY
              MenuOptions = []
              ReactionTime = 400
              MenuLeft = 5
              object Link12: TdhLink
                Left = 2
                Top = 2
                Height = 34
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link22: TdhLink
                Left = 2
                Top = 32
                Height = 34
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link8: TdhLink
            Left = 2
            Top = 2
            Height = 34
            Text = 'Link con sottomenu'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu5: TdhMenu
              Left = 225
              Top = 711
              Width = 161
              Height = 68
              Use = Menu2
              AutoSizeXY = asXY
              MenuOptions = []
              ReactionTime = 400
              MenuLeft = 5
              object Link11: TdhLink
                Left = 2
                Top = 32
                Height = 34
                Text = 'Link con sottomenu'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                object Menu10: TdhMenu
                  Left = 387
                  Top = 741
                  Width = 57
                  Height = 98
                  Use = Menu2
                  AutoSizeXY = asXY
                  MenuOptions = []
                  ReactionTime = 400
                  MenuLeft = 5
                  object Link18: TdhLink
                    Left = 2
                    Top = 2
                    Height = 34
                    Text = 'Link'
                    Use = Link2
                    AutoSizeXY = asXY
                    Align = alTop
                    PreferDownStyles = True
                    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  end
                  object Link19: TdhLink
                    Left = 2
                    Top = 32
                    Height = 34
                    Text = 'Link'
                    Use = Link2
                    AutoSizeXY = asXY
                    Align = alTop
                    PreferDownStyles = True
                    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  end
                  object Link21: TdhLink
                    Left = 2
                    Top = 62
                    Height = 34
                    Text = 'Link'
                    Use = Link2
                    AutoSizeXY = asXY
                    Align = alTop
                    PreferDownStyles = True
                    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  end
                end
              end
              object Link20: TdhLink
                Left = 2
                Top = 2
                Height = 34
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link9: TdhLink
            Left = 2
            Top = 62
            Height = 34
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
      object Link4: TdhLink
        Left = 155
        Top = 2
        Width = 157
        Text = 'Link con sottomenu'
        Use = Link2
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 2
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu6: TdhMenu
          Left = 216
          Top = 711
          Width = 161
          Height = 68
          Use = Menu2
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 5
          object Link10: TdhLink
            Left = 2
            Top = 2
            Height = 34
            Text = 'Link con sottomenu'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu9: TdhMenu
              Left = 378
              Top = 711
              Width = 57
              Height = 68
              Use = Menu2
              AutoSizeXY = asXY
              MenuOptions = []
              ReactionTime = 400
              MenuLeft = 5
              object Link15: TdhLink
                Left = 2
                Top = 2
                Height = 34
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link16: TdhLink
                Left = 2
                Top = 32
                Height = 34
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link14: TdhLink
            Left = 2
            Top = 32
            Height = 34
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
      object Link5: TdhLink
        Left = 308
        Top = 2
        Width = 157
        Text = 'Link con sottomenu'
        Use = Link2
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 2
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu8: TdhMenu
          Left = 369
          Top = 711
          Width = 57
          Height = 98
          Use = Menu2
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 5
          object Link13: TdhLink
            Left = 2
            Top = 2
            Height = 34
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link17: TdhLink
            Left = 2
            Top = 32
            Height = 34
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link25: TdhLink
            Left = 2
            Top = 62
            Height = 34
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
    end
    object Label12: TdhLabel
      Left = 36
      Top = 872
      Width = 632
      Height = 241
      Text = 
        'Un oggetto menu adatta la propria dimensione alla dimensione deg' +
        'li oggetti figlio, facendo in modo che siano tutti allineati a s' +
        'inistra o in alto, posto che <b>Largh. Auto</b> o <b>Alt. Auto</' +
        'b> nella scheda <tab>&nbsp;&nbsp;&nbsp;&nbsp;Pos.&nbsp;&nbsp;&nb' +
        'sp;</tab> sia spuntata. Per questo motivo <b>Menu3</b> nell'#39'esem' +
        'pio soprastante '#232' un oggetto menu diverso da un semplice oggetto' +
        ' pannello. Come menu non dipendente da una voce di menu <b>Menu3' +
        '</b> '#232' sempre visibile.'#10'<br/><br/>'#10'Un sottomenu pu'#242' posizionarsi' +
        ' sia sotto la propria voce di menu che alla sua destra, secondo ' +
        'il modo in cui la voce di menu stessa viene allineata a sinistra' +
        ' o in alto. Come mostrato nell'#39'esempio soprastante, il primo liv' +
        'ello del sottomenu si trova sotto la propria voce di menu, mentr' +
        'e il secondo livello di sottomenu si trova a destra della propri' +
        'a voce di menu.'#10'<br/><br/>'#10'Posizionando un sottomenu, la posizio' +
        'ne relativa della voce di menu viene assegnata a tutti i sottome' +
        'nu che usano lo stesso stile di menu. Quando elimini l'#39'ultima vo' +
        'ce di un menu in un menu auto-dimensionato, anche il menu stesso' +
        ' viene cancellato.'#10'<br/><br/>'#10'Nota che lo stile down di una voce' +
        ' di menu '#232' attivo se il suo sottomenu viene aperto.'
      AutoSizeXY = asY
    end
    object Label14: TdhLabel
      Left = 40
      Top = 1304
      Width = 66
      Height = 16
      Text = '<u>Menu inline</u>'
      AutoSizeXY = asXY
    end
    object Label16: TdhLabel
      Left = 40
      Top = 1336
      Width = 640
      Height = 32
      Text = 
        'Nel <b>Menu inline</b> '#232' impostata l'#39'opzione e la voce di menu d' +
        'el menu viene allineata in alto. Anche il menu viene allineato i' +
        'n alto, quando appare sotto la voce di menu. L'#39'effetto visuale v' +
        'iene illustrato nell'#39'esempio seguente:'
      AutoSizeXY = asY
    end
    object Label13: TdhLabel
      Left = 40
      Top = 1800
      Width = 592
      Height = 64
      Text = 
        'Il precedente menu inline contiene due livelli di sottomenu nidi' +
        'ficati. Nota che il foglio di stile del menu <b>Menu26</b> '#232' anc' +
        'h'#39'esso nidificato in modo da fornire diversi colori di sfondo pe' +
        'r ogni livello nidificato. Ogni volta che aggiungi un sottomenu,' +
        ' si tenter'#224' di assegnare un foglio di stile menu vicino al medes' +
        'imo livello nidificato. Questo ha effetto anche quando si creano' +
        ' menu di tipo popup.'
      AutoSizeXY = asY
    end
    object Page1: TdhPage
      Left = 42
      Top = 1386
      Width = 680
      Height = 408
      AutoSizeXY = asNone
      UseIFrame = True
      object PageControl1: TdhPageControl
        Left = 232
        Top = 8
        Width = 24
        Height = 24
        ActivePage = Page5
        FixedHeight = True
        object Page2: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Yellow
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page3: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 4227327
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page4: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 4259584
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page5: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Blue
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page6: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 16512
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page7: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Green
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page8: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 8421631
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page9: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 8388863
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page10: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Olive
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page11: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Navy
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page12: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 16512
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page13: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 16711808
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page14: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Black
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page15: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 8453888
          AutoSizeXY = asNone
          UseIFrame = False
        end
      end
      object Menu20: TdhMenu
        Left = 26
        Top = 4
        Width = 184
        Height = 84
        Style.Border.Width = 2
        Style.Border.Style = cbsSolid
        Style.BorderRadius.All = '20'
        Use = Menu26
        AutoSizeXY = asY
        MenuOptions = []
        ReactionTime = 400
        object Link43: TdhLink
          Left = 16
          Top = 10
          Height = 24
          Text = 'Link con sottomenu'
          Use = Link57
          AutoSizeXY = asXY
          Align = alTop
          Right = 6
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          object Menu21: TdhMenu
            Left = 16
            Top = 30
            Height = 80
            Use = Menu27
            AutoSizeXY = asXY
            Align = alTop
            MenuOptions = []
            ReactionTime = 400
            object Link44: TdhLink
              Left = 14
              Top = 8
              Height = 24
              Text = 'Link con sottomenu'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page3
              object Menu22: TdhMenu
                Left = 14
                Top = 28
                Height = 40
                Use = Menu28
                AutoSizeXY = asXY
                Align = alTop
                MenuOptions = []
                ReactionTime = 400
                object Link46: TdhLink
                  Left = 14
                  Top = 8
                  Height = 24
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page5
                end
              end
            end
            object Link47: TdhLink
              Left = 14
              Top = 28
              Height = 24
              Text = 'Link con sottomenu'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page6
              object Menu23: TdhMenu
                Left = 14
                Top = 48
                Height = 80
                Use = Menu28
                AutoSizeXY = asXY
                Align = alTop
                MenuOptions = []
                ReactionTime = 400
                object Link48: TdhLink
                  Left = 14
                  Top = 8
                  Height = 24
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page7
                end
                object Link49: TdhLink
                  Left = 14
                  Top = 28
                  Height = 24
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page8
                end
                object Link50: TdhLink
                  Left = 14
                  Top = 48
                  Height = 24
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page9
                end
              end
            end
            object Link51: TdhLink
              Left = 14
              Top = 48
              Height = 24
              Text = 'Link con sottomenu'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page10
              object Menu24: TdhMenu
                Left = 14
                Top = 68
                Height = 60
                Use = Menu28
                AutoSizeXY = asXY
                Align = alTop
                MenuOptions = []
                ReactionTime = 400
                object Link52: TdhLink
                  Left = 14
                  Top = 8
                  Height = 24
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page11
                end
                object Link60: TdhLink
                  Left = 14
                  Top = 28
                  Height = 24
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page4
                end
              end
            end
          end
        end
        object Link53: TdhLink
          Left = 16
          Top = 30
          Height = 24
          Text = 'Link con sottomenu'
          Use = Link57
          AutoSizeXY = asXY
          Align = alTop
          Right = 6
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          object Menu25: TdhMenu
            Left = 16
            Top = 50
            Height = 60
            Use = Menu27
            AutoSizeXY = asXY
            Align = alTop
            MenuOptions = []
            ReactionTime = 400
            object Link54: TdhLink
              Left = 14
              Top = 8
              Height = 24
              Text = 'Link'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page13
            end
            object Link55: TdhLink
              Left = 14
              Top = 28
              Height = 24
              Text = 'Link'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page14
            end
          end
        end
        object Link56: TdhLink
          Left = 16
          Top = 50
          Height = 24
          Text = 'Link'
          Use = Link57
          AutoSizeXY = asXY
          Align = alTop
          Right = 6
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page15
        end
      end
      object StyleSheet4: TdhStyleSheet
        Left = 232
        Top = 57
        Width = 28
        Height = 28
        Expanded = False
        ExpandedWidth = 320
        ExpandedHeight = 240
        Expanded = False
        object Menu26: TdhMenu
          Left = 0
          Top = 0
          Height = 40
          Style.Padding = 4
          Style.PaddingLeft = 10
          Style.PaddingRight = 0
          Style.Margin = '4'
          Style.BackgroundColor = Silver
          Style.BorderRadius.TopLeft = '10'
          Style.BorderRadius.BottomLeft = '10'
          AutoSizeXY = asXY
          Align = alTop
          Right = 8
          MenuOptions = [moInline, moClickToOpen]
          ReactionTime = 400
          object Link57: TdhLink
            Left = 14
            Top = 8
            Height = 24
            Text = 'Link26'
            Style.PaddingLeft = 9
            Style.Margin = '4'
            Style.Cursor = ccuPointer
            AutoSizeXY = asXY
            Align = alTop
            Right = -13
            StyleDown.BackgroundColor = Red
            StyleDown.Color = Black
            StyleDown.TextDecoration = [ctdNone]
            StyleDown.BorderRadius.All = '34'
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = 'http://'
            object Menu27: TdhMenu
              Left = 14
              Top = 31
              Height = 40
              Style.PaddingRight = 10
              Style.MarginRight = '0'
              Style.BackgroundColor = Yellow
              Use = Menu26
              AutoSizeXY = asXY
              Align = alTop
              MenuOptions = [moNoAuto, moInline]
              ReactionTime = 400
              object Link58: TdhLink
                Left = 14
                Top = 8
                Height = 27
                Text = 'Link31'
                Use = Link57
                AutoSizeXY = asXY
                Align = alTop
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                object Menu28: TdhMenu
                  Left = 10
                  Top = 31
                  Height = 40
                  Style.BackgroundColor = 65408
                  Style.BorderRadius.BottomRight = '10'
                  Style.BorderRadius.TopRight = '10'
                  Use = Menu27
                  AutoSizeXY = asXY
                  Align = alTop
                  MenuOptions = [moNoAuto, moInline, moClickToOpen]
                  ReactionTime = 400
                  object Link59: TdhLink
                    Left = 14
                    Top = 8
                    Height = 27
                    Text = 'Link32'
                    Use = Link57
                    AutoSizeXY = asXY
                    Align = alTop
                    PreferDownStyles = True
                    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  end
                end
              end
            end
          end
        end
      end
      object Menu11: TdhMenu
        Left = 576
        Top = 144
        Width = 100
        Height = 100
        AutoSizeXY = asXY
        MenuOptions = []
        ReactionTime = 400
      end
    end
    object Label19: TdhLabel
      Left = 40
      Top = 1917
      Width = 129
      Height = 16
      Text = '<u>Menu Aperto Continuo</u>'
      AutoSizeXY = asXY
    end
    object Label15: TdhLabel
      Left = 40
      Top = 1958
      Width = 624
      Height = 32
      Text = 
        'Se viene impostata questa opzione di menu, il sottomenu si apre ' +
        'immediatamente quando il mouse si sofferma sulle sue voci di men' +
        'u ed un altro sottomenu di un menu gemello '#232' gi'#224' aperto.'
      AutoSizeXY = asY
    end
    object Label17: TdhLabel
      Left = 40
      Top = 2035
      Width = 303
      Height = 16
      Text = '<u>Apertura al clic del mouse o al passaggio del mouse</u>'
      AutoSizeXY = asXY
    end
    object Label18: TdhLabel
      Left = 40
      Top = 2076
      Width = 608
      Height = 48
      Text = 
        'Mettendo la spunta nella casella <b>dopo</b> nel pannello <b>Apr' +
        'i Menu Con</b> il menu si apre automaticamente soffermando il mo' +
        'use sul menu per l'#39'intervallo di tempo specificato. In caso cont' +
        'rario, il menu si potr'#224' aprire solo con un clic del mouse.'
      AutoSizeXY = asY
    end
    object Label20: TdhLabel
      Left = 40
      Top = 1240
      Width = 624
      Height = 35
      Text = 
        'Un menu ri-usa le seguenti opzioni dal suo foglio di stile menu,' +
        ' quando '#232' spuntato <b>Automatico</b> nella scheda  <tab>&nbsp;&n' +
        'bsp;Menu&nbsp;&nbsp;&nbsp;</tab>'
      Style.Padding = 1
      Style.Margin = '0'
      AutoSizeXY = asY
    end
  end
end
