object Presets: TPresets
  Left = 502
  Top = 98
  ActiveControl = dhPanel2
  BorderIcons = [biSystemMenu]
  Caption = 'Presets'
  ClientHeight = 319
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 14
  object dhStyleSheet1: TdhStyleSheet
    Left = 40
    Top = 40
    Width = 28
    Height = 28
    Expanded = False
    ExpandedWidth = 100
    ExpandedHeight = 100
    Expanded = False
    object STYLE_Link1: TdhLink
      Left = 0
      Top = 0
      Height = 22
      Text = 'STYLE_Link1'
      Style.Border.Width = 2
      Style.Border.Color = Aqua
      Style.Border.Style = cbsOutset
      Style.Padding = 2
      Style.BackgroundColor = 12639424
      Style.BorderRadius.All = '5'
      AutoSizeXY = asXY
      Align = alTop
      Right = 18
      StyleDown.Border.Style = cbsInset
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
  end
  object dhPanel1: TdhPanel
    Left = 0
    Top = 5290
    AutoSizeXY = asNone
    Align = alClient
    Right = 0
    Bottom = -37632
    object dhPageControl1: TdhPageControl
      Left = 8
      Top = 16
      Width = 24
      Height = 24
      FixedHeight = False
    end
  end
  object dhPanel2: TdhPage
    Left = 0
    Top = 0
    Height = 5290
    Style.BackgroundColor = Silver
    AutoSizeXY = asXY
    Align = alTop
    Right = 0
    UseIFrame = False
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 32
    Top = 120
    object mInsertObject: TMenuItem
      Caption = 'Insert'
      OnClick = mInsertObjectClick
    end
    object mGetStylesOnly: TMenuItem
      Caption = 'Copy Styles'
      OnClick = mGetStylesOnlyClick
    end
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      'STYLE_*')
    Left = 112
    Top = 160
    LangData = {
      070050726573657473010100000001000000070043617074696F6E0108000000
      0D0064685374796C6553686565743100000B005354594C455F4C696E6B310000
      0800646850616E656C3100000E00646850616765436F6E74726F6C3100000800
      646850616E656C3200000A00506F7075704D656E753100000D006D496E736572
      744F626A656374010100000002000000070043617074696F6E000E006D476574
      5374796C65734F6E6C79010100000003000000070043617074696F6E00}
  end
end
