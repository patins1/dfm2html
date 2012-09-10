object dhMultiLine: TdhMultiLine
  Left = 381
  Top = 76
  BorderIcons = [biSystemMenu]
  Caption = 'Multiline editor'
  ClientHeight = 274
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    430
    274)
  PixelsPerInch = 96
  TextHeight = 13
  object bOK: TButton
    Left = 266
    Top = 245
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object bCancel: TButton
    Left = 346
    Top = 245
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 413
    Height = 229
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 2
    OnKeyDown = MemoKeyDown
  end
end
