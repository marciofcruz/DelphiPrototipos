program MarcioClient;

uses
  Vcl.Forms,
  formMain in 'formMain.pas' {frmPrincipal},
  MarcioClient.CController.Base in 'ClientController\MarcioClient.CController.Base.pas',
  Entidade.Base in '..\Comum\Entidade.Base.pas',
  MarcioClient.CController.Autenticacao in 'ClientController\MarcioClient.CController.Autenticacao.pas',
  EstruturaToken in '..\Comum\EstruturaToken.pas',
  MarcioClient.CController.Jogo in 'ClientController\MarcioClient.CController.Jogo.pas',
  Entidade.Jogo in '..\Comum\Entidade.Jogo.pas',
  Entidade.Resultado in '..\Comum\Entidade.Resultado.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
