object FormWarnings: TFormWarnings
  Left = 132
  Top = 94
  AutoScroll = False
  Caption = 'Warnings'
  ClientHeight = 180
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  DesignSize = (
    469
    180)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TTntMemo
    Left = 0
    Top = 0
    Width = 469
    Height = 153
    Align = alTop
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Button1: TTntButton
    Left = 394
    Top = 155
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DKLanguageController1: TDKLanguageController
    Left = 224
    Top = 88
    LangData = {
      0C00466F726D5761726E696E6773010100000001000000070043617074696F6E
      010200000005004D656D6F3100000700427574746F6E31010100000003000000
      070043617074696F6E00}
  end
end
