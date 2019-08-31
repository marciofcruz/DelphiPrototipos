object DMEntidade: TDMEntidade
  OldCreateOrder = False
  Height = 362
  Width = 588
  object sqlEntidade: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 
      'SELECT'#13#10'ENTIDADE.ENTIDADE,'#13#10'ENTIDADE.NOMECOMPLETO,'#13#10'ENTIDADE.SIT' +
      'UACAO,'#13#10'ENTIDADE.DTCADASTRO,'#13#10'ENTIDADE.ORIGEM,'#13#10'COUNT(IMAGEMENTI' +
      'DADE.IMAGEMENTIDADE) AS QTDEIMAGENS'#13#10'FROM'#13#10'ENTIDADE'#13#10'left join I' +
      'MAGEMENTIDADE ON (IMAGEMENTIDADE.ENTIDADE=ENTIDADE.ENTIDADE AND ' +
      'IMAGEMENTIDADE.SITUACAO=1)'#13#10'WHERE'#13#10'ENTIDADE.SITUACAO=1'#13#10'GROUP BY' +
      #13#10'ENTIDADE.ENTIDADE,'#13#10'ENTIDADE.NOMECOMPLETO,'#13#10'ENTIDADE.SITUACAO,' +
      #13#10'ENTIDADE.DTCADASTRO,'#13#10'ENTIDADE.ORIGEM'#13#10'ORDER BY'#13#10'ENTIDADE.NOME' +
      'COMPLETO'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DMConexao.Conexao
    Left = 48
    Top = 16
    object sqlEntidadeENTIDADE: TIntegerField
      FieldName = 'ENTIDADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqlEntidadeNOMECOMPLETO: TStringField
      FieldName = 'NOMECOMPLETO'
      Size = 100
    end
    object sqlEntidadeSITUACAO: TSmallintField
      FieldName = 'SITUACAO'
    end
    object sqlEntidadeDTCADASTRO: TSQLTimeStampField
      FieldName = 'DTCADASTRO'
    end
    object sqlEntidadeORIGEM: TStringField
      FieldName = 'ORIGEM'
      Size = 10
    end
    object sqlEntidadeQTDEIMAGENS: TIntegerField
      FieldName = 'QTDEIMAGENS'
      ProviderFlags = []
    end
  end
  object dspEntidade: TDataSetProvider
    DataSet = sqlEntidade
    UpdateMode = upWhereKeyOnly
    Left = 128
    Top = 24
  end
  object cdsEntidade: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEntidade'
    Left = 216
    Top = 32
    object cdsEntidadeENTIDADE: TIntegerField
      FieldName = 'ENTIDADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsEntidadeNOMECOMPLETO: TStringField
      FieldName = 'NOMECOMPLETO'
      Size = 100
    end
    object cdsEntidadeSITUACAO: TSmallintField
      FieldName = 'SITUACAO'
    end
    object cdsEntidadeDTCADASTRO: TSQLTimeStampField
      FieldName = 'DTCADASTRO'
    end
    object cdsEntidadeORIGEM: TStringField
      FieldName = 'ORIGEM'
      Size = 10
    end
    object cdsEntidadeQTDEIMAGENS: TIntegerField
      FieldName = 'QTDEIMAGENS'
      ProviderFlags = []
    end
  end
  object sqlProximaChaveEntidade: TSQLDataSet
    CommandText = 'select'#13#10'COALESCE(max(entidade),0)+1 PROXIMA'#13#10'from'#13#10'entidade'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DMConexao.Conexao
    Left = 472
    Top = 16
    object sqlProximaChaveEntidadePROXIMA: TIntegerField
      FieldName = 'PROXIMA'
    end
  end
  object sqlImagemEntidade: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 
      'SELECT '#13#10'IMAGEMENTIDADE.IMAGEMENTIDADE,'#13#10'IMAGEMENTIDADE.ENTIDADE' +
      ','#13#10'IMAGEMENTIDADE.SITUACAO,'#13#10'IMAGEMENTIDADE.DTCADASTRO,'#13#10'IMAGEME' +
      'NTIDADE.FACE'#13#10'FROM '#13#10'IMAGEMENTIDADE'#13#10'WHERE'#13#10'IMAGEMENTIDADE.ENTID' +
      'ADE=:ENTIDADE'#13#10'AND IMAGEMENTIDADE.SITUACAO=1'#13#10'ORDER BY '#13#10'IMAGEME' +
      'NTIDADE.DTCADASTRO'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ENTIDADE'
        ParamType = ptInput
      end>
    SQLConnection = DMConexao.Conexao
    Left = 40
    Top = 160
    object sqlImagemEntidadeIMAGEMENTIDADE: TIntegerField
      FieldName = 'IMAGEMENTIDADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqlImagemEntidadeENTIDADE: TIntegerField
      FieldName = 'ENTIDADE'
    end
    object sqlImagemEntidadeSITUACAO: TSmallintField
      FieldName = 'SITUACAO'
    end
    object sqlImagemEntidadeDTCADASTRO: TSQLTimeStampField
      FieldName = 'DTCADASTRO'
    end
    object sqlImagemEntidadeFACE: TMemoField
      FieldName = 'FACE'
      BlobType = ftMemo
      Size = -1
    end
  end
  object dspImagemEntidade: TDataSetProvider
    DataSet = sqlImagemEntidade
    UpdateMode = upWhereKeyOnly
    Left = 136
    Top = 168
  end
  object cdsImagemEntidade: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'ENTIDADE'
        ParamType = ptInput
      end>
    ProviderName = 'dspImagemEntidade'
    Left = 248
    Top = 152
    object cdsImagemEntidadeIMAGEMENTIDADE: TIntegerField
      FieldName = 'IMAGEMENTIDADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsImagemEntidadeENTIDADE: TIntegerField
      FieldName = 'ENTIDADE'
    end
    object cdsImagemEntidadeSITUACAO: TSmallintField
      FieldName = 'SITUACAO'
    end
    object cdsImagemEntidadeDTCADASTRO: TSQLTimeStampField
      FieldName = 'DTCADASTRO'
    end
    object cdsImagemEntidadeFACE: TMemoField
      FieldName = 'FACE'
      BlobType = ftMemo
    end
  end
  object sqlProximaChaveImagemEntidade: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 
      'select'#13#10'COALESCE(max(IMAGEMENTIDADE),0)+1 PROXIMA'#13#10'from'#13#10'IMAGEME' +
      'NTIDADE'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DMConexao.Conexao
    Left = 480
    Top = 88
    object sqlProximaChaveImagemEntidadePROXIMA: TIntegerField
      FieldName = 'PROXIMA'
    end
  end
  object sqlGetNomeImagem: TSQLDataSet
    CommandText = 
      'select '#13#10'entidade.NOMECOMPLETO,'#13#10'IMAGEMENTIDADE.IMAGEMENTIDADE'#13#10 +
      'from '#13#10'entidade'#13#10'inner join IMAGEMENTIDADE on (IMAGEMENTIDADE.EN' +
      'TIDADE=ENTIDADE.ENTIDADE AND IMAGEMENTIDADE.SITUACAO=1)'#13#10'where'#13#10 +
      'IMAGEMENTIDADE.IMAGEMENTIDADE=:IMAGEMENTIDADE'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'IMAGEMENTIDADE'
        ParamType = ptInput
      end>
    SQLConnection = DMConexao.Conexao
    Left = 40
    Top = 312
    object sqlGetNomeImagemNOMECOMPLETO: TStringField
      FieldName = 'NOMECOMPLETO'
      Size = 100
    end
    object sqlGetNomeImagemIMAGEMENTIDADE: TIntegerField
      FieldName = 'IMAGEMENTIDADE'
    end
  end
  object sqlTodasImagens: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 
      'SELECT '#13#10'IMAGEMENTIDADE.IMAGEMENTIDADE,'#13#10'IMAGEMENTIDADE.ENTIDADE' +
      ','#13#10'IMAGEMENTIDADE.FACE'#13#10'FROM '#13#10'IMAGEMENTIDADE'#13#10'inner join ENTIDA' +
      'DE on (ENTIDADE.ENTIDADE=IMAGEMENTIDADE.ENTIDADE AND ENTIDADE.SI' +
      'TUACAO=1)'#13#10'WHERE'#13#10'IMAGEMENTIDADE.SITUACAO=1'#13#10'ORDER BY '#13#10'IMAGEMEN' +
      'TIDADE.ENTIDADE'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DMConexao.Conexao
    Left = 48
    Top = 232
    object sqlTodasImagensIMAGEMENTIDADE: TIntegerField
      FieldName = 'IMAGEMENTIDADE'
    end
    object sqlTodasImagensENTIDADE: TIntegerField
      FieldName = 'ENTIDADE'
    end
    object sqlTodasImagensFACE: TMemoField
      FieldName = 'FACE'
      BlobType = ftMemo
      Size = -1
    end
  end
  object dspTodasImagens: TDataSetProvider
    DataSet = sqlTodasImagens
    Left = 152
    Top = 248
  end
  object cdsTodasImagens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTodasImagens'
    Left = 248
    Top = 232
    object cdsTodasImagensIMAGEMENTIDADE: TIntegerField
      FieldName = 'IMAGEMENTIDADE'
    end
    object cdsTodasImagensENTIDADE: TIntegerField
      FieldName = 'ENTIDADE'
    end
    object cdsTodasImagensFACE: TMemoField
      FieldName = 'FACE'
      BlobType = ftMemo
    end
  end
end
