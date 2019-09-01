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
    Add('Regras "Bol�o Copa do Mundo 2006"');
    Add('Valor por Aposta - R$ 15,00 (Quinze Reais)');
    Add('Valor do Pr�mio - ser� divulgado ap�s o encerramento das apostas');
    Add('');
    Add('1. As apostas ser�o encerradas em 07/06/2006 - quarta-feira, data '+
        'limite para realiza��o do pagamento relativo � cota de participa��o.');
    Add('2. O ganhador ser� aquele que somar maior n�mero de pontos at� o t�rmino '+
        'do Campeonato.');
    Add('3. Nas Oitavas, Quartas, Semi e final, os apostadores dever�o '+
        'selecionar apenas os nomes das sele��es vencedoras e n�o mais os resultados e placar.');
    Add('4. Em caso de empate na quantidade de pontos entre os participantes, os '+
        'crit�rios de desempate ser�o pela ordem:');
    Add('     a) - maior quantidade de acerto do placar da partida;');
    Add('     b) - persistindo o empate no item a, o pr�mio ser� dividido entre os vencedores.');
    Add('');
    Add('5.Pontua��o:');
    Add('     Acertando o placar - 5 pontos');
    Add('     Acertando apenas o vencedor ou empate - 3 pontos por sele��o;');
    Add('     Classifica��o para Oitavas de Final - 3 pontos por sele��o;');
    Add('     Classifica��o para Semi Final - 3 pontos por sele��o;');
    Add('     Classifica��o para Quartas - 3 pontos por sele��o;');
    Add('     Classifica��o para Final - 3 pontos por sele��o;');
    Add('     Campe�o da Copa - 15 pontos.');
    Add('');
    Add('6. A atualiza��o dos resultados ser� realizada no decorrer do dia, ap�s '+
        'as partidas, exceto nos finais de semana quando ent�o o resultado ser� '+
        'atualizado na segunda-feira posterior.');
    Add('7. O valor do pr�mio ser� pago ao vencedor ou vencedores ao final da Copa,'+
        'ap�s a grande final, na segunda-feira dia 09/julho/2006.');
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
      Caption := 'Aguarde, gerando relat�rio ...';
      pQuickReport := QRGeral;
      QRPreview.QRPrinter := TQRPrinter(Sender);
      ShowModal;
    end;
  except
    Close;
  end;

end;

end.
