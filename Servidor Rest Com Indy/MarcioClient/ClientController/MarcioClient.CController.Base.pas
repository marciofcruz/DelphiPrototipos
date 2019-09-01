unit MarcioClient.CController.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, Data.DB, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Comp.Client, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  REST.Authenticator.Basic,
  REST.Json, System.JSON, Rest.JsonReflect, IdHTTP,
  REST.Response.Adapter,
  Entidade.Base;

type
  TRetornoJSON = class
     FStatus: Integer;
     FMensagem: String;
  public
     property STATUS: Integer read FStatus write FStatus;
     property MENSAGEM: String read FMensagem write FMensagem;
  end;

  TResponse = reference to procedure(aRetornoJSON: TRetornoJSON);

  TControllerBase = class
  private
    FHTTPBasicAuthenticator: THTTPBasicAuthenticator;

    FBaseURL: String;
    FPassword: String;
    FUser: String;
    FTemAutenticacao: Boolean;
    FToken: String;

    procedure TesteErroJson(AJson: String);

    procedure setBaseURL(const Value: String);
    procedure setPassword(const Value: String);
    procedure setUser(const Value: String);

    procedure setAutenticacao;
    procedure setTemAutenticacao(const Value: Boolean);
  protected
    FRestClient: TRestClient;
    FRestRequest: TRESTRequest;
    FRestResponse: TRESTResponse;

    function ExecutarGET(const ANomeMetodo: String; const AJson: String=''):String;
    function ExecutarPost(const ANomeMetodo, AJson: String):TRetornoJSON; virtual;
    function ExecutarPut(const ANomeMetodo, AJson: String):TRetornoJSON;  virtual;
  public
    constructor Create;
    destructor Destroy; override;

    procedure CarregarLista(const ANomeMetodo: String; Tabela: TFDMemTable); virtual; abstract;
    function EnviarLista(const ANomeMetodo: String; Tabela: TFDMemTable):TRetornoJSON; virtual; abstract;

    property Token: String read FToken write FToken;
    property BaseURL: String read FBaseURL write setBaseURL;
    property User: String read FUser write setUser;
    property Password: String read FPassword write setPassword;
    property TemAutenticacao: Boolean read FTemAutenticacao write setTemAutenticacao;
  end;

var
  ControllerCriticalSection: TRTLCriticalSection;

implementation

uses
  Toviasur.Estrutura.Token;

constructor TControllerBase.Create;
begin
  FHTTPBasicAuthenticator := THTTPBasicAuthenticator.Create(nil);

  FRestClient := TRESTClient.Create(nil);
  FRestClient.Authenticator := FHTTPBasicAuthenticator;
  FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestClient.AcceptEncoding := 'identity';
  FRestClient.AutoCreateParams := False;
  FRestClient.UserAgent := 'Marcio User Agent';
  FRestClient.AllowCookies := False;

  FRestResponse := TRESTResponse.Create(nil);
  FRestResponse.ContentType := 'application/json';

  FRestRequest := TRESTRequest.Create(nil);
  FRESTRequest.Accept := 'JSON';
  FRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Method := rmGET;
  FRESTRequest.Response := FRestResponse;
  FRestRequest.SynchronizedEvents := False;
end;

destructor TControllerBase.Destroy;
begin
  FreeAndNil(FRestRequest);
  FreeAndNil(FRestResponse);
  FreeAndNil(FRestClient);

  FreeAndNil(FHTTPBasicAuthenticator);

  inherited;
end;

function TControllerBase.ExecutarGET(const ANomeMetodo: String; const AJson: String=''):String;
begin
  EnterCriticalSection(ControllerCriticalSection);
  try
    FRESTClient.BaseURL := FBaseURL+'/'+ANomeMetodo;
    FRestRequest.Params.Clear;

    FRestRequest.Params.Add;
    FRestRequest.Params[FRestRequest.Params.Count-1].Name := 'token';
    FRestRequest.Params[FRestRequest.Params.Count-1].Value := FToken;

    FRestRequest.Params.Add;
    FRestRequest.Params[FRestRequest.Params.Count-1].Name := 'conteudo';
    FRestRequest.Params[FRestRequest.Params.Count-1].Value := AJson;

    FRestRequest.Method := TRESTRequestMethod.rmGET;
    FRestRequest.Execute;
    Result := FRestResponse.JSONText;

    TesteErroJson(FRestResponse.JSONText);
  finally
    LeaveCriticalSection(ControllerCriticalSection);
  end;
end;

function TControllerBase.ExecutarPost(const ANomeMetodo, AJson: String):TRetornoJSON;
var
  TextoRetorno: String;
begin
  Result := nil;

  EnterCriticalSection(ControllerCriticalSection);
  try
    FRESTClient.BaseURL := FBaseURL+'/'+ANomeMetodo;
    FRestRequest.Method := TRESTRequestMethod.rmPOST;

    FRestRequest.Params.Clear;

    FRestRequest.Params.Add;
    FRestRequest.Params[FRestRequest.Params.Count-1].Name := 'token';
    FRestRequest.Params[FRestRequest.Params.Count-1].Value := FToken;
    FRestRequest.Params.Add;
    FRestRequest.Params[FRestRequest.Params.Count-1].Name := 'conteudo';
    FRestRequest.Params[FRestRequest.Params.Count-1].Value := AJson;

    FRestRequest.Execute;
    TextoRetorno := FRestResponse.JSONText;

    TesteErroJson(FRestResponse.JSONText);

    Result := TJson.JsonToObject<TRetornoJSON>(TextoRetorno);
  finally
    LeaveCriticalSection(ControllerCriticalSection);
  end;
end;

function TControllerBase.ExecutarPut(const ANomeMetodo,
  AJson: String): TRetornoJSON;
var
  TextoRetorno: String;
begin
  Result := nil;

  EnterCriticalSection(ControllerCriticalSection);
  try
    FRESTClient.BaseURL := FBaseURL+'/'+ANomeMetodo;
    FRestRequest.Method := TRESTRequestMethod.rmPUT;

    FRestRequest.Params.Clear;

    FRestRequest.Params.Add;
    FRestRequest.Params[FRestRequest.Params.Count-1].Name := 'token';
    FRestRequest.Params[FRestRequest.Params.Count-1].Value := FToken;
    FRestRequest.Params.Add;
    FRestRequest.Params[FRestRequest.Params.Count-1].Name := 'conteudo';
    FRestRequest.Params[FRestRequest.Params.Count-1].Value := AJson;

    FRestRequest.Execute;
    TextoRetorno := FRestResponse.JSONText;

    TesteErroJson(FRestResponse.JSONText);

    Result := TJson.JsonToObject<TRetornoJSON>(TextoRetorno);
  finally
    LeaveCriticalSection(ControllerCriticalSection);
  end;
end;

procedure TControllerBase.setAutenticacao;
begin
  FHTTPBasicAuthenticator.Username := FUser;
  FHTTPBasicAuthenticator.Password := FPassword;

  if FTemAutenticacao then
  begin
    FRestClient.Authenticator := FHTTPBasicAuthenticator;
  end
  else
  begin
    FRestClient.Authenticator := nil;
  end;
end;

procedure TControllerBase.setBaseURL(const Value: String);
begin
  FBaseURL := Value;
  FRestClient.BaseURL := Value;
end;

procedure TControllerBase.setPassword(const Value: String);
begin
  FPassword := Value;

  setAutenticacao;
end;

procedure TControllerBase.setTemAutenticacao(const Value: Boolean);
begin
  FTemAutenticacao := Value;

  setAutenticacao;
end;

procedure TControllerBase.setUser(const Value: String);
begin
  FUser := Value;

  setAutenticacao;
end;

procedure TControllerBase.TesteErroJson(AJson: String);
var
  Retorno: TRetornoJSON;
begin
  try
    Retorno := TJson.JsonToObject<TRetornoJSON>(AJson);

    if Retorno.FStatus=401 then
    begin
      raise Exception.Create(Retorno.Mensagem);
    end;
  finally
    FreeAndNil(Retorno);
  end;
end;

initialization
  InitializeCriticalSection(ControllerCriticalSection);

finalization
  DeleteCriticalSection(ControllerCriticalSection);

end.
