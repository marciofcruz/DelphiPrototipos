unit MFC.DM.CadastroEntidade;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Data.SqlExpr,
  Datasnap.Provider, Datasnap.DBClient,
  MFC.DM.Conexao;

type
  TDMEntidade = class(TDataModule)
    sqlEntidade: TSQLDataSet;
    dspEntidade: TDataSetProvider;
    cdsEntidade: TClientDataSet;
    sqlProximaChaveEntidade: TSQLDataSet;
    sqlProximaChaveEntidadePROXIMA: TIntegerField;
    sqlImagemEntidade: TSQLDataSet;
    sqlImagemEntidadeIMAGEMENTIDADE: TIntegerField;
    dspImagemEntidade: TDataSetProvider;
    cdsImagemEntidade: TClientDataSet;
    cdsImagemEntidadeIMAGEMENTIDADE: TIntegerField;
    sqlProximaChaveImagemEntidade: TSQLDataSet;
    sqlProximaChaveImagemEntidadePROXIMA: TIntegerField;
    sqlEntidadeENTIDADE: TIntegerField;
    sqlEntidadeNOMECOMPLETO: TStringField;
    sqlEntidadeSITUACAO: TSmallintField;
    sqlEntidadeDTCADASTRO: TSQLTimeStampField;
    sqlEntidadeORIGEM: TStringField;
    cdsEntidadeENTIDADE: TIntegerField;
    cdsEntidadeNOMECOMPLETO: TStringField;
    cdsEntidadeSITUACAO: TSmallintField;
    cdsEntidadeDTCADASTRO: TSQLTimeStampField;
    cdsEntidadeORIGEM: TStringField;
    sqlEntidadeQTDEIMAGENS: TIntegerField;
    cdsEntidadeQTDEIMAGENS: TIntegerField;
    sqlGetNomeImagem: TSQLDataSet;
    sqlGetNomeImagemNOMECOMPLETO: TStringField;
    sqlGetNomeImagemIMAGEMENTIDADE: TIntegerField;
    sqlTodasImagens: TSQLDataSet;
    sqlTodasImagensIMAGEMENTIDADE: TIntegerField;
    sqlTodasImagensENTIDADE: TIntegerField;
    dspTodasImagens: TDataSetProvider;
    cdsTodasImagens: TClientDataSet;
    cdsTodasImagensIMAGEMENTIDADE: TIntegerField;
    cdsTodasImagensENTIDADE: TIntegerField;
    sqlImagemEntidadeENTIDADE: TIntegerField;
    sqlImagemEntidadeSITUACAO: TSmallintField;
    sqlImagemEntidadeDTCADASTRO: TSQLTimeStampField;
    cdsImagemEntidadeENTIDADE: TIntegerField;
    cdsImagemEntidadeSITUACAO: TSmallintField;
    cdsImagemEntidadeDTCADASTRO: TSQLTimeStampField;
    sqlImagemEntidadeFACE: TMemoField;
    cdsImagemEntidadeFACE: TMemoField;
    sqlTodasImagensFACE: TMemoField;
    cdsTodasImagensFACE: TMemoField;
  private
  public
    procedure Configurar(DMConexao: TDMConexao);
    function getChaveEntidade:Integer;
    function getChaveImagemEntidade:Integer;

    function getNomeEntidade(AImagem: Integer):String;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMEntidade }

procedure TDMEntidade.Configurar(DMConexao: TDMConexao);
begin
  sqlEntidade.SQLConnection := DMConexao.Conexao;
end;

function TDMEntidade.getChaveEntidade: Integer;
begin
  try
    sqlProximaChaveEntidade.Close;
    sqlProximaChaveEntidade.Open;
    Result := sqlProximaChaveEntidadePROXIMA.AsInteger;
  finally
    sqlProximaChaveEntidade.Close;
  end;
end;

function TDMEntidade.getChaveImagemEntidade:Integer;
begin
  try
    sqlProximaChaveImagemEntidade.Close;
    sqlProximaChaveImagemEntidade.Open;
    Result := sqlProximaChaveImagemEntidadePROXIMA.AsInteger;
  finally
    sqlProximaChaveImagemEntidade.Close;
  end;
end;
function TDMEntidade.getNomeEntidade(AImagem: Integer): String;
begin
  if (not sqlGetNomeImagem.Active) or
     (sqlGetNomeImagem.Params.ParamByName('IMAGEMENTIDADE').AsInteger<>AImagem) then
  begin
    sqlGetNomeImagem.Close;
    sqlGetNomeImagem.Params.ParamByName('IMAGEMENTIDADE').AsInteger := AImagem;
    sqlGetNomeImagem.Open;
  end;

  Result := sqlGetNomeImagemNOMECOMPLETO.AsString+' - '+IntToStr(AImagem);
end;

end.
