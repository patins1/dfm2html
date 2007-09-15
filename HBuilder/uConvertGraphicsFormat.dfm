object ConvertGraphicsFormat: TConvertGraphicsFormat
  Left = 182
  Top = 93
  AutoScroll = False
  Caption = 'Convert Graphic Formats'
  ClientHeight = 325
  ClientWidth = 382
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
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 178
    Height = 13
    Caption = 'Filter graphic formats to be converted:'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 248
    Top = 96
    Width = 12
    Height = 13
    Caption = '=>'
  end
  object Label3: TLabel
    Left = 272
    Top = 16
    Width = 95
    Height = 13
    Caption = 'Select target format:'
    WordWrap = True
  end
  object Panel1: TPanel
    Left = 16
    Top = 40
    Width = 225
    Height = 137
    TabOrder = 2
    object cSingleGIF: TCheckBox
      Left = 16
      Top = 16
      Width = 191
      Height = 17
      Caption = 'GIF (consisting of one image)'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object cAnimatedGIF: TCheckBox
      Left = 16
      Top = 40
      Width = 195
      Height = 17
      Caption = 'GIF Animations (first image is taken)'
      TabOrder = 1
    end
    object cBitmap: TCheckBox
      Left = 16
      Top = 64
      Width = 73
      Height = 17
      Caption = 'BMP'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object cJPEG: TCheckBox
      Left = 16
      Top = 88
      Width = 97
      Height = 17
      Caption = 'JPEG'
      TabOrder = 3
    end
    object cPNG: TCheckBox
      Left = 16
      Top = 112
      Width = 97
      Height = 17
      Caption = 'PNG'
      TabOrder = 4
    end
  end
  object bSaving: TButton
    Left = 16
    Top = 208
    Width = 217
    Height = 25
    Caption = 'Calculate potential saving of conversion'
    TabOrder = 0
    OnClick = bConvertClick
  end
  object bConvert: TButton
    Left = 16
    Top = 248
    Width = 73
    Height = 25
    Caption = 'Convert'
    TabOrder = 1
    OnClick = bConvertClick
  end
  object cNoIncrease: TCheckBox
    Left = 16
    Top = 184
    Width = 225
    Height = 17
    Caption = 'Don'#39't convert if size would increase'
    TabOrder = 3
  end
  object Panel2: TPanel
    Left = 272
    Top = 40
    Width = 97
    Height = 137
    TabOrder = 4
    object cToGIF: TRadioButton
      Left = 16
      Top = 72
      Width = 65
      Height = 17
      Caption = 'GIF'
      TabOrder = 0
    end
    object cToPNG: TRadioButton
      Left = 16
      Top = 40
      Width = 73
      Height = 17
      Caption = 'PNG'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object Button1: TButton
    Left = 16
    Top = 288
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 5
  end
end
