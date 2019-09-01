inherited frmCadastroModelo: TfrmCadastroModelo
  Caption = 'Modelos'
  ClientHeight = 412
  ClientWidth = 763
  ExplicitWidth = 779
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlOperacoes: TPanel
    Width = 763
    ExplicitWidth = 763
  end
  inherited pnlPrincipal: TPanel
    Width = 763
    Height = 355
    ExplicitWidth = 763
    ExplicitHeight = 355
    inherited pagina: TPageControl
      Width = 757
      Height = 349
      ExplicitWidth = 757
      ExplicitHeight = 349
      inherited tabVisualizacao: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 749
        ExplicitHeight = 321
        inherited DBGridPrincipal: TDBGrid
          Width = 749
          Height = 321
          Columns = <
            item
              Expanded = False
              FieldName = 'DESCRICAO'
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
        ExplicitTop = 24
        ExplicitWidth = 749
        ExplicitHeight = 321
        object StaticText3: TStaticText
          Left = 48
          Top = 80
          Width = 42
          Height = 17
          Caption = 'Modelo:'
          TabOrder = 2
        end
        object edtModelo: TEdit
          Left = 105
          Top = 76
          Width = 456
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 50
          TabOrder = 3
          Text = 'EDTNOME'
        end
        object cobFabricante: TComboBoxEx
          Left = 109
          Top = 120
          Width = 452
          Height = 22
          ItemsEx = <
            item
            end>
          Style = csExDropDownList
          TabOrder = 4
          DropDownCount = 25
        end
        object StaticText2: TStaticText
          Left = 48
          Top = 123
          Width = 59
          Height = 17
          Caption = 'Fabricante:'
          TabOrder = 5
        end
      end
    end
  end
  inherited FDMain: TFDMemTable
    object FDMainDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
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
  object FDFabricantes: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 39
    Top = 316
    object FDFabricantesCHAVEINTERNA: TIntegerField
      FieldName = 'CHAVEINTERNA'
    end
    object FDFabricantesEXCLUIDO: TIntegerField
      FieldName = 'EXCLUIDO'
    end
    object FDFabricantesDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object FDFabricantesREVISAO: TIntegerField
      FieldName = 'REVISAO'
    end
    object FDFabricantesALTERADO: TIntegerField
      FieldName = 'ALTERADO'
    end
    object FDFabricantesITEMINDEX: TIntegerField
      FieldName = 'ITEMINDEX'
    end
  end
  object dtsFabricantes: TDataSource
    AutoEdit = False
    DataSet = FDFabricantes
    Left = 135
    Top = 316
  end
end
