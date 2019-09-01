program MarcioServer;

uses
  Vcl.Forms,
  formMain in 'formMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  Toviasur.HandleContext in 'Toviasur\Toviasur.HandleContext.pas',
  Toviasur.Comuns in 'Toviasur\Toviasur.Comuns.pas',
  Toviasur.Proxy in 'Toviasur\Toviasur.Proxy.pas',
  ToviasurFramework in 'Toviasur\ToviasurFramework.pas',
  MarcioServer.SController.Base in 'ServerController\MarcioServer.SController.Base.pas',
  MarcioServer.Model.DMBase in 'Model\MarcioServer.Model.DMBase.pas' {DMBase: TDataModule},
  MarcioServer.Model.DMFabricante in 'Model\MarcioServer.Model.DMFabricante.pas' {DMFabricante: TDataModule},
  Entidade.Fabricante in '..\Comum\Entidade.Fabricante.pas',
  Entidade.Base in '..\Comum\Entidade.Base.pas',
  Entidade.Modelo in '..\Comum\Entidade.Modelo.pas',
  MarcioServer.Model.DMModelo in 'Model\MarcioServer.Model.DMModelo.pas' {DMModelo: TDataModule},
  Entidade.Equipamento in '..\Comum\Entidade.Equipamento.pas',
  MarcioServer.Model.DMEquipamento in 'Model\MarcioServer.Model.DMEquipamento.pas' {DMEquipamento: TDataModule},
  Comum.Pesquisa.Equipamento in '..\Comum\Pesquisa\Comum.Pesquisa.Equipamento.pas',
  Toviasur.Token in 'Toviasur\Toviasur.Token.pas',
  Toviasur.Estrutura.Token in 'Toviasur\Toviasur.Estrutura.Token.pas',
  JOSE.Encoding.Base64 in 'Toviasur\JWT\Common\JOSE.Encoding.Base64.pas',
  JOSE.Hashing.HMAC in 'Toviasur\JWT\Common\JOSE.Hashing.HMAC.pas',
  JOSE.Signing.RSA in 'Toviasur\JWT\Common\JOSE.Signing.RSA.pas',
  JOSE.Types.Arrays in 'Toviasur\JWT\Common\JOSE.Types.Arrays.pas',
  JOSE.Types.Bytes in 'Toviasur\JWT\Common\JOSE.Types.Bytes.pas',
  JOSE.Types.JSON in 'Toviasur\JWT\Common\JOSE.Types.JSON.pas',
  JOSE.Builder in 'Toviasur\JWT\JOSE\JOSE.Builder.pas',
  JOSE.Consumer in 'Toviasur\JWT\JOSE\JOSE.Consumer.pas',
  JOSE.Consumer.Validators in 'Toviasur\JWT\JOSE\JOSE.Consumer.Validators.pas',
  JOSE.Context in 'Toviasur\JWT\JOSE\JOSE.Context.pas',
  JOSE.Core.Base in 'Toviasur\JWT\JOSE\JOSE.Core.Base.pas',
  JOSE.Core.Builder in 'Toviasur\JWT\JOSE\JOSE.Core.Builder.pas',
  JOSE.Core.JWA.Compression in 'Toviasur\JWT\JOSE\JOSE.Core.JWA.Compression.pas',
  JOSE.Core.JWA.Encryption in 'Toviasur\JWT\JOSE\JOSE.Core.JWA.Encryption.pas',
  JOSE.Core.JWA.Factory in 'Toviasur\JWT\JOSE\JOSE.Core.JWA.Factory.pas',
  JOSE.Core.JWA in 'Toviasur\JWT\JOSE\JOSE.Core.JWA.pas',
  JOSE.Core.JWA.Signing in 'Toviasur\JWT\JOSE\JOSE.Core.JWA.Signing.pas',
  JOSE.Core.JWE in 'Toviasur\JWT\JOSE\JOSE.Core.JWE.pas',
  JOSE.Core.JWK in 'Toviasur\JWT\JOSE\JOSE.Core.JWK.pas',
  JOSE.Core.JWS in 'Toviasur\JWT\JOSE\JOSE.Core.JWS.pas',
  JOSE.Core.JWT in 'Toviasur\JWT\JOSE\JOSE.Core.JWT.pas',
  JOSE.Core.Parts in 'Toviasur\JWT\JOSE\JOSE.Core.Parts.pas',
  Toviasur.ControllerBase in 'Toviasur\Toviasur.ControllerBase.pas',
  Toviasur.ControllerAutenticacao in 'Toviasur\Toviasur.ControllerAutenticacao.pas',
  MarcioServer.SController.Almoxarifado in 'ServerController\MarcioServer.SController.Almoxarifado.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

