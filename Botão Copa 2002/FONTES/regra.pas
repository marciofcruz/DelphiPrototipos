unit regra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, qrprntr, QRCtrls;

type
  Tfrmregra = class(TForm)
    QRGeral: TQuickRep;
    QRBand1: TQRBand;
    qmregra: TQRMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QRGeralPreview(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure montarregra;
  end;

var
  frmregra: Tfrmregra;

implementation

uses UnPrev;

{$R *.dfm}

procedure Tfrmregra.montarregra;
begin
  with qmRegra.Lines do
  begin
    clear;
    Add('Regras "Bolão Copa do Mundo 2006"');
    Add('Valor por Aposta - R$ 15,00 (Quinze Reais)');
    Add('Valor do Prêmio - será divulgado após o encerramento das apostas');
    Add('');
    Add('1. As apostas serão encerradas em 07/06/2006 - quarta-feira, data '+
        'limite para realização do pagamento relativo à cota de participação.');
    Add('2. O ganhador será aquele que somar maior número de pontos até o término '+
        'do Campeonato.');
    Add('3. Nas Oitavas, Quartas, Semi e final, os apostadores deverão '+
        'selecionar apenas os nomes das seleções vencedoras e não mais os resultados e placar.');
    Add('4. Em caso de empate na quantidade de pontos entre os participantes, os '+
        'critérios de desempate serão pela ordem:');
    Add('     a) - maior quantidade de acerto do placar da partida;');
    Add('     b) - persistindo o empate no item a, o prêmio será dividido entre os vencedores.');
    Add('');
    Add('5.Pontuação:');
    Add('     Acertando o placar - 5 pontos');
    Add('     Acertando apenas o vencedor ou empate - 3 pontos por seleção;');
    Add('     Classificação para Oitavas de Final - 3 pontos por seleção;');
    Add('     Classificação para Semi Final - 3 pontos por seleção;');
    Add('     Classificação para Quartas - 3 pontos por seleção;');
    Add('     Classificação para Final - 3 pontos por seleção;');
    Add('     Campeão da Copa - 15 pontos.');
    Add('');
    Add('6. A atualização dos resultados será realizada no decorrer do dia, após '+
        'as partidas, exceto nos finais de semana quando então o resultado será '+
        'atualizado na segunda-feira posterior.');
    Add('7. O valor do prêmio será pago ao vencedor ou vencedores ao final da Copa,'+
        'após a grande final, na segunda-feira dia 09/julho/2006.');
  end;
end;


procedure Tfrmregra.FormCreate(Sender: TObject);
begin
  frmpreview := Tfrmpreview.create(Self);
end;

procedure Tfrmregra.FormDestroy(Sender: TObject);
begin
  FreeAndNil(frmPreview);
end;

procedure Tfrmregra.QRGeralPreview(Sender: TObject);
begin
  try
    with frmPreview do
    begin
      Impressao := pTotal;
      Caption := 'Aguarde, gerando relatório ...';
      pQuickReport := QRGeral;
      QRPreview.QRPrinter := TQRPrinter(Sender);
      ShowModal;
    end;
  except
    Close;
  end;

end;

end.
