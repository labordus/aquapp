object frmRaster: TfrmRaster
  Left = 231
  Top = 174
  AutoSize = True
  BorderStyle = bsToolWindow
  Caption = 'Overzicht van alle ingelogde dagen.'
  ClientHeight = 331
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel9: TBevel
    Left = 2
    Top = 0
    Width = 323
    Height = 33
    Style = bsRaised
  end
  object Label134: TLabel
    Left = 5
    Top = 5
    Width = 309
    Height = 26
    Caption = 
      'Hier ziet u een overzicht van alle gelogde dagen, u kunt een dag' +
      ' selecteren door er met de muis op te klikken.'
    Font.Charset = ANSI_CHARSET
    Font.Color = 5177344
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label1: TLabel
    Left = 418
    Top = 33
    Width = 110
    Height = 13
    Caption = 'Overzicht van het jaar :'
  end
  object btnJaarTerug: TSpeedButton
    Left = 532
    Top = 29
    Width = 21
    Height = 21
    Constraints.MaxHeight = 21
    Constraints.MinHeight = 21
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888808888
      8888888888008888888888888080888888888888088088888888888088800000
      0008880888888888880880888888888888080888888888888808808888888888
      8808880888888888880888808880000000088888088088888888888880808888
      8888888888008888888888888880888888888888888888888888}
    OnClick = btnJaarTerugClick
  end
  object btnJaarVerder: TSpeedButton
    Left = 676
    Top = 29
    Width = 21
    Height = 21
    Constraints.MaxHeight = 21
    Constraints.MinHeight = 21
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888808888
      8888888888800888888888888880808888888888888088088888000000008880
      8888088888888888088808888888888880880888888888888808088888888888
      8088088888888888088800000000888088888888888088088888888888808088
      8888888888800888888888888880888888888888888888888888}
    Layout = blGlyphRight
    OnClick = btnJaarVerderClick
  end
  object JvImageSquare1: TJvImageSquare
    Left = 4
    Top = 34
    Width = 21
    Height = 21
    Color = 50688
    Text = 'JvImageSquare1'
  end
  object Label2: TLabel
    Left = 32
    Top = 38
    Width = 73
    Height = 13
    Caption = 'Gelogde dagen'
  end
  object Panel1: TPanel
    Left = 0
    Top = 56
    Width = 700
    Height = 250
    BevelInner = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
  end
  object btnCancel: TJvBitBtn
    Left = 630
    Top = 309
    Width = 65
    Height = 22
    Cancel = True
    Caption = 'Annuleren'
    Default = True
    TabOrder = 3
    OnClick = btnCancelClick
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clBlue
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
  end
  object btnOK: TJvBitBtn
    Left = 562
    Top = 309
    Width = 65
    Height = 22
    Cancel = True
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOKClick
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clBlue
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
  end
  object edtJaar: TComboBox
    Left = 554
    Top = 30
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = edtJaarChange
    Items.Strings = (
      '1990'
      '1991'
      '1992'
      '1993'
      '1994'
      '1995'
      '1996'
      '1997'
      '1998'
      '1999'
      '2000'
      '2001'
      '2002'
      '2003'
      '2004'
      '2005'
      '2006'
      '2007'
      '2008'
      '2009'
      '2010'
      '2011'
      '2012'
      '2013'
      '2014'
      '2015'
      '2016'
      '2017'
      '2018'
      '2019'
      '2020'
      '2021'
      '2022'
      '2023'
      '2024'
      '2025'
      '2026'
      '2027'
      '2028'
      '2029'
      '2030')
  end
  object IvTranslator1: TIvTranslator
    DictionaryName = 'Dictionary1'
    Left = 624
    Top = 8
    TargetsData = (
      1
      3
      (
        '*'
        'Hint'
        0)
      (
        '*'
        'Caption'
        0)
      (
        '*'
        'Items'
        0))
  end
end
