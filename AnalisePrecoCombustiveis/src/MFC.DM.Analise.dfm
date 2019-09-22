object DMAnalise: TDMAnalise
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 385
  Width = 682
  object FDMediaPorCidade: TFDMemTable
    IndexFieldNames = 'CHAVE;ESTADO'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 40
    Top = 24
    object FDMediaPorCidadeCHAVE: TStringField
      FieldName = 'CHAVE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey, pfHidden]
      Visible = False
      Size = 50
    end
    object FDMediaPorCidadeANO: TIntegerField
      DisplayLabel = 'Ano'
      FieldName = 'ANO'
    end
    object FDMediaPorCidadeMES: TIntegerField
      DisplayLabel = 'M'#234's'
      FieldName = 'MES'
      KeyFields = 'ANO'
    end
    object FDMediaPorCidadeESTADO: TStringField
      DisplayLabel = 'UF'
      FieldName = 'ESTADO'
      Size = 30
    end
    object FDMediaPorCidadeCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 50
    end
    object FDMediaPorCidadePRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'PRODUTO'
      Size = 50
    end
    object FDMediaPorCidadePRECOMEDIOREVENDA: TFloatField
      DisplayLabel = 'Pre'#231'o M'#233'dio Revenda'
      FieldName = 'PRECOMEDIOREVENDA'
    end
    object FDMediaPorCidadePRECOREVENDAMIN: TFloatField
      FieldName = 'PRECOREVENDAMIN'
      Visible = False
    end
    object FDMediaPorCidadePRECOREVENDAMAX: TFloatField
      FieldName = 'PRECOREVENDAMAX'
      Visible = False
    end
    object FDMediaPorCidadeVARIACAOABSOLUTA: TFloatField
      DisplayLabel = 'Varia'#231#227'o Absoluta'
      FieldName = 'VARIACAOABSOLUTA'
    end
    object FDMediaPorCidadeTOTALPRECOREVENDA: TFloatField
      FieldName = 'TOTALPRECOREVENDA'
      Visible = False
    end
    object FDMediaPorCidadeQTDE: TIntegerField
      FieldName = 'QTDE'
      Visible = False
    end
    object FDMediaPorCidadeVARIANCIAPOPULACIONAL: TFloatField
      DisplayLabel = 'Vari'#226'ncia Populacional'
      FieldName = 'VARIANCIAPOPULACIONAL'
    end
  end
  object FDMediaPorRegiao: TFDMemTable
    IndexFieldNames = 'CHAVE;ESTADO'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 96
    object FDMediaPorRegiaoCHAVE: TStringField
      FieldName = 'CHAVE'
      Visible = False
      Size = 50
    end
    object FDMediaPorRegiaoREGIAO: TStringField
      DisplayLabel = 'Regi'#227'o'
      FieldName = 'REGIAO'
      Size = 30
    end
    object FDMediaPorRegiaoPRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'PRODUTO'
      Size = 50
    end
    object FDMediaPorRegiaoPRECOMEDIOREVENDA: TFloatField
      DisplayLabel = 'Pre'#231'o M'#233'dio Revenda'
      FieldName = 'PRECOMEDIOREVENDA'
    end
    object FDMediaPorRegiaoTOTALPRECOMEDIO: TFloatField
      FieldName = 'TOTALPRECOMEDIO'
      Visible = False
    end
    object FDMediaPorRegiaoAMOSTRAS: TIntegerField
      FieldName = 'QTDE'
      Visible = False
    end
  end
  object FDMediaPorUF: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 160
    object FDMediaPorUFCHAVE: TStringField
      FieldName = 'CHAVE'
      Visible = False
      Size = 50
    end
    object FDMediaPorUFREGIAO: TStringField
      DisplayLabel = 'Regi'#227'o'
      FieldName = 'REGIAO'
      Visible = False
      Size = 30
    end
    object FDMediaPorUFUF: TStringField
      FieldName = 'UF'
      Size = 30
    end
    object FDMediaPorUFPRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'PRODUTO'
      Size = 50
    end
    object FDMediaPorUFPRECOMEDIOREVENDA: TFloatField
      DisplayLabel = 'Pre'#231'o M'#233'dio Revenda'
      FieldName = 'PRECOMEDIOREVENDA'
    end
    object FDMediaPorUFTOTALPRECOMEDIO: TFloatField
      FieldName = 'TOTALPRECOMEDIO'
      Visible = False
    end
    object FDMediaPorUFQTDE: TIntegerField
      FieldName = 'QTDE'
      Visible = False
    end
  end
  object FDAmostragem: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 352
    Top = 200
  end
  object FDDiferencaPreco: TFDMemTable
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'FDDiferencaPrecoIndex1'
      end>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 344
    Top = 80
    object FDDiferencaPrecoCHAVE: TStringField
      FieldName = 'CHAVE'
      Visible = False
      Size = 30
    end
    object FDDiferencaPrecoPRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'PRODUTO'
      Size = 50
    end
    object FDDiferencaPrecoCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 50
    end
    object FDDiferencaPrecoESTADO: TStringField
      DisplayLabel = 'UF'
      FieldName = 'ESTADO'
      Size = 30
    end
    object FDDiferencaPrecoDIFERENCA: TFloatField
      DisplayLabel = 'Diferen'#231'a'
      FieldName = 'DIFERENCA'
    end
    object FDDiferencaPrecoMENORPRECO: TFloatField
      FieldName = 'MENORPRECO'
      Visible = False
    end
    object FDDiferencaPrecoMAIORPRECO: TFloatField
      FieldName = 'MAIORPRECO'
      Visible = False
    end
  end
  object FDCidadeProduto: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 232
    object FDCidadeProdutoCHAVE: TStringField
      FieldName = 'CHAVE'
      Visible = False
      Size = 50
    end
    object FDCidadeProdutoESTADO: TStringField
      DisplayLabel = 'UF'
      FieldName = 'ESTADO'
      Size = 30
    end
    object FDCidadeProdutoCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 50
    end
    object FDCidadeProdutoPRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'PRODUTO'
      Size = 50
    end
    object FDCidadeProdutoPRECOREVENDAMIN: TFloatField
      DisplayLabel = 'Menor PV'
      FieldName = 'PRECOREVENDAMIN'
      Visible = False
    end
    object FDCidadeProdutoPRECOREVENDAMAX: TFloatField
      DisplayLabel = 'Maior PV'
      FieldName = 'PRECOREVENDAMAX'
      Visible = False
    end
    object FDCidadeProdutoVARIACAOABSOLUTA: TFloatField
      DisplayLabel = 'Varia'#231#227'o Absoluta'
      FieldName = 'VARIACAOABSOLUTA'
    end
    object FDCidadeProdutoQTDE: TIntegerField
      FieldName = 'QTDE'
      Visible = False
    end
    object FDCidadeProdutoVARIANCIAPOPULACIONAL: TFloatField
      DisplayLabel = 'Vari'#226'ncia Populacional'
      FieldName = 'VARIANCIAPOPULACIONAL'
    end
  end
  object FDCidade: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 312
    object FDCidadeCHAVE: TStringField
      FieldName = 'CHAVE'
      Visible = False
      Size = 50
    end
    object FDCidadeANO: TIntegerField
      DisplayLabel = 'Ano'
      FieldName = 'ANO'
    end
    object FDCidadeMES: TIntegerField
      DisplayLabel = 'M'#234's'
      FieldName = 'MES'
    end
    object FDCidadeESTADO: TStringField
      DisplayLabel = 'UF'
      FieldName = 'ESTADO'
      Size = 30
    end
    object FDCidadeCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 50
    end
    object FDCidadePRECOREVENDAMIN: TFloatField
      FieldName = 'PRECOREVENDAMIN'
      Visible = False
    end
    object FDCidadePRECOREVENDAMAX: TFloatField
      FieldName = 'PRECOREVENDAMAX'
      Visible = False
    end
    object FDCidadeVARIACAOABSOLUTA: TFloatField
      DisplayLabel = 'Varia'#231#227'o Absoluta'
      FieldName = 'VARIACAOABSOLUTA'
    end
    object FDCidadeQTDE: TIntegerField
      FieldName = 'QTDE'
      Visible = False
    end
    object FDCidadeVARIANCIAPOPULACIONAL: TFloatField
      DisplayLabel = 'Vari'#226'ncia Populacional'
      FieldName = 'VARIANCIAPOPULACIONAL'
    end
  end
end
