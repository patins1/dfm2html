object ObjectExplorer: TObjectExplorer
  Left = 908
  Top = 219
  BorderStyle = bsSizeToolWin
  Caption = 'Object Explorer'
  ClientHeight = 392
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object tree: TTreeView
    Left = 0
    Top = 0
    Width = 247
    Height = 392
    Align = alClient
    HideSelection = False
    Indent = 19
    ReadOnly = True
    TabOrder = 0
    OnChange = treeChange
    ExplicitWidth = 217
    ExplicitHeight = 297
  end
end
