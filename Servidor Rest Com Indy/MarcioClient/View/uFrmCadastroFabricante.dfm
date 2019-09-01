inherited frmCadastroFabricante: TfrmCadastroFabricante
  Caption = 'Fabricantes'
  ClientHeight = 391
  ClientWidth = 673
  ExplicitWidth = 689
  ExplicitHeight = 429
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlOperacoes: TPanel
    Width = 673
    ExplicitWidth = 673
  end
  inherited pnlPrincipal: TPanel
    Width = 673
    Height = 334
    ExplicitWidth = 673
    ExplicitHeight = 334
    inherited pagina: TPageControl
      Width = 667
      Height = 328
      ExplicitWidth = 667
      ExplicitHeight = 328
      inherited tabVisualizacao: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 659
        ExplicitHeight = 300
        inherited DBGridPrincipal: TDBGrid
          Width = 659
          Height = 300
          Columns = <
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Caption = 'Nome'
              Visible = True
            end>
        end
      end
      inherited tabManutencao: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 659
        ExplicitHeight = 300
        object edtNome: TEdit
          Left = 97
          Top = 76
          Width = 456
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 50
          TabOrder = 2
          Text = 'EDTNOME'
        end
        object StaticText3: TStaticText
          Left = 48
          Top = 80
          Width = 35
          Height = 17
          Caption = 'Nome:'
          TabOrder = 3
        end
      end
    end
  end
  inherited ActionList1: TActionList
    Top = 217
  end
  inherited dtsMain: TDataSource
    Top = 216
  end
  inherited FDMain: TFDMemTable
    object FDMainDESCRICAO: TStringField [2]
      FieldName = 'DESCRICAO'
      Size = 50
    end
  end
end
