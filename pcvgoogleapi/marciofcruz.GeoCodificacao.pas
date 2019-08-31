// Desenvolvido por Marcio Fernandes Cruz
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/


unit marciofcruz.GeoCodificacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  ComCtrls, ExtCtrls,
  marciofcruz.RestClient,
  REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, IPPeerClient;


type
  TStatusGeCodificacao = (stNenhum, stOk, stZeroResults, stOverQueryLimit,  stRequestDenied, stInvalidRequest, stUnknowError, stOutros);

  TMFCGeoCodificacao = class(TMFCRestClient)
  private
    FRua: String;
    FBairro: String;
    FCEP: String;
    FNumero: String;
    FUF: String;
    FCidade: String;

    FLatitude: double;
    FLongitude: double;
    FEndereco: String;

    FStatus: TStatusGeCodificacao;

    function getStatusGoogle(Valor: String):TStatusGeCodificacao;
    function getDescricaoStatusGoogle(Status: TStatusGeCodificacao):String;

    procedure SetRua(const Value: String);
    procedure SetBairro(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetUF(const Value: String);

    function getAddress: String;

  protected
    procedure setInicial; override;
  public
    property Rua: String read FRua write SetRua;
    property Numero: String read FNumero write SetNumero;
    property Bairro: String read FBairro write SetBairro;
    property Cidade: String read FCidade write SetCidade;
    property UF: String read FUF write SetUF;
    property CEP: String read FCEP write SetCEP;

    property Latitude: double read FLatitude;
    property Longitude: double read FLongitude;
    property Endereco: String read FEndereco;

    function Executar:Boolean;
    function getInverso(Latitude, Longitude: double):String;
  end;

implementation

{ TMFCGeoCodificacao }

function TMFCGeoCodificacao.Executar: Boolean;
var
  principal: TJSONValue;
  status: TJSONValue;
  results: TJSONArray;
  geometry: TJsonObject;
  location: TJSONObject;
  Endereco: TJSONValue;

begin
  try
    FTempoProcessamento := GetTickCount;

    FRESTRequest.Params.Clear;
    FRESTRequest.Params.AddItem('key', KeyAPI, pkGETorPOST, [], ctTEXT_PLAIN);
    FRESTRequest.Params.AddItem('address', getAddress, pkGETorPOST, [], ctTEXT_PLAIN);
    FRESTRequest.Execute;

    principal := FRestResponse.JSONValue;

    if Assigned(principal) and (principal is TJSONObject) then
    begin
      status := TJSONObject(principal).GetValue('status');
      if not Assigned(status) then
      begin
        raise Exception.Create('Não foi possível localizar a chave de status da solicitação da API do Google Maps!');
      end;

      FStatus := getStatusGoogle(UpperCase(status.Value));
      if (FStatus<>stOk) then
      begin
        raise Exception.Create('O Status da solicitação é: '+status.Value+': '+getDescricaoStatusGoogle(FStatus));
      end;

      results := TJSONObject(principal).GetValue('results') as TJSONArray;
      if not Assigned(results) then
      begin
        raise Exception.Create('Não foi possível localizar o JSON results!');
      end;

      geometry := TJSONObject(results.Items[0]).GetValue('geometry') as TJSONObject;
      if not Assigned(geometry) then
      begin
        raise Exception.Create('Não foi possível localizar o JSON geometry!');
      end;

      location := geometry.GetValue('location') as TJSONObject;
      if not Assigned(location) then
      begin
        raise Exception.Create('Não foi possível localizar o JSON location!');
      end;

      FLatitude := FGeoUteis.TratarValor(location.Values['lat'].Value);
      FLongitude := FGeoUteis.TratarValor(location.Values['lng'].Value);

      Endereco := TJSONObject(results.Items[0]).GetValue('formatted_address');

      FEndereco := Endereco.Value;

      FTempoProcessamento := GetTickCount-FTempoProcessamento;

      Result := True;
    end
    else
    begin
      raise Exception.Create('Não foi possível acessar o resultado do JSON!');
    end;
  except
    on E:Exception do
    begin
      FTempoProcessamento := 0;
      raise;
    end;
  end;
end;

function TMFCGeoCodificacao.getAddress: String;
begin
  Result := StringReplace(Rua, '+', ' ', [rfReplaceAll]) + '+' +
    StringReplace(Numero, '+', ' ', [rfReplaceAll]);

  Result := Result + '+' + StringReplace(Bairro, '+', ' ',
    [rfReplaceAll]);
  Result := Result + '+' + StringReplace(Cidade, '+', ' ',
    [rfReplaceAll]);
  Result := Result + '+' + StringReplace(UF, '+', ' ', [rfReplaceAll]);
  Result := Result + '+' + StringReplace(CEP, '+', ' ', [rfReplaceAll]);
end;

function TMFCGeoCodificacao.getDescricaoStatusGoogle(
  Status: TStatusGeCodificacao): String;
begin
  case Status of
    stNenhum: Result := 'Nenhum';
    stOk: Result := 'Result é válido';
    stZeroResults: Result := 'Código geográfico foi bem-sucedido, mas não retornou resultados. Isso poderá ocorrer se o geocodificador receber um address que não existe';
    stInvalidRequest: Result := 'Solicitação fornecida é inválida.';
    stOverQueryLimit: Result := 'O serviço recebeu solicitações demais do seu aplicativo no intervalo de tempo permitido.';
    stRequestDenied: Result := 'Solicitação foi negada.';
    stUnknowError: Result := 'solicitação não foi processada devido a um erro de servidor. A solicitação poderá ser bem-sucedida se você tentar novamente.';
    stOutros: Result := 'Outros não catalogados';
  end;
end;

function TMFCGeoCodificacao.getInverso(Latitude, Longitude: double): String;
var
  principal: TJSONValue;
  status: TJSONValue;
  results: TJSONArray;
  Endereco: TJSONValue;

begin
  try
    FTempoProcessamento := GetTickCount;

    FRESTRequest.Params.Clear;
    FRESTRequest.Params.AddItem('Key', KeyAPI, pkGETorPOST, [], ctTEXT_PLAIN);
    FRESTRequest.Params.AddItem('latlng', FloatToJson(Latitude)+','+FloatToJson(Longitude), pkGETorPOST, [], ctTEXT_PLAIN);
    FRESTRequest.Execute;

    principal := FRestResponse.JSONValue;

    if Assigned(principal) and (principal is TJSONObject) then
    begin
      status := TJSONObject(principal).GetValue('status');
      if not Assigned(status) then
      begin
        raise Exception.Create('Não foi possível localizar a chave de status da solicitação da API do Google Maps!');
      end;

      FStatus := getStatusGoogle(UpperCase(status.Value));
      if (FStatus<>stOk) then
      begin
        raise Exception.Create('O Status da solicitação é: '+status.Value+': '+getDescricaoStatusGoogle(FStatus));
      end;

      results := TJSONObject(principal).GetValue('results') as TJSONArray;
      if not Assigned(results) then
      begin
        raise Exception.Create('Não foi possível localizar o JSON results!');
      end;

      Endereco := TJSONObject(results.Items[0]).GetValue('formatted_address');

      Result := Endereco.Value;

      FTempoProcessamento := GetTickCount-FTempoProcessamento;
    end
    else
    begin
      raise Exception.Create('Não foi possível acessar o resultado do JSON!');
    end;
  except
    on E:Exception do
    begin
      FTempoProcessamento := 0;
      raise;
    end;
  end;
end;

function TMFCGeoCodificacao.getStatusGoogle(Valor: String): TStatusGeCodificacao;
begin
  if Valor='OK' then
  begin
    Result := stOk;
  end
  else if Valor='INVALID_REQUEST' then
  begin
    Result := stInvalidRequest;
  end
  else if Valor='ZERO_RESULTS' then
  begin
    Result := stZeroResults;
  end
  else if Valor='OVER_QUERY_LIMIT' then
  begin
    Result := stOverQueryLimit;
  end
  else if Valor='REQUEST_DENIED' then
  begin
    Result := stRequestDenied;
  end
  else if Valor='UNKNOWN_ERROR' then
  begin
    Result := stUnknowError;
  end
  else
  begin
    Result := stOutros;
  end;
end;

procedure TMFCGeoCodificacao.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TMFCGeoCodificacao.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TMFCGeoCodificacao.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TMFCGeoCodificacao.setInicial;
begin
  FRESTClient.BaseURL := 'https://maps.googleapis.com/maps/api/geocode/json';
  FURLDocumentacao := 'https://developers.google.com/maps/documentation/geocoding/start?hl=pt-br';
end;

procedure TMFCGeoCodificacao.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TMFCGeoCodificacao.SetRua(const Value: String);
begin
  FRua := Value;
end;

procedure TMFCGeoCodificacao.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
