object TemplatesWizard: TTemplatesWizard
  Left = 180
  Top = 33
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'Templates'
  ClientHeight = 342
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = ListBox1Click
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    389
    342)
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TTntListBox
    Left = 8
    Top = 10
    Width = 129
    Height = 291
    Anchors = [akLeft, akTop, akBottom]
    Color = clBtnFace
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object Button1: TTntButton
    Left = 225
    Top = 311
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TTntButton
    Left = 305
    Top = 311
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object dhStyleSheet1: TdhStyleSheet
    Left = 32
    Top = 226
    Width = 28
    Height = 28
    Expanded = False
    ExpandedWidth = 100
    ExpandedHeight = 100
    Expanded = False
    object STYLE_Link1: TdhLink
      Left = 0
      Top = 0
      Height = 33
      Text = 'STYLE_Link1'
      Style.Border.Width = 5
      Style.Border.Color = Silver
      Style.Border.Style = cbsSolid
      Style.Margin = '5'
      Style.Cursor = ccuPointer
      Style.BorderRadius.All = '5'
      AutoSizeXY = asXY
      Align = alTop
      Right = 6
      OnClick = STYLE_Link1Click
      OnDblClick = STYLE_Link1DblClick
      StyleDown.Border.Color = Blue
      PreferDownStyles = True
      Options = []
    end
  end
  object lEmpty: TdhLabel
    Left = 152
    Top = 18
    Width = 41
    Height = 13
    Text = '- Empty -'
    AutoSizeXY = asXY
  end
  object ScrollBox1: TScrollBox
    Left = 144
    Top = 10
    Width = 241
    Height = 291
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    BorderStyle = bsNone
    TabOrder = 5
    OnMouseMove = ScrollBox1MouseMove
    OnMouseWheel = ScrollBox1MouseWheel
    object tt: TdhPanel
      Left = 0
      Top = 0
      Height = 225
      AutoSizeXY = asY
      Align = alTop
      Right = 0
      OnMouseMove = ScrollBox1MouseMove
    end
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      'STYLE_*')
    Left = 184
    Top = 168
    LangData = {
      0F0054656D706C6174657357697A617264010100000001000000070043617074
      696F6E010800000008004C697374426F783100000700427574746F6E31010100
      000002000000070043617074696F6E000700427574746F6E3201010000000300
      0000070043617074696F6E000D0064685374796C6553686565743100000B0053
      54594C455F4C696E6B31000006006C456D707479010100000005000000040054
      657874000A005363726F6C6C426F78310000020074740000}
  end
end
