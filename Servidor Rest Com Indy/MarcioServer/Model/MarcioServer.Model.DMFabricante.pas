unit MarcioServer.Model.DMFabricante;

interface

uses
  System.SysUtils, System.Classes, System.TypInfo, Winapi.Windows,
  MarcioServer.Model.DMBase, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Generics.Collections, Toviasur.Comuns,
  REST.Json, System.Json, REST.JsonReflect,
  Entidade.Base,
  Entidade.Fabricante;

type
  TDMFabricante = class(TDMBase)
    FDListaFabricante: TFDQuery;
    FDListaFabricanteROWID: TLargeintField;
    FDListaFabricanteFABRICANTE: TFDAutoIncField;
    FDListaFabricanteDESCRICAO: TStringField;
    FDListaFabricanteREVISAO: TIntegerField;
    FDEdicao: TFDQuery;
    FDEdicaoFABRICANTE: TFDAutoIncField;
    FDEdicaoDESCRICAO: TStringField;
    FDEdicaoREVISAO: TIntegerField;
    FDFabricanteUsadoModelo: TFDQuery;
    FDFabricanteUsadoModeloQTDE: TLargeintField;
  private
    procedure PodeExcluir(const aFabricante: TFabricante);

    function Excluir(const aFabricante: TFabricante): String;
    function Incluir(const aFabricante: TFabricante): String;
    function Alterar(const aFabricante: TFabricante): String;
  public
    function getLista: TJSONObject;
    function AtualizarLista(AContainer: TContainerBase<TFabricante>)
      : TJSONObject;

    function getDicionarioFabricante: TDictionary<Integer, TFabricante>;
  end;

implementation

{$R *.dfm}

function TDMFabricante.Alterar(const aFabricante
  : TFabricante): String;
begin
  try
    FDEdicao.Close;
    FDEdicao.Params.ParamByName('FABRICANTE').AsInteger := aFabricante.PK;
    FDEdicao.Open;

    if FDEdicaoREVISAO.AsInteger <> aFabricante.Revisao then
    begin
      raise Exception.Create('Registro alterado por outro usuário!');
    end;

    FDEdicao.Edit;
    FDEdicaoREVISAO.AsInteger := FDEdicaoREVISAO.AsInteger + 1;
    FDEdicaoDESCRICAO.AsString := Trim(aFabricante.Descricao);
    FDEdicao.Post;
  except
    on E: Exception do
    begin
      Result := 'Erro alteração ' + aFabricante.Descricao + ': ' +
        E.Message;
    end;
  end;
end;

function TDMFabricante.AtualizarLista(AContainer: TContainerBase<TFabricante>)
  : TJSONObject;
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

        Result := TServerUtils.getMensagemJsonObject(200, 'Processo Concluído.');
      except
        on E: Exception do
        begin
          Result := TServerUtils.getMensagemJsonObject(400, E.Message);
        end;
      end;
    end);
end;

function TDMFabricante.Excluir(const aFabricante
  : TFabricante): String;
begin
  try
    PodeExcluir(aFabricante);

    FDEdicao.Close;
    FDEdicao.Params.ParamByName('FABRICANTE').AsInteger := aFabricante.PK;
    FDEdicao.Open;

    if FDEdicaoREVISAO.AsInteger <> aFabricante.Revisao then
    begin
      raise Exception.Create('Registro alterado por outro usuário!');
    end;

    FDEdicao.Delete;
  except
    on E: Exception do
    begin
      Result := 'Erro exclusão fabricante ' + aFabricante.Descricao + ': ' +
        E.Message;
    end;
  end;
end;

function TDMFabricante.getDicionarioFabricante
  : TDictionary<Integer, TFabricante>;
begin
  Result := TDictionary<Integer, TFabricante>.Create;
  try
    EnterCriticalSection(NegocioCriticalSection);
    FDConexao.Open;

    FDListaFabricante.Open;
    FDListaFabricante.First;
    while not FDListaFabricante.Eof do
    begin
      Result.Add(FDListaFabricanteFABRICANTE.AsInteger,
        TFabricante.Create(FDListaFabricanteFABRICANTE.AsInteger,
        FDListaFabricanteREVISAO.AsInteger, 0, 0,
        FDListaFabricanteDESCRICAO.AsString));

      FDListaFabricante.Next;
    end;
  finally
    FDListaFabricante.Close;
    FDConexao.Close;
    LeaveCriticalSection(NegocioCriticalSection);
  end;
end;

function TDMFabricante.getLista: TJSONObject;
begin
  Result := Processar(
    function: TJSONObject
    var
      Container: TContainerBase<TFabricante>;
    begin
      Container := TContainerBase<TFabricante>.Create;
      try
        FDListaFabricante.Open;
        FDListaFabricante.First;
        while not FDListaFabricante.Eof do
        begin
          Container.AddLinha(TFabricante.Create
            (FDListaFabricanteFABRICANTE.AsInteger,
            FDListaFabricanteREVISAO.AsInteger, 0, 0,
            FDListaFabricanteDESCRICAO.AsString));

          FDListaFabricante.Next;
        end;
      finally
        Result := TJson.ObjectToJsonObject(Container);
        FreeAndNil(Container);
        FDListaFabricante.Close;
      end;
    end);
end;

function TDMFabricante.Incluir(const aFabricante
  : TFabricante): String;
begin
  try
    FDEdicao.Close;
    FDEdicao.Params.ParamByName('FABRICANTE').AsInteger := -1;
    FDEdicao.Open;

    FDEdicao.Append;
    FDEdicaoREVISAO.AsInteger := 1;
    FDEdicaoDESCRICAO.AsString := Trim(aFabricante.Descricao);
    FDEdicao.Post;
  except
    on E: Exception do
    begin
      Result := 'Erro inclusão ' + aFabricante.Descricao + ': ' +
        E.Message;
    end;
  end;
end;

procedure TDMFabricante.PodeExcluir(const aFabricante: TFabricante);
begin
  try
    FDFabricanteUsadoModelo.Close;
    FDFabricanteUsadoModelo.Params.ParamByName('FABRICANTE').AsInteger := aFabricante.PK;
    FDFabricanteUsadoModelo.Open;

    if FDFabricanteUsadoModeloQTDE.AsInteger<>0 then
    begin
      raise Exception.Create('Fabricante está sendo utilizado!');
    end;
  finally
    FDFabricanteUsadoModelo.Close;
  end;
end;

end.
