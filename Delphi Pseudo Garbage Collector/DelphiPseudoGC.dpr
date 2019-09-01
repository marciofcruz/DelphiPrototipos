program DelphiPseudoGC;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmTeste},
  MarcioCruz.PseudoGC in 'MarcioCruz.PseudoGC.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTeste, frmTeste);
  Application.Run;
end.
