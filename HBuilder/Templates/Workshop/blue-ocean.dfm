object PageContainer11: TPageContainer11
  Left = -4
  Top = -23
  Caption = 'blue-ocean.dfm'
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
    Style.BackgroundImage.Path = 'images-blue-ocean\index_nm.jpg'
    Style.BackgroundImage.State = isAnalyzed
    Style.BackgroundImage.Width = 300
    Style.BackgroundImage.Height = 820
    Style.PaddingRight = 0
    Style.MarginTop = '0'
    Style.MarginRight = '0'
    Style.BackgroundColor = 13750737
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Title = 'Unterseite01'
    object Panel4: TdhPanel
      Left = 16
      Top = 14
      Width = 805
      Height = 734
      Style.BackgroundColor = 12440289
      AutoSizeXY = asNone
      object Panel2: TdhPanel
        Left = 512
        Top = 163
        Width = 265
        Height = 465
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        object Panel6: TdhPanel
          Left = 32
          Top = 72
          Width = 192
          Height = 32
          Style.BackgroundColor = 4684190
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
            Width = 176
            Height = 16
            Text = '<i>Text Text Text</i>'
            Style.FontSize = '14'
            Style.FontWeight = cfwBold
            AutoSizeXY = asY
          end
        end
        object Panel14: TdhPanel
          Left = 32
          Top = 104
          Width = 192
          Height = 120
          Style.BackgroundImage.Path = 'images-blue-ocean\Panel14_nm.png'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 1
          Style.BackgroundImage.Height = 120
          Style.BackgroundRepeat = cbrRepeatX
          AutoSizeXY = asNone
          object Link1: TdhLink
            Left = 48
            Top = 24
            Width = 76
            Height = 16
            Text = 'LinkPage 1'
            Style.FontSize = '14'
            Style.Color = 4684190
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
            Style.Color = 4684190
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            Layout = ltLink
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page2.html'
          end
        end
        object Panel17: TdhPanel
          Left = 32
          Top = 256
          Width = 200
          Height = 32
          Style.BackgroundColor = 4684190
          Style.Color = White
          AutoSizeXY = asNone
          object Label9: TdhLabel
            Left = 8
            Top = 8
            Width = 176
            Height = 16
            Text = '<i>Text Text Text</i>'
            Style.FontSize = '14'
            Style.FontWeight = cfwBold
            AutoSizeXY = asY
          end
        end
        object Panel18: TdhPanel
          Left = 32
          Top = 288
          Width = 200
          Height = 104
          Style.BackgroundImage.Path = 'images-blue-ocean\Panel18_nm.png'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 1
          Style.BackgroundImage.Height = 104
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
            Top = 20
            Width = 80
            Height = 16
            Text = 'Link Page 3'
            Style.FontSize = '14'
            Style.Color = 4684190
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page3.html'
          end
          object Link12: TdhLink
            Left = 48
            Top = 52
            Width = 80
            Height = 16
            Text = 'Link Page 4'
            Style.FontSize = '14'
            Style.Color = 4684190
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page4.html'
          end
        end
      end
      object Panel1: TdhPanel
        Left = 24
        Top = 24
        Width = 750
        Height = 125
        Style.BackgroundImage.Path = 'images-blue-ocean\Panel1_nm.jpg'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 750
        Style.BackgroundImage.Height = 126
        AutoSizeXY = asNone
        object Label1: TdhLabel
          Left = 24
          Top = 64
          Width = 230
          Height = 35
          Text = 'My first Website'
          Style.FontSize = '30'
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
        end
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
        Top = 176
        Width = 490
        Height = 465
        Style.PaddingBottom = 0
        Style.FontSize = '18'
        Style.MarginBottom = '0'
        Style.BackgroundColor = White
        Style.Color = Gray
        AutoSizeXY = asNone
        UseIFrame = False
        object Label3: TdhLabel
          Left = 56
          Top = 99
          Width = 385
          Height = 300
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.<br/><br/>'#10'This tem' +
            'plate is generated under the licence of the Creative Commons.'#10'Yo' +
            'u are allowed to use the template and embedded pictures - but pl' +
            'ease do'#10'not remove the links in the footer of this template. If ' +
            'you like to change the'#10'picture, you will find a giude in your DF' +
            'M2HTML installation files. The files'#10'are usually installed on yo' +
            'u Drive C in a folder named Programs.<br/><br/>'#10'This template is' +
            ' generated under the licence of the Creative Commons.'#10'You are al' +
            'lowed to use the template and embedded pictures - but please do'#10 +
            'not remove the links in the footer of this template. If you like' +
            ' to change the'#10'picture, you will find a giude in your DFM2HTML i' +
            'nstallation files. The files'#10'are usually installed on you Drive ' +
            'C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label4: TdhLabel
          Left = 56
          Top = 48
          Width = 60
          Height = 26
          Text = 'Home'
          Style.FontSize = '22'
          Style.Color = 4684190
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
      end
      object Page2: TdhPage
        Left = 42
        Top = 176
        Width = 490
        Height = 465
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label12: TdhLabel
          Left = 56
          Top = 99
          Width = 385
          Height = 300
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.<br/><br/>'#10'This tem' +
            'plate is generated under the licence of the Creative Commons.'#10'Yo' +
            'u are allowed to use the template and embedded pictures - but pl' +
            'ease do'#10'not remove the links in the footer of this template. If ' +
            'you like to change the'#10'picture, you will find a giude in your DF' +
            'M2HTML installation files. The files'#10'are usually installed on yo' +
            'u Drive C in a folder named Programs.<br/><br/>'#10'This template is' +
            ' generated under the licence of the Creative Commons.'#10'You are al' +
            'lowed to use the template and embedded pictures - but please do'#10 +
            'not remove the links in the footer of this template. If you like' +
            ' to change the'#10'picture, you will find a giude in your DFM2HTML i' +
            'nstallation files. The files'#10'are usually installed on you Drive ' +
            'C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label13: TdhLabel
          Left = 56
          Top = 48
          Width = 70
          Height = 26
          Text = 'Page 2'
          Style.FontSize = '22'
          Style.Color = 4684190
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
      end
      object Page3: TdhPage
        Left = 42
        Top = 176
        Width = 490
        Height = 465
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label5: TdhLabel
          Left = 56
          Top = 99
          Width = 385
          Height = 300
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.<br/><br/>'#10'This tem' +
            'plate is generated under the licence of the Creative Commons.'#10'Yo' +
            'u are allowed to use the template and embedded pictures - but pl' +
            'ease do'#10'not remove the links in the footer of this template. If ' +
            'you like to change the'#10'picture, you will find a giude in your DF' +
            'M2HTML installation files. The files'#10'are usually installed on yo' +
            'u Drive C in a folder named Programs.<br/><br/>'#10'This template is' +
            ' generated under the licence of the Creative Commons.'#10'You are al' +
            'lowed to use the template and embedded pictures - but please do'#10 +
            'not remove the links in the footer of this template. If you like' +
            ' to change the'#10'picture, you will find a giude in your DFM2HTML i' +
            'nstallation files. The files'#10'are usually installed on you Drive ' +
            'C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label6: TdhLabel
          Left = 56
          Top = 48
          Width = 70
          Height = 26
          Text = 'Page 3'
          Style.FontSize = '22'
          Style.Color = 4684190
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
      end
      object Page4: TdhPage
        Left = 42
        Top = 176
        Width = 490
        Height = 465
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label11: TdhLabel
          Left = 56
          Top = 48
          Width = 70
          Height = 26
          Text = 'Page 4'
          Style.FontSize = '22'
          Style.Color = 4684190
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object PageControl2: TdhPageControl
          Left = 16
          Top = 16
          Width = 24
          Height = 24
          ActivePage = Page6
          FixedHeight = True
          object Page6: TdhPage
            Left = 56
            Top = 96
            Width = 400
            Height = 344
            AutoSizeXY = asNone
            UseIFrame = False
            object ContactForm: TdhHTMLForm
              Left = 8
              Top = 8
              Width = 384
              Height = 320
              AutoSizeXY = asNone
              Method = fmtPost
              object Submit1: TdhLink
                Left = 8
                Top = 288
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
              object Label8: TdhLabel
                Left = 4
                Top = 8
                Width = 65
                Height = 15
                Text = 'Your Name:'
                Style.FontSize = '12'
                Style.Color = 5191464
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
                Width = 37
                Height = 15
                Text = 'E-Mail:'
                Style.FontSize = '12'
                Style.Color = 5191464
                AutoSizeXY = asXY
              end
              object email: TdhEdit
                Left = 8
                Top = 64
                Width = 184
                Height = 23
                AutoSizeXY = asY
              end
              object Label15: TdhLabel
                Left = 9
                Top = 155
                Width = 54
                Height = 15
                Text = 'Message:'
                Style.FontSize = '12'
                Style.Color = 5191464
                AutoSizeXY = asXY
              end
              object message: TdhMemo
                Left = 8
                Top = 176
                Width = 360
                Height = 96
                AutoSizeXY = asNone
              end
              object Reset1: TdhLink
                Left = 80
                Top = 288
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
                Left = 152
                Top = 288
                Width = 24
                Height = 24
                Value = 'dfm2html'
              end
              object Label18: TdhLabel
                Left = 8
                Top = 99
                Width = 39
                Height = 15
                Text = 'Phone:'
                Style.FontSize = '12'
                Style.Color = 5191464
                AutoSizeXY = asXY
              end
              object Phone: TdhEdit
                Left = 8
                Top = 115
                Width = 184
                Height = 23
                AutoSizeXY = asY
              end
            end
          end
          object Page7: TdhPage
            Left = 56
            Top = 96
            Width = 400
            Height = 344
            Style.PaddingTop = 30
            AutoSizeXY = asNone
            UseIFrame = False
            object Label16: TdhLabel
              Left = 0
              Top = 49
              Height = 36
              Text = 'Thank you for your message, <?php echo $_POST["name"]?>!'
              Style.TextAlign = ctaCenter
              Style.FontStyle = cfsItalic
              Style.FontWeight = cfwBold
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
            end
            object DirectHTML2: TdhDirectHTML
              Left = 0
              Top = 85
              Height = 19
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              InnerHTML = '<?php'#13#10#9'} else {'#13#10'?>'
              GenerateContainer = False
            end
            object DirectHTML3: TdhDirectHTML
              Left = 0
              Top = 128
              Height = 19
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              InnerHTML = '<?php'#13#10#9'}'#13#10'?>'
              GenerateContainer = False
            end
            object Label17: TdhLabel
              Left = 0
              Top = 104
              Height = 24
              Text = '<?php echo $err?> &nbsp;&nbsp;<Link23>Go back</Link23>'
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
              object Link23: TdhLink
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
    end
    object Panel9: TdhPanel
      Left = 40
      Top = 657
      Width = 755
      Height = 67
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
        Style.BackgroundImage.Path = 'images-blue-ocean\Panel3_nm.jpg'
        Style.BackgroundColor = White
        Use = Label2
        AutoSizeXY = asNone
        Anchors = [akLeft, akTop, akRight]
        Right = 312
      end
      object Label14: TdhLabel
        Left = 60
        Top = 17
        Width = 127
        Height = 15
        Text = 'Website powered by'
        Style.BorderTop.Color = 7631979
        Style.BorderTop.Style = cbsNone
        Style.FontSize = '12'
        Style.Color = 7631979
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link3: TdhLink
        Left = 181
        Top = 17
        Width = 63
        Height = 15
        Text = 'DFM2HTML'
        Style.FontSize = '12'
        Style.Color = 5402006
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.dfm2html.com'
        Target = '_blank'
      end
      object Label29: TdhLabel
        Left = 247
        Top = 17
        Width = 181
        Height = 15
        Text = 'the easy to use Website Editor'
        Style.FontSize = '12'
        Style.Color = 7631979
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Label31: TdhLabel
        Left = 167
        Top = 37
        Width = 329
        Height = 15
        Text = 'Solutions and Workshops for small Companies'
        Style.FontSize = '12'
        Style.Color = 7631979
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link4: TdhLink
        Left = 118
        Top = 37
        Width = 45
        Height = 15
        Text = 'amaveo'
        Style.FontSize = '12'
        Style.Color = 5402006
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.amaveo.com'
        Target = '_blank'
      end
      object Label28: TdhLabel
        Left = 59
        Top = 36
        Width = 63
        Height = 15
        Text = 'Layout by'
        Style.FontSize = '12'
        Style.Color = 7631979
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
    end
  end
end
