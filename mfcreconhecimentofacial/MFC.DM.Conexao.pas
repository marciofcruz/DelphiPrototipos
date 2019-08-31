unit MFC.DM.Conexao;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMySQL, Data.DB, Data.SqlExpr,
  DBXDevartSQLServer, MFC.Modelo.Tipos;

type
  TDMConexao = class(TDataModule)
    Conexao: TSQLConnection;
  private
  public
    procedure Configurar(AConfigSqlServer: TConfigSQLServer);
  end;

implementation

{$R *.dfm}

{ TDMConexao }

procedure TDMConexao.Configurar(AConfigSqlServer: TConfigSQLServer);
begin
  Conexao.Close;
  Conexao.Params.Values['HostName'] := AConfigSqlServer.Host;
  Conexao.Params.Values['DataBase'] := AConfigSqlServer.Banco;
  Conexao.Params.Values['User_Name'] := AConfigSqlServer.Usuario;
  Conexao.Params.Values['Password'] := AConfigSqlServer.Senha;
  Conexao.Open;
end;

end.
