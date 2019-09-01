unit MarcioClient.CController.Equipamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, MarcioClient.CController.Base,
  Entidade.Base, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  REST.Json, System.JSON, Rest.JsonReflect, Entidade.Equipamento,
  Comum.Pesquisa.Equipamento;


type
  TControllerEquipamento = class(TControllerBase)
  private
    FParametrosPesquisa: TPesquisaEquipamento;
  public
    constructor Create;
    destructor Destroy; override;

    property ParametrosPesquisa: TPesquisaEquipamento read FParametrosPesquisa write FParametrosPesquisa;

    procedure CarregarLista(const ANomeMetodo: String; Tabela: TFDMemTable); override;
    function EnviarLista(const ANomeMetodo: String; Tabela: TFDMemTable):TRetornoJSON; override;
    function setRegistro(const aChaveInterna: Integer; const aDataDevolucao: TDateTime; const ANomeMetodo: String; Tabela: TFDMemTable):TRetornoJSON;
  end;

implementation

uses
  Entidade.Modelo, Entidade.Fabricante;

{ TControllerEquipamento }

procedure TControllerEquipamento.CarregarLista(const ANomeMetodo: String;
  Tabela: TFDMemTable);
var
  Retorno: String;
  Container: TContainerEquipamento;
  Cont: Integer;
  BookMark: TBookmark;
begin
  BookMark := nil;

  Retorno := ExecutarGET(ANomeMetodo, TJson.ObjectToJsonObject(FParametrosPesquisa).ToJSON);
  Container := TJson.JsonToObject<TContainerEquipamento>(Retorno);

  try
    if Tabela.Active then
    begin
      BookMark := Tabela.GetBookmark;
    end;

    Tabela.DisableControls;
    Tabela.Close;
    Tabela.Open;

    for Cont:=0 to Length(Container.Linhas)-1 do
    begin
      Tabela.Append;
      Tabela.FieldByName('CHAVEINTERNA').AsInteger := Container.Linhas[Cont].PK;
      Tabela.FieldByName('DESCRICAO').AsString := Container.Linhas[Cont].Descricao;
      Tabela.FieldByName('REVISAO').AsInteger := Container.Linhas[Cont].Revisao;
      Tabela.FieldByName('SERIE').AsString := Container.Linhas[Cont].Serie;
      Tabela.FieldByName('CATEGORIA').AsString := Container.Linhas[Cont].Categoria;
      Tabela.FieldByName('DATAENTRADA').AsDateTime := Container.Linhas[Cont].DataEntrada;

      if Container.Linhas[Cont].DataSaida>0 then
      begin
        Tabela.FieldByName('DATASAIDA').AsDateTime := Container.Linhas[Cont].DataSaida;
      end;

      Tabela.FieldByName('MODELO').AsInteger := Container.Linhas[Cont].Modelo.PK;
      Tabela.FieldByName('DESCMODELO').AsString := Container.Linhas[Cont].Modelo.Descricao;
      Tabela.FieldByName('FABRICANTE').AsInteger := Container.Linhas[Cont].Modelo.Fabricante.PK;
      Tabela.FieldByName('DESCFABRICANTE').AsString := Container.Linhas[Cont].Modelo.Fabricante.Descricao;
      Tabela.FieldByName('EXCLUIDO').AsInteger := 0;
      Tabela.Post;
    end;
  finally
    if Assigned(BookMark) and Tabela.BookmarkValid(BookMark) then
    begin
      Tabela.GotoBookmark(BookMark);
      Tabela.FreeBookmark(BookMark);
    end
    else
    begin
      Tabela.First;
    end;

    Tabela.EnableControls;
  end;
end;

constructor TControllerEquipamento.Create;
begin
  inherited;
  FParametrosPesquisa := TPesquisaEquipamento.Create;
end;

destructor TControllerEquipamento.Destroy;
begin
  FreeAndnil(FParametrosPesquisa);

  inherited;
end;

function TControllerEquipamento.EnviarLista(const ANomeMetodo: String;
  Tabela: TFDMemTable): TRetornoJSON;
var
  Container: TContainerBase<TEquipamento>;
  Cont: Integer;
  BookMark: TBookMark;
  Fabricante: TFabricante;
  Modelo: TModelo;
begin
  inherited;

  Result := nil;

  Container := TContainerBase<TEquipamento>.Create;
  try
    try
      Tabela.DisableControls;

      BookMark := Tabela.GetBookmark;

      Tabela.Filtered := False;

      Tabela.First;

      while not Tabela.Eof do
      begin
        if (Tabela.FieldByName('EXCLUIDO').AsInteger=1) or
           (Tabela.FieldByName('ALTERADO').AsInteger=1) then
        begin
          Fabricante := TFabricante.Create(Tabela.FieldByName('FABRICANTE').AsInteger, 0, 0, 0, Tabela.FieldByName('DESCFABRICANTE').AsString);
          Modelo := TModelo.Create(Tabela.FieldByName('MODELO').AsInteger, 0, 0, 0, Tabela.FieldByName('DESCMODELO').AsString,
                                                               Fabricante);

          Container.AddLinha(TEquipamento.Create(Tabela.FieldByName('CHAVEINTERNA').AsInteger,
                                                Tabela.FieldByName('REVISAO').AsInteger,
                                                Tabela.FieldByName('EXCLUIDO').AsInteger,
                                                Tabela.FieldByName('ALTERADO').AsInteger,
                                                Tabela.FieldByName('DESCRICAO').AsString,
                                                Modelo,
                                                Tabela.FieldByName('DATAENTRADA').AsDateTime,
                                                Tabela.FieldByName('DATASAIDA').AsDateTime,
                                                Tabela.FieldByName('SERIE').AsString,
                                                Tabela.FieldByName('CATEGORIA').AsString));

          if Tabela.FieldByName('EXCLUIDO').AsInteger=1 then
          begin
            Tabela.Delete;
            Tabela.First;
          end
          else if Tabela.FieldByName('ALTERADO').AsInteger=1 then
          begin
            Tabela.Edit;
            Tabela.FieldByName('ALTERADO').AsInteger := 0;
            Tabela.Post;
          end;
        end;

        Tabela.Next;
      end;

      if Tabela.BookmarkValid(BookMark) then
      begin
        Tabela.GotoBookmark(BookMark);
      end
      else
      begin
        Tabela.First;
      end;

      if Length(Container.Linhas)=0 then
      begin
        Result := TRetornoJSON.Create;
        Result.Status := 200;
        Result.Mensagem := 'Nenhuma linha para ser sincronizada!';
      end
      else
      begin
        Result := ExecutarPost(ANomeMetodo, TJson.ObjectToJsonObject(Container).ToJSON);
      end;
    except
      on E:Exception do
      begin
        if Assigned(Modelo) then
        begin
          FreeAndnil(Modelo);
        end;

        if Result=nil then
        begin
          Result := TRetornoJSON.Create;
          Result.STATUS := -1;
          Result.MENSAGEM := E.Message;
        end;
      end;
    end;
  finally
    Tabela.Filtered := True;
    Tabela.FreeBookmark(BookMark);
    Tabela.EnableControls;
    FreeAndNil(Container);
  end;
end;

function TControllerEquipamento.setRegistro(const aChaveInterna: Integer; const aDataDevolucao: TDateTime; const ANomeMetodo: String;
  Tabela: TFDMemTable): TRetornoJSON;
var
  Container: TContainerBase<TEquipamento>;
  Cont: Integer;
  Fabricante: TFabricante;
  Modelo: TModelo;
begin
  inherited;

  Result := nil;
  Fabricante := nil;
  Modelo := nil;

  Container := TContainerBase<TEquipamento>.Create;
  try
    try
      if Tabela.Locate('CHAVEINTERNA', aChaveInterna, []) then
      begin
        Fabricante := TFabricante.Create(Tabela.FieldByName('FABRICANTE').AsInteger, 0, 0, 0, Tabela.FieldByName('DESCFABRICANTE').AsString);
        Modelo := TModelo.Create(Tabela.FieldByName('MODELO').AsInteger, 0, 0, 0, Tabela.FieldByName('DESCMODELO').AsString,
                                                             Fabricante);

        Container.AddLinha(TEquipamento.Create(Tabela.FieldByName('CHAVEINTERNA').AsInteger,
                                            Tabela.FieldByName('REVISAO').AsInteger,
                                            Tabela.FieldByName('EXCLUIDO').AsInteger,
                                            Tabela.FieldByName('ALTERADO').AsInteger,
                                            Tabela.FieldByName('DESCRICAO').AsString,
                                            Modelo,
                                            Tabela.FieldByName('DATAENTRADA').AsDateTime,
                                            aDataDevolucao,
                                            Tabela.FieldByName('SERIE').AsString,
                                            Tabela.FieldByName('CATEGORIA').AsString));

        Result := ExecutarPut(ANomeMetodo, TJson.ObjectToJsonObject(Container).ToJSON);
      end;
    except
      on E:Exception do
      begin
        if Assigned(Modelo) then
        begin
          FreeAndnil(Modelo);
        end;

        if Result=nil then
        begin
          Result := TRetornoJSON.Create;
          Result.STATUS := -1;
          Result.MENSAGEM := E.Message;
        end;
      end;
    end;
  finally
    FreeAndNil(Container);
  end;
end;

end.
