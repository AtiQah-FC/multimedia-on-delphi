object Form1: TForm1
  Left = 897
  Top = 127
  Width = 530
  Height = 375
  Caption = 'Form1'
  Color = clGray
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
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 403
    Top = 272
    Width = 3
    Height = 13
  end
  object pb2: TPaintBox
    Left = 128
    Top = 184
    Width = 249
    Height = 105
    Color = clGray
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
    Left = 392
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
    Left = 432
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 5
    OnClick = btn4Click
  end
  object btn6: TButton
    Left = 432
    Top = 73
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
  object btn5: TButton
    Left = 432
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Video'
    TabOrder = 8
    OnClick = btn5Click
  end
  object btn7: TButton
    Left = 352
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Equalaizer'
    TabOrder = 9
    OnClick = btn7Click
  end
  object btn8: TButton
    Left = 392
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Record'
    TabOrder = 10
    OnClick = btn8Click
  end
  object dlgOpen1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 192
    Top = 312
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 64
    Top = 312
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 96
    Top = 312
  end
  object Timer3: TTimer
    Interval = 1
    OnTimer = Timer3Timer
    Left = 128
    Top = 312
  end
  object xpmnfst1: TXPManifest
    Left = 224
    Top = 312
  end
  object Timer4: TTimer
    Interval = 10
    OnTimer = Timer4Timer
    Left = 160
    Top = 312
  end
end
