object frmmaincup: Tfrmmaincup
  Left = 167
  Top = 103
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Copa do mundo'
  ClientHeight = 422
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object imgMin: TImage
    Left = 324
    Top = 0
    Width = 105
    Height = 105
    Hint = 'Minimizar'
    ParentShowHint = False
    ShowHint = True
    OnClick = imgMinClick
  end
  object imgQuit: TImage
    Left = 431
    Top = 0
    Width = 105
    Height = 105
    Hint = 'Fechar'
    ParentShowHint = False
    ShowHint = True
    OnClick = imgQuitClick
  end
  object imgbg: TImage
    Left = 4
    Top = 0
    Width = 105
    Height = 105
  end
  object lblPrograma: TLabel
    Left = 139
    Top = 8
    Width = 441
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = 'BOL'#195'O COPA DO MUNDO 2006'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 184
    Top = 76
    Width = 74
    Height = 13
    Caption = 'Usu'#225'rio logado:'
    Transparent = True
  end
  object lblnomeusuario: TLabel
    Left = 264
    Top = 76
    Width = 90
    Height = 13
    Caption = 'Usu'#225'rio logado:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 184
    Top = 94
    Width = 123
    Height = 13
    Caption = 'Apostadores cadastrados:'
    Transparent = True
  end
  object lblquantidadeapostadores: TLabel
    Left = 310
    Top = 94
    Width = 90
    Height = 13
    Caption = 'Usu'#225'rio logado:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 184
    Top = 112
    Width = 122
    Height = 13
    Caption = 'Apostadores confirmados:'
    Transparent = True
  end
  object lblconfirmados: TLabel
    Left = 309
    Top = 112
    Width = 90
    Height = 13
    Caption = 'Usu'#225'rio logado:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 184
    Top = 136
    Width = 335
    Height = 2
  end
  object Label4: TLabel
    Left = 184
    Top = 148
    Width = 71
    Height = 13
    Caption = 'Situa'#231#227'o atual:'
    Transparent = True
  end
  object lblsituacaoatual: TLabel
    Left = 261
    Top = 148
    Width = 90
    Height = 13
    Caption = 'Usu'#225'rio logado:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 184
    Top = 340
    Width = 68
    Height = 13
    Caption = 'M'#225'rcio F. Cruz'
  end
  object Label6: TLabel
    Left = 184
    Top = 356
    Width = 120
    Height = 13
    Caption = 'super.marcio@ig.com.br'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object panbotoes: TPanel
    Left = 8
    Top = 112
    Width = 133
    Height = 277
    AutoSize = True
    BevelOuter = bvNone
    Color = clBlue
    TabOrder = 0
    object panexclusivosupervisor: TPanel
      Left = 0
      Top = 0
      Width = 133
      Height = 100
      Align = alTop
      AutoSize = True
      Color = clBlue
      TabOrder = 0
      object pantabelaoficial: TPanel
        Left = 1
        Top = 1
        Width = 131
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 0
        TabStop = True
        object btnresultados: TButton
          Left = 1
          Top = 1
          Width = 129
          Height = 25
          Caption = 'Prencher tabela oficial...'
          TabOrder = 0
          OnClick = btnresultadosClick
        end
      end
      object panimprimirtabela: TPanel
        Left = 1
        Top = 25
        Width = 131
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 1
        object btnimprimirtabela: TButton
          Left = 1
          Top = 1
          Width = 129
          Height = 25
          Caption = 'Imprimir tabela oficial...'
          TabOrder = 0
          OnClick = btnimprimirtabelaClick
        end
      end
      object panapostadores: TPanel
        Left = 1
        Top = 50
        Width = 131
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 2
        object btnapostadores: TButton
          Left = 1
          Top = 0
          Width = 129
          Height = 25
          Caption = 'Apostadores...'
          TabOrder = 0
          OnClick = btnapostadoresClick
        end
      end
      object panbloqueio: TPanel
        Left = 1
        Top = 74
        Width = 131
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 3
        Visible = False
        object btnbloqueioliberacao: TButton
          Left = 1
          Top = 0
          Width = 129
          Height = 25
          Caption = 'Bloqueio/Libera'#231#227'o...'
          TabOrder = 0
          OnClick = btnbloqueioliberacaoClick
        end
      end
    end
    object panexclusivousuario: TPanel
      Left = 0
      Top = 100
      Width = 133
      Height = 100
      Align = alTop
      BevelOuter = bvNone
      Color = clBlue
      TabOrder = 1
      object pantrocarsenha: TPanel
        Left = 0
        Top = 0
        Width = 133
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 0
        Visible = False
        object btntrocarsenha: TButton
          Left = 2
          Top = 0
          Width = 129
          Height = 25
          Caption = 'Trocar senha...'
          TabOrder = 0
          OnClick = btntrocarsenhaClick
        end
      end
      object panimprimirminhaaposta: TPanel
        Left = 0
        Top = 25
        Width = 133
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 1
        Visible = False
        object btnimprimirminhaaposta: TButton
          Left = 2
          Top = 0
          Width = 129
          Height = 25
          Caption = 'Imprimir minha aposta...'
          TabOrder = 0
          OnClick = btnimprimirminhaapostaClick
        end
      end
      object panminhaaposta: TPanel
        Left = 0
        Top = 50
        Width = 133
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 2
        Visible = False
        object btnminhaaposta: TButton
          Left = 2
          Top = 0
          Width = 129
          Height = 25
          Caption = 'Minha aposta...'
          TabOrder = 0
          OnClick = btnminhaapostaClick
        end
      end
      object panverapostas: TPanel
        Left = 0
        Top = 75
        Width = 133
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 3
        Visible = False
        object btnveroutrasapostas: TButton
          Left = 2
          Top = 0
          Width = 129
          Height = 25
          Caption = 'Ver outras apostas...'
          TabOrder = 0
          OnClick = btnveroutrasapostasClick
        end
      end
    end
    object pangeral: TPanel
      Left = 0
      Top = 200
      Width = 133
      Height = 77
      Align = alTop
      AutoSize = True
      Color = clBlue
      TabOrder = 2
      object panranking: TPanel
        Left = 1
        Top = 1
        Width = 131
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 0
        object btnranking: TButton
          Left = 1
          Top = 0
          Width = 129
          Height = 25
          Caption = 'Ranking...'
          TabOrder = 0
          OnClick = btnrankingClick
        end
      end
      object panregras: TPanel
        Left = 1
        Top = 26
        Width = 131
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 1
        object btnregras: TButton
          Left = 1
          Top = 0
          Width = 129
          Height = 25
          Caption = 'Regras do bol'#227'o...'
          TabOrder = 0
          OnClick = btnregrasClick
        end
      end
      object pansair: TPanel
        Left = 1
        Top = 51
        Width = 131
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 2
        object btnsair: TButton
          Left = 1
          Top = 0
          Width = 129
          Height = 25
          Caption = 'Sair do sistema - ESC'
          TabOrder = 0
          OnClick = btnsairClick
        end
      end
    end
  end
end
