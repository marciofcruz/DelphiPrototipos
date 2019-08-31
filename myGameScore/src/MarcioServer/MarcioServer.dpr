program MarcioServer;

uses
  Vcl.Forms,
  formMain in 'formMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  RaptorWS.HandleContext in 'RaptorWS\fontes\RaptorWS.HandleContext.pas',
  RaptorWS.ServerUtils in 'RaptorWS\fontes\RaptorWS.ServerUtils.pas',
  RaptorWS.SysTypes in 'RaptorWS\fontes\RaptorWS.SysTypes.pas',
  MarcioServer.RaptorWS.Proxy in 'RaptorWS\comunidade\MarcioServer.RaptorWS.Proxy.pas',
  MarcioServer.RaptorWS.ServidorRest in 'RaptorWS\comunidade\MarcioServer.RaptorWS.ServidorRest.pas',
  MarcioServer.SController.Base in 'ServerController\MarcioServer.SController.Base.pas',
  MarcioServer.Model.DMBase in 'Model\MarcioServer.Model.DMBase.pas' {DMBase: TDataModule},
  MarcioServer.Model.DMJogo in 'Model\MarcioServer.Model.DMJogo.pas' {DMJogo: TDataModule},
  Entidade.Jogo in '..\Comum\Entidade.Jogo.pas',
  Entidade.Base in '..\Comum\Entidade.Base.pas',
  JOSE.Builder in 'JWT\fontes\JOSE\JOSE.Builder.pas',
  JOSE.Consumer in 'JWT\fontes\JOSE\JOSE.Consumer.pas',
  JOSE.Consumer.Validators in 'JWT\fontes\JOSE\JOSE.Consumer.Validators.pas',
  JOSE.Context in 'JWT\fontes\JOSE\JOSE.Context.pas',
  JOSE.Core.Base in 'JWT\fontes\JOSE\JOSE.Core.Base.pas',
  JOSE.Core.Builder in 'JWT\fontes\JOSE\JOSE.Core.Builder.pas',
  JOSE.Core.JWA.Compression in 'JWT\fontes\JOSE\JOSE.Core.JWA.Compression.pas',
  JOSE.Core.JWA.Encryption in 'JWT\fontes\JOSE\JOSE.Core.JWA.Encryption.pas',
  JOSE.Core.JWA.Factory in 'JWT\fontes\JOSE\JOSE.Core.JWA.Factory.pas',
  JOSE.Core.JWA in 'JWT\fontes\JOSE\JOSE.Core.JWA.pas',
  JOSE.Core.JWA.Signing in 'JWT\fontes\JOSE\JOSE.Core.JWA.Signing.pas',
  JOSE.Core.JWE in 'JWT\fontes\JOSE\JOSE.Core.JWE.pas',
  JOSE.Core.JWK in 'JWT\fontes\JOSE\JOSE.Core.JWK.pas',
  JOSE.Core.JWS in 'JWT\fontes\JOSE\JOSE.Core.JWS.pas',
  JOSE.Core.JWT in 'JWT\fontes\JOSE\JOSE.Core.JWT.pas',
  JOSE.Core.Parts in 'JWT\fontes\JOSE\JOSE.Core.Parts.pas',
  JOSE.Encoding.Base64 in 'JWT\fontes\Common\JOSE.Encoding.Base64.pas',
  JOSE.Hashing.HMAC in 'JWT\fontes\Common\JOSE.Hashing.HMAC.pas',
  JOSE.Signing.RSA in 'JWT\fontes\Common\JOSE.Signing.RSA.pas',
  JOSE.Types.Arrays in 'JWT\fontes\Common\JOSE.Types.Arrays.pas',
  JOSE.Types.Bytes in 'JWT\fontes\Common\JOSE.Types.Bytes.pas',
  JOSE.Types.JSON in 'JWT\fontes\Common\JOSE.Types.JSON.pas',
  MarcioServer.JWT.Token in 'JWT\MarcioServer.JWT.Token.pas',
  EstruturaToken in '..\Comum\EstruturaToken.pas',
  Entidade.Resultado in '..\Comum\Entidade.Resultado.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

