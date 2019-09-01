unit Toviasur.Estrutura.Token;

interface

uses
  System.SysUtils, System.Classes;

type
  TRetornoToken = class
  private
    FNomeGrupoEconomico: String;
    FNomeUsuario: String;
    FToken: String;
    FExpiracao: TDateTime;
    FAcessoLiberado: Boolean;
    FMensagem: String;
  public
    property NomeGrupoEconomico: String read FNomeGrupoEconomico write FNomeGrupoEconomico;
    property NomeUsuario: string read FNomeUsuario write FNomeUsuario;
    property Token: string read FToken write FToken;
    property Expiracao: TDateTime read FExpiracao write FExpiracao;
    property AcessoLiberado: Boolean read FAcessoLiberado write FAcessoLiberado;
    property Mensagem: String read FMensagem write FMensagem;
  end;

  TRequisitaToken = class
  private
    FSenha: String;
    FLogin: String;
  public
    property Login: String read FLogin write FLogin;
    property Senha: String read FSenha write FSenha;
  end;

implementation

end.
