object PageContainer3: TPageContainer3
  Left = -4
  Top = -23
  Width = 1608
  Height = 751
  Caption = 'Menus.dfm'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 18
  object Page1: TdhPage
    Left = 0
    Top = 0
    Style.FontSize = '13'
    Style.BackgroundColor = Silver
    AutoSizeXY = asNone
    Right = 0
    Bottom = 0
    UseIFrame = False
    DesignSize = (
      1600
      724)
    object PresetsHelper4: TdhLabel
      Left = 0
      Top = 0
      Height = 24
      Text = 'DHTML menus:'
      Style.Padding = 4
      Style.TextAlign = ctaCenter
      Style.Color = Red
      Style.FontWeight = cfwBold
      AutoSizeXY = asY
      Align = alTop
      Right = 0
    end
    object StyleSheet1: TdhStyleSheet
      Left = 872
      Top = 626
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 208
      ExpandedHeight = 176
      Expanded = False
      object Menu1: TdhMenu
        Left = 0
        Top = 0
        Height = 142
        Style.Border.Width = 2
        Style.Border.Color = 8808006
        Style.Border.Style = cbsSolid
        Style.Margin = '5'
        Style.BorderRadius.All = '13'
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        MenuOptions = []
        ReactionTime = 400
        object Link3: TdhLink
          Left = 7
          Top = 49
          Height = 44
          Text = 'Middle Link'
          Style.Padding = 3
          Style.FontSize = '14'
          Style.Margin = '2'
          Style.BackgroundColor = 8808006
          Style.TextAlign = ctaCenter
          Style.Cursor = ccuPointer
          Style.FontFamily = 'Verdana'
          Style.Color = Silver
          Style.FontVariant = cfvSmallCaps
          Style.TextDecoration = [ctdNone]
          AutoSizeXY = asXY
          Align = alTop
          Right = 7
          StyleOver.Color = White
          StyleOver.FontWeight = cfwBold
          Layout = ltText
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        end
        object Link10: TdhLink
          Left = 7
          Top = 91
          Height = 44
          Text = 'Bottom Link'
          Style.BorderRadius.BottomRight = '9'
          Style.BorderRadius.BottomLeft = '9'
          Use = Link3
          AutoSizeXY = asXY
          Align = alTop
          Right = 7
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        end
        object Link9: TdhLink
          Left = 7
          Top = 7
          Height = 44
          Text = 'Top Link'
          Style.BorderRadius.TopLeft = '9'
          Style.BorderRadius.TopRight = '9'
          Use = Link3
          AutoSizeXY = asXY
          Align = alTop
          Right = 7
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        end
      end
      object Label1: TdhLabel
        Left = 0
        Top = 91
        Height = 16
        Text = 'Label1'
        Style.FontFamily = 'Arial'
        AutoSizeXY = asY
        Align = alTop
        Right = 0
      end
    end
    object Menu2: TdhMenu
      Top = 624
      Width = 136
      Height = 166
      Use = Menu1
      AutoSizeXY = asY
      Anchors = [akTop]
      MenuOptions = []
      ReactionTime = 400
      object Link8: TdhLink
        Left = 7
        Top = 132
        Height = 27
        Text = 'Contact'
        Use = Link10
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Link11: TdhLink
        Left = 7
        Top = 32
        Height = 27
        Text = 'Information'
        Use = Link3
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Link12: TdhLink
        Left = 7
        Top = 57
        Height = 27
        Text = 'News'
        Use = Link3
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Link13: TdhLink
        Left = 7
        Top = 82
        Height = 27
        Text = 'Links&nbsp;&nbsp;&nbsp;&nbsp;<Label1>&nbsp;'#9658'</Label1>'
        Style.TextAlign = ctaRight
        Use = Link3
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu14: TdhMenu
          Left = 851
          Top = 536
          Width = 80
          Height = 91
          Use = Menu1
          AutoSizeXY = asY
          MenuOptions = []
          ReactionTime = 400
          object Link32: TdhLink
            Left = 7
            Top = 7
            Height = 27
            Text = 'Link32'
            Use = Link9
            AutoSizeXY = asXY
            Align = alTop
            Right = 7
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link33: TdhLink
            Left = 7
            Top = 32
            Height = 27
            Text = 'Link33'
            Use = Link3
            AutoSizeXY = asXY
            Align = alTop
            Right = 7
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link34: TdhLink
            Left = 7
            Top = 57
            Height = 27
            Text = 'Link34'
            Use = Link10
            AutoSizeXY = asXY
            Align = alTop
            Right = 7
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
      object Link14: TdhLink
        Left = 7
        Top = 7
        Height = 27
        Text = 'Home'
        Use = Link9
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Link15: TdhLink
        Left = 7
        Top = 107
        Height = 27
        Text = 'Photos'
        Use = Link3
        AutoSizeXY = asY
        Align = alTop
        Right = 7
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object Menu5: TdhMenu
      Top = 56
      Width = 216
      Height = 39
      Use = Menu8
      AutoSizeXY = asXY
      Anchors = [akTop]
      MenuOptions = []
      ReactionTime = 400
      object Link2: TdhLink
        Left = 0
        Top = 0
        Width = 72
        Text = 'Link8<br/>'#10'<Link24/>'
        Use = Link22
        AutoSizeXY = asY
        Align = alLeft
        Bottom = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu4: TdhMenu
          Left = 687
          Top = 94
          Width = 66
          Height = 75
          Use = Menu9
          AutoSizeXY = asY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 8
          MenuTop = 3
          object Link5: TdhLink
            Left = 5
            Top = 4
            Height = 22
            Text = 'Link5'
            Use = Link23
            AutoSizeXY = asXY
            Align = alTop
            Right = 5
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '#'
          end
          object Link6: TdhLink
            Left = 5
            Top = 26
            Height = 22
            Text = 'Link6'
            Use = Link23
            AutoSizeXY = asXY
            Align = alTop
            Right = 5
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '#'
          end
          object Link7: TdhLink
            Left = 5
            Top = 48
            Height = 22
            Text = 'Link7'
            Use = Link23
            AutoSizeXY = asXY
            Align = alTop
            Right = 5
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '#'
          end
        end
      end
      object Link4: TdhLink
        Left = 69
        Top = 0
        Width = 75
        Text = 'Link9<br/>'#10'<Link24></Link24>'
        Use = Link22
        AutoSizeXY = asY
        Align = alLeft
        Bottom = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu6: TdhMenu
          Left = 756
          Top = 94
          Width = 69
          Height = 53
          Use = Menu9
          AutoSizeXY = asY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 8
          MenuTop = 3
          object Link16: TdhLink
            Left = 5
            Top = 4
            Height = 22
            Text = 'Link10'
            Use = Link23
            AutoSizeXY = asXY
            Align = alTop
            Right = 5
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '#'
          end
          object Link17: TdhLink
            Left = 5
            Top = 26
            Height = 22
            Text = 'Link11'
            Use = Link23
            AutoSizeXY = asXY
            Align = alTop
            Right = 5
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '#'
          end
        end
      end
      object Link18: TdhLink
        Left = 141
        Top = 0
        Width = 75
        Text = 'Link2<br/>'#10'<Link24></Link24>'
        Use = Link22
        AutoSizeXY = asY
        Align = alLeft
        Bottom = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu7: TdhMenu
          Left = 828
          Top = 94
          Width = 69
          Height = 75
          Use = Menu9
          AutoSizeXY = asY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 8
          MenuTop = 3
          object Link19: TdhLink
            Left = 5
            Top = 4
            Height = 22
            Text = 'Link3'
            Use = Link23
            AutoSizeXY = asXY
            Align = alTop
            Right = 5
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '#'
          end
          object Link20: TdhLink
            Left = 5
            Top = 26
            Height = 22
            Text = 'Link12'
            Use = Link23
            AutoSizeXY = asXY
            Align = alTop
            Right = 5
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '#'
          end
          object Link21: TdhLink
            Left = 5
            Top = 48
            Height = 22
            Text = 'Link13'
            Use = Link23
            AutoSizeXY = asXY
            Align = alTop
            Right = 5
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            Link = '#'
          end
        end
      end
    end
    object StyleSheet2: TdhStyleSheet
      Left = 888
      Top = 64
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 352
      ExpandedHeight = 184
      Expanded = False
      object Menu8: TdhMenu
        Left = 0
        Top = 0
        Height = 39
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        MenuOptions = []
        ReactionTime = 400
        object Link22: TdhLink
          Left = 0
          Top = 0
          Width = 53
          Text = 'Link1<br/>'#10'<Link24></Label1>'
          Style.Border.Style = cbsSolid
          Style.BackgroundImage.Data = {
            0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
            00001908020000007FF2D328000000424944415478DA0DC3211040401000C0FB
            2CEBB2AECBBA2EEBBAACCBBA2EEBB2AECBFADB9DD91439A7F87C7DBCBD3C3DDC
            DD5C5D9C9D1C1DECED6C6DACAD2C2D8CFC03105D2574B384087E000000004945
            4E44AE426082}
          Style.BackgroundPosition = '0% 100%'
          Style.BackgroundRepeat = cbrRepeatX
          Style.Padding = 7
          Style.PaddingBottom = 4
          Style.FontSize = '13'
          Style.Margin = '3'
          Style.MarginBottom = '0'
          Style.BackgroundColor = Aqua
          Style.TextAlign = ctaCenter
          Style.Cursor = ccuPointer
          Style.FontFamily = 'Arial'
          Style.BorderRadius.TopLeft = '15'
          Style.BorderRadius.BottomRight = '15'
          Style.BorderRadius.BottomLeft = '17'
          Style.BorderRadius.TopRight = '16'
          AutoSizeXY = asXY
          Align = alLeft
          Bottom = 0
          StyleDown.BorderRadius.BottomRight = '0'
          StyleDown.BorderRadius.BottomLeft = '0'
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          object Menu9: TdhMenu
            Left = 892
            Top = 130
            Width = 47
            Height = 31
            Style.Border.Style = cbsSolid
            Style.BorderTop.Width = 0
            Style.Padding = 4
            Style.BackgroundColor = Blue
            Style.ZIndex = 2
            Style.BorderRadius.BottomRight = '15'
            Style.BorderRadius.BottomLeft = '15'
            AutoSizeXY = asXY
            MenuOptions = []
            ReactionTime = 400
            MenuLeft = 8
            MenuTop = 4
            object Link23: TdhLink
              Left = 5
              Top = 4
              Height = 22
              Text = 'Link4'
              Style.Padding = 3
              Style.FontSize = '13'
              Style.TextAlign = ctaCenter
              Style.FontFamily = 'Arial'
              Style.Color = White
              AutoSizeXY = asXY
              Align = alTop
              Right = 5
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              Link = 'http://'
            end
          end
        end
      end
      object Link24: TdhLink
        Left = 0
        Top = 39
        Width = 20
        Height = 7
        ImageType = bitImage
        Style.BackgroundImage.Data = {
          0954474946496D6167654749463839611400070000000021F90401000000002C
          0000000014000700800000000000000211848FA918EDBED28351BEBA285661FB
          5500003B}
        AutoSizeXY = asXY
        Align = alTop
        StyleDown.BackgroundImage.Data = {
          0954474946496D6167654749463839611400070000000021F90401000000002C
          000000001400070080000000FFFF000211848FA918EDBED28351BEBA285661FB
          5500003B}
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object Menu10: TdhMenu
      Top = 240
      Width = 208
      Height = 48
      Use = Menu20
      AutoSizeXY = asY
      Anchors = [akTop]
      MenuOptions = []
      ReactionTime = 400
      object Link25: TdhLink
        Left = 0
        Top = 0
        Height = 16
        Text = '<Image1></Image1><Image2></Image2><Link49>Link18</Link49>'
        Use = Link45
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu11: TdhMenu
          Left = 0
          Top = 16
          Height = 32
          Use = Menu21
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          MenuOptions = []
          ReactionTime = 400
          object Link26: TdhLink
            Left = 20
            Top = 0
            Height = 16
            Text = '<Image1></Image1><Image2></Image2><Link49>Link23</Link49>'
            Use = Link46
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu12: TdhMenu
              Left = 20
              Top = 16
              Height = 32
              Use = Menu21
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              MenuOptions = []
              ReactionTime = 400
              object Link27: TdhLink
                Left = 20
                Top = 0
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link25</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link28: TdhLink
                Left = 20
                Top = 16
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link26</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link29: TdhLink
            Left = 20
            Top = 16
            Height = 16
            Text = '<Image1></Image1><Image2></Image2><Link49>Link27</Link49>'
            Use = Link46
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu13: TdhMenu
              Left = 20
              Top = 32
              Height = 32
              Use = Menu21
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              MenuOptions = []
              ReactionTime = 400
              object Link30: TdhLink
                Left = 20
                Top = 0
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link28</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link31: TdhLink
                Left = 20
                Top = 16
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link29</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
        end
      end
      object Link38: TdhLink
        Left = 0
        Top = 16
        Height = 16
        Text = '<Image1></Image1><Image2></Image2><Link49>Link24</Link49>'
        Use = Link45
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu17: TdhMenu
          Left = 0
          Top = 32
          Height = 32
          Use = Menu21
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          MenuOptions = []
          ReactionTime = 400
          object Link39: TdhLink
            Left = 20
            Top = 0
            Height = 16
            Text = '<Image1></Image1><Image2></Image2><Link49>Link30</Link49>'
            Use = Link46
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu18: TdhMenu
              Left = 20
              Top = 16
              Height = 32
              Use = Menu21
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              MenuOptions = []
              ReactionTime = 400
              object Link40: TdhLink
                Left = 20
                Top = 0
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link31</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link41: TdhLink
                Left = 20
                Top = 16
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link32</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link42: TdhLink
            Left = 20
            Top = 16
            Height = 16
            Text = '<Image1></Image1><Image2></Image2><Link49>Link33</Link49>'
            Use = Link46
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu19: TdhMenu
              Left = 20
              Top = 32
              Height = 32
              Use = Menu21
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              MenuOptions = []
              ReactionTime = 400
              object Link43: TdhLink
                Left = 20
                Top = 0
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link34</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link44: TdhLink
                Left = 20
                Top = 16
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link35</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
        end
      end
      object Link73: TdhLink
        Left = 0
        Top = 32
        Height = 16
        Text = '<Image1></Image1><Image2></Image2><Link49>Link73</Link49>'
        Use = Link45
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu28: TdhMenu
          Left = 0
          Top = 48
          Height = 32
          Use = Menu21
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          MenuOptions = []
          ReactionTime = 400
          object Link74: TdhLink
            Left = 20
            Top = 0
            Height = 16
            Text = '<Image1></Image1><Image2></Image2><Link49>Link74</Link49>'
            Use = Link46
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu29: TdhMenu
              Left = 20
              Top = 16
              Height = 32
              Use = Menu21
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              MenuOptions = []
              ReactionTime = 400
              object Link75: TdhLink
                Left = 20
                Top = 0
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link75</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link76: TdhLink
                Left = 20
                Top = 16
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link76</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link77: TdhLink
            Left = 20
            Top = 16
            Height = 16
            Text = '<Image1></Image1><Image2></Image2><Link49>Link77</Link49>'
            Use = Link46
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu30: TdhMenu
              Left = 20
              Top = 32
              Height = 32
              Use = Menu21
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              MenuOptions = []
              ReactionTime = 400
              object Link78: TdhLink
                Left = 20
                Top = 0
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link78</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link79: TdhLink
                Left = 20
                Top = 16
                Height = 16
                Text = '<Link48></Link48><Image2></Image2><Link49>Link79</Link49>'
                Use = Link47
                AutoSizeXY = asXY
                Align = alTop
                Right = 0
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
        end
      end
    end
    object StyleSheet3: TdhStyleSheet
      Left = 904
      Top = 240
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 280
      ExpandedHeight = 200
      Expanded = False
      object Menu20: TdhMenu
        Left = 0
        Top = 0
        Height = 40
        Style.FontSize = '11'
        Style.FontFamily = 'tahoma'
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        MenuOptions = [moInline]
        ReactionTime = 400
        object Link45: TdhLink
          Left = 0
          Top = 0
          Height = 40
          Text = 
            '<Image1></Image1><Image2></Image2><Link49>Parent directory</Link' +
            '49>'
          Style.PaddingTop = 1
          Style.PaddingBottom = 2
          Style.Cursor = ccuDefault
          AutoSizeXY = asXY
          Align = alTop
          Right = 0
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          object Menu21: TdhMenu
            Left = 0
            Top = 16
            Height = 56
            Style.PaddingLeft = 20
            AutoSizeXY = asXY
            Align = alTop
            Right = 0
            MenuOptions = [moInline, moClickToOpen]
            ReactionTime = 400
            object Link46: TdhLink
              Left = 20
              Top = 0
              Height = 16
              Text = '<Image1></Image1><Image2></Image2><Link49>Link19</Link49>'
              Use = Link45
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            end
            object Link47: TdhLink
              Left = 20
              Top = 16
              Height = 16
              Text = '<Link48></Link48><Image2></Image2><Link49>Link19</Link49>'
              Use = Link45
              AutoSizeXY = asXY
              Align = alTop
              Right = 0
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            end
          end
        end
      end
      object Image1: TdhLink
        Left = 0
        Top = 16
        Width = 21
        Height = 11
        ImageType = bitImage
        Style.BackgroundImage.Data = {
          0954474946496D6167654749463839610B000B0011000021F90401000000002C
          000000000B000B0081000000FFFFFF808080000000021F848F26CBAC0163100F
          8E48818817E63D84E154051DA97158297D4D93C44001003B}
        Style.MarginLeft = '5'
        Style.MarginRight = '5'
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        StyleDown.BackgroundImage.Data = {
          0954474946496D6167654749463839610B000B0011000021F90401000001002C
          000000000B000B0081FFFFFF000000808080000000021C8C8F26CBAC0023104F
          421A84BD6F783F5516A66DE416664D93B44101003B}
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Image2: TdhLink
        Left = 0
        Top = 27
        Width = 21
        Height = 13
        ImageType = bitImage
        Style.BackgroundImage.Data = {
          0954474946496D61676547494638396110000D0033000021F90401000000002C
          0000000010000D0083000000FFFF99CC9933FFCC66996600666666CCCCCC8080
          80CC6633FFCC99CCCC33333333000000000000000000000000044C1000418591
          38CF6C3516402006532520D7348E1A715C42909874650803E84909E0E2B1D56A
          10201480C261F1984B8E144BE4604A9DC68CD22AF55AB89D08E0B0787100180E
          85B47A5D284700003B}
        Style.MarginLeft = '0'
        Style.MarginRight = '5'
        Style.VerticalAlign = 'middle'
        AutoSizeXY = asXY
        Align = alTop
        StyleOver.BackgroundImage.Data = {
          0954474946496D61676547494638396110000D0033000021F90401000000002C
          0000000010000D0083000000CC9933FFFF99FFCC66808080996600C0C0C0CCCC
          CCCCCC66996633CCCC33666666FFCC99FFCC330000000000000454108040C391
          38CF1C8CC601208CC25451D744925A907881809C7465044C807C12032484C020
          B65A0D04C08082581C211085A0B2396234020BE971C0ED721589C52DE62D07A2
          874361CD6EAFB31703614EAFCF3D11003B}
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Link48: TdhLink
        Left = 0
        Top = 40
        Height = 80
        Text = 'placeholder for directories without subdirectories'
        Style.MarginLeft = '21'
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
      object Link49: TdhLink
        Left = 0
        Top = 72
        Height = 32
        Text = 'folder caption'
        Style.Color = Black
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        StyleOver.Color = Navy
        StyleOver.TextDecoration = [ctdUnderline]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      end
    end
    object Menu3: TdhMenu
      Top = 416
      Width = 141
      Height = 19
      Use = Menu15
      AutoSizeXY = asXY
      Anchors = [akTop]
      MenuOptions = []
      ReactionTime = 400
      object Link35: TdhLink
        Left = 0
        Top = 0
        Width = 32
        Text = 'File'
        Use = Link1
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu22: TdhMenu
          Left = 721
          Top = 435
          Width = 90
          Height = 141
          Use = Menu16
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 3
          object Link52: TdhLink
            Left = 3
            Top = 29
            Height = 17
            Text = 'Open'
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link57: TdhLink
            Left = 3
            Top = 20
            Height = 9
            Use = Link55
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link58: TdhLink
            Left = 3
            Top = 3
            Height = 17
            Text = 'New'
            Use = Link56
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu24: TdhMenu
              Left = 799
              Top = 435
              Width = 122
              Height = 46
              Use = Menu31
              AutoSizeXY = asXY
              MenuOptions = []
              ReactionTime = 400
              object Link54: TdhLink
                Left = 3
                Top = 3
                Height = 17
                Text = 'Empty'
                Use = Link51
                AutoSizeXY = asXY
                Align = alTop
                Right = 9
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link37: TdhLink
                Left = 3
                Top = 20
                Height = 17
                Text = 'From Template'
                Use = Link51
                AutoSizeXY = asXY
                Align = alTop
                Right = 9
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link64: TdhLink
            Left = 3
            Top = 72
            Height = 17
            Text = 'Save'
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link63: TdhLink
            Left = 3
            Top = 89
            Height = 17
            Text = 'Save As '
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link65: TdhLink
            Left = 3
            Top = 106
            Height = 9
            Use = Link55
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link66: TdhLink
            Left = 3
            Top = 115
            Height = 17
            Text = 'Exit'
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link70: TdhLink
            Left = 3
            Top = 46
            Height = 17
            Text = 'Reopen'
            Use = Link56
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            object Menu27: TdhMenu
              Left = 799
              Top = 452
              Width = 87
              Height = 46
              Use = Menu31
              AutoSizeXY = asXY
              MenuOptions = []
              ReactionTime = 400
              object Link71: TdhLink
                Left = 3
                Top = 3
                Height = 17
                Text = 'Tutorial'
                Use = Link51
                AutoSizeXY = asXY
                Align = alTop
                Right = 9
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
              object Link72: TdhLink
                Left = 3
                Top = 20
                Height = 17
                Text = 'Guide'
                Use = Link51
                AutoSizeXY = asXY
                Align = alTop
                Right = 9
                PreferDownStyles = True
                Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              end
            end
          end
          object Link80: TdhLink
            Left = 3
            Top = 63
            Height = 9
            Use = Link55
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
      object Link36: TdhLink
        Left = 32
        Top = 0
        Width = 34
        Text = 'Edit'
        Use = Link1
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu23: TdhMenu
          Left = 753
          Top = 435
          Width = 76
          Height = 55
          Use = Menu16
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 3
          object Link53: TdhLink
            Left = 3
            Top = 3
            Height = 17
            Text = 'Copy'
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link67: TdhLink
            Left = 3
            Top = 20
            Height = 9
            Use = Link55
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link68: TdhLink
            Left = 3
            Top = 29
            Height = 17
            Text = 'Find'
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
      object Link61: TdhLink
        Left = 120
        Top = 0
        Width = 21
        Text = '?'
        Use = Link1
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu26: TdhMenu
          Left = 841
          Top = 435
          Width = 71
          Height = 29
          Use = Menu16
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 3
          object Link69: TdhLink
            Left = 3
            Top = 3
            Height = 17
            Text = 'Info'
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
      object Link50: TdhLink
        Left = 66
        Top = 0
        Width = 54
        Text = 'Window'
        Use = Link1
        AutoSizeXY = asXY
        Align = alLeft
        Bottom = 0
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        object Menu25: TdhMenu
          Left = 787
          Top = 435
          Width = 117
          Height = 63
          Use = Menu16
          AutoSizeXY = asXY
          MenuOptions = []
          ReactionTime = 400
          MenuLeft = 3
          MenuTop = 3
          object Link59: TdhLink
            Left = 3
            Top = 3
            Height = 17
            Text = 'Cascade'
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link62: TdhLink
            Left = 3
            Top = 20
            Height = 17
            Text = 'Tile'
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
          object Link60: TdhLink
            Left = 3
            Top = 37
            Height = 17
            Text = 'Arrange icons'
            Use = Link51
            AutoSizeXY = asXY
            Align = alTop
            Right = 9
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          end
        end
      end
    end
    object StyleSheet4: TdhStyleSheet
      Left = 936
      Top = 400
      Width = 248
      Height = 176
      Expanded = True
      object Menu15: TdhMenu
        Left = 0
        Top = 0
        Height = 19
        AutoSizeXY = asXY
        Align = alTop
        Right = 0
        MenuOptions = []
        ReactionTime = 400
        object Link1: TdhLink
          Left = 0
          Top = 0
          Width = 86
          Text = 'Top menu item'
          Style.Padding = 3
          Style.PaddingLeft = 8
          Style.PaddingRight = 8
          Style.FontSize = '11'
          Style.BackgroundColor = White
          Style.Cursor = ccuDefault
          Style.FontFamily = 'tahoma'
          AutoSizeXY = asXY
          Align = alLeft
          Bottom = 0
          StyleDown.BackgroundColor = 12937777
          StyleDown.Color = White
          StyleOver.BackgroundColor = 12937777
          StyleOver.Color = White
          PreferDownStyles = True
          Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
          object Menu16: TdhMenu
            Left = 934
            Top = 443
            Width = 169
            Height = 55
            ImageFormat = ifSemiTransparent
            Style.Border.Color = 10070188
            Style.Border.Style = cbsSolid
            Style.Padding = 2
            Style.Margin = '6'
            Style.MarginLeft = '0'
            Style.MarginTop = '0'
            Style.BackgroundColor = White
            Style.Effects.Enabled = True
            Style.Effects.AntiAliasing = False
            Style.Effects.Text = etInclude
            Style.Effects.OuterShadow.Enabled = True
            Style.Effects.OuterShadow.Alpha = 110
            Style.Effects.OuterShadow.Radius = 2
            Style.Effects.OuterShadow.Degree = 126
            Style.Effects.OuterShadow.Distance = 3
            AutoSizeXY = asXY
            MenuOptions = [moResumeOpen]
            ReactionTime = 400
            object Link56: TdhLink
              Left = 3
              Top = 3
              Height = 17
              Text = 'Menu item with submenu'
              Style.BackgroundImage.Data = {
                0954474946496D6167654749463837610B000800F70000000000800000008000
                808000000080800080008080808080C0C0C0FF000000FF00FFFF000000FFFF00
                FF00FFFFFFFFFF00000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000330000660000990000CC0000
                FF0033000033330033660033990033CC0033FF00660000663300666600669900
                66CC0066FF0099000099330099660099990099CC0099FF00CC0000CC3300CC66
                00CC9900CCCC00CCFF00FF0000FF3300FF6600FF9900FFCC00FFFF3300003300
                333300663300993300CC3300FF3333003333333333663333993333CC3333FF33
                66003366333366663366993366CC3366FF3399003399333399663399993399CC
                3399FF33CC0033CC3333CC6633CC9933CCCC33CCFF33FF0033FF3333FF6633FF
                9933FFCC33FFFF6600006600336600666600996600CC6600FF66330066333366
                33666633996633CC6633FF6666006666336666666666996666CC6666FF669900
                6699336699666699996699CC6699FF66CC0066CC3366CC6666CC9966CCCC66CC
                FF66FF0066FF3366FF6666FF9966FFCC66FFFF99000099003399006699009999
                00CC9900FF9933009933339933669933999933CC9933FF996600996633996666
                9966999966CC9966FF9999009999339999669999999999CC9999FF99CC0099CC
                3399CC6699CC9999CCCC99CCFF99FF0099FF3399FF6699FF9999FFCC99FFFFCC
                0000CC0033CC0066CC0099CC00CCCC00FFCC3300CC3333CC3366CC3399CC33CC
                CC33FFCC6600CC6633CC6666CC6699CC66CCCC66FFCC9900CC9933CC9966CC99
                99CC99CCCC99FFCCCC00CCCC33CCCC66CCCC99CCCCCCCCCCFFCCFF00CCFF33CC
                FF66CCFF99CCFFCCCCFFFFFF0000FF0033FF0066FF0099FF00CCFF00FFFF3300
                FF3333FF3366FF3399FF33CCFF33FFFF6600FF6633FF6666FF6699FF66CCFF66
                FFFF9900FF9933FF9966FF9999FF99CCFF99FFFFCC00FFCC33FFCC66FFCC99FF
                CCCCFFCCFFFFFF00FFFF33FFFF66FFFF99FFFFCCFFFFFF2C000000000B000800
                00081F001F007840B0A04100030D1E44A8B02042860D1F3624087162C289180B
                0604003B}
              Style.BackgroundPosition = '100% 50%'
              Style.BackgroundRepeat = cbrNoRepeat
              Use = Link51
              AutoSizeXY = asXY
              Align = alTop
              Right = 9
              StyleDown.BackgroundImage.Data = {
                0954474946496D6167654749463839610B00080000000021F90401000000002C
                000000000B00080080000000FFFFFF020F4480A971BAEC12837146446FBB3C15
                003B}
              StyleOver.BackgroundImage.Data = {
                0954474946496D6167654749463839610B00080000000021F90401000000002C
                000000000B00080080000000FFFFFF020F4480A971BAEC12837146446FBB3C15
                003B}
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
              object Menu31: TdhMenu
                Left = 1091
                Top = 443
                Width = 38
                Height = 40
                Use = Menu16
                AutoSizeXY = asNone
                MenuOptions = [moNoAuto]
                ReactionTime = 400
              end
            end
            object Link51: TdhLink
              Left = 3
              Top = 29
              Height = 17
              Text = 'Menu item'
              Style.PaddingLeft = 19
              Style.PaddingTop = 1
              Style.PaddingRight = 20
              Use = Link1
              AutoSizeXY = asXY
              Align = alTop
              Right = 9
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            end
            object Link55: TdhLink
              Left = 3
              Top = 20
              Height = 9
              Style.PaddingTop = 1
              Style.MarginLeft = '1'
              Style.MarginTop = '3'
              Style.MarginRight = '1'
              Style.MarginBottom = '5'
              Style.BackgroundColor = 10070188
              AutoSizeXY = asXY
              Align = alTop
              Right = 9
              PreferDownStyles = True
              Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            end
          end
        end
      end
    end
  end
end
