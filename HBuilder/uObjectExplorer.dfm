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
    MultiSelect = True
    MultiSelectStyle = [msControlSelect, msShiftSelect]
    ReadOnly = True
    TabOrder = 0
    OnChange = treeChange
    OnMouseDown = treeMouseDown
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      'dhLink1.*')
    Left = 136
    Top = 40
    LangData = {
      0E004F626A6563744578706C6F72657201010000000100000007004361707469
      6F6E01010000000400747265650000}
  end
end
