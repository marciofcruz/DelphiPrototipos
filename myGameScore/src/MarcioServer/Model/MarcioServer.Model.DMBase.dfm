object DMBase: TDMBase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 325
  Width = 611
  object FDConexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\projetos\arcasoft\estudos\provas\labsoft\MarcioServe' +
        'r\Win32\Debug\Banco\Marcio.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDCriarEsquema: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS JOGO ('
      ' DATA  datetime  PRIMARY KEY,'
      ' PONTOS INT'
      ');')
    Left = 56
    Top = 96
  end
end
