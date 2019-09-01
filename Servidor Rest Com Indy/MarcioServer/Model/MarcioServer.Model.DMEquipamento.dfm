inherited DMEquipamento: TDMEquipamento
  OldCreateOrder = True
  Height = 410
  Width = 767
  object FDListaEquipamento: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'SELECT '
      'EQUIPAMENTO.EQUIPAMENTO,'
      'EQUIPAMENTO.DESCRICAO,'
      'EQUIPAMENTO.REVISAO,'
      'EQUIPAMENTO.MODELO,'
      'EQUIPAMENTO.SERIE,'
      'EQUIPAMENTO.CATEGORIA,'
      'MODELO.DESCRICAO DESCMODELO,'
      'FABRICANTE.DESCRICAO DESCFABRICANTE ,'
      'MODELO.FABRICANTE,'
      'EQUIPAMENTO.DTENTRADA,'
      'EQUIPAMENTO.DTSAIDA'
      'FROM '
      'EQUIPAMENTO'
      'inner join MODELO on (MODELO.MODELO=EQUIPAMENTO.MODELO)'
      
        'inner join FABRICANTE on (FABRICANTE.FABRICANTE=MODELO.FABRICANT' +
        'E)')
    Left = 488
    Top = 40
    object FDListaEquipamentoEQUIPAMENTO: TIntegerField
      FieldName = 'EQUIPAMENTO'
      Origin = 'EQUIPAMENTO'
    end
    object FDListaEquipamentoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
    object FDListaEquipamentoREVISAO: TIntegerField
      FieldName = 'REVISAO'
      Origin = 'REVISAO'
    end
    object FDListaEquipamentoMODELO: TIntegerField
      FieldName = 'MODELO'
      Origin = 'MODELO'
    end
    object FDListaEquipamentoSERIE: TStringField
      FieldName = 'SERIE'
      Origin = 'SERIE'
      Size = 30
    end
    object FDListaEquipamentoCATEGORIA: TStringField
      FieldName = 'CATEGORIA'
      Origin = 'CATEGORIA'
      Size = 30
    end
    object FDListaEquipamentoDESCMODELO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCMODELO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object FDListaEquipamentoDESCFABRICANTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCFABRICANTE'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object FDListaEquipamentoFABRICANTE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'FABRICANTE'
      Origin = 'FABRICANTE'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDListaEquipamentoDTENTRADA: TSQLTimeStampField
      FieldName = 'DTENTRADA'
      Origin = 'DTENTRADA'
    end
    object FDListaEquipamentoDTSAIDA: TSQLTimeStampField
      FieldName = 'DTSAIDA'
      Origin = 'DTSAIDA'
    end
  end
  object FDEdicao: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'SELECT '
      'EQUIPAMENTO.EQUIPAMENTO,'
      'EQUIPAMENTO.DESCRICAO,'
      'EQUIPAMENTO.REVISAO,'
      'EQUIPAMENTO.MODELO,'
      'EQUIPAMENTO.SERIE,'
      'EQUIPAMENTO.CATEGORIA,'
      'EQUIPAMENTO.DTENTRADA,'
      'EQUIPAMENTO.DTSAIDA'
      'FROM '
      'EQUIPAMENTO'
      'WHERE'
      'EQUIPAMENTO.EQUIPAMENTO=:EQUIPAMENTO')
    Left = 488
    Top = 112
    ParamData = <
      item
        Name = 'EQUIPAMENTO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDEdicaoEQUIPAMENTO: TIntegerField
      FieldName = 'EQUIPAMENTO'
      Origin = 'EQUIPAMENTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDEdicaoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
    object FDEdicaoREVISAO: TIntegerField
      FieldName = 'REVISAO'
      Origin = 'REVISAO'
    end
    object FDEdicaoMODELO: TIntegerField
      FieldName = 'MODELO'
      Origin = 'MODELO'
    end
    object FDEdicaoSERIE: TStringField
      FieldName = 'SERIE'
      Origin = 'SERIE'
      Size = 30
    end
    object FDEdicaoCATEGORIA: TStringField
      FieldName = 'CATEGORIA'
      Origin = 'CATEGORIA'
      Size = 30
    end
    object FDEdicaoDTENTRADA: TSQLTimeStampField
      FieldName = 'DTENTRADA'
      Origin = 'DTENTRADA'
      Required = True
    end
    object FDEdicaoDTSAIDA: TSQLTimeStampField
      FieldName = 'DTSAIDA'
      Origin = 'DTSAIDA'
    end
  end
end
