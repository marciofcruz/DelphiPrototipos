unit ToviasurFramework;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Generics.Collections,
  IdHTTPServer, IdContext,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  Toviasur.ControllerBase,
  Toviasur.ControllerAutenticacao,
  Toviasur.Proxy,
  Toviasur.Comuns,
  Toviasur.HandleContext;

type
  TTVSAutenticacaoHTTP = class
  private
    fUsername: string;
    fPassword: String;
    fHasAuthenticacion: Boolean;
  Public
    property HasAuthentication: Boolean read fHasAuthenticacion
      write fHasAuthenticacion;
    property UserName: string read fUsername write fUsername;
    property Password: string read fPassword write fPassword;

    constructor Create; overload;
  end;

  TTVSEngine = class
  private
    FIdHTTPServer: TIdHTTPServer;

    FPorta: Integer;
    FListenQueue: Integer;

    FTVSAutenticacaoHTTP: TTVSAutenticacaoHTTP;

    FRotasGET,
    FRotasPOST,
    FRotasDELETE,
    FRotasPUT: TDictionary<String,TRota>;

    procedure AddCORSHeaders(AResponseInfo: TIdHTTPResponseInfo);

    procedure VerificarAutenticacao(ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);

    procedure HTTPServerCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure HTTPServerCommandOther(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);

    procedure setPorta(const Value: Integer);
    procedure setListenQueue(const Value: Integer);
    function getEstahAtivado: Boolean;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;

    procedure Ativar;
    procedure Desativar;

    procedure AddController(AClasse: TClasseController);

    property EstahAtivado: Boolean read getEstahAtivado;

    property Porta: Integer read FPorta write setPorta;
    property ListenQueue: Integer read FListenQueue write setListenQueue;

    property ServerParams: TTVSAutenticacaoHTTP read FTVSAutenticacaoHTTP write FTVSAutenticacaoHTTP;
  end;

implementation

uses
  System.RTTI;

procedure TTVSEngine.AddController(AClasse: TClasseController);
var
  context: TRttiContext;
  Metodo: TRttiMethod;
  Tipos: TRttiType;
  PathAtributo: TCustomAttribute;

  procedure Adicionar(Dicionario: TDictionary<String,TRota>;
                      APath: String; ANomeMetodo: String);
  var
    Rota: TRota;
  begin
    Rota := nil;
    if Dicionario.TryGetValue(APath, Rota) then
    begin
      raise Exception.Create('Rota já adicionada anteriormente:'#13+
                             'Controller: '+Rota.Controller.ClassName+#13+
                             'URI: '+Rota.URI+#13+
                             'Método: '+ANomeMetodo);

    end;

    Rota := TRota.Create(AClasse, APath, ANomeMetodo);

    Dicionario.Add(APath, Rota);
  end;

begin
  if TTVSAtributos.TemAtributo(AClasse, TVSController) then
  begin
    Tipos := context.GetType(AClasse);

    for Metodo in Tipos.GetMethods do
    begin
      if TTVSAtributos.TemAtributo(Metodo, TVSPathAttribute, PathAtributo) then
      begin
        if verboGET in TVSPathAttribute(PathAtributo).TVCVerbosHTTP then
        begin
          Adicionar(FRotasGET, TVSPathAttribute(PathAtributo).URI, Metodo.Name);
        end
        else if verboPOST in TVSPathAttribute(PathAtributo).TVCVerbosHTTP then
        begin
          Adicionar(FRotasPOST, TVSPathAttribute(PathAtributo).URI, Metodo.Name);
        end
        else if verboDELETE in TVSPathAttribute(PathAtributo).TVCVerbosHTTP then
        begin
          Adicionar(FRotasDELETE, TVSPathAttribute(PathAtributo).URI, Metodo.Name);
        end
        else if verboPUT in TVSPathAttribute(PathAtributo).TVCVerbosHTTP then
        begin
          Adicionar(FRotasPUT, TVSPathAttribute(PathAtributo).URI, Metodo.Name);
        end;
      end;
    end;
  end;
end;

procedure TTVSEngine.AddCORSHeaders(AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin'] := '*';
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Credentials'] := 'true';
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Methods'] := 'GET, POST, PUT, DELETE, OPTIONS';
end;

procedure TTVSEngine.Ativar;
begin
  FIdHTTPServer.ListenQueue := FListenQueue;
  FIdHTTPServer.DefaultPort := FPorta;
  FIdHTTPServer.ContextClass := TServerContext;

  FIdHTTPServer.Active := True;

  ProxyRaptor.LogBusiness(nil, 'Servidor Iniciado');
end;

constructor TTVSEngine.Create(AOwner: TComponent);
begin
  inherited Create;

  FPorta := 8080;
  FListenQueue := 100;

  FRotasGET := TDictionary<String, TRota>.Create;
  FRotasPOST := TDictionary<String, TRota>.Create;
  FRotasDELETE := TDictionary<String, TRota>.Create;
  FRotasPUT := TDictionary<String, TRota>.Create;

  AddController(TControllerAutenticacao);

  FTVSAutenticacaoHTTP := TTVSAutenticacaoHTTP.Create;

  FIdHTTPServer := TIdHTTPServer.Create(AOwner);
  FIdHTTPServer.OnCommandGet := HTTPServerCommandGet;
  FIdHTTPServer.OnCommandOther := HTTPServerCommandOther;

  FTVSAutenticacaoHTTP.UserName := 'user';
  FTVSAutenticacaoHTTP.Password := 'passwd';
  FTVSAutenticacaoHTTP.HasAuthentication := False;
end;

procedure TTVSEngine.Desativar;
begin
  FIdHTTPServer.Active := False;

  ProxyRaptor.LogBusiness(nil, 'Finalizado');
end;

destructor TTVSEngine.Destroy;
begin
  FreeAndNil(FIdHTTPServer);
  FreeAndNil(FTVSAutenticacaoHTTP);

  FreeAndNil(FRotasGET);
  FreeAndNil(FRotasPOST);
  FreeAndNil(FRotasDELETE);
  FreeAndNil(FRotasPUT);

  inherited;
end;

function TTVSEngine.getEstahAtivado: Boolean;
begin
  Result := FIdHTTPServer.Active;
end;

procedure TTVSEngine.HTTPServerCommandGet(AContext: TIdContext;
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

procedure TTVSEngine.HTTPServerCommandOther(AContext: TIdContext;
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

procedure TTVSEngine.setListenQueue(const Value: Integer);
begin
  FListenQueue := Value;
end;

procedure TTVSEngine.setPorta(const Value: Integer);
begin
  FPorta := Value;
end;

procedure TTVSEngine.VerificarAutenticacao(ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  If (FTVSAutenticacaoHTTP.HasAuthentication) then
  Begin
    if (not SameStr(ARequestInfo.AuthUsername,FTVSAutenticacaoHTTP.UserName)) or
       (not SameStr(ARequestInfo.AuthPassword,FTVSAutenticacaoHTTP.Password)) then
    Begin
      AResponseInfo.AuthRealm := 'Forneça autenticação';
      AResponseInfo.WriteContent;
      Abort;
    End;
  End;
end;

{ TTVSAutenticacaoHTTP }

constructor TTVSAutenticacaoHTTP.Create;
begin
  HasAuthentication := False;
end;

end.
