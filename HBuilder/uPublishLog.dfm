object PublishLog: TPublishLog
  Left = 231
  Top = 131
  ActiveControl = RichEdit1
  Caption = 'Log'
  ClientHeight = 266
  ClientWidth = 416
  Color = clBtnFace
  Constraints.MinHeight = 100
  Constraints.MinWidth = 100
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object bStopTransfer: TTntSpeedButton
    Left = 325
    Top = 249
    Width = 81
    Height = 17
    Caption = 'Stop!'
    Visible = False
    OnClick = bStopTransferClick
  end
  object RichEdit1: TTntMemo
    Left = 0
    Top = 0
    Width = 416
    Height = 249
    Align = alTop
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object DKLanguageController1: TDKLanguageController
    Left = 200
    Top = 136
    LangData = {
      0A005075626C6973684C6F67010100000001000000070043617074696F6E0102
      0000000D006253746F705472616E736665720101000000020000000700436170
      74696F6E0009005269636845646974310000}
  end
end
