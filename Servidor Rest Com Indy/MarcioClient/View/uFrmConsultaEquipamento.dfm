inherited frmConsultaEquipamento: TfrmConsultaEquipamento
  Caption = 'Consulta de Equipamentos'
  ClientHeight = 362
  ClientWidth = 699
  ExplicitWidth = 715
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlOperacoes: TPanel
    Width = 699
    ExplicitWidth = 699
  end
  inherited pnlPrincipal: TPanel
    Width = 699
    Height = 305
    ExplicitWidth = 699
    ExplicitHeight = 305
    inherited pagina: TPageControl
      Width = 693
      Height = 189
      ExplicitWidth = 693
      ExplicitHeight = 189
      inherited tabVisualizacao: TTabSheet
        ExplicitWidth = 685
        ExplicitHeight = 161
        inherited DBGridPrincipal: TDBGrid
          Width = 685
          Height = 161
        end
      end
      inherited tabManutencao: TTabSheet
        ExplicitWidth = 685
        ExplicitHeight = 161
      end
    end
    inherited pnlParametrosPesquisa: TPanel
      Width = 693
      ExplicitWidth = 693
      inherited grbParametrosPesquisa: TGroupBox
        Width = 687
        ExplicitWidth = 687
      end
    end
  end
end
