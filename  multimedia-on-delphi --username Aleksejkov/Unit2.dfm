object Form2: TForm2
  Left = 299
  Top = 170
  Width = 321
  Height = 403
  Caption = 'PlayList'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 22
    Width = 313
    Height = 347
    Align = alClient
    ItemHeight = 16
    MultiSelect = True
    PopupMenu = PopupMenu1
    Style = lbOwnerDrawFixed
    TabOrder = 0
    OnDblClick = ListBox1DblClick
    OnDragDrop = ListBox1DragDrop
    OnDragOver = ListBox1DragOver
    OnDrawItem = ListBox1DrawItem
    OnKeyDown = ListBox1KeyDown
    OnMouseDown = ListBox1MouseDown
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 313
    Height = 22
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
    object ComboBox1: TComboBox
      Left = 0
      Top = 0
      Width = 313
      Height = 22
      Style = csOwnerDrawFixed
      Anchors = [akLeft, akTop, akRight]
      DropDownCount = 24
      ItemHeight = 16
      TabOrder = 0
      OnChange = ComboBox1Change
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 96
    object N1: TMenuItem
      Caption = 'Новый PlayList'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = 'Воспроизвести  Enter'
      Default = True
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = 'Удалить                  Del'
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = 'Воспроизведение'
      object N5: TMenuItem
        Caption = 'Повторять одну'
        GroupIndex = 1
        RadioItem = True
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = 'Повторять все'
        Checked = True
        GroupIndex = 1
        RadioItem = True
        OnClick = N6Click
      end
      object N7: TMenuItem
        Caption = 'В случайном порядке'
        GroupIndex = 1
        RadioItem = True
        OnClick = N7Click
      end
      object N8: TMenuItem
        Caption = 'Отключить повтор'
        GroupIndex = 1
        RadioItem = True
        OnClick = N8Click
      end
    end
    object N9: TMenuItem
      Caption = 'Добавить файлы'
      object N11: TMenuItem
        Caption = 'Добавить файлы'
        OnClick = N11Click
      end
      object N12: TMenuItem
        Caption = 'Добавить файлы из папки'
        OnClick = N12Click
      end
      object N13: TMenuItem
        Caption = 'Добавить из папки (включая подпапки)'
      end
    end
    object N10: TMenuItem
      Caption = 'Удалить список'
    end
    object N14: TMenuItem
      Caption = 'Дополнительно'
      object N15: TMenuItem
        Caption = 'Перемешать'
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 104
    Top = 96
  end
end
