object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Caption = 'Guide.dfm'
  ClientHeight = 726
  ClientWidth = 1600
  Font.Charset = GREEK_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 19
  object index: TdhPage
    Left = 0
    Top = 0
    Style.FontSize = '13'
    Style.FontFamily = 'Arial'
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    object Label1: TdhLabel
      Left = 30
      Top = 24
      Width = 350
      Height = 51
      Text = 'DFM2HTML Guide'
      Style.FontSize = '36'
      Style.FontFamily = 'Arial Black'
      AutoSizeXY = asXY
    end
    object Label2: TdhLabel
      Left = 32
      Top = 104
      Width = 632
      Height = 16
      Text = 
        'In this guide you will learn how to set up a site with several p' +
        'ages  in a frameless layout within minutes.'
      AutoSizeXY = asY
    end
    object Label3: TdhLabel
      Left = 32
      Top = 160
      Width = 179
      Height = 16
      Text = '1. Add a page control object'
      Use = Label4
      AutoSizeXY = asXY
    end
    object StyleSheet1: TdhStyleSheet
      Left = 535
      Top = 40
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Label4: TdhLabel
        Left = 0
        Top = 22
        Height = 16
        Text = 'Step'
        Style.Color = 206
        Style.FontWeight = cfwBold
        AutoSizeXY = asY
        Align = alTop
      end
      object Image3: TdhLink
        Left = 0
        Top = 38
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Image3_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Label13: TdhLabel
        Left = 0
        Top = 188
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label13_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label20: TdhLabel
        Left = 0
        Top = 158
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label20_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label23: TdhLabel
        Left = 0
        Top = 68
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label23_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label30: TdhLabel
        Left = 0
        Top = 98
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label30_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
      object Label38: TdhLabel
        Left = 0
        Top = 128
        Width = 31
        Height = 30
        ImageType = bitImage
        Style.BackgroundImage.Path = 'Images\Label38_nm.png'
        Style.BackgroundImage.State = isAnalyzed
        Style.BackgroundImage.Width = 31
        Style.BackgroundImage.Height = 30
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asY
        Align = alTop
      end
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
    end
    object Label5: TdhLabel
      Left = 40
      Top = 192
      Width = 632
      Height = 78
      Text = 
        'First, create a new DFM2HTML document with the <b>File</b> menu.' +
        ' To design several pages in one DFM2HTML document, you have to a' +
        'dd a page control object to the document. Do this by clicking on' +
        ' the <Image3></Image3> button in the tool bar and then clicking ' +
        'on the document.'#10'You have added the object named <b>PageControl1' +
        '</b> as child object to object <b>index</b> (the outermost objec' +
        't of the document).'
      AutoSizeXY = asY
    end
    object Label6: TdhLabel
      Left = 32
      Top = 288
      Width = 125
      Height = 16
      Text = '2. Add page objects'
      Use = Label4
      AutoSizeXY = asXY
    end
    object Label8: TdhLabel
      Left = 32
      Top = 432
      Width = 144
      Height = 16
      Text = '3. Change visual styles'
      Use = Label4
      AutoSizeXY = asXY
    end
    object Label9: TdhLabel
      Left = 40
      Top = 320
      Width = 632
      Height = 82
      Text = 
        'Now we add alternative pages to the page control object. Only on' +
        'e alternative page can show up at the same time. In the bottom a' +
        'rea you see property tabs, in which properties of selected objec' +
        'ts can be edited. Go to the <tab>&nbsp;&nbsp;Pages&nbsp;&nbsp;</' +
        'tab> tab of the page control. Since one alternative page, <b>Pag' +
        'e1</b>, was already created by default, add a second alternative' +
        ' page, <b>Page2</b>, by clicking the <b>Create new page</b> butt' +
        'on. The name of an object can be changed in the <tab>&nbsp;&nbsp' +
        ';Object&nbsp;&nbsp;</tab> tab.'
      AutoSizeXY = asY
    end
    object Label10: TdhLabel
      Left = 40
      Top = 464
      Width = 632
      Height = 67
      Text = 
        'First select <b>Page1</b>. You can do this in the combo box of t' +
        'he tool bar. Go to its <tab>&nbsp;&nbsp;&nbsp;Font&nbsp;&nbsp;&n' +
        'bsp;&nbsp;</tab> tab and assign a red background color.'#10'Select <' +
        'b>Page2</b> and assign a yellow background color. Pages of one p' +
        'age control object can have different heights, but the position ' +
        'is the same. Assign a height of 1000 pixels in the <tab>&nbsp;&n' +
        'bsp;&nbsp;Pos.&nbsp;&nbsp;&nbsp;&nbsp;</tab> tab'#10'of <b>Page2</b>' +
        '.'
      Style.PaddingTop = 1
      AutoSizeXY = asY
    end
    object Label7: TdhLabel
      Left = 32
      Top = 568
      Width = 84
      Height = 16
      Text = '4. Link pages'
      Use = Label4
      AutoSizeXY = asXY
    end
    object Label12: TdhLabel
      Left = 40
      Top = 600
      Width = 632
      Height = 62
      Text = 
        'Add two link objects <Label13></Label13> to object <b>index</b>,' +
        ' <b>Link1</b> and <b>Link2</b>.'#10'In the <tab>&nbsp;&nbsp;&nbsp;Li' +
        'nk&nbsp;&nbsp;&nbsp;&nbsp;</tab> tab of <b>Link1</b>, choose <b>' +
        'Page1</b> in the <i>Link to page</i> combo box. Choose <b>Page2<' +
        '/b> for <b>Link2</b> accordingly.'#10'By double-clicking one link, y' +
        'ou can quickly navigate to the linked page object. Now the user ' +
        'can activate the two alternative pages using links.'
      AutoSizeXY = asY
    end
    object Label14: TdhLabel
      Left = 32
      Top = 704
      Width = 114
      Height = 16
      Text = '5. Generate HTML'
      Use = Label4
      AutoSizeXY = asXY
    end
    object Label15: TdhLabel
      Left = 40
      Top = 736
      Width = 632
      Height = 48
      Text = 
        'You can test the site within DFM2HTML with the <b>test</b> butto' +
        'n in the tool bar.'#10'You can preview the site in a browser by <b>P' +
        'ublish | Preview</b>. You can upload the site to a FTP directory' +
        ' by filling out the parameters in <b>Publish</b> | <b>Page Prope' +
        'rties</b> &rarr; <b>FTP Directory</b> and pressing <b>Publish</b' +
        '> | <b>Publish</b> finally.'
      AutoSizeXY = asY
    end
    object Label16: TdhLabel
      Left = 32
      Top = 848
      Width = 256
      Height = 16
      Text = '<b>Advanced topics (double-click on a link):</b>'
      AutoSizeXY = asXY
    end
    object PageControl1: TdhPageControl
      Left = 32
      Top = 912
      Width = 24
      Height = 24
      ActivePage = Page2
      FixedHeight = False
      object Page1: TdhPage
        Left = 32
        Top = 904
        Width = 656
        Height = 48
        AutoSizeXY = asNone
        UseIFrame = False
      end
      object Page2: TdhPage
        Left = 32
        Top = 904
        Width = 656
        Height = 536
        Use = Label41
        AutoSizeXY = asNone
        UseIFrame = False
        object Label17: TdhLabel
          Left = 32
          Top = 89
          Width = 158
          Height = 16
          Text = '1. Put pages into a panel'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label18: TdhLabel
          Left = 40
          Top = 121
          Width = 561
          Height = 110
          Text = 
            'First we need to create a new parent object for the alternative ' +
            'pages.'#10'Select <b>PageControl1</b> and execute <nobr><b>Edit</b> ' +
            '| <b>Cut</b></nobr> (confirm the warning). Now the page control ' +
            'with all its pages is in the clipboard.'#10'Add a panel object <Labe' +
            'l20></Label20> to object <b>index</b> and paste the objects of t' +
            'he clipboard into it (<b>Edit | Paste</b>). Set the height of <b' +
            '>Panel1</b> to be big enough to include the visible page of <b>P' +
            'ageControl1</b>, plus extra space to add the footer object we wi' +
            'll add in the next step.'#10'To better visualize <b>Panel1</b>, you ' +
            'can define a background color.'
          AutoSizeXY = asY
        end
        object Label19: TdhLabel
          Left = 40
          Top = 33
          Width = 561
          Height = 32
          Text = 
            'Following steps explain how to create a footer, i.e. an object w' +
            'hich is displayed at the bottom of each generated HTML page.'
          AutoSizeXY = asY
        end
        object Label21: TdhLabel
          Left = 32
          Top = 249
          Width = 148
          Height = 16
          Text = '2. Add the footer object'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label22: TdhLabel
          Left = 40
          Top = 281
          Width = 561
          Height = 95
          Text = 
            'Now put a label object <Label23></Label23> in the reserved space' +
            ' of <b>Panel1</b> and name it <b>Label1</b>. '#10'Enter a footer tex' +
            't, e.g. a copyright notice, in the editor window reachable by co' +
            'ntext menu of <b>Label1</b>. The copyright symbol '#169' can be selec' +
            'ted from the Unicode table reachable by the <b>UNICODE</b> butto' +
            'n. Finally check <b>Bottom parent edge</b> and uncheck <b>Top pa' +
            'rent edge</b> in the <b>Keep distance constant to</b> settings o' +
            'f the <tab>&nbsp;&nbsp;&nbsp;Pos.&nbsp;&nbsp;&nbsp;&nbsp;</tab> ' +
            'tab for <b>Label1</b>.'
          AutoSizeXY = asY
        end
        object Label11: TdhLabel
          Left = 40
          Top = 408
          Width = 561
          Height = 90
          Text = 
            'When you now preview the site in a browser you will make two obs' +
            'ervations:'#10'<ul>'#10'<li>When changing the alternative page, the heig' +
            'ht difference is propagated to <b>Panel1</b>.</li>'#10'<li>The foote' +
            'r object has a constant distance to the bottom edge of <b>Panel1' +
            '</b>, thus appearing below each alternative page.</li>'#10'</ul>'
          AutoSizeXY = asY
        end
      end
      object Page3: TdhPage
        Left = 32
        Top = 904
        Width = 656
        Height = 536
        Use = Label41
        AutoSizeXY = asNone
        UseIFrame = False
        object Label24: TdhLabel
          Left = 40
          Top = 33
          Width = 561
          Height = 32
          Text = 
            'Following steps explain how to reuse styles by stylesheet object' +
            's. The aim is to give <b>Page1</b> and <b>Page2</b> a black bord' +
            'er with rounded corners, defining the styles only on one object.'
          AutoSizeXY = asY
        end
        object Label25: TdhLabel
          Left = 32
          Top = 89
          Width = 255
          Height = 16
          Text = '1. Create a stylesheet with a style object'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label26: TdhLabel
          Left = 40
          Top = 121
          Width = 561
          Height = 46
          Text = 
            'Add a stylesheet object <Label30></Label30> to object <b>index</' +
            'b>. Press on the black <big>+</big> sign to add a simple label o' +
            'bject and name it <b>Style1</b>.'
          AutoSizeXY = asY
        end
        object Label27: TdhLabel
          Left = 32
          Top = 193
          Width = 95
          Height = 16
          Text = '2. Define styles'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label28: TdhLabel
          Left = 40
          Top = 225
          Width = 561
          Height = 50
          Text = 
            'Select <b>Style1</b>, go to the <tab>&nbsp;&nbsp;&nbsp;Edge&nbsp' +
            ';&nbsp;&nbsp;</tab> tab and define a black border of 10 pixel (s' +
            'elect value <b>Solid</b> for the border style). Now round the co' +
            'rners: Press the <b>Edit Border Radius</b> button and define a b' +
            'order radius of 20 pixels.'
          Style.PaddingTop = 1
          AutoSizeXY = asY
        end
        object Label29: TdhLabel
          Left = 40
          Top = 400
          Width = 561
          Height = 48
          Text = 
            'Note that a stylesheet object only serves as a simple container ' +
            'object, in which you can drop any object type from the tool bar.' +
            ' However only objects within a stylesheet can be reused by other' +
            ' objects.'#10'If you add a third page to the page control, it will b' +
            'e initialized to use <b>Style1</b>.'
          AutoSizeXY = asY
        end
        object Label31: TdhLabel
          Left = 32
          Top = 297
          Width = 93
          Height = 16
          Text = '3. Reuse styles'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label32: TdhLabel
          Left = 40
          Top = 329
          Width = 561
          Height = 34
          Text = 
            'Select <b>Page1</b>, go to the <tab>&nbsp;&nbsp;Object&nbsp;&nbs' +
            'p;</tab> tab and choose <b>Style1</b> into the <b>Use</b> field.' +
            ' Do the same with <b>Page2</b>.'
          Style.PaddingTop = 1
          AutoSizeXY = asY
        end
      end
      object Page4: TdhPage
        Left = 32
        Top = 904
        Width = 656
        Height = 536
        Use = Label41
        AutoSizeXY = asNone
        UseIFrame = False
        object Label33: TdhLabel
          Left = 40
          Top = 33
          Width = 561
          Height = 32
          Text = 
            'If you want to convert the above example to a frames layout, whe' +
            're the inner content of the page can be scrolled while the navig' +
            'ation links are fixed, follow the next steps:'
          AutoSizeXY = asY
        end
        object Label34: TdhLabel
          Left = 32
          Top = 89
          Width = 263
          Height = 16
          Text = '1. Put pages into a scrollable page object'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label35: TdhLabel
          Left = 40
          Top = 121
          Width = 597
          Height = 110
          Text = 
            'While <b>Page1</b> and <b>Page2</b> are managed by a page contro' +
            'l, you can add independent page objects from the tool bar <Label' +
            '38></Label38> to a document, too. An independent page can have s' +
            'crollbars, like the outermost page object <b>index</b>.'#10'Now firs' +
            't select <b>PageControl1</b> and execute <nobr><b>Edit</b> | <b>' +
            'Cut</b></nobr> (confirm the warning). The page control with all ' +
            'its pages is in the clipboard.'#10'Then add a new page object to obj' +
            'ect <b>index</b> and name it <b>Page3</b>.'#10'Paste the objects of ' +
            'the clipboard into it (<b>Edit | Paste</b>). To better visualize' +
            ' <b>Page3</b>, you can define a background color.'
          AutoSizeXY = asY
        end
        object Label36: TdhLabel
          Left = 32
          Top = 257
          Width = 160
          Height = 16
          Text = '2. Adjust position settings'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label37: TdhLabel
          Left = 40
          Top = 289
          Width = 597
          Height = 66
          Text = 
            'In the <tab>&nbsp;&nbsp;&nbsp;Pos.&nbsp;&nbsp;&nbsp;&nbsp;</tab>' +
            ' tab for <b>Page3</b>, check the options <b>Right parent edge</b' +
            '> and <b>Bottom parent edge</b>.'#10'Object <b>index</b> represents ' +
            'the browser window, and if it is resized by the user, child obje' +
            'ct <b>Page3</b> resizes in the same way, keeping the distance of' +
            ' its edges constant to the corresponding edges of object <b>inde' +
            'x</b>.'
          Style.PaddingTop = 1
          AutoSizeXY = asY
        end
        object Label39: TdhLabel
          Left = 32
          Top = 377
          Width = 109
          Height = 16
          Text = '3. Hide scrollbars'
          Use = Label4
          AutoSizeXY = asXY
        end
        object Label40: TdhLabel
          Left = 40
          Top = 417
          Width = 597
          Height = 49
          Text = 
            'You should position object <b>Page3</b> to fill out a large area' +
            ' of object <b>index</b>. You can hide any scrollbars in the <tab' +
            '>&nbsp;&nbsp;&nbsp;Page&nbsp;&nbsp;&nbsp;</tab> tab of object <b' +
            '>index</b> (select <b>no</b>), since the alternative pages are s' +
            'crolled within object <b>Page3</b> already.'
          AutoSizeXY = asY
        end
      end
    end
    object Link2: TdhLink
      Left = 32
      Top = 876
      Width = 76
      Height = 22
      Text = 'Add a footer'
      Use = Link4
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page2
      LinkAnchor = Link2
    end
    object Link1: TdhLink
      Left = 136
      Top = 876
      Width = 100
      Height = 22
      Text = 'Use stylesheets'
      Use = Link4
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page3
      LinkAnchor = Link1
    end
    object Link3: TdhLink
      Left = 256
      Top = 876
      Width = 158
      Height = 22
      Text = 'Change to a frames layout'
      Use = Link4
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      LinkPage = Page4
      LinkAnchor = Link3
    end
    object StyleSheet2: TdhStyleSheet
      Left = 496
      Top = 848
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Link4: TdhLink
        Left = 0
        Top = 0
        Height = 22
        Text = 'Link4'
        Style.Padding = 3
        AutoSizeXY = asXY
        Align = alTop
        Right = 20
        StyleDown.Border.Color = Blue
        StyleDown.Border.Style = cbsSolid
        StyleDown.Padding = 2
        StyleDown.TextDecoration = [ctdNone]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Label41: TdhLabel
        Left = 0
        Top = 22
        Height = 18
        Text = 'Label41'
        Style.Border.Color = Blue
        Style.Border.Style = cbsSolid
        AutoSizeXY = asY
        Align = alTop
        Right = 24
      end
    end
  end
end
