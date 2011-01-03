object Form3: TForm3
  Left = 346
  Top = 192
  BorderStyle = bsDialog
  Caption = 'Новый PlayList'
  ClientHeight = 73
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 217
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 72
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Принять'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 2
    OnClick = Button2Click
  end
end
