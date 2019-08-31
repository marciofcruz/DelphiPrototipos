// Desenvolvido por Marcio Fernandes Cruz
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/

unit marciofcruz.GeoMatrizDistancia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  ComCtrls, ExtCtrls,
  DateUtils,
  marciofcruz.RestClient,
  REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, IPPeerClient;

type
  TStatusMatrizDistancia = (stNenhum, stOk, stInvalidRequest, stMaxElementsExceeded, stOverQueryLimit, stRequestDenied, stUnknowError, stOutros, stNotFound, stZeroResults);
  TMatrizModotransporte = (mtCondutor, mtPedestre, mtBicicleta, mtTransportePublico);
  TMatrizOpcaoTrafego = (moNenhum, moMelhorChute, moPessimista, moOtimista);
  TMatrizTipoHorario = (mhPartida, mhChegada);
  TMatrizRoteamentoTransportePublico = (mrMenosCaminhada, mrMenosBaldeacao);
  TMatrizRestricao = (trNenhum, trPedagio, trRodovia, trEstradaDeFerro, trInterior);

  TMatrizCoordenada=  record
    Latitude, Longitude: double;
  end;

  TMatrizResultado = record
    Valor: Integer;
    Texto: String;
  end;

  TCustoTransporte = record
    Moeda: String;
    Valor: Currency;
    Texto: String;
  end;

  TMFCGeoMatrizDistancia = class(TMFCRestClient)
  private
    FCoordenadaOrigem: TMatrizCoordenada;
    FCoordenadaDestino: TMatrizCoordenada;

    FMatrizModotransporte: TMatrizModotransporte;
    FMatrizOpcaoTrafego: TMatrizOpcaoTrafego;
    FMatrizTipoHorario: TMatrizTipoHorario;

    FStatus: TStatusMatrizDistancia;

    FRestricao: TMatrizRestricao;

    FPreferenciaOnibus: Boolean;
    FPreferenciaMetro: Boolean;
    FPreferenciaTrem: Boolean;
    FPreferenciaBonde: Boolean;
    FPreferenciaEstradaFerro: Boolean;

    FRoteamentoTransportePublico: TMatrizRoteamentoTransportePublico;

    FHorario: TDateTime;

    FDistancia: TMatrizResultado;
    FDuracao: TMatrizResultado;
    FTransito: TMatrizResultado;
    FCustoTransporte: TCustoTransporte;

    function getPreferenciaTransporte:string;
    function getParametroMode:string;
    function getParametroAvoid:string;
    function getParametroOpcaoTrafego:string;
    function getParametroRoteamentoTransportePublico:String;

    function getStatusGoogle(Valor: String):TStatusMatrizDistancia;
  protected
    procedure setInicial; override;
  public
    procedure Reset;

    function getDescricaoStatusGoogle(Status: TStatusMatrizDistancia):String;

    procedure setCoordenadaOrigem(ALatitude, ALongitude: double);
    procedure setCoordenadaDestino(ALatitude, ALongitude: double);

    procedure setModoTransporte(Valor: TMatrizModotransporte);

    procedure setOpcaoTrafego(Valor: TMatrizOpcaoTrafego);

    procedure setRestricao(Valor: TMatrizRestricao);

    procedure setTipoHorario(Valor: TMatrizTipoHorario);
    procedure setHorario(Valor: TDateTime);

    procedure setPreferenciaOnibus(Valor: Boolean);
    procedure setPreferenciaMetro(Valor: Boolean);
    procedure setPreferenciaTrem(Valor: Boolean);
    procedure setPreferenciaBonde(Valor: Boolean);
    procedure setPreferenciaEstradaFerro(Valor: Boolean);

    procedure setRoteamentoTransportePublico(Valor: TMatrizRoteamentoTransportePublico);

    function Executar:Boolean;

    property Status: TStatusMatrizDistancia read FStatus;
    property Distancia: TMatrizResultado read FDistancia;
    property Duracao: TMatrizResultado read FDuracao;
    property Transito: TMatrizResultado read FTransito;
    property CustoTransporte: TCustoTransporte read FCustoTransporte;
  end;

implementation

{ TMFCGeoMatrizDistancia }

function TMFCGeoMatrizDistancia.getParametroAvoid: String;
begin
  Result := '';

  case FRestricao of
    trPedagio: Result := 'tolls';
    trRodovia: Result := 'highways';
    trEstradaDeFerro: Result := 'ferries';
    trInterior: Result := 'indoor';
  end;
end;

function TMFCGeoMatrizDistancia.getParametroMode: string;
begin
  case FMatrizModotransporte of
    mtCondutor: Result := 'driving';
    mtPedestre: Result := 'walking';
    mtBicicleta: Result := 'bicycling';
    mtTransportePublico: Result := 'transit';
  end;
end;

function TMFCGeoMatrizDistancia.getParametroOpcaoTrafego: string;
begin
  case FMatrizOpcaoTrafego of
    moMelhorChute: Result := 'best_guess';
    moPessimista: Result := 'pessimistic';
    moOtimista: Result := 'optimistic';
  end;
end;

function TMFCGeoMatrizDistancia.getParametroRoteamentoTransportePublico: String;
begin
  if FRoteamentoTransportePublico=mrMenosCaminhada then
  begin
    Result := 'less_walking';
  end
  else
  begin
    Result := 'fewer_transfers';
  end;
end;

function TMFCGeoMatrizDistancia.getPreferenciaTransporte: string;

  procedure Add(Valor: String);
  begin
    if Result='' then
    begin
      Result := Valor;
    end
    else
    begin
      Result := Result+'|'+Valor;
    end;
  end;

begin
  if FPreferenciaOnibus then
  begin
    Add('bus');
  end;

  if FPreferenciaEstradaFerro then
  begin
    Add('rail');
  end
  else
  begin
    if FPreferenciaMetro then
    begin
      Add('subway');
    end;

    if FPreferenciaTrem then
    begin
      Add('train');
    end;

    if FPreferenciaBonde then
    begin
      Add('tram');
    end;
  end;
end;

function TMFCGeoMatrizDistancia.Executar: Boolean;
var
  principal: TJSONValue;
  status: TJSONValue;
  rows: TJSONArray;
//  i: smallint;
  Auxiliar: String;
  elemento: TJSONObject;
  duracao: TJSONObject;
  distancia: TJSONObject;
  trafego: TJSONObject;
  fare: TJSONObject;
  elementoUnico: TJSONObject;
  statusElemento: TJSONValue;


begin
  try
    FTempoProcessamento := GetTickCount;

    FRESTRequest.Params.Clear;
    FRESTRequest.Params.AddItem('units', 'metric', pkGETorPOST, [], ctTEXT_PLAIN);
    FRESTRequest.Params.AddItem('origins', FloatToJson(FCoordenadaOrigem.Latitude)+','+FloatToJson(FCoordenadaOrigem.Longitude), pkGETorPOST, [], ctTEXT_PLAIN);
    FRESTRequest.Params.AddItem('destinations', FloatToJson(FCoordenadaDestino.Latitude)+','+FloatToJson(FCoordenadaDestino.Longitude), pkGETorPOST, [], ctTEXT_PLAIN);
    FRESTRequest.Params.AddItem('key', KeyAPI, pkGETorPOST, [], ctTEXT_PLAIN);
    FRESTRequest.Params.AddItem('language', 'pt-BR', pkGETorPOST, [], ctTEXT_PLAIN);
    FRESTRequest.Params.AddItem('mode', getParametroMode, pkGETorPOST, [], ctTEXT_PLAIN);

    Auxiliar := getParametroAvoid;
    if Auxiliar<>'' then
    begin
      FRESTRequest.Params.AddItem('avoid', Auxiliar, pkGETorPOST, [], ctTEXT_PLAIN);
    end;

    if (FMatrizModotransporte=mtCondutor) and (FMatrizTipoHorario=mhPartida) then
    begin
      FRESTRequest.Params.AddItem('traffic_model', getParametroOpcaoTrafego, pkGETorPOST, [], ctTEXT_PLAIN);
    end;

    if FMatrizModotransporte=mtCondutor then
    begin
      Auxiliar := getPreferenciaTransporte;
      if Auxiliar<>'' then
      begin
        FRESTRequest.Params.AddItem('transit_mode', Auxiliar, pkGETorPOST, [], ctTEXT_PLAIN);
      end;
    end
    else if FMatrizModotransporte=mtTransportePublico then
    begin
      FRESTRequest.Params.AddItem('transit_routing_preference', getParametroRoteamentoTransportePublico, pkGETorPOST, [], ctTEXT_PLAIN);
    end;

    if FMatrizOpcaoTrafego<>moNenhum then
    begin
      Auxiliar := getParametroOpcaoTrafego;

      if Auxiliar<>'' then
      begin
        FRESTRequest.Params.AddItem('traffic_model', Auxiliar, pkGETorPOST, [], ctTEXT_PLAIN);
      end;
    end;

    if FMatrizTipoHorario=mhPartida then
    begin
      FRESTRequest.Params.AddItem('departure_time', IntToStr(DateTimeToUnix(FHorario)), pkGETorPOST, [], ctTEXT_PLAIN);
    end
    else if FMatrizTipoHorario=mhChegada then
    begin
      FRESTRequest.Params.AddItem('arrival_time', IntToStr(DateTimeToUnix(FHorario)), pkGETorPOST, [], ctTEXT_PLAIN);
    end;

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

      rows := TJSONObject(principal).GetValue('rows') as TJSONArray;
      if not Assigned(rows) then
      begin
        raise Exception.Create('Não foi possível localizar o JSON results!');
      end;
//
      elemento := TJSONObject(rows.Items[0]);
      elementoUnico := TJSONArray(elemento.Values['elements']).Items[0] as TJSONObject;

      statusElemento := elementoUnico.Values['status'];
      FStatus := getStatusGoogle(UpperCase(statusElemento.Value));
      if FStatus=stOk then
      begin
        duracao := elementoUnico.GetValue('duration') as TJSONObject;
        if Assigned(duracao) then
        begin
          FDuracao.Texto := duracao.Values['text'].Value;
          FDuracao.Valor := Trunc(StrToIntDef(duracao.Values['value'].Value,0)/60);
        end;

        distancia := elementoUnico.GetValue('distance') as TJSONObject;
        if Assigned(distancia) then
        begin
          FDistancia.Texto := distancia.Values['text'].Value;
          FDistancia.Valor := StrToIntDef(distancia.Values['value'].Value,0);
        end;

        trafego := elementoUnico.GetValue('duration_in_traffic') as TJSONObject;
        if Assigned(trafego) then
        begin
          FTransito.Texto := trafego.Values['text'].Value;
          FTransito.Valor := Trunc(StrToIntDef(trafego.Values['value'].Value,0)/60);
        end;

        fare := elementoUnico.GetValue('fare') as TJSONObject;
        if Assigned(fare) then
        begin
          FCustoTransporte.Moeda := fare.Values['currency'].Value;

          try
            FCustoTransporte.Valor := FGeoUteis.TratarValor(fare.Values['value'].Value);
          except
            FCustoTransporte.Valor := 0;
          end;

          try
            FCustoTransporte.Texto := fare.Values['text'].Value;
          except
            FCustoTransporte.Texto := '';
          end;
        end;
      end;

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

function TMFCGeoMatrizDistancia.getDescricaoStatusGoogle(
  Status: TStatusMatrizDistancia): String;
begin
  case Status of
    stNenhum: Result := 'Nenhum';
    stOk: Result := 'Result é válido';
    stInvalidRequest: Result := 'Solicitação fornecida é inválida.';
    stMaxElementsExceeded: Result := 'O produto das origens e dos destinos excedem o limite por consulta';
    stOverQueryLimit: Result := 'O serviço recebeu solicitações demais do seu aplicativo no intervalo de tempo permitido.';
    stRequestDenied: Result := 'O serviço negou o uso do serviço da Distance Matrix API por parte do seu aplicativo';
    stUnknowError: Result := 'Solicitação da Distance Matrix API não foi processada devido a um erro de servidor. A solicitação poderá ser bem-sucedida se você tentar novamente.';
    stOutros: Result := 'Outros não catalogados';
    stNotFound: Result := 'Não foi possível geocodificar a origen e ou destino';
    stZeroResults: Result := 'Não foi possível encontrar rotas';
  end;
end;

function TMFCGeoMatrizDistancia.getStatusGoogle(
  Valor: String): TStatusMatrizDistancia;
begin
  if Valor='OK' then
  begin
    Result := stOk;
  end
  else if Valor='INVALID_REQUEST' then
  begin
    Result := stInvalidRequest;
  end
  else if Valor='MAX_ELEMENTS_EXCEEDED' then
  begin
    Result := stMaxElementsExceeded;
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
  else if Valor='NOT_FOUND' then
  begin
    Result := stNotFound;
  end
  else if Valor='ZERO_RESULTS' then
  begin
    result := stZeroResults;
  end
  else
  begin
    Result := stOutros;
  end;
end;

procedure TMFCGeoMatrizDistancia.Reset;
begin
  FillChar(FCoordenadaOrigem, SizeOf(FCoordenadaOrigem), 0);
  FillChar(FCoordenadaDestino, SizeOf(FCoordenadaDestino), 0);

  Fillchar(FDistancia, SizeOf(FDistancia), 0);
  FillChar(FDuracao, SizeOf(FDuracao), 0);
  FillChar(FTransito, SizeOf(FTransito), 0);
  FillChar(FCustoTransporte, SizeOf(FCustoTransporte), 0);

  FRestricao := trNenhum;
end;

procedure TMFCGeoMatrizDistancia.setCoordenadaDestino(ALatitude,
  ALongitude: double);
begin
  FCoordenadaDestino.Latitude := ALatitude;
  FCoordenadaDestino.Longitude:= ALongitude;
end;

procedure TMFCGeoMatrizDistancia.setCoordenadaOrigem(ALatitude,
  ALongitude: double);
begin
  FCoordenadaOrigem.Latitude := ALatitude;
  FCoordenadaOrigem.Longitude:= ALongitude;
end;

procedure TMFCGeoMatrizDistancia.setHorario(Valor: TDateTime);
begin
  FHorario := Valor;
end;

procedure TMFCGeoMatrizDistancia.setInicial;
begin
  inherited;

  FRESTClient.BaseURL := 'https://maps.googleapis.com/maps/api/distancematrix/json';
  FURLDocumentacao := 'https://developers.google.com/maps/documentation/distance-matrix/intro?hl=pt-br#travel_modes';
end;

procedure TMFCGeoMatrizDistancia.setModoTransporte(Valor: TMatrizModotransporte);
begin
  FMatrizModotransporte := Valor;
end;

procedure TMFCGeoMatrizDistancia.setOpcaoTrafego(Valor: TMatrizOpcaoTrafego);
begin
  FMatrizOpcaoTrafego := Valor;
end;

procedure TMFCGeoMatrizDistancia.setPreferenciaBonde(Valor: Boolean);
begin
  FPreferenciaBonde := Valor;
end;

procedure TMFCGeoMatrizDistancia.setPreferenciaEstradaFerro(Valor: Boolean);
begin
  FPreferenciaEstradaFerro := Valor;
end;

procedure TMFCGeoMatrizDistancia.setPreferenciaMetro(Valor: Boolean);
begin
  FPreferenciaMetro := Valor;
end;

procedure TMFCGeoMatrizDistancia.setPreferenciaOnibus(Valor: Boolean);
begin
  FPreferenciaOnibus := Valor;
end;

procedure TMFCGeoMatrizDistancia.setPreferenciaTrem(Valor: Boolean);
begin
  FPreferenciaTrem := Valor;
end;

procedure TMFCGeoMatrizDistancia.setRestricao(Valor: TMatrizRestricao);
begin
  FRestricao := Valor;
end;

procedure TMFCGeoMatrizDistancia.setRoteamentoTransportePublico(
  Valor: TMatrizRoteamentoTransportePublico);
begin
  FRoteamentoTransportePublico := Valor;
end;

procedure TMFCGeoMatrizDistancia.setTipoHorario(Valor: TMatrizTipoHorario);
begin
  FMatrizTipoHorario := Valor;
end;

end.
