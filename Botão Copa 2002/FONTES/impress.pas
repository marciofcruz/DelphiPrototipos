unit impress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, qrprntr, DB, DBTables, QRCtrls;

type
  Tfrmimpressao = class(TForm)
    QRGeral: TQuickRep;
    dtsgeral: TQuery;
    QRGroup1: TQRGroup;
    qrlfase: TQRLabel;
    qrdetalhe: TQRBand;
    qrlselecao1: TQRLabel;
    qrlselecao2: TQRLabel;
    qrlplacar2: TQRLabel;
    qrlplacar1: TQRLabel;
    QRLabel1: TQRLabel;
    qrlgrupo: TQRLabel;
    QRBand1: TQRBand;
    qrlapostador: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    qrlencerrado: TQRLabel;
    qrljogosencerrados: TQRLabel;
    procedure QRGeralPreview(Sender: TObject);
    procedure QRGeralBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ioitavachecada: integer;
  public
    { Public declarations }
    iapostador: integer;
    procedure montasql(snome:string = ' ');
  end;

var
  frmimpressao: Tfrmimpressao;

implementation

uses dtMod, UnPrev;

{$R *.dfm}

procedure Tfrmimpressao.montasql(snome:string = ' ');
begin
  if trim(snome) <> '' then
    qrlapostador.caption := snome;

  with dtsgeral,dtsgeral.sql do
  begin
    databasename := modulo.sdatabase;

    if iapostador = 0 then
    begin
      clear;
      Add('SELECT COUNT(*) AAA FROM MATRIZ.DB');
      Add('WHERE ENCERRADO = 1');
      Open;

      qrljogosencerrados.Caption :=
        'Jogos realizados: '+FieldByName('AAA').AsString+'/64';
    end
    else
      qrljogosencerrados.caption := ' ';

    clear;

    if iapostador = 0 then
    begin
      Add('SELECT');
      Add('FASE,CODIGO,COD_SELECAO1,COD_SELECAO2,PLACAR1,PLACAR2,ENCERRADO');
      Add('FROM');
      Add('MATRIZ.DB');
      Add('ORDER BY FASE,CODIGO');
    end
    else
    begin
      Add('SELECT');
      Add('MATRIZ.FASE,');
      Add('APOSTA.COD_JOGO CODIGO,');
      Add('APOSTA.COD_SELECAO1,');
      Add('APOSTA.COD_SELECAO2,');
      Add('APOSTA.PLACAR1,');
      Add('APOSTA.PLACAR2,');
      Add('APOSTA.ENCERRADO');
      Add('FROM');
      Add('APOSTA.DB APOSTA');
      Add('INNER JOIN MATRIZ.DB MATRIZ');
      Add('ON (APOSTA.COD_JOGO = MATRIZ.CODIGO)');
      Add('WHERE APOSTA.COD_APOSTADOR = :P_APOSTADOR');
      Add('ORDER BY MATRIZ.FASE, APOSTA.COD_JOGO');

      Parambyname('P_APOSTADOR').AsInteger := iapostador;
    end;

    Open;
  end;
end;

procedure Tfrmimpressao.QRGeralPreview(Sender: TObject);
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

procedure Tfrmimpressao.QRGeralBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  dtsgeral.first;
  ioitavachecada := 1;
end;

procedure Tfrmimpressao.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  case dtsgeral.FieldByName('FASE').AsInteger of
    1: qrlfase.Caption := 'Primeira fase';
    2: qrlfase.caption := 'Oitavas-de-final';
    3: qrlfase.caption := 'Quartas-de-final';
    4: qrlfase.caption := 'Semi-final';
    5: qrlfase.caption := 'Terceiro lugar';
    6: qrlfase.caption := 'FINAL';
  end;

  PrintBand := dtsgeral.FieldByName('FASE').AsInteger <> 5;
end;

procedure Tfrmimpressao.qrdetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := dtsgeral.FieldByName('FASE').AsInteger <> 5;

  qrlgrupo.caption := '';

  if dtsGeral.FieldByName('CODIGO').AsInteger <= 48 then
  begin
    if ioitavachecada <> 1000 then
    begin
      if dtsGeral.FieldByName('ENCERRADO').AsInteger = 1 then
        inc(ioitavachecada)
      else
        ioitavachecada := 1000;
    end;

    case dtsGeral.FieldByName('CODIGO').AsInteger of
      1:  qrlgrupo.caption := 'Grupo A';
      7:  qrlgrupo.caption := 'Grupo B';
      13: qrlgrupo.caption := 'Grupo C';
      19: qrlgrupo.caption := 'Grupo D';
      25: qrlgrupo.caption := 'Grupo E';
      31: qrlgrupo.caption := 'Grupo F';
      37: qrlgrupo.caption := 'Grupo G';
      43: qrlgrupo.caption := 'Grupo H';
    end;
  end;

  if Modulo.dtsselecao.Locate('CODIGO',
                              dtsGeral.FieldByName('COD_SELECAO1').AsInteger,
                              [locaseinsensitive]) then
  begin
    qrlselecao1.caption := Modulo.dtsselecao.FieldbyName('NOME').AsString;
  end
  else
    qrlselecao1.caption := '?';

  if Modulo.dtsselecao.Locate('CODIGO',
                              dtsGeral.FieldByName('COD_SELECAO2').AsInteger,
                              [locaseinsensitive]) then
  begin
    qrlselecao2.caption := Modulo.dtsselecao.FieldbyName('NOME').AsString;
  end
  else
    qrlselecao2.caption := '?';

  if dtsgeral.FieldByName('ENCERRADO').AsInteger = 1 then
  begin
    if iapostador = 0 then
      qrlencerrado.caption := '(fim)'
    else
      qrlencerrado.caption := ' ';


    if dtsGeral.FieldByName('CODIGO').AsInteger <= 48 then
    begin
      qrlplacar1.caption := dtsGeral.FieldByName('PLACAR1').AsString;
      qrlplacar2.caption := dtsGeral.FieldByName('PLACAR2').AsString;
    end
    else
    begin
      if dtsGeral.FieldByName('PLACAR1').AsInteger = 1 then
      begin
        qrlplacar1.Caption := 'X';
        qrlplacar2.Caption := '';
      end
      else
      begin
        qrlplacar1.Caption := '';
        qrlplacar2.Caption := 'X';
      end;
    end;
  end
  else
  begin
    if (dtsgeral.FieldBYName('CODIGO').AsInteger in [49..56]) and
       (ioitavachecada = 1000) then
    begin
      qrlselecao1.caption := '?';
      qrlselecao2.caption := '?';
    end;

    qrlencerrado.caption := '';
    qrlplacar1.Caption := '';
    qrlplacar2.caption := '';
  end;

  Application.ProcessMessages;
end;

procedure Tfrmimpressao.FormCreate(Sender: TObject);
begin
  frmpreview := Tfrmpreview.create(Self);
end;

procedure Tfrmimpressao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(frmPreview);
end;

end.
