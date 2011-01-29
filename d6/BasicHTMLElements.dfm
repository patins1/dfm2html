object BasicHTMLElements: TBasicHTMLElements
  Left = 0
  Top = 0
  Width = 200
  Height = 374
  VertScrollBar.Tracking = True
  AutoScroll = True
  TabOrder = 0
  object dhStyleSheet1: TdhPage
    Left = 0
    Top = 0
    Height = 1522
    Style.FontSize = '16'
    Style.BackgroundColor = White
    Style.FontFamily = 'Times New Roman'
    AutoSizeXY = asY
    Align = alTop
    Right = 0
    UseIFrame = False
    OutputDirectory = 'DFM2HTML_\'
    object dhLabel1: TdhLabel
      Left = 0
      Top = 46
      Height = 23
      Text = 'HTML'
      Style.Padding = 2
      Style.MarginBottom = '1'
      Style.BackgroundColor = Lime
      Style.TextAlign = ctaCenter
      Style.FontFamily = 'Verdana'
      Style.FontWeight = cfwBold
      AutoSizeXY = asY
      Align = alTop
      Right = 0
    end
    object dhLabel2: TdhLabel
      Left = 0
      Top = 23
      Height = 23
      Text = 'Links'
      Use = dhLabel1
      AutoSizeXY = asY
      Align = alTop
      Right = 0
    end
    object dhLabel3: TdhLabel
      Left = 0
      Top = 0
      Height = 23
      Text = 'Custom'
      Use = dhLabel1
      AutoSizeXY = asY
      Align = alTop
      Right = 0
    end
    object p: TdhLink
      Left = 0
      Top = 68
      Height = 51
      Text = 'p (paragraph)'
      Style.MarginLeft = '0'
      Style.MarginTop = '1em'
      Style.MarginRight = '0'
      Style.MarginBottom = '1em'
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object li: TdhLink
      Left = 0
      Top = 348
      Height = 19
      Text = 'li (list item)'
      Style.Display = cdsListItem
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object ul: TdhLink
      Left = 0
      Top = 192
      Height = 51
      Text = 'ul (unordered list)'
      Style.PaddingLeft = 40
      Style.MarginTop = '1em'
      Style.MarginBottom = '1em'
      Style.Display = cdsBlock
      Style.ListStyleType = clsDisk
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object blockquote: TdhLink
      Left = 0
      Top = 367
      Height = 51
      Text = 'blockquote'
      Style.MarginLeft = '40'
      Style.MarginTop = '1em'
      Style.MarginRight = '40'
      Style.MarginBottom = '1em'
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object address: TdhLink
      Left = 0
      Top = 418
      Height = 19
      Text = 'address'
      Style.FontStyle = cfsItalic
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object center: TdhLink
      Left = 0
      Top = 437
      Height = 19
      Text = 'center'
      Style.TextAlign = ctaCenter
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object h1: TdhLink
      Left = 0
      Top = 456
      Height = 78
      Text = 'h1'
      Style.FontSize = '2em'
      Style.MarginLeft = '0'
      Style.MarginTop = '0.67em'
      Style.MarginRight = '0'
      Style.MarginBottom = '0.67em'
      Style.FontWeight = cfwBold
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object h2: TdhLink
      Left = 0
      Top = 514
      Height = 66
      Text = 'h2'
      Style.FontSize = '1.5em'
      Style.MarginLeft = '0'
      Style.MarginTop = '0.83em'
      Style.MarginRight = '0'
      Style.MarginBottom = '0.83em'
      Style.FontWeight = cfwBold
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object h3: TdhLink
      Left = 0
      Top = 561
      Height = 60
      Text = 'h3'
      Style.FontSize = '1.17em'
      Style.MarginLeft = '0'
      Style.MarginTop = '1em'
      Style.MarginRight = '0'
      Style.MarginBottom = '1em'
      Style.FontWeight = cfwBold
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object h4: TdhLink
      Left = 0
      Top = 602
      Height = 61
      Text = 'h4'
      Style.MarginLeft = '0'
      Style.MarginTop = '1.33em'
      Style.MarginRight = '0'
      Style.MarginBottom = '1.33em'
      Style.FontWeight = cfwBold
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object h5: TdhLink
      Left = 0
      Top = 642
      Height = 59
      Text = 'h5'
      Style.FontSize = '0.83em'
      Style.MarginLeft = '0'
      Style.MarginTop = '1.67em'
      Style.MarginRight = '0'
      Style.MarginBottom = '1.67em'
      Style.FontWeight = cfwBold
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object h6: TdhLink
      Left = 0
      Top = 679
      Height = 65
      Text = 'h6'
      Style.FontSize = '0.67em'
      Style.MarginLeft = '0'
      Style.MarginTop = '2.33em'
      Style.MarginRight = '0'
      Style.MarginBottom = '2.33em'
      Style.FontWeight = cfwBold
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object b: TdhLink
      Left = 0
      Top = 744
      Height = 19
      Text = 'b'
      Style.FontWeight = cfwBolder
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object strong: TdhLink
      Left = 0
      Top = 763
      Height = 19
      Text = 'strong'
      Use = b
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object i: TdhLink
      Left = 0
      Top = 782
      Height = 19
      Text = 'i'
      Style.FontStyle = cfsItalic
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object cite: TdhLink
      Left = 0
      Top = 801
      Height = 19
      Text = 'cite'
      Use = i
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object em: TdhLink
      Left = 0
      Top = 820
      Height = 19
      Text = 'em'
      Use = i
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object dfn: TdhLink
      Left = 0
      Top = 839
      Height = 19
      Text = 'dfn'
      Use = i
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object u: TdhLink
      Left = 0
      Top = 930
      Height = 19
      Text = 'u'
      Style.TextDecoration = [ctdUnderline]
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object ins: TdhLink
      Left = 0
      Top = 949
      Height = 19
      Text = 'ins'
      Use = u
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object s: TdhLink
      Left = 0
      Top = 968
      Height = 19
      Text = 's'
      Style.TextDecoration = [ctdLineThrough]
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object strike: TdhLink
      Left = 0
      Top = 987
      Height = 19
      Text = 'strike'
      Use = s
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object del: TdhLink
      Left = 0
      Top = 1006
      Height = 19
      Text = 'del'
      Use = s
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object blink: TdhLink
      Left = 0
      Top = 1025
      Height = 19
      Text = 'blink'
      Style.TextDecoration = [ctdBlink]
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object big: TdhLink
      Left = 0
      Top = 1044
      Height = 25
      Text = 'big'
      Style.FontSize = 'larger'
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object small: TdhLink
      Left = 0
      Top = 1069
      Height = 14
      Text = 'small'
      Style.FontSize = 'smaller'
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object sup: TdhLink
      Left = 0
      Top = 1083
      Height = 14
      Text = 'sup'
      Style.FontSize = 'smaller'
      Style.VerticalAlign = 'super'
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object sub: TdhLink
      Left = 0
      Top = 1097
      Height = 14
      Text = 'sub'
      Style.FontSize = 'smaller'
      Style.VerticalAlign = 'sub'
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object nobr: TdhLink
      Left = 0
      Top = 1111
      Height = 19
      Text = 'nobr (no line break)'
      Style.WhiteSpace = cwsNowrap
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object hr: TdhLink
      Left = 0
      Top = 1130
      Height = 18
      Style.BorderTop.Width = 1
      Style.BorderTop.Color = 10066329
      Style.BorderTop.Style = cbsSolid
      Style.BorderBottom.Width = 1
      Style.BorderBottom.Color = 14079702
      Style.BorderBottom.Style = cbsSolid
      Style.MarginTop = '0.5em'
      Style.MarginBottom = '0.5em'
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object unknown_element: TdhLink
      Left = 0
      Top = 1148
      Height = 19
      Text = 'unknown_element'
      Style.TextDecoration = [ctdLineThrough]
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object dd: TdhLink
      Left = 0
      Top = 138
      Height = 19
      Text = 'dd'
      Style.MarginLeft = '40'
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object dt: TdhLink
      Left = 0
      Top = 119
      Height = 19
      Text = 'dt'
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object dl: TdhLink
      Left = 0
      Top = 157
      Height = 51
      Text = 'dl'
      Style.MarginLeft = '1'
      Style.MarginTop = '1em'
      Style.MarginBottom = '1em'
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object tt: TdhLink
      Left = 0
      Top = 858
      Height = 18
      Text = 'tt'
      Style.FontFamily = 'monospace'
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object code: TdhLink
      Left = 0
      Top = 876
      Height = 18
      Text = 'code'
      Use = tt
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object kbd: TdhLink
      Left = 0
      Top = 894
      Height = 18
      Text = 'kbd'
      Use = tt
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object samp: TdhLink
      Left = 0
      Top = 912
      Height = 18
      Text = 'samp'
      Use = tt
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object menu: TdhLink
      Left = 0
      Top = 262
      Height = 51
      Text = 'menu'
      Use = ul
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object dir: TdhLink
      Left = 0
      Top = 297
      Height = 51
      Text = 'dir'
      Use = ul
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object ol: TdhLink
      Left = 0
      Top = 227
      Height = 51
      Text = 'ol (ordered list)'
      Style.ListStyleType = clsDecimal
      Use = ul
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object edit: TdhLink
      Left = 0
      Top = 1195
      Height = 23
      Text = 'edit'
      Style.Border.Width = 2
      Style.Border.Style = cbsInset
      Style.Padding = 1
      Style.FontSize = '14'
      Style.BackgroundColor = White
      Style.WhiteSpace = cwsPre
      Style.FontFamily = 'Microsoft Sans Serif'
      Style.Color = Black
      Style.FontStyle = cfsNormal
      Style.FontWeight = cfwNormal
      Style.TextDecoration = [ctdNone]
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object radiobuttonnormal: TdhLink
      Left = 0
      Top = 1218
      Width = 20
      Height = 16
      Text = 'radiobuttonpic'
      ImageType = bitImage
      Style.BackgroundImage.Path = 'res:TRANSPARENT_RADIOBUTTONNORMAL'
      Style.MarginLeft = '5'
      Style.MarginTop = '4'
      Style.MarginRight = '3'
      Style.MarginBottom = '0'
      Style.VerticalAlign = 'baseline'
      Use = checkboxnormal
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object radiobuttondown: TdhLink
      Left = 0
      Top = 1234
      Width = 20
      Height = 16
      Text = 'radiobuttonpic'
      ImageType = bitImage
      Style.BackgroundImage.Path = 'res:TRANSPARENT_RADIOBUTTONDOWN'
      Use = radiobuttonnormal
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object checkboxnormal: TdhLink
      Left = 0
      Top = 1250
      Width = 20
      Height = 17
      Text = 'radiobuttonpic'
      ImageType = bitImage
      Style.BackgroundImage.Path = 'res:CHECKBOXNORMAL'
      Style.MarginLeft = '4'
      Style.MarginTop = '4'
      Style.MarginRight = '3'
      Style.MarginBottom = '0'
      Style.VerticalAlign = 'baseline'
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object checkboxdown: TdhLink
      Left = 0
      Top = 1267
      Width = 20
      Height = 17
      Text = 'radiobuttonpic'
      ImageType = bitImage
      Style.BackgroundImage.Path = 'res:CHECKBOXDOWN'
      Use = checkboxnormal
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object newchar: TdhLink
      Left = 0
      Top = 1284
      Height = 19
      Text = 'newchar'
      Style.BackgroundColor = Yellow
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object filebutton: TdhLink
      Left = 0
      Top = 1167
      Height = 28
      Text = 'filebutton'
      Style.Border.Width = 2
      Style.Border.Style = cbsOutset
      Style.PaddingLeft = 9
      Style.PaddingTop = 1
      Style.PaddingRight = 9
      Style.PaddingBottom = 3
      Style.BackgroundColor = ButtonFace
      Style.TextAlign = ctaCenter
      Style.WhiteSpace = cwsNowrap
      Style.Cursor = ccuDefault
      Style.FontFamily = 'Microsoft Sans Serif'
      Style.Color = Black
      Style.FontStyle = cfsNormal
      Style.FontWeight = cfwNormal
      Style.TextDecoration = [ctdNone]
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      StyleOverDown.Border.Style = cbsInset
      StyleOverDown.PaddingLeft = 10
      StyleOverDown.PaddingTop = 2
      StyleOverDown.PaddingRight = 8
      StyleOverDown.PaddingBottom = 2
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object button: TdhLink
      Left = 0
      Top = 1303
      Height = 24
      Text = 'button'
      Style.FontSize = '13'
      Style.Cursor = ccuDefault
      Use = filebutton
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object memo: TdhLink
      Left = 0
      Top = 1327
      Height = 22
      Text = 'memo'
      Style.FontSize = '13'
      Style.FontFamily = 'Courier New, Courier, monospace'
      Use = edit
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object a: TdhLink
      Left = 0
      Top = 1364
      Height = 19
      Text = 'a'
      Style.Cursor = ccuPointer
      Style.Color = Blue
      Style.TextDecoration = [ctdUnderline]
      Style.Effects.Rotation = 120
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object for_small_caps: TdhLabel
      Left = 0
      Top = 1349
      Height = 15
      Text = 'for_small_caps'
      Style.FontSize = '0.8em'
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
    end
    object uniw: TdhLabel
      Left = 0
      Top = 1383
      Height = 19
      Text = 'uniw'
      Style.BackgroundColor = 13303807
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
    end
    object listbox: TdhLabel
      Left = 0
      Top = 1402
      Height = 22
      Text = 'listbox'
      Style.PaddingLeft = 0
      Style.PaddingTop = 1
      Style.PaddingRight = 0
      Style.PaddingBottom = 1
      Style.FontSize = '13'
      Style.FontFamily = 'Microsoft Sans Serif'
      Use = edit
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
    end
    object selectedlistboxitem: TdhLabel
      Left = 0
      Top = 1424
      Height = 19
      Text = 'selectedlistboxitem'
      Style.BackgroundColor = Highlight
      Style.Color = White
      Style.Display = cdsBlock
      Use = listboxitem
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
    end
    object cursor: TdhLabel
      Left = 0
      Top = 119
      Height = 19
      Text = 'cursor'
      Style.Border.Color = White
      Style.BorderLeft.Style = cbsSolid
      Style.BorderRight.Style = cbsSolid
      Style.MarginLeft = '-1'
      Style.MarginRight = '-1'
      Visible = False
      AutoSizeXY = asY
      Align = alTop
      Right = 0
    end
    object listboxitem: TdhLabel
      Left = 0
      Top = 1443
      Height = 19
      Text = 'listboxitem'
      Style.PaddingLeft = 3
      Style.PaddingRight = 3
      Style.WhiteSpace = cwsNowrap
      Style.Display = cdsBlock
      Style.Effects.Rotation = 120
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
    end
    object menupopup: TdhLabel
      Left = 0
      Top = 1462
      Height = 25
      Text = 'menupopup'
      Style.Border.Style = cbsSolid
      Style.BorderTop.Color = 11711154
      Style.BorderBottom.Color = Black
      Style.BorderLeft.Color = 11711154
      Style.BorderRight.Color = Black
      Use = listbox
      AutoSizeXY = asNone
      Visible = False
      Align = alTop
      Right = 0
    end
    object hidden: TdhLabel
      Left = 0
      Top = 1487
      Height = 19
      Text = 'hidden'
      Style.Visibility = cviHidden
      AutoSizeXY = asY
      Visible = False
      Align = alTop
      Right = 0
    end
  end
end
