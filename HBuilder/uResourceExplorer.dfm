object ResourceExplorer: TResourceExplorer
  Left = 0
  Top = 0
  Caption = 'Resource Explorer'
  ClientHeight = 342
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TTntMemo
    Left = 0
    Top = 0
    Width = 562
    Height = 325
    Align = alClient
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
  object cShowObjectNames: TTntCheckBox
    Left = 0
    Top = 325
    Width = 562
    Height = 17
    Align = alBottom
    Caption = 'Show object names'
    TabOrder = 1
    OnClick = cShowObjectNamesClick
  end
  object DKLanguageController1: TDKLanguageController
    Left = 8
    Top = 8
    LangData = {
      10005265736F757263654578706C6F7265720101000000010000000700436170
      74696F6E01020000000900526963684564697431000010006353686F774F626A
      6563744E616D6573010100000002000000070043617074696F6E00}
  end
end
