program DccTest;

uses
  Forms,
  uMain in 'uMain.pas' {frmMenu},
  uSelec in 'uSelec.pas' {frmSelecionarArquivos},
  uSearch in 'uSearch.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Compila e testa o carregamento de executáveis do Delphi 32';
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
