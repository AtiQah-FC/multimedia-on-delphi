object Form1: TForm1
  Left = 792
  Top = 144
  Width = 591
  Height = 395
  Caption = 'Form1'
  Color = clWhite
  TransparentColorValue = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 184
    Width = 35
    Height = 13
    Caption = 'Volume'
  end
  object Label1: TLabel
    Left = 64
    Top = 272
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 416
    Top = 264
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object pb2: TPaintBox
    Left = 128
    Top = 184
    Width = 249
    Height = 105
    Color = clWhite
    ParentColor = False
  end
  object TrackBar1: TTrackBar
    Left = 8
    Top = 200
    Width = 45
    Height = 134
    Max = 100
    Orientation = trVertical
    TabOrder = 0
    OnChange = TrackBar1Change
  end
  object lst1: TListBox
    Left = 8
    Top = 8
    Width = 337
    Height = 169
    Color = clAqua
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = lst1DblClick
  end
  object btn1: TButton
    Left = 352
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Play'
    TabOrder = 2
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 352
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 3
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 352
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Pause'
    TabOrder = 4
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 456
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 5
    OnClick = btn4Click
  end
  object btn6: TButton
    Left = 456
    Top = 41
    Width = 75
    Height = 24
    Caption = 'RMove'
    TabOrder = 6
    OnClick = btn6Click
  end
  object pb1: TProgressBar
    Left = 64
    Top = 288
    Width = 385
    Height = 17
    Max = 200
    TabOrder = 7
    OnMouseDown = pb1MouseDown
  end
  object dlgOpen1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 536
    Top = 304
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 472
    Top = 304
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 504
    Top = 304
  end
  object Timer3: TTimer
    Interval = 1
    OnTimer = Timer3Timer
    Left = 440
    Top = 304
  end
  object xpmnfst1: TXPManifest
    Left = 408
    Top = 304
  end
  object Timer4: TTimer
    Interval = 10
    OnTimer = Timer4Timer
    Left = 504
    Top = 272
  end
end