object TransBG: TTransBG
  Left = 179
  Top = 191
  BorderStyle = bsToolWindow
  Caption = 'TransBG'
  ClientHeight = 221
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 423
    Height = 185
    ActivePage = TabSheet1
    Align = alTop
    TabIndex = 1
    TabOrder = 0
    object TabSheet3: TTabSheet
      Caption = 'Strech'
      object Label1: TLabel
        Left = 16
        Top = 8
        Width = 131
        Height = 13
        Caption = 'Strech to full client area by..'
      end
      object CheckGroupBox1: TCheckGroupBox
        Left = 8
        Top = 56
        Width = 377
        Height = 89
        TabOrder = 0
        CheckComponent = cStrechParted
        PositionCheckComponent = True
        object Label2: TLabel
          Left = 16
          Top = 32
          Width = 10
          Height = 13
          Caption = 'X:'
        end
        object Label3: TLabel
          Left = 16
          Top = 64
          Width = 10
          Height = 13
          Caption = 'Y:'
        end
        object slPartX: TRxSlider
          Left = 96
          Top = 16
          Width = 265
          Height = 33
          TabOrder = 0
          OnChange = slPartXChange
        end
        object spPartX: TMySpinEdit
          Left = 40
          Top = 24
          Width = 48
          Height = 22
          Increment = 1
          Digits = 0
          Max = 3000
          Alignment = taRightJustify
          TabOrder = 1
          OnChange = spPartXChange
        end
        object spPartY: TMySpinEdit
          Left = 40
          Top = 56
          Width = 48
          Height = 22
          Increment = 1
          Digits = 0
          Max = 3000
          Alignment = taRightJustify
          TabOrder = 2
          OnChange = spPartYChange
        end
        object slPartY: TRxSlider
          Left = 96
          Top = 48
          Width = 265
          Height = 33
          TabOrder = 3
          OnChange = slPartYChange
        end
      end
      object cStrechLinear: TCheckBox
        Left = 16
        Top = 29
        Width = 97
        Height = 17
        Caption = 'scale linear'
        TabOrder = 2
        OnClick = cStrechLinearClick
      end
      object cStrechParted: TCheckBox
        Left = 16
        Top = 53
        Width = 185
        Height = 17
        Caption = 'devide into 4 parts, division point:'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Rotate'
      object CheckGroupBox2: TCheckGroupBox
        Left = 8
        Top = 16
        Width = 401
        Height = 129
        Enabled = False
        TabOrder = 0
        CheckComponent = cRotateEnabled
        PositionCheckComponent = True
        object Label6: TLabel
          Left = 16
          Top = 32
          Width = 30
          Height = 13
          Caption = 'Angle:'
          Enabled = False
        end
        object slAngle: TRxSlider
          Left = 8
          Top = 48
          Width = 385
          Height = 33
          Enabled = False
          Increment = 45
          MaxValue = 360
          TabOrder = 0
          OnChange = slAngleChange
        end
        object spAngle: TMySpinEdit
          Left = 56
          Top = 24
          Width = 48
          Height = 22
          Increment = 1
          Digits = 0
          Max = 3000
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 1
          OnChange = spAngleChange
        end
      end
      object cRotateEnabled: TCheckBox
        Left = 16
        Top = 13
        Width = 65
        Height = 17
        Caption = 'Rotate'
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Shift'
      ImageIndex = 1
      object CheckGroupBox3: TCheckGroupBox
        Left = 8
        Top = 16
        Width = 401
        Height = 129
        Enabled = False
        TabOrder = 0
        CheckComponent = cShiftEnabled
        PositionCheckComponent = True
        object Label7: TLabel
          Left = 24
          Top = 32
          Width = 10
          Height = 13
          Caption = 'X:'
          Enabled = False
        end
        object Label8: TLabel
          Left = 24
          Top = 64
          Width = 10
          Height = 13
          Caption = 'Y:'
          Enabled = False
        end
        object slShiftX: TRxSlider
          Left = 104
          Top = 16
          Width = 265
          Height = 33
          Enabled = False
          TabOrder = 0
          OnChange = slShiftXChange
        end
        object spShiftX: TMySpinEdit
          Left = 48
          Top = 24
          Width = 48
          Height = 22
          Increment = 1
          Digits = 0
          Max = 3000
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 1
          OnChange = spShiftXChange
        end
        object spShiftY: TMySpinEdit
          Left = 48
          Top = 56
          Width = 48
          Height = 22
          Increment = 1
          Digits = 0
          Max = 3000
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 2
          OnChange = spShiftYChange
        end
        object slShiftY: TRxSlider
          Left = 104
          Top = 48
          Width = 265
          Height = 33
          Enabled = False
          TabOrder = 3
          OnChange = slShiftYChange
        end
      end
      object cShiftEnabled: TCheckBox
        Left = 16
        Top = 13
        Width = 49
        Height = 17
        Caption = 'Shift'
        TabOrder = 1
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Scale'
      ImageIndex = 3
    end
  end
  object Button1: TButton
    Left = 256
    Top = 192
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 336
    Top = 192
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TButton
    Left = 8
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Clear values'
    TabOrder = 3
  end
end
