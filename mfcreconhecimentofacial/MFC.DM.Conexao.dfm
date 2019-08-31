object DMConexao: TDMConexao
  OldCreateOrder = False
  Height = 234
  Width = 475
  object Conexao: TSQLConnection
    ConnectionName = 'MySQLConnection'
    DriverName = 'DevartSQLServer'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=%.dbo'
      'DriverUnit=DBXDevartSQLServer'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver250.' +
        'bpl'
      
        'MetaDataPackageLoader=TDBXDevartMSSQLMetaDataCommandFactory,DbxD' +
        'evartSQLServerDriver250.bpl'
      'ProductName=DevartSQLServer'
      'GetDriverFunc=getSQLDriverSQLServer'
      'LibraryName=dbexpsda40.dll'
      'VendorLib=sqloledb.dll'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'MaxBlobSize=-1'
      'LongStrings=True'
      'EnableBCD=True'
      'FetchAll=True'
      'ParamPrefix=False'
      'UseUnicode=True'
      'IPVersion=IPv4'
      'BlobSize=-1'
      'HostName=MARCIODELL'
      'DataBase=HKFACEID'
      'User_Name=sa'
      'Password=HKEng123')
    Left = 80
    Top = 48
  end
end
