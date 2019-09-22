unit MFC.DM.Analise;

interface

uses
  Forms,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  MFC.Classes.Amostragem,
  IdHashMessageDigest, idHash, System.Hash,
  System.Generics.Collections, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove.Text;

type
  TLinha = record
    Regiao, Estado, Cidade, Produto: String;
    Ano, Mes: Integer;
    PrecoMedioRevenda: Double;
  end;

  TDMAnalise = class(TDataModule)
    FDMediaPorCidade: TFDMemTable;
    FDMediaPorCidadeESTADO: TStringField;
    FDMediaPorCidadeCIDADE: TStringField;
    FDMediaPorCidadePRODUTO: TStringField;
    FDMediaPorCidadePRECOMEDIOREVENDA: TFloatField;
    FDMediaPorCidadeANO: TIntegerField;
    FDMediaPorCidadeMES: TIntegerField;
    FDMediaPorCidadeCHAVE: TStringField;
    FDMediaPorRegiao: TFDMemTable;
    FDMediaPorRegiaoCHAVE: TStringField;
    FDMediaPorRegiaoREGIAO: TStringField;
    FDMediaPorRegiaoPRECOMEDIOREVENDA: TFloatField;
    FDMediaPorRegiaoPRODUTO: TStringField;
    FDMediaPorUF: TFDMemTable;
    FDMediaPorUFCHAVE: TStringField;
    FDMediaPorUFREGIAO: TStringField;
    FDMediaPorUFPRODUTO: TStringField;
    FDMediaPorUFPRECOMEDIOREVENDA: TFloatField;
    FDMediaPorUFUF: TStringField;
    FDMediaPorCidadePRECOREVENDAMIN: TFloatField;
    FDMediaPorCidadePRECOREVENDAMAX: TFloatField;
    FDMediaPorCidadeVARIACAOABSOLUTA: TFloatField;
    FDMediaPorCidadeTOTALPRECOREVENDA: TFloatField;
    FDAmostragem: TFDMemTable;
    FDMediaPorUFTOTALPRECOMEDIO: TFloatField;
    FDMediaPorRegiaoTOTALPRECOMEDIO: TFloatField;
    FDMediaPorRegiaoAMOSTRAS: TIntegerField;
    FDMediaPorCidadeQTDE: TIntegerField;
    FDMediaPorUFQTDE: TIntegerField;
    FDDiferencaPreco: TFDMemTable;
    FDDiferencaPrecoCHAVE: TStringField;
    FDDiferencaPrecoESTADO: TStringField;
    FDDiferencaPrecoCIDADE: TStringField;
    FDDiferencaPrecoPRODUTO: TStringField;
    FDDiferencaPrecoDIFERENCA: TFloatField;
    FDDiferencaPrecoMENORPRECO: TFloatField;
    FDDiferencaPrecoMAIORPRECO: TFloatField;
    FDMediaPorCidadeVARIANCIAPOPULACIONAL: TFloatField;
    FDCidadeProduto: TFDMemTable;
    FDCidadeProdutoCHAVE: TStringField;
    FDCidadeProdutoESTADO: TStringField;
    FDCidadeProdutoCIDADE: TStringField;
    FDCidadeProdutoPRODUTO: TStringField;
    FDCidadeProdutoPRECOREVENDAMIN: TFloatField;
    FDCidadeProdutoPRECOREVENDAMAX: TFloatField;
    FDCidadeProdutoVARIACAOABSOLUTA: TFloatField;
    FDCidadeProdutoQTDE: TIntegerField;
    FDCidadeProdutoVARIANCIAPOPULACIONAL: TFloatField;
    FDCidade: TFDMemTable;
    FDCidadeCHAVE: TStringField;
    FDCidadeANO: TIntegerField;
    FDCidadeMES: TIntegerField;
    FDCidadeESTADO: TStringField;
    FDCidadeCIDADE: TStringField;
    FDCidadePRECOREVENDAMIN: TFloatField;
    FDCidadePRECOREVENDAMAX: TFloatField;
    FDCidadeVARIACAOABSOLUTA: TFloatField;
    FDCidadeQTDE: TIntegerField;
    FDCidadeVARIANCIAPOPULACIONAL: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FMD5: THashMD5;

    FPrecisao: byte;
    FProdutos: TStringList;

    FDicionarioMesCidade: TDictionary<String, TItem>;
    FDicionarioCidadeProduto: TDictionary<String, TItem>;
    FDicionarioCidade: TDictionary<String, TItem>;

    procedure VarianciaPopulacionalMeses;
    procedure VarianciaPopulacionalCidade;
    procedure VarianciaPopulacionalCidadeProduto;

    procedure SelecionarMaioresDiferencas(aQtde: Integer);

    procedure AddProdutoLista(const aProduto: String);

    function AddMediaPorCidade(Linha: TLinha):String;
    function AddCidade(Linha: TLinha):String;
    function AddCidadeProduto(Linha: TLinha):String;

    procedure AddMediaPorRegiao(Linha: TLinha);
    procedure AddMediaPorUF(Linha: TLinha);
    procedure AddMaiorDiferenca(Linha: TLinha);
  public
    procedure Analisar(AOrigem: TFDMemTable);
    procedure Reset;
  end;

implementation

uses
  Dialogs, Math, DateUtils;

{$R *.dfm}

{ TDMAnalise }

procedure TDMAnalise.AddMediaPorRegiao(Linha: TLinha);
var
  Hash: String;
begin
  Hash := FMD5.GetHashString(Format('%-30.30s', [Linha.Regiao])+
                             Format('%-100.100s', [Linha.Produto]));

  if FDMediaPorRegiao.FindKey([Hash]) then
  begin
    Assert(FDMediaPorRegiaoREGIAO.AsString=Linha.Regiao, 'Regiao invalido');
    Assert(FDMediaPorRegiaoPRODUTO.AsString=Linha.Produto, 'Produto invalido');

    FDMediaPorRegiao.Edit;
    FDMediaPorRegiaoAMOSTRAS.AsInteger := FDMediaPorRegiaoAMOSTRAS.AsInteger+1;
    FDMediaPorRegiaoTOTALPRECOMEDIO.AsFloat := FDMediaPorRegiaoTOTALPRECOMEDIO.AsFloat+Linha.PrecoMedioRevenda;
  end
  else
  begin
    FDMediaPorRegiao.Append;
    FDMediaPorRegiaoCHAVE.AsString := Hash;
    FDMediaPorRegiaoREGIAO.AsString := Linha.Regiao;
    FDMediaPorRegiaoPRODUTO.AsString := Linha.Produto;
    FDMediaPorRegiaoAMOSTRAS.AsInteger := 1;
    FDMediaPorRegiaoTOTALPRECOMEDIO.AsFloat := Linha.PrecoMedioRevenda;
  end;

  FDMediaPorRegiaoPRECOMEDIOREVENDA.AsFloat := SimpleRoundTo(FDMediaPorRegiaoTOTALPRECOMEDIO.AsFloat/FDMediaPorRegiaoAMOSTRAS.AsInteger,-1*FPrecisao);
  FDMediaPorRegiao.Post;
end;

procedure TDMAnalise.AddMediaPorUF(Linha: TLinha);
var
  Hash: String;
begin
  Hash := FMD5.GetHashString(Format('%-30.30s', [Linha.Regiao])+
                             Format('%-30.30s', [Linha.Estado])+
                             Format('%-100.100s', [Linha.Produto]));

  if FDMediaPorUF.FindKey([Hash]) then
  begin
    Assert(FDMediaPorUFREGIAO.AsString=Linha.Regiao, 'Regiao invalido');
    Assert(FDMediaPorUFUF.AsString=Linha.Estado, 'UF invalido');
    Assert(FDMediaPorUFPRODUTO.AsString=Linha.Produto, 'Produto invalido');

    FDMediaPorUF.Edit;
    FDMediaPorUFQTDE.AsInteger := FDMediaPorUFQTDE.AsInteger+1;
    FDMediaPorUFTOTALPRECOMEDIO.AsFloat := FDMediaPorUFTOTALPRECOMEDIO.AsFloat+Linha.PrecoMedioRevenda;
  end
  else
  begin
    FDMediaPorUF.Append;
    FDMediaPorUFCHAVE.AsString := Hash;
    FDMediaPorUFREGIAO.AsString := Linha.Regiao;
    FDMediaPorUFUF.AsString := Linha.Estado;
    FDMediaPorUFPRODUTO.AsString := Linha.Produto;
    FDMediaPorUFQTDE.AsInteger := 1;
    FDMediaPorUFTOTALPRECOMEDIO.AsFloat := Linha.PrecoMedioRevenda;
  end;

  FDMediaPorUFPRECOMEDIOREVENDA.AsFloat := SimpleRoundTo(FDMediaPorUFTOTALPRECOMEDIO.AsFloat/FDMediaPorUFQTDE.AsInteger, -1*FPrecisao);

  FDMediaPorUF.Post;
end;

procedure TDMAnalise.AddProdutoLista(const aProduto: String);
begin
  if FProdutos.IndexOf(aProduto)=-1 then
  begin
    FProdutos.Add(aProduto);
  end;
end;

procedure TDMAnalise.AddMaiorDiferenca(Linha: TLinha);
var
  Hash: String;
begin
  Hash := FMD5.GetHashString(Format('%-25.25s', [Linha.Estado])+
                             Format('%-50.50s', [Linha.Cidade])+
                             Format('%-100.100s', [Linha.Produto]));

  if FDDiferencaPreco.FindKey([Hash]) then
  begin
    Assert(FDDiferencaPrecoESTADO.AsString=Linha.Estado, 'UF invalido');
    Assert(FDDiferencaPrecoCIDADE.AsString=Linha.Cidade, 'Cidade invalido');
    Assert(FDDiferencaPrecoPRODUTO.AsString=Linha.Produto, 'Produto invalido');

    FDDiferencaPreco.Edit;

    if Linha.PrecoMedioRevenda<FDDiferencaPrecoMENORPRECO.AsFloat then
    begin
      FDDiferencaPrecoMENORPRECO.AsFloat := Linha.PrecoMedioRevenda;
    end;

    if Linha.PrecoMedioRevenda>FDDiferencaPrecoMAIORPRECO.AsFloat then
    begin
      FDDiferencaPrecoMAIORPRECO.AsFloat := Linha.PrecoMedioRevenda;
    end;
  end
  else
  begin
    FDDiferencaPreco.Append;
    FDDiferencaPrecoCHAVE.AsString := Hash;
    FDDiferencaPrecoCIDADE.AsString := Linha.Cidade;
    FDDiferencaPrecoESTADO.AsString := Linha.Estado;
    FDDiferencaPrecoPRODUTO.AsString := Linha.Produto;
    FDDiferencaPrecoMENORPRECO.AsFloat := Linha.PrecoMedioRevenda;
    FDDiferencaPrecoMAIORPRECO.AsFloat := Linha.PrecoMedioRevenda;
  end;

  FDDiferencaPrecoDIFERENCA.AsFloat := SimpleRoundTo(FDDiferencaPrecoMAIORPRECO.AsFloat-FDDiferencaPrecoMENORPRECO.AsFloat, -1*FPrecisao);
  FDDiferencaPreco.Post;
end;

function TDMAnalise.AddCidade(Linha: TLinha): String;
begin
  Result := FMD5.GetHashString(Format('%4.4d', [Linha.Ano])+
                             Format('%2.2d', [Linha.Mes])+
                             Format('%-25.25s', [Linha.Estado])+
                             Format('%-50.50s', [Linha.Cidade]));

  if not FDicionarioCidade.ContainsKey(Result) then
  begin
    FDicionarioCidade.AddOrSetValue(Result, TItem.Create);
  end;

  FDicionarioCidade.Items[Result].AddValor(Linha.PrecoMedioRevenda);

  if FDCidade.FindKey([Result]) then
  begin
    Assert(FDMediaPorCidadeANO.AsInteger=Linha.Ano, 'Ano invalido');
    Assert(FDMediaPorCidadeMES.AsInteger=Linha.Mes, 'Mes invalido');
    Assert(FDMediaPorCidadeESTADO.AsString=Linha.Estado, 'Estado invalido');
    Assert(FDMediaPorCidadeCIDADE.AsString=Linha.Cidade, 'Cidade invalido');
    Assert(FDMediaPorCidadePRODUTO.AsString=Linha.Produto, 'Produto invalido');

    FDCidade.Edit;

    FDCidadeQTDE.AsInteger := FDMediaPorCidadeQTDE.AsInteger+1;

    if Linha.PrecoMedioRevenda<FDCidadePRECOREVENDAMIN.AsFloat then
    begin
      FDCidadePRECOREVENDAMIN.AsFloat := Linha.PrecoMedioRevenda;
    end;

    if Linha.PrecoMedioRevenda>FDCidadePRECOREVENDAMAX.AsFloat then
    begin
      FDCidadePRECOREVENDAMAX.AsFloat := Linha.PrecoMedioRevenda;
    end;
  end
  else
  begin
    FDCidade.Append;
    FDCidadeCHAVE.AsString := Result;
    FDCidadeQTDE.AsInteger := 1;
    FDCidadeANO.AsInteger := Linha.Ano;
    FDCidadeMES.AsInteger := Linha.Mes;
    FDCidadeESTADO.AsString := Linha.Estado;
    FDCidadeCIDADE.AsString := Linha.Cidade;
    FDCidadePRECOREVENDAMIN.AsFloat := Linha.PrecoMedioRevenda;
    FDCidadePRECOREVENDAMAX.AsFloat := Linha.PrecoMedioRevenda;
  end;

  FDCidadeVARIACAOABSOLUTA.AsFloat := SimpleRoundTo(FDCidadePRECOREVENDAMAX.AsFloat-FDCidadePRECOREVENDAMIN.AsFloat,-1*FPrecisao);
  FDCidade.Post;
end;

function TDMAnalise.AddCidadeProduto(Linha: TLinha):String;
begin
  Result := FMD5.GetHashString(Format('%-25.25s', [Linha.Estado])+
                             Format('%-50.50s', [Linha.Cidade])+
                             Format('%-100.100s', [Linha.Produto]));

  if not FDicionarioCidadeProduto.ContainsKey(Result) then
  begin
    FDicionarioCidadeProduto.AddOrSetValue(Result, TItem.Create);
  end;

  FDicionarioCidadeProduto.Items[Result].AddValor(Linha.PrecoMedioRevenda);

  if FDCidadeProduto.FindKey([Result]) then
  begin
    Assert(FDCidadeProdutoESTADO.AsString=Linha.Estado, 'Estado invalido');
    Assert(FDCidadeProdutoCIDADE.AsString=Linha.Cidade, 'Cidade invalido');
    Assert(FDCidadeProdutoPRODUTO.AsString=Linha.Produto, 'Produto invalido');

    FDCidadeProduto.Edit;

    FDCidadeProdutoQTDE.AsInteger := FDMediaPorCidadeQTDE.AsInteger+1;

    if Linha.PrecoMedioRevenda<FDCidadeProdutoPRECOREVENDAMIN.AsFloat then
    begin
      FDCidadeProdutoPRECOREVENDAMIN.AsFloat := Linha.PrecoMedioRevenda;
    end;

    if Linha.PrecoMedioRevenda>FDCidadeProdutoPRECOREVENDAMAX.AsFloat then
    begin
      FDCidadeProdutoPRECOREVENDAMAX.AsFloat := Linha.PrecoMedioRevenda;
    end;
  end
  else
  begin
    FDCidadeProduto.Append;
    FDCidadeProdutoCHAVE.AsString := Result;
    FDCidadeProdutoQTDE.AsInteger := 1;
    FDCidadeProdutoESTADO.AsString := Linha.Estado;
    FDCidadeProdutoCIDADE.AsString := Linha.Cidade;
    FDCidadeProdutoPRODUTO.AsString := Linha.Produto;
    FDCidadeProdutoPRECOREVENDAMIN.AsFloat := Linha.PrecoMedioRevenda;
    FDCidadeProdutoPRECOREVENDAMAX.AsFloat := Linha.PrecoMedioRevenda;
  end;

  FDCidadeProdutoVARIACAOABSOLUTA.AsFloat := SimpleRoundTo(FDCidadeProdutoPRECOREVENDAMAX.AsFloat-FDCidadeProdutoPRECOREVENDAMIN.AsFloat,-1*FPrecisao);
  FDCidadeProduto.Post;
end;

function TDMAnalise.AddMediaPorCidade(Linha: TLinha):String;
begin
  Result := FMD5.GetHashString(Format('%4.4d', [Linha.Ano])+
                             Format('%2.2d', [Linha.Mes])+
                             Format('%-25.25s', [Linha.Estado])+
                             Format('%-50.50s', [Linha.Cidade])+
                             Format('%-100.100s', [Linha.Produto]));

  if not FDicionarioMesCidade.ContainsKey(Result) then
  begin
    FDicionarioMesCidade.AddOrSetValue(Result, TItem.Create);
  end;

  FDicionarioMesCidade.Items[Result].AddValor(Linha.PrecoMedioRevenda);

  if FDMediaPorCidade.FindKey([Result]) then
  begin
    Assert(FDMediaPorCidadeANO.AsInteger=Linha.Ano, 'Ano invalido');
    Assert(FDMediaPorCidadeMES.AsInteger=Linha.Mes, 'Mes invalido');
    Assert(FDMediaPorCidadeESTADO.AsString=Linha.Estado, 'Estado invalido');
    Assert(FDMediaPorCidadeCIDADE.AsString=Linha.Cidade, 'Cidade invalido');
    Assert(FDMediaPorCidadePRODUTO.AsString=Linha.Produto, 'Produto invalido');

    FDMediaPorCidade.Edit;

    FDMediaPorCidadeQTDE.AsInteger := FDMediaPorCidadeQTDE.AsInteger+1;
    FDMediaPorCidadeTOTALPRECOREVENDA.AsFloat := FDMediaPorCidadeTOTALPRECOREVENDA.AsFloat+Linha.PrecoMedioRevenda;

    if Linha.PrecoMedioRevenda<FDMediaPorCidadePRECOREVENDAMIN.AsFloat then
    begin
      FDMediaPorCidadePRECOREVENDAMIN.AsFloat := Linha.PrecoMedioRevenda;
    end;

    if Linha.PrecoMedioRevenda>FDMediaPorCidadePRECOREVENDAMAX.AsFloat then
    begin
      FDMediaPorCidadePRECOREVENDAMAX.AsFloat := Linha.PrecoMedioRevenda;
    end;
  end
  else
  begin
    FDMediaPorCidade.Append;
    FDMediaPorCidadeCHAVE.AsString := Result;
    FDMediaPorCidadeQTDE.AsInteger := 1;
    FDMediaPorCidadeANO.AsInteger := Linha.Ano;
    FDMediaPorCidadeMES.AsInteger := Linha.Mes;
    FDMediaPorCidadeESTADO.AsString := Linha.Estado;
    FDMediaPorCidadeCIDADE.AsString := Linha.Cidade;
    FDMediaPorCidadePRODUTO.AsString := Linha.Produto;
    FDMediaPorCidadePRECOREVENDAMIN.AsFloat := Linha.PrecoMedioRevenda;
    FDMediaPorCidadePRECOREVENDAMAX.AsFloat := Linha.PrecoMedioRevenda;
    FDMediaPorCidadeTOTALPRECOREVENDA.AsFloat := Linha.PrecoMedioRevenda;
  end;

  FDMediaPorCidadeVARIACAOABSOLUTA.AsFloat := SimpleRoundTo(FDMediaPorCidadePRECOREVENDAMAX.AsFloat-FDMediaPorCidadePRECOREVENDAMIN.AsFloat,-1*FPrecisao);
  FDMediaPorCidade.Post;
end;

procedure TDMAnalise.Analisar(AOrigem: TFDMemTable);
var
  Linha: TLinha;
begin
  try
    Reset;

    AOrigem.DisableControls;

    AOrigem.First;
    while not AOrigem.Eof do
    begin
      FillChar(Linha, SizeOf(Linha), 0);

      Linha.Mes := MonthOf(AOrigem.FieldByName('DATA FINAL').AsDateTime);
      Linha.Ano := YearOf(AOrigem.FieldByName('DATA FINAL').AsDateTime);
      Linha.Regiao := AOrigem.FieldByName('REGIÃO').AsString;
      Linha.Estado := AOrigem.FieldByName('ESTADO').AsString;
      Linha.Cidade := AOrigem.FieldByName('MUNICÍPIO').AsString;
      Linha.Produto := AOrigem.FieldByName('PRODUTO').AsString;
      Linha.PrecoMedioRevenda := AOrigem.FieldByName('PREÇO MÉDIO REVENDA').AsFloat;

      AddProdutoLista(Linha.Produto);

      AddMediaPorCidade(Linha);
      AddCidade(Linha);
      AddCidadeProduto(Linha);
      AddMediaPorRegiao(Linha);
      AddMediaPorUF(Linha);
      AddMaiorDiferenca(Linha);

      AOrigem.Next;
    end;

    VarianciaPopulacionalMeses;
    VarianciaPopulacionalCidadeProduto;
    VarianciaPopulacionalCidade;
    SelecionarMaioresDiferencas(5);
  finally
    AOrigem.First;
    AOrigem.EnableControls;

    FDDiferencaPreco.IndexFieldNames := 'PRODUTO;DIFERENCA';
    FDDiferencaPreco.First;

    FDMediaPorCidade.IndexFieldNames := 'ANO;MES;ESTADO;CIDADE;PRODUTO';
    FDMediaPorCidade.First;

    FDMediaPorRegiao.IndexFieldNames := 'REGIAO;PRODUTO';
    FDMediaPorRegiao.First;

    FDMediaPorUF.IndexFieldNames := 'REGIAO;UF;PRODUTO';
    FDMediaPorUF.First;

    FDCidadeProduto.IndexFieldNames := 'ESTADO;CIDADE;PRODUTO';
    FDCidadeProduto.First;

    FDCidade.IndexFieldNames := 'ESTADO;CIDADE';
    FDCidade.First;
  end;
end;

procedure TDMAnalise.DataModuleCreate(Sender: TObject);
begin
  FMD5 := THashMD5.Create;

  FDicionarioMesCidade := TDictionary<String,TItem>.Create;
  FDicionarioCidadeProduto := TDictionary<String, TItem>.Create;
  FDicionarioCidade := TDictionary<String, TItem>.Create;

  FProdutos := TStringList.Create;

  FPrecisao := 8;
end;

procedure TDMAnalise.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FDicionarioCidade);
  FreeAndNil(FDicionarioCidadeProduto);
  FreeAndNil(FDicionarioMesCidade);
  FreeAndNil(FProdutos);
end;

procedure TDMAnalise.Reset;
var
  Chave: String;
begin
  for Chave in FDicionarioMesCidade.Keys do
  begin
    FDicionarioMesCidade.Items[Chave].Free;
  end;
  FDicionarioMesCidade.Clear;

  for Chave in FDicionarioCidadeProduto.Keys do
  begin
    FDicionarioCidadeProduto.Items[Chave].Free;
  end;
  FDicionarioCidadeProduto.Clear;

  FProdutos.Clear;

  FDCidadeProduto.IndexFieldNames := 'CHAVE';
  FDCidadeProduto.Close;
  FDCidadeProduto.Open;

  FDMediaPorCidade.IndexFieldNames := 'CHAVE';
  FDMediaPorCidade.Close;
  FDMediaPorCidade.Open;

  FDMediaPorRegiao.IndexFieldNames := 'CHAVE';
  FDMediaPorRegiao.Close;
  FDMediaPorRegiao.Open;

  FDMediaPorUF.IndexFieldNames := 'CHAVE';
  FDMediaPorUF.Close;
  FDMediaPorUF.Open;

  FDDiferencaPreco.IndexFieldNames := 'CHAVE';
  FDDiferencaPreco.Close;
  FDDiferencaPreco.Open;

  FDCidade.IndexFieldNames := 'CHAVE';
  FDCidade.Close;
  FDCidade.Open;
end;

procedure TDMAnalise.SelecionarMaioresDiferencas(aQtde: Integer);
var
  cont: Integer;
  Diferenca: Double;
  Selecionados: Integer;
begin
  for cont := 0 to FProdutos.Count-1 do
  begin
    try
      FDDiferencaPreco.IndexFieldNames := 'DIFERENCA';

      FDDiferencaPreco.Filtered := False;
      FDDiferencaPreco.Filter := 'PRODUTO='+QuotedStr(FProdutos[cont]);
      FDDiferencaPreco.Filtered := True;

      FDDiferencaPreco.Last;

      Diferenca := FDDiferencaPrecoDIFERENCA.AsFloat;
      Selecionados := 1;

      while not FDDiferencaPreco.Bof do
      begin
        if FDDiferencaPrecoDIFERENCA.AsFloat<Diferenca then
        begin
          Diferenca := FDDiferencaPrecoDIFERENCA.AsFloat;
          inc(Selecionados);
        end;

        if (Selecionados>=aQtde) then
        begin
          break;
        end;

        FDDiferencaPreco.Prior;
      end;

      FDDiferencaPreco.First;
      while not FDDiferencaPreco.Eof do
      begin
        if FDDiferencaPrecoDIFERENCA.AsFloat>=Diferenca then
        begin
          FDDiferencaPreco.Next;
        end
        else
        begin
          FDDiferencaPreco.Delete;
          FDDiferencaPreco.First;
        end;
      end;
    finally
      FDDiferencaPreco.Filtered := False;
      FDDiferencaPreco.Filter := '';
    end;
  end;
end;

procedure TDMAnalise.VarianciaPopulacionalCidade;
var
  Item: TItem;
begin
  try
    FDCidade.First;

    while not FDCidade.Eof do
    begin
      if FDicionarioCidade.TryGetValue(FDCidadeCHAVE.AsString, Item) then
      begin
        FDCidade.Edit;
        FDCidadeVARIANCIAPOPULACIONAL.AsFloat := SimpleRoundTo(Item.getVarianciaPopulacional,-1*FPrecisao);
        FDCidade.Post;
      end;

      FDCidade.Next;
    end;
  finally
    FDCidade.First;
  end;
end;

procedure TDMAnalise.VarianciaPopulacionalCidadeProduto;
var
  Item: TItem;
begin
  try
    FDCidadeProduto.First;

    while not FDCidadeProduto.Eof do
    begin
      if FDicionarioCidadeProduto.TryGetValue(FDCidadeProdutoCHAVE.AsString, Item) then
      begin
        FDCidadeProduto.Edit;
        FDCidadeProdutoVARIANCIAPOPULACIONAL.AsFloat := SimpleRoundTo(Item.getVarianciaPopulacional,-1*FPrecisao);
        FDCidadeProduto.Post;
      end;

      FDCidadeProduto.Next;
    end;
  finally
    FDCidadeProduto.First;
  end;
end;

procedure TDMAnalise.VarianciaPopulacionalMeses;
var
  Item: TItem;
begin
  try
     FDMediaPorCidade.First;

    while not FDMediaPorCidade.Eof do
    begin
      if FDicionarioMesCidade.TryGetValue(FDMediaPorCidadeCHAVE.AsString, Item) then
      begin
        FDMediaPorCidade.Edit;
        FDMediaPorCidadePRECOMEDIOREVENDA.AsFloat := SimpleRoundTo(Item.getMedia,-1*FPrecisao);
        FDMediaPorCidadeVARIANCIAPOPULACIONAL.AsFloat := SimpleRoundTo(Item.getVarianciaPopulacional,-1*FPrecisao);
        FDMediaPorCidade.Post;
      end;

      FDMediaPorCidade.Next;
    end;
  finally
    FDMediaPorCidade.First;
  end;
end;

end.
