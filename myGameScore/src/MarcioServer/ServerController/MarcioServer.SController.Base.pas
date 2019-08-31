unit MarcioServer.SController.Base;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Winapi.Windows,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdContext,   Vcl.StdCtrls,
  RaptorWS.Systypes, RaptorWS.ServerUtils, REST.JSon, System.JSON,
  Dialogs,
  EstruturaToken;

type
  TProxy = class
  private
    function ValidarToken(const aToken: String; var aMensagem: String):Boolean;
    function geJSONTokenUsuario(const aRequisicao: TRequisitaToken):TRetornoToken;
  public
    function OnGet(ARequestInfo: TIdHTTPRequestInfo): string;
    function OnPost(ARequestInfo: TIdHTTPRequestInfo): string;
    function OnPut(ARequestInfo: TIdHTTPRequestInfo): string;
    function OnDelete(ARequestInfo: TIdHTTPRequestInfo): string;
  end;

implementation

uses
  DateUtils,
  MarcioServer.JWT.Token,
  MarcioServer.Model.DMBase,
  MarcioServer.Model.DMJogo,
  Entidade.Base,
  Entidade.Jogo;

function TProxy.geJSONTokenUsuario(const aRequisicao: TRequisitaToken):TRetornoToken;
var
  Token: TToken;
begin
  Result := TRetornoToken.Create;

  Result.AcessoLiberado := False;

  if (aRequisicao.Login='usuario') and (aRequisicao.Senha='senha') then
  begin
    Token := TToken.Create;
    try
      Token.NomeGrupoEconomico := 'myGameScore Corporation';
      Token.IDUsuario := 102030; // Usuario Ficticio
      Token.Expiracao := incMinute(now, 4);

      Result.NomeUsuario := 'Nome Usuario';
      Result.NomeGrupoEconomico := Token.NomeGrupoEconomico;
      Result.Expiracao := Token.Expiracao;
      Result.AcessoLiberado := True;
      Result.Token := Token.Executar;
    finally
      FreeAndNil(Token);
    end;
  end
  else
  begin
    Result.Mensagem := 'Usuário e senha não conferem';
  end;
end;

function TProxy.OnDelete(ARequestInfo: TIdHTTPRequestInfo): string;
var
  Encontrado: Boolean;
begin
  Encontrado := False;

  try
    {if UpperCase(ARequestInfo.URI) = UpperCase('/fabricante') then
    begin
      Encontrado := True;
    end; }
  finally
    if not Encontrado then
    begin
      Result := TServerUtils.ReturnMethodNotFound;
    end;
  end;
end;

function TProxy.OnGet(ARequestInfo: TIdHTTPRequestInfo): string;
var
  Classe: TDMBase;
  JSONObject: TJSONObject;
  RetornoToken: String;

begin
  Classe := nil;
  JSONObject := nil;

  try
    if ValidarToken(ARequestInfo.Params.Values['token'], RetornoToken) then
    begin
      if UpperCase(ARequestInfo.uri) = UpperCase('/jogo') then
      begin
        Classe := TDMJogo.Create(nil);
        JSONObject := TDMJogo(Classe).getResultado;
        Result := JSONObject.ToString;
      end
      else
      begin
        Result := TServerUtils.ReturnMethodNotFound;
      end;
    end
    else
    begin
      Result := TServerUtils.Result2JSON(401, RetornoToken);
    end;
  finally
    FreeAndNil(Classe);
    FreeAndNil(JSONObject);
  end;
end;

function TProxy.OnPost(ARequestInfo: TIdHTTPRequestInfo): string;
var
  Classe: TDMBase;
  Jogo: TJogo;
  JSONObject: TJSONObject;
  RequisitaToken: TRequisitaToken;
  RetornoToken: TRetornoToken;
  Auxiliar: String;

begin
  Classe := nil;
  Jogo := nil;
  JSONObject := nil;
  RequisitaToken := nil;
  RetornoToken := nil;


  try
    try
      if UpperCase(ARequestInfo.uri) = UpperCase('/gettokenusuario') then
      begin
        RequisitaToken := TJson.JsonToObject<TRequisitaToken>(ARequestInfo.Params.Values['conteudo']);
        RetornoToken := geJSONTokenUsuario(RequisitaToken);
        JSONObject := TJson.ObjectToJsonObject(RetornoToken);
        Result := JSONObject.ToString;
      end
      else if ValidarToken(ARequestInfo.Params.Values['token'], Auxiliar) then
      begin
        if UpperCase(ARequestInfo.URI) = UpperCase('/jogo') then
        begin
          Jogo := TJson.JsonToObject<TJogo>(ARequestInfo.Params.Values['conteudo']);

          Classe := TDMJogo.Create(nil);
          JSONObject := TDMJogo(Classe).Incluir(Jogo);

          Result := JSONObject.ToString;
        end
        else
        begin
          Result := TServerUtils.ReturnMethodNotFound;
        end;
      end
      else
      begin
        Result := TServerUtils.Result2JSON(401, Auxiliar);
      end;
    except
      on E:Exception do
      begin
        Result := TServerUtils.Result2JSON(400, E.Message);
      end;
    end;
  finally
    FreeAndnil(Jogo);
    FreeAndNil(Classe);
    FreeAndNil(JSONObject);
    FreeAndNil(RequisitaToken);
    FreeAndNil(RetornoToken);
  end;
end;

function TProxy.OnPut(ARequestInfo: TIdHTTPRequestInfo): string;
var
  Classe: TDMBase;
  JSONObject: TJSONObject;
  Auxiliar: String;

begin
  Classe := nil;
  JSONObject := nil;

  try
    if ValidarToken(ARequestInfo.Params.Values['token'], Auxiliar) then
    begin
      try
      except
        on E:Exception do
        begin
          Result := TServerUtils.Result2JSON(400, E.Message);
        end;
      end;
    end
    else
    begin
      Result := TServerUtils.Result2JSON(401, Auxiliar);
    end;
  finally
    FreeAndNil(Classe);
    FreeAndNil(JSONObject);
  end;
end;

function TProxy.ValidarToken(const aToken: String;
  var aMensagem: String): Boolean;
var
  Token: TToken;
  Informacao: TInfoRequisicaoToken;
begin
  Result := False;
  Token := TToken.Create;
  try
    Informacao := Token.getInformacaoRequisicao(aToken);

    if Informacao.AssinaturaValida then
    begin
      if Informacao.Expiracao<=now then
      begin
        aMensagem := 'Necessário gerar outro Token. O atual venceu em: '+
                     FormatDateTime('dd/mm/yyyy hh:nn', Informacao.Expiracao);
      end
      else
      begin
        Result := True;
      end;
    end
    else
    begin
      aMensagem := 'Token não possui assinatura válida!';
    end;
  finally
    FreeAndNil(Token);
  end;
end;

end.
