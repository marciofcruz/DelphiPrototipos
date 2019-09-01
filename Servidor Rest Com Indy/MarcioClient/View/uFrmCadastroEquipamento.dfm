inherited frmCadastroEquipamento: TfrmCadastroEquipamento
  Caption = 'Equipamentos'
  ClientHeight = 486
  ClientWidth = 782
  ExplicitWidth = 798
  ExplicitHeight = 524
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlOperacoes: TPanel
    Width = 782
    ExplicitWidth = 782
    inherited btnSincronizar: TButton
      Left = 733
      ExplicitLeft = 733
    end
    object Button6: TButton
      Left = 477
      Top = 16
      Width = 75
      Height = 25
      Action = actDevolver
      TabOrder = 6
    end
    object Button7: TButton
      Left = 565
      Top = 16
      Width = 116
      Height = 25
      Action = actCancelarDevolucao
      TabOrder = 7
      OnClick = Button7Click
    end
  end
  inherited pnlPrincipal: TPanel
    Width = 782
    Height = 429
    ExplicitWidth = 782
    ExplicitHeight = 429
    inherited pagina: TPageControl
      Width = 776
      Height = 313
      ActivePage = tabManutencao
      ExplicitWidth = 776
      ExplicitHeight = 313
      inherited tabVisualizacao: TTabSheet
        ExplicitWidth = 768
        ExplicitHeight = 285
        inherited DBGridPrincipal: TDBGrid
          Width = 768
          Height = 285
        end
      end
      inherited tabManutencao: TTabSheet
        ExplicitWidth = 768
        ExplicitHeight = 285
        object StaticText2: TStaticText
          Left = 36
          Top = 69
          Width = 46
          Height = 17
          Caption = 'Entrada:'
          TabOrder = 2
        end
        object dtEntrada: TDateTimePicker
          Left = 104
          Top = 64
          Width = 115
          Height = 21
          Date = 43506.000000000000000000
          Time = 0.912887939812208000
          TabOrder = 3
        end
        object StaticText4: TStaticText
          Left = 36
          Top = 97
          Width = 56
          Height = 17
          Caption = 'Nome Eqp:'
          TabOrder = 4
        end
        object edtNome: TEdit
          Left = 104
          Top = 94
          Width = 456
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 50
          TabOrder = 5
          Text = 'EDTNOME'
        end
        object StaticText5: TStaticText
          Left = 36
          Top = 129
          Width = 32
          Height = 17
          Caption = 'S'#233'rie:'
          TabOrder = 6
        end
        object edtSerie: TEdit
          Left = 104
          Top = 126
          Width = 456
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 30
          TabOrder = 7
          Text = 'EDTNOME'
        end
        object StaticText6: TStaticText
          Left = 36
          Top = 158
          Width = 55
          Height = 17
          Caption = 'Categoria:'
          TabOrder = 8
        end
        object edtCategoria: TEdit
          Left = 104
          Top = 155
          Width = 456
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 30
          TabOrder = 9
          Text = 'EDTNOME'
        end
        object cobModelo: TComboBoxEx
          Left = 102
          Top = 188
          Width = 452
          Height = 22
          ItemsEx = <
            item
            end>
          Style = csExDropDownList
          TabOrder = 10
          DropDownCount = 25
        end
        object StaticText7: TStaticText
          Left = 36
          Top = 191
          Width = 42
          Height = 17
          Caption = 'Modelo:'
          TabOrder = 11
        end
      end
    end
    inherited pnlParametrosPesquisa: TPanel
      Width = 776
      ExplicitWidth = 776
      inherited grbParametrosPesquisa: TGroupBox
        Width = 770
        ExplicitWidth = 770
        inherited cobOpcoesDataEntrada: TComboBox
          Items.Strings = (
            'IGUAL'
            'MAIOR OU IGUAL'
            'MENOR OU IGUAL'
            'ENTRE')
        end
        inherited cobOpcoesDataSaida: TComboBox
          Items.Strings = (
            'IGUAL'
            'MAIOR OU IGUAL'
            'MENOR OU IGUAL'
            'ENTRE')
        end
      end
    end
  end
  inherited ActionList1: TActionList
    Top = 73
    inherited actNovo: TAction
      Caption = 'Entrada'
    end
    object actDevolver: TAction
      Category = 'Outros'
      Caption = 'Devolver'
      OnExecute = actDevolverExecute
      OnUpdate = actDevolverUpdate
    end
    object actCancelarDevolucao: TAction
      Category = 'Outros'
      Caption = 'Cancelar Devolu'#231#227'o'
      OnUpdate = actCancelarDevolucaoUpdate
    end
  end
  inherited dtsMain: TDataSource
    Top = 72
  end
  inherited FDMain: TFDMemTable
    Top = 164
  end
  object FDModelos: TFDMemTable
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
    Left = 135
    Top = 168
    object FDModelosCHAVEINTERNA: TIntegerField
      FieldName = 'CHAVEINTERNA'
    end
    object FDModelosEXCLUIDO: TIntegerField
      FieldName = 'EXCLUIDO'
    end
    object FDModelosREVISAO: TIntegerField
      FieldName = 'REVISAO'
    end
    object FDModelosALTERADO: TIntegerField
      FieldName = 'ALTERADO'
    end
    object FDModelosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object FDModelosFABRICANTE: TIntegerField
      FieldName = 'FABRICANTE'
    end
    object FDModelosDESCFABRICANTE: TStringField
      FieldName = 'DESCFABRICANTE'
      Size = 50
    end
    object FDModelosCAPTION: TStringField
      FieldName = 'CAPTION'
      Size = 100
    end
    object FDModelosITEMINDEX: TIntegerField
      FieldName = 'ITEMINDEX'
    end
  end
end
