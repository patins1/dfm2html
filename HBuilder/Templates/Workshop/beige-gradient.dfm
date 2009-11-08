object PageContainer3: TPageContainer3
  Left = -4
  Top = -23
  Caption = 'beige-gradient.dfm'
  ClientHeight = 776
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
    Style.BackgroundImage.Path = 'images-beige-gradient\index_nm.png'
    Style.BackgroundImage.State = isAnalyzed
    Style.BackgroundImage.Width = 1264
    Style.BackgroundImage.Height = 1
    Style.BackgroundRepeat = cbrRepeatY
    Style.PaddingRight = 0
    Style.MarginTop = '0'
    Style.MarginRight = '0'
    Style.BackgroundColor = White
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Title = 'Unterseite01'
    object Panel9: TdhPanel
      Left = 44
      Top = 630
      Width = 773
      Height = 41
      Style.BorderLeft.Style = cbsNone
      Style.BorderRight.Style = cbsNone
      Style.BackgroundColor = White
      Use = Label2
      AutoSizeXY = asNone
      object Panel3: TdhPanel
        Left = 40
        Top = -616
        Height = 32
        Style.BorderLeft.Style = cbsNone
        Style.BorderRight.Style = cbsNone
        Style.BackgroundImage.Path = 'images-beige-gradient\Panel3_nm.jpg'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 500
        Style.BackgroundImage.Height = 447
        Style.BackgroundColor = White
        Use = Label2
        AutoSizeXY = asNone
        Anchors = [akLeft, akTop, akRight]
        Right = 312
      end
      object Label13: TdhLabel
        Left = 16
        Top = -56
        Width = 100
        Height = 16
        Text = 'Text T'
        Style.Color = 4210816
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Label17: TdhLabel
        Left = 17
        Top = 6
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
      object Link5: TdhLink
        Left = 121
        Top = 6
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
        Top = 6
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
        Top = 21
        Width = 241
        Height = 12
        Text = 'Solutions and Workshops for small Companies'
        Style.FontSize = '10'
        Style.Color = 16512
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link6: TdhLink
        Left = 68
        Top = 20
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
        Top = 18
        Width = 63
        Height = 12
        Text = 'Layout by'
        Style.FontSize = '10'
        Style.Color = 16512
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
    end
    object PageControl1: TdhPageControl
      Left = 8
      Top = 105
      Width = 24
      Height = 24
      ActivePage = Page1
      FixedHeight = False
      object Page1: TdhPage
        Left = 45
        Top = 183
        Width = 525
        Height = 435
        Style.PaddingBottom = 0
        Style.FontSize = '18'
        Style.MarginBottom = '0'
        Style.BackgroundColor = White
        Style.Color = Gray
        AutoSizeXY = asNone
        UseIFrame = False
        object Label3: TdhLabel
          Left = 62
          Top = 140
          Width = 390
          Height = 240
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
          Style.FontSize = '14'
          Style.TextAlign = ctaJustify
          Style.Color = 1186853
          AutoSizeXY = asY
        end
        object Label4: TdhLabel
          Left = 54
          Top = 40
          Width = 73
          Height = 30
          Text = 'Home'
          Style.FontSize = '26'
          Style.Color = 3957115
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
      end
      object Page2: TdhPage
        Left = 45
        Top = 183
        Width = 525
        Height = 435
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label6: TdhLabel
          Left = 62
          Top = 140
          Width = 390
          Height = 240
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
          Style.FontSize = '14'
          Style.TextAlign = ctaJustify
          Style.Color = 1186853
          AutoSizeXY = asY
        end
        object Label7: TdhLabel
          Left = 54
          Top = 40
          Width = 83
          Height = 30
          Text = 'Page 2'
          Style.FontSize = '26'
          Style.Color = 3957115
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
      end
      object Page3: TdhPage
        Left = 45
        Top = 183
        Width = 525
        Height = 435
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label8: TdhLabel
          Left = 62
          Top = 140
          Width = 390
          Height = 240
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
          Style.FontSize = '14'
          Style.TextAlign = ctaJustify
          Style.Color = 1186853
          AutoSizeXY = asY
        end
        object Label9: TdhLabel
          Left = 54
          Top = 40
          Width = 83
          Height = 30
          Text = 'Page 3'
          Style.FontSize = '26'
          Style.Color = 3957115
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
      end
      object Page4: TdhPage
        Left = 45
        Top = 183
        Width = 525
        Height = 435
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label11: TdhLabel
          Left = 54
          Top = 40
          Width = 83
          Height = 30
          Text = 'Page 4'
          Style.FontSize = '26'
          Style.Color = 3957115
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
            Left = 47
            Top = 88
            Width = 434
            Height = 328
            AutoSizeXY = asNone
            UseIFrame = False
            object ContactForm: TdhHTMLForm
              Left = 8
              Top = 8
              Width = 411
              Height = 313
              AutoSizeXY = asNone
              Method = fmtPost
              object Submit1: TdhLink
                Left = 13
                Top = 279
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
              object Label12: TdhLabel
                Left = 4
                Top = 8
                Width = 74
                Height = 16
                Text = 'Your Name:'
                Style.FontSize = '14'
                Style.Color = 1186853
                AutoSizeXY = asXY
              end
              object name: TdhEdit
                Left = 8
                Top = 24
                Width = 385
                Height = 23
                AutoSizeXY = asY
              end
              object Label2: TdhLabel
                Left = 8
                Top = 48
                Width = 43
                Height = 16
                Text = 'E-Mail:'
                Style.FontSize = '14'
                Style.Color = 1186853
                AutoSizeXY = asXY
              end
              object email: TdhEdit
                Left = 8
                Top = 64
                Width = 385
                Height = 23
                AutoSizeXY = asY
              end
              object Label14: TdhLabel
                Left = 9
                Top = 146
                Width = 61
                Height = 16
                Text = 'Message:'
                Style.FontSize = '14'
                Style.Color = 1186853
                AutoSizeXY = asXY
              end
              object message: TdhMemo
                Left = 8
                Top = 163
                Width = 387
                Height = 108
                AutoSizeXY = asNone
              end
              object Reset1: TdhLink
                Left = 85
                Top = 279
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
                Left = 149
                Top = 279
                Width = 24
                Height = 24
                Value = 'dfm2html'
              end
              object Label18: TdhLabel
                Left = 8
                Top = 95
                Width = 45
                Height = 16
                Text = 'Phone:'
                Style.FontSize = '14'
                Style.Color = 1186853
                AutoSizeXY = asXY
              end
              object Phone: TdhEdit
                Left = 8
                Top = 111
                Width = 385
                Height = 23
                AutoSizeXY = asY
              end
            end
          end
          object Page7: TdhPage
            Left = 47
            Top = 88
            Width = 434
            Height = 328
            Style.PaddingTop = 30
            AutoSizeXY = asNone
            UseIFrame = False
            object Label15: TdhLabel
              Left = 0
              Top = 49
              Height = 18
              Text = 'Thank you for your message, <?php echo $_POST["name"]?>!'
              Style.TextAlign = ctaCenter
              Style.Color = 1186853
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
            end
            object DirectHTML2: TdhDirectHTML
              Left = 0
              Top = 67
              Height = 19
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              InnerHTML = '<?php'#13#10#9'} else {'#13#10'?>'
              GenerateContainer = False
            end
            object DirectHTML3: TdhDirectHTML
              Left = 0
              Top = 110
              Height = 19
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              InnerHTML = '<?php'#13#10#9'}'#13#10'?>'
              GenerateContainer = False
            end
            object Label16: TdhLabel
              Left = 0
              Top = 86
              Height = 24
              Text = '<?php echo $err?> &nbsp;&nbsp;<Link23>Go back</Link23>'
              Style.TextAlign = ctaCenter
              Style.Color = 1186853
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
    end
    object Panel1: TdhPanel
      Left = 46
      Top = 32
      Width = 770
      Height = 71
      Style.BorderLeft.Style = cbsNone
      Style.BorderRight.Style = cbsNone
      Style.BackgroundColor = White
      Use = Label2
      AutoSizeXY = asNone
      object Label1: TdhLabel
        Left = 21
        Top = 14
        Width = 305
        Height = 46
        Text = 'My first Website'
        Style.FontSize = '40'
        Style.Color = 3957115
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
      end
    end
    object Panel2: TdhPanel
      Left = 45
      Top = 116
      Width = 773
      Height = 56
      Style.Border.Width = 0
      Style.Border.Color = 1610733
      Style.Border.Style = cbsSolid
      Style.BackgroundImage.Path = 'images-beige-gradient\Panel2_nm.jpg'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 50
      Style.BackgroundImage.Height = 50
      Style.BackgroundColor = Gray
      Style.Color = 366842
      AutoSizeXY = asNone
      object Link1: TdhLink
        Left = 40
        Top = 18
        Width = 80
        Height = 16
        Text = 'Link Page 1'
        Style.FontSize = '14'
        Style.Color = 1186853
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        Layout = ltLink
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = './index.html'
      end
      object Link3: TdhLink
        Left = 168
        Top = 19
        Width = 80
        Height = 16
        Text = 'Link Page 2'
        Style.FontSize = '14'
        Style.Color = 1186853
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        Layout = ltLink
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = './Page2.html'
      end
      object Link2: TdhLink
        Left = 291
        Top = 19
        Width = 80
        Height = 16
        Text = 'Link Page 3'
        Style.FontSize = '14'
        Style.Color = 1186853
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = './Page3.html'
      end
      object Link4: TdhLink
        Left = 414
        Top = 21
        Width = 80
        Height = 16
        Text = 'Link Page 4'
        Style.FontSize = '14'
        Style.Color = 1186853
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = './Page4.html'
      end
    end
    object Panel4: TdhPanel
      Left = 567
      Top = 183
      Width = 248
      Height = 436
      Style.Border.Width = 2
      Style.Border.Color = 1610733
      Style.Border.Style = cbsNone
      Style.BackgroundColor = White
      Style.Color = 14071439
      AutoSizeXY = asNone
      object Panel5: TdhPanel
        Left = 8
        Top = 143
        Width = 211
        Height = 226
        Style.BackgroundImage.Path = 'images-beige-gradient\Panel5_nm.jpg'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 50
        Style.BackgroundImage.Height = 250
        Style.BackgroundColor = 1610733
        AutoSizeXY = asNone
      end
      object Label5: TdhLabel
        Left = 21
        Top = 160
        Width = 180
        Height = 193
        Text = 
          #10'<p><b>Contact:</b></p>'#10'<p>Name Name<br>'#10'Street Street Street<br' +
          '>'#10'City City City</p>'#10#10'<p>Phone: 999 / 99 99 99 99<br>'#10'Fax: 999 /' +
          ' 99 99 99 99</p>'#10#10'<p>E-Mail: info@domain.de<br>'#10'Web: www.domain.' +
          'de</p>'
        Style.FontSize = '13'
        Style.Color = 1186853
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
    end
  end
end
