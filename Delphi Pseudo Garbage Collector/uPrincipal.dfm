object frmTeste: TfrmTeste
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 
    'Teste de vazamento de mem'#243'ria e a classe TPseuddoGC - Marcio - 0' +
    '4/03/2019'
  ClientHeight = 142
  ClientWidth = 706
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBase: TPanel
    Left = 0
    Top = 73
    Width = 706
    Height = 69
    Align = alClient
    BevelOuter = bvNone
    Color = clAqua
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 152
    ExplicitHeight = 297
    object GroupBox1: TGroupBox
      Left = 5
      Top = 5
      Width = 348
      Height = 59
      Align = alLeft
      Caption = 'Cria'#231#227'o e destrui'#231#227'o tradicional'
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitHeight = 439
      object btnCriacaoSemFree: TButton
        Left = 120
        Top = 16
        Width = 177
        Height = 25
        Caption = 'Cria'#231#227'o sem Free (Vazamento)'
        TabOrder = 0
        OnClick = btnCriacaoSemFreeClick
      end
      object btnTryFinally: TButton
        Left = 8
        Top = 16
        Width = 97
        Height = 25
        Caption = 'try..finally'
        TabOrder = 1
        OnClick = btnTryFinallyClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 353
      Top = 5
      Width = 348
      Height = 59
      Align = alClient
      Caption = 'Cria'#231#227'o com a TPseudoGC'
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 1
      ExplicitLeft = 354
      ExplicitTop = 6
      object btnCriacaocomPseudoGC: TButton
        Left = 40
        Top = 16
        Width = 185
        Height = 25
        Caption = 'Cria'#231#227'o com o TPseudoGC'
        TabOrder = 0
        OnClick = btnCriacaocomPseudoGCClick
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 706
    Height = 73
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object sttInformacao: TStaticText
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 698
      Height = 65
      Align = alClient
      Alignment = taCenter
      Caption = 'sttInformacao'
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 704
      ExplicitHeight = 71
    end
  end
end
