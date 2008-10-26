object PageContainer2: TPageContainer2
  Left = 110
  Top = 46
  Caption = 'PHPItalian.dfm'
  ClientHeight = 424
  ClientWidth = 1074
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  ShowHint = True
  Visible = True
  PixelsPerInch = 96
  TextHeight = 18
  object Page1: TdhPage
    Left = 0
    Top = 0
    Style.FontSize = '13'
    Style.BackgroundColor = Silver
    Style.FontFamily = 'arial'
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    object PresetsHelperPHP1: TdhLabel
      Left = 0
      Top = 0
      Height = 89
      Text = 
        '<center>'#10'<u><b><en_php>Contatore Visite</en_php><de_php>Besucher' +
        'z'#228'hler</de_php></b></u><br/>'#10'(<en_php>fornito da <Link1>selfphp<' +
        '/Link1></en_php><de_php>Quelle: <Link1>selfphp</Link1></de_php>)' +
        #10'</center>'#10'<br/>'#10'<en_php>'#9658'Per evitare di conteggiare lo stesso v' +
        'isitatore ogni volta che ricarica il contatore visite, l'#39'IP di u' +
        'n visitatore viene contato una sola volta ogni 30 minuti (determ' +
        'inato dalla variabile <code>$zeit</code> nel codice PHP).</en_ph' +
        'p>'#10'<de_php>'#9658'Dieser Besucherz'#228'hler hat eine IP-Sperre. Diese IP-S' +
        'perre erm'#246'glicht es, den jeweiligen Besucher lediglich ein einzi' +
        'ges Mal pro Besuch zu registrieren, und zwar f'#252'r eine festgelegt' +
        'e Zeit (siehe Variable <code>$zeit</code>, 30 Minuten sind die V' +
        'oreinstellung). </de_php>'
      Style.Padding = 4
      Style.Color = Blue
      AutoSizeXY = asXY
      Align = alTop
      Right = 0
    end
    object StyleSheet1: TdhStyleSheet
      Left = 24
      Top = 16
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Link1: TdhLink
        Left = 0
        Top = 0
        Height = 16
        Text = 'Link1'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.selfphp.info/praxisbuch/index.php'
      end
      object Label7: TdhLabel
        Left = 0
        Top = 16
        Height = 36
        Text = 'Label7'
        Style.Border.Style = cbsNone
        Style.Margin = '10'
        Style.BackgroundColor = White
        Style.BorderRadius.All = '8'
        AutoSizeXY = asY
        Align = alTop
        Right = 6
      end
    end
    object PresetsHelperPHP2: TdhLabel
      Left = 0
      Top = 153
      Height = 199
      Text = 
        '<center><u><b><en_php>Modulo contatto</en_php><de_php>Kontaktfor' +
        'mular</de_php></b></u></center><br/>'#10#10'<en_php>'#9658'Devi specificare ' +
        'l'#39'indirizzo email a cui verranno inviati i messaggi nell'#39'oggetto' +
        ' ProcessContactForm, variabile <code>$recipient</code>.'#10'La varia' +
        'bile <code>$subject</code> determina l'#39'oggetto inserito nel camp' +
        'o oggetto dell'#39'email.</en_php>'#10'<de_php>'#9658'In Objekt "ProcessContac' +
        'tForm", Variable $recipient, mu'#223't du die Email-Adresse angeben, ' +
        'zu der das Formular gesendet werden soll. Variable $subject best' +
        'immt die Betreff-Zeile der Email.</de_php>'#10'<br/><br/>'#10'<en_php>'#9658'P' +
        'er inserire altri input di oggetti diversi '#232' sufficiente'#10'aggiung' +
        'erli all'#39'oggetto ContactForm. Puoi anche aggiungere oggetti file' +
        ' input, che avranno come effetto l'#39'inserimento di file allegati.' +
        '</en_php>'#10'<de_php>'#9658'Du kannst beliebige weitere Formularfelder im' +
        ' Formular-Objekt "ContactForm" anlegen. Datei-Upload-Felder werd' +
        'en als Attachments der Email angeh'#228'ngt, die Benutzereingaben f'#252'r' +
        ' alle anderen Felder werden direkt in der Email aufgelistet.</de' +
        '_php>'#10'<br/><br/>'#10'<en_php>'#9658'Il valore dell'#39'oggetto di input "email' +
        '" apparir'#224' nel campo FROM dell'#39'email.</en_php>'#10'<de_php>'#9658'Die Benu' +
        'tzereingabe f'#252'r das Eingabefeld "email" bestimmt den Absender ei' +
        'ner versendeten Email.</de_php>'
      Style.Padding = 4
      Style.PaddingTop = 50
      Style.Color = Blue
      AutoSizeXY = asXY
      Align = alTop
      Right = 0
    end
    object PresetsHelperPHP3: TdhPanel
      Left = 0
      Top = 89
      Height = 64
      Use = Label7
      AutoSizeXY = asNone
      Align = alTop
      Right = 0
      object VisitorCounter: TdhLabel
        Top = 21
        Width = 13
        Height = 23
        Text = 
          '<?'#10#10'/////////////////////////////////////////'#10'// Counter + Reloa' +
          'dsperre v1.0'#10'/////////////////////////////////////////'#10#10'// 0=kei' +
          'ne Reloadsperre, 1=Reloadsperre'#10'$aktiv = 1;'#10'// Zeit der Reloadsp' +
          'erre in Minuten'#10'$zeit = 30;'#10'// IP-Datei'#10'$ipdatei = "ips.txt";'#10'//' +
          ' Counterdatei'#10'$datei = "counter.txt";'#10'// Anzahl der f'#252'hrenden Nu' +
          'llen'#10'$stellen = 5;'#10#10'/////////////////////////////////////////'#10'//' +
          ' IP-Reloadsperre'#10'/////////////////////////////////////////'#10#10'func' +
          'tion pruf_IP($rem_addr) {'#10'  global $ipdatei,$zeit;'#10'  @$ip_array ' +
          '= file($ipdatei);'#10'  $reload_dat = fopen($ipdatei,"w");'#10'  $this_t' +
          'ime = time();'#10'  for ($i=0; $i<count($ip_array); $i++) {'#10'    list' +
          '($ip_addr,$time_stamp) = explode("|",$ip_array[$i]);'#10'    if ($th' +
          'is_time < ($time_stamp+60*$zeit)) {'#10'      if ($ip_addr == $rem_a' +
          'ddr) {'#10'        $gefunden=1;'#10'      }'#10'      else {'#10'        fwrite(' +
          '$reload_dat,"$ip_addr|$time_stamp");'#10'      }'#10'    }'#10'  }'#10'  fwrite(' +
          '$reload_dat,"$rem_addr|$this_time\n");'#10'  fclose($reload_dat);'#10'  ' +
          'return ($gefunden==1) ? 1 : 0;'#10'}'#10#10'//////////////////////////////' +
          '///////////'#10'// Counter-Abfrage'#10'/////////////////////////////////' +
          '////////'#10#10'if (file_exists($datei) && ($aktiv==0 || ($aktiv==1 &&' +
          ' pruf_IP($REMOTE_ADDR)==0))) {'#10'  // Falls die Datei existiert, w' +
          'ird sie ausgelesen und'#10'  // der dort enthaltene Wert um Eins erh' +
          #246'ht.'#10'  $fp=fopen($datei,"r+");'#10'  $zahl=fgets($fp,$stellen);'#10'  $z' +
          'ahl++;'#10'  rewind($fp);'#10'  flock($fp,2);'#10'  fputs($fp,$zahl,$stellen' +
          ');'#10'  flock($fp,3);'#10'  fclose($fp);'#10'}else if (!file_exists($datei)' +
          ' && ($aktiv==0 || ($aktiv==1 && pruf_IP($REMOTE_ADDR)==0))) {'#10'  ' +
          '// Die Datei counter.txt existiert nicht, sie wird'#10'  // neu ange' +
          'legt und mit dem Wert 1 gef'#252'llt.'#10'  $fp=fopen($datei,"w");'#10'  $zah' +
          'l="1";'#10'  fputs($fp,$zahl,$stellen);'#10'  fclose($fp);'#10'} else {'#10'  //' +
          ' Die Datei existiert zwar, jedoch handelt'#10'  // es sich wahrschei' +
          'nlich um den gleichen Besucher'#10'  $fp=fopen($datei,"r");'#10'  $zahl=' +
          'fgets($fp,$stellen);'#10'  fclose($fp);'#10'}'#10'    '#10'$zahl=sprintf("%0".$s' +
          'tellen."d",$zahl);'#10#10'echo $zahl;'#10#10'?>'
        Style.Border.Width = 2
        Style.Border.Color = Lime
        Style.Border.Style = cbsSolid
        Style.Padding = 1
        Style.BackgroundColor = Black
        Style.FontFamily = 'Impact'
        Style.Color = Lime
        AutoSizeXY = asXY
        Anchors = [akTop]
      end
    end
    object PresetsHelperPHP4: TdhPanel
      Left = 0
      Top = 352
      Height = 280
      Use = Label7
      AutoSizeXY = asNone
      Align = alTop
      Right = 0
      object PageControl1: TdhPageControl
        Top = 21
        Width = 24
        Height = 24
        Anchors = [akTop]
        ActivePage = Page3
        FixedHeight = True
        object Page2: TdhPage
          Top = 13
          Width = 216
          Height = 256
          AutoSizeXY = asNone
          Anchors = [akTop]
          UseIFrame = False
          object ContactForm: TdhHTMLForm
            Left = 8
            Top = 8
            Width = 200
            Height = 240
            AutoSizeXY = asNone
            Method = fmtPost
            object Submit1: TdhLink
              Left = 8
              Top = 208
              Width = 63
              Height = 24
              Text = 'Submit'
              AutoSizeXY = asXY
              Layout = ltButton
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page3
              FormButtonType = fbSubmit
            end
            object Label1: TdhLabel
              Left = 4
              Top = 8
              Width = 69
              Height = 16
              Text = 'Your Name:'
              AutoSizeXY = asXY
            end
            object name: TdhEdit
              Left = 8
              Top = 24
              Width = 184
              Height = 23
              AutoSizeXY = asY
            end
            object Label2: TdhLabel
              Left = 8
              Top = 48
              Width = 41
              Height = 16
              Text = 'E-Mail:'
              AutoSizeXY = asXY
            end
            object email: TdhEdit
              Left = 8
              Top = 64
              Width = 184
              Height = 23
              AutoSizeXY = asY
            end
            object Label3: TdhLabel
              Left = 8
              Top = 88
              Width = 57
              Height = 16
              Text = 'Message:'
              AutoSizeXY = asXY
            end
            object message: TdhMemo
              Left = 8
              Top = 104
              Width = 184
              Height = 96
              AutoSizeXY = asNone
            end
            object Reset1: TdhLink
              Left = 80
              Top = 208
              Width = 58
              Height = 24
              Text = 'Reset'
              AutoSizeXY = asXY
              Layout = ltButton
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              FormButtonType = fbReset
            end
            object access: TdhHiddenField
              Left = 144
              Top = 208
              Width = 24
              Height = 24
              Value = 'dfm2html'
            end
          end
        end
        object Page3: TdhPage
          Top = 13
          Width = 216
          Height = 256
          Style.PaddingTop = 30
          AutoSizeXY = asNone
          Anchors = [akTop]
          UseIFrame = False
          object Label4: TdhLabel
            Left = 0
            Top = 49
            Height = 16
            Text = 'Ti ringraziamo per il messaggio <?php echo $_POST["name"]?>!'
            Style.TextAlign = ctaCenter
            Style.FontStyle = cfsItalic
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
          end
          object DirectHTML2: TdhDirectHTML
            Left = 0
            Top = 65
            Height = 19
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            InnerHTML = '<?php'#13#10#9'} else {'#13#10'?>'
            GenerateContainer = False
          end
          object DirectHTML3: TdhDirectHTML
            Left = 0
            Top = 108
            Height = 19
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            InnerHTML = '<?php'#13#10#9'}'#13#10'?>'
            GenerateContainer = False
          end
          object Label6: TdhLabel
            Left = 0
            Top = 84
            Height = 24
            Text = '<?php echo $err?> &nbsp;&nbsp;<Link2>Indietro</Link2>'
            Style.TextAlign = ctaCenter
            Style.Color = Red
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
          end
          object StyleSheet2: TdhStyleSheet
            Left = 16
            Top = 152
            Width = 28
            Height = 28
            Expanded = False
            ExpandedWidth = 100
            ExpandedHeight = 100
            Expanded = False
            object Link2: TdhLink
              Left = 0
              Top = 0
              Height = 24
              Text = 'Link1'
              AutoSizeXY = asXY
              Align = alTop
              Right = 4
              Layout = ltButton
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              Link = 'javascript:history.back()'
            end
          end
          object ProcessContactForm: TdhDirectHTML
            Left = 0
            Top = 30
            Height = 19
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            InnerHTML = 
              '<?php'#13#10#9'$recipient = "your@email.com";'#13#10#9'$subject = "Contact for' +
              'm";'#13#10#13#10#9'if ($_POST["access"]!="dfm2html")  $err="Page incorrectl' +
              'y accessed (e.g. by a bot)"; else'#13#10#9'if ($_POST["name"] == "")  $' +
              'err="You must specify a name!"; else'#13#10#9'if ($_POST["message"] == ' +
              '"")  $err="You must specify a message!"; else'#13#10#9'if ($recipient =' +
              '= "your@email.com") $err="No recipient defined by the web design' +
              'er!"; else'#13#10#9'$err="";'#13#10#9'if ($err=="") {'#13#10#9#9'$msg= "";'#13#10#9#9'foreach(' +
              '$_POST as $key=> $val) {'#13#10#9#9#9'if ($key != "access") $msg .= $key.' +
              '" : ".$val."\n\n";'#13#10#9#9'}'#13#10#9#9'$header='#39#39';'#13#10#9#9'if (isset($_POST["emai' +
              'l"])) $header .= '#39'From:'#39'.$_POST['#39'email'#39']."\n";'#13#10#13#10#9#9'if (count($_' +
              'FILES)>0) {'#13#10#13#10#9#9'$boundary = strtoupper(md5(uniqid(time())));'#13#10#13 +
              #10#9#9'$header .= "MIME-Version: 1.0\n";'#13#10#9#9'$header .= "Content-Type' +
              ': multipart/mixed; boundary=$boundary\n\n";'#13#10#9#9'$header .= "This ' +
              'is a multi-part message in MIME format.\n\n";'#13#10#9#9'$header .= "--$' +
              'boundary\n";'#13#10#9#9'$header .= "Content-Type: text/plain\n";'#13#10#9#9'$hea' +
              'der .= "Content-Transfer-Encoding: 8bit\n\n";'#13#10#9#9'$header .= "$ms' +
              'g\n";'#13#10#9#9'$msg='#39#39';'#13#10#13#10#9#9#13#10#9#9'foreach ($_FILES as $filefield => $fi' +
              'le) if (is_uploaded_file($file['#39'tmp_name'#39'])) {'#13#10#9#9#9#13#10#9#9#9'$content' +
              '=chunk_split(base64_encode(fread(fopen($file['#39'tmp_name'#39'],"r"),fi' +
              'lesize($file['#39'tmp_name'#39']))));'#13#10#13#10#9#9#9'$header .= "--$boundary\n";'#13 +
              #10#9#9#9'$header .= "Content-Type: ".$file['#39'type'#39']."; name=\"".$file[' +
              #39'name'#39']."\"\n";'#13#10#9#9#9'$header .= "Content-Transfer-Encoding: base6' +
              '4\n";'#13#10#9#9#9'$header .= "Content-Disposition: attachment; filename=' +
              '\"".$file['#39'name'#39']."\"\n\n";'#13#10#9#9#9'$header .= "$content\n";'#13#10#13#10#9#9'}'#13 +
              #10#9#9'$header .= "--$boundary--";'#13#10#9#9'}'#13#10#9#9'mail($recipient, $subject' +
              ', $msg, $header);'#13#10#13#10'?>'
            GenerateContainer = False
          end
        end
      end
    end
    object PresetsHelperPHP6: TdhLabel
      Left = 0
      Top = 632
      Height = 184
      Text = 
        '<center><u><b><en_php>Gestore File</en_php><de_php>Dateimanager<' +
        '/de_php></b></u></center><br/>'#10#10'<en_php>Con questo script di ges' +
        'tione dei file puoi caricare file sul server o cancellarli.</en_' +
        'php>'#10'<de_php>Mit diesem Dateimanager-Script k'#246'nnen lokale Dateie' +
        'n auf den Webserver hochgeladen werden oder von diesem wieder ge' +
        'l'#246'scht werden.</de_php>'#10'<br/><br/>'#10'<en_php>'#9658'I file vengono depos' +
        'itati nella directory <code>$dir</code>, che '#232' interpretata loca' +
        'lmente al percorso del server.'#10'Nota che gli script PHP negli ogg' +
        'etti allineati in alto vengono eseguiti nell'#39'ordine visuale dato' +
        ', dall'#39'alto al basso. La variabile <code>$dir</code> viene dichi' +
        'arata al massimo livello in alto pertanto pu'#242' essere accessibile' +
        ' da tutti gli oggetti allineati in alto che seguono.</en_php>'#10'<d' +
        'e_php>'#9658'Die Dateien werden auf der Serverseite im Verzeichnis <co' +
        'de>$dir</code>, das relativ zum Server-Pfad interpretiert wird, ' +
        'gespeichert. Beachte, da'#223' die Objekte mit den PHP-Scripts nach o' +
        'ben ausgerichtet sind und dadurch in der Reihenfolge von oben na' +
        'ch unten ausgef'#252'hrt werden. Da Variable <code>$dir</code> im obe' +
        'rsten Script-Objekt definiert ist, ist sie daher f'#252'r alle folgen' +
        'den Scripte sichtbar und zugreifbar.</de_php>'#10'<br/><br/>'#10'<en_php' +
        '>'#9658'Potrebbe essere necessario aumentare la larghezza del contenit' +
        'ore principale per visualizzare correttamente i nomi di file pi'#249 +
        ' lunghi.</en_php>'#10'<de_php>'#9658'F'#252'r l'#228'ngere Dateinamen sollte die Bre' +
        'ite des '#228'u'#223'eren Container-Objekts vergr'#246#223'ert werden.</de_php>'
      Style.Padding = 4
      Style.PaddingTop = 50
      Style.Color = Blue
      AutoSizeXY = asXY
      Align = alTop
      Right = 0
    end
    object PresetsHelperPHP5: TdhPanel
      Left = 0
      Top = 816
      Height = 176
      Use = Label7
      AutoSizeXY = asNone
      Align = alTop
      Right = 0
      object Page4: TdhPage
        Top = -62
        Width = 200
        Height = 252
        AutoSizeXY = asNone
        Anchors = [akTop]
        UseIFrame = False
        object DirectHTML1: TdhDirectHTML
          Left = 0
          Top = 57
          Height = 19
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          InnerHTML = 
            '<?php'#13#10'$dh  = opendir($dir);'#13#10'while (false !== ($filename = read' +
            'dir($dh))) {'#13#10'    $entries[] = $filename;'#13#10'}'#13#10'?>'
          GenerateContainer = False
        end
        object DirectHTML4: TdhDirectHTML
          Left = 0
          Top = 125
          Height = 19
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          InnerHTML = '<?php'#13#10'  }'#13#10'?>'
          GenerateContainer = False
        end
        object DirectHTML5: TdhDirectHTML
          Left = 0
          Top = 76
          Height = 19
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          InnerHTML = '<?php'#13#10'foreach ($entries as $item) if ($item[0]!='#39'.'#39') {'#13#10'?>'
          GenerateContainer = False
        end
        object Panel2: TdhPanel
          Left = 0
          Top = 95
          Height = 30
          Style.Border.Color = Silver
          Style.Border.Style = cbsSolid
          Style.Padding = 0
          Style.FontSize = '14'
          Style.MarginBottom = '4'
          Style.BackgroundColor = 13041663
          AutoSizeXY = asNone
          Align = alTop
          Right = 0
          object Link3: TdhLink
            Left = 3
            Top = 2
            Width = 8
            Height = 16
            Text = '<?php echo $item?>'
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '<?php echo $dir.$item?>'
          end
          object Link4: TdhLink
            Top = 1
            Width = 30
            Tooltip = 'Delete'
            Text = 'X'
            Style.FontSize = '14'
            Style.FontFamily = 'Tahoma'
            Style.Color = Red
            Style.FontWeight = cfwBold
            AutoSizeXY = asNone
            Align = alRight
            Right = 1
            Bottom = 5
            Layout = ltButton
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '<?php echo '#39'?FileToDelete='#39'.$item; ?>'
          end
        end
        object Form1: TdhHTMLForm
          Left = 0
          Top = 144
          Height = 72
          Style.Border.Color = Blue
          Style.Border.Style = cbsSolid
          Style.Padding = 7
          AutoSizeXY = asNone
          Align = alTop
          Right = 0
          Action = '<?php echo $PHP_SELF; ?>'
          Method = fmtPost
          object FileToUpload: TdhFileField
            Left = 8
            Top = 8
            Height = 23
            AutoSizeXY = asX
            Align = alTop
            Right = 8
          end
          object Link5: TdhLink
            Left = 8
            Top = 40
            Width = 67
            Height = 24
            Text = 'Upload'
            AutoSizeXY = asXY
            Layout = ltButton
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            FormButtonType = fbSubmit
          end
        end
        object DirectHTML6: TdhDirectHTML
          Left = 0
          Top = 19
          Height = 19
          Style.Color = Red
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          InnerHTML = 
            '<?php'#13#10#13#10'if (isset($FileToUpload) && $FileToUpload!="" && $FileT' +
            'oUpload!="none") {'#13#10#9'if (copy($FileToUpload, $dir.$FileToUpload_' +
            'name))'#13#10#9#9'echo '#39'Uploaded  '#39'.$FileToUpload_name.'#39' successfully!<b' +
            'r><br>'#39';'#13#10#9'else'#9'echo '#39'Failed to upload '#39'.$FileToUpload_name.'#39'<br' +
            '><br>'#39';'#13#10'}'#13#10#13#10'?>'
          GenerateContainer = False
        end
        object DirectHTML7: TdhDirectHTML
          Left = 0
          Top = 0
          Height = 19
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          InnerHTML = '<?php'#13#10'$dir = '#39'files/'#39';'#13#10'?>'
          GenerateContainer = False
        end
        object DirectHTML8: TdhDirectHTML
          Left = 0
          Top = 38
          Height = 19
          Style.Color = Red
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          InnerHTML = 
            '<?php'#13#10#13#10'if (isset($_REQUEST['#39'FileToDelete'#39'])) {'#13#10#9'$del=$_REQUES' +
            'T['#39'FileToDelete'#39'];'#13#10#9'if (strpos($del, '#39'\\'#39')!=false || strpos($de' +
            'l, '#39'/'#39')!=false)'#13#10#9#9'echo '#39'Invalid file name!<br><br>'#39';'#13#10#9'else if ' +
            '(unlink($dir.$del))'#13#10#9#9'echo '#39'Deleted  '#39'.$del.'#39' successfully!<br>' +
            '<br>'#39';'#13#10#9'else'#9'echo '#39'Failed to delete '#39'.$del.'#39'<br><br>'#39';'#13#10'}'#13#10#13#10'?>'
          GenerateContainer = False
        end
      end
    end
    object StyleSheet8: TdhStyleSheet
      Left = 88
      Top = 16
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 232
      ExpandedHeight = 296
      Expanded = False
      object de_php: TdhLabel
        Left = 0
        Top = 0
        Height = 16
        Text = 'de'
        Style.Display = cdsNone
        AutoSizeXY = asY
        Align = alTop
      end
      object en_php: TdhLabel
        Left = 0
        Top = 16
        Height = 16
        Text = 'en'
        Style.Display = cdsInline
        AutoSizeXY = asY
        Align = alTop
      end
    end
  end
end
