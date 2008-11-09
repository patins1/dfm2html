object MoreMisc: TMoreMisc
  Left = 156
  Top = 144
  Caption = 'Special Styles'
  ClientHeight = 288
  ClientWidth = 241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    241
    288)
  PixelsPerInch = 96
  TextHeight = 13
  object Label16: TdhLabel
    Left = 8
    Top = 16
    Width = 51
    Height = 13
    Text = 'line-height:'
    AutoSizeXY = asXY
  end
  object Label33: TdhLabel
    Left = 152
    Top = 216
    Width = 53
    Height = 13
    Text = 'text before:'
    AutoSizeXY = asXY
    Visible = False
  end
  object Label28: TdhLabel
    Left = 184
    Top = 208
    Width = 44
    Height = 13
    Text = 'text after:'
    AutoSizeXY = asXY
    Visible = False
  end
  object Label32: TdhLabel
    Left = 8
    Top = 64
    Width = 121
    Height = 13
    Text = 'additional CSS properties:'
    AutoSizeXY = asXY
  end
  object Label1: TdhLabel
    Left = 128
    Top = 16
    Width = 38
    Height = 13
    Text = 'visibility:'
    AutoSizeXY = asXY
  end
  object Label2: TdhLabel
    Left = 8
    Top = 112
    Width = 127
    Height = 13
    Text = 'additional HTML attributes:'
    AutoSizeXY = asXY
  end
  object Button1: TTntButton
    Left = 80
    Top = 255
    Width = 65
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 1
  end
  object CODE_cbLineHeight: ThComboBox
    Left = 8
    Top = 32
    Width = 105
    Height = 21
    DropDownCount = 10
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      'normal'
      '20px'
      '50%'
      '150%')
    ValueChange = CODE_cbLineHeightValueChange
    ChangeReason = 'Change Line-Height'
  end
  object eBefore: ThEdit
    Left = 168
    Top = 184
    Width = 305
    Height = 21
    TabOrder = 2
    Visible = False
    ValueChange = eBeforeValueChange
    ChangeReason = 'Change Text-Before'
  end
  object eAfter: ThEdit
    Left = 168
    Top = 160
    Width = 305
    Height = 21
    TabOrder = 3
    Visible = False
    ValueChange = eAfterValueChange
    ChangeReason = 'Change Text After'
  end
  object eOther: ThEdit
    Left = 8
    Top = 80
    Width = 225
    Height = 21
    TabOrder = 4
    ValueChange = eOtherValueChange
    LateChange = True
    ChangeReason = 'Change Custom CSS'
  end
  object cbVisibility: ThComboBox
    Left = 128
    Top = 32
    Width = 105
    Height = 21
    Style = csDropDownList
    DropDownCount = 10
    ItemHeight = 13
    TabOrder = 5
    Items.Strings = (
      '*CLEAR VALUE*'
      'hidden'
      'visible')
    ValueChange = cbVisibilityValueChange
    ChangeReason = 'Change Visibility'
  end
  object bClearMore: TTntButton
    Left = 8
    Top = 255
    Width = 65
    Height = 25
    Anchors = [akBottom]
    Caption = 'Reset'
    TabOrder = 6
    OnClick = bClearMoreClick
  end
  object CODE_eHTMLAttributes: ThComboBox
    Left = 8
    Top = 128
    Width = 225
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    Items.Strings = (
      'onclick="javascript:alert('#39'hi'#39')"'
      'onfocus="this.value='#39#39';"')
    ValueChange = CODE_eHTMLAttributesValueChange
    ChangeReason = 'Change Custom Attributes'
  end
  object cbDisplay: ThComboBox
    Left = 8
    Top = 176
    Width = 145
    Height = 21
    Style = csDropDownList
    DropDownCount = 10
    ItemHeight = 13
    TabOrder = 14
    Items.Strings = (
      '*CLEAR VALUE*'
      'inline'
      'block'
      'list-item'
      'none')
    ValueChange = cbDisplayValueChange
    ChangeReason = 'Change Display'
  end
  object dhLabel1: TdhLabel
    Left = 8
    Top = 160
    Width = 35
    Height = 13
    Text = 'display:'
    AutoSizeXY = asXY
  end
  object dhLabel2: TdhLabel
    Left = 8
    Top = 208
    Width = 66
    Height = 13
    Text = 'letter-spacing:'
    AutoSizeXY = asXY
  end
  object CODE_cbLetterSpacing: ThComboBox
    Left = 8
    Top = 224
    Width = 105
    Height = 21
    DropDownCount = 10
    ItemHeight = 13
    TabOrder = 17
    Items.Strings = (
      'normal'
      '1px'
      '3px'
      '5px'
      '7px'
      '0.1em'
      '0.3em'
      '0.5em'
      '0.7em')
    ValueChange = CODE_cbLetterSpacingValueChange
    ChangeReason = 'Change Letter-Spacing'
  end
  object CODE_cbWordSpacing: ThComboBox
    Left = 128
    Top = 224
    Width = 105
    Height = 21
    DropDownCount = 10
    ItemHeight = 13
    TabOrder = 18
    Items.Strings = (
      'normal'
      '8px'
      '13px'
      '20px'
      '32px'
      '0.5em'
      '1em'
      '1.5em'
      '2em')
    ValueChange = CODE_cbWordSpacingValueChange
    ChangeReason = 'Change Word-Spacing'
  end
  object dhLabel3: TdhLabel
    Left = 128
    Top = 208
    Width = 66
    Height = 13
    Text = 'word-spacing:'
    AutoSizeXY = asXY
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      '*.ChangeReason'
      'CODE_*')
    Left = 112
    Top = 112
    LangData = {
      08004D6F72654D697363010100000001000000070043617074696F6E01140000
      0007004C6162656C31360101000000130000000400546578740007004C616265
      6C33330101000000140000000400546578740007004C6162656C323801010000
      00150000000400546578740007004C6162656C33320101000000160000000400
      546578740006004C6162656C310101000000170000000400546578740006004C
      6162656C32010100000018000000040054657874000700427574746F6E310101
      00000008000000070043617074696F6E001100434F44455F63624C696E654865
      6967687400000700654265666F72650000060065416674657200000600654F74
      68657200000C0063625669736962696C69747901010000001A00000005004974
      656D73000A0062436C6561724D6F726501010000001000000007004361707469
      6F6E001400434F44455F6548544D4C4174747269627574657300000900636244
      6973706C617901010000001B00000005004974656D7300080064684C6162656C
      3101010000001C00000004005465787400080064684C6162656C320101000000
      1D000000040054657874001400434F44455F63624C657474657253706163696E
      6700001200434F44455F6362576F726453706163696E670000080064684C6162
      656C3301010000001E00000004005465787400}
  end
end
