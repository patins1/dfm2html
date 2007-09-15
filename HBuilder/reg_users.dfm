object PageContainer1: TPageContainer1
  Left = -4
  Top = -23
  Width = 1032
  Height = 493
  Caption = 'reg_users.dfm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 18
  object index: TdhPage
    Left = 0
    Top = 0
    Width = 1024
    Height = 466
    Style.BackgroundColor = Navy
    AutoSizeXY = asNone
    FTPURL = 'ftp://p8288468:5yMTPDtZ@kiegeland.com/dfm2html/reg_users/'
    DesignSize = (
      1024
      466)
    object Label1: TdhLabel
      Left = 56
      Top = 40
      Width = 193
      Height = 41
      Text = '<Label7>DFM</Label7><Label8>2HTML</Label8>'
      Style.FontSize = '36'
      Style.FontFamily = 'arial'
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.TextOnly = False
      AutoSizeXY = asXY
    end
    object StyleSheet3: TdhStyleSheet
      Left = 600
      Top = 41
      Width = 28
      Height = 28
      Expanded = False
      ExpandedWidth = 100
      ExpandedHeight = 100
      Expanded = False
      object Label7: TdhLabel
        Left = 0
        Top = 0
        Width = 10
        Height = 18
        Text = 'Label7'
        Style.Color = Red
        AutoSizeXY = asY
        Align = alTop
      end
      object Label8: TdhLabel
        Left = 0
        Top = 16
        Width = 10
        Height = 18
        Text = 'Label8'
        Style.Color = White
        AutoSizeXY = asY
        Align = alTop
      end
    end
    object Text3: TdhLabel
      Left = 56
      Width = 265
      Height = 19
      Text = 'DFM2HTML &copy; J'#246'rg Kiegeland 2005'
      Style.Color = White
      Style.FontWeight = cfwBold
      Style.Effects.Enabled = True
      Style.Effects.AntiAliasing = True
      Style.Effects.TextOnly = False
      AutoSizeXY = asXY
      Anchors = [akLeft, akBottom]
      Bottom = 11
    end
    object Label2: TdhLabel
      Left = 56
      Top = 96
      Width = 553
      Height = 19
      Text = 
        'Registered users can download a registered version of DFM2HTML h' +
        'ere:'
      Style.Color = White
      Style.FontWeight = cfwBold
      AutoSizeXY = asXY
    end
    object Link1: TdhLink
      Left = 56
      Top = 144
      Width = 336
      Height = 24
      Text = 'Download DFM2HTML v1.2 registered version'
      AutoSizeXY = asY
      Layout = ltButton
      PreferDownStyles = True
      Options = [loDownIfMenu, loDownIfMouseDown, loDownIfURL]
      Link = 'dfm2html_inst.exe'
    end
    object Label3: TdhLabel
      Left = 56
      Top = 192
      Width = 568
      Height = 114
      Text = 
        'If you have registered an older version of DFM2HTML, you can use' +
        ' the download button above to update your older version of DFM2H' +
        'TML. '#10'<br/>(You do not need to uninstall the older version, but ' +
        'it is required that you close any running DFM2HTML program insta' +
        'nce before installing a new version.)'#10'<br/><br/>'
      Style.Color = White
      Style.FontWeight = cfwBold
      AutoSizeXY = asY
    end
  end
end
