object PageContainer7: TPageContainer7
  Left = -4
  Top = -23
  Caption = 'blue-clouds.dfm'
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
      Width = 810
      Height = 740
      Style.BackgroundColor = 12440289
      AutoSizeXY = asNone
      object Panel2: TdhPanel
        Left = 559
        Top = 200
        Width = 213
        Height = 448
        Style.BackgroundColor = White
        AutoSizeXY = asNone
        object Panel6: TdhPanel
          Left = 14
          Top = 74
          Width = 180
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
            Left = 22
            Top = 8
            Width = 75
            Height = 16
            Text = '<i>Header</i>'
            Style.FontSize = '13'
            Style.FontWeight = cfwBold
            AutoSizeXY = asY
          end
        end
        object Panel14: TdhPanel
          Left = 14
          Top = 104
          Width = 180
          Height = 120
          Style.BackgroundImage.Path = 'images-blue-clouds\Panel14_nm.png'
          Style.BackgroundImage.State = isAnalyzed
          Style.BackgroundImage.Width = 1
          Style.BackgroundImage.Height = 120
          Style.BackgroundRepeat = cbrRepeatX
          AutoSizeXY = asNone
          object Link1: TdhLink
            Left = 48
            Top = 24
            Width = 75
            Height = 16
            Text = 'Link Page 1'
            Style.FontSize = '13'
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
            Width = 75
            Height = 16
            Text = 'Link Page 2'
            Style.FontSize = '13'
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
          Left = 18
          Top = 256
          Width = 180
          Height = 32
          Style.BackgroundColor = 4684190
          Style.Color = White
          AutoSizeXY = asNone
          object Label9: TdhLabel
            Left = 21
            Top = 8
            Width = 66
            Height = 16
            Text = '<i>Header</i>'
            Style.FontSize = '13'
            Style.FontWeight = cfwBold
            AutoSizeXY = asY
          end
        end
        object Panel18: TdhPanel
          Left = 18
          Top = 288
          Width = 181
          Height = 104
          Style.BackgroundImage.Path = 'images-blue-clouds\Panel18_nm.png'
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
          object Link12: TdhLink
            Left = 47
            Top = 52
            Width = 75
            Height = 16
            Text = 'Link Page 4'
            Style.FontSize = '13'
            Style.Color = 4684190
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page4.html'
          end
          object Link5: TdhLink
            Left = 47
            Top = 27
            Width = 75
            Height = 16
            Text = 'Link Page 3'
            Style.FontSize = '13'
            Style.Color = 4684190
            Style.FontWeight = cfwBold
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = './Page3.html'
          end
        end
      end
      object Panel1: TdhPanel
        Left = 24
        Top = 26
        Width = 750
        Height = 166
        Style.BackgroundImage.Path = 'images-blue-clouds\Panel1_nm.jpg'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 750
        Style.BackgroundImage.Height = 173
        AutoSizeXY = asNone
        object Label1: TdhLabel
          Left = 496
          Top = 16
          Width = 234
          Height = 35
          Text = 'My own Website'
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
        Top = 209
        Width = 518
        Height = 450
        Style.PaddingBottom = 0
        Style.FontSize = '18'
        Style.MarginBottom = '0'
        Style.BackgroundColor = White
        Style.Color = Gray
        AutoSizeXY = asNone
        UseIFrame = False
        object Label3: TdhLabel
          Left = 24
          Top = 16
          Width = 60
          Height = 26
          Text = 'Home'
          Style.FontSize = '22'
          Style.Color = 4684190
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          SUse = 'Label10'
        end
        object Panel5: TdhPanel
          Left = 24
          Top = 54
          Width = 230
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
          object Panel8: TdhPanel
            Left = 256
            Top = 0
            Width = 232
            Height = 168
            Style.BackgroundColor = 14604465
            AutoSizeXY = asNone
            object Panel10: TdhPanel
              Left = 232
              Top = 0
              Width = 100
              Height = 96
              AutoSizeXY = asNone
            end
            object Panel11: TdhPanel
              Left = 264
              Top = 0
              Width = 232
              Height = 168
              Style.BackgroundColor = 14604465
              AutoSizeXY = asNone
              object Panel12: TdhPanel
                Left = 232
                Top = 0
                Width = 100
                Height = 96
                AutoSizeXY = asNone
              end
            end
          end
        end
        object Panel15: TdhPanel
          Left = 268
          Top = 54
          Width = 220
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
        end
        object Label4: TdhLabel
          Left = 284
          Top = 89
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label15: TdhLabel
          Left = 48
          Top = 89
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Panel16: TdhPanel
          Left = 24
          Top = 238
          Width = 230
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
        end
        object Label16: TdhLabel
          Left = 48
          Top = 273
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Panel19: TdhPanel
          Left = 268
          Top = 238
          Width = 220
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
        end
        object Label17: TdhLabel
          Left = 284
          Top = 273
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
      end
      object Page2: TdhPage
        Left = 42
        Top = 209
        Width = 518
        Height = 432
        Style.BackgroundColor = White
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
        object Panel7: TdhPanel
          Left = 24
          Top = 54
          Width = 230
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
          object Panel20: TdhPanel
            Left = 256
            Top = 0
            Width = 232
            Height = 168
            Style.BackgroundColor = 14604465
            AutoSizeXY = asNone
            object Panel21: TdhPanel
              Left = 232
              Top = 0
              Width = 100
              Height = 96
              AutoSizeXY = asNone
            end
            object Panel22: TdhPanel
              Left = 264
              Top = 0
              Width = 232
              Height = 168
              Style.BackgroundColor = 14604465
              AutoSizeXY = asNone
              object Panel23: TdhPanel
                Left = 232
                Top = 0
                Width = 100
                Height = 96
                AutoSizeXY = asNone
              end
            end
          end
        end
        object Panel24: TdhPanel
          Left = 268
          Top = 54
          Width = 220
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
        end
        object Label13: TdhLabel
          Left = 284
          Top = 89
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label18: TdhLabel
          Left = 48
          Top = 89
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Panel25: TdhPanel
          Left = 24
          Top = 238
          Width = 230
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
        end
        object Label19: TdhLabel
          Left = 48
          Top = 273
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Panel26: TdhPanel
          Left = 268
          Top = 238
          Width = 220
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
        end
        object Label20: TdhLabel
          Left = 284
          Top = 273
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
      end
      object Page3: TdhPage
        Left = 42
        Top = 209
        Width = 518
        Height = 432
        Style.BackgroundColor = White
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
        object Panel27: TdhPanel
          Left = 24
          Top = 54
          Width = 230
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
          object Panel28: TdhPanel
            Left = 256
            Top = 0
            Width = 232
            Height = 168
            Style.BackgroundColor = 14604465
            AutoSizeXY = asNone
            object Panel29: TdhPanel
              Left = 232
              Top = 0
              Width = 100
              Height = 96
              AutoSizeXY = asNone
            end
            object Panel30: TdhPanel
              Left = 264
              Top = 0
              Width = 232
              Height = 168
              Style.BackgroundColor = 14604465
              AutoSizeXY = asNone
              object Panel31: TdhPanel
                Left = 232
                Top = 0
                Width = 100
                Height = 96
                AutoSizeXY = asNone
              end
            end
          end
        end
        object Panel32: TdhPanel
          Left = 268
          Top = 54
          Width = 220
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
        end
        object Label6: TdhLabel
          Left = 284
          Top = 89
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Label21: TdhLabel
          Left = 48
          Top = 89
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Panel33: TdhPanel
          Left = 24
          Top = 238
          Width = 230
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
        end
        object Label22: TdhLabel
          Left = 48
          Top = 273
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
        object Panel34: TdhPanel
          Left = 268
          Top = 238
          Width = 220
          Height = 168
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
        end
        object Label23: TdhLabel
          Left = 284
          Top = 273
          Width = 180
          Height = 98
          Text = 
            'The navigation bar has a fixed distance to the right edge, while' +
            ' the '#10'distance to the left edge varies when resizing the browser' +
            ' window. Noch ein weiterer Satz passt hier hin'#10'The navigation ba' +
            'r has a fixed distance to the right edge, while the '
          Style.FontSize = '11'
          Style.TextAlign = ctaJustify
          Style.Color = 5191464
          AutoSizeXY = asY
        end
      end
      object Page4: TdhPage
        Left = 42
        Top = 209
        Width = 518
        Height = 432
        Style.BackgroundColor = White
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
          Left = 24
          Top = 54
          Width = 488
          Height = 355
          Style.BackgroundColor = 14403509
          AutoSizeXY = asNone
          object PageControl2: TdhPageControl
            Left = 16
            Top = 16
            Width = 24
            Height = 24
            ActivePage = Page7
            FixedHeight = True
            object Page6: TdhPage
              Left = 16
              Top = 11
              Width = 448
              Height = 335
              AutoSizeXY = asNone
              UseIFrame = False
              object ContactForm: TdhHTMLForm
                Left = 8
                Top = 3
                Width = 432
                Height = 325
                AutoSizeXY = asNone
                Method = fmtPost
                object Submit1: TdhLink
                  Left = 8
                  Top = 293
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
                  Left = 4
                  Top = 8
                  Width = 57
                  Height = 14
                  Text = 'Your Name:'
                  Style.FontSize = '11'
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
                  Top = 48
                  Width = 31
                  Height = 14
                  Text = 'E-Mail:'
                  Style.FontSize = '11'
                  Style.Color = 5191464
                  AutoSizeXY = asXY
                end
                object email: TdhEdit
                  Left = 8
                  Top = 64
                  Width = 400
                  Height = 23
                  AutoSizeXY = asY
                end
                object Label24: TdhLabel
                  Left = 8
                  Top = 148
                  Width = 47
                  Height = 14
                  Text = 'Message:'
                  Style.FontSize = '11'
                  Style.Color = 5191464
                  AutoSizeXY = asXY
                end
                object message: TdhMemo
                  Left = 8
                  Top = 164
                  Width = 400
                  Height = 115
                  AutoSizeXY = asNone
                end
                object Reset1: TdhLink
                  Left = 80
                  Top = 293
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
                  Left = 148
                  Top = 293
                  Width = 24
                  Height = 24
                  Value = 'dfm2html'
                end
                object Label27: TdhLabel
                  Left = 8
                  Top = 93
                  Width = 33
                  Height = 14
                  Text = 'Phone:'
                  Style.FontSize = '11'
                  Style.Color = 5191464
                  AutoSizeXY = asXY
                end
                object Phone: TdhEdit
                  Left = 8
                  Top = 114
                  Width = 400
                  Height = 23
                  AutoSizeXY = asY
                end
              end
            end
            object Page7: TdhPage
              Left = 16
              Top = 11
              Width = 448
              Height = 335
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
      Left = 40
      Top = 674
      Width = 752
      Height = 53
      Style.BorderLeft.Style = cbsNone
      Style.BorderRight.Style = cbsNone
      Style.BackgroundColor = 13612444
      Use = Label2
      AutoSizeXY = asNone
      object Label14: TdhLabel
        Left = 22
        Top = 9
        Width = 127
        Height = 15
        Text = 'Website powered by'
        Style.FontSize = '12'
        Style.Color = White
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
        Style.Color = 4684190
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
        Style.Color = White
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
        Style.Color = 4684190
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
        Style.Color = White
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
        Style.Color = White
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
      end
    end
  end
end
