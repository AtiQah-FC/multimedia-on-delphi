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
      Caption = '����� PlayList'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '�������������  Enter'
      Default = True
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = '�������                  Del'
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = '���������������'
      object N5: TMenuItem
        Caption = '��������� ����'
        GroupIndex = 1
        RadioItem = True
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = '��������� ���'
        Checked = True
        GroupIndex = 1
        RadioItem = True
        OnClick = N6Click
      end
      object N7: TMenuItem
        Caption = '� ��������� �������'
        GroupIndex = 1
        RadioItem = True
        OnClick = N7Click
      end
      object N8: TMenuItem
        Caption = '��������� ������'
        GroupIndex = 1
        RadioItem = True
        OnClick = N8Click
      end
    end
    object N9: TMenuItem
      Caption = '�������� �����'
      object N11: TMenuItem
        Caption = '�������� �����'
        OnClick = N11Click
      end
      object N12: TMenuItem
        Caption = '�������� ����� �� �����'
        OnClick = N12Click
      end
      object N13: TMenuItem
        Caption = '�������� �� ����� (������� ��������)'
      end
    end
    object N10: TMenuItem
      Caption = '������� ������'
    end
    object N14: TMenuItem
      Caption = '�������������'
      object N15: TMenuItem
        Caption = '����������'
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 104
    Top = 96
  end
end
