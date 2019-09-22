object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'An'#225'lise Pre'#231'o Combust'#237'veis - Marcio Cruz - 20/09/2019'
  ClientHeight = 487
  ClientWidth = 754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grpOpcoes: TGroupBox
    Left = 0
    Top = 0
    Width = 754
    Height = 129
    Align = alTop
    Caption = 'Op'#231#245'es'
    TabOrder = 0
    object btnSelecionarArquivo: TSpeedButton
      Left = 24
      Top = 79
      Width = 121
      Height = 22
      Action = actSelecionarCSV
    end
    object btnImportarCSV: TSpeedButton
      Left = 168
      Top = 80
      Width = 154
      Height = 22
      Action = actAnalisar
    end
    object lblEdit: TLabeledEdit
      Left = 24
      Top = 40
      Width = 641
      Height = 21
      EditLabel.Width = 97
      EditLabel.Height = 13
      EditLabel.Caption = 'Selecionar o arquivo'
      TabOrder = 0
      Text = 
        'C:\projetos\marcio\estudos\Delphi\provas\AnalisePrecoCombustivei' +
        's\SEMANAL_MUNICIPIOS-2019.csv'
    end
  end
  object pagina: TPageControl
    Left = 0
    Top = 129
    Width = 754
    Height = 339
    ActivePage = tabMediaMesAMes
    Align = alClient
    TabOrder = 1
    object tabMediaMesAMes: TTabSheet
      Caption = 'M'#234's x Ano x Cidade x Produto'
      object DBGridMesAMes: TDBGrid
        Left = 0
        Top = 0
        Width = 746
        Height = 270
        Align = alClient
        DataSource = dtsMesAMes
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Panel1: TPanel
        Left = 0
        Top = 270
        Width = 746
        Height = 41
        Align = alBottom
        TabOrder = 1
        object Label1: TLabel
          Left = 1
          Top = 1
          Width = 744
          Height = 39
          Align = alClient
          Alignment = taCenter
          Caption = 
            'Req a)  Estes valores est'#227'o distribu'#237'dos em dados semanais, agru' +
            'pe eles por m'#234's e calcule as m'#233'dias de valores de cada combust'#237'v' +
            'el por cidade.  Req c) Calcule a vari'#226'ncia e a varia'#231#227'o absoluta' +
            ' do m'#225'ximo, m'#237'nimo de cada cidade, m'#234's a m'#234's.'
          WordWrap = True
          ExplicitWidth = 733
          ExplicitHeight = 26
        end
      end
    end
    object tabCidadeProduto: TTabSheet
      Caption = 'Cidade x Produto'
      ImageIndex = 4
      object Panel5: TPanel
        Left = 0
        Top = 270
        Width = 746
        Height = 41
        Align = alBottom
        Caption = 
          'Req c) Calcule a vari'#226'ncia e a varia'#231#227'o absoluta do m'#225'ximo, m'#237'ni' +
          'mo de cada cidade e produto. Obs: Eu acho que o item "c" pode se' +
          'r aplicado sem o mensal.'
        TabOrder = 0
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 746
        Height = 270
        Align = alClient
        DataSource = dtsCidadeProduto
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tabCidade: TTabSheet
      Tag = 3
      Caption = 'Cidade'
      ImageIndex = 5
      object Panel6: TPanel
        Left = 0
        Top = 270
        Width = 746
        Height = 41
        Align = alBottom
        Caption = 
          'c) Calcule a vari'#226'ncia e a varia'#231#227'o absoluta do m'#225'ximo, m'#237'nimo d' +
          'e cada cidade, m'#234's a m'#234's. Observa'#231#227'o: Literalmente, "misturando"' +
          ' os valores de cada produto.o'
        TabOrder = 0
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 746
        Height = 270
        Align = alClient
        DataSource = dtsCidade
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tabMediaPorRegiao: TTabSheet
      Caption = 'Regi'#227'o x Produto'
      ImageIndex = 1
      object DBGridMediaRegiao: TDBGrid
        Left = 0
        Top = 0
        Width = 746
        Height = 270
        Align = alClient
        DataSource = dtsMediaPorRegiao
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Panel2: TPanel
        Left = 0
        Top = 270
        Width = 746
        Height = 41
        Align = alBottom
        Caption = 'Req b) Calcule a m'#233'dia de valor do combust'#237'vel por regi'#227'o.'
        TabOrder = 1
      end
    end
    object tabMediaPorUF: TTabSheet
      Caption = 'UF x Produto'
      ImageIndex = 2
      object DBMediaPorUF: TDBGrid
        Left = 0
        Top = 0
        Width = 746
        Height = 270
        Align = alClient
        DataSource = dtsMediaPorUf
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Panel3: TPanel
        Left = 0
        Top = 270
        Width = 746
        Height = 41
        Align = alBottom
        Caption = 'Req b) Calcule a m'#233'dia de valor do combust'#237'vel por Estado'
        TabOrder = 1
      end
    end
    object tabMaioresDiferencas: TTabSheet
      Caption = 'Cinco maiores diferen'#231'as por Produto'
      ImageIndex = 3
      object Panel4: TPanel
        Left = 0
        Top = 270
        Width = 746
        Height = 41
        Align = alBottom
        Caption = 
          'd) Quais s'#227'o as 5 cidades que possuem a maior diferen'#231'a entre o ' +
          'combust'#237'vel mais barato e o mais caro.'
        TabOrder = 0
      end
      object DBMaioresDiferencas: TDBGrid
        Left = 0
        Top = 0
        Width = 746
        Height = 270
        Align = alClient
        DataSource = dtsMaioresDiferencas
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object sttProcessamento: TStatusBar
    Left = 0
    Top = 468
    Width = 754
    Height = 19
    Panels = <
      item
        Width = 500
      end
      item
        Width = 50
      end>
  end
  object openFile: TOpenTextFileDialog
    Filter = 'CSV|*.CSV'
    Left = 544
    Top = 296
  end
  object actContainer: TActionList
    Left = 560
    Top = 96
    object actSelecionarCSV: TAction
      Caption = 'Selecionar CSV'
      OnExecute = actSelecionarCSVExecute
    end
    object actAnalisar: TAction
      Caption = 'Importar e Analisar'
      OnExecute = actAnalisarExecute
      OnUpdate = actAnalisarUpdate
    end
  end
  object dtsMesAMes: TDataSource
    Left = 624
    Top = 80
  end
  object dtsMediaPorRegiao: TDataSource
    Left = 632
    Top = 136
  end
  object dtsMediaPorUf: TDataSource
    Left = 632
    Top = 192
  end
  object dtsMaioresDiferencas: TDataSource
    AutoEdit = False
    Left = 644
    Top = 249
  end
  object dtsCidadeProduto: TDataSource
    AutoEdit = False
    Left = 652
    Top = 305
  end
  object dtsCidade: TDataSource
    Left = 652
    Top = 369
  end
end
