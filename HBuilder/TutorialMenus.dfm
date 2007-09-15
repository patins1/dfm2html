object PageContainer2: TPageContainer2
  Left = -4
  Top = -23
  Width = 1608
  Height = 751
  Caption = 'TutorialMenus.dfm'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
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
      Left = 0
      Top = 0
      Width = 693
      Height = 43
      Text = 
        '<Label4><nobr>&nbsp;DFM2HTML Tutorial&nbsp;</nobr></Label4><Labe' +
        'l3>&nbsp;for </Label3><Label2><nobr>&nbsp;DHTML Menus&nbsp;</nob' +
        'r></Label2>'
      Style.FontSize = '36'
      Style.FontFamily = 'Pump Demi Bold LET'
      Style.FontWeight = cfwBold
      Style.Effects.AntiAliasing = True
      AutoSizeXY = asXY
    end
    object StyleSheet1: TdhStyleSheet
      Left = 844
      Top = 80
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Label2: TdhLabel
        Left = 0
        Top = 0
        Height = 16
        Text = 'Label2'
        Style.BackgroundColor = Red
        Style.Color = Yellow
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
      object Label3: TdhLabel
        Left = 0
        Top = 19
        Height = 16
        Text = 'Label3'
        Style.BackgroundColor = Yellow
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
      object Label4: TdhLabel
        Left = 0
        Top = 38
        Height = 16
        Text = 'Label4'
        Style.BackgroundColor = Blue
        Style.Color = White
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
    end
    object StyleSheet2: TdhStyleSheet
      Left = 846
      Top = 128
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 224
      ExpandedHeight = 232
      Expanded = False
      object chapter: TdhLink
        Left = 0
        Top = 22
        Height = 16
        Text = 'chapter'
        Style.Color = Black
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
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
        Right = 0
      end
      object Label6: TdhLabel
        Left = 0
        Top = 64
        Height = 16
        Text = 'Label3'
        Style.Color = Red
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
      object tab: TdhLabel
        Left = 0
        Top = 0
        Height = 22
        Text = 'tab'
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000002F00
          000012080200000044A110880000000467414D410000B18F0BFC61050000004D
          4944415478DAEDD00109C0400C43D156533CC553ABA9D174BBC13C9441BE82C7
          CF734612D48AD5400039539712D8B5442804E6D4452D7FF93C425615C96DC95B
          775B638D35D658638D35FFD43CCBCA5BBE1D42F3BE0000000049454E44AE4260
          82}
        Style.BackgroundRepeat = cbrNoRepeat
        Style.Padding = 3
        Style.FontSize = '11'
        Style.FontFamily = 'Microsoft Sans Serif'
        Style.LineHeight = '150%'
        Style.Effects.Rotation = 120
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
    end
    object Link1: TdhLink
      Left = 404
      Top = 317
      Width = 135
      Height = 18
      Text = 'Sections of this tutorial'
      Style.Border.Style = cbsSolid
      Style.BackgroundColor = Yellow
      Style.Cursor = ccuPointer
      AutoSizeXY = asXY
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      object Menu1: TdhMenu
        Left = 404
        Top = 338
        Width = 123
        Height = 62
        Style.Border.Width = 1
        Style.Border.Color = Silver
        Style.Border.Style = cbsSolid
        Style.Padding = 6
        Style.Margin = '0'
        Style.BackgroundColor = 14540253
        AutoSizeXY = asXY
        MenuOptions = []
        ReactionTime = 400
        MenuLeft = -131
        MenuTop = 28
        object Link24: TdhLink
          Left = 7
          Top = 7
          Height = 19
          Text = 'Basics'
          AutoSizeXY = asXY
          Align = alTop
          Right = 7
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkAnchor = Label8
        end
        object Link6: TdhLink
          Left = 7
          Top = 26
          Height = 19
          Text = 'Style management'
          AutoSizeXY = asXY
          Align = alTop
          Right = 7
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkAnchor = Label9
        end
        object Link23: TdhLink
          Left = 7
          Top = 45
          Height = 19
          Text = 'Menu Options'
          AutoSizeXY = asXY
          Align = alTop
          Right = 7
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkAnchor = Label5
        end
      end
    end
    object Label8: TdhLabel
      Left = 28
      Top = 64
      Width = 40
      Height = 16
      Text = 'Basics'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label9: TdhLabel
      Left = 28
      Top = 552
      Width = 120
      Height = 16
      Text = 'Style management'
      Use = chapter
      AutoSizeXY = asXY
    end
    object Label10: TdhLabel
      Left = 36
      Top = 592
      Width = 632
      Height = 49
      Text = 
        'If a menu reuses the styles of another menu and <b>Automatic</b>' +
        ' is checked, it also reuses all settings in the <tab>&nbsp;&nbsp' +
        ';Menu&nbsp;&nbsp;&nbsp;</tab> tab of the other menu. In the foll' +
        'owing example, all styles for menu items and submenus are define' +
        'd in stylesheet <b>MenuStylesheet</b>, while the actual menus/me' +
        'nu items only reuse these styles:'
      AutoSizeXY = asY
    end
    object Label7: TdhLabel
      Left = 28
      Top = 88
      Width = 720
      Height = 129
      Text = 
        'Since version 1.9, a new object type is introduced, menu objects' +
        '. '#10'A menu object is a container for menu items and can be opened' +
        ' by exactly one link object definable at <b>Open Menu By</b> in ' +
        'the <tab>&nbsp;&nbsp;Menu&nbsp;&nbsp;&nbsp;</tab> tab.'#10'The menu ' +
        'object is then owned by the link object, i.e. deleting the link ' +
        'object deletes the menu object and copying the link object inclu' +
        'des copying the menu object.'#10'<br/><br/>'#10'Via <b>Create Submenu</b' +
        '> from the context menu of a link, you can create a new menu bei' +
        'ng opened by this link. '#10'In design mode, the menu of a link can ' +
        'be opened by double-clicking the link or choosing <nobr><b>Go to' +
        ' | Menu</b></nobr> from its context menu.'#10'You can add a menu ite' +
        'm (a simple link object) to the menu by the context menu of the ' +
        'menu.'
      AutoSizeXY = asY
    end
    object Label11: TdhLabel
      Left = 140
      Top = 312
      Width = 248
      Height = 111
      Text = 
        'When the mouse is at least<nobr> 400 msec</nobr> over the link t' +
        'o the right, the assigned submenu opens. The time interval can b' +
        'e customized in the <tab>&nbsp;&nbsp;Menu&nbsp;&nbsp;&nbsp;</tab' +
        '> tab. '#10'If disabled (<b>after</b> is unchecked), the menu can be' +
        ' opened by a mouse click.'
      Style.Border.Color = Silver
      Style.Border.Style = cbsSolid
      Style.Padding = 6
      Style.Margin = '0'
      Style.TextAlign = ctaJustify
      AutoSizeXY = asY
    end
    object Label5: TdhLabel
      Left = 28
      Top = 1208
      Width = 87
      Height = 16
      Text = 'Menu Options'
      Use = chapter
      AutoSizeXY = asXY
    end
    object MenuStylesheet: TdhStyleSheet
      Left = 772
      Top = 672
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 248
      ExpandedHeight = 160
      Expanded = False
      object Menu2: TdhMenu
        Left = 0
        Top = 0
        Height = 38
        Style.Border.Width = 2
        Style.Border.Color = 10485760
        Style.Border.Style = cbsSolid
        Style.Margin = '0'
        Style.BorderRadius.All = '20'
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        MenuOptions = []
        ReactionTime = 400
        object Link2: TdhLink
          Left = 2
          Top = 2
          Height = 34
          Text = 'Link'
          Style.Padding = 5
          Style.PaddingLeft = 10
          Style.PaddingRight = 10
          Style.Margin = '4'
          Style.BackgroundColor = 10485760
          Style.Cursor = ccuPointer
          Style.FontFamily = 'Verdana'
          Style.Color = White
          Style.BorderRadius.All = '135'
          AutoSizeXY = asXY
          Align = alTop
          Right = -4
          StyleDown.BackgroundColor = Blue
          StyleOver.BackgroundColor = Aqua
          StyleOver.Color = Black
          PreferDownStyles = False
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        end
      end
    end
    object Menu3: TdhMenu
      Left = 60
      Top = 672
      Width = 443
      Height = 38
      Use = Menu2
      AutoSizeXY = asXY
      MenuOptions = []
      ReactionTime = 400
      object Link3: TdhLink
        Left = 2
        Top = 2
        Width = 149
        Text = 'Link with submenu'
        Use = Link2
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 2
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu4: TdhMenu
          Left = 63
          Top = 713
          Width = 153
          Height = 98
          Use = Menu2
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 5
          object Link7: TdhLink
            Left = 2
            Top = 34
            Height = 36
            Text = 'Link with submenu'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu7: TdhMenu
              Left = 217
              Top = 745
              Width = 57
              Height = 68
              Use = Menu2
              AutoSizeXY = asXY
              MenuOptions = []
              ReactionTime = 400
              MenuLeft = 5
              object Link12: TdhLink
                Left = 2
                Top = 2
                Height = 36
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                Right = 2
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link22: TdhLink
                Left = 2
                Top = 34
                Height = 36
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                Right = 2
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link8: TdhLink
            Left = 2
            Top = 2
            Height = 36
            Text = 'Link with submenu'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu5: TdhMenu
              Left = 217
              Top = 713
              Width = 153
              Height = 68
              Use = Menu2
              AutoSizeXY = asXY
              MenuOptions = []
              ReactionTime = 400
              MenuLeft = 5
              object Link11: TdhLink
                Left = 2
                Top = 34
                Height = 36
                Text = 'Link with submenu'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                Right = 2
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                object Menu10: TdhMenu
                  Left = 371
                  Top = 745
                  Width = 57
                  Height = 98
                  Use = Menu2
                  AutoSizeXY = asXY
                  MenuOptions = []
                  ReactionTime = 400
                  MenuLeft = 5
                  object Link18: TdhLink
                    Left = 2
                    Top = 2
                    Height = 36
                    Text = 'Link'
                    Use = Link2
                    AutoSizeXY = asXY
                    Align = alTop
                    Right = 2
                    PreferDownStyles = True
                    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  end
                  object Link19: TdhLink
                    Left = 2
                    Top = 34
                    Height = 36
                    Text = 'Link'
                    Use = Link2
                    AutoSizeXY = asXY
                    Align = alTop
                    Right = 2
                    PreferDownStyles = True
                    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  end
                  object Link21: TdhLink
                    Left = 2
                    Top = 66
                    Height = 36
                    Text = 'Link'
                    Use = Link2
                    AutoSizeXY = asXY
                    Align = alTop
                    Right = 2
                    PreferDownStyles = True
                    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  end
                end
              end
              object Link20: TdhLink
                Left = 2
                Top = 2
                Height = 36
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                Right = 2
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link9: TdhLink
            Left = 2
            Top = 66
            Height = 36
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
      object Link4: TdhLink
        Left = 147
        Top = 2
        Width = 149
        Text = 'Link with submenu'
        Use = Link2
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 2
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu6: TdhMenu
          Left = 241
          Top = 713
          Width = 153
          Height = 68
          Use = Menu2
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 5
          object Link10: TdhLink
            Left = 2
            Top = 2
            Height = 36
            Text = 'Link with submenu'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu9: TdhMenu
              Left = 395
              Top = 713
              Width = 57
              Height = 68
              Use = Menu2
              AutoSizeXY = asXY
              MenuOptions = []
              ReactionTime = 400
              MenuLeft = 5
              object Link15: TdhLink
                Left = 2
                Top = 2
                Height = 36
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                Right = 2
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link16: TdhLink
                Left = 2
                Top = 34
                Height = 36
                Text = 'Link'
                Use = Link2
                AutoSizeXY = asXY
                Align = alTop
                Right = 2
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link14: TdhLink
            Left = 2
            Top = 34
            Height = 36
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
      object Link5: TdhLink
        Left = 292
        Top = 2
        Width = 149
        Text = 'Link with submenu'
        Use = Link2
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 2
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu8: TdhMenu
          Left = 419
          Top = 713
          Width = 57
          Height = 98
          Use = Menu2
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 5
          object Link13: TdhLink
            Left = 2
            Top = 2
            Height = 36
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link17: TdhLink
            Left = 2
            Top = 34
            Height = 36
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link25: TdhLink
            Left = 2
            Top = 66
            Height = 36
            Text = 'Link'
            Use = Link2
            AutoSizeXY = asXY
            Align = alTop
            Right = 2
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
    end
    object Label12: TdhLabel
      Left = 36
      Top = 872
      Width = 632
      Height = 225
      Text = 
        'A menu object adapts its size to the size of the child objects, ' +
        ' provided they are all aligned to the left or to the top and tha' +
        't <b>Auto Width</b> or <b>Auto Height</b> in the <tab>&nbsp;&nbs' +
        'p;&nbsp;&nbsp;Pos.&nbsp;&nbsp;&nbsp;</tab> tab is checked. For t' +
        'hat reason, <b>Menu3</b> in the above example is a menu object i' +
        'n contrast to a simple panel object. As menu not belonging to a ' +
        'menu item, <b>Menu3</b> is always visible.'#10'<br/><br/>'#10'A submenu ' +
        'is either positioned under its menu item or to the right of its ' +
        'menu item, depending on whether the menu item itself is aligned ' +
        'to the left or to the top. Thus, in the example above, the first' +
        ' level of submenus are under their menuitems, while the second l' +
        'evel of submenus are to the right of their menu items.'#10'<br/><br/' +
        '>'#10'When you position a submenu, the relative position to the menu' +
        ' item is assigned to all submenus using the same menu style. Whe' +
        'n you delete the last contained menu item of an auto-sized menu,' +
        ' the menu itself is deleted, too.'#10'<br/><br/>'#10'Note that the down-' +
        'style of a menu item is active if its submenu is opened.'
      AutoSizeXY = asY
    end
    object Label14: TdhLabel
      Left = 40
      Top = 1304
      Width = 73
      Height = 16
      Text = '<u>Inline menus</u>'
      AutoSizeXY = asXY
    end
    object Label16: TdhLabel
      Left = 40
      Top = 1336
      Width = 624
      Height = 32
      Text = 
        'If the <b>Inline Menu</b> option is set and the menu'#39's menu item' +
        ' is aligned to the top, the menu is also aligned to the top appe' +
        'aring under the menu item. The visual effect shows the following' +
        ' example:'
      AutoSizeXY = asY
    end
    object Label13: TdhLabel
      Left = 40
      Top = 1800
      Width = 624
      Height = 64
      Text = 
        'The preceding inline menu contains two levels of nested sub menu' +
        's. Note that the stylesheet menu <b>Menu26</b> is also nested in' +
        ' order to provide different background colors for each nesting l' +
        'evel. Whenever you add a submenu, it is tried to assign a styles' +
        'heet menu near the same nesting level. This also applies when cr' +
        'eating popup menus.'
      AutoSizeXY = asY
    end
    object Page1: TdhPage
      Left = 42
      Top = 1386
      Width = 680
      Height = 408
      AutoSizeXY = asNone
      UseIFrame = True
      object PageControl1: TdhPageControl
        Left = 232
        Top = 8
        Width = 24
        Height = 24
        ActivePage = Page8
        FixedHeight = True
        object Page2: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Yellow
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page3: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 4227327
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page4: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 4259584
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page5: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Blue
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page6: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 16512
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page7: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Green
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page8: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 8421631
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page9: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 8388863
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page10: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Olive
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page11: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Navy
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page12: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 16512
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page13: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 16711808
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page14: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = Black
          AutoSizeXY = asNone
          UseIFrame = False
        end
        object Page15: TdhPage
          Left = 232
          Top = 8
          Width = 40
          Height = 40
          Style.BackgroundColor = 8453888
          AutoSizeXY = asNone
          UseIFrame = False
        end
      end
      object Menu20: TdhMenu
        Left = 26
        Top = 4
        Width = 184
        Height = 84
        Style.Border.Width = 2
        Style.Border.Style = cbsSolid
        Style.BorderRadius.All = '20'
        Use = Menu26
        AutoSizeXY = asY
        MenuOptions = []
        ReactionTime = 400
        object Link43: TdhLink
          Left = 16
          Top = 10
          Height = 24
          Text = 'Link with submenu'
          Use = Link57
          AutoSizeXY = asXY
          Align = alTop
          Right = 6
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          object Menu21: TdhMenu
            Left = 16
            Top = 33
            Height = 80
            Use = Menu27
            AutoSizeXY = asXY
            Align = alTop
            Right = 6
            MenuOptions = []
            ReactionTime = 400
            object Link44: TdhLink
              Left = 14
              Top = 8
              Height = 27
              Text = 'Link with submenu'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              Right = 10
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page3
              object Menu22: TdhMenu
                Left = 14
                Top = 31
                Height = 40
                Use = Menu28
                AutoSizeXY = asXY
                Align = alTop
                Right = 10
                MenuOptions = []
                ReactionTime = 400
                object Link46: TdhLink
                  Left = 14
                  Top = 8
                  Height = 27
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 10
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page5
                end
              end
            end
            object Link47: TdhLink
              Left = 14
              Top = 31
              Height = 27
              Text = 'Link with submenu'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              Right = 10
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page6
              object Menu23: TdhMenu
                Left = 14
                Top = 54
                Height = 80
                Use = Menu28
                AutoSizeXY = asXY
                Align = alTop
                Right = 10
                MenuOptions = []
                ReactionTime = 400
                object Link48: TdhLink
                  Left = 14
                  Top = 8
                  Height = 27
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 10
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page7
                end
                object Link49: TdhLink
                  Left = 14
                  Top = 31
                  Height = 27
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 10
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page8
                end
                object Link50: TdhLink
                  Left = 14
                  Top = 54
                  Height = 27
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 10
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page9
                end
              end
            end
            object Link51: TdhLink
              Left = 14
              Top = 54
              Height = 27
              Text = 'Link with submenu'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              Right = 10
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page10
              object Menu24: TdhMenu
                Left = 14
                Top = 77
                Height = 60
                Use = Menu28
                AutoSizeXY = asXY
                Align = alTop
                Right = 10
                MenuOptions = []
                ReactionTime = 400
                object Link52: TdhLink
                  Left = 14
                  Top = 8
                  Height = 27
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 10
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page11
                end
                object Link60: TdhLink
                  Left = 14
                  Top = 31
                  Height = 27
                  Text = 'Link'
                  Use = Link58
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = 10
                  PreferDownStyles = True
                  Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  LinkPage = Page4
                end
              end
            end
          end
        end
        object Link53: TdhLink
          Left = 16
          Top = 30
          Height = 24
          Text = 'Link with submenu'
          Use = Link57
          AutoSizeXY = asXY
          Align = alTop
          Right = 6
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          object Menu25: TdhMenu
            Left = 16
            Top = 56
            Height = 60
            Use = Menu27
            AutoSizeXY = asXY
            Align = alTop
            Right = 6
            MenuOptions = []
            ReactionTime = 400
            object Link54: TdhLink
              Left = 14
              Top = 8
              Height = 27
              Text = 'Link'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              Right = 10
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page13
            end
            object Link55: TdhLink
              Left = 14
              Top = 31
              Height = 27
              Text = 'Link'
              Use = Link58
              AutoSizeXY = asXY
              Align = alTop
              Right = 10
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              LinkPage = Page14
            end
          end
        end
        object Link56: TdhLink
          Left = 16
          Top = 50
          Height = 24
          Text = 'Link'
          Use = Link57
          AutoSizeXY = asXY
          Align = alTop
          Right = 6
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          LinkPage = Page15
        end
      end
      object StyleSheet4: TdhStyleSheet
        Left = 232
        Top = 57
        Width = 28
        Height = 28
        Expanded = False
        ExpandedWidth = 320
        ExpandedHeight = 240
        Expanded = False
        object Menu26: TdhMenu
          Left = 0
          Top = 0
          Height = 40
          Style.Padding = 4
          Style.PaddingLeft = 10
          Style.PaddingRight = 0
          Style.Margin = '4'
          Style.BackgroundColor = Silver
          Style.BorderRadius.TopLeft = '10'
          Style.BorderRadius.BottomLeft = '10'
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          MenuOptions = [moInline, moClickToOpen]
          ReactionTime = 400
          object Link57: TdhLink
            Left = 14
            Top = 8
            Height = 24
            Text = 'Link26'
            Style.PaddingLeft = 9
            Style.Margin = '4'
            Style.Cursor = ccuPointer
            AutoSizeXY = asXY
            Align = alTop
            Right = -5
            StyleDown.BackgroundColor = Red
            StyleDown.Color = Black
            StyleDown.TextDecoration = [ctdNone]
            StyleDown.BorderRadius.All = '34'
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = 'http://'
            object Menu27: TdhMenu
              Left = 14
              Top = 31
              Height = 40
              Style.PaddingRight = 10
              Style.MarginRight = '0'
              Style.BackgroundColor = Yellow
              Use = Menu26
              AutoSizeXY = asXY
              Align = alTop
              Right = -12
              MenuOptions = [moNoAuto, moInline]
              ReactionTime = 400
              object Link58: TdhLink
                Left = 14
                Top = 8
                Height = 27
                Text = 'Link31'
                Use = Link57
                AutoSizeXY = asXY
                Align = alTop
                Right = 10
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                object Menu28: TdhMenu
                  Left = 10
                  Top = 31
                  Height = 40
                  Style.BackgroundColor = 65408
                  Style.BorderRadius.BottomRight = '10'
                  Style.BorderRadius.TopRight = '10'
                  Use = Menu27
                  AutoSizeXY = asXY
                  Align = alTop
                  Right = -10
                  MenuOptions = [moNoAuto, moInline, moClickToOpen]
                  ReactionTime = 400
                  object Link59: TdhLink
                    Left = 14
                    Top = 8
                    Height = 27
                    Text = 'Link32'
                    Use = Link57
                    AutoSizeXY = asXY
                    Align = alTop
                    Right = 10
                    PreferDownStyles = True
                    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
                  end
                end
              end
            end
          end
        end
      end
      object Menu11: TdhMenu
        Left = 576
        Top = 144
        Width = 100
        Height = 100
        AutoSizeXY = asXY
        MenuOptions = []
        ReactionTime = 400
      end
    end
    object Label19: TdhLabel
      Left = 40
      Top = 1917
      Width = 136
      Height = 16
      Text = '<u>Continue Opened Menu</u>'
      AutoSizeXY = asXY
    end
    object Label15: TdhLabel
      Left = 40
      Top = 1958
      Width = 624
      Height = 32
      Text = 
        'If this menu option is set, the submenu is immediately opened wh' +
        'en the mouse is over its menu item and another submenu of a sibl' +
        'ing menu item is already opened.'
      AutoSizeXY = asY
    end
    object Label17: TdhLabel
      Left = 40
      Top = 2035
      Width = 208
      Height = 16
      Text = '<u>Open by mouse click or mouse over</u>'
      AutoSizeXY = asXY
    end
    object Label18: TdhLabel
      Left = 40
      Top = 2076
      Width = 624
      Height = 32
      Text = 
        'If you select the <b>after</b> checkbox in the <b>Open Menu By</' +
        'b> panel, then the menu is opened after the specified time inter' +
        'val has elapsed. Otherwise, the menu can only be opened by a mou' +
        'se click.'
      AutoSizeXY = asY
    end
    object Label20: TdhLabel
      Left = 40
      Top = 1240
      Width = 624
      Height = 35
      Text = 
        'A menu reuses the following options from its stylesheet menu, wh' +
        'en <b>Automatic</b> is checked in the  <tab>&nbsp;&nbsp;Menu&nbs' +
        'p;&nbsp;&nbsp;</tab> tab.'
      Style.Padding = 1
      Style.Margin = '0'
      AutoSizeXY = asY
    end
  end
end
