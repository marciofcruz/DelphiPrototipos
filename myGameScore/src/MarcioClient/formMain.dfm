object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Marcio Client - 13/06/2019 - myGameScore'
  ClientHeight = 427
  ClientWidth = 742
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
  object grbConfiguracao: TGroupBox
    Left = 0
    Top = 0
    Width = 742
    Height = 81
    Align = alTop
    Caption = 'Configura'#231#227'o para acesso do servidor'
    TabOrder = 0
    object edtHost: TLabeledEdit
      Left = 92
      Top = 24
      Width = 121
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'Host'
      LabelPosition = lpLeft
      TabOrder = 0
      Text = 'http://localhost'
    end
    object edtPorta: TLabeledEdit
      Left = 276
      Top = 24
      Width = 85
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'Porta'
      LabelPosition = lpLeft
      NumbersOnly = True
      TabOrder = 1
      Text = '8080'
      TextHint = '8080'
    end
    object edtUsuario: TLabeledEdit
      Left = 428
      Top = 24
      Width = 84
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Hint = 'O usu'#225'rio '#233' user'
      EditLabel.Caption = 'Usuario'
      EditLabel.ParentShowHint = False
      EditLabel.ShowHint = True
      LabelPosition = lpLeft
      TabOrder = 2
      Text = 'marcio.cruz'
    end
    object edtSenha: TLabeledEdit
      Left = 580
      Top = 24
      Width = 88
      Height = 21
      Hint = 'A senha '#233' passwd'
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Senha'
      LabelPosition = lpLeft
      ParentShowHint = False
      PasswordChar = '*'
      ShowHint = True
      TabOrder = 3
      Text = 'senhasegura'
      TextHint = 'passwd'
    end
    object ckbTemAutenticacao: TCheckBox
      Left = 408
      Top = 51
      Width = 161
      Height = 17
      Caption = 'Tem Autentica'#231#227'o'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 81
    Width = 742
    Height = 157
    Align = alTop
    Caption = 'Autentica'#231#227'o no Sistema '
    TabOrder = 1
    object edtUsuarioSistema: TLabeledEdit
      Left = 52
      Top = 24
      Width = 124
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Hint = 'O usu'#225'rio '#233' user'
      EditLabel.Caption = 'Usu'#225'rio'
      EditLabel.ParentShowHint = False
      EditLabel.ShowHint = True
      LabelPosition = lpLeft
      TabOrder = 0
      Text = 'usuario'
    end
    object edtSenhaSistema: TLabeledEdit
      Left = 228
      Top = 24
      Width = 124
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Senha'
      EditLabel.ParentShowHint = False
      EditLabel.ShowHint = True
      LabelPosition = lpLeft
      TabOrder = 1
      Text = 'senha'
    end
    object btnAutenticacao: TButton
      Left = 383
      Top = 21
      Width = 114
      Height = 25
      Caption = 'Autentica'#231#227'o'
      TabOrder = 2
      OnClick = btnAutenticacaoClick
    end
    object edtTokenGerado: TLabeledEdit
      Left = 76
      Top = 56
      Width = 633
      Height = 21
      Color = clWhite
      EditLabel.Width = 29
      EditLabel.Height = 13
      EditLabel.Caption = 'Token'
      EditLabel.ParentShowHint = False
      EditLabel.ShowHint = True
      LabelPosition = lpLeft
      TabOrder = 3
    end
    object edtProvedor: TLabeledEdit
      Left = 76
      Top = 80
      Width = 633
      Height = 21
      Color = clWhite
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Hint = 'O usu'#225'rio '#233' user'
      EditLabel.Caption = 'Provedor'
      EditLabel.ParentShowHint = False
      EditLabel.ShowHint = True
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 4
    end
    object edtExpiracao: TLabeledEdit
      Left = 76
      Top = 104
      Width = 633
      Height = 21
      Color = clWhite
      EditLabel.Width = 47
      EditLabel.Height = 13
      EditLabel.Hint = 'O usu'#225'rio '#233' user'
      EditLabel.Caption = 'Expira'#231#227'o'
      EditLabel.ParentShowHint = False
      EditLabel.ShowHint = True
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 5
    end
    object edtMensagem: TLabeledEdit
      Left = 76
      Top = 128
      Width = 293
      Height = 21
      Color = clWhite
      EditLabel.Width = 51
      EditLabel.Height = 13
      EditLabel.Caption = 'Mensagem'
      EditLabel.ParentShowHint = False
      EditLabel.ShowHint = True
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 6
    end
    object edtLiberado: TLabeledEdit
      Left = 484
      Top = 129
      Width = 224
      Height = 21
      Color = clWhite
      EditLabel.Width = 78
      EditLabel.Height = 13
      EditLabel.Caption = 'Acesso Liberado'
      EditLabel.ParentShowHint = False
      EditLabel.ShowHint = True
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 7
    end
  end
  object pagina: TPageControl
    Left = 0
    Top = 238
    Width = 742
    Height = 189
    ActivePage = tabLancarPontos
    Align = alClient
    TabOrder = 2
    OnChange = paginaChange
    object tabLancarPontos: TTabSheet
      Caption = 'Lan'#231'ar Pontos'
      object lblCaptionDataJogo: TLabel
        Left = 24
        Top = 24
        Width = 49
        Height = 13
        Caption = 'Data Jogo'
      end
      object Label1: TLabel
        Left = 151
        Top = 24
        Width = 33
        Height = 13
        Caption = 'Pontos'
      end
      object dtDataJogo: TDateTimePicker
        Left = 24
        Top = 43
        Width = 105
        Height = 21
        Date = 43629.905107835650000000
        Time = 43629.905107835650000000
        TabOrder = 0
      end
      object spePontos: TSpinEdit
        Left = 149
        Top = 43
        Width = 121
        Height = 22
        MaxLength = 3
        MaxValue = 999
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object btnSalvar: TButton
        Left = 288
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Salvar'
        TabOrder = 2
        OnClick = btnSalvarClick
      end
    end
    object tabVerResultados: TTabSheet
      Caption = 'Ver Resultados'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 158
      object memRecorde: TMemo
        Left = 0
        Top = 0
        Width = 734
        Height = 161
        Align = alClient
        Lines.Strings = (
          'memRecorde')
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
end
