unit MarcioServer.SController.Base;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Winapi.Windows,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdContext,   Vcl.StdCtrls,
  Toviasur.Comuns,
  REST.JSon, System.JSON,
  Dialogs,
  Toviasur.Estrutura.Token;

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
  Toviasur.Token,
  MarcioServer.Model.DMBase,
  MarcioServer.Model.DMFabricante,
  MarcioServer.Model.DMModelo,
  MarcioServer.Model.DMEquipamento,
  Entidade.Base,
  Comum.Pesquisa.Equipamento,
  Entidade.Fabricante, Entidade.Modelo, Entidade.Equipamento;

function TProxy.geJSONTokenUsuario(const aRequisicao: TRequisitaToken):TRetornoToken;
var
  Token: TTVSToken;
begin
  Result := TRetornoToken.Create;

  Result.AcessoLiberado := False;

  if (aRequisicao.Login='usuario') and (aRequisicao.Senha='senha') then
  begin
    Token := TTVSToken.Create;
    try
      Token.NomeGrupoEconomico := 'MarcioServer Inc';
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
  PesquisaEquipamento: TPesquisaEquipamento;
  RetornoToken: String;

begin
  Classe := nil;
  JSONObject := nil;
  PesquisaEquipamento := nil;

  try
    if ValidarToken(ARequestInfo.Params.Values['token'], RetornoToken) then
    begin
      if UpperCase(ARequestInfo.uri) = UpperCase('/fabricante') then
      begin
        Classe := TDMFabricante.Create(nil);
        JSONObject := TDMFabricante(Classe).getLista;
        Result := JSONObject.ToString;
      end
      else if UpperCase(ARequestInfo.uri) = UpperCase('/modelo') then
      begin
        Classe := TDMModelo.Create(nil);
        JSONObject := TDMModelo(Classe).getLista;
        Result := JSONObject.ToString;
      end
      else if UpperCase(ARequestInfo.uri) = UpperCase('/equipamento') then
      begin
        PesquisaEquipamento := TJson.JsonToObject<TPesquisaEquipamento>(ARequestInfo.Params.Values['conteudo']);
        Classe := TDMEquipamento.Create(nil);
        JSONObject := TDMEquipamento(Classe).getLista(PesquisaEquipamento);
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
    FreeAndNil(PesquisaEquipamento);
  end;
end;

function TProxy.OnPost(ARequestInfo: TIdHTTPRequestInfo): string;
var
  Classe: TDMBase;
  ContainerFabricante: TContainerFabricante;
  ContainerModelo: TContainerModelo;
  ContainerEquipamento: TContainerEquipamento;
  JSONObject: TJSONObject;
  RequisitaToken: TRequisitaToken;
  RetornoToken: TRetornoToken;
  Auxiliar: String;

begin
  Classe := nil;
  ContainerFabricante := nil;
  ContainerModelo := nil;
  ContainerEquipamento := nil;
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
        if UpperCase(ARequestInfo.URI) = UpperCase('/fabricante') then
        begin
          ContainerFabricante := TJson.JsonToObject<TContainerFabricante>(ARequestInfo.Params.Values['conteudo']);

          Classe := TDMFabricante.Create(nil);
          JSONObject := TDMFabricante(Classe).AtualizarLista(ContainerFabricante);

          Result := JSONObject.ToString;
        end
        else if UpperCase(ARequestInfo.URI) = UpperCase('/modelo') then
        begin
          ContainerModelo := TJson.JsonToObject<TContainerModelo>(ARequestInfo.Params.Values['conteudo']);

          Classe := TDMModelo.Create(nil);
          JSONObject := TDMModelo(Classe).AtualizarLista(ContainerModelo);

          Result := JSONObject.ToString;
        end
        else if UpperCase(ARequestInfo.URI) = UpperCase('/equipamento') then
        begin
          ContainerEquipamento := TJson.JsonToObject<TContainerEquipamento>(ARequestInfo.Params.Values['conteudo']);

          Classe := TDMEquipamento.Create(nil);
          JSONObject := TDMEquipamento(Classe).AtualizarLista(ContainerEquipamento);

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
    FreeAndnil(ContainerFabricante);
    FreeAndnil(ContainerModelo);
    FreeAndNIl(ContainerEquipamento);
    FreeAndNil(Classe);
    FreeAndNil(JSONObject);
    FreeAndNil(RequisitaToken);
    FreeAndNil(RetornoToken);
  end;
end;

function TProxy.OnPut(ARequestInfo: TIdHTTPRequestInfo): string;
var
  Classe: TDMBase;
  ContainerEquipamento: TContainerEquipamento;
  JSONObject: TJSONObject;
  Auxiliar: String;

begin
  Classe := nil;
  ContainerEquipamento := nil;
  JSONObject := nil;

  try
    if ValidarToken(ARequestInfo.Params.Values['token'], Auxiliar) then
    begin
      try
        if UpperCase(ARequestInfo.URI) = UpperCase('/equipamento') then
        begin
          ContainerEquipamento := TJson.JsonToObject<TContainerEquipamento>(ARequestInfo.Params.Values['conteudo']);

          Classe := TDMEquipamento.Create(nil);
          JSONObject := TDMEquipamento(Classe).Alterar(ContainerEquipamento);

          Result := JSONObject.ToString;
        end
        else
        begin
          Result := TServerUtils.ReturnMethodNotFound;
        end;
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
    FreeAndNIl(ContainerEquipamento);
    FreeAndNil(Classe);
    FreeAndNil(JSONObject);
  end;
end;

function TProxy.ValidarToken(const aToken: String;
  var aMensagem: String): Boolean;
var
  Token: TTVSToken;
  Informacao: TInfoRequisicaoToken;
begin
  Result := False;
  Token := TTVSToken.Create;
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
