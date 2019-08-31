unit MarcioServer.Model.DMJogo;

interface

uses
  System.SysUtils, System.Classes, System.TypInfo, Winapi.Windows,
  MarcioServer.Model.DMBase, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Generics.Collections, RaptorWS.ServerUtils,
  REST.Json, System.Json, REST.JsonReflect,
  Entidade.Base, Entidade.Jogo, Entidade.Resultado;

type
  TDMJogo = class(TDMBase)
    FDListaJogo: TFDQuery;
    FDEdicao: TFDQuery;
    FDEdicaoDATA: TDateTimeField;
    FDEdicaoPONTOS: TIntegerField;
    FDListaJogoDATA: TDateTimeField;
    FDListaJogoPONTOS: TIntegerField;
  private
  public
    function getResultado: TJSONObject;
    function Incluir(const aJogo: TJogo): TJSONObject;
  end;

implementation

{$R *.dfm}


function TDMJogo.getResultado: TJSONObject;
begin
  Result := Processar(
    function: TJSONObject
    var
      ResultadoJogo: TResultadoJogo;
    begin
      ResultadoJogo := TResultadoJogo.Create;
      try
        FDListaJogo.Open;
        FDListaJogo.First;
        while not FDListaJogo.Eof do
        begin
          if FDListaJogo.Bof then
          begin
            ResultadoJogo.MaiorPontuacaoJogo := FDListaJogoPONTOS.AsInteger;

            ResultadoJogo.DataPrimeiroJogo := FDListaJogoDATA.AsDateTime;
          end
          else
          begin
            if FDListaJogoPONTOS.AsInteger>ResultadoJogo.MaiorPontuacaoJogo then
            begin
              ResultadoJogo.MaiorPontuacaoJogo := FDListaJogoPONTOS.AsInteger;
              ResultadoJogo.QtdeRecordes := ResultadoJogo.QtdeRecordes+1;
            end;
          end;

          ResultadoJogo.JogosDisputados := ResultadoJogo.JogosDisputados+1;
          ResultadoJogo.TotalPontos := ResultadoJogo.TotalPontos+FDListaJogoPONTOS.AsInteger;

          FDListaJogo.Next;
        end;

        if ResultadoJogo.JogosDisputados<>0 then
        begin
          ResultadoJOgo.MediaPontosPorJogo := ResultadoJogo.TotalPontos/ResultadoJogo.JogosDisputados;
        end;

        ResultadoJogo.DataUltimoJogo := FDListaJogoDATA.AsDateTime;
      finally
        Result := TJson.ObjectToJsonObject(ResultadoJogo);
        FreeAndNil(ResultadoJogo);
        FDListaJogo.Close;
      end;
    end);
end;

function TDMJogo.Incluir(const aJogo: TJogo): TJSONObject;
begin
  try
    try
      if aJogo.Data>date then
      begin
        raise Exception.Create('Data do jogo não pode ser maior que a data atual!');
      end;

      FDEdicao.Close;
      FDEdicao.Params.ParamByName('DATA').AsDateTime := aJogo.Data;
      FDEdicao.Open;

      if FDEdicao.RecordCount<>0 then
      begin
        raise Exception.Create('Há um resultado de jogo lançado para o dia '+DateToStr(aJogo.Data));
      end;

      FDEdicao.Append;
      FDEdicaoDATA.AsDateTime := aJogo.Data;
      FDEdicaoPONTOS.AsInteger := aJogo.Ponto;
      FDEdicao.Post;

      Result := TServerUtils.getMensagemJsonObject(200, 'OK');
    except
      on E:Exception do
      begin
        Result := TServerUtils.getMensagemJsonObject(400, E.Message);
      end;
    end;
  finally
    FDEdicao.Close;
  end;
end;

end.
