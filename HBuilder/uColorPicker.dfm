object ColorPicker: TColorPicker
  Left = 643
  Top = 259
  Caption = 'Color Picker'
  ClientHeight = 202
  ClientWidth = 148
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    148
    202)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TdhLabel
    Left = 0
    Top = 0
    Height = 13
    Text = 'Color under mouse cursor:'
    AutoSizeXY = asXY
    Align = alTop
    Right = 0
  end
  object Label2: TdhLabel
    Left = 0
    Top = 78
    Height = 13
    Text = 'Picked color (press CTRL):'
    AutoSizeXY = asXY
    Align = alTop
    Right = 0
  end
  object Panel1: TdhPanel
    Left = 0
    Top = 13
    Height = 65
    Style.Border.Width = 1
    Style.Border.Color = Black
    Style.Border.Style = cbsSolid
    Style.Margin = '3'
    Style.BorderRadius.All = '10'
    AutoSizeXY = asNone
    Align = alTop
    Right = 0
  end
  object Panel2: TdhPanel
    Left = 0
    Top = 91
    Height = 65
    Style.Border.Width = 1
    Style.Border.Color = Black
    Style.Border.Style = cbsSolid
    Style.Margin = '3'
    Style.BorderRadius.All = '10'
    AutoSizeXY = asNone
    Align = alTop
    Right = 0
  end
  object Button2: TTntButton
    Left = 0
    Top = 177
    Width = 70
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Button3: TTntButton
    Left = 71
    Top = 177
    Width = 77
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 120
    Top = 8
    object ColorPicker1: TMenuItem
      Caption = 'Color Picker'
      OnClick = ColorPicker1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CopyColortoClipboard1: TMenuItem
      Caption = 'Copy Color to Clipboard'
      OnClick = CopyColortoClipboard1Click
    end
    object GetColorfromClipboard1: TMenuItem
      Caption = 'Get Color from Clipboard'
      OnClick = GetColorfromClipboard1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 152
    Top = 8
  end
  object DKLanguageController1: TDKLanguageController
    Left = 64
    Top = 104
    LangData = {
      0B00436F6C6F725069636B6572010100000001000000070043617074696F6E01
      0C00000006004C6162656C310101000000090000000400546578740006004C61
      62656C3201010000000A00000004005465787400060050616E656C3100000600
      50616E656C3200000700427574746F6E32010100000004000000070043617074
      696F6E000700427574746F6E33010100000005000000070043617074696F6E00
      0A00506F7075704D656E753100000C00436F6C6F725069636B65723101010000
      0006000000070043617074696F6E0002004E3100001500436F7079436F6C6F72
      746F436C6970626F61726431010100000007000000070043617074696F6E0016
      00476574436F6C6F7266726F6D436C6970626F61726431010100000008000000
      070043617074696F6E00060054696D6572310000}
  end
end
