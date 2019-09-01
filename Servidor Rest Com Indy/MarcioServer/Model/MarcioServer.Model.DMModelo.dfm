inherited DMModelo: TDMModelo
  OldCreateOrder = True
  Height = 400
  Width = 648
  object FDListaModelo: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'select'
      'MODELO.MODELO,'
      'MODELO.DESCRICAO,'
      'MODELO.REVISAO,'
      'MODELO.FABRICANTE,'
      'FABRICANTE.DESCRICAO DESCFABRICANTE'
      'from '
      'MODELO'
      
        'inner join FABRICANTE on (FABRICANTE.FABRICANTE=MODELO.FABRICANT' +
        'E)'
      'order by'
      'MODELO.FABRICANTE')
    Left = 440
    Top = 16
    object FDListaModeloMODELO: TFDAutoIncField
      FieldName = 'MODELO'
      Origin = 'MODELO'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDListaModeloDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 50
    end
    object FDListaModeloREVISAO: TIntegerField
      FieldName = 'REVISAO'
      Origin = 'REVISAO'
    end
    object FDListaModeloFABRICANTE: TIntegerField
      FieldName = 'FABRICANTE'
      Origin = 'FABRICANTE'
    end
    object FDListaModeloDESCFABRICANTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCFABRICANTE'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
  end
  object FDEdicao: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'select'
      'MODELO.MODELO,'
      'MODELO.DESCRICAO,'
      'MODELO.REVISAO,'
      'MODELO.FABRICANTE'
      'from '
      'MODELO'
      'WHERE'
      'MODELO.MODELO=:MODELO')
    Left = 440
    Top = 88
    ParamData = <
      item
        Name = 'MODELO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDEdicaoMODELO: TFDAutoIncField
      FieldName = 'MODELO'
      Origin = 'MODELO'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDEdicaoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 50
    end
    object FDEdicaoREVISAO: TIntegerField
      FieldName = 'REVISAO'
      Origin = 'REVISAO'
    end
    object FDEdicaoFABRICANTE: TIntegerField
      FieldName = 'FABRICANTE'
      Origin = 'FABRICANTE'
    end
  end
  object FDModeloRepetido: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'select'
      'COUNT(MODELO.MODELO) QTDE'
      'from '
      'MODELO'
      'WHERE'
      'MODELO.DESCRICAO=:DESCRICAO'
      'and MODELO.FABRICANTE=:FABRICANTE')
    Left = 448
    Top = 160
    ParamData = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'FABRICANTE'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDModeloRepetidoQTDE: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'QTDE'
      Origin = 'QTDE'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDPodeExcluir: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'select'
      'count(equipamento.equipamento) qtde'
      'from'
      'equipamento'
      'where'
      'equipamento.modelo=:MODELO')
    Left = 448
    Top = 256
    ParamData = <
      item
        Name = 'MODELO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDPodeExcluirqtde: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'qtde'
      Origin = 'qtde'
      ProviderFlags = []
      ReadOnly = True
    end
  end
end
