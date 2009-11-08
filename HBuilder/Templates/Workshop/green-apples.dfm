object PageContainer15: TPageContainer15
  Left = -4
  Top = -23
  Caption = 'green-apples.dfm'
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
    Style.BackgroundImage.Path = 'images-green-apples\index_nm.png'
    Style.BackgroundImage.State = isAnalyzed
    Style.BackgroundImage.Width = 1
    Style.BackgroundImage.Height = 761
    Style.BackgroundRepeat = cbrRepeatX
    Style.PaddingRight = 0
    Style.MarginTop = '0'
    Style.MarginRight = '0'
    Style.BackgroundColor = Olive
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Title = 'Unterseite01'
    object Panel4: TdhPanel
      Left = 16
      Top = 18
      Width = 800
      Height = 732
      Style.BackgroundColor = 4898232
      AutoSizeXY = asNone
      object Panel2: TdhPanel
        Left = 502
        Top = 224
        Width = 270
        Height = 432
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        object Panel6: TdhPanel
          Left = 26
          Top = 72
          Width = 192
          Height = 32
          Style.BackgroundColor = Olive
          Style.Color = White
          AutoSizeXY = asNone
          object Panel13: TdhPanel
            Left = -8
            Top = 368
            Width = 192
            Height = 32
            Style.BackgroundColor = Olive
            AutoSizeXY = asNone
          end
          object Label7: TdhLabel
            Left = 8
            Top = 8
            Width = 155
            Height = 19
            Text = '<i>Headline</i>'
            AutoSizeXY = asY
          end
        end
        object Panel14: TdhPanel
          Left = 26
          Top = 104
          Width = 192
          Height = 116
          Style.BackgroundImage.Path = 'images-green-apples\Panel14_nm.png'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 1
          Style.BackgroundImage.Height = 116
          Style.BackgroundRepeat = cbrRepeatX
          AutoSizeXY = asNone
          object Link1: TdhLink
            Left = 48
            Top = 24
            Width = 80
            Height = 16
            Text = 'Link Page 1'
            Style.FontSize = '14'
            Style.Color = Olive
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            Layout = ltLink
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './index.html'
          end
          object Link2: TdhLink
            Left = 48
            Top = 56
            Width = 80
            Height = 16
            Text = 'Link Page 2'
            Style.FontSize = '14'
            Style.Color = Olive
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            Layout = ltLink
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page2.html'
          end
        end
        object Panel17: TdhPanel
          Left = 26
          Top = 256
          Width = 200
          Height = 32
          Style.BackgroundColor = Olive
          Style.Color = White
          AutoSizeXY = asNone
          object Label9: TdhLabel
            Left = 8
            Top = 8
            Width = 150
            Height = 19
            Text = '<i>Headline</i>'
            AutoSizeXY = asY
          end
        end
        object Panel18: TdhPanel
          Left = 26
          Top = 288
          Width = 200
          Height = 104
          Style.BackgroundImage.Path = 'images-green-apples\Panel18_nm.png'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 1
          Style.BackgroundImage.Height = 96
          Style.BackgroundRepeat = cbrRepeatX
          Style.Color = Olive
          AutoSizeXY = asNone
          object Link8: TdhLink
            Left = -120
            Top = 180
            Width = 100
            Height = 16
            Text = 'Link zu Page 4'
            Style.FontSize = '14'
            Style.Color = White
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page4
            LinkAnchor = Page4
          end
          object Link11: TdhLink
            Left = 48
            Top = 12
            Width = 80
            Height = 16
            Text = 'Link Page 3'
            Style.FontSize = '14'
            Style.Color = Olive
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page3.html'
          end
          object Link12: TdhLink
            Left = 48
            Top = 36
            Width = 80
            Height = 16
            Text = 'Link Page 4'
            Style.FontSize = '14'
            Style.Color = Olive
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page4.html'
          end
        end
      end
      object Label15: TdhLabel
        Left = 27
        Top = 703
        Width = 104
        Height = 12
        Text = 'Website powered by'
        Style.BorderTop.Color = 7631979
        Style.BorderTop.Style = cbsNone
        Style.FontSize = '10'
        Style.Color = 3957115
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link15: TdhLink
        Left = 131
        Top = 704
        Width = 55
        Height = 12
        Text = 'DFM2HTML'
        Style.FontSize = '10'
        Style.Color = 5064243
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.dfm2html.com'
        Target = '_blank'
      end
      object Label29: TdhLabel
        Left = 192
        Top = 704
        Width = 181
        Height = 12
        Text = 'the easy to use Website Editor'
        Style.FontSize = '10'
        Style.Color = 3957115
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Label31: TdhLabel
        Left = 123
        Top = 716
        Width = 329
        Height = 12
        Text = 'Solutions and Workshops for small Companies'
        Style.FontSize = '10'
        Style.Color = 3957115
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link16: TdhLink
        Left = 80
        Top = 715
        Width = 40
        Height = 12
        Text = 'amaveo'
        Style.FontSize = '10'
        Style.Color = 5064243
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.amaveo.com'
        Target = '_blank'
      end
      object Label28: TdhLabel
        Left = 27
        Top = 714
        Width = 48
        Height = 12
        Text = 'Layout by'
        Style.FontSize = '10'
        Style.Color = 3957115
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
        Left = 42
        Top = 242
        Width = 480
        Height = 432
        Style.PaddingBottom = 0
        Style.FontSize = '18'
        Style.MarginBottom = '0'
        Style.BackgroundColor = White
        Style.Color = Gray
        AutoSizeXY = asNone
        UseIFrame = False
        object Label3: TdhLabel
          Left = 48
          Top = 99
          Width = 391
          Height = 300
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'#10'<br/><br/>'#10'This t' +
            'emplate is generated under the licence of the Creative Commons.'#10 +
            'You are allowed to use the template and embedded pictures - but ' +
            'please do'#10'not remove the links in the footer of this template. I' +
            'f you like to change the'#10'picture, you will find a giude in your ' +
            'DFM2HTML installation files. The files'#10'are usually installed on ' +
            'your Drive C in a folder named Programs.'#10'<br/><br/>'#10'This templat' +
            'e is generated under the licence of the Creative Commons.'#10'You ar' +
            'e allowed to use the template and embedded pictures - but please' +
            ' do'#10'not remove the links in the footer of this template. If you ' +
            'like to change the'#10'picture, you will find a giude in your DFM2HT' +
            'ML installation files. The files'#10'are usually installed on your D' +
            'rive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 23387
          AutoSizeXY = asY
        end
        object Label4: TdhLabel
          Left = 46
          Top = 28
          Width = 60
          Height = 26
          Text = 'Home'
          Style.FontSize = '22'
          Style.Color = Olive
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Panel5: TdhPanel
          Left = 46
          Top = 60
          Width = 395
          Height = 16
          Style.BackgroundImage.Path = 'images-green-apples\Panel5_nm.jpg'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 381
          Style.BackgroundImage.Height = 29
          AutoSizeXY = asNone
        end
      end
      object Page2: TdhPage
        Left = 42
        Top = 242
        Width = 480
        Height = 432
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label12: TdhLabel
          Left = 46
          Top = 28
          Width = 70
          Height = 26
          Text = 'Page 2'
          Style.FontSize = '22'
          Style.Color = Olive
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Panel10: TdhPanel
          Left = 46
          Top = 60
          Width = 395
          Height = 16
          Style.BackgroundImage.Path = 'images-green-apples\Panel10_nm.jpg'
          AutoSizeXY = asNone
        end
        object Label13: TdhLabel
          Left = 48
          Top = 99
          Width = 391
          Height = 300
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'#10'<br/><br/>'#10'This t' +
            'emplate is generated under the licence of the Creative Commons.'#10 +
            'You are allowed to use the template and embedded pictures - but ' +
            'please do'#10'not remove the links in the footer of this template. I' +
            'f you like to change the'#10'picture, you will find a giude in your ' +
            'DFM2HTML installation files. The files'#10'are usually installed on ' +
            'your Drive C in a folder named Programs.'#10'<br/><br/>'#10'This templat' +
            'e is generated under the licence of the Creative Commons.'#10'You ar' +
            'e allowed to use the template and embedded pictures - but please' +
            ' do'#10'not remove the links in the footer of this template. If you ' +
            'like to change the'#10'picture, you will find a giude in your DFM2HT' +
            'ML installation files. The files'#10'are usually installed on your D' +
            'rive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 23387
          AutoSizeXY = asY
        end
      end
      object Page3: TdhPage
        Left = 42
        Top = 242
        Width = 480
        Height = 432
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label5: TdhLabel
          Left = 46
          Top = 28
          Width = 70
          Height = 26
          Text = 'Page 3'
          Style.FontSize = '22'
          Style.Color = Olive
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Panel7: TdhPanel
          Left = 46
          Top = 60
          Width = 395
          Height = 16
          Style.BackgroundImage.Path = 'images-green-apples\Panel7_nm.jpg'
          AutoSizeXY = asNone
        end
        object Label6: TdhLabel
          Left = 48
          Top = 99
          Width = 391
          Height = 300
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'#10'<br/><br/>'#10'This t' +
            'emplate is generated under the licence of the Creative Commons.'#10 +
            'You are allowed to use the template and embedded pictures - but ' +
            'please do'#10'not remove the links in the footer of this template. I' +
            'f you like to change the'#10'picture, you will find a giude in your ' +
            'DFM2HTML installation files. The files'#10'are usually installed on ' +
            'your Drive C in a folder named Programs.'#10'<br/><br/>'#10'This templat' +
            'e is generated under the licence of the Creative Commons.'#10'You ar' +
            'e allowed to use the template and embedded pictures - but please' +
            ' do'#10'not remove the links in the footer of this template. If you ' +
            'like to change the'#10'picture, you will find a giude in your DFM2HT' +
            'ML installation files. The files'#10'are usually installed on your D' +
            'rive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 23387
          AutoSizeXY = asY
        end
      end
      object Page4: TdhPage
        Left = 42
        Top = 242
        Width = 480
        Height = 432
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label8: TdhLabel
          Left = 46
          Top = 28
          Width = 70
          Height = 26
          Text = 'Page 4'
          Style.FontSize = '22'
          Style.Color = Olive
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Panel8: TdhPanel
          Left = 46
          Top = 60
          Width = 395
          Height = 16
          Style.BackgroundImage.Path = 'images-green-apples\Panel8_nm.jpg'
          AutoSizeXY = asNone
        end
        object PageControl2: TdhPageControl
          Left = 20
          Top = 20
          Width = 24
          Height = 24
          ActivePage = Page7
          FixedHeight = True
          object Page6: TdhPage
            Left = 40
            Top = 92
            Width = 400
            Height = 316
            AutoSizeXY = asNone
            UseIFrame = False
            object ContactForm: TdhHTMLForm
              Left = 8
              Top = 8
              Width = 388
              Height = 304
              AutoSizeXY = asNone
              Method = fmtPost
              object Submit1: TdhLink
                Left = 8
                Top = 272
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
              object Label11: TdhLabel
                Left = 4
                Top = 8
                Width = 65
                Height = 15
                Text = 'Your Name:'
                Style.FontSize = '12'
                Style.Color = 23387
                AutoSizeXY = asXY
              end
              object name: TdhEdit
                Left = 8
                Top = 24
                Width = 364
                Height = 23
                AutoSizeXY = asY
              end
              object Label2: TdhLabel
                Left = 8
                Top = 48
                Width = 37
                Height = 15
                Text = 'E-Mail:'
                Style.FontSize = '12'
                Style.Color = 23387
                AutoSizeXY = asXY
              end
              object email: TdhEdit
                Left = 8
                Top = 64
                Width = 364
                Height = 23
                AutoSizeXY = asY
              end
              object Label14: TdhLabel
                Left = 8
                Top = 140
                Width = 54
                Height = 15
                Text = 'Message:'
                Style.FontSize = '12'
                Style.Color = 23387
                AutoSizeXY = asXY
              end
              object message: TdhMemo
                Left = 8
                Top = 160
                Width = 364
                Height = 104
                AutoSizeXY = asNone
              end
              object Reset1: TdhLink
                Left = 80
                Top = 272
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
                Top = 272
                Width = 24
                Height = 24
                Value = 'dfm2html'
              end
              object Label18: TdhLabel
                Left = 8
                Top = 96
                Width = 39
                Height = 15
                Text = 'Phone:'
                Style.FontSize = '12'
                Style.Color = 23387
                AutoSizeXY = asXY
              end
              object Phone: TdhEdit
                Left = 8
                Top = 112
                Width = 364
                Height = 23
                AutoSizeXY = asY
              end
            end
          end
          object Page7: TdhPage
            Left = 40
            Top = 92
            Width = 400
            Height = 316
            Style.PaddingTop = 30
            AutoSizeXY = asNone
            UseIFrame = False
            object Label16: TdhLabel
              Left = 0
              Top = 49
              Height = 15
              Text = 'Thank you for your message, <?php echo $_POST["name"]?>!'
              Style.FontSize = '12'
              Style.TextAlign = ctaCenter
              Style.Color = 23387
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
            object Label17: TdhLabel
              Left = 0
              Top = 83
              Height = 24
              Text = '<?php echo $err?> &nbsp;&nbsp;<Link23>Go back</Link23>'
              Style.TextAlign = ctaCenter
              Style.Color = 23387
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
      Left = 40
      Top = 32
      Width = 750
      Height = 192
      Style.BorderLeft.Style = cbsNone
      Style.BorderRight.Style = cbsNone
      Style.BackgroundImage.Path = 'images-green-apples\Panel1_nm.jpg'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 750
      Style.BackgroundImage.Height = 202
      Style.BackgroundColor = White
      Use = Label2
      AutoSizeXY = asNone
      object Label1: TdhLabel
        Left = 15
        Top = 11
        Width = 254
        Height = 59
        Text = 'My first Website'
        Style.Border.Width = 12
        Style.Border.Color = Olive
        Style.Border.Style = cbsSolid
        Style.FontSize = '30'
        Style.BackgroundColor = Olive
        Style.Color = White
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
      end
    end
    object Panel9: TdhPanel
      Left = 40
      Top = 686
      Width = 750
      Height = 32
      Style.BorderLeft.Style = cbsNone
      Style.BorderRight.Style = cbsNone
      Style.BackgroundImage.Path = 'images-green-apples\Panel9_nm.jpg'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 916
      Style.BackgroundImage.Height = 49
      Style.BackgroundColor = White
      Use = Label2
      AutoSizeXY = asNone
      object Panel3: TdhPanel
        Left = 40
        Top = -616
        Height = 32
        Style.BorderLeft.Style = cbsNone
        Style.BorderRight.Style = cbsNone
        Style.BackgroundImage.Path = 'images-green-apples\Panel3_nm.jpg'
        Style.BackgroundColor = White
        Use = Label2
        AutoSizeXY = asNone
        Anchors = [akLeft, akTop, akRight]
        Right = 312
      end
    end
  end
end
