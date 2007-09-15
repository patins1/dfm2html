object PageContainer6: TPageContainer6
  Left = -4
  Top = -23
  Width = 1032
  Height = 519
  Caption = 'Template6.dfm'
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
    AutoSizeXY = asNone
    UseIFrame = False
    VertPosition = 76
    DesignSize = (
      1024
      492)
    Right = 0
    Bottom = 0
    object Panel1: TdhPanel
      Left = 0
      Top = -20
      Height = 40
      Style.Border.Color = Blue
      Style.BorderTop.Width = 1
      Style.BorderTop.Style = cbsSolid
      Style.BorderBottom.Style = cbsSolid
      Style.BackgroundColor = Lime
      AutoSizeXY = asNone
      Anchors = [akLeft, akTop, akRight]
      Right = 0
      object Link1: TdhLink
        Left = 16
        Top = 8
        Width = 41
        Height = 18
        Text = 'Home'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page1
      end
      object Label1: TdhLabel
        Left = 67
        Top = 8
        Width = 16
        Height = 19
        Text = '|'
        AutoSizeXY = asY
      end
      object Link3: TdhLink
        Left = 80
        Top = 8
        Width = 42
        Height = 18
        Text = 'News'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page2
      end
      object Label2: TdhLabel
        Left = 131
        Top = 8
        Width = 16
        Height = 19
        Text = '|'
        AutoSizeXY = asY
      end
      object Link4: TdhLink
        Left = 144
        Top = 8
        Width = 41
        Height = 18
        Text = 'Links'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page3
      end
      object Label3: TdhLabel
        Left = 195
        Top = 8
        Width = 16
        Height = 19
        Text = '|'
        AutoSizeXY = asY
      end
      object Link5: TdhLink
        Left = 208
        Top = 8
        Width = 47
        Height = 18
        Text = 'Photos'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page4
      end
      object Label4: TdhLabel
        Left = 269
        Top = 8
        Width = 16
        Height = 19
        Text = '|'
        AutoSizeXY = asY
      end
      object Link6: TdhLink
        Left = 280
        Top = 8
        Width = 53
        Height = 18
        Text = 'Contact'
        Use = Link2
        AutoSizeXY = asXY
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
        LinkPage = Page5
      end
    end
    object StyleSheet1: TdhStyleSheet
      Left = 616
      Top = 28
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 144
      ExpandedHeight = 200
      Expanded = False
      object Link2: TdhLink
        Left = 0
        Top = 0
        Height = 18
        Text = 'menu item'
        Style.PaddingRight = 4
        Style.FontSize = '16'
        Style.FontFamily = 'Monotype Corsiva'
        Style.FontWeight = cfwBold
        AutoSizeXY = asXY
        Align = alTop
        StyleDown.Color = Black
        StyleDown.TextDecoration = [ctdNone]
        PreferDownStyles = True
        Options = [loDownIfMenu, loDownIfURL]
        Right = -100
      end
      object Label5: TdhLabel
        Left = 0
        Top = 19
        Height = 20
        Text = 'sub menu box'
        Style.Border.Color = 16758711
        Style.BorderBottom.Style = cbsSolid
        Style.BorderRight.Style = cbsSolid
        Style.BackgroundColor = 13303754
        AutoSizeXY = asY
        Align = alTop
        Right = 2147483647
      end
      object Label6: TdhLabel
        Left = 0
        Top = 39
        Height = 34
        Text = 'section'
        Style.FontSize = '28'
        Style.TextAlign = ctaCenter
        Style.Effects.Enabled = True
        Style.Effects.AntiAliasing = True
        Style.Effects.TextOnly = False
        Use = Link2
        AutoSizeXY = asY
        Align = alTop
        Right = -100
      end
      object Label15: TdhLabel
        Left = 0
        Top = 72
        Height = 19
        Text = 'news block'
        Style.TextAlign = ctaJustify
        AutoSizeXY = asY
        Align = alTop
        Right = 2147483647
      end
      object Label20: TdhLabel
        Left = 0
        Top = 91
        Height = 23
        Text = 'photo'
        Style.Border.Width = 2
        Style.Border.Color = 4210816
        Style.Border.Style = cbsSolid
        Style.BackgroundImage.Data = {
          0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000017800
          00000108020000005BA5224C000000214944415478DA6364F8CFC0C800028C0C
          0418442A1B356AD4A851A3468D426300009D9102009826D97C0000000049454E
          44AE426082}
        Style.BackgroundRepeat = cbrRepeatY
        Style.TextAlign = ctaCenter
        Style.BorderRadius.All = '26'
        AutoSizeXY = asY
        Align = alTop
        Right = 2147483647
      end
    end
    object PageControl1: TdhPageControl
      Left = 8
      Top = 28
      Width = 24
      Height = 24
      ActivePage = Page1
      FixedHeight = False
      object Page1: TdhPage
        Left = 0
        Top = 20
        Width = 784
        Height = 472
        AutoSizeXY = asNone
        UseIFrame = False
        object Panel3: TdhPanel
          Left = 0
          Top = 0
          Width = 128
          Height = 96
          Use = Label5
          AutoSizeXY = asNone
          object Label7: TdhLabel
            Left = 0
            Top = 32
            Width = 127
            Height = 34
            Text = 'Home'
            Use = Label6
            AutoSizeXY = asY
          end
        end
        object Label12: TdhLabel
          Left = 232
          Top = 40
          Width = 360
          Height = 380
          Text = 
            'In this template the alternative pages are organized by object <' +
            'b>PageControl1</b> and they are accessible by the top navigation' +
            ' bar.'#10'The pages for <i>News</i> and for <i>Photos</i> have subpa' +
            'ges organized by <b>PageControl2</b> and <b>PageControl3</b>. '#10'T' +
            'o demonstrate a variation, photos are shown in a HTML frame, whi' +
            'le news have own main pages.'#10'<br>'#10'<br>'#10'To e.g. add a new photo, ' +
            'select object <b>PageControl3</b> and choose <b>New Page</b> fro' +
            'm the context menu. Add a new link (per copy&paste) in the <i>Ph' +
            'otos</i> submenu and link it to the new created page (<b>Link</b' +
            '> tab -> <b>Link to page</b>). Now create content for the new pa' +
            'ge (e.g. copy&paste the photo caption and the photo itself from ' +
            'another photo page to the new page and then customize it).'#10'<br/>' +
            '<br/>'#10'The link for a page, which is activated, is styled as text' +
            '. This is done by setting the font color to black and unchecking' +
            ' the <b>Underline</b> style in the <b>Font</b> tab, but only for' +
            ' the <b>Down</b> state. '#10'This is only applied to object <b>Link2' +
            '</b> in the stylesheet. Other link objects refer to it by the <b' +
            '>Use</b> property.'
          Style.TextAlign = ctaJustify
          AutoSizeXY = asY
        end
      end
      object Page2: TdhPage
        Left = 0
        Top = 20
        Width = 784
        Height = 560
        AutoSizeXY = asNone
        UseIFrame = False
        object Panel4: TdhPanel
          Left = 0
          Top = 0
          Width = 128
          Height = 184
          Use = Label5
          AutoSizeXY = asNone
          object Label8: TdhLabel
            Left = 0
            Top = 32
            Width = 127
            Height = 33
            Text = 'News'
            Use = Label6
            AutoSizeXY = asY
          end
          object Link7: TdhLink
            Left = 32
            Top = 80
            Width = 49
            Height = 19
            Text = 'Item 1'
            Use = Link2
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page6
          end
          object Link8: TdhLink
            Left = 32
            Top = 104
            Width = 49
            Height = 19
            Text = 'Item 2'
            Use = Link2
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page7
          end
          object Link9: TdhLink
            Left = 32
            Top = 128
            Width = 49
            Height = 19
            Text = 'Item 3'
            Use = Link2
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page8
          end
        end
        object PageControl2: TdhPageControl
          Left = 168
          Top = 32
          Width = 24
          Height = 24
          ActivePage = Page6
          FixedHeight = False
          object Page6: TdhPage
            Left = 128
            Top = 0
            Width = 640
            Height = 528
            AutoSizeXY = asNone
            UseIFrame = False
            object Label13: TdhLabel
              Left = 240
              Top = 24
              Width = 169
              Height = 33
              Text = 'News Item 1'
              Use = Label6
              AutoSizeXY = asXY
            end
            object Label14: TdhLabel
              Left = 104
              Top = 104
              Width = 192
              Height = 361
              Text = 
                'quid hoc miramur de uerbo dei, cum sermo iste quem promimus ita ' +
                'liber sensibus influat, ut eum et recipiat, et non includat audi' +
                'tor?'#10'nam nisi reciperetur, neminem instrueret: si includeretur, ' +
                'ad alios non ueniret.'#10'<br/><br/>'#10' non cum ipsa uox in silentio c' +
                'ogitatur, quae uel Graecae est, uel Latinae, uel linguae alteriu' +
                's cuiuslibet: sed cum ante omnem linguarum diuersitatem res ipsa' +
                ' quae dicenda est, adhuc in cubili cordis quodam modo nuda est i' +
                'ntelligenti, quae ut inde procedat loquentis uoce uestitur.'
              Use = Label15
              AutoSizeXY = asY
            end
            object Label16: TdhLabel
              Left = 336
              Top = 104
              Width = 192
              Height = 228
              Text = 
                ' nec timemus dum loquimur, ne totum audiendo unus absumat, nec a' +
                'lter possit habere quod sumat:'#10'<br/><br/>'#10' nemo ergo credat dei ' +
                'filium conuersum et commutatum esse in hominis filium: sed potiu' +
                's credamus et non consumpta diuina et perfecte assumpta humana s' +
                'ubstantia, manentem dei filium, factum hominis filium.'
              Use = Label15
              AutoSizeXY = asY
            end
          end
          object Page7: TdhPage
            Left = 128
            Top = 0
            Width = 640
            Height = 528
            AutoSizeXY = asNone
            UseIFrame = False
            object Label17: TdhLabel
              Left = 240
              Top = 24
              Width = 176
              Height = 44
              Text = 'News Item 2'
              Use = Label6
              AutoSizeXY = asXY
            end
          end
          object Page8: TdhPage
            Left = 128
            Top = 0
            Width = 640
            Height = 528
            AutoSizeXY = asNone
            UseIFrame = False
            object Label18: TdhLabel
              Left = 240
              Top = 24
              Width = 176
              Height = 44
              Text = 'News Item 3'
              Use = Label6
              AutoSizeXY = asXY
            end
          end
        end
      end
      object Page3: TdhPage
        Left = 0
        Top = 20
        Width = 784
        Height = 472
        AutoSizeXY = asNone
        UseIFrame = False
        object Panel5: TdhPanel
          Left = 0
          Top = 0
          Width = 128
          Height = 96
          Use = Label5
          AutoSizeXY = asNone
          object Label9: TdhLabel
            Left = 0
            Top = 32
            Width = 127
            Height = 33
            Text = 'Links'
            Use = Label6
            AutoSizeXY = asY
          end
        end
      end
      object Page4: TdhPage
        Left = 0
        Top = 20
        Width = 784
        Height = 528
        AutoSizeXY = asNone
        UseIFrame = False
        object Panel6: TdhPanel
          Left = 0
          Top = 0
          Width = 128
          Height = 184
          Use = Label5
          AutoSizeXY = asNone
          object Label10: TdhLabel
            Left = 0
            Top = 32
            Width = 127
            Height = 33
            Text = 'Photos'
            Use = Label6
            AutoSizeXY = asY
          end
          object Link13: TdhLink
            Left = 32
            Top = 80
            Width = 63
            Height = 19
            Text = 'Photo 1'
            Use = Link2
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page10
          end
          object Link14: TdhLink
            Left = 32
            Top = 104
            Width = 63
            Height = 19
            Text = 'Photo 2'
            Use = Link2
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page11
          end
          object Link15: TdhLink
            Left = 32
            Top = 128
            Width = 63
            Height = 19
            Text = 'Photo 3'
            Use = Link2
            AutoSizeXY = asXY
            PreferDownStyles = True
            Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
            LinkPage = Page12
          end
        end
        object Page9: TdhPage
          Left = 128
          Top = 0
          Width = 616
          Height = 472
          AutoSizeXY = asNone
          UseIFrame = False
          object PageControl3: TdhPageControl
            Left = 40
            Top = 32
            Width = 24
            Height = 24
            ActivePage = Page10
            FixedHeight = False
            object Page10: TdhPage
              Left = 0
              Top = 0
              Width = 584
              Height = 464
              AutoSizeXY = asNone
              UseIFrame = False
              object Label19: TdhLabel
                Left = 248
                Top = 24
                Width = 106
                Height = 33
                Text = 'Photo 1'
                Use = Label6
                AutoSizeXY = asXY
              end
              object Label21: TdhLabel
                Left = 112
                Top = 128
                Width = 376
                Height = 320
                Use = Label20
                AutoSizeXY = asNone
              end
            end
            object Page11: TdhPage
              Left = 0
              Top = 0
              Width = 584
              Height = 464
              AutoSizeXY = asNone
              UseIFrame = False
              object Label22: TdhLabel
                Left = 248
                Top = 24
                Width = 110
                Height = 44
                Text = 'Photo 2'
                Use = Label6
                AutoSizeXY = asXY
              end
              object Label23: TdhLabel
                Left = 112
                Top = 128
                Width = 376
                Height = 320
                Style.BackgroundImage.Data = {
                  0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000000100
                  00013C08020000008EE44C19000001C24944415478DA2DC367580D000086D17B
                  6DB2B2B38AB23719194956F6267BA4A26C5219A1ECB2F7DE7B672B7B65342811
                  CA569451324BB7F7C7779EE7184D0683D164640ECDC95CCCCD3C9A97F9989F05
                  68A60559888559448BD29CC5585C4BB0244BB1B496A105CBB21CCB6B0556A425
                  ADB4122BD39A365A8555598DD5B5066BB2166BB38ED6653DD667036DC846B465
                  636DC2A66C463B6DCE166CC956B4D7D674601B3A6A5BB6637B76D08E74622776
                  D62EECCA6EECCE1EDA93BDD89B7DB42FFBB13F07A83307721007EB100EE5300E
                  E7081DC95174E16875A51BDD3946C7D2839E1CA7E3398113398993750AA7721A
                  BD743ABDE9435F9DC1999CC5D9EAC7399CCB79F4D700CEE7022ED4455CCC255C
                  AA810CE2322ED7155CC9555CCD35BA96EBB89E1B7423377133B7E8566EE376EE
                  D09DDCC5DDDCC3BDBA8FFB798007F5100FF3088FEA311EE7099ED4530CE6699E
                  E1593DC7F3BCC08B7A89210CE565BDC2ABBCC6EB7A8337798BB77947EF328CF7
                  785F1FF021C319A1918CE2233ED668C6F00963F9549F318ECFF9425F329E097C
                  A5AFF9866FF94EDFF3033F329149FA899F99CC14FDC2AFFCC6EF9ACA34FE60BA
                  FEE42FFEE61FFED57FCC6026FF6B164D866C3CE4D97275991547000000004945
                  4E44AE426082}
                Style.BackgroundRepeat = cbrRepeatX
                Use = Label20
                AutoSizeXY = asNone
              end
            end
            object Page12: TdhPage
              Left = 0
              Top = 0
              Width = 584
              Height = 464
              AutoSizeXY = asNone
              UseIFrame = False
              object Label24: TdhLabel
                Left = 248
                Top = 24
                Width = 110
                Height = 44
                Text = 'Photo 3'
                Use = Label6
                AutoSizeXY = asXY
              end
              object Label25: TdhLabel
                Left = 112
                Top = 128
                Width = 376
                Height = 320
                Style.BackgroundImage.Data = {
                  0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000017400
                  00000108020000004199C2C2000000214944415478DA6364F8CFC0F09F918101
                  4C6265E0971D553FAA7E54FDA87A6C0C0052210010D69C46A40000000049454E
                  44AE426082}
                Style.BackgroundRepeat = cbrRepeatY
                Use = Label20
                AutoSizeXY = asNone
              end
            end
          end
        end
      end
      object Page5: TdhPage
        Left = 0
        Top = 20
        Width = 784
        Height = 400
        AutoSizeXY = asNone
        UseIFrame = False
        object Panel2: TdhPanel
          Left = 0
          Top = 0
          Width = 128
          Height = 96
          Use = Label5
          AutoSizeXY = asNone
          object Label11: TdhLabel
            Left = 0
            Top = 32
            Width = 127
            Height = 33
            Text = 'Contact'
            Use = Label6
            AutoSizeXY = asY
          end
        end
      end
    end
    object Label26: TdhLabel
      Top = -74
      Width = 288
      Height = 45
      Text = 'Welcome to my<i><big><big> homepage</big></big></i>'
      Style.FontSize = '18'
      Style.Margin = '3'
      Style.Color = Red
      Style.FontWeight = cfwBold
      Style.ZIndex = 11
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.TextOnly = False
      AutoSizeXY = asXY
      Anchors = [akTop]
    end
  end
end
