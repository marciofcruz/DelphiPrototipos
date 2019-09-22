program AnalisePrecoCombustiveis;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  MFC.CSVtoDataSet in 'src\MFC.CSVtoDataSet.pas',
  MFC.DM.Analise in 'src\MFC.DM.Analise.pas' {DMAnalise: TDataModule},
  MFC.Classes.Amostragem in 'src\MFC.Classes.Amostragem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
