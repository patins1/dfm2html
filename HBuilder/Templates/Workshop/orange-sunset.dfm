object PageContainer27: TPageContainer27
  Left = -4
  Top = -23
  Caption = 'orange-sunset.dfm'
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
    Style.PaddingRight = 0
    Style.MarginTop = '0'
    Style.MarginRight = '0'
    Style.BackgroundColor = 13750737
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Title = 'Unterseite01'
    GeneratedCSSFile = 'dfm2html.css'
    object Panel4: TdhPanel
      Left = 16
      Top = 10
      Width = 820
      Height = 776
      Style.BackgroundColor = 6666210
      AutoSizeXY = asNone
      object Panel2: TdhPanel
        Left = 562
        Top = 280
        Width = 220
        Height = 450
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        object Panel6: TdhPanel
          Left = 12
          Top = 72
          Width = 180
          Height = 32
          Style.BackgroundColor = 27090
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
            Left = 12
            Top = 10
            Width = 158
            Height = 16
            Text = '<i>Text Text Text</i>'
            Style.FontSize = '13'
            Style.FontWeight = cfwBold
            AutoSizeXY = asY
          end
        end
        object Panel14: TdhPanel
          Left = 12
          Top = 104
          Width = 180
          Height = 120
          Style.BackgroundImage.Path = 'images-orange-sunset\Panel14_nm.png'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 1
          Style.BackgroundImage.Height = 120
          Style.BackgroundRepeat = cbrRepeatX
          AutoSizeXY = asNone
          object Link1: TdhLink
            Left = 38
            Top = 24
            Width = 75
            Height = 16
            Text = 'Link Page 1'
            Style.FontSize = '13'
            Style.Color = 27090
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            Layout = ltLink
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './index.html'
          end
          object Link2: TdhLink
            Left = 38
            Top = 56
            Width = 75
            Height = 16
            Text = 'Link Page 2'
            Style.FontSize = '13'
            Style.Color = 27090
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            Layout = ltLink
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page2.html'
          end
        end
        object Panel17: TdhPanel
          Left = 12
          Top = 256
          Width = 180
          Height = 32
          Style.BackgroundColor = 27090
          Style.Color = White
          AutoSizeXY = asNone
          object Label9: TdhLabel
            Left = 12
            Top = 8
            Width = 143
            Height = 16
            Text = '<i>Text Text Text</i>'
            Style.FontSize = '13'
            Style.FontWeight = cfwBold
            AutoSizeXY = asY
          end
        end
        object Panel18: TdhPanel
          Left = 12
          Top = 288
          Width = 180
          Height = 104
          Style.BackgroundImage.Path = 'images-orange-sunset\Panel18_nm.png'
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
            Left = 38
            Top = 20
            Width = 75
            Height = 16
            Text = 'Link Page 3'
            Style.FontSize = '13'
            Style.Color = 27090
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page3.html'
          end
          object Link12: TdhLink
            Left = 38
            Top = 52
            Width = 75
            Height = 16
            Text = 'Link Page 4'
            Style.FontSize = '13'
            Style.Color = 27090
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
        Width = 760
        Height = 230
        Style.BackgroundImage.Path = 'images-orange-sunset\Panel1_nm.jpg'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 760
        Style.BackgroundImage.Height = 236
        AutoSizeXY = asNone
        object Label1: TdhLabel
          Left = 155
          Top = 37
          Width = 196
          Height = 43
          Text = 'My Website'
          Style.FontSize = '36'
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
        end
      end
      object Label17: TdhLabel
        Left = 27
        Top = 738
        Width = 127
        Height = 14
        Text = 'Website powered by'
        Style.BorderTop.Color = 7631979
        Style.BorderTop.Style = cbsNone
        Style.FontSize = '11'
        Style.Color = 142504
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link5: TdhLink
        Left = 148
        Top = 738
        Width = 60
        Height = 14
        Text = 'DFM2HTML'
        Style.FontSize = '11'
        Style.Color = 5402006
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.dfm2html.com'
        Target = '_blank'
      end
      object Label29: TdhLabel
        Left = 214
        Top = 738
        Width = 181
        Height = 14
        Text = 'the easy to use Website Editor'
        Style.FontSize = '11'
        Style.Color = 142504
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Label31: TdhLabel
        Left = 134
        Top = 758
        Width = 329
        Height = 14
        Text = 'Solutions and Workshops for small Companies'
        Style.FontSize = '11'
        Style.Color = 142504
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link6: TdhLink
        Left = 85
        Top = 758
        Width = 43
        Height = 14
        Text = 'amaveo'
        Style.FontSize = '11'
        Style.Color = 5402006
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.amaveo.com'
        Target = '_blank'
      end
      object Label28: TdhLabel
        Left = 26
        Top = 757
        Width = 63
        Height = 14
        Text = 'Layout by'
        Style.FontSize = '11'
        Style.Color = 142504
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
        Top = 290
        Width = 540
        Height = 450
        Style.PaddingBottom = 0
        Style.FontSize = '18'
        Style.MarginBottom = '0'
        Style.BackgroundColor = White
        Style.Color = Gray
        AutoSizeXY = asNone
        UseIFrame = False
        object Label3: TdhLabel
          Left = 36
          Top = 81
          Width = 209
          Height = 150
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 2042179
          AutoSizeXY = asY
        end
        object Label4: TdhLabel
          Left = 36
          Top = 16
          Width = 79
          Height = 33
          Text = 'Home'
          Style.FontSize = '28'
          Style.Color = 6666210
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Panel5: TdhPanel
          Left = 282
          Top = 76
          Width = 200
          Height = 152
          Style.BackgroundImage.Path = 'images-orange-sunset\Panel5_nm.jpg'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 200
          Style.BackgroundImage.Height = 170
          AutoSizeXY = asNone
        end
        object Panel3: TdhPanel
          Left = 44
          Top = 260
          Width = 200
          Height = 152
          Style.BackgroundImage.Path = 'images-orange-sunset\Panel3_nm.jpg'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 200
          Style.BackgroundImage.Height = 170
          AutoSizeXY = asNone
        end
        object Label2: TdhLabel
          Left = 282
          Top = 258
          Width = 207
          Height = 150
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 2042179
          AutoSizeXY = asY
        end
      end
      object Page2: TdhPage
        Left = 42
        Top = 290
        Width = 540
        Height = 450
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label13: TdhLabel
          Left = 36
          Top = 16
          Width = 91
          Height = 33
          Text = 'Page 2'
          Style.FontSize = '28'
          Style.Color = 6666210
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label12: TdhLabel
          Left = 36
          Top = 81
          Width = 209
          Height = 150
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 2042179
          AutoSizeXY = asY
        end
        object Panel7: TdhPanel
          Left = 282
          Top = 76
          Width = 200
          Height = 152
          Style.BackgroundImage.Path = 'images-orange-sunset\Panel7_nm.jpg'
          AutoSizeXY = asNone
        end
        object Label14: TdhLabel
          Left = 282
          Top = 258
          Width = 207
          Height = 150
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 2042179
          AutoSizeXY = asY
        end
        object Panel8: TdhPanel
          Left = 44
          Top = 260
          Width = 200
          Height = 152
          Style.BackgroundImage.Path = 'images-orange-sunset\Panel8_nm.jpg'
          AutoSizeXY = asNone
        end
      end
      object Page3: TdhPage
        Left = 42
        Top = 290
        Width = 540
        Height = 450
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label6: TdhLabel
          Left = 36
          Top = 16
          Width = 91
          Height = 33
          Text = 'Page 3'
          Style.FontSize = '28'
          Style.Color = 6666210
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label5: TdhLabel
          Left = 36
          Top = 81
          Width = 209
          Height = 150
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 2042179
          AutoSizeXY = asY
        end
        object Panel9: TdhPanel
          Left = 282
          Top = 76
          Width = 200
          Height = 152
          Style.BackgroundImage.Path = 'images-orange-sunset\Panel9_nm.jpg'
          AutoSizeXY = asNone
        end
        object Label15: TdhLabel
          Left = 282
          Top = 258
          Width = 207
          Height = 150
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 2042179
          AutoSizeXY = asY
        end
        object Panel10: TdhPanel
          Left = 44
          Top = 260
          Width = 200
          Height = 152
          Style.BackgroundImage.Path = 'images-orange-sunset\Panel10_nm.jpg'
          AutoSizeXY = asNone
        end
      end
      object Page4: TdhPage
        Left = 42
        Top = 290
        Width = 540
        Height = 450
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label11: TdhLabel
          Left = 36
          Top = 16
          Width = 91
          Height = 33
          Text = 'Page 4'
          Style.FontSize = '28'
          Style.Color = 6666210
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label16: TdhLabel
          Left = 37
          Top = 58
          Width = 458
          Height = 75
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on your Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 2042179
          AutoSizeXY = asY
        end
        object PageControl2: TdhPageControl
          Left = 16
          Top = 16
          Width = 24
          Height = 24
          ActivePage = Page6
          FixedHeight = True
          object Page6: TdhPage
            Left = 23
            Top = 141
            Width = 486
            Height = 256
            AutoSizeXY = asNone
            UseIFrame = False
            object ContactForm: TdhHTMLForm
              Left = 8
              Top = 8
              Width = 472
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
                LinkPage = Page7
                FormButtonType = fbSubmit
              end
              object Label8: TdhLabel
                Left = 9
                Top = 10
                Width = 65
                Height = 15
                Text = 'Your Name:'
                Style.FontSize = '12'
                Style.Color = 2042179
                AutoSizeXY = asXY
              end
              object name: TdhEdit
                Left = 8
                Top = 30
                Width = 223
                Height = 23
                AutoSizeXY = asY
              end
              object Label18: TdhLabel
                Left = 252
                Top = 12
                Width = 37
                Height = 15
                Text = 'E-Mail:'
                Style.FontSize = '12'
                Style.Color = 2042179
                AutoSizeXY = asXY
              end
              object email: TdhEdit
                Left = 252
                Top = 31
                Width = 211
                Height = 23
                AutoSizeXY = asY
              end
              object Label19: TdhLabel
                Left = 8
                Top = 65
                Width = 54
                Height = 15
                Text = 'Message:'
                Style.FontSize = '12'
                Style.Color = 2042179
                AutoSizeXY = asXY
              end
              object message: TdhMemo
                Left = 8
                Top = 84
                Width = 455
                Height = 116
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
          object Page7: TdhPage
            Left = 23
            Top = 141
            Width = 486
            Height = 256
            Style.PaddingTop = 30
            AutoSizeXY = asNone
            UseIFrame = False
            object Label20: TdhLabel
              Left = 0
              Top = 49
              Height = 18
              Text = 'Thank you for your message, <?php echo $_POST["name"]?>!'
              Style.TextAlign = ctaCenter
              Style.Color = 2042179
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
            object Label21: TdhLabel
              Left = 0
              Top = 86
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
  end
end
