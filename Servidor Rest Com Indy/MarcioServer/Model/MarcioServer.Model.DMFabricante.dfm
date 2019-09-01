inherited DMFabricante: TDMFabricante
  OldCreateOrder = True
  Height = 277
  Width = 593
  inherited FDConexao: TFDConnection
    ResourceOptions.AssignedValues = [rvPersistent]
    ResourceOptions.Persistent = True
  end
  object FDListaFabricante: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'SELECT'
      'FABRICANTE.ROWID AS ROWID,'
      'FABRICANTE.FABRICANTE,'
      'FABRICANTE.DESCRICAO,'
      'FABRICANTE.REVISAO'
      'FROM'
      'FABRICANTE'
      'order by'
      'FABRICANTE.DESCRICAO')
    Left = 272
    Top = 16
    object FDListaFabricanteROWID: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'ROWID'
      Origin = 'FABRICANTE'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDListaFabricanteFABRICANTE: TFDAutoIncField
      FieldName = 'FABRICANTE'
      Origin = 'FABRICANTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object FDListaFabricanteDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 50
    end
    object FDListaFabricanteREVISAO: TIntegerField
      FieldName = 'REVISAO'
      Origin = 'REVISAO'
    end
  end
  object FDEdicao: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'SELECT'
      'FABRICANTE.FABRICANTE,'
      'FABRICANTE.DESCRICAO,'
      'FABRICANTE.REVISAO'
      'FROM'
      'FABRICANTE'
      'where'
      'FABRICANTE.FABRICANTE=:FABRICANTE')
    Left = 272
    Top = 80
    ParamData = <
      item
        Name = 'FABRICANTE'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDEdicaoFABRICANTE: TFDAutoIncField
      FieldName = 'FABRICANTE'
      Origin = 'FABRICANTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
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
  end
  object FDFabricanteUsadoModelo: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'select'
      'COUNT(MODELO.MODELO) QTDE'
      'from'
      'MODELO'
      'WHERE'
      'MODELO.FABRICANTE=:FABRICANTE')
    Left = 408
    Top = 72
    ParamData = <
      item
        Name = 'FABRICANTE'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDFabricanteUsadoModeloQTDE: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'QTDE'
      Origin = 'QTDE'
      ProviderFlags = []
      ReadOnly = True
    end
  end
end
