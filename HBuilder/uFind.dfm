object FindText: TFindText
  Left = 496
  Top = 359
  AutoScroll = False
  Caption = 'Find Text'
  ClientHeight = 238
  ClientWidth = 447
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
  object Label1: TdhLabel
    Left = 16
    Top = 20
    Width = 56
    Height = 13
    Text = 'Text to find:'
    AutoSizeXY = asXY
  end
  object gKind: TTntRadioGroup
    Left = 232
    Top = 120
    Width = 201
    Height = 65
    Caption = 'Search in'
    ItemIndex = 0
    Items.Strings = (
      'Entered text'
      'Displayed text')
    TabOrder = 0
  end
  object Button1: TTntButton
    Left = 280
    Top = 200
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TTntButton
    Left = 360
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object eFind: TTntComboBox
    Left = 112
    Top = 16
    Width = 321
    Height = 21
    ItemHeight = 13
    TabOrder = 3
  end
  object gOrigin: TTntRadioGroup
    Left = 16
    Top = 120
    Width = 201
    Height = 65
    Caption = 'Origin'
    ItemIndex = 1
    Items.Strings = (
      'From selected object'
      'Entire scope')
    TabOrder = 4
  end
  object gDirection: TTntRadioGroup
    Left = 232
    Top = 48
    Width = 201
    Height = 65
    Caption = 'Direction'
    ItemIndex = 0
    Items.Strings = (
      'Forward'
      'Backward')
    TabOrder = 5
  end
  object GroupBox1: TTntGroupBox
    Left = 16
    Top = 48
    Width = 201
    Height = 65
    Caption = 'Options'
    TabOrder = 6
    object cCaseSensitive: TTntCheckBox
      Left = 8
      Top = 16
      Width = 185
      Height = 17
      Caption = 'Case sensitive'
      TabOrder = 0
    end
    object cHidden: TTntCheckBox
      Left = 8
      Top = 40
      Width = 185
      Height = 17
      Caption = 'Include hidden content'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object DKLanguageController1: TDKLanguageController
    Left = 200
    Top = 208
    LangData = {
      080046696E6454657874010100000001000000070043617074696F6E010A0000
      0006004C6162656C31010100000002000000040054657874000500674B696E64
      010200000003000000070043617074696F6E0400000005004974656D73000700
      427574746F6E31010100000005000000070043617074696F6E00070042757474
      6F6E32010100000006000000070043617074696F6E0005006546696E64000007
      00674F726967696E010200000007000000070043617074696F6E080000000500
      4974656D73000A0067446972656374696F6E0102000000090000000700436170
      74696F6E0A00000005004974656D7300090047726F7570426F78310101000000
      0B000000070043617074696F6E000E00634361736553656E7369746976650101
      0000000C000000070043617074696F6E0007006348696464656E01010000000D
      000000070043617074696F6E00}
  end
end
