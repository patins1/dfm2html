object PageWizard: TPageWizard
  Left = 205
  Top = 145
  AutoScroll = False
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
    ActivePage = TabSheet2
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 0
    object TabSheet1: TTntTabSheet
      Caption = 'General'
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
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 48
        Width = 385
        Height = 161
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
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
          TabOrder = 0
        end
        object eRemote: TTntEdit
          Left = 96
          Top = 56
          Width = 249
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 1
        end
        object Button2: TTntButton
          Left = 352
          Top = 56
          Width = 25
          Height = 17
          Caption = '...'
          TabOrder = 2
          OnClick = Button2Click
        end
        object Button32: TTntButton
          Left = 352
          Top = 8
          Width = 25
          Height = 17
          Caption = '...'
          TabOrder = 3
          OnClick = Button32Click
        end
        object eHTTPURL: TTntEdit
          Left = 96
          Top = 104
          Width = 249
          Height = 21
          Color = clWhite
          TabOrder = 4
        end
      end
    end
    object TabSheet2: TTntTabSheet
      Caption = 'Meta Tags'
      ImageIndex = 1
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
        TabOrder = 0
      end
      object eKeywords: TTntEdit
        Left = 96
        Top = 40
        Width = 281
        Height = 21
        TabOrder = 1
      end
      object eDescription: TTntEdit
        Left = 96
        Top = 72
        Width = 281
        Height = 21
        TabOrder = 2
      end
      object TntGroupBox1: TMyGroupBox
        Left = 8
        Top = 112
        Width = 378
        Height = 89
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
          Top = 60
          Width = 30
          Height = 13
          Text = 'Delay:'
          AutoSizeXY = asXY
          Anchors = [akTop, akRight]
          Right = 283
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
          TabOrder = 3
        end
      end
    end
    object TabSheet3: TTntTabSheet
      Caption = 'Insert HTML'
      ImageIndex = 2
      object TntPageControl1: TTntPageControl
        Left = 8
        Top = 8
        Width = 378
        Height = 194
        ActivePage = TntTabSheet1
        TabOrder = 0
        object TntTabSheet1: TTntTabSheet
          Caption = 'Before </HEAD>'
          object eHead: TTntMemo
            Left = 8
            Top = 8
            Width = 352
            Height = 149
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object TntTabSheet2: TTntTabSheet
          Caption = 'After <BODY>'
          object eBody: TTntMemo
            Left = 8
            Top = 8
            Width = 352
            Height = 149
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object TntTabSheet3: TTntTabSheet
          Caption = 'At the very top'
          object eTop: TTntMemo
            Left = 8
            Top = 8
            Width = 352
            Height = 149
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
    end
  end
  object Button1: TTntButton
    Left = 252
    Top = 255
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
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
    Anchors = [akLeft, akBottom]
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
      0A005061676557697A617264010100000001000000070043617074696F6E0128
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
      6E4469616C6F673100000B004F70656E4469616C6F673200000C00546E744772
      6F7570426F7831010100000028000000070043617074696F6E0007004C616265
      6C31310101000000290000000400546578740007004C6162656C313001010000
      002A00000004005465787400100065466F7277617264696E6744656C61790000
      0E0065466F7277617264696E6755524C00000F00546E7450616765436F6E7472
      6F6C3100000C00546E7454616253686565743101010000002B00000007004361
      7074696F6E000C00546E7454616253686565743201010000002C000000070043
      617074696F6E000C00546E7454616253686565743301010000002D0000000700
      43617074696F6E00050065486561640000050065426F64790000040065546F70
      0000}
  end
end