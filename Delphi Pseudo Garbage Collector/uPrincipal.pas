unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmTeste = class(TForm)
    pnlBase: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    sttInformacao: TStaticText;
    btnCriacaocomPseudoGC: TButton;
    btnCriacaoSemFree: TButton;
    btnTryFinally: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnTryFinallyClick(Sender: TObject);
    procedure btnCriacaoSemFreeClick(Sender: TObject);
    procedure btnCriacaocomPseudoGCClick(Sender: TObject);
  private
    const C_Maximo = 500;

    procedure FecharTela(ACaption: String);
  public
  end;

var
  frmTeste: TFrmTeste;


implementation

uses
  MarcioCruz.PseudoGC;

{$R *.dfm}

procedure TfrmTeste.btnTryFinallyClick(Sender: TObject);
var
  Cont: SmallInt;
  ObjetoQualquer: TStrings;
begin
  for Cont := 1 to C_Maximo do
  begin
    ObjetoQualquer := nil;
    try
      ObjetoQualquer := TStrings.Create;
    finally
      ObjetoQualquer.Free;
    end;
  end;

  FecharTela((Sender as TButton).Caption);
end;

procedure TfrmTeste.btnCriacaocomPseudoGCClick(Sender: TObject);
var
  Cont: SmallInt;
  ObjetoQualquer: TStrings;
begin
  for Cont := 1 to C_Maximo do
  begin
    ObjetoQualquer := TPseudoGC<TStrings>.Create(TStrings.Create).Instancia;
  end;

  FecharTela((Sender as TButton).Caption);
end;

procedure TfrmTeste.btnCriacaoSemFreeClick(Sender: TObject);
var
  Cont: SmallInt;
  ObjetoQualquer: TStrings;
begin
  for Cont := 1 to C_Maximo do
  begin
    ObjetoQualquer := TStrings.Create;
  end;

  FecharTela((Sender as TButton).Caption);
end;

procedure TfrmTeste.FecharTela(ACaption: String);
begin
  MessageBox(Self.Handle, 'Ao clicar em OK, o programa vai se encerrar.'#13+
                          'Se houver vazamento de memória, será informado.',
                          PChar('Opção Selecionada: '+ACaption),
                          mb_Ok+mb_IconInformation);

  close;
end;

procedure TfrmTeste.FormCreate(Sender: TObject);
begin
  sttInformacao.Caption :=
    'O comando "Executar" sempre criará 500 objetos, simulando uma operação em um programa em Deploy'#13+
    'O arquivo DPR já possui a configuração de ReportMemoryLeaksOnShutdown, para alertar na saída do programa.'#13+
    'Depois da execução, o sistema vai fechar e, se houver vazamento, será demonstrado uma mensagem.'#13+
    'Marcio Cruz';
end;

end.
