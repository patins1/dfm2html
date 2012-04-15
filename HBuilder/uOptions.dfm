object Options: TOptions
  Left = 225
  Top = 137
  Caption = 'Options'
  ClientHeight = 241
  ClientWidth = 364
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
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl11: TMyPageControl
    Left = 8
    Top = 8
    Width = 347
    Height = 193
    ActivePage = TabSheet5
    TabOrder = 0
    TabStop = False
    object TabSheet1: TTntTabSheet
      Caption = 'Grid'
      object Label2: TdhLabel
        Left = 8
        Top = 88
        Width = 32
        Height = 13
        Text = 'Grid Y:'
        AutoSizeXY = asXY
      end
      object Label3: TdhLabel
        Left = 8
        Top = 120
        Width = 59
        Height = 13
        Text = 'Grid Display:'
        AutoSizeXY = asXY
      end
      object Label6: TdhLabel
        Left = 8
        Top = 8
        Width = 242
        Height = 26
        Text = 
          'Objects are aligned to a grid when positioned. (Hold down the AL' +
          'T key to bypass grid-positioning.)'
        AutoSizeXY = asY
      end
      object Label1: TdhLabel
        Left = 8
        Top = 56
        Width = 32
        Height = 13
        Text = 'Grid X:'
        AutoSizeXY = asXY
      end
      object spGridX: TMySpinEdit
        Left = 80
        Top = 48
        Width = 48
        Height = 22
        MaxValue = 100
        MinValue = 1
        TabOrder = 0
        Value = 1
        Alignment = taRightJustify
        ValueChange = spGridXValueChange
      end
      object spGridY: TMySpinEdit
        Left = 80
        Top = 80
        Width = 48
        Height = 22
        MaxValue = 100
        MinValue = 1
        TabOrder = 1
        Value = 1
        Alignment = taRightJustify
        ValueChange = spGridXValueChange
      end
      object cbGridDisplay: TTntComboBox
        Left = 80
        Top = 112
        Width = 89
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = spGridXChange
        Items.Strings = (
          'None'
          'Dotted'
          'Checked'
          'Lined')
      end
    end
    object TabSheet2: TTntTabSheet
      Caption = 'Font'
      ImageIndex = 1
      object Label5: TdhLabel
        Left = 8
        Top = 8
        Width = 257
        Height = 39
        Text = 
          'Define a default font which is applied to new created documents.' +
          ' Objects defining their own font will overwrite this setting.'
        AutoSizeXY = asY
      end
      object Button2: TTntButton
        Left = 8
        Top = 72
        Width = 265
        Height = 25
        Caption = 'Choose default font..'
        TabOrder = 0
        OnClick = Button2Click
      end
      object bApplyFont: TTntButton
        Left = 8
        Top = 112
        Width = 265
        Height = 25
        Caption = 'Apply default font to current document'
        TabOrder = 1
        OnClick = bApplyFontClick
      end
    end
    object TabSheet3: TTntTabSheet
      Caption = 'Output'
      ImageIndex = 2
      object Label4: TdhLabel
        Left = 111
        Top = 8
        Width = 218
        Height = 39
        Text = 
          'If compression is enabled, superfluous whitespaces are cut from ' +
          'generated HTML files.'
        AutoSizeXY = asY
      end
      object Label7: TdhLabel
        Left = 8
        Top = 96
        Width = 297
        Height = 26
        Text = 
          'You can select a program which is invoked for a preview (if left' +
          ' blank, the default HTML viewer is started):'
        AutoSizeXY = asY
      end
      object cCompress: TTntCheckBox
        Left = 8
        Top = 3
        Width = 97
        Height = 17
        Caption = 'Compress'
        TabOrder = 0
        OnClick = eViewerChange
      end
      object Button3: TTntButton
        Left = 184
        Top = 128
        Width = 25
        Height = 17
        Caption = '...'
        TabOrder = 1
        OnClick = Button3Click
      end
      object eViewer: TTntComboBox
        Left = 8
        Top = 128
        Width = 169
        Height = 21
        TabOrder = 2
        OnChange = eViewerChange
        Items.Strings = (
          'iexplore'
          'firefox'
          'chrome')
      end
      object cCSS3: TTntCheckBox
        Left = 8
        Top = 56
        Width = 105
        Height = 17
        Caption = 'CSS3'
        TabOrder = 5
        OnClick = cCSS3Click
      end
      object lCSS3Warning: TdhLabel
        Left = 111
        Top = 53
        Width = 210
        Height = 26
        Text = 'Attention: Most browsers do not support CSS3 yet!'
        Style.Color = Red
        AutoSizeXY = asY
        Visible = False
      end
    end
    object TabSheet4: TTntTabSheet
      Caption = 'Publish'
      ImageIndex = 3
      object Label8: TdhLabel
        Left = 32
        Top = 32
        Width = 153
        Height = 13
        Text = '(only modified files are uploaded)'
        Style.FontSize = '8'
        Style.Color = Gray
        AutoSizeXY = asXY
      end
      object Label9: TdhLabel
        Left = 16
        Top = 136
        Width = 169
        Height = 13
        Text = '(often required behind a firewall)'
        Style.FontSize = '8'
        Style.Color = Gray
        AutoSizeXY = asY
      end
      object dhLabel2: TdhLabel
        Left = 11
        Top = 67
        Width = 267
        Height = 43
        Text = 'Upload Cache for FTP directory:'
        Use = STYLE_Label10
        AutoSizeXY = asNone
      end
      object cSmartPublishing: TTntCheckBox
        Left = 16
        Top = 16
        Width = 241
        Height = 17
        Caption = 'Use Smart Publishing'
        TabOrder = 0
        OnClick = cSmartPublishingClick
      end
      object cPassiveFTP: TTntCheckBox
        Left = 16
        Top = 120
        Width = 209
        Height = 17
        Caption = 'Use Passive FTP transfers'
        TabOrder = 1
        OnClick = eViewerChange
      end
      object bClearFocusedCache: TTntButton
        Left = 204
        Top = 72
        Width = 65
        Height = 16
        Caption = 'Clear'
        TabOrder = 3
        OnClick = bClearFocusedCacheClick
      end
      object dhLabel1: TdhLabel
        Left = 11
        Top = 43
        Width = 267
        Height = 27
        Text = 'Entire Upload Cache'
        Use = STYLE_Label10
        AutoSizeXY = asY
      end
      object dhStyleSheet1: TdhStyleSheet
        Left = 88
        Top = -8
        Width = 28
        Height = 28
        Expanded = False
        ExpandedWidth = 129
        ExpandedHeight = 100
        Expanded = False
        object STYLE_Label10: TdhLabel
          Left = 0
          Top = 0
          Height = 27
          Text = 'STYLE_Label10'
          Style.PaddingLeft = 4
          Style.PaddingTop = 2
          Style.PaddingBottom = 2
          Style.Margin = '5'
          Style.BackgroundColor = White
          Style.Effects.Enabled = True
          Style.Effects.AntiAliasing = False
          Style.Effects.Text = etInclude
          Style.Effects.OuterShadow.Enabled = True
          Style.Effects.OuterShadow.Alpha = 100
          Style.Effects.OuterShadow.Distance = 2
          Style.BorderRadius.All = '6'
          AutoSizeXY = asY
          Align = alTop
          Right = 12
        end
      end
      object cClearCache: TTntButton
        Left = 204
        Top = 48
        Width = 65
        Height = 17
        Caption = 'Clear'
        TabOrder = 2
        OnClick = cClearCacheClick
      end
      object lDirectoryCache: TdhLabel
        Left = 24
        Top = 88
        Width = 75
        Height = 13
        Text = 'lDirectoryCache'
        AutoSizeXY = asXY
      end
    end
    object TabSheet5: TTntTabSheet
      Caption = 'Appearance'
      ImageIndex = 4
      object RadioGroup1: TTntRadioGroup
        Left = 6
        Top = 8
        Width = 161
        Height = 145
        Caption = 'Position of Tabs'
        Items.Strings = (
          'Top'
          'Bottom'
          'Left'
          'Right'
          'Floating Horizontal'
          'Floating Vertical')
        TabOrder = 0
        OnClick = RadioGroup1Click
      end
      object gStartUpAction: TTntRadioGroup
        Left = 173
        Top = 8
        Width = 161
        Height = 82
        Caption = 'Action at Program Start-Up'
        Items.Strings = (
          'Show Selection Window'
          'Open Last Recently File'
          'No Action')
        TabOrder = 1
        OnClick = RadioGroup1Click
      end
    end
    object TabSheet6: TTntTabSheet
      Caption = 'Misc'
      object cAutoUpdate: TTntCheckBox
        Left = 16
        Top = 16
        Width = 241
        Height = 17
        Caption = 'Monthly check for updates'
        TabOrder = 0
        OnClick = cSmartPublishingClick
      end
      object spUndoLimit: TMySpinEdit
        Left = 16
        Top = 96
        Width = 65
        Height = 22
        MaxValue = 999999
        MinValue = 0
        TabOrder = 1
        Value = 1
        Alignment = taRightJustify
        ValueChange = spGridXValueChange
      end
      object Label10: TdhLabel
        Left = 16
        Top = 77
        Width = 49
        Height = 13
        Text = 'Undo limit:'
        AutoSizeXY = asXY
      end
    end
  end
  object Button1: TTntButton
    Left = 280
    Top = 210
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    Default = True
    ModalResult = 2
    TabOrder = 1
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 68
    Top = 210
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'dfm'
    Filter = 'Executable|*.EXE'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 640
    Top = 80
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      'eViewer.*'
      'lDirectoryCache.*'
      'OpenDialog1.DefaultExt'
      'STYLE_*')
    Left = 32
    Top = 208
    LangData = {
      07004F7074696F6E73010100000001000000070043617074696F6E012B000000
      0D0050616765436F6E74726F6C31310000090054616253686565743101010000
      0002000000070043617074696F6E0006004C6162656C31010100000021000000
      0400546578740006004C6162656C320101000000220000000400546578740006
      004C6162656C330101000000230000000400546578740006004C6162656C3601
      0100000024000000040054657874000700737047726964580000070073704772
      69645900000D00636247726964446973706C6179010100000007000000050049
      74656D7300090054616253686565743201010000000800000007004361707469
      6F6E0006004C6162656C35010100000025000000040054657874000700427574
      746F6E3201010000000A000000070043617074696F6E000A00624170706C7946
      6F6E7401010000000B000000070043617074696F6E0009005461625368656574
      3301010000000C000000070043617074696F6E0006004C6162656C3401010000
      00260000000400546578740006004C6162656C37010100000027000000040054
      65787400090063436F6D707265737301010000000F000000070043617074696F
      6E000700427574746F6E33000007006556696577657200000900546162536865
      657434010100000011000000070043617074696F6E0006004C6162656C380101
      000000280000000400546578740006004C6162656C3901010000002900000004
      005465787400080064684C6162656C3201010000001400000004005465787400
      100063536D6172745075626C697368696E670101000000150000000700436170
      74696F6E000B0063506173736976654654500101000000160000000700436170
      74696F6E00120062436C656172466F6375736564436163686501010000001700
      0000070043617074696F6E00080064684C6162656C3101010000001800000004
      0054657874000D0064685374796C6553686565743100000D005354594C455F4C
      6162656C313000000B0063436C656172436163686501010000001A0000000700
      43617074696F6E00090054616253686565743501010000001B00000007004361
      7074696F6E000B00526164696F47726F75703101020000001C00000007004361
      7074696F6E1D00000005004974656D73000700427574746F6E3101010000001E
      000000070043617074696F6E000B00466F6E744469616C6F673100000B004F70
      656E4469616C6F6731010100000020000000060046696C746572000F006C4469
      726563746F727943616368650000090054616253686565743601010000002A00
      0000070043617074696F6E000B00634175746F55706461746501010000002B00
      0000070043617074696F6E000E006753746172745570416374696F6E01020000
      002C000000070043617074696F6E2D00000005004974656D7300050063435353
      3301010000002E000000070043617074696F6E000C006C435353335761726E69
      6E6701010000002F000000040054657874000B007370556E646F4C696D697400
      0007004C6162656C313001010000003000000004005465787400}
  end
end
