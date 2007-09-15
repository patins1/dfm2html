object ChooseUnicode: TChooseUnicode
  Left = 278
  Top = 192
  ActiveControl = dhPage1
  BorderStyle = bsDialog
  Caption = 'Insert Character'
  ClientHeight = 362
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object IGNORE_Label3: TLabel
    Left = 208
    Top = 330
    Width = 14
    Height = 13
    Caption = '&x;'
    ShowAccelChar = False
  end
  object IGNORE_Label1: TLabel
    Left = 280
    Top = 330
    Width = 80
    Height = 13
    Caption = 'IGNORE_Label1'
    Visible = False
  end
  object dhPage1: TScrollBox
    Left = 0
    Top = 0
    Width = 538
    Height = 289
    VertScrollBar.Tracking = True
    Align = alTop
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 0
    object IGNORE_dhLabel1: TdhLabel
      Left = 0
      Top = 0
      Height = 50
      Text = 
        'dhLabel1 sdaf asdf asdf sdfasdfa sdfasdf sadf asd fs 2  345 4656' +
        '4 46 445645 646 45645 645 6'
      OnStateTransition = IGNORE_dhLabel1StateTransition
      Style.Padding = 2
      Style.FontSize = '20'
      Style.BackgroundColor = White
      Style.FontFamily = 'Arial'
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      OnClick = IGNORE_dhLabel1Click
      OnDblClick = IGNORE_dhLabel1Click
      OnMouseMove = IGNORE_dhLabel1MouseMove
    end
  end
  object Button1: TTntButton
    Left = 376
    Top = 332
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object IGNORE_dhLabel2: TdhLabel
    Left = 8
    Top = 297
    Width = 522
    Height = 24
    Text = 'IGNORE_dhLabel2'
    Style.FontSize = '20'
    Style.BackgroundColor = Lime
    AutoSizeXY = asY
  end
  object Button2: TTntButton
    Left = 456
    Top = 332
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object Button3: TTntButton
    Left = 8
    Top = 332
    Width = 89
    Height = 25
    Caption = 'Remove Last'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TTntButton
    Left = 104
    Top = 332
    Width = 89
    Height = 25
    Caption = 'Remove All'
    TabOrder = 5
    OnClick = Button4Click
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      'IGNORE_*')
    Left = 256
    Top = 176
    LangData = {
      0D0043686F6F7365556E69636F6465010100000001000000070043617074696F
      6E01090000000D0049474E4F52455F4C6162656C330000070064685061676531
      00000F0049474E4F52455F64684C6162656C3100000700427574746F6E310101
      00000007000000070043617074696F6E000F0049474E4F52455F64684C616265
      6C3200000700427574746F6E32010100000009000000070043617074696F6E00
      0700427574746F6E3301010000000A000000070043617074696F6E0007004275
      74746F6E3401010000000B000000070043617074696F6E000D0049474E4F5245
      5F4C6162656C310000}
  end
end
