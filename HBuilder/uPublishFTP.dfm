object PublishFTP: TPublishFTP
  Left = 745
  Top = 105
  Caption = 'FTP Settings'
  ClientHeight = 326
  ClientWidth = 463
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
  object Button1: TTntButton
    Left = 296
    Top = 293
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TTntButton
    Left = 380
    Top = 293
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Default = True
    ModalResult = 2
    TabOrder = 1
  end
  object Panel1: TMyPanel
    Left = 8
    Top = 8
    Width = 447
    Height = 275
    TabOrder = 2
    DesignSize = (
      447
      275)
    object Label1: TdhLabel
      Top = 32
      Width = 25
      Height = 13
      Text = 'Host:'
      AutoSizeXY = asXY
      Anchors = [akTop, akRight]
      Right = 382
    end
    object Label2: TdhLabel
      Top = 96
      Width = 25
      Height = 13
      Text = 'User:'
      AutoSizeXY = asXY
      Anchors = [akTop, akRight]
      Right = 382
    end
    object Label3: TdhLabel
      Top = 128
      Width = 49
      Height = 13
      Text = 'Password:'
      AutoSizeXY = asXY
      Anchors = [akTop, akRight]
      Right = 382
    end
    object Label4: TdhLabel
      Top = 160
      Width = 45
      Height = 13
      Text = 'Directory:'
      AutoSizeXY = asXY
      Anchors = [akTop, akRight]
      Right = 382
    end
    object Label5: TdhLabel
      Top = 64
      Width = 22
      Height = 13
      Text = 'Port:'
      AutoSizeXY = asXY
      Anchors = [akTop, akRight]
      Right = 382
    end
    object eUser: TTntEdit
      Left = 72
      Top = 88
      Width = 145
      Height = 21
      TabOrder = 0
      OnChange = eUserChange
    end
    object eDir: TTntEdit
      Left = 72
      Top = 152
      Width = 145
      Height = 21
      TabOrder = 1
      OnChange = eUserChange
    end
    object ePort: TTntEdit
      Left = 72
      Top = 56
      Width = 145
      Height = 21
      TabOrder = 2
      OnChange = eUserChange
    end
    object ePsw: TMyMaskEdit
      Left = 72
      Top = 120
      Width = 145
      Height = 21
      TabOrder = 3
      OnChange = eUserChange
    end
    object Button3: TTntButton
      Left = 72
      Top = 224
      Width = 145
      Height = 17
      Caption = 'Extract from URL'
      TabOrder = 4
      OnClick = Button3Click
    end
    object eHost: TTntComboBox
      Left = 72
      Top = 24
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 5
      OnChange = eHostChange
    end
    object Button4: TTntButton
      Left = 72
      Top = 175
      Width = 145
      Height = 17
      Caption = 'Open remote FTP directory'
      TabOrder = 6
      OnClick = Button4Click
    end
    object bReset: TTntButton
      Left = 72
      Top = 248
      Width = 145
      Height = 17
      Caption = 'Reset'
      TabOrder = 7
      OnClick = Button3Click
    end
    object Label8: TdhLabel
      Left = 224
      Top = 32
      Width = 115
      Height = 13
      Text = 'example: mydomain.com'
      Style.FontSize = '8'
      Style.Color = Gray
      AutoSizeXY = asXY
    end
    object dhLabel1: TdhLabel
      Left = 224
      Top = 64
      Width = 64
      Height = 13
      Text = 'defaults to 21'
      Style.FontSize = '8'
      Style.Color = Gray
      AutoSizeXY = asXY
    end
    object dhLabel3: TdhLabel
      Left = 224
      Top = 160
      Width = 111
      Height = 13
      Text = 'example: /webcontent/'
      Style.FontSize = '8'
      Style.Color = Gray
      AutoSizeXY = asXY
    end
    object dhLabel2: TdhLabel
      Left = 72
      Top = 200
      Width = 12
      Height = 13
      Text = '=>'
      Style.FontSize = '8'
      AutoSizeXY = asXY
    end
  end
  object DKLanguageController1: TDKLanguageController
    Left = 144
    Top = 144
    LangData = {
      0A005075626C697368465450010100000001000000070043617074696F6E0114
      0000000700427574746F6E31010100000002000000070043617074696F6E0007
      00427574746F6E32010100000003000000070043617074696F6E00060050616E
      656C31000006004C6162656C3101010000000C0000000400546578740006004C
      6162656C3201010000000D0000000400546578740006004C6162656C33010100
      00000E0000000400546578740006004C6162656C3401010000000F0000000400
      546578740006004C6162656C3501010000001000000004005465787400050065
      5573657200000400654469720000050065506F72740000040065507377000007
      00427574746F6E33010100000009000000070043617074696F6E00050065486F
      737400000700427574746F6E3401010000000A000000070043617074696F6E00
      060062526573657401010000000B000000070043617074696F6E0006004C6162
      656C3801010000001100000004005465787400080064684C6162656C31010100
      00001200000004005465787400080064684C6162656C33010100000013000000
      04005465787400080064684C6162656C320000}
  end
end
