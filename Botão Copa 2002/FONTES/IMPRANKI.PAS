unit impranki;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, qrprntr, DB, DBTables, QRCtrls;

type
  Tfrmranking = class(TForm)
    QRGeral: TQuickRep;
    dtsgeral: TQuery;
    qrdetalhe: TQRBand;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    qrljogosencerrados: TQRLabel;
    QRBand2: TQRBand;
    qrlcaptionposicao: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    qrlposicao: TQRLabel;
    qrltotalpontos: TQRLabel;
    qrlpontosresultado: TQRLabel;
    qrlnome: TQRLabel;
    QRLabel4: TQRLabel;
    qrlpontosplacar: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    qrlpontosclassificacao: TQRLabel;
    procedure QRGeralPreview(Sender: TObject);
    procedure QRGeralBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qrdetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    sposicaoant: string;
    iposicao: integer;
  public
    { Public declarations }
    procedure preparacao;
  end;

var
  frmranking: Tfrmranking;

implementation

uses dtMod, UnPrev;

{$R *.dfm}

procedure Tfrmranking.preparacao;
begin
  with dtsgeral, dtsgeral.sql do
  begin
    databasename := modulo.sdatabase;

    clear;
    Add('SELECT COUNT(*) AAA FROM MATRIZ.DB');
    Add('WHERE ENCERRADO = 1');
    Open;

    qrljogosencerrados.Caption :=
      'Jogos realizados: '+FieldByName('AAA').AsString+'/64';

    if FieldByName('AAA').AsInteger > 0 then
    begin
      clear;
      Add('SELECT');
      Add('NOME,');
      Add('TOTALPONTOS,');
      Add('PONTORESULTADO,');
      Add('PONTOPLACAR,');
      Add('PONTOCLASSIFICACAO');
      Add('FROM');
      Add('PESSOA.DB');
      Add('ORDER BY TOTALPONTOS DESC, PONTORESULTADO DESC');
      Open;
    end
    else
      Close;
  end;
end;

procedure Tfrmranking.QRGeralPreview(Sender: TObject);
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

procedure Tfrmranking.QRGeralBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  sposicaoant := 'AAA/AAA';
  iposicao := 0;
  dtsgeral.first;
end;

procedure Tfrmranking.FormCreate(Sender: TObject);
begin
  frmpreview := Tfrmpreview.create(Self);
end;

procedure Tfrmranking.FormDestroy(Sender: TObject);
begin
  FreeAndNil(frmPreview);
end;

procedure Tfrmranking.qrdetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrltotalpontos.caption := dtsGeral.FieldByName('TOTALPONTOS').AsString;
  qrlpontosresultado.caption := dtsGeral.FieldByName('PONTORESULTADO').AsString;
  qrlnome.caption := dtsGeral.FieldBYName('NOME').AsString;
  qrlpontosplacar.caption := dtsGeral.FieldByName('PONTOPLACAR').AsString;
  qrlpontosclassificacao.caption := dtsGeral.FieldByName('PONTOCLASSIFICACAO').AsString;

  if sposicaoant <>
     Format('%3.3d/%3.3d',[dtsGeral.FieldByName('TOTALPONTOS').AsInteger,
                           dtsGeral.FieldByName('PONTORESULTADO').AsInteger]) then
  begin
    sposicaoant := Format('%3.3d/%3.3d',[dtsGeral.FieldByName('TOTALPONTOS').AsInteger,
                         dtsGeral.FieldByName('PONTORESULTADO').AsInteger]);
    inc(iposicao);
    qrlposicao.caption := IntToStr(iposicao);

    if qrdetalhe.color = $00F0F0F0 then
      qrdetalhe.color :=  clwhite
    else
      qrdetalhe.color := $00F0F0F0;

    qrlposicao.color := qrdetalhe.color;
    qrltotalpontos.color := qrdetalhe.color;
    qrlpontosresultado.color := qrdetalhe.color;
    qrlnome.color := qrdetalhe.color;
    qrlpontosplacar.color := qrdetalhe.color;
    qrlpontosclassificacao.color := qrDetalhe.color;
  end
  else
    qrlposicao.caption := '';

  Application.ProcessMessages;
end;

end.
