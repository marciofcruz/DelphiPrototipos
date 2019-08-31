unit MarcioServer.RaptorWS.ServidorRest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  IdHTTPServer, IdContext,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  RaptorWS.ServerUtils, RaptorWS.Systypes,
  MarcioServer.RaptorWS.Proxy,
  RaptorWS.HandleContext;

type
  TServidorRest = class
  private
    FIdHTTPServer: TIdHTTPServer;

    FPorta: Integer;
    FListenQueue: Integer;

    FServerParams: TServerParams;
    FHasAuthentication: Boolean;
    FPassword: String;
    FUserName: String;

    procedure VerificarAutenticacao(ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);

    procedure HTTPServerCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure HTTPServerCommandOther(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);

    procedure setPorta(const Value: Integer);
    procedure setListenQueue(const Value: Integer);
    procedure setHasAuthentication(const Value: Boolean);
    procedure setPassword(const Value: String);
    procedure setUserName(const Value: String);
    function getEstahAtivado: Boolean;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    procedure AddCORSHeaders(AResponseInfo: TIdHTTPResponseInfo);

    procedure Ativar;
    procedure Desativar;

    property EstahAtivado: Boolean read getEstahAtivado;

    property Porta: Integer read FPorta write setPorta;
    property ListenQueue: Integer read FListenQueue write setListenQueue;

    property UserName: String read FUserName write setUserName;
    property Password: String read FPassword write setPassword;
    property HasAuthentication: Boolean read FHasAuthentication write setHasAuthentication;
  end;

implementation

{ TServidorRest }

procedure TServidorRest.AddCORSHeaders(AResponseInfo: TIdHTTPResponseInfo);
begin
  // Contribuição do José Benedito (JB Soluções) para
  // permitir retornar respostas a requisiçõe AJAX CrossDomain

  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin'] := '*';
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Credentials'] := 'true';
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Methods'] := 'GET, POST, PUT, DELETE, OPTIONS';
end;

procedure TServidorRest.Ativar;
begin
  FIdHTTPServer.ListenQueue := FListenQueue;
  FIdHTTPServer.DefaultPort := FPorta;
  FIdHTTPServer.ContextClass := TServerContext;

  FIdHTTPServer.Active := True;

  ProxyRaptor.LogBusiness(nil, 'Servidor Iniciado');
end;

constructor TServidorRest.Create(AOwner: TComponent);
begin
  inherited Create;

  FPorta := 8080;
  FListenQueue := 100;

  FServerParams := TServerParams.Create;

  FIdHTTPServer := TIdHTTPServer.Create(AOwner);
  FIdHTTPServer.OnCommandGet := HTTPServerCommandGet;
  FIdHTTPServer.OnCommandOther := HTTPServerCommandOther;

  UserName := 'user';
  Password := 'passwd';
  HasAuthentication := False;
end;

procedure TServidorRest.Desativar;
begin
  FIdHTTPServer.Active := False;

  ProxyRaptor.LogBusiness(nil, 'Finalizado');
end;

destructor TServidorRest.Destroy;
begin
  FreeAndNil(FIdHTTPServer);
  FreeAndNil(FServerParams);

  inherited;
end;

function TServidorRest.getEstahAtivado: Boolean;
begin
  Result := FIdHTTPServer.Active;
end;

procedure TServidorRest.HTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  Cmd: String;
  ServerContext: TServerContext;
  Retorno: string;
begin
  Cmd := ARequestInfo.RawHTTPCommand;

  VerificarAutenticacao(ARequestInfo, AResponseInfo);

  if (UpperCase(Copy(Cmd, 1, 3)) = 'GET') OR
    (UpperCase(Copy(Cmd, 1, 4)) = 'POST') OR
    (UpperCase(Copy(Cmd, 1, 3)) = 'HEAD') then
  Begin
    if ARequestInfo.URI <> '/favicon.ico' Then
    Begin
      ProxyRaptor.LogRequisicao(ARequestInfo);

      ServerContext := TServerContext(AContext);

      try
        Retorno := ServerContext.HandleRequest(ARequestInfo, AResponseInfo, Cmd);
      except
        on E:Exception do
        begin
          Retorno := E.Message;
        end;
      end;

      AddCORSHeaders(AResponseInfo);

      // Escreve conteudo no Response
      AResponseInfo.ContentText := Retorno;

      ProxyRaptor.LogResposta(AResponseInfo);
      AResponseInfo.WriteContent;
    End;
  end;
end;

procedure TServidorRest.HTTPServerCommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  Cmd: String;
  ServerContext: TServerContext;
  Retorno: string;

begin
  Cmd := ARequestInfo.RawHTTPCommand;

  VerificarAutenticacao(ARequestInfo, AResponseInfo);

  if (UpperCase(Copy(Cmd, 1, 3)) = 'PUT') OR
    (UpperCase(Copy(Cmd, 1, 6)) = 'DELETE') then
  Begin
    ProxyRaptor.LogRequisicao(ARequestInfo);

    ServerContext := TServerContext(AContext);

    Retorno := ServerContext.HandleRequest(ARequestInfo, AResponseInfo, Cmd);

    AddCORSHeaders(AResponseInfo);

    // Escreve conteudo no Response
    AResponseInfo.ContentText := Retorno;

    ProxyRaptor.LogResposta(AResponseInfo);
    AResponseInfo.WriteContent;
  end;
end;

procedure TServidorRest.setHasAuthentication(const Value: Boolean);
begin
  FHasAuthentication := Value;

  FServerParams.HasAuthentication := Value;
end;

procedure TServidorRest.setListenQueue(const Value: Integer);
begin
  FListenQueue := Value;
end;

procedure TServidorRest.setPassword(const Value: String);
begin
  FPassword := Value;
  FServerParams.Password := Value;
end;

procedure TServidorRest.setPorta(const Value: Integer);
begin
  FPorta := Value;
end;

procedure TServidorRest.setUserName(const Value: String);
begin
  FUserName := Value;
  FServerParams.UserName := Value;
end;

procedure TServidorRest.VerificarAutenticacao(ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  If (FServerParams.HasAuthentication) then
  Begin
    if (not SameStr(ARequestInfo.AuthUsername,FServerParams.UserName)) or
       (not SameStr(ARequestInfo.AuthPassword,FServerParams.Password)) then
    Begin
      AResponseInfo.AuthRealm := 'Forneça autenticação';
      AResponseInfo.WriteContent;
      Abort;
    End;
  End;
end;

end.
