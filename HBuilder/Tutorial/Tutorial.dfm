object PageContainer1: TPageContainer1
  Left = -4
  Top = -23
  Caption = 'Tutorial.dfm'
  ClientHeight = 726
  ClientWidth = 1600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Times New Roman'
  Font.Pitch = fpVariable
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 15
  object tutorial: TdhPage
    Left = 0
    Top = 0
    Style.Border.Width = 0
    Style.Border.Style = cbsSolid
    Style.BackgroundImage.Path = 'Images\tutorial_nm.png'
    Style.BackgroundImage.State = isAnalyzed
    Style.BackgroundImage.Width = 796
    Style.BackgroundImage.Height = 1
    Style.BackgroundRepeat = cbrRepeatY
    Style.Padding = 10
    Style.Margin = '20'
    Style.FontFamily = 'Arial'
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    Title = 'Tutorial'
    OutputDirectory = 'tutorial\'
    MetaAuthor = 'J'#246'rg Kiegeland'
    MetaDescription = 'DFM2HTML Tutorial'
    object Panel6: TdhPanel
      Left = 16
      Top = 88
      Width = 296
      Height = 416
      Style.Border.Width = 18
      Style.Border.Color = 33023
      Style.Border.Style = cbsDouble
      Style.Margin = '11'
      Style.BackgroundColor = 33023
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.InnerShadow.Alpha = 128
      Style.Effects.InnerShadow.Radius = 2
      Style.Effects.InnerShadow.Color = White
      Style.Effects.InnerShadow.Degree = 131
      Style.Effects.InnerShadow.Distance = 1
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Degree = 131
      Style.Effects.OuterShadow.Distance = 4
      Style.BorderRadius.All = '11'
      AutoSizeXY = asNone
      object TdhAnchor7: TdhLink
        Left = 48
        Top = 128
        Width = 55
        Height = 16
        Text = 'Forms'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor12
      end
      object TdhAnchor6: TdhLink
        Left = 48
        Top = 272
        Width = 145
        Height = 16
        Text = 'Miscellaneous styles'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor10
      end
      object TdhAnchor5: TdhLink
        Left = 48
        Top = 256
        Width = 57
        Height = 16
        Text = 'Effects'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor9
      end
      object TdhAnchor4: TdhLink
        Left = 48
        Top = 224
        Width = 62
        Height = 16
        Text = 'Images'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor8
      end
      object TdhAnchor3: TdhLink
        Left = 48
        Top = 192
        Width = 54
        Height = 16
        Text = 'Edges'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor7
      end
      object TdhAnchor2: TdhLink
        Left = 48
        Top = 176
        Width = 113
        Height = 16
        Text = 'Formatting text'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor4
      end
      object TdhAnchor1: TdhLink
        Left = 32
        Top = 64
        Width = 152
        Height = 16
        Text = 'Positioning of objects'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor5
      end
      object TdhAnchor9: TdhLink
        Left = 48
        Top = 144
        Width = 84
        Height = 16
        Text = 'Navigation'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = TdhAnchor8
      end
      object TdhLink1: TdhLink
        Left = 48
        Top = 304
        Width = 203
        Height = 16
        Text = 'Dealing with styles and states'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Anchor11
      end
      object TdhLink2: TdhLink
        Left = 32
        Top = 48
        Width = 63
        Height = 16
        Text = 'Objects'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = TdhLabel5
      end
      object Link1: TdhLink
        Left = 32
        Top = 80
        Width = 94
        Height = 16
        Text = 'Object types'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label13
      end
      object Link4: TdhLink
        Left = 32
        Top = 32
        Width = 128
        Height = 16
        Text = 'About this tutorial'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label15
      end
      object Link5: TdhLink
        Left = 48
        Top = 288
        Width = 106
        Height = 16
        Text = 'Reusing styles'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label18
      end
      object Link6: TdhLink
        Left = 32
        Top = 160
        Width = 96
        Height = 16
        Text = 'Object styles'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label20
      end
      object Link9: TdhLink
        Left = 48
        Top = 112
        Width = 49
        Height = 16
        Text = 'Links'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label23
      end
      object Link14: TdhLink
        Left = 48
        Top = 240
        Width = 56
        Height = 16
        Text = 'Colors'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label26
      end
      object Link16: TdhLink
        Left = 48
        Top = 96
        Width = 58
        Height = 16
        Text = 'Labels'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label32
      end
      object Link17: TdhLink
        Left = 32
        Top = 336
        Width = 143
        Height = 16
        Text = 'Publish your project'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label43
      end
      object Link18: TdhLink
        Left = 48
        Top = 208
        Width = 126
        Height = 16
        Text = 'Rounded Corners'
        Use = Link7
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label37
      end
      object Link19: TdhLink
        Left = 32
        Top = 352
        Width = 212
        Height = 16
        Text = 'Sharing DFM2HTML  ressources'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label35
      end
      object Link20: TdhLink
        Left = 32
        Top = 320
        Width = 43
        Height = 16
        Text = 'PHP'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = Label45
      end
    end
    object StyleSheet2: TdhStyleSheet
      Left = 439
      Top = 56
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 224
      ExpandedHeight = 232
      Expanded = False
      object tab: TdhLabel
        Left = 0
        Top = 0
        Height = 22
        Text = 'tab'
        Style.BackgroundImage.Path = 'Images\tab_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 47
        Style.BackgroundImage.Height = 18
        Style.BackgroundRepeat = cbrNoRepeat
        Style.Padding = 3
        Style.FontSize = '11'
        Style.FontFamily = 'Microsoft Sans Serif'
        Style.LineHeight = '150%'
        Style.Effects.Rotation = 120
        AutoSizeXY = asY
        Align = alTop
        Right = 20
      end
      object chapter: TdhLink
        Left = 0
        Top = 22
        Height = 16
        Text = 'chapter'
        Style.Color = Black
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object pad: TdhLabel
        Left = 0
        Top = 38
        Height = 26
        Text = 'pad'
        Style.Padding = 5
        AutoSizeXY = asY
        Align = alTop
        Right = 16
      end
      object Label3: TdhLabel
        Left = 0
        Top = 64
        Height = 16
        Text = 'Label3'
        Style.Color = Red
        AutoSizeXY = asY
        Align = alTop
      end
      object Link2: TdhLink
        Left = 0
        Top = 80
        Height = 16
        Text = 'Link2'
        Style.BackgroundImage.Path = 'Images\Link2_nm.png'
        Style.BackgroundImage.State = isSemiTransparent
        Style.BackgroundImage.Width = 50
        Style.BackgroundImage.Height = 50
        Style.BackgroundRepeat = cbrNoRepeat
        Style.Padding = 0
        Style.PaddingLeft = 16
        Style.Color = Black
        Style.FontWeight = cfwBold
        Style.TextDecoration = [ctdNone]
        AutoSizeXY = asXY
        Align = alTop
        Right = 10
        StyleOver.BackgroundImage.Path = 'Images\Link2_ov.png'
        StyleOver.BackgroundPosition = '0% 0%'
        StyleOver.TextDecoration = [ctdUnderline]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Link7: TdhLink
        Left = 0
        Top = 96
        Height = 16
        Text = 'Link7'
        Style.BackgroundImage.Path = 'Images\Link7_nm.png'
        Style.BackgroundImage.State = isSemiTransparent
        Style.BackgroundImage.Width = 50
        Style.BackgroundImage.Height = 50
        Use = Link2
        AutoSizeXY = asXY
        Align = alTop
        Right = 10
        StyleOver.BackgroundImage.Path = 'Images\Link7_ov.png'
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object Text5: TdhLabel
      Left = 24
      Top = 760
      Width = 624
      Height = 363
      Text = 
        'To position an object, select it with the mouse and drag it arou' +
        'nd to the desired position. The object is aligned to a grid by d' +
        'efault. This can be prevented by holding down the ALT key. <br/>' +
        '<br/>'#10'In the <tab>&nbsp;&nbsp;&nbsp;&nbsp;Pos.&nbsp;&nbsp;&nbsp;' +
        '</tab> tab, you can set sophisticated position parameters.'#10'In th' +
        'e <b>Bounds</b> section, you can set the X/Y coordinates of the ' +
        'object (<b>left</b> and <b>top</b> values).'#10'<br/><br/>'#10'By defaul' +
        't, the distance of an object to the top and left edge of the par' +
        'ent object is fixed.'#10'So e.g. if the width of the parent object i' +
        's increased, the distance of the child object to the left parent' +
        ' edge is not changing, while the distance to the right parent ed' +
        'ge is increasing accordingly.'#10'In the <nobr><b>Keep distance cons' +
        'tant to</b></nobr> section, you can set to which parent edges th' +
        'e distance is hold constant.'#10'A special case is when you define t' +
        'hat neither to the right nor to the left parent edge the distanc' +
        'e is fixed. In this case, the object is horizontally centered.'#10'<' +
        'br>'#10'<br>'#10'You can align an object to a parent edge or to the full' +
        ' parent area in the <b>Alignment</b> section.'#10'The default is val' +
        'ue <b>None</b>, which means that the object is absolute position' +
        'ed (positioned by coordinates).'#10'In contrast, all child objects w' +
        'ith a value of <b>Top</b> are stacked up, starting from the top ' +
        'parent edge downwards. In HTML, this corresponds to the normal f' +
        'low of block elements. However in DFM2HTML, you can also stack u' +
        'p child objects starting from the left, right or bottom parent e' +
        'dge.'#10'<br/><br/>'#10'In the <b>Bounds</b> section, you can set the wi' +
        'dth and the height of an object.'#10'Some objects can adjust their s' +
        'ize to the content, so you do not have to set suitable values fo' +
        'r the width and height of the object. Control automatic sizing w' +
        'ith the options <b>auto width</b></nobr> and <nobr><b>auto heigh' +
        't</b></nobr>.'
      Use = pad
      AutoSizeXY = asY
    end
    object TdhLabel2: TdhLabel
      Left = 24
      Top = 3800
      Width = 662
      Height = 59
      Text = 
        'In the <tab>&nbsp;&nbsp;&nbsp;Font&nbsp;&nbsp;&nbsp;&nbsp;</tab>' +
        ' tab you can format text with a font and you can choose a backgr' +
        'ound color.<br/>'#10'If you edit the font of an object, '#10'the childre' +
        'n of the object inherit the font settings (if they not define th' +
        'eir own font).<br/>'#10'Examples for different fonts:'
      Use = pad
      AutoSizeXY = asXY
    end
    object Text6: TdhLabel
      Left = 24
      Top = 3872
      Width = 154
      Height = 27
      Text = 'Courier New'
      Style.FontSize = '24'
      Style.FontFamily = 'Courier New'
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
    end
    object TdhLabel3: TdhLabel
      Left = 24
      Top = 3896
      Width = 179
      Height = 35
      Text = 'Comic Sans MS'
      Style.FontSize = '24'
      Style.FontFamily = 'Comic Sans MS'
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
    end
    object TdhLabel4: TdhLabel
      Left = 24
      Top = 3936
      Width = 193
      Height = 28
      Text = 'Times New Roman'
      Style.FontSize = '24'
      Style.Margin = '1'
      Style.FontFamily = 'Times New Roman'
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
    end
    object Panel1: TdhPanel
      Left = 304
      Top = 3864
      Width = 240
      Height = 108
      Style.Border.Width = 2
      Style.Border.Color = White
      Style.Border.Style = cbsOutset
      Style.FontSize = '16'
      Style.BackgroundColor = Silver
      Style.FontFamily = 'Comic Sans MS'
      Style.FontStyle = cfsItalic
      Style.FontWeight = cfwBold
      AutoSizeXY = asNone
      object Text7: TdhLabel
        Left = 8
        Top = 8
        Width = 80
        Height = 23
        Text = 'This font'
        Style.BackgroundColor = 65408
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        AutoSizeXY = asY
      end
      object Text8: TdhLabel
        Left = 24
        Top = 32
        Width = 120
        Height = 23
        Text = '.. is defined'
        Style.BackgroundColor = Yellow
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        AutoSizeXY = asY
      end
      object Text9: TdhLabel
        Left = 40
        Top = 56
        Width = 144
        Height = 23
        Text = '.. by the parent '
        Style.BackgroundColor = Red
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        AutoSizeXY = asY
      end
      object Text10: TdhLabel
        Left = 56
        Top = 80
        Width = 168
        Height = 23
        Text = '.. container object.'
        Style.BackgroundColor = Aqua
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.Text = etInclude
        AutoSizeXY = asY
      end
    end
    object TdhLabel6: TdhLabel
      Left = 24
      Top = 3990
      Width = 688
      Height = 27
      Text = 
        'Note that these examples are anti-aliased. This feature can be e' +
        'nabled in the <tab>&nbsp;&nbsp;Effect&nbsp;&nbsp;&nbsp;</tab> ta' +
        'b.'
      Use = pad
      AutoSizeXY = asY
    end
    object TdhLabel8: TdhLabel
      Left = 24
      Top = 4109
      Width = 552
      Height = 75
      Text = 
        'In the <tab>&nbsp;&nbsp;&nbsp;Edge&nbsp;&nbsp;&nbsp;</tab> tab y' +
        'ou can set  margin, border and padding values for <b>all</b> edg' +
        'es and for the <b>left</b>/<b>top</b>/<b>bottom</b>/<b>right</b>' +
        ' edge individually. The following graphic displays where the mar' +
        'gin, border and padding area of an object is located (the margin' +
        ' box includes the border box, the border box includes the paddin' +
        'g box and the padding box includes the content box):'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet3: TdhStyleSheet
      Left = 608
      Top = 4264
      Width = 28
      Height = 28
      Expanded = False
      VertPosition = 18
      ExpandedWidth = 144
      ExpandedHeight = 160
      Expanded = False
      object Label4: TdhLabel
        Left = 0
        Top = -18
        Height = 18
        Text = 'Label4'
        Style.Border.Width = 1
        Style.Border.Style = cbsNone
        Style.BorderLeft.Style = cbsNone
        Style.BorderRight.Style = cbsNone
        Style.Padding = 1
        Style.Margin = '0'
        Style.TextAlign = ctaLeft
        Style.FontWeight = cfwBold
        Style.Effects.Alpha = 194
        AutoSizeXY = asY
        Align = alTop
        Right = 24
      end
    end
    object Panel4: TdhPanel
      Left = 48
      Top = 4224
      Width = 504
      Height = 216
      Style.Border.Width = 1
      Style.Border.Style = cbsDotted
      AutoSizeXY = asNone
      object Panel2: TdhPanel
        Left = 1
        Top = 1
        Style.Border.Width = 20
        Style.Border.Color = Red
        Style.Border.Style = cbsDashed
        Style.Padding = 20
        Style.Margin = '20'
        Style.BackgroundColor = Aqua
        AutoSizeXY = asNone
        Align = alClient
        Right = 1
        Bottom = 1
        object Panel3: TdhPanel
          Left = 60
          Top = 60
          Style.BackgroundColor = White
          AutoSizeXY = asNone
          Align = alClient
          Right = 60
          Bottom = 60
        end
      end
      object TdhLabel11: TdhLabel
        Left = 67
        Top = 62
        Width = 335
        Height = 18
        Text = 'content area: text or child objects are rendered here'
        Style.BackgroundColor = Transparent
        Style.Effects.Rotation = 120
        Use = Label4
        AutoSizeXY = asXY
      end
      object TdhLabel10: TdhLabel
        Left = 67
        Top = 42
        Width = 377
        Height = 18
        Text = 'padding: background-color/image are displayed in this box'
        Style.BackgroundColor = Transparent
        Use = Label4
        AutoSizeXY = asXY
      end
      object Text11: TdhLabel
        Left = 67
        Top = 22
        Width = 329
        Height = 18
        Text = 'border: each edge can have a different border style'
        Style.BackgroundColor = Transparent
        Use = Label4
        AutoSizeXY = asXY
      end
      object TdhLabel9: TdhLabel
        Left = 67
        Top = 2
        Width = 212
        Height = 18
        Text = 'margin: is transparent to the user'
        Style.BackgroundColor = Transparent
        Style.Effects.Rotation = 120
        Use = Label4
        AutoSizeXY = asXY
      end
    end
    object Text12: TdhLabel
      Left = 558
      Top = 4219
      Width = 27
      Height = 216
      Text = 
        '&lt;-------height, see <tab>&nbsp;&nbsp;Pos.&nbsp;&nbsp;&nbsp;</' +
        'tab> page-----&gt;'
      Style.Effects.Rotation = 90
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      Use = pad
      AutoSizeXY = asXY
    end
    object TdhLabel12: TdhLabel
      Left = 38
      Top = 4442
      Width = 513
      Height = 27
      Text = 
        '&lt;-------------------------------------------width, see <tab>&' +
        'nbsp;&nbsp;&nbsp;Pos.&nbsp;&nbsp;&nbsp;&nbsp;</tab> page--------' +
        '-----------------------------------&gt;'
      Use = pad
      AutoSizeXY = asXY
    end
    object TdhLabel14: TdhLabel
      Left = 24
      Top = 4730
      Width = 680
      Height = 75
      Text = 
        'You can define an image to any visual object in the <tab>&nbsp;&' +
        'nbsp;Image&nbsp;&nbsp;</tab> tab. The image appears behind any t' +
        'ext content or child objects. '#10'You can tile the image (<b>type=t' +
        'ile</b>), stretch the image (<b>type=stretch</b>), split the ima' +
        'ge (<b>type=split</b>) or the image determines the object'#39's size' +
        ' (<b>type=image</b>). '#10'If you set the type to <b>tile</b>, you c' +
        'an define from where to start tiling and in what directions to t' +
        'ile. Examples:'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet4: TdhStyleSheet
      Left = 592
      Top = 4656
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 144
      ExpandedHeight = 100
      Expanded = False
      object Label8: TdhLabel
        Left = 0
        Top = 0
        Height = 36
        Text = 'Label8'
        Style.Border.Width = 1
        Style.Border.Style = cbsSolid
        Style.BackgroundImage.Path = 'Images\Label8_nm.gif'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 110
        Style.BackgroundImage.Height = 40
        Style.BackgroundPosition = '0% 0%'
        Style.Padding = 8
        Style.FontSize = '16'
        Style.TextAlign = ctaCenter
        Style.Color = White
        Style.FontStyle = cfsItalic
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
        Align = alTop
        Right = 8
      end
      object Link13: TdhLink
        Left = 0
        Top = 36
        Height = 24
        Text = 'Link13'
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        Right = 4
        Layout = ltButton
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object Text13: TdhLabel
      Left = 32
      Top = 4824
      Width = 144
      Height = 128
      Text = 'tiled in <nobr>x/y direction</nobr>'
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object TdhLabel15: TdhLabel
      Left = 184
      Top = 4824
      Width = 144
      Height = 128
      Text = 'tiled in <nobr>y direction</nobr>, centered'
      Style.BackgroundPosition = '50% 0%'
      Style.BackgroundRepeat = cbrRepeatY
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object TdhLabel16: TdhLabel
      Left = 456
      Top = 4824
      Width = 144
      Height = 128
      Text = 'stretch'
      ImageType = bitStretch
      Style.BackgroundPosition = '52% 52%'
      Style.BackgroundRepeat = cbrRepeatY
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object TdhLabel17: TdhLabel
      Left = 24
      Top = 5392
      Width = 568
      Height = 59
      Text = 
        'If you enabled effects in the <tab>&nbsp;&nbsp;Effect&nbsp;&nbsp' +
        ';&nbsp;</tab> tab, the object is rasterized and saved as one ima' +
        'ge in the HTML file. Now you can apply various effects like rota' +
        'te/scale/opacity/blur, just try them out. Some effects:'
      Use = pad
      AutoSizeXY = asY
    end
    object Button1: TdhLink
      Left = 40
      Top = 5496
      Width = 64
      Height = 64
      Text = 'Button1'
      Style.Cursor = ccuDefault
      Style.Effects.Rotation = 315
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
      Layout = ltButton
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'javascript:alert(this.id+'#39' is pressed'#39')'
    end
    object Text14: TdhLabel
      Left = 40
      Top = 5456
      Width = 96
      Height = 32
      Text = 'A button, rotated by 45'#176
      AutoSizeXY = asY
    end
    object Text16: TdhLabel
      Left = 312
      Top = 5456
      Width = 120
      Height = 32
      Text = 'A link, saying "hello" when clicked:'
      AutoSizeXY = asY
    end
    object Link3: TdhLink
      Left = 312
      Top = 5496
      Width = 83
      Height = 53
      Text = 'Hello'
      Style.FontSize = '24'
      Style.Margin = '12'
      Style.Color = White
      Style.FontWeight = cfwBold
      Style.TextDecoration = [ctdNone]
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 196
      Style.Effects.OuterShadow.Radius = 7
      Style.Effects.OuterShadow.Distance = 9
      Style.Effects.OuterGlow.Enabled = True
      Style.Effects.OuterGlow.Alpha = 186
      Style.Effects.OuterGlow.Radius = 2
      Style.Effects.OuterGlow.Color = Black
      Style.Effects.OuterGlow.Flood = 54
      AutoSizeXY = asXY
      StyleDown.Padding = 2
      StyleDown.Effects.Enabled = True
      StyleDown.Effects.AntiAliasing = True
      StyleDown.Effects.Text = etInclude
      StyleDown.Effects.OuterShadow.Enabled = True
      StyleDown.Effects.OuterShadow.Alpha = 196
      StyleDown.Effects.OuterShadow.Radius = 7
      StyleDown.Effects.OuterShadow.Distance = 7
      StyleDown.Effects.OuterGlow.Enabled = True
      StyleDown.Effects.OuterGlow.Alpha = 186
      StyleDown.Effects.OuterGlow.Radius = 2
      StyleDown.Effects.OuterGlow.Color = Black
      StyleDown.Effects.OuterGlow.Flood = 54
      StyleOver.TextDecoration = [ctdUnderline]
      StyleOver.Effects.OuterShadow.Enabled = True
      StyleOver.Effects.OuterShadow.Alpha = 255
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'javascript:alert('#39'hello'#39')'
    end
    object Panel5: TdhPanel
      Left = 136
      Top = 5488
      Width = 104
      Height = 88
      Style.Border.Width = 2
      Style.Border.Color = White
      Style.Border.Style = cbsOutset
      Style.Margin = '12'
      Style.BackgroundColor = Silver
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 212
      Style.Effects.OuterShadow.Radius = 7
      AutoSizeXY = asNone
    end
    object TdhLabel19: TdhLabel
      Left = 144
      Top = 5456
      Width = 152
      Height = 32
      Text = 'A container with a border, dropping a shadow:'
      AutoSizeXY = asY
    end
    object TdhLabel21: TdhLabel
      Left = 24
      Top = 5634
      Width = 480
      Height = 43
      Text = 
        'There are many different styles available in the <tab>&nbsp;&nbs' +
        'p;&nbsp;Misc&nbsp;&nbsp;&nbsp;&nbsp;</tab> tab, most related to ' +
        'text formatting. For each one is given a little  example:'
      Use = pad
      AutoSizeXY = asY
    end
    object Text15: TdhLabel
      Left = 32
      Top = 5688
      Width = 80
      Height = 16
      Text = 'font-variant:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object Text17: TdhLabel
      Left = 120
      Top = 5688
      Width = 320
      Height = 16
      Text = 'Some text formatted with font-variant=small-caps'
      Style.FontVariant = cfvSmallCaps
      AutoSizeXY = asXY
    end
    object TdhLabel22: TdhLabel
      Left = 16
      Top = 5720
      Width = 96
      Height = 16
      Text = 'text-transform:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel23: TdhLabel
      Left = 120
      Top = 5720
      Width = 312
      Height = 16
      Text = 'Some text formatted with text-transform=capitalize'
      Style.TextTransform = cttCapitalize
      AutoSizeXY = asXY
    end
    object TdhLabel24: TdhLabel
      Left = 32
      Top = 5752
      Width = 80
      Height = 16
      Text = 'white-space:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel25: TdhLabel
      Left = 120
      Top = 5752
      Width = 508
      Height = 16
      Text = 
        'In text formatted with white-space=pre        whitespaces      d' +
        'o        not           collapse.'
      Style.WhiteSpace = cwsPre
      AutoSizeXY = asXY
    end
    object TdhLabel26: TdhLabel
      Left = 32
      Top = 5784
      Width = 80
      Height = 16
      Text = 'direction:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object Edit1: TdhEdit
      Left = 120
      Top = 5784
      Width = 208
      Height = 23
      Style.Direction = cdiRtl
      AutoSizeXY = asY
      Text = 'from right to left'
    end
    object TdhLabel27: TdhLabel
      Left = 32
      Top = 5824
      Width = 80
      Height = 16
      Text = 'text-align:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel28: TdhLabel
      Left = 120
      Top = 5824
      Width = 144
      Height = 50
      Text = 
        'Some text formatted with the text-align property set to "justify' +
        '".'
      Style.Border.Width = 1
      Style.Border.Style = cbsSolid
      Style.TextAlign = ctaJustify
      AutoSizeXY = asY
    end
    object TdhLabel29: TdhLabel
      Left = 32
      Top = 5888
      Width = 80
      Height = 16
      Text = 'cursor:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel30: TdhLabel
      Left = 120
      Top = 5888
      Width = 361
      Height = 16
      Text = 'A question mark appears if you move the mouse over this text.'
      Style.Cursor = ccuHelp
      AutoSizeXY = asXY
    end
    object TdhLabel31: TdhLabel
      Left = 32
      Top = 5920
      Width = 80
      Height = 16
      Text = 'z-index:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object dhAnchor112: TdhLink
      Left = 288
      Top = 5976
      Width = 116
      Height = 56
      Text = 'dhAnchor112'
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor113: TdhLink
      Left = 160
      Top = 6008
      Width = 116
      Height = 56
      Text = 'dhAnchor113'
      Style.BackgroundColor = Blue
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor114: TdhLink
      Left = 264
      Top = 6016
      Width = 116
      Height = 56
      Text = 'dhAnchor114'
      Style.BackgroundColor = Lime
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor115: TdhLink
      Left = 336
      Top = 6008
      Width = 116
      Height = 56
      Text = 'dhAnchor115'
      Style.BackgroundColor = Fuchsia
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor116: TdhLink
      Left = 208
      Top = 6000
      Width = 116
      Height = 56
      Text = 'dhAnchor116'
      Style.BackgroundColor = Green
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhAnchor117: TdhLink
      Left = 192
      Top = 5968
      Width = 116
      Height = 56
      Text = 'dhAnchor117'
      Style.BackgroundColor = Aqua
      Use = dhRule27
      AutoSizeXY = asNone
      PreferDownStyles = True
      Options = [loDownIfMenu]
    end
    object dhStyleSheet6: TdhStyleSheet
      Left = 488
      Top = 5960
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 169
      ExpandedHeight = 105
      Expanded = False
      object dhRule27: TdhLink
        Left = 0
        Top = 0
        Height = 56
        Text = 'dhRule27'
        ImageFormat = ifSimple
        Style.Padding = 20
        Style.BackgroundColor = Red
        Style.Cursor = ccuDefault
        Style.ZIndex = 0
        Style.BorderRadius.All = '11'
        AutoSizeXY = asY
        Align = alTop
        Right = -14
        StyleOver.ZIndex = 4
        Layout = ltText
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object TdhLabel32: TdhLabel
      Left = 120
      Top = 5920
      Width = 504
      Height = 32
      Text = 
        'If the mouse is over one of these objects, it is displayed in fr' +
        'ont of all other objects, since then z-index is set to 1 while a' +
        'll other panels have the default value of 0:'
      AutoSizeXY = asY
    end
    object TdhLabel33: TdhLabel
      Left = 32
      Top = 6120
      Width = 80
      Height = 16
      Text = 'text-indent:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel34: TdhLabel
      Left = 120
      Top = 6120
      Width = 136
      Height = 66
      Text = 
        'In this example, the first line is indented by 15px. All followi' +
        'ng lines are not affected.'
      Style.Border.Width = 1
      Style.Border.Style = cbsSolid
      Style.TextIndent = '15'
      AutoSizeXY = asY
    end
    object TdhLabel35: TdhLabel
      Left = 280
      Top = 6120
      Width = 160
      Height = 82
      Text = 
        'This example uses a negative indentation of -15px. To be not out' +
        ' of bounds, a left padding of 15px was defined, too.'
      Style.Border.Width = 1
      Style.Border.Style = cbsSolid
      Style.PaddingLeft = 15
      Style.TextIndent = '-15'
      AutoSizeXY = asY
    end
    object TdhLabel36: TdhLabel
      Left = 32
      Top = 6232
      Width = 80
      Height = 16
      Text = 'vertical-align:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel37: TdhLabel
      Left = 120
      Top = 6232
      Width = 344
      Height = 77
      Text = 
        'This property is very useful for images which are included in te' +
        'xt. Some example values:<br/>baseline (the default):<Label9></La' +
        'bel9> ,  middle:<TdhLabel39></TdhLabel39> , 5px:<TdhLabel40></Td' +
        'hLabel40>'
      AutoSizeXY = asY
    end
    object TdhStyleSheet1: TdhStyleSheet
      Left = 552
      Top = 6094
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 152
      ExpandedHeight = 256
      Expanded = False
      object Label9: TdhLabel
        Left = 0
        Top = 0
        Width = 30
        Height = 30
        Style.VerticalAlign = 'baseline'
        Use = Label42
        AutoSizeXY = asY
        Align = alTop
      end
      object TdhLabel39: TdhLabel
        Left = 0
        Top = 30
        Width = 30
        Height = 30
        Style.VerticalAlign = 'middle'
        Use = Label42
        AutoSizeXY = asY
        Align = alTop
      end
      object TdhLabel40: TdhLabel
        Left = 0
        Top = 60
        Width = 30
        Height = 30
        Style.VerticalAlign = '5'
        Use = Label42
        AutoSizeXY = asY
        Align = alTop
      end
      object Label42: TdhLabel
        Left = 0
        Top = 90
        Width = 30
        Height = 30
        Text = 'Label42'
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label42_nm.gif'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 30
        Style.BackgroundImage.Height = 30
        AutoSizeXY = asY
        Align = alTop
      end
    end
    object TdhLabel42: TdhLabel
      Left = 24
      Top = 6674
      Width = 736
      Height = 453
      Text = 
        #10'A link can be exactly in one of four different object states, f' +
        'or which you can define styles separately: '#10'<ul>'#10'<li>the "normal' +
        '" state (the normal state of an object)</li>'#10'<li>the "over" stat' +
        'e (when the mouse is over the object)</li>'#10'<li>the "down" state ' +
        '(when the mouse is pressed, or at other conditions configurable ' +
        'in the <tab>&nbsp;&nbsp;&nbsp;Link&nbsp;&nbsp;&nbsp;&nbsp;</tab>' +
        ' tab) </li>'#10'<li>the "over/down" state (when the mouse is over th' +
        'e object <b>and</b> the mouse is pressed)</li>'#10'</ul>'#10'The state f' +
        'or which you want to modify the styles can be set in the tool ba' +
        'r.<br><br>'#10'The styles which are active for a given state are lis' +
        'ted next (the given order shows the precedence if the same style' +
        ' is defined for more than one state of the same object):<br>'#10'<La' +
        'bel11>"normal" styles</Label11> in the "normal" state<br>'#10'<Label' +
        '11>"down" styles &rarr; "normal" styles</Label11> in the "down" ' +
        'state<br>'#10'<Label11>"over" styles &rarr; "normal" styles</Label11' +
        '> in the "over" state<br>'#10'<Label11>"over/down" styles &rarr; "do' +
        'wn" styles &rarr; "over" styles &rarr; "normal" styles</Label11>' +
        ' in the "over/down" state'#10'<br/><br/>'#10'If you have checked <b>Pref' +
        'er Over styles to Down styles</b> in the <tab>&nbsp;&nbsp;Object' +
        '&nbsp;&nbsp;</tab> tab, the last line changes to:<br/>'#10'<Label11>' +
        '"over/down" styles &rarr; "over" styles &rarr; "down" styles &ra' +
        'rr; "normal" styles</Label11> in the "over/down" state<br>'#10'This ' +
        'option can only be set if no <b>Use</b> object is defined for th' +
        'e current object.<br/>'#10'<br/>'#10'There are some styles which are spe' +
        'cific to object classes:'#10'<ul>'#10'<li>For links, you can set if they' +
        ' shall have a text, button or link layout.</li>'#10'<li>For links, y' +
        'ou can define in more detail, when the "down" state shall be act' +
        'ive (as mentioned above)</li>'#10'<li>For any visual object, you can' +
        ' define the image format when the objects needs to be rastered i' +
        'n the <tab>&nbsp;&nbsp;Object&nbsp;&nbsp;</tab> tab</li>'#10'</ul>'#10'I' +
        'f one such style is set to &lt;Automatic&gt;, '#10'the style from th' +
        'e <b>Use</b> object (if defined) is taken instead.'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet6: TdhStyleSheet
      Left = 680
      Top = 6608
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Label10: TdhLabel
        Left = 0
        Top = 0
        Width = 24
        Height = 24
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label10_nm.gif'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 24
        Style.BackgroundImage.Height = 24
        Style.BackgroundRepeat = cbrRepeat
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label11: TdhLabel
        Left = 0
        Top = 24
        Height = 22
        Text = 'Label11'
        Style.Border.Width = 1
        Style.Border.Style = cbsDotted
        Style.Margin = '0'
        Style.WhiteSpace = cwsNowrap
        Style.LineHeight = '150%'
        AutoSizeXY = asY
        Align = alTop
        Right = 24
      end
    end
    object Text2: TdhLabel
      Left = 456
      Top = 8160
      Width = 256
      Height = 32
      Text = 
        '(The page is as high as needed to show all components, this is t' +
        'he deepest one)'
      Style.Color = 55769
      AutoSizeXY = asY
    end
    object StyleSheet5: TdhStyleSheet
      Left = 680
      Top = 6880
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 104
      Expanded = False
      object Image1: TdhLink
        Left = 0
        Top = 0
        Width = 24
        Height = 24
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Image1_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 24
        Style.BackgroundImage.Height = 24
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Image2: TdhLink
        Left = 0
        Top = 24
        Width = 24
        Height = 24
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Image2_nm.bmp'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 24
        Style.BackgroundImage.Height = 24
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object TdhLabel52: TdhLabel
      Left = 32
      Top = 6440
      Width = 80
      Height = 32
      Text = 'additional CSS:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object TdhLabel53: TdhLabel
      Left = 120
      Top = 6432
      Width = 512
      Height = 58
      Text = 
        'If you are familiar with CSS styles, you can define own styles, ' +
        'which are inserted unparsed into the HTML file. The following ex' +
        'ample uses an IE filter which applies only to the Internet Explo' +
        'rer:'
      Use = pad
      AutoSizeXY = asY
    end
    object Anchor18: TdhLink
      Left = 128
      Top = 6488
      Width = 248
      Height = 22
      Text = 'Move the mouse over this link'
      Style.FontSize = '19'
      Style.Other = 'filter:blendTrans(Duration=0.2)'
      Style.Color = Red
      AutoSizeXY = asXY
      StyleOver.BackgroundColor = Red
      StyleOver.Color = Aqua
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'javascript:alert('#39'hello'#39')'
    end
    object TdhLabel55: TdhLabel
      Left = 464
      Top = 5456
      Width = 224
      Height = 32
      Text = 'Applying inner shadow, inner glow and outer shadow:'
      AutoSizeXY = asY
    end
    object TdhLabel57: TdhLabel
      Left = 487
      Top = 5473
      Width = 160
      Height = 88
      Text = 'Open'
      Style.BackgroundRepeat = cbrNoRepeat
      Style.FontSize = '48'
      Style.Margin = '10'
      Style.FontFamily = 'Arial Black'
      Style.Color = Olive
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.InnerShadow.Enabled = True
      Style.Effects.InnerShadow.Alpha = 255
      Style.Effects.InnerShadow.Radius = 2
      Style.Effects.InnerShadow.Degree = 285
      Style.Effects.InnerShadow.Distance = 2
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 255
      Style.Effects.InnerGlow.Enabled = True
      Style.Effects.InnerGlow.Alpha = 255
      Style.Effects.InnerGlow.Radius = 2
      Style.Effects.InnerGlow.Flood = 83
      Style.Effects.OuterGlow.Alpha = 255
      Style.Effects.OuterGlow.Radius = 3
      Style.Effects.OuterGlow.Color = Red
      Style.Effects.OuterGlow.Flood = 63
      Style.Effects.Blur.Radius = 1
      AutoSizeXY = asXY
    end
    object Anchor5: TdhLabel
      Left = 24
      Top = 736
      Width = 136
      Height = 16
      Text = 'Positioning of objects'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor4: TdhLabel
      Left = 24
      Top = 3752
      Width = 97
      Height = 16
      Text = 'Formatting text'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor7: TdhLabel
      Left = 24
      Top = 4056
      Width = 38
      Height = 16
      Text = 'Edges'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor8: TdhLabel
      Left = 24
      Top = 4696
      Width = 46
      Height = 16
      Text = 'Images'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor9: TdhLabel
      Left = 24
      Top = 5360
      Width = 41
      Height = 16
      Text = 'Effects'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor10: TdhLabel
      Left = 24
      Top = 5600
      Width = 129
      Height = 16
      Text = 'Miscellaneous styles'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Anchor11: TdhLabel
      Left = 24
      Top = 6648
      Width = 187
      Height = 16
      Text = 'Dealing with styles and states'
      Use = chapter
      AutoSizeXY = asXY
    end
    object TdhLabel5: TdhLabel
      Left = 24
      Top = 584
      Width = 47
      Height = 16
      Text = 'Objects'
      Use = chapter
      AutoSizeXY = asXY
    end
    object TdhLabel7: TdhLabel
      Left = 24
      Top = 616
      Width = 648
      Height = 75
      Text = 
        'Click and drop objects from the tool bar onto the document. '#10'Edi' +
        't properties of objects in the property tabs you see below. '#10'For' +
        ' example, change an object'#39's name in the <tab>&nbsp;&nbsp;Object' +
        '&nbsp;&nbsp;</tab> tab. '#10'Objects must have a unique name. Every ' +
        'object except the outer most object has'#10'a parent object. If you ' +
        'select the object and press the ESCAPE key once, the object'#39's pa' +
        'rent is selected.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label13: TdhLabel
      Left = 24
      Top = 1176
      Width = 78
      Height = 16
      Text = 'Object types'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label14: TdhLabel
      Left = 24
      Top = 1208
      Width = 640
      Height = 309
      Text = 
        'Object types are:'#10'<ul>'#10'<li><b>Labels</b>: they display static te' +
        'xt</li>'#10'<li><b>Links</b>: they are like labels, but can be linke' +
        'd to some destination; they can be in four different states</li>' +
        #10'<li><b>Panels</b>: They can be used as parent for other objects' +
        '</li>'#10'<li><b>Page</b>: Like a panel. If it not belongs to a page' +
        ' control object, it can show scrollbars.</li>'#10'<li><b>Form object' +
        's</b>: you need form objects to build HTML forms, which can be e' +
        'valuated by a web server</li>'#10'<li><b>Page control</b>: a page co' +
        'ntrol is an object with which you can manage several page object' +
        's. Only one of those pages is displayed at the same time. They c' +
        'an be linked by link objects.</li>'#10'<li><b>Stylesheet</b>: a styl' +
        'esheet object is just a container for objects which define visua' +
        'l styles for being used by other objects.</li>'#10'<li><b>Direct HTM' +
        'L</b>: to insert HTML/Javascript code directly into the generate' +
        'd HTML document</li>'#10'<li><b>File objects</b>: Link or embed exte' +
        'rnal files. When publishing, they get uploaded, too. The generat' +
        'ed file name consists of the <nobr><i>object id + . + file exten' +
        'sion of the chosen file</i></nobr>.</li>'#10'<li><b>Menu objects</b>' +
        ': You can build DHTML popup menus with menu objects. They are ex' +
        'plained in a separate tutorial (<b>Tools | Menu Tutorial</b>).</' +
        'li>'#10'</ul>'#10'Note that an image can be assigned to any visual objec' +
        't type in the <tab>&nbsp;&nbsp;Image&nbsp;&nbsp;</tab> tab, so t' +
        'here is no image object for its own.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label17: TdhLabel
      Left = 6
      Top = 19
      Width = 347
      Height = 68
      Text = 'Tutorial to DFM2HTML'
      Style.Padding = 17
      Style.FontSize = '29'
      Style.Color = White
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      Style.Effects.InnerShadow.Degree = 119
      Style.Effects.OuterShadow.Enabled = True
      Style.Effects.OuterShadow.Alpha = 255
      Style.Effects.OuterShadow.Radius = 3
      Style.Effects.OuterShadow.Flood = 100
      Style.Effects.OuterShadow.Distance = 0
      AutoSizeXY = asXY
    end
    object Label15: TdhLabel
      Left = 24
      Top = 504
      Width = 112
      Height = 16
      Text = 'About this tutorial'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label16: TdhLabel
      Left = 24
      Top = 528
      Width = 544
      Height = 42
      Text = 
        'This tutorial will show you how to create'#10'a web page with DFM2HT' +
        'ML. <br/>To start a new document,'#10'click <b>File | New</b>.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label18: TdhLabel
      Left = 24
      Top = 6536
      Width = 90
      Height = 16
      Text = 'Reusing styles'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label19: TdhLabel
      Left = 24
      Top = 6554
      Width = 736
      Height = 67
      Text = 
        'In previous sections you have seen that many visual styles can b' +
        'e applied to an object.<br/>'#10'To share styles between objects, yo' +
        'u can put a stylesheet object <Label10></Label10> onto the docum' +
        'ent and add objects to it. <br/>'#10'Now other objects can use style' +
        's defined by these objects by the <b>Use</b> property in the <ta' +
        'b>&nbsp;&nbsp;Object&nbsp;&nbsp;</tab> tab.'
      Use = pad
      AutoSizeXY = asY
    end
    object Anchor12: TdhLabel
      Left = 24
      Top = 1962
      Width = 39
      Height = 16
      Text = 'Forms'
      Use = chapter
      AutoSizeXY = asXY
    end
    object TdhLabel47: TdhLabel
      Left = 32
      Top = 1980
      Width = 416
      Height = 50
      Text = 
        'When you build HTML forms, you must place all input objects, lik' +
        'e a radio button <Image1></Image1>, within a <b>Form</b> object ' +
        '<Image2></Image2> :'
      Use = pad
      AutoSizeXY = asY
    end
    object Form1: TdhHTMLForm
      Left = 32
      Top = 2050
      Height = 512
      Style.Border.Width = 6
      Style.Border.Color = 14540253
      Style.Border.Style = cbsSolid
      Style.BackgroundImage.Path = 'Images\Form1_nm.gif'
      Style.FontFamily = 'Verdana'
      Style.FontWeight = cfwBold
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight]
      Right = 44
      Action = 'javascript:alert('#39'The form was submitted!'#39')'
      Target = '_self'
      object Text18: TdhLabel
        Left = 72
        Top = 32
        Width = 100
        Height = 16
        Text = 'First name:'
        Use = Label1
        AutoSizeXY = asY
      end
      object Text19: TdhLabel
        Left = 72
        Top = 68
        Width = 100
        Height = 16
        Text = 'Sure name:'
        Use = Label1
        AutoSizeXY = asY
      end
      object Text20: TdhLabel
        Left = 72
        Top = 104
        Width = 100
        Height = 16
        Text = 'Gender:'
        Use = Label1
        AutoSizeXY = asY
      end
      object TdhLabel43: TdhLabel
        Left = 40
        Top = 152
        Width = 132
        Height = 16
        Text = 'Characteristics:'
        Use = Label1
        AutoSizeXY = asY
      end
      object Smoker: TdhCheckBox
        Left = 176
        Top = 152
        Width = 103
        Height = 22
        Text = 'smoker'
        Use = Label2
        AutoSizeXY = asNone
      end
      object Driver: TdhCheckBox
        Left = 176
        Top = 174
        Width = 103
        Height = 22
        Text = 'driver'
        Use = Label2
        AutoSizeXY = asNone
      end
      object HTMLFreak: TdhCheckBox
        Left = 176
        Top = 196
        Width = 103
        Height = 22
        Text = 'HTML freak'
        Use = Label2
        AutoSizeXY = asNone
      end
      object TdhLabel44: TdhLabel
        Left = 40
        Top = 224
        Width = 132
        Height = 16
        Text = 'Next large city:'
        Use = Label1
        AutoSizeXY = asY
      end
      object FirstName: TdhEdit
        Left = 176
        Top = 24
        Width = 312
        Height = 32
        Use = Edit3
        AutoSizeXY = asY
      end
      object SureName: TdhEdit
        Left = 176
        Top = 60
        Width = 312
        Height = 32
        Use = Edit3
        AutoSizeXY = asY
      end
      object Comment: TdhMemo
        Left = 176
        Top = 256
        Width = 309
        Height = 176
        Use = Edit3
        AutoSizeXY = asNone
      end
      object TdhLabel45: TdhLabel
        Left = 40
        Top = 256
        Width = 132
        Height = 16
        Text = 'Comment:'
        Use = Label1
        AutoSizeXY = asY
      end
      object TdhLabel46: TdhLabel
        Left = 40
        Top = 448
        Width = 132
        Height = 16
        Text = 'Form:'
        Use = Label1
        AutoSizeXY = asY
      end
      object Submit: TdhLink
        Left = 176
        Top = 440
        Width = 176
        Height = 32
        Text = 'Submit'
        Style.Cursor = ccuDefault
        Style.Effects.InnerShadow.Enabled = True
        Use = Submit3
        AutoSizeXY = asY
        Layout = ltButton
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        FormButtonType = fbSubmit
      end
      object Reset: TdhLink
        Left = 360
        Top = 440
        Width = 176
        Height = 32
        Text = 'Reset'
        Style.Cursor = ccuDefault
        Use = Submit3
        AutoSizeXY = asY
        Layout = ltButton
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        FormButtonType = fbReset
      end
      object StyleSheet1: TdhStyleSheet
        Left = 520
        Top = 28
        Width = 28
        Height = 28
        Expanded = False
        ExpandedWidth = 200
        ExpandedHeight = 168
        Expanded = False
        object Label1: TdhLabel
          Left = 0
          Top = 0
          Height = 16
          Text = 'Label1'
          Style.TextAlign = ctaRight
          AutoSizeXY = asY
          Align = alTop
        end
        object Label2: TdhLabel
          Left = 0
          Top = 16
          Height = 18
          Text = 'Label2'
          Style.Border.Width = 1
          Style.Border.Color = 14540253
          Style.Border.Style = cbsSolid
          Style.BackgroundColor = 16777181
          AutoSizeXY = asY
          Align = alTop
          Right = 24
        end
        object Edit3: TdhEdit
          Left = 0
          Top = 34
          Height = 32
          HTMLAttributes = 'wrap="off"'
          Style.Border.Width = 6
          Style.Border.Color = 14540253
          Style.Border.Style = cbsSolid
          Style.FontSize = '15'
          Style.BackgroundColor = 11206655
          Style.Color = 13369344
          Style.FontWeight = cfwBold
          AutoSizeXY = asY
          Align = alTop
          Right = 12
          Text = 'Next large city:'
        end
        object Submit3: TdhLink
          Left = 0
          Top = 88
          Height = 32
          Text = 'Submit3'
          Style.Border.Width = 6
          Style.Border.Color = 14540253
          Style.Border.Style = cbsSolid
          Style.BackgroundColor = 11184810
          Style.Cursor = ccuDefault
          Style.Color = White
          Style.FontWeight = cfwBold
          AutoSizeXY = asXY
          Align = alTop
          Right = -4
          Layout = ltButton
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          FormButtonType = fbSubmit
        end
        object TdhComboBox1: TdhSelect
          Left = 0
          Top = 66
          Height = 22
          Style.BackgroundColor = 16777181
          Style.Color = 13369344
          Style.FontWeight = cfwBold
          AutoSizeXY = asY
          Align = alTop
          Right = 6
          Items = <>
          SelectType = stDropDown
        end
      end
      object BigCity: TdhSelect
        Left = 176
        Top = 224
        Width = 312
        Height = 22
        Use = TdhComboBox1
        AutoSizeXY = asY
        Items = <
          item
            Text = 'Berlin'
          end
          item
            Text = 'New York'
            Selected = True
          end>
        SelectType = stDropDown
      end
      object Gender: TdhPanel
        Left = 176
        Top = 96
        Width = 200
        Height = 49
        AutoSizeXY = asNone
        object Male: TdhRadioButton
          Left = 0
          Top = 0
          Width = 104
          Height = 22
          Text = 'male'
          Use = Label2
          AutoSizeXY = asNone
        end
        object Female: TdhRadioButton
          Left = 0
          Top = 22
          Width = 104
          Height = 22
          Text = 'female'
          Use = Label2
          AutoSizeXY = asNone
        end
      end
    end
    object Label12: TdhLabel
      Left = 32
      Top = 2570
      Width = 640
      Height = 92
      Text = 
        'Note that the input objects'#39' names (definable in the <tab>&nbsp;' +
        '&nbsp;Object&nbsp;&nbsp;</tab> tab) are used when the form data ' +
        'is transmitted.'#10'When a form is submitted by the user, the form d' +
        'ata is send to the URL specified in the <b>URL</b> field in the ' +
        '<tab>&nbsp;&nbsp;&nbsp;Form&nbsp;&nbsp;&nbsp;</tab> tab of the <' +
        'b>Form</b> object.'#10'Alternatively, the URL can be specified direc' +
        'tly by the <b>Submit</b> button, using its <b>URL</b> field or t' +
        'he <b>Link to page</b> field. The form data is appended to the d' +
        'estination URL if the <b>Get</b> method is chosen, otherwise it ' +
        'is transmitted in the background (method <b>Post</b>).'
      Use = pad
      AutoSizeXY = asY
    end
    object TdhAnchor8: TdhLabel
      Left = 24
      Top = 2695
      Width = 68
      Height = 16
      Text = 'Navigation'
      Use = chapter
      AutoSizeXY = asXY
    end
    object TdhLabel1: TdhLabel
      Left = 24
      Top = 2718
      Width = 616
      Height = 31
      Text = 
        'A page control object <Image3></Image3> can manage several pages' +
        ', which can be referenced by link objects:'
      Use = pad
      AutoSizeXY = asY
    end
    object PageControl1: TdhPageControl
      Left = 32
      Top = 2800
      Width = 24
      Height = 24
      ActivePage = Page1
      FixedHeight = True
      DynamicNavigation = True
      object Page1: TdhPage
        Left = 32
        Top = 2792
        Width = 696
        Height = 264
        Style.BackgroundImage.Path = 'Images\Page1_nm.png'
        Style.BackgroundRepeat = cbrRepeat
        Style.BackgroundColor = Transparent
        Use = Panel7
        AutoSizeXY = asNone
        UseIFrame = False
        object Label5: TdhLabel
          Left = 32
          Top = 40
          Width = 144
          Height = 80
          Text = 
            'Every page can have different content. The pages can have differ' +
            'ent heights but width and position are the same.'
          Style.Color = Red
          AutoSizeXY = asY
        end
      end
      object Page2: TdhPage
        Left = 32
        Top = 2792
        Width = 696
        Height = 264
        Style.Border.Color = Lime
        Style.Border.Style = cbsSolid
        Style.BackgroundColor = Transparent
        Use = Panel7
        AutoSizeXY = asNone
        UseIFrame = False
        object Label6: TdhLabel
          Left = 32
          Top = 48
          Width = 112
          Height = 87
          Text = 
            'This is the second page. All three pages are'#10'managed by the Page' +
            ' Control <Image3></Image3>'
          Style.Padding = 1
          AutoSizeXY = asY
        end
      end
      object Page3: TdhPage
        Left = 32
        Top = 2792
        Width = 696
        Height = 264
        Style.BackgroundImage.Path = 'Images\Page3_nm.png'
        Style.BackgroundRepeat = cbrRepeat
        Style.BackgroundColor = Transparent
        Use = Panel7
        AutoSizeXY = asNone
        UseIFrame = False
        object Label7: TdhLabel
          Left = 48
          Top = 40
          Width = 176
          Height = 80
          Text = 
            'This is the last page. Pages can be embedded in web pages static' +
            'ally or can be switched between each other dynamically via JavaS' +
            'cript.'
          AutoSizeXY = asY
        end
      end
    end
    object StyleSheet7: TdhStyleSheet
      Left = 496
      Top = 2672
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 88
      Expanded = False
      object Image3: TdhLink
        Left = 0
        Top = 0
        Width = 21
        Height = 21
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Image3_nm.gif'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 21
        Style.BackgroundImage.Height = 21
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Panel7: TdhPanel
        Left = 0
        Top = 21
        Height = 32
        Style.BackgroundColor = 65408
        Style.BorderRadius.All = '14'
        AutoSizeXY = asNone
        Align = alTop
      end
    end
    object Anchor2: TdhLink
      Left = 32
      Top = 2776
      Width = 84
      Height = 16
      Text = 'Link to Page 1'
      Style.Color = Red
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page1
      LinkAnchor = TdhAnchor8
    end
    object Anchor6: TdhLink
      Left = 144
      Top = 2776
      Width = 84
      Height = 16
      Text = 'Link to Page 2'
      Style.Color = Lime
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page2
      LinkAnchor = TdhAnchor8
    end
    object Anchor13: TdhLink
      Left = 264
      Top = 2776
      Width = 84
      Height = 16
      Text = 'Link to Page 3'
      Style.Color = 16744448
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page3
      LinkAnchor = TdhAnchor8
    end
    object Label20: TdhLabel
      Left = 24
      Top = 3651
      Width = 80
      Height = 16
      Text = 'Object styles'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label21: TdhLabel
      Left = 24
      Top = 3675
      Width = 528
      Height = 59
      Text = 
        'Visual objects can be assigned various styles demonstrated in th' +
        'e following sections. '#10'An object can re-use the styles of anothe' +
        'r object'#10'by choosing that object'#10'into the <b>Use</b> field in th' +
        'e <tab>&nbsp;&nbsp;Object&nbsp;&nbsp;</tab> tab.'
      Use = pad
      AutoSizeXY = asY
    end
    object Link8: TdhLink
      Left = 32
      Top = 4584
      Width = 200
      Height = 88
      Text = '<br/><br/><br/>This is a button <br/>with <b>round corners</b>'
      Style.BorderRadius.All = '20'
      AutoSizeXY = asNone
      Layout = ltButton
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object Label23: TdhLabel
      Left = 24
      Top = 1792
      Width = 33
      Height = 16
      Text = 'Links'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label24: TdhLabel
      Left = 22
      Top = 1824
      Width = 528
      Height = 74
      Text = 
        'Links are the objects which determine the navigation structure o' +
        'f your page.'#10'A link can link to an external location, like '#10'<goo' +
        'glelink>http://www.google.com</googlelink>, or'#10'to a <b>Page</b> ' +
        'object (<nav_example>see here</nav_example>).<br/>'#10'By double cli' +
        'cking the link in design mode, you can navigate to the destinati' +
        'on.<br/>'#10'A link can have three different layouts:'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet8: TdhStyleSheet
      Left = 476
      Top = 1887
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 168
      ExpandedHeight = 100
      Expanded = False
      object googlelink: TdhLink
        Left = 0
        Top = 0
        Height = 16
        Text = 'googlelink'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        Link = 'http://www.google.de'
      end
      object nav_example: TdhLink
        Left = 0
        Top = 16
        Height = 16
        Text = 'nav_example'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkAnchor = TdhAnchor8
      end
    end
    object Link10: TdhLink
      Left = 26
      Top = 1904
      Width = 38
      Height = 16
      Text = 'google'
      AutoSizeXY = asXY
      Layout = ltLink
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'http://www.google.com'
    end
    object Link11: TdhLink
      Left = 74
      Top = 1904
      Width = 38
      Height = 16
      Text = 'google'
      AutoSizeXY = asXY
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'http://www.google.com'
    end
    object Link12: TdhLink
      Left = 122
      Top = 1904
      Width = 65
      Height = 24
      Text = 'google'
      AutoSizeXY = asXY
      Layout = ltButton
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'http://www.google.com'
    end
    object Label25: TdhLabel
      Left = 24
      Top = 4970
      Width = 600
      Height = 195
      Text = 
        'With the&nbsp;<Link13>File..</Link13> button, you can load an im' +
        'age from your local file system.<br/> '#10'You can even drag&drop an' +
        ' image file from the file system or a web browser window onto th' +
        'e image box in the <tab>&nbsp;&nbsp;Image&nbsp;&nbsp;</tab> tab ' +
        'or onto some object directly. '#10'It is possible to create an image' +
        ' from a semi-transparent color or a gradient.'#10'Right-clicking on ' +
        'the image box, a context menu appears which allows you to change' +
        ' some color parameters, save the image to disk or make the color' +
        ' of the bottom-leftmost pixel (which hopely hits the background ' +
        'color of the image) transparent.'#10'<br/><br/>'#10'The DFM2HTML documen' +
        't only stores links to images.  '#10'Since former versions of DFM2HT' +
        'ML stored images directly in the document, you can use the <b>To' +
        'ols | Externalize Images</b> command to swap out images from you' +
        'r document to a folder.'#10'You can use the same command to move alr' +
        'eady linked images to another folder. You can view the location ' +
        'of an image via <nobr><b>Styles | Show style information</b></no' +
        'br>.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label26: TdhLabel
      Left = 24
      Top = 5208
      Width = 40
      Height = 16
      Text = 'Colors'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label27: TdhLabel
      Left = 24
      Top = 5224
      Width = 568
      Height = 79
      Text = 
        'A color, like the font-color, background-color or border-color,'#10 +
        'can be edited with a color button (e.g. <Link15>&nbsp;Color &nbs' +
        'p;&nbsp;&nbsp;<Label28>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp' +
        ';&nbsp;</Label28></Link15>).'#10'Each color button has a context men' +
        'u, with which the color value can be copied to/extracted from th' +
        'e clipboard in the'#10'common HTML color format #RRGGBB. '#10'With the C' +
        'olor Picker dialog, you can pick up the color of a pixel from an' +
        'ywhere on the screen.'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet9: TdhStyleSheet
      Left = 632
      Top = 5208
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Link15: TdhLink
        Left = 0
        Top = 0
        Height = 21
        Text = 'Link15'
        Style.Padding = 2
        Style.FontSize = '11'
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        Right = 18
        Layout = ltButton
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Label28: TdhLabel
        Left = 0
        Top = 21
        Height = 16
        Text = 'Label28'
        Style.BackgroundColor = Red
        AutoSizeXY = asY
        Align = alTop
      end
    end
    object Label29: TdhLabel
      Left = 32
      Top = 6328
      Width = 80
      Height = 16
      Text = 'line-height:'
      Style.TextAlign = ctaRight
      AutoSizeXY = asY
    end
    object Label30: TdhLabel
      Left = 120
      Top = 6328
      Width = 222
      Height = 16
      Text = 'You can define the height of text lines:'
      AutoSizeXY = asXY
    end
    object Label31: TdhLabel
      Left = 360
      Top = 6329
      Width = 152
      Height = 80
      Text = 
        'In this example, the line-height is set to 200% of the current f' +
        'ont size.'
      Style.Border.Width = 1
      Style.Border.Style = cbsSolid
      Style.LineHeight = '200%'
      AutoSizeXY = asY
    end
    object Label32: TdhLabel
      Left = 24
      Top = 1536
      Width = 42
      Height = 16
      Text = 'Labels'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label33: TdhLabel
      Left = 22
      Top = 1568
      Width = 600
      Height = 196
      Text = 
        'A label is a simple object with text content.'#10'Text can be edited' +
        ' in the <tab>&nbsp;&nbsp;&nbsp;Text&nbsp;&nbsp;&nbsp;&nbsp;</tab' +
        '> tab or'#10'with the text editor dialog which allows you to'#10'format ' +
        'selected text with standard HTML tags or'#10'with styles you defined' +
        ' on your own in stylesheet objects.'#10'You can open this dialog wit' +
        'h the context menu or by clicking the object while holding down ' +
        'the ALT key, which opens the editor and goes to that text positi' +
        'on which you clicked with the mouse.'#10#10'A formatted text section b' +
        'egins with a start tag of the form <b><code>&lt;X&gt;</code></b>' +
        #10'and ends with a end tag for the form <b><code>&lt;/X&gt;</code>' +
        '</b>.'#10'In contrast to real HTML tags, no attributes are allowed.'#10 +
        'You can remove a pair of tags with the <Label34>UNTAG</Label34> ' +
        'button.'#10'<br/><br/>'#10'You can insert any Unicode character supporte' +
        'd by the current font with the <Label34>UNICODE</Label34> button' +
        '.'#10'Since e.g. the <b>&lt;</b> and <b>&gt;</b> characters are used' +
        ' to mark tags,'#10'press the <Label34>MASK</Label34> button'#10'to escap' +
        'e the special characters <b>&lt;</b>, <b>&gt;</b>, <b>&quot;</b>' +
        ' and <b>&amp;</b> within selected text.'#10#10'A line break can be ins' +
        'erted with the <Label34>BR</Label34> button.'
      Use = pad
      AutoSizeXY = asY
    end
    object StyleSheet10: TdhStyleSheet
      Left = 656
      Top = 1440
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Label34: TdhLabel
        Left = 0
        Top = 0
        Height = 27
        Text = 'Label34'
        Style.Border.Width = 2
        Style.Border.Color = White
        Style.Border.Style = cbsOutset
        Style.Padding = 4
        Style.PaddingLeft = 8
        Style.PaddingRight = 8
        Style.FontSize = '9'
        Style.BackgroundColor = 13160660
        Style.FontFamily = 'Lucida Console'
        Style.FontWeight = cfwBold
        Style.LineHeight = '15'
        AutoSizeXY = asY
        Align = alTop
        Right = 6
      end
    end
    object Label35: TdhLabel
      Left = 24
      Top = 7829
      Width = 196
      Height = 16
      Text = 'Sharing DFM2HTML ressources'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label36: TdhLabel
      Left = 24
      Top = 7498
      Width = 672
      Height = 282
      Text = 
        'For a DFM2HTML project, a set of HTML pages and image files, whi' +
        'ch can be viewed in a browser, can be generated. Before you publ' +
        'ish your project to the internet, '#10'you should preview the result' +
        ' on your local computer via <b>Publish</b> | <b>Preview</b>. A s' +
        'et of HTML pages are generated and stored in a directory of your' +
        ' local disk. '#10'The local directory can be changed at <b>Publish <' +
        '/b>| <b>Page Properties</b> &rarr; <b>Local Directory</b>. A rel' +
        'ative path is interpreted relative to the directory where your D' +
        'FM2HTML project file is stored.'#10'<br/><br/>'#10'HTML pages, which are' +
        ' accessed online using a HTTP address, are usually stored on a F' +
        'TP server.'#10'DFM2HTML can automatically upload generated files to ' +
        'a FTP directory, which you can define at <b>Publish </b>| <b>Pag' +
        'e Properties</b> &rarr; <b>FTP Directory</b> (you have to find o' +
        'ut about the FTP connection parameters at your hosting service).' +
        ' '#10'After filling out the FTP connection parameters, you can publi' +
        'sh the project by <b>Publish </b>| <b>Publish</b>. '#10'To open the ' +
        'web browser from within DFM2HTML and browse the web site online,' +
        ' you can define the HTTP address at <b>Publish </b>| <b>Page Pro' +
        'perties</b> &rarr; <b>HTTP URL</b> and then choose <b>Publish </' +
        'b>| <b>Browse Remote</b>.'#10'<br/><br/>'#10'The same HTML files are gen' +
        'erated for both a preview and FTP publishing.'#10'Only files which h' +
        'ave changed since the last upload are uploaded to the FTP server' +
        ' (this behavior can be deactivated in <b>Tools</b> | <b>Options<' +
        '/b> &rarr; <b>Publish</b> &rarr; <b>Use Smart Publishing</b>).'#10'F' +
        'iles which are generated for a preview can also be uploaded to a' +
        ' FTP server with external FTP programs or can in general be stor' +
        'ed on any medium with a directory structure (like a CD-ROM).'
      Use = pad
      AutoSizeXY = asY
    end
    object Label38: TdhLabel
      Left = 32
      Top = 3086
      Width = 688
      Height = 503
      Text = 
        'Only one page from a page control object can show up at the same' +
        ' time. They are called <u>alternative pages</u>.'#10'<br/>'#10'You can a' +
        'dd a page to a page control object '#10'<ul>'#10'<li>by the context menu' +
        '</li>'#10'<li>by <b>Create new page</b> in the <tab>&nbsp;&nbsp;Page' +
        's&nbsp;&nbsp;</tab> tab</li>'#10'<li>by dropping a page object from ' +
        'the tool bar onto the page control object</li>'#10'<li>by pasting a ' +
        'page object from the clipboard into the page control object (<b>' +
        'Edit | Paste</b>).</li>'#10'</ul>'#10'Alternative pages are by default p' +
        'ut into different HTML pages.'#10'By unchecking <nobr><b>One HTML pa' +
        'ge per Page object</b></nobr> in the <tab>&nbsp;&nbsp;Pages&nbsp' +
        ';&nbsp;</tab> tab, the pages are contained within one HTML page.' +
        ' This has the advantage'#10'that no new HTML page has to be loaded i' +
        'nto the browser when the user activates another alternative page' +
        ' by  a link, so'#10'the new page is immediately shown. The disadvant' +
        'age is that all pages are contained in one HTML file.'#10'For many p' +
        'ages with many pictures this can increase the loading time from ' +
        'the server.'#10'<br/><br/>'#10'You can define various parameters for a p' +
        'age object, which is implemented in a separate HTML page,'#10'in the' +
        ' <nobr><b>Page Properties</b></nobr> dialog (reachable from the ' +
        'context menu).'#10'There you can define e.g. a title or keywords for' +
        ' the HTML page. '#10'The name of the final HTML file consists of the' +
        ' name of the page object and the extension &quot;.html&quot;.'#10'<b' +
        'r/><br/>'#10#10'<u>Independent pages</u><br/><br/>'#10'A page object does ' +
        'not need to be controlled by a page control object. '#10'Independent' +
        ' page objects can be created by dropping a page object from the ' +
        'tool bar onto an object not being a page control object.'#10'Indepen' +
        'dent pages can have scrollbars.'#10'Every DFM2HTML document has at l' +
        'east one independent page object, namely the outermost parent ob' +
        'ject (named "index" by default).'#10'<br/>'#10'<br/>'#10'By default an indep' +
        'endent page does not produce a separate HTML file (except the ou' +
        'termost page).'#10'If you check <b>&lt;IFRAME&gt;</b> in the <tab>&n' +
        'bsp;&nbsp;&nbsp;Page&nbsp;&nbsp;&nbsp;</tab> tab,'#10'the content of' +
        ' the page object is put into a separate HTML page, which is embe' +
        'dded by an IFRAME element in the outer HTML page. '#10'The advantage' +
        ' is that only this inner HTML page is reloaded when a contained ' +
        'alternative page is activated. '#10'On the other hand this means tha' +
        't the URL (the internet address) of these alternative pages are ' +
        'not displayed in the browser address bar and the pages'#10'cannot be' +
        ' referenced by external web pages.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label37: TdhLabel
      Left = 24
      Top = 4480
      Width = 94
      Height = 16
      Text = 'Round Corners'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label39: TdhLabel
      Left = 24
      Top = 4509
      Width = 608
      Height = 59
      Text = 
        'By pressing the Edit Border Radius button in the'#10'<tab>&nbsp;&nbs' +
        'p;&nbsp;Edge&nbsp;&nbsp;&nbsp;</tab> tab '#10'you can round each cor' +
        'ner individually or all four corners together '#10'by defining a rou' +
        'nding radius. The vertical and the horizontal radius can separat' +
        'ely be adjusted. The following example has a rounding radius of ' +
        '20 pixels for both:'
      Use = pad
      AutoSizeXY = asY
    end
    object Panel8: TdhPanel
      Left = 33
      Top = 4585
      Width = 40
      Height = 40
      Style.Border.Style = cbsDashed
      Style.BorderRadius.All = '20'
      AutoSizeXY = asNone
    end
    object Panel9: TdhPanel
      Left = 34
      Top = 4586
      Width = 20
      Height = 20
      Style.Border.Color = Red
      Style.Border.Style = cbsSolid
      Style.BorderTop.Style = cbsNone
      Style.BorderLeft.Style = cbsNone
      AutoSizeXY = asNone
    end
    object Label22: TdhLabel
      Left = 58
      Top = 4590
      Width = 41
      Height = 14
      Text = '20 pixel'
      Style.FontSize = '11'
      Style.Color = Red
      Style.FontWeight = cfwBold
      AutoSizeXY = asXY
    end
    object Label40: TdhLabel
      Left = 608
      Top = 4824
      Width = 144
      Height = 128
      Text = 'split'
      ImageType = bitSplit
      Style.BackgroundPosition = '52% 52%'
      Style.BackgroundRepeat = cbrRepeatY
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object Label41: TdhLabel
      Left = 336
      Top = 4824
      Width = 112
      Height = 42
      Text = 'image'
      ImageType = bitImage
      Style.BackgroundPosition = '50% 0%'
      Style.BackgroundRepeat = cbrRepeatY
      Style.Effects.Rotation = 120
      Use = Label8
      AutoSizeXY = asNone
    end
    object Label43: TdhLabel
      Left = 24
      Top = 7477
      Width = 127
      Height = 16
      Text = 'Publish your project'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label44: TdhLabel
      Left = 24
      Top = 7858
      Width = 672
      Height = 123
      Text = 
        'You can drag and drop DFM2HTML files (<code>*.dfm</code>) linked' +
        ' within a browser window into DFM2HTML.'#10'That way DFM2HTML users ' +
        'can'#10'interchange DFM2HTML resources by linking them on their web ' +
        'pages.<br/>'#10'<br/>'#10'The DFM2HTML format is based on simple ASCII t' +
        'ext, so that'#10'objects can be copied to clipboard, stored into any' +
        ' text file (like'#10'a web page or email),'#10'and later pasted back int' +
        'o some other DFM2HTML document. '#10'Use <nobr><b>Edit | Full Copy</' +
        'b></nobr> instead of <nobr><b>Edit | Copy</b></nobr> to copy not' +
        ' only the selected objects into the clipboard but also any used ' +
        'stylesheet objects.'
      Use = pad
      AutoSizeXY = asY
    end
    object Label45: TdhLabel
      Left = 24
      Top = 7141
      Width = 27
      Height = 16
      Text = 'PHP'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label46: TdhLabel
      Left = 24
      Top = 7162
      Width = 672
      Height = 286
      Text = 
        'You can use PHP tags in textual content or e.g. in a <b>DirectHT' +
        'ML</b> object.'#10'<br/><br/>A sample PHP tag printing out <code>hel' +
        'lo</code> is<br/>'#10#10'<code>&lt;?php echo "hello"; ?&gt;</code>'#10'<br' +
        '/><br/>'#10#10'PHP tags are processed by the server and '#10'are invisible' +
        ' to the clients. With PHP you can'#10'e.g. create a visitor counter ' +
        'or a contact form.'#10'These two examples are included in the PHP se' +
        'ction'#10'of the <b>Tools | Presets</b> window. To see if your serve' +
        'r supports PHP, you can'#10'add e.g. the visitor counter to your web' +
        ' page, publish it to your'#10'server and browse it. If the visitor c' +
        'ounter shows a number,'#10'PHP is supported by your server. Note tha' +
        't'#10'PHP normally not works when you locally preview your web page.' +
        #10'<br/><br/>'#10'DFM2HTML itself displays a question mark when encoun' +
        'tering PHP tags.'#10'They are not evaluated by DFM2HTML any further,' +
        ' however, generated HTML files are'#10'given the extension <code>.ph' +
        'p</code> if PHP tags are found.'#10'Note that this can change your s' +
        'tart page from <code>index.html</code> to <code>index.php</code>' +
        '.'#10'<br/><br/>'#10'Note that PHP tags are executed on the server in th' +
        'e order they appear in the HTML file. This implies that the PHP ' +
        'tags of a group of top-aligned objects are executed in the visua' +
        'l order from top to down. '
      Use = pad
      AutoSizeXY = asY
    end
  end
end
