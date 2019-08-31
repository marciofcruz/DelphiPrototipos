// Desenvolvido por Marcio Fernandes Cruz
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/

unit marciofcruz.RestClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  ComCtrls, ExtCtrls,
  marciofcruz.GeoUteis,
  REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, IPPeerClient;

type
  TMFCRestClient = class(TObject)
  private
    FProxyPassword: String;
    FProxyPort: Integer;
    FProxyServer: String;
    FProxyUserName: String;
    FKeyAPI: string;

    FHandle: THandle;

    procedure SetProxyPassword(const Value: String);
    procedure SetProxyPort(const Value: Integer);
    procedure SetProxyServer(const Value: String);
    procedure SetProxyUserName(const Value: String);
    procedure SetKeyAPI(const Value: string);
  protected
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRestResponse: TRESTResponse;

    FGeoUteis: TMFCGeoUteis;

    FURLDocumentacao: String;

    FTempoProcessamento: Cardinal;

    procedure setInicial; virtual;
  public
    constructor Create(AHandle: THandle); reintroduce;
    destructor Destroy; override;

    procedure AbrirExemplo;

    property ProxyPassword: String read FProxyPassword write SetProxyPassword;
    property ProxyPort: Integer read FProxyPort write SetProxyPort;
    property ProxyServer: String read FProxyServer write SetProxyServer;
    property ProxyUserName: String read FProxyUserName write SetProxyUserName;
    property KeyAPI: string read FKeyAPI write SetKeyAPI;

    property TempoProcessamento: cardinal read FTempoProcessamento;

    property GeoUteis: TMFCGeoUteis read FGeoUteis;
  end;

implementation

uses
  ShellApi;
{ TMFCRestClient }

procedure TMFCRestClient.AbrirExemplo;
begin
 ShellExecute(FHandle, 'open', PWideChar(FURLDocumentacao), nil, nil, SW_SHOWNORMAL) ;
end;

constructor TMFCRestClient.Create(AHandle: THandle);
begin
  inherited Create;

  FGeoUteis := TMFCGeoUteis.Create;

  FHandle :=  AHandle;

  FTempoProcessamento := 0;

  FRESTClient := TRESTClient.Create(nil);
  FRESTClient.Accept := 'JSON';
  FRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRESTClient.HandleRedirects := True;
  FRESTClient.UserAgent := 'MARCIOFCRUZ';
  FRESTClient.FallbackCharsetEncoding := 'UTF-8';

  FRestResponse := TRESTResponse.Create(nil);
  FRestResponse.ContentType := 'application/json';

  FRESTRequest := TRESTRequest.Create(nil);
  FRESTRequest.Accept := 'JSON';
  FRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Method := rmGET;
  FRESTRequest.Response := FRestResponse;

  setInicial;
end;

destructor TMFCRestClient.Destroy;
begin
  FreeAndNil(FGeoUteis);

  FreeAndNil(FRESTRequest);
  FreeAndNil(FRestResponse);
  FreeAndNil(FRESTClient);

  inherited;
end;

procedure TMFCRestClient.setInicial;
begin
  FRESTClient.BaseURL := '';
  FURLDocumentacao := '';
end;

procedure TMFCRestClient.SetKeyAPI(const Value: string);
begin
  FKeyAPI := Value;
end;

procedure TMFCRestClient.SetProxyPassword(const Value: String);
begin
  FProxyPassword := Value;
  FRESTClient.ProxyPassword := Value;
end;

procedure TMFCRestClient.SetProxyPort(const Value: Integer);
begin
  FProxyPort := Value;
  FRESTClient.ProxyPort := Value;
end;

procedure TMFCRestClient.SetProxyServer(const Value: String);
begin
  FProxyServer := Value;
  FRESTClient.ProxyServer := Value;
end;

procedure TMFCRestClient.SetProxyUserName(const Value: String);
begin
  FProxyUserName := Value;
  FRESTClient.ProxyUsername := Value;
end;

end.
