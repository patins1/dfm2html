object PageContainer7: TPageContainer7
  Left = -4
  Top = -23
  Caption = 'beige-small-loops.dfm'
  ClientHeight = 906
  ClientWidth = 1680
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
    Style.BorderRight.Width = 0
    Style.BorderRight.Style = cbsNone
    Style.BackgroundImage.Path = 'images-beige-small-loops\index_nm.jpg'
    Style.BackgroundImage.State = isAnalyzed
    Style.BackgroundImage.Width = 50
    Style.BackgroundImage.Height = 44
    Style.PaddingRight = 0
    Style.MarginTop = '0'
    Style.MarginRight = '0'
    Style.BackgroundColor = Silver
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Title = 'Unterseite01'
    object Panel1: TdhPanel
      Left = 35
      Top = 76
      Width = 224
      Height = 504
      Style.FontSize = '18'
      Style.BackgroundColor = 13820654
      AutoSizeXY = asNone
      object Label14: TdhLabel
        Left = 22
        Top = 333
        Width = 176
        Height = 144
        Text = 
          'Name Name Name<br>'#10'Street Street Street<br>'#10'Zip Code City City C' +
          'ity<br><br>'#10#10'Tel: 000 / 000 000 00<br>'#10'Fax: 000 / 000 000 00<br>' +
          '<br>'#10#10'E-Mail: name@domain.de<br>'#10'Web: www.domain.de'
        Style.FontSize = '13'
        Style.TextAlign = ctaRight
        Style.FontFamily = 'Arial'
        Style.Color = 3881787
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Panel13: TdhPanel
        Left = 36
        Top = 179
        Width = 165
        Height = 41
        Style.BackgroundImage.Path = 'images-beige-small-loops\Panel13_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 1
        Style.BackgroundImage.Height = 41
        Style.BackgroundRepeat = cbrRepeatX
        AutoSizeXY = asNone
        object Panel14: TdhPanel
          Left = 191
          Top = 0
          Width = 165
          Height = 41
          Style.BackgroundImage.Path = 'images-beige-small-loops\Panel14_nm.png'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 1
          Style.BackgroundImage.Height = 41
          Style.BackgroundRepeat = cbrRepeatX
          AutoSizeXY = asNone
        end
        object Link8: TdhLink
          Left = 33
          Top = 15
          Width = 81
          Height = 16
          Text = 'Link Page 4'
          Style.FontSize = '14'
          Style.FontFamily = 'Arial'
          Style.Color = 15420
          Style.FontStyle = cfsItalic
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          Link = './Page4.html'
        end
      end
    end
    object Panel3: TdhPanel
      Left = 70
      Top = 103
      Width = 165
      Height = 41
      Style.BackgroundImage.Path = 'images-beige-small-loops\Panel3_nm.png'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 1
      Style.BackgroundImage.Height = 41
      Style.BackgroundRepeat = cbrRepeatX
      AutoSizeXY = asNone
      object Panel4: TdhPanel
        Left = 191
        Top = 0
        Width = 165
        Height = 41
        Style.BackgroundImage.Path = 'images-beige-small-loops\Panel4_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 1
        Style.BackgroundImage.Height = 41
        Style.BackgroundRepeat = cbrRepeatX
        AutoSizeXY = asNone
      end
      object Link5: TdhLink
        Left = 36
        Top = 15
        Width = 81
        Height = 16
        Text = 'Link Page 1'
        Style.FontSize = '14'
        Style.FontFamily = 'Arial'
        Style.Color = 15420
        Style.FontStyle = cfsItalic
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        Layout = ltLink
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = './index.html'
      end
    end
    object PageControl1: TdhPageControl
      Left = -40
      Top = 105
      Width = 24
      Height = 24
      ActivePage = Page1
      FixedHeight = False
      object Page1: TdhPage
        Left = 277
        Top = 76
        Width = 559
        Height = 506
        Style.PaddingBottom = 0
        Style.FontSize = '18'
        Style.MarginBottom = '0'
        Style.BackgroundColor = 6927821
        AutoSizeXY = asNone
        UseIFrame = False
        object Label2: TdhLabel
          Left = 83
          Top = 283
          Width = 416
          Height = 165
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.<br/><br/>'#10'This te' +
            'mplate is generated under the licence of the Creative Commons.'#10'Y' +
            'ou are allowed to use the template and embedded pictures - but p' +
            'lease do'#10'not remove the links in the footer of this template. If' +
            ' you like to change the'#10'picture, you will find a giude in your D' +
            'FM2HTML installation files. The files'#10'are usually installed on y' +
            'our Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.FontFamily = 'Arial'
          Style.Color = 2960685
          AutoSizeXY = asY
        end
        object Label3: TdhLabel
          Left = 418
          Top = 114
          Width = 77
          Height = 29
          Text = 'Page 1'
          Style.FontSize = '24'
          Style.FontFamily = 'Arial'
          Style.Color = 15420
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label4: TdhLabel
          Top = 75
          Width = 234
          Height = 35
          Text = '<b>My own  Website</b>'
          Style.FontSize = '30'
          Style.TextAlign = ctaRight
          Style.FontFamily = 'arial'
          Style.Color = White
          AutoSizeXY = asXY
          Anchors = [akTop, akRight]
          Right = 59
        end
      end
      object Page2: TdhPage
        Left = 277
        Top = 76
        Width = 559
        Height = 505
        Style.BackgroundColor = 6927821
        AutoSizeXY = asNone
        UseIFrame = False
        object Label1: TdhLabel
          Left = 83
          Top = 283
          Width = 416
          Height = 165
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.<br/><br/>'#10'This te' +
            'mplate is generated under the licence of the Creative Commons.'#10'Y' +
            'ou are allowed to use the template and embedded pictures - but p' +
            'lease do'#10'not remove the links in the footer of this template. If' +
            ' you like to change the'#10'picture, you will find a giude in your D' +
            'FM2HTML installation files. The files'#10'are usually installed on y' +
            'our Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.FontFamily = 'Arial'
          Style.Color = 2960685
          AutoSizeXY = asY
        end
        object Label5: TdhLabel
          Left = 418
          Top = 114
          Width = 77
          Height = 29
          Text = 'Page 2'
          Style.FontSize = '24'
          Style.FontFamily = 'Arial'
          Style.Color = 15420
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label6: TdhLabel
          Left = 227
          Top = 75
          Width = 273
          Height = 35
          Text = '<b>My own  Website</b>'
          Style.FontSize = '30'
          Style.TextAlign = ctaRight
          Style.FontFamily = 'arial'
          Style.Color = White
          AutoSizeXY = asY
        end
      end
      object Page3: TdhPage
        Left = 277
        Top = 76
        Width = 559
        Height = 506
        Style.BackgroundColor = 6927821
        AutoSizeXY = asNone
        UseIFrame = False
        object Label7: TdhLabel
          Left = 83
          Top = 283
          Width = 416
          Height = 165
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.<br/><br/>'#10'This te' +
            'mplate is generated under the licence of the Creative Commons.'#10'Y' +
            'ou are allowed to use the template and embedded pictures - but p' +
            'lease do'#10'not remove the links in the footer of this template. If' +
            ' you like to change the'#10'picture, you will find a giude in your D' +
            'FM2HTML installation files. The files'#10'are usually installed on y' +
            'our Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.FontFamily = 'Arial'
          Style.Color = 2960685
          AutoSizeXY = asY
        end
        object Label8: TdhLabel
          Left = 418
          Top = 114
          Width = 77
          Height = 29
          Text = 'Page 3'
          Style.FontSize = '24'
          Style.FontFamily = 'Arial'
          Style.Color = 15420
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label12: TdhLabel
          Left = 227
          Top = 75
          Width = 273
          Height = 35
          Text = '<b>My own  Website</b>'
          Style.FontSize = '30'
          Style.TextAlign = ctaRight
          Style.FontFamily = 'arial'
          Style.Color = White
          AutoSizeXY = asY
        end
      end
      object Page4: TdhPage
        Left = 277
        Top = 76
        Width = 559
        Height = 504
        Style.BackgroundColor = 6927821
        AutoSizeXY = asNone
        UseIFrame = False
        object Label9: TdhLabel
          Left = 227
          Top = 75
          Width = 273
          Height = 35
          Text = '<b>My own  Website</b>'
          Style.FontSize = '30'
          Style.TextAlign = ctaRight
          Style.FontFamily = 'arial'
          Style.Color = White
          AutoSizeXY = asY
        end
        object Label11: TdhLabel
          Left = 418
          Top = 114
          Width = 77
          Height = 29
          Text = 'Page 4'
          Style.FontSize = '24'
          Style.FontFamily = 'Arial'
          Style.Color = 15420
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object PageControl2: TdhPageControl
          Left = 16
          Top = 16
          Width = 24
          Height = 24
          ActivePage = Page7
          FixedHeight = True
          object Page6: TdhPage
            Left = 35
            Top = 177
            Width = 471
            Height = 313
            AutoSizeXY = asNone
            UseIFrame = False
            object ContactForm: TdhHTMLForm
              Left = 8
              Top = 8
              Width = 455
              Height = 294
              AutoSizeXY = asNone
              Method = fmtPost
              object Submit1: TdhLink
                Left = 11
                Top = 264
                Width = 63
                Height = 24
                Text = 'Submit'
                AutoSizeXY = asXY
                Layout = ltButton
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                LinkPage = Page7
                FormButtonType = fbSubmit
              end
              object Label13: TdhLabel
                Left = 8
                Top = 39
                Width = 65
                Height = 15
                Text = 'Your Name:'
                Style.FontSize = '12'
                Style.Color = 3881787
                AutoSizeXY = asXY
              end
              object name: TdhEdit
                Left = 9
                Top = 53
                Width = 436
                Height = 23
                AutoSizeXY = asY
              end
              object Label15: TdhLabel
                Left = 12
                Top = 79
                Width = 37
                Height = 15
                Text = 'E-Mail:'
                Style.FontSize = '12'
                Style.Color = 3881787
                AutoSizeXY = asXY
              end
              object email: TdhEdit
                Left = 9
                Top = 93
                Width = 437
                Height = 23
                AutoSizeXY = asY
              end
              object Label16: TdhLabel
                Left = 13
                Top = 169
                Width = 54
                Height = 15
                Text = 'Message:'
                Style.FontSize = '12'
                Style.Color = 3881787
                AutoSizeXY = asXY
              end
              object message: TdhMemo
                Left = 10
                Top = 183
                Width = 437
                Height = 73
                AutoSizeXY = asNone
              end
              object Reset1: TdhLink
                Left = 83
                Top = 264
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
                Left = 147
                Top = 264
                Width = 24
                Height = 24
                Value = 'dfm2html'
              end
              object Label19: TdhLabel
                Left = 12
                Top = 126
                Width = 39
                Height = 15
                Text = 'Phone:'
                Style.FontSize = '12'
                Style.Color = 3881787
                AutoSizeXY = asXY
              end
              object Phone: TdhEdit
                Left = 9
                Top = 140
                Width = 437
                Height = 23
                AutoSizeXY = asY
              end
            end
          end
          object Page7: TdhPage
            Left = 35
            Top = 177
            Width = 471
            Height = 313
            Style.PaddingTop = 30
            AutoSizeXY = asNone
            UseIFrame = False
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
            object Label17: TdhLabel
              Left = 0
              Top = 49
              Height = 15
              Text = 'Thank you for your message, <?php echo $_POST["name"]?>!'
              Style.FontSize = '12'
              Style.TextAlign = ctaCenter
              Style.Color = 3881787
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
            end
            object DirectHTML2: TdhDirectHTML
              Left = 0
              Top = 64
              Height = 19
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              InnerHTML = '<?php'#13#10#9'} else {'#13#10'?>'
              GenerateContainer = False
            end
            object Label18: TdhLabel
              Left = 0
              Top = 83
              Height = 24
              Text = '<?php echo $err?> &nbsp;&nbsp;<Link23>Go back</Link23>'
              Style.TextAlign = ctaCenter
              Style.Color = 3881787
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
            end
            object DirectHTML3: TdhDirectHTML
              Left = 0
              Top = 107
              Height = 19
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              InnerHTML = '<?php'#13#10#9'}'#13#10'?>'
              GenerateContainer = False
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
              object Link23: TdhLink
                Left = 0
                Top = 0
                Height = 24
                Text = 'Link1'
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                Layout = ltButton
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                Link = 'javascript:history.back()'
              end
            end
          end
        end
      end
    end
    object Panel2: TdhPanel
      Left = 38
      Top = 595
      Width = 800
      Height = 47
      Style.BackgroundImage.Path = 'images-beige-small-loops\Panel2_nm.png'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 1
      Style.BackgroundImage.Height = 47
      Style.BackgroundRepeat = cbrRepeatX
      Style.FontSize = '18'
      Style.BackgroundColor = 13820654
      AutoSizeXY = asNone
      object Label20: TdhLabel
        Left = 17
        Top = 9
        Width = 127
        Height = 12
        Text = 'Website powered by'
        Style.BorderTop.Color = 7631979
        Style.BorderTop.Style = cbsNone
        Style.FontSize = '10'
        Style.Color = 16512
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link1: TdhLink
        Left = 121
        Top = 9
        Width = 55
        Height = 12
        Text = 'DFM2HTML'
        Style.FontSize = '10'
        Style.Color = 5402006
        Style.FontWeight = cfwBold
        Style.TextDecoration = [ctdNone]
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.dfm2html.com'
        Target = '_blank'
      end
      object Label29: TdhLabel
        Left = 180
        Top = 9
        Width = 156
        Height = 12
        Text = 'the easy to use Website Editor'
        Style.FontSize = '10'
        Style.Color = 16512
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Label31: TdhLabel
        Left = 110
        Top = 24
        Width = 241
        Height = 12
        Text = 'Solutions and Workshops for small Companies'
        Style.FontSize = '10'
        Style.Color = 16512
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link2: TdhLink
        Left = 68
        Top = 23
        Width = 40
        Height = 12
        Text = 'amaveo'
        Style.FontSize = '10'
        Style.Color = 5402006
        Style.FontWeight = cfwBold
        Style.TextDecoration = [ctdNone]
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.amaveo.com'
        Target = '_blank'
      end
      object Label28: TdhLabel
        Left = 17
        Top = 21
        Width = 63
        Height = 12
        Text = 'Layout by'
        Style.FontSize = '10'
        Style.Color = 16512
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
    end
    object Panel5: TdhPanel
      Left = 70
      Top = 154
      Width = 165
      Height = 41
      Style.BackgroundImage.Path = 'images-beige-small-loops\Panel5_nm.png'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 1
      Style.BackgroundImage.Height = 41
      Style.BackgroundRepeat = cbrRepeatX
      AutoSizeXY = asNone
      object Panel6: TdhPanel
        Left = 191
        Top = 0
        Width = 165
        Height = 41
        Style.BackgroundImage.Path = 'images-beige-small-loops\Panel6_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 1
        Style.BackgroundImage.Height = 41
        Style.BackgroundRepeat = cbrRepeatX
        AutoSizeXY = asNone
      end
      object Panel7: TdhPanel
        Left = 173
        Top = 1
        Width = 165
        Height = 41
        Style.BackgroundImage.Path = 'images-beige-small-loops\Panel7_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 1
        Style.BackgroundImage.Height = 41
        Style.BackgroundRepeat = cbrRepeatX
        AutoSizeXY = asNone
        object Panel8: TdhPanel
          Left = 191
          Top = 0
          Width = 165
          Height = 41
          Style.BackgroundImage.Path = 'images-beige-small-loops\Panel8_nm.png'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 1
          Style.BackgroundImage.Height = 41
          Style.BackgroundRepeat = cbrRepeatX
          AutoSizeXY = asNone
        end
      end
      object Link6: TdhLink
        Left = 31
        Top = 13
        Width = 81
        Height = 16
        Text = 'Link Page 2'
        Style.FontSize = '14'
        Style.FontFamily = 'Arial'
        Style.Color = 15420
        Style.FontStyle = cfsItalic
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        Layout = ltLink
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = './Page2.html'
      end
    end
    object Panel9: TdhPanel
      Left = 71
      Top = 204
      Width = 165
      Height = 41
      Style.BackgroundImage.Path = 'images-beige-small-loops\Panel9_nm.png'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 1
      Style.BackgroundImage.Height = 41
      Style.BackgroundRepeat = cbrRepeatX
      AutoSizeXY = asNone
      object Panel10: TdhPanel
        Left = 191
        Top = 0
        Width = 165
        Height = 41
        Style.BackgroundImage.Path = 'images-beige-small-loops\Panel10_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 1
        Style.BackgroundImage.Height = 41
        Style.BackgroundRepeat = cbrRepeatX
        AutoSizeXY = asNone
      end
      object Panel11: TdhPanel
        Left = 0
        Top = 48
        Width = 165
        Height = 41
        Style.BackgroundImage.Path = 'images-beige-small-loops\Panel11_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 1
        Style.BackgroundImage.Height = 41
        Style.BackgroundRepeat = cbrRepeatX
        AutoSizeXY = asNone
        object Panel12: TdhPanel
          Left = 191
          Top = 0
          Width = 165
          Height = 41
          Style.BackgroundImage.Path = 'images-beige-small-loops\Panel12_nm.png'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 1
          Style.BackgroundImage.Height = 41
          Style.BackgroundRepeat = cbrRepeatX
          AutoSizeXY = asNone
        end
      end
      object Link7: TdhLink
        Left = 30
        Top = 16
        Width = 81
        Height = 16
        Text = 'Link Page 3'
        Style.FontSize = '14'
        Style.FontFamily = 'Arial'
        Style.Color = 15420
        Style.FontStyle = cfsItalic
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = './Page3.html'
      end
    end
    object Panel15: TdhPanel
      Left = 30
      Top = 22
      Width = 808
      Height = 39
      Style.BackgroundImage.Path = 'images-beige-small-loops\Panel15_nm.png'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 1
      Style.BackgroundImage.Height = 39
      Style.BackgroundRepeat = cbrRepeatX
      AutoSizeXY = asNone
    end
  end
end
