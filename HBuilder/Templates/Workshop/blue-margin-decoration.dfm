object PageContainer9: TPageContainer9
  Left = -4
  Top = -23
  Caption = 'blue-margin-decoration.dfm'
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
      Left = 124
      Top = 10
      Width = 720
      Height = 730
      Style.BackgroundColor = White
      AutoSizeXY = asNone
      object Panel2: TdhPanel
        Left = 23
        Top = 118
        Width = 225
        Height = 530
        Style.BackgroundColor = White
        Style.BorderRadius.All = '11'
        AutoSizeXY = asNone
        object Panel14: TdhPanel
          Left = 4
          Top = 12
          Width = 168
          Height = 488
          Style.Border.Color = White
          Style.Border.Style = cbsSolid
          Style.BorderRight.Width = 3
          Style.BorderRight.Color = 10120005
          Style.BorderRight.Style = cbsDotted
          Style.BackgroundColor = White
          AutoSizeXY = asNone
          object Link1: TdhLink
            Left = 10
            Top = 24
            Width = 80
            Height = 16
            Text = 'Link Page 1'
            Style.FontSize = '14'
            Style.Color = 5402006
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            Layout = ltLink
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './index.html'
          end
          object Link2: TdhLink
            Left = 8
            Top = 56
            Width = 80
            Height = 16
            Text = 'Link Page 2'
            Style.FontSize = '14'
            Style.Color = 5402006
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            Layout = ltLink
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page2.html'
          end
          object Link6: TdhLink
            Left = 7
            Top = 89
            Width = 80
            Height = 16
            Text = 'Link Page 3'
            Style.FontSize = '14'
            Style.Color = 5402006
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page3.html'
          end
          object Link7: TdhLink
            Left = 7
            Top = 122
            Width = 80
            Height = 16
            Text = 'Link Page 4'
            Style.FontSize = '14'
            Style.Color = 5402006
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page4.html'
          end
        end
      end
      object Panel1: TdhPanel
        Left = 20
        Top = 18
        Width = 670
        Height = 70
        Style.Border.Style = cbsNone
        Style.BorderBottom.Width = 3
        Style.BorderBottom.Color = 10120005
        Style.BorderBottom.Style = cbsDotted
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        object Label1: TdhLabel
          Left = 2
          Top = 22
          Width = 250
          Height = 37
          Text = 'My own Website'
          Style.FontSize = '32'
          Style.Color = 10120005
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
        end
      end
    end
    object PageControl1: TdhPageControl
      Left = 12
      Top = 15
      Width = 24
      Height = 24
      ActivePage = Page1
      FixedHeight = False
      object Page1: TdhPage
        Left = 342
        Top = 129
        Width = 474
        Height = 502
        Style.PaddingBottom = 0
        Style.FontSize = '18'
        Style.MarginBottom = '0'
        Style.BackgroundColor = White
        Style.Color = Gray
        AutoSizeXY = asNone
        UseIFrame = False
        object Label3: TdhLabel
          Left = 18
          Top = 12
          Width = 73
          Height = 30
          Text = 'Home'
          Style.FontSize = '26'
          Style.Color = 10120005
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label16: TdhLabel
          Left = 80
          Top = 105
          Width = 346
          Height = 90
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label4: TdhLabel
          Left = 80
          Top = 225
          Width = 344
          Height = 90
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label7: TdhLabel
          Left = 78
          Top = 347
          Width = 346
          Height = 90
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
      end
      object Page2: TdhPage
        Left = 342
        Top = 129
        Width = 474
        Height = 500
        Style.Border.Color = 12440289
        Style.BackgroundColor = White
        Style.BorderRadius.All = '11'
        AutoSizeXY = asNone
        UseIFrame = False
        object Label12: TdhLabel
          Left = 24
          Top = 16
          Width = 70
          Height = 26
          Text = 'Page 2'
          Style.FontSize = '22'
          Style.Color = 4684190
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label9: TdhLabel
          Left = 80
          Top = 105
          Width = 346
          Height = 90
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label13: TdhLabel
          Left = 80
          Top = 225
          Width = 344
          Height = 90
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label15: TdhLabel
          Left = 78
          Top = 347
          Width = 346
          Height = 90
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
      end
      object Page3: TdhPage
        Left = 342
        Top = 129
        Width = 474
        Height = 500
        Style.Border.Color = 12440289
        Style.BackgroundColor = White
        Style.BorderRadius.All = '11'
        AutoSizeXY = asNone
        UseIFrame = False
        object Label5: TdhLabel
          Left = 24
          Top = 16
          Width = 70
          Height = 26
          Text = 'Page 3'
          Style.FontSize = '22'
          Style.Color = 4684190
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Label6: TdhLabel
          Left = 80
          Top = 105
          Width = 346
          Height = 90
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label17: TdhLabel
          Left = 80
          Top = 225
          Width = 344
          Height = 90
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label18: TdhLabel
          Left = 78
          Top = 347
          Width = 346
          Height = 90
          Text = 
            'This template is generated under the licence of the Creative Com' +
            'mons.'#10'You are allowed to use the template and embedded pictures ' +
            '- but please do'#10'not remove the links in the footer of this templ' +
            'ate. If you like to change the'#10'picture, you will find a giude in' +
            ' your DFM2HTML installation files. The files'#10'are usually install' +
            'ed on you Drive C in a folder named Programs.'
          Style.FontSize = '12'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
      end
      object Page4: TdhPage
        Left = 342
        Top = 129
        Width = 474
        Height = 532
        Style.Border.Color = 12440289
        Style.BackgroundColor = White
        Style.BorderRadius.All = '11'
        AutoSizeXY = asNone
        UseIFrame = False
        object Label8: TdhLabel
          Left = 24
          Top = 16
          Width = 70
          Height = 26
          Text = 'Page 4'
          Style.FontSize = '22'
          Style.Color = 4684190
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Panel35: TdhPanel
          Left = 10
          Top = 64
          Width = 476
          Height = 458
          Style.BackgroundColor = White
          AutoSizeXY = asNone
          object PageControl2: TdhPageControl
            Left = 80
            Top = 12
            Width = 24
            Height = 24
            ActivePage = Page6
            FixedHeight = True
            object Page6: TdhPage
              Left = 12
              Top = 12
              Width = 440
              Height = 432
              AutoSizeXY = asNone
              UseIFrame = False
              object ContactForm: TdhHTMLForm
                Left = 4
                Top = 5
                Width = 432
                Height = 418
                AutoSizeXY = asNone
                Method = fmtPost
                object Submit1: TdhLink
                  Left = 8
                  Top = 377
                  Width = 63
                  Height = 24
                  Text = 'Submit'
                  Style.Color = 5191464
                  AutoSizeXY = asXY
                  Layout = ltButton
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page7
                  FormButtonType = fbSubmit
                end
                object Label11: TdhLabel
                  Left = 8
                  Top = 10
                  Width = 37
                  Height = 15
                  Text = 'Name:'
                  Style.FontSize = '12'
                  Style.Color = 5191464
                  AutoSizeXY = asXY
                end
                object name: TdhEdit
                  Left = 8
                  Top = 24
                  Width = 400
                  Height = 23
                  AutoSizeXY = asY
                end
                object Label2: TdhLabel
                  Left = 8
                  Top = 56
                  Width = 37
                  Height = 15
                  Text = 'E-Mail:'
                  Style.FontSize = '12'
                  Style.Color = 5191464
                  AutoSizeXY = asXY
                end
                object email: TdhEdit
                  Left = 8
                  Top = 70
                  Width = 400
                  Height = 23
                  AutoSizeXY = asY
                end
                object Label24: TdhLabel
                  Left = 8
                  Top = 164
                  Width = 54
                  Height = 15
                  Text = 'Message:'
                  Style.FontSize = '12'
                  Style.Color = 5191464
                  AutoSizeXY = asXY
                end
                object message: TdhMemo
                  Left = 6
                  Top = 186
                  Width = 400
                  Height = 174
                  AutoSizeXY = asNone
                end
                object Reset1: TdhLink
                  Left = 76
                  Top = 377
                  Width = 58
                  Height = 24
                  Text = 'Reset'
                  Style.Color = 5191464
                  AutoSizeXY = asXY
                  Layout = ltButton
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  FormButtonType = fbReset
                end
                object access: TdhHiddenField
                  Left = 142
                  Top = 381
                  Width = 24
                  Height = 24
                  Value = 'dfm2html'
                end
                object Label27: TdhLabel
                  Left = 8
                  Top = 107
                  Width = 39
                  Height = 15
                  Text = 'Phone:'
                  Style.FontSize = '12'
                  Style.Color = 5191464
                  AutoSizeXY = asXY
                end
                object Phone: TdhEdit
                  Left = 6
                  Top = 124
                  Width = 400
                  Height = 23
                  AutoSizeXY = asY
                end
              end
            end
            object Page7: TdhPage
              Left = 12
              Top = 12
              Width = 440
              Height = 432
              Style.PaddingTop = 30
              AutoSizeXY = asNone
              UseIFrame = False
              object Label25: TdhLabel
                Left = 0
                Top = 49
                Height = 39
                Text = 
                  'Thank you for your message, <?php echo $_POST["name"]?>!'#10'<br/><b' +
                  'r/>We will contact you as soon as possible.'
                Style.FontSize = '11'
                Style.TextAlign = ctaCenter
                Style.Color = 5191464
                Style.FontStyle = cfsItalic
                Style.FontWeight = cfwBold
                AutoSizeXY = asXY
                Align = alTop
              end
              object DirectHTML2: TdhDirectHTML
                Left = 0
                Top = 88
                Height = 19
                AutoSizeXY = asXY
                Align = alTop
                InnerHTML = '<?php'#13#10#9'} else {'#13#10'?>'
                GenerateContainer = False
              end
              object DirectHTML3: TdhDirectHTML
                Left = 0
                Top = 131
                Height = 19
                AutoSizeXY = asXY
                Align = alTop
                InnerHTML = '<?php'#13#10#9'}'#13#10'?>'
                GenerateContainer = False
              end
              object Label26: TdhLabel
                Left = 0
                Top = 107
                Height = 24
                Text = '<?php echo $err?> &nbsp;&nbsp;<Link23>Go back</Link23>'
                Style.TextAlign = ctaCenter
                Style.Color = 5191464
                AutoSizeXY = asXY
                Align = alTop
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
                InnerHTML = 
                  '<?php'#13#10#9'$recipient = "youremail@domain.com";'#13#10#9'$subject = "Conta' +
                  'ct form";'#13#10#13#10#9'if ($_POST["access"]!="dfm2html")  $err="Page inco' +
                  'rrectly accessed (e.g. by a bot)"; else'#13#10#9'if ($_POST["name"] == ' +
                  '"")  $err="You must specify a name!"; else'#13#10#9'if ($_POST["message' +
                  '"] == "")  $err="You must specify a message!"; else'#13#10#9'if ($recip' +
                  'ient == "your@email.com") $err="No recipient defined by the web ' +
                  'designer!"; else'#13#10#9'$err="";'#13#10#9'if ($err=="") {'#13#10#9#9'$msg= "";'#13#10#9#9'fo' +
                  'reach($_POST as $key=> $val) {'#13#10#9#9#9'if ($key != "access") $msg .=' +
                  ' $key." : ".$val."\n\n";'#13#10#9#9'}'#13#10#9#9'$header='#39#39';'#13#10#9#9'if (isset($_POST' +
                  '["email"])) $header .= '#39'From:'#39'.$_POST['#39'email'#39']."\n";'#13#10#13#10#9#9'if (co' +
                  'unt($_FILES)>0) {'#13#10#13#10#9#9'$boundary = strtoupper(md5(uniqid(time())' +
                  '));'#13#10#13#10#9#9'$header .= "MIME-Version: 1.0\n";'#13#10#9#9'$header .= "Conten' +
                  't-Type: multipart/mixed; boundary=$boundary\n\n";'#13#10#9#9'$header .= ' +
                  '"This is a multi-part message in MIME format.\n\n";'#13#10#9#9'$header .' +
                  '= "--$boundary\n";'#13#10#9#9'$header .= "Content-Type: text/plain\n";'#13#10 +
                  #9#9'$header .= "Content-Transfer-Encoding: 8bit\n\n";'#13#10#9#9'$header .' +
                  '= "$msg\n";'#13#10#9#9'$msg='#39#39';'#13#10#13#10#9#9#13#10#9#9'foreach ($_FILES as $filefield ' +
                  '=> $file) if (is_uploaded_file($file['#39'tmp_name'#39'])) {'#13#10#9#9#9#13#10#9#9#9'$c' +
                  'ontent=chunk_split(base64_encode(fread(fopen($file['#39'tmp_name'#39'],"' +
                  'r"),filesize($file['#39'tmp_name'#39']))));'#13#10#13#10#9#9#9'$header .= "--$boundar' +
                  'y\n";'#13#10#9#9#9'$header .= "Content-Type: ".$file['#39'type'#39']."; name=\"".' +
                  '$file['#39'name'#39']."\"\n";'#13#10#9#9#9'$header .= "Content-Transfer-Encoding:' +
                  ' base64\n";'#13#10#9#9#9'$header .= "Content-Disposition: attachment; fil' +
                  'ename=\"".$file['#39'name'#39']."\"\n\n";'#13#10#9#9#9'$header .= "$content\n";'#13#10 +
                  #13#10#9#9'}'#13#10#9#9'$header .= "--$boundary--";'#13#10#9#9'}'#13#10#9#9'mail($recipient, $s' +
                  'ubject, $msg, $header);'#13#10#13#10'?>'
                GenerateContainer = False
              end
            end
          end
        end
      end
    end
    object Panel9: TdhPanel
      Left = 140
      Top = 670
      Width = 672
      Height = 53
      Style.BorderTop.Width = 3
      Style.BorderTop.Color = 10120005
      Style.BorderTop.Style = cbsDotted
      Style.BorderLeft.Style = cbsNone
      Style.BorderRight.Style = cbsNone
      Style.BackgroundColor = White
      Use = Label2
      AutoSizeXY = asNone
      object Label14: TdhLabel
        Left = 22
        Top = 9
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
        Left = 143
        Top = 9
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
      object Label28: TdhLabel
        Left = 21
        Top = 28
        Width = 63
        Height = 15
        Text = 'Layout by'
        Style.FontSize = '12'
        Style.Color = 7631979
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Link4: TdhLink
        Left = 80
        Top = 29
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
      object Label29: TdhLabel
        Left = 209
        Top = 9
        Width = 181
        Height = 15
        Text = 'the easy to use Website Editor'
        Style.FontSize = '12'
        Style.Color = 7631979
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
      object Label31: TdhLabel
        Left = 129
        Top = 29
        Width = 329
        Height = 15
        Text = 'Solutions and Workshops for small Companies'
        Style.FontSize = '12'
        Style.Color = 7631979
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
    end
    object Panel3: TdhPanel
      Left = 10
      Top = 10
      Width = 98
      Height = 730
      Style.BackgroundImage.Path = 'images-blue-margin-decoration\Panel3_nm.jpg'
      Style.BackgroundImage.State = isAnalyzed
      Style.BackgroundImage.Width = 100
      Style.BackgroundImage.Height = 250
      AutoSizeXY = asNone
    end
  end
end
