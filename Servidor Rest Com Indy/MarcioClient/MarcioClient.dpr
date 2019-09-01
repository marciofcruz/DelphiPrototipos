program MarcioClient;

uses
  Vcl.Forms,
  formMain in 'formMain.pas' {frmPrincipal},
  uFrmCadastroBase in 'View\uFrmCadastroBase.pas' {frmCadastroBase},
  uFrmCadastroFabricante in 'View\uFrmCadastroFabricante.pas' {frmCadastroFabricante},
  MarcioClient.CController.Fabricante in 'ClientController\MarcioClient.CController.Fabricante.pas',
  MarcioClient.CController.Base in 'ClientController\MarcioClient.CController.Base.pas',
  Entidade.Base in '..\Comum\Entidade.Base.pas',
  Entidade.Fabricante in '..\Comum\Entidade.Fabricante.pas',
  MarcioClient.CController.Modelo in 'ClientController\MarcioClient.CController.Modelo.pas',
  Entidade.Modelo in '..\Comum\Entidade.Modelo.pas',
  ufrmCadastroModelo in 'View\ufrmCadastroModelo.pas' {frmCadastroModelo},
  MarcioClient.CController.Equipamento in 'ClientController\MarcioClient.CController.Equipamento.pas',
  Entidade.Equipamento in '..\Comum\Entidade.Equipamento.pas',
  uFrmBaseEquipamento in 'View\uFrmBaseEquipamento.pas' {frmBaseEquipamento},
  Comum.Pesquisa.Equipamento in '..\Comum\Pesquisa\Comum.Pesquisa.Equipamento.pas',
  uFrmConsultaEquipamento in 'View\uFrmConsultaEquipamento.pas' {frmConsultaEquipamento},
  uFrmCadastroEquipamento in 'View\uFrmCadastroEquipamento.pas' {frmCadastroEquipamento},
  formDataSimples in 'formDataSimples.pas' {frmDataSimples},
  MarcioClient.CController.Autenticacao in 'ClientController\MarcioClient.CController.Autenticacao.pas',
  Toviasur.Estrutura.Token in '..\MarcioServer\Toviasur\Toviasur.Estrutura.Token.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
