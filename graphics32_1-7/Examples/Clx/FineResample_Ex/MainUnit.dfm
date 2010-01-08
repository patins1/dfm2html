object Form1: TForm1
  Left = 192
  Top = 114
  Width = 293
  Height = 218
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    285
    191)
  PixelsPerInch = 96
  TextHeight = 13
  object Image32: TImage32
    Left = 12
    Top = 12
    Width = 160
    Height = 160
    Anchors = [akLeft, akTop, akRight, akBottom]
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smStretch
    TabOrder = 0
  end
  object RadioGroup1: TRadioGroup
    Left = 184
    Top = 12
    Width = 93
    Height = 133
    Anchors = [akTop, akRight]
    Caption = 'RadioGroup1'
    ItemIndex = 0
    Items.Strings = (
      'sfNearest'
      'sfLinear'
      'sfSpline'
      'sfLanczos'
      'sfMitchell'
      'sfCosine')
    TabOrder = 1
    OnClick = RadioGroup1Click
  end
  object CheckBox1: TCheckBox
    Left = 184
    Top = 156
    Width = 93
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'FullEdge'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = CheckBox1Click
  end
end
