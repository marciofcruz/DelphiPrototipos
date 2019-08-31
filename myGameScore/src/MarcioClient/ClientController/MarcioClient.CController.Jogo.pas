unit MarcioClient.CController.Jogo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, Data.DB, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Comp.Client, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  REST.Authenticator.Basic,
  REST.Json, System.Json, REST.JsonReflect, IdHTTP,
  REST.Response.Adapter,
  Entidade.Base,
  Entidade.Resultado,
  EstruturaToken,
  MarcioClient.CController.Base;

type
  TJogo = class(TControllerBase)
  private
    function ExecutarPost(const AJson: String): TRetornoToken;
  public
    function Lancar(const aData: TDateTime; const aPonto: Byte): TRetornoToken;
    function getResultado:TResultadoJogo;
  end;

implementation

uses
  Entidade.Jogo;

function TJogo.ExecutarPost(const AJson: String): TRetornoToken;
var
  TextoRetorno: String;
begin
  Result := nil;

  EnterCriticalSection(ControllerCriticalSection);
  try
    FRESTClient.BaseURL := BaseURL+'/jogo';
    FRestRequest.Method := TRESTRequestMethod.rmPOST;

    FRestRequest.Params.Clear;

    FRestRequest.Params.Add;
    FRestRequest.Params[FRestRequest.Params.Count-1].Name := 'token';
    FRestRequest.Params[FRestRequest.Params.Count-1].Value := Token;

    FRestRequest.Params.Add;
    FRestRequest.Params[FRestRequest.Params.Count-1].Name := 'conteudo';
    FRestRequest.Params[FRestRequest.Params.Count-1].Value := AJson;

    FRestRequest.Execute;
    TextoRetorno := FRestResponse.JSONText;

    Result := TJson.JsonToObject<TRetornoToken>(TextoRetorno);
  finally
    LeaveCriticalSection(ControllerCriticalSection);
  end;
end;

function TJogo.getResultado: TResultadoJogo;
var
  Retorno: String;
begin
  Retorno := ExecutarGET('jogo');

  Result := TJson.JsonToObject<TResultadoJogo>(Retorno);
end;

function TJogo.Lancar(const aData: TDateTime; const aPonto: Byte): TRetornoToken;
var
  Jogo: Entidade.Jogo.TJogo;
begin
  Jogo := Entidade.Jogo.TJogo.Create(Token, aData, aPonto);
  try
    Result := ExecutarPost(TJson.ObjectToJsonObject(Jogo).ToJSON);
  finally
    FreeAndnil(Jogo);
  end;
end;

end.
