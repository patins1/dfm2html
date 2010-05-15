object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Caption = 'kieghomepage.dfm'
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
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    FTPURL = 'ftp://p8288468:5yMTPDtZ@kiegeland.com/'
    HTTPURL = 'http://www.kiegeland.com/'
    object Label5: TdhLabel
      Left = 48
      Top = 88
      Width = 139
      Height = 190
      Text = 
        'Copyright '#169' 2010<br/>'#10'J'#246'rg Kiegeland<br/>'#10'Software Development<b' +
        'r/>'#10'<br/>'#10'Alt-Moabit 83 B<br/>'#10'10555 Berlin<br/>'#10'Germany<br/>'#10'<b' +
        'r/>'#10#10'E-mail:<br/>'#10'dev@kiegeland.com<br/>'
      Style.FontFamily = 'Times New Roman'
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
    end
    object Label1: TdhLabel
      Left = 40
      Top = 24
      Width = 584
      Height = 43
      Text = 'J'#246'rg Kiegeland, Dipl.- Informatiker'
      Style.FontSize = '36'
      Style.FontFamily = 'Arial'
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
    end
    object Label2: TdhLabel
      Left = 344
      Top = 88
      Width = 280
      Height = 249
      Text = 
        'Hi, I am a programming freelancer, and work mainly for <Link2>ik' +
        'v</Link2>, <i>the</i> company for Java based solutions (we have ' +
        'a long C++ way behind), very flexible, develops current standard' +
        's (<Link3>QVT</Link3>, <Link4>functional safety</Link4>). I can ' +
        'also work for you, my hourly rate is "only" 150'#8364'. Please contact' +
        ' me at my email adress and I will tell you if I can help you. I ' +
        'am very skilled in:'#10#10'<ul><li>QVT (model transformations)</li>'#10'<l' +
        'i>Java/Eclipse</li>'#10'<li>Databases (Postgres)</li>'#10'</ul>'
      AutoSizeXY = asY
    end
    object StyleSheet1: TdhStyleSheet
      Left = 832
      Top = 112
      Width = 312
      Height = 144
      Expanded = True
      object Link1: TdhLink
        Left = 0
        Top = 0
        Height = 18
        Text = 'Link1'
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Link2: TdhLink
        Left = 0
        Top = 18
        Height = 18
        Text = 'ikv'
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.ikv.de/index.php?lang=en'
      end
      object Link3: TdhLink
        Left = 0
        Top = 36
        Height = 18
        Text = 'QVT'
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 
          'http://www.ikv.de/index.php?option=com_content&task=view&id=75&I' +
          'temid=77'
      end
      object Link4: TdhLink
        Left = 0
        Top = 54
        Height = 18
        Text = 'safety'
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 
          'http://www.ikv.de/index.php?option=com_content&task=view&id=107&' +
          'Itemid=95'
      end
    end
  end
end
