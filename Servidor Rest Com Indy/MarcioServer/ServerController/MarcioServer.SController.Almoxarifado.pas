unit MarcioServer.SController.Almoxarifado;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Winapi.Windows,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdContext,   Vcl.StdCtrls,
  Toviasur.Comuns, Toviasur.ControllerBase,
  REST.JSon, System.JSON,
  Dialogs;

type
  [TVSController]
  TControllerCadastro = class(TTVSControllerBase)
  private
  public
    [TVSPathAttribute('/fabricante', [verboGET])]
    function getListaFabricante(ARequestInfo: TIdHTTPRequestInfo):String;

    [TVSPathAttribute('/modelo', [verboGET])]
    function getListaModelo(ARequestInfo: TIdHTTPRequestInfo):String;

    [TVSPathAttribute('/equipamento', [verboGET])]
    function getListaEquipamento(ARequestInfo: TIdHTTPRequestInfo):String;
  end;

implementation

uses
  MarcioServer.Model.DMBase,
  MarcioServer.Model.DMFabricante,
  MarcioServer.Model.DMModelo,
  MarcioServer.Model.DMEquipamento,
  Comum.Pesquisa.Equipamento;

function TControllerCadastro.getListaEquipamento(
  ARequestInfo: TIdHTTPRequestInfo): String;
var
  Classe: TDMBase;
  JSONObject: TJSONObject;
  PesquisaEquipamento: TPesquisaEquipamento;
begin
  PesquisaEquipamento := TJson.JsonToObject<TPesquisaEquipamento>(ARequestInfo.Params.Values['conteudo']);
  Classe := TDMEquipamento.Create(nil);
  JSONObject := TDMEquipamento(Classe).getLista(PesquisaEquipamento);
  Result := JSONObject.ToString;
end;

function TControllerCadastro.getListaFabricante(ARequestInfo: TIdHTTPRequestInfo): String;
var
  Classe: TDMBase;
  JSONObject: TJSONObject;
begin
  Classe := TDMFabricante.Create(nil);
  JSONObject := TDMFabricante(Classe).getLista;
  Result := JSONObject.ToString;
end;

function TControllerCadastro.getListaModelo(ARequestInfo: TIdHTTPRequestInfo): String;
var
  Classe: TDMBase;
  JSONObject: TJSONObject;
begin
  Classe := TDMModelo.Create(nil);
  JSONObject := TDMModelo(Classe).getLista;
  Result := JSONObject.ToString;
end;

end.
