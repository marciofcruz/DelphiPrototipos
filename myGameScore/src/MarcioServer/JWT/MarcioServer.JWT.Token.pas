unit MarcioServer.JWT.Token;

interface

uses
  System.SysUtils, System.Classes,
  System.Generics.Collections,
  System.Math,
  DateUtils,
  Dialogs,
  JOSE.Core.Builder,
  JOSE.Core.JWA,
  JOSE.Types.JSON,
  JOSE.Core.JWK,
  JOSE.Core.JWS,
  JOSE.Core.JWT;

type
  TInfoRequisicaoToken = record
    AssinaturaValida: Boolean;
    IDUsuario: Integer; // Sub
    Expiracao: TDateTime;
    Audiencia: String;
    NomeGrupoEconomico: String;
  end;

  TToken = class(TObject)
  const
    C_ChaveSegurancaHK = 'HojeLiNaCamaRobsonCrusoeEmFrances';
  private
    FChave: TJWK;
    FNomeGrupoEconomico: String; // issuer
    FIDUsuario: Integer; // Sub
    FAudiencia: String; // aud
    FExpiracao: TDatetime; // exp
    FIDRegistroAcesso: Integer; // JWTID
    FDataServidor: TDateTime; // IssuedAt
  public
    property NomeGrupoEconomico: String read FNomeGrupoEconomico write FNomeGrupoEconomico;
    property IDUsuario: Integer read FIDUsuario write FIDUsuario;
    property Audiencia: String read FAudiencia write FAudiencia;
    property Expiracao: TDateTime read FExpiracao write FExpiracao;
    property IDRegistroAcesso: Integer read FIDRegistroAcesso write FIDRegistroAcesso;
    property DataServidor: TDateTime read FDataServidor write FDataServidor;

    constructor Create;
    destructor Destroy; override;

    function Executar:String;

    function TemAssinaturaValida(const aToken: String):Boolean;
    function getInformacaoRequisicao(const aToken: String):TInfoRequisicaoToken;
  end;

implementation

{ TToken }

constructor TToken.Create;
begin
  FChave := TJWK.Create(C_ChaveSegurancaHK);

  FIDRegistroAcesso := 0;
  FDataServidor := now;
  FExpiracao := incDay(now, 1);
end;

function TToken.TemAssinaturaValida(const aToken: String): Boolean;
var
  Token: TJWT;
begin
  Token := nil;
  
  try
    Token := TJOSE.Verify(FChave, aToken);

    Result := Assigned(Token) and Token.Verified;
  finally
    FreeAndNil(Token);
  end;
end;

destructor TToken.Destroy;
begin
  FreeAndNil(FChave);
  
  inherited;
end;

function TToken.Executar: String;
var
  JWT: TJWT;
begin
  JWT := nil;

  try
    JWT := TJWT.Create;

    JWT.Claims.Issuer := FNomeGrupoEconomico;
    JWT.Claims.Subject := IntToStr(IDUsuario);
    JWT.Claims.Audience := FAudiencia;

    if FIDRegistroAcesso<>0 then
    begin
      JWT.Claims.JWTId :=  IntToStr(FIDRegistroAcesso);
    end;

    JWT.Claims.IssuedAt := FDataServidor;
    JWT.Claims.Expiration := FExpiracao;
    JWT.Claims.NotBefore := FDataServidor;

    Result := TJOSE.SerializeCompact(C_ChaveSegurancaHK, TJOSEAlgorithmId.HS256, JWT);
  finally
    FreeAndNil(JWT);
  end;
end;

function TToken.getInformacaoRequisicao(const aToken: String): TInfoRequisicaoToken;
var
  Token: TJWT;
  Signer: TJWS;
begin
  Token := nil;
  Signer := nil;
  try
    Token := TJWT.Create;
    Signer := TJWS.Create(Token);
    Signer.SkipKeyValidation := True;

    Signer.SetKey(FChave);
    Signer.CompactToken := aToken;
    Signer.VerifySignature;

    Result.AssinaturaValida := Token.Verified;
    Result.IDUsuario := StrToIntDef(Token.Claims.Subject,-1);
    Result.Expiracao := Token.Claims.Expiration;
    Result.Audiencia := Token.Claims.Audience;
    Result.NomeGrupoEconomico := Token.Claims.Issuer;
  finally
    FreeAndNil(Signer);
    FreeAndNil(Token);
  end;
end;

end.
