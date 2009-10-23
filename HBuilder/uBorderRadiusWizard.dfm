object BorderRadiusWizard: TBorderRadiusWizard
  Left = 158
  Top = 112
  Caption = 'Border Radius'
  ClientHeight = 298
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object STYLE_dhStyleSheet1: TdhStyleSheet
    Left = 176
    Top = 16
    Width = 28
    Height = 28
    Expanded = False
    VertPosition = 49
    ExpandedWidth = 129
    ExpandedHeight = 100
    Expanded = False
    object STYLE_Link1: TdhLink
      Left = 0
      Top = -49
      Height = 18
      Text = 'STYLE_Link1'
      Style.Border.Width = 1
      Style.Border.Color = White
      Style.Border.Style = cbsSolid
      Style.BorderBottom.Color = Black
      Style.BorderRight.Color = Black
      Style.PaddingLeft = 2
      Style.PaddingTop = 1
      Style.PaddingRight = 2
      Style.PaddingBottom = 2
      Style.FontSize = '11'
      Style.BackgroundColor = 13160660
      Style.TextAlign = ctaCenter
      AutoSizeXY = asXY
      Align = alTop
      Right = 0
      StyleDown.BorderTop.Color = Black
      StyleDown.BorderBottom.Color = White
      StyleDown.BorderLeft.Color = Black
      StyleDown.BorderRight.Color = White
      StyleDown.PaddingLeft = 3
      StyleDown.PaddingTop = 2
      StyleDown.PaddingRight = 1
      StyleDown.PaddingBottom = 1
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object STYLE_nob: TdhLabel
      Left = 0
      Top = -31
      Height = 13
      Text = 'STYLE_nob'
      Style.FontWeight = cfwNormal
      Use = STYLE_Label4
      AutoSizeXY = asY
      Align = alTop
      Right = 0
    end
    object STYLE_Label4: TdhLabel
      Left = 0
      Top = -18
      Height = 13
      Text = 'STYLE_Label4'
      Style.FontWeight = cfwBold
      AutoSizeXY = asY
      Align = alTop
      Right = 0
    end
    object STYLE_Label3: TdhLabel
      Left = 0
      Top = -5
      Height = 24
      Text = 'STYLE_Label3'
      Style.PaddingTop = 11
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
    end
    object STYLE_Label5: TdhLabel
      Left = 0
      Top = 19
      Height = 29
      Text = 'STYLE_Label5'
      Style.PaddingTop = 16
      Style.Display = cdsBlock
      AutoSizeXY = asY
      Align = alTop
      Right = 0
    end
    object STYLE_Link2: TdhLink
      Left = 0
      Top = 48
      Height = 24
      Text = 'STYLE_Link2'
      ImageType = bitTile
      Style.Border.Color = 5197647
      Style.Border.Style = cbsSolid
      Style.Margin = '0'
      Style.BackgroundColor = 9868950
      Style.TextAlign = ctaCenter
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      Style.Effects.Alpha = 100
      Style.BorderRadius.All = '0'
      AutoSizeXY = asNone
      Align = alTop
      Right = 0
      StyleDown.ZIndex = 1
      StyleDown.Effects.Enabled = True
      StyleDown.Effects.AntiAliasing = False
      StyleDown.Effects.Text = etInclude
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
  end
  object CornerNavigation: TdhPanel
    Left = 0
    Top = 0
    Width = 164
    Height = 153
    AutoSizeXY = asNone
    object cBottomLeft: TdhLink
      Left = 16
      Top = 74
      Width = 59
      Height = 59
      Text = 
        '<STYLE_Label5><STYLE_nob>&nbsp;&nbsp;</STYLE_nob>Bottom<STYLE_no' +
        'b>&nbsp;&nbsp;</STYLE_nob></STYLE_Label5><STYLE_nob>&nbsp;&nbsp;' +
        '&nbsp;&nbsp;&nbsp;</STYLE_nob>Left'
      OnStateTransition = cBottomRightStateTransition
      Style.BorderRadius.BottomLeft = '100'
      Use = STYLE_Link2
      AutoSizeXY = asNone
      OnClick = cAllClick
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object cTopLeft: TdhLink
      Left = 16
      Top = 16
      Width = 59
      Height = 59
      Text = 
        '<br><STYLE_nob>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<' +
        '/STYLE_nob>Top<br><STYLE_nob>&nbsp;</STYLE_nob>Left'
      OnStateTransition = cBottomRightStateTransition
      Style.BorderRadius.TopLeft = '100'
      Use = STYLE_Link2
      AutoSizeXY = asNone
      OnClick = cAllClick
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object cTopRight: TdhLink
      Left = 74
      Top = 16
      Width = 59
      Height = 59
      Text = 
        '<br>Top<STYLE_nob>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</STYLE_no' +
        'b><br><STYLE_nob>&nbsp;</STYLE_nob>Right'
      OnStateTransition = cBottomRightStateTransition
      Style.BorderRadius.TopRight = '100'
      Use = STYLE_Link2
      AutoSizeXY = asNone
      OnClick = cAllClick
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object cBottomRight: TdhLink
      Left = 74
      Top = 74
      Width = 59
      Height = 59
      Text = 
        '<STYLE_Label5><STYLE_nob></STYLE_nob>Bottom<STYLE_nob>&nbsp;</ST' +
        'YLE_nob></STYLE_Label5>Right<STYLE_nob>&nbsp;&nbsp;&nbsp;&nbsp;&' +
        'nbsp;</STYLE_nob>'
      OnStateTransition = cBottomRightStateTransition
      Style.BorderRadius.BottomRight = '100'
      Use = STYLE_Link2
      AutoSizeXY = asNone
      OnClick = cAllClick
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
    object cAll: TdhLink
      Left = 53
      Top = 53
      Width = 43
      Height = 43
      Text = '<STYLE_Label3>All</STYLE_Label3>'
      Style.PaddingTop = 1
      Style.Margin = '1'
      Style.TextAlign = ctaCenter
      Style.ZIndex = 10
      Style.Effects.Rotation = 315
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = False
      Style.Effects.Text = etInclude
      Style.BorderRadius.All = '30'
      Use = STYLE_Link2
      AutoSizeXY = asNone
      OnClick = cAllClick
      Layout = ltText
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    end
  end
  object Button1: TTntButton
    Left = 320
    Top = 80
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TTntButton
    Left = 320
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object bClear: TTntButton
    Left = 320
    Top = 24
    Width = 73
    Height = 25
    Caption = 'Reset All'
    TabOrder = 3
    Visible = False
    OnClick = bClearClick
  end
  object Panel1: TPanel
    Left = 8
    Top = 152
    Width = 387
    Height = 137
    TabOrder = 4
    object Label2: TdhLabel
      Left = 11
      Top = 80
      Width = 61
      Height = 13
      Text = 'Vert. Radius:'
      AutoSizeXY = asY
    end
    object Label1: TdhLabel
      Left = 8
      Top = 48
      Width = 64
      Height = 13
      Text = 'Horz. Radius:'
      AutoSizeXY = asY
    end
    object cBoth: TTntCheckBox
      Left = 80
      Top = 8
      Width = 297
      Height = 17
      Caption = 'Define vertical and horizontal radius'
      TabOrder = 0
      OnClick = cBothClick
    end
    object cHorz: TMySpinEdit
      Left = 80
      Top = 40
      Width = 49
      Height = 22
      MaxValue = 9999
      MinValue = 0
      TabOrder = 1
      Value = 0
      Alignment = taRightJustify
      ValueChange = cHorzValueChange
      TrackBar = MyTrackBar1
    end
    object MyTrackBar1: TMyTrackBar
      Left = 136
      Top = 39
      Width = 241
      Height = 26
      Max = 200
      TabOrder = 2
    end
    object tbVert: TMyTrackBar
      Left = 136
      Top = 71
      Width = 241
      Height = 26
      Max = 200
      TabOrder = 3
    end
    object cVert: TMySpinEdit
      Left = 80
      Top = 72
      Width = 49
      Height = 22
      MaxValue = 9999
      MinValue = 0
      TabOrder = 4
      Value = 0
      Alignment = taRightJustify
      ValueChange = cHorzValueChange
      TrackBar = tbVert
    end
    object bClearAct: TTntButton
      Left = 80
      Top = 104
      Width = 75
      Height = 25
      Caption = 'Reset'
      TabOrder = 5
      OnClick = bClearActClick
    end
    object dhLabel1: TdhLabel
      Left = 8
      Top = 48
      Width = 64
      Height = 13
      Text = 'Radius:'
      AutoSizeXY = asY
    end
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      'bClear.*'
      'STYLE_*')
    StoreList.Strings = (
      'dhStyleSheet1*')
    Left = 208
    Top = 120
    LangData = {
      1200426F7264657252616469757357697A617264010100000001000000070043
      617074696F6E011A00000013005354594C455F64685374796C65536865657431
      00000B005354594C455F4C696E6B31000009005354594C455F6E6F6200000C00
      5354594C455F4C6162656C3400000C005354594C455F4C6162656C3300000C00
      5354594C455F4C6162656C3500000B005354594C455F4C696E6B320000100043
      6F726E65724E617669676174696F6E00000B0063426F74746F6D4C6566740101
      0000000800000004005465787400080063546F704C6566740101000000090000
      0004005465787400090063546F70526967687401010000000A00000004005465
      7874000C0063426F74746F6D526967687401010000000B000000040054657874
      00040063416C6C01010000000C000000040054657874000700427574746F6E31
      01010000000D000000070043617074696F6E000700427574746F6E3201010000
      000E000000070043617074696F6E00060062436C6561720000060050616E656C
      31000006004C6162656C320101000000100000000400546578740006004C6162
      656C3101010000001100000004005465787400050063426F7468010100000012
      000000070043617074696F6E00050063486F727A00000B004D79547261636B42
      617231000006007462566572740000050063566572740000090062436C656172
      416374010100000013000000070043617074696F6E00080064684C6162656C31
      01010000001400000004005465787400}
  end
end
