object Form2: TForm2
  Left = 738
  Top = 225
  Width = 638
  Height = 491
  Caption = 'Form2'
  Color = clNavy
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 8
    Top = 8
    Width = 489
    Height = 289
    Color = clCream
    TabOrder = 0
    OnDblClick = pnl1DblClick
  end
  object btn1: TButton
    Left = 8
    Top = 304
    Width = 489
    Height = 25
    Caption = 'Add Media'
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 8
    Top = 336
    Width = 489
    Height = 25
    Caption = 'Play'
    TabOrder = 2
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 8
    Top = 368
    Width = 489
    Height = 25
    Caption = 'Pause'
    TabOrder = 3
    OnClick = btn3Click
  end
  object sc: TScrollBar
    Left = 8
    Top = 400
    Width = 489
    Height = 17
    PageSize = 0
    TabOrder = 4
    OnScroll = scScroll
  end
  object dlgOpen1: TOpenDialog
    Left = 544
    Top = 176
  end
  object xpmnfst1: TXPManifest
    Left = 560
    Top = 96
  end
end
