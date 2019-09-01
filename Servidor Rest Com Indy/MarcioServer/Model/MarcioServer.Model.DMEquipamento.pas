unit MarcioServer.Model.DMEquipamento;

interface

uses
  System.SysUtils, System.Classes, System.TypInfo, Winapi.Windows,
  MarcioServer.Model.DMBase, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Generics.Collections,
  REST.Json, System.Json, REST.JsonReflect,
  Entidade.Base,
  Entidade.Equipamento, Comum.Pesquisa.Equipamento;

type
  TDMEquipamento = class(TDMBase)
    FDListaEquipamento: TFDQuery;
    FDListaEquipamentoEQUIPAMENTO: TIntegerField;
    FDListaEquipamentoDESCRICAO: TStringField;
    FDListaEquipamentoREVISAO: TIntegerField;
    FDListaEquipamentoMODELO: TIntegerField;
    FDListaEquipamentoSERIE: TStringField;
    FDListaEquipamentoCATEGORIA: TStringField;
    FDListaEquipamentoDESCMODELO: TStringField;
    FDListaEquipamentoDESCFABRICANTE: TStringField;
    FDListaEquipamentoFABRICANTE: TIntegerField;
    FDListaEquipamentoDTENTRADA: TSQLTimeStampField;
    FDListaEquipamentoDTSAIDA: TSQLTimeStampField;
    FDEdicao: TFDQuery;
    FDEdicaoEQUIPAMENTO: TIntegerField;
    FDEdicaoDESCRICAO: TStringField;
    FDEdicaoREVISAO: TIntegerField;
    FDEdicaoMODELO: TIntegerField;
    FDEdicaoSERIE: TStringField;
    FDEdicaoCATEGORIA: TStringField;
    FDEdicaoDTENTRADA: TSQLTimeStampField;
    FDEdicaoDTSAIDA: TSQLTimeStampField;
  private
    procedure AbrirPesquisa(APesquisaEquipamento: TPesquisaEquipamento);

    function Excluir(const aEquipamento: TEquipamento): String;
    function Incluir(const aEquipamento: TEquipamento): String;
    function Alterar(const aEquipamento: TEquipamento): String; overload;
  public
    function getLista(APesquisaEquipamento: TPesquisaEquipamento): TJSONObject;
    function AtualizarLista(AContainer: TContainerBase<TEquipamento>): TJSONObject;
    function Alterar(AContainer: TContainerBase<TEquipamento>): TJsonObject; overload;
  end;

implementation

uses
  Toviasur.Comuns,
  Entidade.Modelo, Entidade.Fabricante;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMEquipamento.AbrirPesquisa(APesquisaEquipamento: TPesquisaEquipamento);
var
  lstComando: TStrings;

  procedure AjustarParametroData(APrefixo, ANomeCampo: String; APesquisaData: TPesquisaData);
  begin
    if APesquisaData.Ativo then
    begin
      if APesquisaData.TipoPesquisa='IGUAL' then
      begin
        lstComando.Add('AND '+ANomeCampo+'=:'+APrefixo+'INICIAL');
      end
      else if APesquisaData.TipoPesquisa='MAIOR OU IGUAL' then
      begin
        lstComando.Add('AND '+ANomeCampo+'>=:'+APrefixo+'INICIAL');
      end
      else if APesquisaData.TipoPesquisa='MENOR OU IGUAL' then
      begin
        lstComando.Add('AND '+ANomeCampo+'<=:'+APrefixo+'INICIAL');
      end
      else if APesquisaData.TipoPesquisa='ENTRE' then
      begin
        lstComando.Add('AND '+ANomeCampo+' BETWEEN :'+APrefixo+'INICIAL AND :'+APrefixo+'FINAL');
      end;
    end;
  end;

begin
  lstComando := TStringList.Create;
  try
    FDListaEquipamento.Close;
    FDListaEquipamento.SQL.Clear;

    lstComando.Add(
      'SELECT'#13+
      'EQUIPAMENTO.EQUIPAMENTO,'#13+
      'EQUIPAMENTO.DESCRICAO,'#13+
      'EQUIPAMENTO.REVISAO,'#13+
      'EQUIPAMENTO.MODELO,'#13+
      'EQUIPAMENTO.SERIE,'#13+
      'EQUIPAMENTO.CATEGORIA,'#13+
      'MODELO.DESCRICAO DESCMODELO,'#13+
      'FABRICANTE.DESCRICAO DESCFABRICANTE ,'#13+
      'MODELO.FABRICANTE,'#13+
      'EQUIPAMENTO.DTENTRADA,'#13+
      'EQUIPAMENTO.DTSAIDA'#13+
      'FROM'#13+
      'EQUIPAMENTO'#13+
      'inner join MODELO on (MODELO.MODELO=EQUIPAMENTO.MODELO)'#13+
      'inner join FABRICANTE on (FABRICANTE.FABRICANTE=MODELO.FABRICANTE)'#13+
      'WHERE EQUIPAMENTO.EQUIPAMENTO>=-1000');

    if APesquisaEquipamento.Localizacao='NA EMPRESA' then
    begin
      lstComando.Add('AND EQUIPAMENTO.DTSAIDA IS NULL');
    end
    else if APesquisaEquipamento.Localizacao='DEVOLVIDOS' then
    begin
      lstComando.Add('AND EQUIPAMENTO.DTSAIDA IS NOT NULL');
    end;

    if APesquisaEquipamento.PesquisaDescricao.Ativo and
       (Trim(APesquisaEquipamento.PesquisaDescricao.Descricao)<>'') then
    begin
      lstComando.Add('AND EQUIPAMENTO.DESCRICAO LIKE :DESCRICAO');
    end;

    AjustarParametroData('ENT', 'EQUIPAMENTO.DTENTRADA', APesquisaEquipamento.DataEntrada);
    AjustarParametroData('SAI', 'EQUIPAMENTO.DTSAIDA', APesquisaEquipamento.DataSaida);

    FDListaEquipamento.SQL.AddStrings(lstComando);

    if pos(':DESCRICAO', FDListaEquipamento.SQL.GetText)>0 then
    begin
      FDListaEquipamento.ParamByName('DESCRICAO').AsString :=
        '%'+APesquisaEquipamento.PesquisaDescricao.Descricao+'%';
    end;

    if pos(':ENTINICIAL',  FDListaEquipamento.SQL.GetText)>0 then
    begin
      FDListaEquipamento.ParamByName('ENTINICIAL').AsDateTime := APesquisaEquipamento.DataEntrada.DTInicial;
    end;
    if pos(':ENTFINAL',  FDListaEquipamento.SQL.GetText)>0 then
    begin
      FDListaEquipamento.ParamByName('ENTFINAL').AsDateTime := APesquisaEquipamento.DataEntrada.DTFinal;
    end;

    if pos(':SAIINICIAL',  FDListaEquipamento.SQL.GetText)>0 then
    begin
      FDListaEquipamento.ParamByName('SAIINICIAL').AsDateTime := APesquisaEquipamento.DataSaida.DTInicial;
    end;
    if pos(':SAIFINAL',  FDListaEquipamento.SQL.GetText)>0 then
    begin
      FDListaEquipamento.ParamByName('SAIFINAL').AsDateTime := APesquisaEquipamento.DataSaida.DTFinal;
    end;

    FDListaEquipamento.Open;
  finally
    FreeAndNil(lstComando);
  end;
end;

function TDMEquipamento.Alterar(const aEquipamento: TEquipamento): String;
begin
 try
    FDEdicao.Close;
    FDEdicao.Params.ParamByName('EQUIPAMENTO').AsInteger := aEquipamento.PK;
    FDEdicao.Open;

    if FDEdicaoREVISAO.AsInteger <> aEquipamento.Revisao then
    begin
      raise Exception.Create('Registro alterado por outro usuário!');
    end;

    FDEdicao.Edit;
    FDEdicaoREVISAO.AsInteger := FDEdicaoREVISAO.AsInteger + 1;
    FDEdicaoDESCRICAO.AsString := Trim(aEquipamento.Descricao);
    FDEdicaoMODELO.AsInteger := aEquipamento.Modelo.PK;
    FDEdicaoSERIE.AsString := Trim(aEquipamento.Serie);
    FDEdicaoCATEGORIA.AsString := Trim(aEquipamento.Categoria);
    FDEdicaoDTENTRADA.AsDateTime := aEquipamento.DataEntrada;

    if aEquipamento.DataSaida>0 then
    begin
      FDEdicaoDTSAIDA.AsDateTime := aEquipamento.DataSaida;
    end
    else
    begin
      FDEdicaoDTSAIDA.Clear;
    end;
    FDEdicao.Post;
  except
    on E: Exception do
    begin
      Result := 'Erro alteração ' + aEquipamento.Descricao + ': ' +
        E.Message;
    end;
  end;
end;

function TDMEquipamento.Alterar(
  AContainer: TContainerBase<TEquipamento>): TJsonObject;
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
          Auxiliar := Alterar(AContainer.Linhas[Cont]);

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

function TDMEquipamento.AtualizarLista(
  AContainer: TContainerBase<TEquipamento>): TJSONObject;
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

function TDMEquipamento.Excluir(const aEquipamento: TEquipamento): String;
begin
  try
    FDEdicao.Close;
    FDEdicao.Params.ParamByName('EQUIPAMENTO').AsInteger := aEquipamento.PK;
    FDEdicao.Open;

    if FDEdicaoREVISAO.AsInteger <> aEquipamento.Revisao then
    begin
      raise Exception.Create('Registro alterado por outro usuário!');
    end;

    FDEdicao.Delete;
  except
    on E: Exception do
    begin
      Result := 'Erro exclusão' + aEquipamento.Descricao + ': ' +
        E.Message;
    end;
  end;
end;

function TDMEquipamento.getLista(APesquisaEquipamento: TPesquisaEquipamento): TJSONObject;
begin
  Result := Processar(
    function: TJSONObject
    var
      Container: TContainerBase<TEquipamento>;
      Equipamento: TEquipamento;
      Modelo: TModelo;

    begin
      Container := TContainerBase<TEquipamento>.Create;
      try
        AbrirPesquisa(APesquisaEquipamento);
        FDListaEquipamento.First;
        while not FDListaEquipamento.Eof do
        begin
          Modelo := TModelo.Create( FDListaEquipamentoMODELO.AsInteger, 0, 0, 0, FDListaEquipamentoDESCMODELO.AsString,
                                    TFabricante.Create(FDListaEquipamentoFABRICANTE.AsInteger, 0, 0, 0,FDListaEquipamentoDESCFABRICANTE.AsString));

          Equipamento := TEquipamento.Create( FDListaEquipamentoEQUIPAMENTO.AsInteger,
                                              FDListaEquipamentoREVISAO.AsInteger,
                                              0,
                                              0,
                                              FDListaEquipamentoDESCRICAO.AsString,
                                              Modelo,
                                              FDListaEquipamentoDTENTRADA.AsDateTime,
                                              FDListaEquipamentoDTSAIDA.AsDateTime,
                                              FDListaEquipamentoSERIE.AsString,
                                              FDListaEquipamentoCATEGORIA.AsString);


          Container.AddLinha(Equipamento);

          FDListaEquipamento.Next;
        end;
      finally
        Result := TJson.ObjectToJsonObject(Container);
        FreeAndNil(Container);
      end;
    end);
end;

function TDMEquipamento.Incluir(const aEquipamento: TEquipamento): String;
begin
 try
    FDEdicao.Close;
    FDEdicao.Params.ParamByName('EQUIPAMENTO').AsInteger := -1;
    FDEdicao.Open;

    FDEdicao.Append;
    FDEdicaoREVISAO.AsInteger := 1;
    FDEdicaoDESCRICAO.AsString := Trim(aEquipamento.Descricao);
    FDEdicaoMODELO.AsInteger := aEquipamento.Modelo.PK;
    FDEdicaoSERIE.AsString := Trim(aEquipamento.Serie);
    FDEdicaoCATEGORIA.AsString := Trim(aEquipamento.Categoria);
    FDEdicaoDTENTRADA.AsDateTime := aEquipamento.DataEntrada;

    if aEquipamento.DataSaida>0 then
    begin
      FDEdicaoDTSAIDA.AsDateTime := aEquipamento.DataSaida;
    end
    else
    begin
      FDEdicaoDTSAIDA.Clear;
    end;
    FDEdicao.Post;
  except
    on E: Exception do
    begin
      Result := 'Erro inclusão ' + aEquipamento.Descricao + ': ' +
        E.Message;
    end;
  end;

end;

end.
