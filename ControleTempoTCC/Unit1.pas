unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DateUtils;

type
  TOrdem = (Introducao, Libras, Visao,Tecnicas, Conclusao,Apresentacao);

  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnIniciar: TButton;
    btnPausar: TButton;
    btnParar: TButton;
    Timer1: TTimer;
    Memo1: TMemo;
    lblRestante: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
    procedure btnPausarClick(Sender: TObject);
    procedure btnPararClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FLista: array[Low(TOrdem)..High(TOrdem)] of TTime;

    FTempoRestante: TTime;
    Anterior: TDateTime;
    Atual: TDateTime;

    procedure HabilitarBotao;

    procedure Processar;

    procedure Resetar;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  C_Ordem: array[Low(TOrdem)..High(TOrdem)] of String = ('1/6 - Introdução',
                                                      '2/6 - Libras',
                                                      '3/6 - Visão Computacional',
                                                      '4/6 - Técnicas protótipo',
                                                      '5/6 - Conclusão da Pesquisa',
                                                      '6/6 - Apresentação trabalho prático');

implementation

{$R *.dfm}

procedure TForm1.btnIniciarClick(Sender: TObject);
begin
  Anterior := now;
  Timer1.Enabled := True;

  HabilitarBotao;
end;

procedure TForm1.btnPararClick(Sender: TObject);
begin
  Timer1.Enabled := False;

  Resetar;
end;

procedure TForm1.btnPausarClick(Sender: TObject);
begin
  Timer1.Enabled := False;

  HabilitarBotao;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Resetar;
end;

procedure TForm1.HabilitarBotao;
begin
  btnIniciar.Enabled := not Timer1.Enabled;
  btnPausar.Enabled := Timer1.Enabled;
  btnParar.Enabled := Timer1.Enabled;
end;

procedure TForm1.Processar;
var
  Cont: TOrdem;
  Debito: TdateTime;
  Encontrou: Boolean;

begin
  Atual := now;
  Debito := Atual-Anterior;
  Anterior := Atual;

  Encontrou := False;

  for Cont := Low(TOrdem) to High(TOrdem) do
  begin
    if  FLista[Cont]>0 then
    begin
      Encontrou := True;

      FLista[Cont] := FLista[Cont] - Debito;

      FTempoRestante := FTempoRestante - Debito;

      if FLista[Cont]<0 then
      begin
        FLista[Cont] := 0;
      end;

      if FTempoRestante<0 then
      begin
        FTempoRestante := 0;
      end;

      Break;
    end;
  end;

  if not Encontrou then
  begin
    Timer1.Enabled := False;
  end;

  lblRestante.Caption := 'Tempo Restante: '+TimeToStr(FTempoRestante);

  Memo1.Lines.Clear;
  for Cont := Low(TOrdem) to High(TOrdem) do
  begin
    Memo1.Lines.Add(C_Ordem[Cont]+' - '+TimeToStr(FLista[Cont]));
  end;
end;

procedure TForm1.Resetar;
var
  Cont: TOrdem;
begin
  Memo1.Lines.Clear;

  FLista[Introducao] := StrToTime('00:01:00');
  FLista[Libras] := StrToTime('00:01:00');
  FLista[Visao] := StrToTime('00:01:15');
  FLista[Tecnicas] := StrToTime('00:10:00');
  FLista[Conclusao] := StrToTime('00:01:30');
  FLista[Apresentacao] := StrToTime('00:05:15');

  Atual := 0;
  Anterior := 0;

  FTempoRestante := 0;
  for Cont := Low(TOrdem) to High(TOrdem) do
  begin
    FTempoRestante := FTempoRestante+FLista[Cont];
  end;

  lblRestante.Caption := 'Tempo Restante: '+TimeToStr(FTempoRestante);

  HabilitarBotao;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Processar;
end;

end.

