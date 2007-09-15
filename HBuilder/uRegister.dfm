object Register: TRegister
  Left = 207
  Top = 116
  BorderStyle = bsDialog
  Caption = 'Register'
  ClientHeight = 127
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 40
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    OnKeyDown = Edit1KeyDown
  end
  object dhLabel1: TdhLabel
    Left = 8
    Top = 16
    Width = 263
    Height = 13
    Text = 'For registered users, enter your password and press OK:'
    AutoSizeXY = asXY
  end
  object dhStyleSheet1: TdhStyleSheet
    Left = 312
    Top = 0
    Width = 28
    Height = 28
    Expanded = False
    ExpandedWidth = 100
    ExpandedHeight = 100
    Expanded = False
    object Link1: TdhLink
      Left = 0
      Top = 0
      Width = 82
      Height = 24
      Text = 'Link1'
      AutoSizeXY = asXY
      Align = alTop
      Layout = ltButton
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'http://www.dfm2html.com/register.html'
    end
  end
  object Button1: TButton
    Left = 8
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 96
    Top = 96
    Width = 73
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object dhLink1: TdhLink
    Left = 184
    Top = 96
    Width = 73
    Height = 24
    Text = 'Register'
    Style.Color = Blue
    Style.TextDecoration = [ctdUnderline]
    AutoSizeXY = asXY
    Layout = ltButton
    PreferDownStyles = True
    Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
    Link = 'http://www.dfm2html.com/register.html'
  end
end
