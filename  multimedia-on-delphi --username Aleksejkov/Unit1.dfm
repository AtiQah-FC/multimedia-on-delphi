object Form1: TForm1
  Left = 270
  Top = 246
  Width = 443
  Height = 150
  Caption = 'EasyPlayer v4'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 417
    Height = 20
    AutoSize = False
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 192
    Top = 80
    Width = 55
    Height = 25
    AutoSize = False
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Label3: TLabel
    Left = 264
    Top = 80
    Width = 55
    Height = 25
    AutoSize = False
    Caption = 'Label3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 8
    Top = 32
    Width = 169
    Height = 16
    AutoSize = False
    Caption = 'Label4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 192
    Top = 32
    Width = 233
    Height = 16
    AutoSize = False
    Caption = 'Label5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 8
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Play/Pause'
    TabOrder = 1
    OnClick = Button2Click
  end
  object MediaPlayer1: TMediaPlayer
    Left = 160
    Top = 8
    Width = 253
    Height = 30
    Visible = False
    TabOrder = 2
  end
  object Button3: TButton
    Left = 352
    Top = 80
    Width = 75
    Height = 25
    Caption = 'PlayList'
    TabOrder = 3
    OnClick = Button3Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 56
    Width = 417
    Height = 17
    Min = 0
    Max = 417
    TabOrder = 4
    OnMouseDown = ProgressBar1MouseDown
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.mp3|*.mp3|*.wma|*.wma|*.wav|*.wav'
    Left = 72
    Top = 8
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 112
    Top = 8
  end
end
