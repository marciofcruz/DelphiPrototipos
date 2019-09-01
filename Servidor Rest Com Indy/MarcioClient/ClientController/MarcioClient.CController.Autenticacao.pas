unit MarcioClient.CController.Autenticacao;

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
  Entidade.Base,
  Toviasur.Estrutura.Token,
  MarcioClient.CController.Base;

type
  TAutenticacao = class(TControllerBase)
  private
    function ExecutarPost(const AJson: String):TRetornoToken;
  public
    function Autenticar(const aUsuarioSistema, aSenhaSistema: String):TRetornoToken;
  end;

implementation

{ TControllerAutenticacao }

function TAutenticacao.Autenticar(const aUsuarioSistema, aSenhaSistema: String): TRetornoToken;
var
  Requisicao: TRequisitaToken;
begin
  Requisicao := TRequisitaToken.Create;
  try
    Requisicao.Login := aUsuarioSistema;
    Requisicao.Senha := aSenhaSistema;
    Result := ExecutarPost(TJson.ObjectToJsonObject(Requisicao).ToJSON);
  finally
    FreeAndnil(Requisicao);
  end;
end;

function TAutenticacao.ExecutarPost(const AJson: String): TRetornoToken;
var
  TextoRetorno: String;
begin
  Result := nil;

  EnterCriticalSection(ControllerCriticalSection);
  try
    FRESTClient.BaseURL := BaseURL+'/gettokenusuario';
    FRestRequest.Method := TRESTRequestMethod.rmPOST;

    FRestRequest.Params.Clear;

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

end.
