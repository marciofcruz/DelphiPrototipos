object frmtrocarsenha: Tfrmtrocarsenha
  Left = 192
  Top = 109
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Trocar senha'
  ClientHeight = 141
  ClientWidth = 246
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 58
    Top = 14
    Width = 60
    Height = 13
    Alignment = taRightJustify
    Caption = 'Senha atual:'
  end
  object Bevel1: TBevel
    Left = 48
    Top = 40
    Width = 193
    Height = 2
  end
  object Label1: TLabel
    Left = 57
    Top = 54
    Width = 61
    Height = 13
    Alignment = taRightJustify
    Caption = 'Nova senha:'
  end
  object Label3: TLabel
    Left = 12
    Top = 78
    Width = 106
    Height = 13
    Alignment = taRightJustify
    Caption = 'Confirmar nova senha:'
  end
  object btntrocar: TButton
    Left = 39
    Top = 112
    Width = 75
    Height = 25
    Caption = '&Trocar'
    Default = True
    TabOrder = 3
    OnClick = btntrocarClick
  end
  object btnfechar: TButton
    Left = 131
    Top = 112
    Width = 75
    Height = 25
    Caption = '&Fechar'
    TabOrder = 4
    OnClick = btnfecharClick
  end
  object edtsenhaatual: TEdit
    Left = 124
    Top = 10
    Width = 90
    Height = 22
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 0
  end
  object edtnovasenha: TEdit
    Left = 124
    Top = 50
    Width = 90
    Height = 22
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtconfirmarnovasenha: TEdit
    Left = 124
    Top = 74
    Width = 90
    Height = 22
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 2
  end
end
