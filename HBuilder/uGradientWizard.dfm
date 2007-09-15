object GradientWizard: TGradientWizard
  Left = 178
  Top = 103
  AutoScroll = False
  Caption = 'Gradient Wizard'
  ClientHeight = 155
  ClientWidth = 271
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object FirstColor: TdhColorPicker
    Left = 8
    Top = 75
    Width = 105
    Height = 21
    Caption = 'First Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Margin = 5
    ParentFont = False
    PopupMenu = ColorPicker.PopupMenu1
    OnColorChanged = FirstColorColorChanged
    Color = clRed
  end
  object SecondColor: TdhColorPicker
    Left = 8
    Top = 99
    Width = 105
    Height = 21
    Caption = 'Second Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Margin = 5
    ParentFont = False
    PopupMenu = ColorPicker.PopupMenu1
    OnColorChanged = FirstColorColorChanged
    Color = clRed
  end
  object lWidth: TdhLabel
    Left = 8
    Top = 136
    Width = 39
    Height = 13
    Text = 'Width:'
    AutoSizeXY = asY
  end
  object SampleGradient: TdhPanel
    Left = 176
    Top = 16
    Width = 88
    Height = 88
    Style.Border.Width = 1
    Style.Border.Color = Black
    Style.Border.Style = cbsDotted
    Style.BackgroundRepeat = cbrRepeatX
    AutoSizeXY = asNone
  end
  object rgDirection: TTntRadioGroup
    Left = 8
    Top = 8
    Width = 153
    Height = 57
    Caption = 'Direction'
    Items.Strings = (
      'From top to bottom'
      'From left to right')
    TabOrder = 1
    OnClick = rgDirectionClick
  end
  object Button1: TTntButton
    Left = 192
    Top = 126
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object spMasterAlpha: TMySpinEdit
    Left = 56
    Top = 128
    Width = 58
    Height = 22
    MaxValue = 1000000
    MinValue = 0
    TabOrder = 3
    Value = 0
    Alignment = taRightJustify
    ValueChange = spMasterAlphaValueChange
  end
  object dhLink1: TdhLink
    Left = 116
    Top = 75
    Width = 18
    Height = 45
    Text = '&#x21A8;'
    Style.PaddingLeft = 1
    Style.FontSize = '24'
    Style.FontFamily = 'Arial'
    Style.Color = WindowText
    Style.TextDecoration = [ctdNone]
    AutoSizeXY = asNone
    OnClick = dhLink1Click
    Layout = ltButton
    PreferDownStyles = True
    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
  end
  object lHeight: TdhLabel
    Left = 8
    Top = 136
    Width = 39
    Height = 13
    Text = 'Height:'
    AutoSizeXY = asY
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      'dhLink1.*')
    Left = 136
    Top = 40
    LangData = {
      0E004772616469656E7457697A61726401010000000100000007004361707469
      6F6E01090000000A004669727374436F6C6F7201010000000200000007004361
      7074696F6E000B005365636F6E64436F6C6F7201010000000300000007004361
      7074696F6E0006006C576964746801010000000B000000040054657874000E00
      53616D706C654772616469656E7400000B007267446972656374696F6E010200
      000005000000070043617074696F6E0D00000005004974656D73000700427574
      746F6E31010100000008000000070043617074696F6E000D0073704D61737465
      72416C7068610000070064684C696E6B31000007006C48656967687401010000
      000C00000004005465787400}
  end
end
