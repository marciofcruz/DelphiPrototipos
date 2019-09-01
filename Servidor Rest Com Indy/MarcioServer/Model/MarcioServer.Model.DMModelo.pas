unit MarcioServer.Model.DMModelo;

interface

uses
  System.SysUtils, System.Classes, System.TypInfo,
  MarcioServer.Model.DMBase, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Generics.Collections,
  REST.Json, System.Json, REST.JsonReflect,
  Entidade.Base,
  Entidade.Fabricante,
  Entidade.Modelo;

type
  TDMModelo = class(TDMBase)
    FDListaModelo: TFDQuery;
    FDListaModeloMODELO: TFDAutoIncField;
    FDListaModeloDESCRICAO: TStringField;
    FDListaModeloREVISAO: TIntegerField;
    FDListaModeloFABRICANTE: TIntegerField;
    FDEdicao: TFDQuery;
    FDEdicaoMODELO: TFDAutoIncField;
    FDEdicaoDESCRICAO: TStringField;
    FDEdicaoREVISAO: TIntegerField;
    FDEdicaoFABRICANTE: TIntegerField;
    FDModeloRepetido: TFDQuery;
    FDModeloRepetidoQTDE: TLargeintField;
    FDListaModeloDESCFABRICANTE: TStringField;
    FDPodeExcluir: TFDQuery;
    FDPodeExcluirqtde: TLargeintField;
  private
    procedure TesteJahExiste(const aModelo: TModelo);

    function Excluir(const aModelo: TModelo): String;
    function Incluir(const aModelo: TModelo): String;
    function Alterar(const aModelo: TModelo): String;
  public
    function getLista: TJSONObject;
    function AtualizarLista(AContainer: TContainerBase<TModelo>): TJSONObject;
  end;

implementation

uses
  Toviasur.Comuns,
  MarcioServer.Model.DMFabricante;

{$R *.dfm}
{ TDMModelo }

function TDMModelo.Alterar(const aModelo: TModelo): String;
begin
 try
    TesteJahExiste(aModelo);

    FDEdicao.Close;
    FDEdicao.Params.ParamByName('MODELO').AsInteger := aModelo.PK;
    FDEdicao.Open;

    if FDEdicaoREVISAO.AsInteger <> aModelo.Revisao then
    begin
      raise Exception.Create('Registro alterado por outro usuário!');
    end;

    FDEdicao.Edit;
    FDEdicaoREVISAO.AsInteger := FDEdicaoREVISAO.AsInteger + 1;
    FDEdicaoDESCRICAO.AsString := Trim(aModelo.Descricao);
    FDEdicaoFABRICANTE.AsInteger := aModelo.Fabricante.PK;
    FDEdicao.Post;
  except
    on E: Exception do
    begin
      Result := 'Erro alteração ' + aModelo.Descricao + ': ' +
        E.Message;
    end;
  end;

end;

function TDMModelo.AtualizarLista(
  AContainer: TContainerBase<TModelo>): TJSONObject;
begin
  Result := Processar(
    function: TJSONObject
    var
      Cont: Integer;
      Auxiliar: String;
    begin
      try
        for Cont := 0 to Length(AContainer.Linhas) - 1 do
        begin
          Auxiliar := '';
          if AContainer.Linhas[Cont].Excluido = 1 then
          begin
            Auxiliar := Excluir(AContainer.Linhas[Cont]);
          end
          else if AContainer.Linhas[Cont].Alterado = 1 then
          begin
            if AContainer.Linhas[Cont].PK = 0 then
            begin
              Auxiliar := Incluir(AContainer.Linhas[Cont]);
            end
            else
            begin
              Auxiliar := Alterar(AContainer.Linhas[Cont]);
            end;
          end;

          if Auxiliar <> '' then
          begin
            raise Exception.Create(Auxiliar);
          end;
        end;

        Result := TServerUtils.getMensagemJsonObject(200, 'OK');
      except
        on E: Exception do
        begin
          Result := TServerUtils.getMensagemJsonObject(400, E.Message);
        end;
      end;
    end);
end;

function TDMModelo.Excluir(const aModelo: TModelo): String;
begin
  try
    FDPodeExcluir.Close;
    FDPodeExcluir.Params.ParamByName('MODELO').AsInteger := aModelo.PK;
    FDPodeExcluir.Open;

    if FDPodeExcluirqtde.AsInteger<>0 then
    begin
      raise Exception.Create('Modelo está sendo utilizado!');
    end;

    FDEdicao.Close;
    FDEdicao.Params.ParamByName('MODELO').AsInteger := aModelo.PK;
    FDEdicao.Open;

    if FDEdicaoREVISAO.AsInteger <> aModelo.Revisao then
    begin
      raise Exception.Create('Registro alterado por outro usuário!');
    end;

    FDEdicao.Delete;
  except
    on E: Exception do
    begin
      Result := 'Erro exclusão ' + aModelo.Descricao + ': ' +
        E.Message;
    end;
  end;
end;

function TDMModelo.getLista: TJSONObject;
begin
  Result := Processar(
    function: TJSONObject
    var
      Container: TContainerBase<TModelo>;
    begin
      Container := TContainerBase<TModelo>.Create;
      try
        FDListaModelo.Open;
        FDListaModelo.First;
        while not FDListaModelo.Eof do
        begin
          Container.AddLinha(TModelo.Create(FDListaModeloMODELO.AsInteger,
            FDListaModeloREVISAO.AsInteger, 0, 0,
            FDListaModeloDESCRICAO.AsString, TFabricante.Create(FDListaModeloFABRICANTE.AsInteger, 0, 0, 0, FDListaModeloDESCFABRICANTE.AsString)));

          FDListaModelo.Next;
        end;
      finally
        Result := TJson.ObjectToJsonObject(Container);
        FreeAndNil(Container);
      end;
    end);

end;

function TDMModelo.Incluir(const aModelo: TModelo): String;
begin
  try
    TesteJahExiste(aModelo);

    FDEdicao.Close;
    FDEdicao.Params.ParamByName('MODELO').AsInteger := -1;
    FDEdicao.Open;

    FDEdicao.Append;
    FDEdicaoREVISAO.AsInteger := 1;
    FDEdicaoDESCRICAO.AsString := Trim(aModelo.Descricao);
    FDEdicaoFABRICANTE.AsInteger := aModelo.Fabricante.PK;
    FDEdicao.Post;
  except
    on E: Exception do
    begin
      Result := 'Erro inclusão ' + aModelo.Descricao + ': ' +
        E.Message;
    end;
  end;

end;

procedure TDMModelo.TesteJahExiste(const aModelo: TModelo);
begin
  FDModeloRepetido.Close;
  FDModeloRepetido.Params.ParamByName('DESCRICAO').AsString := aModelo.Descricao;
  FDModeloRepetido.Params.ParamByName('FABRICANTE').AsInteger := aModelo.Fabricante.PK;
  FDModeloRepetido.Open;

  if FDModeloRepetidoQTDE.AsInteger<>0 then
  begin
    raise Exception.Create('Já existe o modelo '+aModelo.Descricao+' para o fabricante '+aModelo.Fabricante.Descricao);
  end;
end;

end.
