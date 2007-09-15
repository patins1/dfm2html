object StartUp: TStartUp
  Left = 122
  Top = 82
  Width = 312
  Height = 283
  Caption = 'Start Up'
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object dhStyleSheet1: TdhStyleSheet
    Left = 0
    Top = 0
    Width = 28
    Height = 28
    Expanded = False
    ExpandedWidth = 100
    ExpandedHeight = 100
    Expanded = False
    object STYLE_Link1: TdhLink
      Left = 0
      Top = 0
      Height = 45
      Text = 'STYLE_Link1'
      Style.Padding = 12
      Style.FontSize = '18'
      Style.TextAlign = ctaCenter
      Style.FontFamily = 'Arial'
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.Text = etInclude
      AutoSizeXY = asXY
      Align = alTop
      Right = 2
      StyleOver.Border.Width = 10
      StyleOver.Border.Color = Yellow
      StyleOver.Border.Style = cbsSolid
      StyleOver.BorderLeft.Width = 0
      StyleOver.BorderRight.Width = 0
      StyleOver.Padding = 2
      StyleOver.BorderRadius.All = '20'
      Layout = ltText
      PreferDownStyles = False
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
  end
  object dhLink1: TdhLink
    Left = 8
    Top = 8
    Width = 296
    Height = 45
    Text = 'Open Last Recently File'
    Use = STYLE_Link1
    AutoSizeXY = asY
    OnClick = dhLink1Click
    PreferDownStyles = False
    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
  end
  object cTemplate: TdhLink
    Left = 8
    Top = 104
    Width = 296
    Height = 45
    Text = 'New From Template'
    Use = STYLE_Link1
    AutoSizeXY = asY
    OnClick = cTemplateClick
    PreferDownStyles = False
    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
  end
  object dhLink3: TdhLink
    Left = 8
    Top = 152
    Width = 296
    Height = 45
    Text = 'Read Tutorial'
    Use = STYLE_Link1
    AutoSizeXY = asY
    OnClick = dhLink3Click
    PreferDownStyles = False
    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
  end
  object dhLink4: TdhLink
    Left = 8
    Top = 56
    Width = 296
    Height = 45
    Text = 'Open Empty Page'
    Use = STYLE_Link1
    AutoSizeXY = asY
    OnClick = dhLink4Click
    PreferDownStyles = False
    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
  end
  object dhLink2: TdhLink
    Left = 8
    Top = 200
    Width = 296
    Height = 45
    Text = 'Guide'
    Use = STYLE_Link1
    AutoSizeXY = asY
    OnClick = dhLink2Click
    PreferDownStyles = False
    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      'STYLE_*')
    Left = 144
    Top = 128
    LangData = {
      070053746172745570010100000001000000070043617074696F6E0107000000
      0D0064685374796C6553686565743100000B005354594C455F4C696E6B310000
      070064684C696E6B310101000000040000000400546578740009006354656D70
      6C61746501010000000500000004005465787400070064684C696E6B33010100
      00000600000004005465787400070064684C696E6B3401010000000700000004
      005465787400070064684C696E6B3201010000000800000004005465787400}
  end
end
