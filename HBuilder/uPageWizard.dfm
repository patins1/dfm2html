object PageWizard: TPageWizard
  Left = 391
  Top = 307
  Caption = 'Page Properties'
  ClientHeight = 287
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    418
    287)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TMyPageControl
    Left = 8
    Top = 8
    Width = 403
    Height = 238
    ActivePage = TabSheet3
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTntTabSheet
      Caption = 'General'
      DesignSize = (
        395
        210)
      object Label6: TdhLabel
        Left = 8
        Top = 16
        Width = 23
        Height = 13
        Text = 'Title:'
        AutoSizeXY = asXY
      end
      object eTitle: TTntEdit
        Left = 96
        Top = 8
        Width = 249
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 48
        Width = 385
        Height = 161
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        DesignSize = (
          385
          161)
        object Label7: TdhLabel
          Left = 8
          Top = 16
          Width = 74
          Height = 13
          Text = 'Local Directory:'
          AutoSizeXY = asXY
        end
        object Label8: TdhLabel
          Left = 96
          Top = 32
          Width = 159
          Height = 13
          Text = '(lokal output directory for preview)'
          Style.FontSize = '8'
          Style.Color = Gray
          AutoSizeXY = asXY
        end
        object Label9: TdhLabel
          Left = 8
          Top = 64
          Width = 68
          Height = 13
          Text = 'FTP Directory:'
          AutoSizeXY = asXY
        end
        object Label12: TdhLabel
          Left = 96
          Top = 80
          Width = 146
          Height = 13
          Text = '(remote directory for publishing)'
          Style.FontSize = '8'
          Style.Color = Gray
          AutoSizeXY = asXY
        end
        object Label15: TdhLabel
          Left = 8
          Top = 112
          Width = 57
          Height = 13
          Text = 'HTTP URL:'
          AutoSizeXY = asXY
        end
        object Label16: TdhLabel
          Left = 96
          Top = 128
          Width = 249
          Height = 13
          Text = '(can be opened by Publish | Browse Remote)'
          Style.FontSize = '8'
          Style.Color = Gray
          AutoSizeXY = asY
        end
        object eOutputDirectory: TTntEdit
          Left = 96
          Top = 8
          Width = 249
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object eRemote: TTntEdit
          Left = 96
          Top = 56
          Width = 249
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 1
        end
        object Button2: TTntButton
          Left = 352
          Top = 56
          Width = 25
          Height = 17
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 2
          OnClick = Button2Click
        end
        object Button32: TTntButton
          Left = 352
          Top = 8
          Width = 25
          Height = 17
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 3
          OnClick = Button32Click
        end
        object eHTTPURL: TTntEdit
          Left = 96
          Top = 104
          Width = 249
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          TabOrder = 4
        end
      end
    end
    object TabSheet2: TTntTabSheet
      Caption = 'Meta Tags'
      ImageIndex = 1
      DesignSize = (
        395
        210)
      object Label1: TdhLabel
        Left = 8
        Top = 16
        Width = 34
        Height = 13
        Text = 'Author:'
        AutoSizeXY = asXY
      end
      object Label2: TdhLabel
        Left = 8
        Top = 48
        Width = 49
        Height = 13
        Text = 'Keywords:'
        AutoSizeXY = asXY
      end
      object Label3: TdhLabel
        Left = 8
        Top = 80
        Width = 56
        Height = 13
        Text = 'Description:'
        AutoSizeXY = asXY
      end
      object eAuthor: TTntEdit
        Left = 96
        Top = 8
        Width = 281
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object eKeywords: TTntEdit
        Left = 96
        Top = 40
        Width = 281
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object eDescription: TTntEdit
        Left = 96
        Top = 72
        Width = 281
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
      object GroupBox1: TMyGroupBox
        Left = 8
        Top = 112
        Width = 378
        Height = 89
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Redirection'
        TabOrder = 6
        DesignSize = (
          378
          89)
        object Label11: TdhLabel
          Left = 70
          Top = 28
          Width = 25
          Height = 13
          Text = 'URL:'
          AutoSizeXY = asXY
        end
        object Label10: TdhLabel
          Left = 65
          Top = 60
          Width = 30
          Height = 13
          Text = 'Delay:'
          AutoSizeXY = asXY
        end
        object eForwardingDelay: TMySpinEdit
          Left = 104
          Top = 51
          Width = 48
          Height = 22
          MaxValue = 99999
          MinValue = 0
          TabOrder = 2
          Value = 0
          Alignment = taRightJustify
        end
        object eForwardingURL: TTntEdit
          Left = 104
          Top = 20
          Width = 233
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
        end
      end
    end
    object TabSheet3: TTntTabSheet
      Caption = 'Insert HTML'
      ImageIndex = 2
      DesignSize = (
        395
        210)
      object PageControlHTML: TTntPageControl
        Left = 8
        Top = 8
        Width = 378
        Height = 194
        ActivePage = TabSheetHTML3
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        object TabSheetHTML3: TTntTabSheet
          Caption = 'At the very top'
          DesignSize = (
            370
            166)
          object eTop: TSynMemo
            Left = 8
            Top = 8
            Width = 352
            Height = 149
            Anchors = [akLeft, akTop, akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            PopupMenu = dhMainForm.mEditorPopupMenu
            TabOrder = 0
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Courier New'
            Gutter.Font.Style = []
            Gutter.Width = 0
            Highlighter = SynHTMLSyn1
          end
        end
        object TabSheetHTML1: TTntTabSheet
          Caption = 'Before </HEAD>'
          DesignSize = (
            370
            166)
          object eHead: TSynMemo
            Left = 8
            Top = 8
            Width = 352
            Height = 149
            Anchors = [akLeft, akTop, akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            PopupMenu = dhMainForm.mEditorPopupMenu
            TabOrder = 0
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Courier New'
            Gutter.Font.Style = []
            Gutter.Width = 0
            Highlighter = SynHTMLSyn1
          end
        end
        object TabSheetHTML2: TTntTabSheet
          Caption = 'After <BODY>'
          DesignSize = (
            370
            166)
          object eBody: TSynMemo
            Left = 8
            Top = 8
            Width = 352
            Height = 149
            Anchors = [akLeft, akTop, akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            PopupMenu = dhMainForm.mEditorPopupMenu
            TabOrder = 0
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Courier New'
            Gutter.Font.Style = []
            Gutter.Width = 0
            Highlighter = SynHTMLSyn1
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Before </BODY>'
          ImageIndex = 3
          DesignSize = (
            370
            166)
          object eBodyClose: TSynMemo
            Left = 8
            Top = 8
            Width = 352
            Height = 149
            Anchors = [akLeft, akTop, akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            PopupMenu = dhMainForm.mEditorPopupMenu
            TabOrder = 0
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clWindowText
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Courier New'
            Gutter.Font.Style = []
            Gutter.Width = 0
            Highlighter = SynHTMLSyn1
          end
        end
      end
    end
    object TabSheet4: TTntTabSheet
      Caption = 'Paths'
      DesignSize = (
        395
        210)
      object dhLabel1: TdhLabel
        Left = 8
        Top = 72
        Width = 61
        Height = 13
        Text = 'Image folder:'
        AutoSizeXY = asXY
      end
      object eImageFolder: TTntEdit
        Left = 104
        Top = 64
        Width = 273
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        OnChange = eImageFolderChange
      end
      object dhLabel2: TdhLabel
        Left = 8
        Top = 118
        Width = 69
        Height = 13
        Text = 'JavaScript file:'
        AutoSizeXY = asXY
      end
      object eJavaScriptFile: TTntEdit
        Left = 104
        Top = 110
        Width = 273
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        OnChange = eJavaScriptFileChange
      end
      object dhLabel3: TdhLabel
        Left = 8
        Top = 16
        Width = 247
        Height = 13
        Text = 'You can define the names of generated files/folders:'
        AutoSizeXY = asXY
      end
      object dhLabel4: TdhLabel
        Left = 96
        Top = 87
        Width = 12
        Height = 13
        Text = '=>'
        AutoSizeXY = asXY
      end
      object dhLabel5: TdhLabel
        Left = 96
        Top = 133
        Width = 12
        Height = 13
        Text = '=>'
        AutoSizeXY = asXY
      end
      object dhLabel6: TdhLabel
        Left = 8
        Top = 160
        Width = 40
        Height = 13
        Text = 'CSS file:'
        AutoSizeXY = asXY
      end
      object eCSSFile: TTntEdit
        Left = 104
        Top = 160
        Width = 273
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 8
        OnChange = eCSSFileChange
      end
      object dhLabel7: TdhLabel
        Left = 96
        Top = 183
        Width = 12
        Height = 13
        Text = '=>'
        AutoSizeXY = asXY
      end
    end
  end
  object Button1: TTntButton
    Left = 252
    Top = 255
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TTntButton
    Left = 336
    Top = 255
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Left = 360
    Top = 304
  end
  object OpenDialog2: TOpenDialog
    Left = 368
    Top = 32
  end
  object DKLanguageController1: TDKLanguageController
    Left = 320
    Top = 8
    LangData = {
      0A005061676557697A617264010100000001000000070043617074696F6E0136
      0000000C0050616765436F6E74726F6C31000009005461625368656574310101
      00000002000000070043617074696F6E0006004C6162656C3601010000001900
      0000040054657874000600655469746C650000060050616E656C31000006004C
      6162656C3701010000001A0000000400546578740006004C6162656C38010100
      00001B0000000400546578740006004C6162656C3901010000001C0000000400
      546578740007004C6162656C313201010000001D000000040054657874000700
      4C6162656C313501010000001E0000000400546578740007004C6162656C3136
      01010000001F000000040054657874001000654F75747075744469726563746F
      7279000007006552656D6F746500000700427574746F6E320000080042757474
      6F6E333200000800654854545055524C00000900546162536865657432010100
      00000D000000070043617074696F6E0006004C6162656C310101000000200000
      000400546578740006004C6162656C3201010000002100000004005465787400
      06004C6162656C3301010000002200000004005465787400070065417574686F
      7200000900654B6579776F72647300000C00654465736372697074696F6E0000
      0900546162536865657433010100000013000000070043617074696F6E000700
      427574746F6E31010100000017000000070043617074696F6E000C0043616E63
      656C427574746F6E010100000018000000070043617074696F6E000B004F7065
      6E4469616C6F673100000B004F70656E4469616C6F67320000090047726F7570
      426F7831010100000028000000070043617074696F6E0007004C6162656C3131
      0101000000290000000400546578740007004C6162656C313001010000002A00
      000004005465787400100065466F7277617264696E6744656C617900000E0065
      466F7277617264696E6755524C00000F0050616765436F6E74726F6C48544D4C
      00000D00546162536865657448544D4C3101010000002B000000070043617074
      696F6E000D00546162536865657448544D4C3201010000002C00000007004361
      7074696F6E000D00546162536865657448544D4C3301010000002D0000000700
      43617074696F6E00050065486561640000050065426F64790000040065546F70
      0000090054616253686565743401010000002E000000070043617074696F6E00
      080064684C6162656C3101010000002F000000040054657874000C0065496D61
      6765466F6C6465720000080064684C6162656C32010100000030000000040054
      657874000F00654A61766153637269707446696C650000080064684C6162656C
      3301010000003100000004005465787400080064684C6162656C340000080064
      684C6162656C350000080064684C6162656C3601010000003200000004005465
      78740008006543535346696C650000080064684C6162656C3700000900546162
      536865657435010100000033000000070043617074696F6E000A0065426F6479
      436C6F736500000B0053796E48544D4C53796E310000}
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Left = 360
    Top = 8
  end
end
