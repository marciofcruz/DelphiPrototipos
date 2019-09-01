object frmlogin: Tfrmlogin
  Left = 278
  Top = 222
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Acessar o Bol'#227'o'
  ClientHeight = 170
  ClientWidth = 223
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 20
    Width = 36
    Height = 13
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel
    Left = 8
    Top = 50
    Width = 34
    Height = 13
    Caption = 'Senha:'
  end
  object Label3: TLabel
    Left = 12
    Top = 128
    Width = 144
    Height = 13
    Caption = 'Para acesso supervisor, digitar'
  end
  object Label4: TLabel
    Left = 12
    Top = 152
    Width = 124
    Height = 13
    Caption = 'C'#243'digo: 0  Senha: BOLAO'
  end
  object edtcodigo: TFPEditFloat
    Left = 48
    Top = 16
    Width = 73
    Height = 21
    MaxLength = 5
    TabOrder = 0
    Text = '0'
    Decimal = 0
    Max = 99999
    Alignment = taRightJustify
    ErrorMessage = '[No Text]'
  end
  object edtsenha: TEdit
    Left = 48
    Top = 46
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
  object btnacessar: TButton
    Left = 20
    Top = 84
    Width = 75
    Height = 25
    Caption = '&Acessar'
    Default = True
    TabOrder = 2
    OnClick = btnacessarClick
  end
  object btnfechar: TButton
    Left = 112
    Top = 84
    Width = 75
    Height = 25
    Caption = '&Fechar'
    TabOrder = 3
    OnClick = btnfecharClick
  end
  object dtsapostador: TQuery
    Left = 184
    Top = 20
  end
end
