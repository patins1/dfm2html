object TransparencyWizard: TTransparencyWizard
  Left = 300
  Top = 130
  ActiveControl = spMasterAlpha
  Caption = 'Color Transparency Wizard'
  ClientHeight = 183
  ClientWidth = 289
  Color = clWhite
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
    Left = 16
    Top = 27
    Width = 105
    Height = 21
    Caption = 'Main Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Margin = 5
    ParentFont = False
    PopupMenu = ColorPicker.PopupMenu1
    OnColorChanged = FirstColorColorChanged
    OnPreviewColorChanged = FirstColorColorChanged
  end
  object Label5: TdhLabel
    Left = 20
    Top = 80
    Width = 39
    Height = 13
    Text = 'Opacity:'
    AutoSizeXY = asXY
  end
  object SampleGradient: TdhPanel
    Left = 184
    Top = 16
    Width = 88
    Height = 88
    Style.Border.Width = 1
    Style.Border.Color = Black
    Style.Border.Style = cbsDotted
    Style.BackgroundRepeat = cbrRepeatX
    AutoSizeXY = asNone
  end
  object Button1: TTntButton
    Left = 208
    Top = 152
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object spMasterAlpha: TMySpinEdit
    Left = 80
    Top = 72
    Width = 42
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 2
    Value = 255
    Alignment = taRightJustify
    ValueChange = spMasterAlphaValueChange
    TrackBar = slMasterAlpha
  end
  object slMasterAlpha: TMyTrackBar
    Left = 5
    Top = 112
    Width = 282
    Height = 33
    Max = 255
    PageSize = 25
    Frequency = 64
    Position = 255
    TabOrder = 3
    TabStop = False
    TickMarks = tmBottomRight
    TickStyle = tsAuto
  end
  object DKLanguageController1: TDKLanguageController
    Left = 136
    Top = 88
    LangData = {
      12005472616E73706172656E637957697A617264010100000001000000070043
      617074696F6E01060000000A004669727374436F6C6F72010100000002000000
      070043617074696F6E0006004C6162656C350101000000050000000400546578
      74000E0053616D706C654772616469656E7400000700427574746F6E31010100
      000004000000070043617074696F6E000D0073704D6173746572416C70686100
      000D00736C4D6173746572416C7068610000}
  end
end
