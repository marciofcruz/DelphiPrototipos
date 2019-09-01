inherited frmBaseEquipamento: TfrmBaseEquipamento
  Caption = 'frmBaseEquipamento'
  ClientHeight = 385
  ClientWidth = 755
  ExplicitWidth = 771
  ExplicitHeight = 423
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlOperacoes: TPanel
    Width = 755
    ExplicitWidth = 755
  end
  inherited pnlPrincipal: TPanel
    Width = 755
    Height = 328
    ExplicitWidth = 755
    ExplicitHeight = 328
    inherited pagina: TPageControl
      Top = 113
      Width = 749
      Height = 212
      ExplicitTop = 113
      ExplicitWidth = 749
      ExplicitHeight = 212
      inherited tabVisualizacao: TTabSheet
        ExplicitWidth = 741
        ExplicitHeight = 184
        inherited DBGridPrincipal: TDBGrid
          Width = 741
          Height = 184
          Columns = <
            item
              Expanded = False
              FieldName = 'DATAENTRADA'
              Title.Caption = 'Entrada'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATASAIDA'
              Title.Caption = 'Sa'#237'da'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Caption = 'Equipamento'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCMODELO'
              Title.Caption = 'Modelo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCFABRICANTE'
              Title.Caption = 'Fabricante'
              Visible = True
            end>
        end
      end
      inherited tabManutencao: TTabSheet
        ExplicitWidth = 741
        ExplicitHeight = 184
      end
    end
    object pnlParametrosPesquisa: TPanel
      Left = 3
      Top = 3
      Width = 749
      Height = 110
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 3
      Padding.Top = 3
      Padding.Right = 3
      Padding.Bottom = 3
      ParentBackground = False
      TabOrder = 1
      object grbParametrosPesquisa: TGroupBox
        Left = 3
        Top = 3
        Width = 743
        Height = 104
        Align = alClient
        Caption = 'Par'#226'metros Pesquisa'
        TabOrder = 0
        object Label1: TLabel
          Left = 519
          Top = 24
          Width = 58
          Height = 13
          Caption = 'Localiza'#231#227'o:'
        end
        object ckbPesquisarDataEntrada: TCheckBox
          Left = 18
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Data Entrada:'
          TabOrder = 0
          OnClick = ckbPesquisarDataEntradaClick
        end
        object cobOpcoesDataEntrada: TComboBox
          Left = 118
          Top = 22
          Width = 115
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnChange = cobOpcoesDataEntradaChange
          Items.Strings = (
            'IGUAL'
            'MAIOR OU IGUAL'
            'MENOR OI IGUAL'
            'ENTRE')
        end
        object dtEntradaInicial: TDateTimePicker
          Left = 255
          Top = 22
          Width = 98
          Height = 21
          Date = 43506.000000000000000000
          Time = 0.716558263891784000
          TabOrder = 2
        end
        object dtEntradaFinal: TDateTimePicker
          Left = 375
          Top = 22
          Width = 98
          Height = 21
          Date = 43506.000000000000000000
          Time = 0.716558263891784000
          TabOrder = 3
        end
        object ckbPesquisarDataSaida: TCheckBox
          Left = 18
          Top = 48
          Width = 97
          Height = 17
          Caption = 'Data Sa'#237'da:'
          TabOrder = 4
          OnClick = ckbPesquisarDataSaidaClick
        end
        object cobOpcoesDataSaida: TComboBox
          Left = 118
          Top = 46
          Width = 115
          Height = 21
          Style = csDropDownList
          TabOrder = 5
          OnChange = cobOpcoesDataSaidaChange
          Items.Strings = (
            'IGUAL'
            'MAIOR OU IGUAL'
            'MENOR OI IGUAL'
            'ENTRE')
        end
        object dtSaidaInicial: TDateTimePicker
          Left = 255
          Top = 46
          Width = 98
          Height = 21
          Date = 43506.000000000000000000
          Time = 0.716558263891784000
          TabOrder = 6
        end
        object dtSaidaFinal: TDateTimePicker
          Left = 375
          Top = 46
          Width = 98
          Height = 21
          Date = 43506.000000000000000000
          Time = 0.716558263891784000
          TabOrder = 7
        end
        object cobLocalizacao: TComboBox
          Left = 590
          Top = 20
          Width = 115
          Height = 21
          Style = csDropDownList
          TabOrder = 8
          OnChange = cobOpcoesDataSaidaChange
          Items.Strings = (
            'TODOS OS LOCAIS'
            'NA EMPRESA'
            'DEVOLVIDOS')
        end
        object ckbProcurarNomeEquipamento: TCheckBox
          Left = 19
          Top = 72
          Width = 73
          Height = 17
          Caption = 'Nome Eqp:'
          TabOrder = 9
          OnClick = ckbProcurarNomeEquipamentoClick
        end
        object edtProcurarDescricao: TEdit
          Left = 118
          Top = 72
          Width = 355
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 10
          Text = 'EDTPROCURARDESCRICAO'
        end
        object btnPesquisar: TButton
          Left = 520
          Top = 68
          Width = 75
          Height = 25
          Action = actPesquisar
          TabOrder = 11
        end
      end
    end
  end
  inherited ActionList1: TActionList
    Left = 520
    Top = 17
    object actPesquisar: TAction
      Category = 'Outros'
      Caption = 'Pesquisar'
      OnExecute = actPesquisarExecute
      OnUpdate = actPesquisarUpdate
    end
  end
  inherited FDMain: TFDMemTable
    object FDMainDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object FDMainSERIE: TStringField
      FieldName = 'SERIE'
      Size = 30
    end
    object FDMainCATEGORIA: TStringField
      FieldName = 'CATEGORIA'
      Size = 30
    end
    object FDMainDATAENTRADA: TDateTimeField
      FieldName = 'DATAENTRADA'
    end
    object FDMainDATASAIDA: TDateTimeField
      FieldName = 'DATASAIDA'
    end
    object FDMainMODELO: TIntegerField
      FieldName = 'MODELO'
    end
    object FDMainDESCMODELO: TStringField
      FieldName = 'DESCMODELO'
      Size = 50
    end
    object FDMainFABRICANTE: TIntegerField
      FieldName = 'FABRICANTE'
    end
    object FDMainDESCFABRICANTE: TStringField
      FieldName = 'DESCFABRICANTE'
      Size = 50
    end
  end
end
