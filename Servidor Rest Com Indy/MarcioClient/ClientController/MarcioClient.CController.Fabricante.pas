unit MarcioClient.CController.Fabricante;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, MarcioClient.CController.Base,
  Entidade.Base, Entidade.Fabricante, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  REST.Json, System.JSON, Rest.JsonReflect;

type
  TControllerFabricante = class(TControllerBase)
  public
    procedure CarregarLista(const ANomeMetodo: String; Tabela: TFDMemTable); override;
    function EnviarLista(const ANomeMetodo: String; Tabela: TFDMemTable):TRetornoJSON; override;
  end;

implementation

procedure TControllerFabricante.CarregarLista(const ANomeMetodo: String;
  Tabela: TFDMemTable);
var
  Retorno: String;
  Container: TContainerFabricante;
  Cont: Integer;
  BookMark: TBookmark;
begin
  BookMark := nil;

  Retorno := ExecutarGET(ANomeMetodo);
  Container := TJson.JsonToObject<TContainerFabricante>(Retorno);

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

function TControllerFabricante.EnviarLista(const ANomeMetodo: String;
  Tabela: TFDMemTable):TRetornoJSON;
var
  Container: TContainerBase<TFabricante>;
  Cont: Integer;
  BookMark: TBookMark;
begin
  inherited;

  Result := nil;

  Container := TContainerBase<TFabricante>.Create;
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
          Container.AddLinha(TFabricante.Create(Tabela.FieldByName('CHAVEINTERNA').AsInteger,
                                                Tabela.FieldByName('REVISAO').AsInteger,
                                                Tabela.FieldByName('EXCLUIDO').AsInteger,
                                                Tabela.FieldByName('ALTERADO').AsInteger,
                                                Tabela.FieldByName('DESCRICAO').AsString));

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

end.
