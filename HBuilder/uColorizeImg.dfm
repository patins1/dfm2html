object ColorizeImg: TColorizeImg
  Left = 1
  Top = 27
  Width = 775
  Height = 474
  Caption = 'Colorize Image'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lStats: TdhLabel
    Left = 288
    Top = 16
    Width = 441
    Height = 13
    Text = 'Stats:'
    Style.Color = Gray
    AutoSizeXY = asNone
  end
  object cImg: TComboBox
    Left = 8
    Top = 184
    Width = 145
    Height = 19
    Style = csOwnerDrawVariable
    Color = clWhite
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = '1'
    OnChange = cImgChange
    OnClick = cImgClick
    OnDrawItem = cImgDrawItem
    OnMeasureItem = cImgMeasureItem
    Items.Strings = (
      '1'
      '1'
      '1'
      '1'
      '1'
      '1'
      '1'
      '1'
      '1'
      '1'
      '1'
      '1')
  end
  object Button1: TTntButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TTntButton
    Left = 96
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TTntButton
    Left = 184
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Panel1: TMyPanel
    Left = 8
    Top = 40
    Width = 753
    Height = 137
    TabOrder = 4
    DesignSize = (
      753
      137)
    object Label1: TdhLabel
      Top = 16
      Width = 51
      Height = 13
      Text = 'Saturation:'
      AutoSizeXY = asXY
      Anchors = [akTop, akRight]
      Right = 690
    end
    object Label2: TdhLabel
      Left = 130
      Top = 33
      Width = 26
      Height = 13
      Text = '100%'
      AutoSizeXY = asY
    end
    object DEGREE_Label3: TdhLabel
      Left = 709
      Top = 33
      Width = 32
      Height = 13
      Text = '1000%'
      AutoSizeXY = asY
    end
    object DEGREE_Label4: TdhLabel
      Left = 68
      Top = 33
      Width = 14
      Height = 13
      Text = '0%'
      AutoSizeXY = asY
    end
    object Label5: TdhLabel
      Top = 56
      Width = 48
      Height = 13
      Text = 'Lightness:'
      AutoSizeXY = asXY
      Anchors = [akTop, akRight]
      Right = 690
    end
    object DEGREE_Label6: TdhLabel
      Left = 130
      Top = 73
      Width = 26
      Height = 13
      Text = '100%'
      AutoSizeXY = asY
    end
    object DEGREE_Label7: TdhLabel
      Left = 709
      Top = 73
      Width = 32
      Height = 13
      Text = '1000%'
      AutoSizeXY = asY
    end
    object DEGREE_Label8: TdhLabel
      Left = 68
      Top = 73
      Width = 14
      Height = 13
      Text = '0%'
      AutoSizeXY = asY
    end
    object Label9: TdhLabel
      Top = 96
      Width = 23
      Height = 13
      Text = 'Hue:'
      AutoSizeXY = asXY
      Anchors = [akTop, akRight]
      Right = 690
    end
    object DEGREE_Label10: TdhLabel
      Left = 68
      Top = 113
      Width = 10
      Height = 13
      Text = '0'#176
      AutoSizeXY = asY
    end
    object DEGREE_Label11: TdhLabel
      Left = 717
      Top = 113
      Width = 22
      Height = 13
      Text = '360'#176
      AutoSizeXY = asY
    end
    object slSaturation: TMyTrackBar
      Left = 64
      Top = 6
      Width = 673
      Height = 27
      Max = 1000
      ParentShowHint = False
      PageSize = 100
      Frequency = 100
      Position = 100
      ShowHint = False
      TabOrder = 0
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = slSaturationChange
    end
    object slLightness: TMyTrackBar
      Left = 64
      Top = 46
      Width = 673
      Height = 27
      Max = 1000
      ParentShowHint = False
      PageSize = 100
      Frequency = 100
      Position = 100
      ShowHint = False
      TabOrder = 1
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = slSaturationChange
    end
    object slHoe: TMyTrackBar
      Left = 64
      Top = 86
      Width = 673
      Height = 27
      Max = 360
      ParentShowHint = False
      PageSize = 30
      Frequency = 30
      ShowHint = False
      TabOrder = 2
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = slSaturationChange
    end
  end
  object lAverageSaturation: TdhLabel
    Left = 472
    Top = 264
    Width = 100
    Height = 13
    Text = 'Average Saturation'
    AutoSizeXY = asY
    Visible = False
  end
  object lAverageLightness: TdhLabel
    Left = 472
    Top = 280
    Width = 100
    Height = 13
    Text = 'Average Lightness'
    AutoSizeXY = asY
    Visible = False
  end
  object DKLanguageController1: TDKLanguageController
    IgnoreList.Strings = (
      'DEGREE_*'
      'lStats.*')
    Left = 376
    Top = 224
    LangData = {
      0B00436F6C6F72697A65496D67010100000001000000070043617074696F6E01
      1600000006006C53746174730000040063496D6700000700427574746F6E3101
      0100000003000000070043617074696F6E000700427574746F6E320101000000
      04000000070043617074696F6E000700427574746F6E33010100000005000000
      070043617074696F6E00060050616E656C31000006004C6162656C3101010000
      00090000000400546578740006004C6162656C3200000D004445475245455F4C
      6162656C3300000D004445475245455F4C6162656C34000006004C6162656C35
      01010000000A000000040054657874000D004445475245455F4C6162656C3600
      000D004445475245455F4C6162656C3700000D004445475245455F4C6162656C
      38000006004C6162656C3901010000000B000000040054657874000E00444547
      5245455F4C6162656C313000000E004445475245455F4C6162656C313100000C
      00736C53617475726174696F6E00000B00736C4C696768746E65737300000500
      736C486F65000012006C4176657261676553617475726174696F6E0101000000
      0C0000000400546578740011006C417665726167654C696768746E6573730101
      0000000D00000004005465787400}
  end
end
