object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Caption = 'grey-ornaments.dfm'
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
    Style.BackgroundColor = White
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Title = 'Unterseite01'
    object Panel3: TdhPanel
      Left = 11
      Top = 14
      Width = 823
      Height = 700
      Style.BackgroundImage.Path = 'images-grey-ornaments\Panel3_nm.png'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 1
      Style.BackgroundImage.Height = 726
      Style.BackgroundRepeat = cbrRepeatX
      Style.BackgroundColor = 12961221
      AutoSizeXY = asNone
      object Panel1: TdhPanel
        Left = 535
        Top = 242
        Width = 244
        Height = 384
        Style.BorderTop.Style = cbsNone
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        object Panel2: TdhPanel
          Left = 76
          Top = 60
          Width = 152
          Height = 28
          Style.BorderTop.Width = 1
          Style.BorderTop.Color = 3881787
          Style.BorderTop.Style = cbsDotted
          AutoSizeXY = asNone
        end
        object Panel8: TdhPanel
          Left = 77
          Top = 177
          Width = 152
          Height = 28
          Style.BorderTop.Width = 1
          Style.BorderTop.Color = 3881787
          Style.BorderTop.Style = cbsDotted
          AutoSizeXY = asNone
        end
        object Panel6: TdhPanel
          Left = 77
          Top = 97
          Width = 152
          Height = 28
          Style.BorderTop.Width = 1
          Style.BorderTop.Color = 3881787
          Style.BorderTop.Style = cbsDotted
          AutoSizeXY = asNone
        end
        object Panel7: TdhPanel
          Left = 77
          Top = 137
          Width = 152
          Height = 28
          Style.BorderTop.Width = 1
          Style.BorderTop.Color = 3881787
          Style.BorderTop.Style = cbsDotted
          AutoSizeXY = asNone
        end
        object Link17: TdhLink
          Left = 116
          Top = 186
          Width = 75
          Height = 16
          Text = 'Link Page 4'
          Style.BorderBottom.Style = cbsNone
          Style.FontSize = '13'
          Style.Color = Black
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          Layout = ltLink
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          Link = './Page4.html'
        end
        object Link18: TdhLink
          Left = 117
          Top = 149
          Width = 75
          Height = 16
          Text = 'Link Page 3'
          Style.BorderBottom.Style = cbsNone
          Style.FontSize = '13'
          Style.Color = Black
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          Layout = ltLink
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          Link = './Page3.html'
        end
        object Link19: TdhLink
          Left = 115
          Top = 109
          Width = 75
          Height = 16
          Text = 'Link Page  2'
          Style.BorderBottom.Style = cbsNone
          Style.FontSize = '13'
          Style.Color = Black
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          Layout = ltLink
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          Link = './Page2.html'
        end
        object Link20: TdhLink
          Left = 112
          Top = 66
          Width = 75
          Height = 16
          Text = 'Link Page 1'
          Style.BorderBottom.Style = cbsNone
          Style.FontSize = '13'
          Style.Color = Black
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          Layout = ltLink
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          Link = './index.html'
        end
      end
      object Label13: TdhLabel
        Left = 31
        Top = 14
        Width = 484
        Height = 65
        Text = 'My own Website'
        Style.FontSize = '56'
        Style.FontFamily = 'CentSchbook BT'
        Style.Color = Black
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Panel4: TdhPanel
        Left = 32
        Top = 635
        Width = 748
        Height = 47
        AutoSizeXY = asNone
        object Label15: TdhLabel
          Left = 15
          Top = 7
          Width = 104
          Height = 12
          Text = 'Website powered by'
          Style.BorderTop.Color = 7631979
          Style.BorderTop.Style = cbsNone
          Style.FontSize = '10'
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asY
        end
        object Link15: TdhLink
          Left = 119
          Top = 8
          Width = 55
          Height = 12
          Text = 'DFM2HTML'
          Style.FontSize = '10'
          Style.Color = 8454143
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          Link = 'http://www.dfm2html.com'
          Target = '_blank'
        end
        object Label29: TdhLabel
          Left = 180
          Top = 8
          Width = 181
          Height = 12
          Text = 'the easy to use Website Editor'
          Style.FontSize = '10'
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asY
        end
        object Label31: TdhLabel
          Left = 111
          Top = 24
          Width = 329
          Height = 12
          Text = 'Solutions and Workshops for small Companies'
          Style.FontSize = '10'
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asY
        end
        object Link16: TdhLink
          Left = 68
          Top = 23
          Width = 40
          Height = 12
          Text = 'amaveo'
          Style.FontSize = '10'
          Style.Color = 8454143
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          Link = 'http://www.amaveo.com'
          Target = '_blank'
        end
        object Label28: TdhLabel
          Left = 15
          Top = 22
          Width = 63
          Height = 12
          Text = 'Layout by'
          Style.FontSize = '10'
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asY
        end
      end
      object Panel9: TdhPanel
        Left = 32
        Top = 84
        Width = 748
        Height = 160
        Style.BackgroundImage.Path = 'images-grey-ornaments\Panel9_nm.jpg'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 750
        Style.BackgroundImage.Height = 171
        AutoSizeXY = asNone
      end
    end
    object PageControl1: TdhPageControl
      Left = 8
      Top = 55
      Width = 24
      Height = 24
      ActivePage = Page1
      FixedHeight = False
      object Page1: TdhPage
        Left = 43
        Top = 256
        Width = 505
        Height = 384
        Style.BorderTop.Style = cbsNone
        Style.BorderRight.Style = cbsNone
        Style.PaddingBottom = 0
        Style.FontSize = '18'
        Style.MarginBottom = '0'
        Style.BackgroundColor = White
        Style.Color = Gray
        AutoSizeXY = asNone
        UseIFrame = False
        object Label3: TdhLabel
          Left = 43
          Top = 96
          Width = 410
          Height = 255
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
          Style.Color = 5197647
          AutoSizeXY = asY
        end
        object Label4: TdhLabel
          Left = 44
          Top = 46
          Width = 54
          Height = 24
          Text = 'Home'
          Style.FontSize = '20'
          Style.Color = Gray
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
      end
      object Page2: TdhPage
        Left = 43
        Top = 256
        Width = 505
        Height = 384
        Style.BorderRight.Style = cbsNone
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label1: TdhLabel
          Left = 44
          Top = 46
          Width = 64
          Height = 24
          Text = 'Page 2'
          Style.FontSize = '20'
          Style.Color = Gray
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label2: TdhLabel
          Left = 43
          Top = 96
          Width = 410
          Height = 255
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
          Style.Color = 5197647
          AutoSizeXY = asY
        end
      end
      object Page3: TdhPage
        Left = 43
        Top = 256
        Width = 505
        Height = 384
        Style.BorderRight.Color = 1610733
        Style.BorderRight.Style = cbsNone
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object Label5: TdhLabel
          Left = 44
          Top = 46
          Width = 64
          Height = 24
          Text = 'Page 3'
          Style.FontSize = '20'
          Style.Color = Gray
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label6: TdhLabel
          Left = 43
          Top = 96
          Width = 410
          Height = 255
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
          Style.Color = 5197647
          AutoSizeXY = asY
        end
      end
      object Page4: TdhPage
        Left = 43
        Top = 256
        Width = 505
        Height = 384
        Style.BorderRight.Color = 1610733
        Style.BorderRight.Style = cbsNone
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        UseIFrame = False
        object PageControl2: TdhPageControl
          Left = 18
          Top = 19
          Width = 24
          Height = 24
          ActivePage = Page6
          FixedHeight = True
          object Page6: TdhPage
            Left = 30
            Top = 85
            Width = 475
            Height = 296
            AutoSizeXY = asNone
            UseIFrame = False
            object ContactForm: TdhHTMLForm
              Left = 8
              Top = 8
              Width = 458
              Height = 276
              AutoSizeXY = asNone
              Method = fmtPost
              object Submit1: TdhLink
                Left = 10
                Top = 235
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
                Width = 65
                Height = 15
                Text = 'Your Name:'
                Style.FontSize = '12'
                Style.Color = 3881787
                AutoSizeXY = asXY
              end
              object name: TdhEdit
                Left = 8
                Top = 24
                Width = 433
                Height = 23
                AutoSizeXY = asY
              end
              object Label14: TdhLabel
                Left = 8
                Top = 48
                Width = 37
                Height = 15
                Text = 'E-Mail:'
                Style.FontSize = '12'
                Style.Color = 3881787
                AutoSizeXY = asXY
              end
              object email: TdhEdit
                Left = 8
                Top = 64
                Width = 434
                Height = 23
                AutoSizeXY = asY
              end
              object Label16: TdhLabel
                Left = 9
                Top = 144
                Width = 54
                Height = 15
                Text = 'Message:'
                Style.FontSize = '12'
                Style.Color = 3881787
                AutoSizeXY = asXY
              end
              object message: TdhMemo
                Left = 9
                Top = 161
                Width = 434
                Height = 68
                AutoSizeXY = asNone
              end
              object Reset1: TdhLink
                Left = 82
                Top = 235
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
                Left = 150
                Top = 235
                Width = 24
                Height = 24
                Value = 'dfm2html'
              end
              object Label19: TdhLabel
                Left = 9
                Top = 93
                Width = 39
                Height = 15
                Text = 'Phone:'
                Style.FontSize = '12'
                Style.Color = 3881787
                AutoSizeXY = asXY
              end
              object Phone: TdhEdit
                Left = 9
                Top = 111
                Width = 434
                Height = 23
                AutoSizeXY = asY
              end
            end
          end
          object Page7: TdhPage
            Left = 30
            Top = 85
            Width = 475
            Height = 296
            Style.PaddingTop = 30
            AutoSizeXY = asNone
            UseIFrame = False
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
            object Label18: TdhLabel
              Left = 0
              Top = 83
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
        object Label7: TdhLabel
          Left = 44
          Top = 46
          Width = 64
          Height = 24
          Text = 'Page 4'
          Style.FontSize = '20'
          Style.Color = Gray
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
      end
    end
  end
end
