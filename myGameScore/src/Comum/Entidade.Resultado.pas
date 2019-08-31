unit Entidade.Resultado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Entidade.Base;

type
  TResultadoJogo = class(TEntidadeBase)
  private
    FDataPrimeiroJogo: TDateTime;
    FJogosDisputados: SmallInt;
    FDataUltimoJogo: TDateTime;
    FMediaPontosPorJogo: double;
    FMaiorPontuacaoJogo: Byte;
    FQtdeRecordes: Integer;
    FTotalPontos: SmallInt;
  public
    constructor Create;

    function ToString: string; override;

    property DataPrimeiroJogo: TDateTime read FDataPrimeiroJogo write FDataPrimeiroJogo;
    property DataUltimoJogo: TDateTime read FDataUltimoJogo write FDataUltimoJogo;
    property JogosDisputados: SmallInt read FJogosDisputados write FJogosDisputados;
    property TotalPontos: SmallInt read FTotalPontos write FTotalPontos;
    property MediaPontosPorJogo: Double read FMediaPontosPorJogo write FMediaPontosPorJogo;
    property MaiorPontuacaoJogo: Byte read FMaiorPontuacaoJogo write FMaiorPontuacaoJogo;
    property QtdeRecordes: Integer read FQtdeRecordes write FQtdeRecordes;
  end;


implementation

{ TResultadoJogo }

constructor TResultadoJogo.Create;
begin
  FDataPrimeiroJogo := 0;
  FJogosDisputados := 0;
  FDataUltimoJogo := 0;
  FTotalPontos := 0;
  FMediaPontosPorJogo := 0;
  FMaiorPontuacaoJogo := 0;
  FQtdeRecordes := 0;
end;

function TResultadoJogo.ToString: string;
begin
  Result :=
    'Data Primeiro Jogo: ['+DateToStr(DataPrimeiroJogo)+'], '+
    'Data Último Jogo: ['+DateToStr(DataUltimoJogo)+'], '+
    'Jogos Disputados: ['+JogosDisputados.ToString+'], '+
    'Total Pontos: ['+TotalPontos.ToString+'], '+
    'Média Pontos Por Jogo: ['+MediaPontosPorJogo.ToString+'], '+
    'Maior Pontuação em um Jogo: ['+MaiorPontuacaoJogo.ToString+'], '+
    'Quantidade de vezes que bateu o próprio recorde: ['+QtdeRecordes.ToString+']';
end;

end.
