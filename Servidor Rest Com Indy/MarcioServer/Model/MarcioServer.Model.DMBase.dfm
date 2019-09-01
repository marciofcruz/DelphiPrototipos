object DMBase: TDMBase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 325
  Width = 611
  object FDConexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\projetos\estudos\provaconsinco\MarcioServer\Win32\De' +
        'bug\Banco\Marcio.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDCriarEsquema: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS fabricante  ('
      ' fabricante autoinc PRIMARY KEY,'
      ' nome varchar(50) NOT NULL'
      ');')
    Left = 24
    Top = 88
  end
end
