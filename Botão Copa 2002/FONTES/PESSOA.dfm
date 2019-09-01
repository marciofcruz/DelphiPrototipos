object frmpessoa: Tfrmpessoa
  Left = 137
  Top = 96
  AlphaBlend = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmpessoa'
  ClientHeight = 384
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnutblGeral
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TbBarraBotoes: TToolBar
    Left = 0
    Top = 0
    Width = 536
    Height = 29
    ButtonWidth = 30
    Caption = 'TbBarraBotoes'
    Flat = True
    Images = Modulo.imgbotoes
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object btnFechar: TToolButton
      Left = 0
      Top = 0
      Hint = 'Fechar'
      Caption = '&Fechar'
      ImageIndex = 5
      MenuItem = mniFechar
    end
    object ToolButton1: TToolButton
      Left = 30
      Top = 0
      Width = 10
      Caption = 'ToolButton1'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object btnPrimeiro: TToolButton
      Left = 40
      Top = 0
      Hint = 'Primeiro'
      Caption = '&Primeiro'
      ImageIndex = 0
      OnClick = mniPrimeiroClick
    end
    object btnAnterior: TToolButton
      Left = 70
      Top = 0
      Hint = 'Anterior'
      Caption = 'A&nterior'
      Grouped = True
      ImageIndex = 1
      OnClick = mniAnteriorClick
    end
    object btnProximo: TToolButton
      Left = 100
      Top = 0
      Hint = 'Pr'#243'ximo'
      Caption = 'P&r'#243'ximo'
      Grouped = True
      ImageIndex = 2
      OnClick = mniProximoClick
    end
    object btnUltimo: TToolButton
      Left = 130
      Top = 0
      Hint = #218'ltimo'
      Caption = '&'#218'ltimo'
      Grouped = True
      ImageIndex = 3
      OnClick = mniUltimoClick
    end
    object btnLocalizar: TToolButton
      Left = 160
      Top = 0
      Hint = 'Localizar'
      Caption = '&Localizar'
      ImageIndex = 11
      OnClick = mniLocalizarClick
    end
    object btnDetalhes: TToolButton
      Left = 190
      Top = 0
      Hint = 'Detalhes'
      Caption = '&Detalhes'
      ImageIndex = 9
      OnClick = mniDetalhesClick
    end
    object ToolButton2: TToolButton
      Left = 220
      Top = 0
      Width = 10
      Caption = 'ToolButton2'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object btnNovo: TToolButton
      Left = 230
      Top = 0
      Hint = 'Incluir'
      Caption = '&Incluir'
      ImageIndex = 8
      OnClick = mniNovoClick
    end
    object btnAlterar: TToolButton
      Left = 260
      Top = 0
      Hint = 'Alterar'
      Caption = '&Alterar'
      ImageIndex = 4
      OnClick = mniAlterarClick
    end
    object btnExcluir: TToolButton
      Left = 290
      Top = 0
      Hint = 'Excluir'
      Caption = '&Excluir'
      ImageIndex = 14
      OnClick = mniExcluirClick
    end
    object btnSalvar: TToolButton
      Left = 320
      Top = 0
      Hint = 'Salvar'
      Caption = '&Salvar'
      ImageIndex = 6
      OnClick = mniSalvarClick
    end
    object btnCancelar: TToolButton
      Left = 350
      Top = 0
      Hint = 'Cancelar'
      Caption = '&Cancelar'
      ImageIndex = 7
      OnClick = mniCancelarClick
    end
    object btnpreencher: TToolButton
      Left = 380
      Top = 0
      Caption = 'btnpreencher'
      ImageIndex = 20
      OnClick = mnipreencherClick
    end
    object btnimpressao: TToolButton
      Left = 410
      Top = 0
      Caption = 'btnimpressao'
      ImageIndex = 13
      OnClick = mniImpressaoClick
    end
  end
  object pagGeral: TPageControl
    Left = 0
    Top = 29
    Width = 536
    Height = 334
    ActivePage = tabprocura
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    object tabprocura: TTabSheet
      Caption = 'tabprocura'
      object panprocura: TPanel
        Left = 0
        Top = 0
        Width = 528
        Height = 35
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          528
          35)
        object btnProcurar: TSpeedButton
          Left = 440
          Top = 6
          Width = 76
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '&Procurar'
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333FFF333333333333000333333333
            3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
            3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
            0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
            BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
            33337777773FF733333333333300033333333333337773333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          OnClick = btnProcurarClick
        end
        object cobIndice: TComboBox
          Left = 4
          Top = 6
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cobIndiceChange
          OnClick = cobIndiceClick
          OnExit = cobIndiceExit
          OnKeyDown = cobIndiceKeyDown
          OnKeyPress = cobIndiceKeyPress
          Items.Strings = (
            'C'#243'digo'
            'Nome')
        end
        object edtProcurar: TMaskEdit
          Left = 164
          Top = 6
          Width = 261
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          TabOrder = 1
          OnKeyPress = edtProcurarKeyPress
        end
      end
      object dcGridPrincipal: TDBGrid
        Left = 0
        Top = 35
        Width = 528
        Height = 271
        Align = alClient
        DataSource = dsGeral
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = mniDetalhesClick
        OnKeyPress = dcGridPrincipalKeyPress
        Columns = <
          item
            Alignment = taRightJustify
            Expanded = False
            Width = 200
            Visible = True
          end>
      end
    end
    object tabmanutencao: TTabSheet
      Caption = 'tabmanutencao'
      ImageIndex = 1
      object Label3: TLabel
        Left = 8
        Top = 48
        Width = 33
        Height = 13
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 8
        Top = 140
        Width = 37
        Height = 13
        Caption = 'Senha'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 4
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object lblcodigo: TLabel
        Left = 9
        Top = 23
        Width = 64
        Height = 13
        AutoSize = False
        Caption = 'C'#243'digo'
        Color = clWhite
        ParentColor = False
      end
      object edtnome: TEdit
        Left = 8
        Top = 64
        Width = 409
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 40
        TabOrder = 0
        Text = 'EDTSIGLA'
      end
      object ckbpago: TCheckBox
        Left = 8
        Top = 108
        Width = 97
        Height = 17
        Caption = 'Pago'
        TabOrder = 1
      end
      object edtsenha: TEdit
        Left = 8
        Top = 156
        Width = 111
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 2
        Text = 'EDTSIGLA'
      end
      object btngerarsenha: TButton
        Left = 138
        Top = 154
        Width = 83
        Height = 25
        Caption = 'Gerar senha...'
        TabOrder = 3
        OnClick = btngerarsenhaClick
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 363
    Width = 536
    Height = 21
    Panels = <
      item
        Width = 333
      end
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Alignment = taCenter
        Bevel = pbRaised
        Width = 100
      end
      item
        Width = 10
      end>
    SimplePanel = False
  end
  object mnutblGeral: TMainMenu
    Images = Modulo.imgbotoes
    Left = 332
    Top = 110
    object mniOpcoes: TMenuItem
      Caption = '&Op'#231#245'es'
      GroupIndex = 1
      object mniPrimeiro: TMenuItem
        Caption = '&Primeiro'
        Hint = 'Primeiro'
        ImageIndex = 0
        ShortCut = 16422
        OnClick = mniPrimeiroClick
      end
      object mniAnterior: TMenuItem
        Caption = 'A&nterior'
        Hint = 'Anterior'
        ImageIndex = 1
        ShortCut = 16421
        OnClick = mniAnteriorClick
      end
      object mniProximo: TMenuItem
        Caption = 'P&r'#243'ximo'
        Hint = 'Pr'#243'ximo'
        ImageIndex = 2
        ShortCut = 16423
        OnClick = mniProximoClick
      end
      object mniUltimo: TMenuItem
        Caption = '&'#218'ltimo'
        Hint = #218'ltimo'
        ImageIndex = 3
        ShortCut = 16424
        OnClick = mniUltimoClick
      end
      object mniLocalizar: TMenuItem
        Caption = '&Localizar'
        Hint = 'Localizar'
        ImageIndex = 11
        ShortCut = 16460
        OnClick = mniLocalizarClick
      end
      object mniDetalhes: TMenuItem
        Caption = '&Detalhes'
        Hint = 'Detalhes'
        ImageIndex = 9
        ShortCut = 16452
        OnClick = mniDetalhesClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mniNovo: TMenuItem
        Caption = '&Incluir'
        Hint = 'Incluir'
        ImageIndex = 8
        ShortCut = 113
        OnClick = mniNovoClick
      end
      object mniAlterar: TMenuItem
        Caption = '&Alterar'
        Hint = 'Alterar'
        ImageIndex = 4
        ShortCut = 114
        OnClick = mniAlterarClick
      end
      object mniExcluir: TMenuItem
        Caption = '&Excluir'
        Hint = 'Excluir'
        ImageIndex = 14
        ShortCut = 116
        OnClick = mniExcluirClick
      end
      object mniSalvar: TMenuItem
        Caption = '&Salvar'
        Hint = 'Salvar'
        ImageIndex = 6
        ShortCut = 115
        OnClick = mniSalvarClick
      end
      object mniCancelar: TMenuItem
        Caption = '&Cancelar'
        Hint = 'Cancelar'
        ImageIndex = 7
        ShortCut = 27
        OnClick = mniCancelarClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mniImpressao: TMenuItem
        Caption = '&Impress'#227'o...'
        Hint = 'Impress'#227'o'
        ImageIndex = 13
        ShortCut = 16464
        Visible = False
        OnClick = mniImpressaoClick
      end
      object N4: TMenuItem
        Caption = '-'
        Visible = False
      end
      object mnipreencher: TMenuItem
        Caption = 'Preencher tabela...'
        ImageIndex = 20
        ShortCut = 118
        OnClick = mnipreencherClick
      end
      object N3: TMenuItem
        Caption = '-'
        Visible = False
      end
      object mniFechar: TMenuItem
        Caption = '&Fechar'
        Hint = 'Fechar'
        ImageIndex = 5
        ShortCut = 32883
        OnClick = mniFecharClick
      end
    end
  end
  object dtsgeral: TQuery
    Left = 164
    Top = 64
  end
  object dsGeral: TDataSource
    DataSet = dtsgeral
    OnDataChange = dsGeralDataChange
    Left = 212
    Top = 64
  end
end
