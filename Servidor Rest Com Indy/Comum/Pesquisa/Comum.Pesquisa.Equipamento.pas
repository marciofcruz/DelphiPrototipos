unit Comum.Pesquisa.Equipamento;

interface

uses
  System.SysUtils, System.Classes;

type
  TPesquisaDescricao = class(TObject)
  private
    FAtivo: Boolean;
    FDescricao: String;
  public
    property Ativo: Boolean read FAtivo write FAtivo;
    property Descricao: String read FDescricao write FDescricao;
  end;

  TPesquisaData = class(TObject)
  private
    FAtivo: Boolean;
    FDTFinal: TDateTime;
    FDTInicial: TDateTime;
    FTipoPesquisa: String;
  public
    property Ativo: Boolean read FAtivo write FAtivo;
    property TipoPesquisa: String read FTipoPesquisa write FTipoPesquisa;
    property DTInicial: TDateTime read FDTInicial write FDTInicial;
    property DTFinal: TDateTime read FDTFinal write FDTFinal;
  end;

  TPesquisaEquipamento = class(TObject)
  private
    FDataEntrada: TPesquisaData;
    FDataSaida: TPesquisaData;
    FLocalizacao: String;
    FPesquisaDescricao: TPesquisaDescricao;

  public
    constructor Create;
    destructor Destroy; override;

    property DataEntrada: TPesquisaData read FDataEntrada write FDataEntrada;
    property DataSaida: TPesquisaData read FDataSaida write FDataSaida;
    property PesquisaDescricao: TPesquisaDescricao read FPesquisaDescricao write FPesquisaDescricao;
    property Localizacao: String read FLocalizacao write FLocalizacao;
  end;


implementation

{ TPesquisaEquipamento }

constructor TPesquisaEquipamento.Create;
begin
  FDataEntrada := TPesquisaData.Create;
  FDataSaida := TPesquisaData.Create;
  FPesquisaDescricao := TPesquisaDescricao.Create;
end;

destructor TPesquisaEquipamento.Destroy;
begin
  FreeAndNil(FPesquisaDescricao);
  FreeAndNil(FDataEntrada);
  FreeAndNil(FDataSaida);

  inherited;
end;

end.
