inherited DMJogo: TDMJogo
  OldCreateOrder = True
  Height = 277
  Width = 593
  inherited FDConexao: TFDConnection
    ResourceOptions.AssignedValues = [rvPersistent]
    ResourceOptions.Persistent = True
  end
  object FDListaJogo: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'SELECT'
      'JOGO.DATA,'
      'JOGO.PONTOS'
      'FROM'
      'JOGO'
      'order by'
      'JOGO.DATA')
    Left = 272
    Top = 16
    object FDListaJogoDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'DATA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDListaJogoPONTOS: TIntegerField
      FieldName = 'PONTOS'
      Origin = 'PONTOS'
    end
  end
  object FDEdicao: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'SELECT'
      'JOGO.DATA,'
      'JOGO.PONTOS'
      'FROM'
      'JOGO'
      'where'
      'JOGO.DATA=:DATA')
    Left = 272
    Top = 80
    ParamData = <
      item
        Name = 'DATA'
        DataType = ftDateTime
        ParamType = ptInput
      end>
    object FDEdicaoDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'DATA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDEdicaoPONTOS: TIntegerField
      FieldName = 'PONTOS'
      Origin = 'PONTOS'
    end
  end
end
