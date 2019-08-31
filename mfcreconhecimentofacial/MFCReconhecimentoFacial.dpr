program MFCReconhecimentoFacial;

uses
  Vcl.Forms,
  MFC.Uteis.GerenciaRefObjeto in 'Fontes\MFC.Uteis.GerenciaRefObjeto.pas',
  MFC.Uteis.ImagemBASE64 in 'Fontes\MFC.Uteis.ImagemBASE64.pas',
  MFC.Uteis.ZIP in 'Fontes\MFC.Uteis.ZIP.pas',
  MFC.CV.Captura in 'Fontes\MFC.CV.Captura.pas',
  MFC.CV.Dispositivos in 'Fontes\MFC.CV.Dispositivos.pas',
  MFC.CV.FuncoesImagem in 'Fontes\MFC.CV.FuncoesImagem.pas',
  MFC.CV.Reconhecimento in 'Fontes\MFC.CV.Reconhecimento.pas',
  MFC.Configuracao in 'MFC.Configuracao.pas',
  MFC.DM.CadastroEntidade in 'MFC.DM.CadastroEntidade.pas' {DMEntidade: TDataModule},
  MFC.DM.Conexao in 'MFC.DM.Conexao.pas' {DMConexao: TDataModule},
  MFC.Modelo.Tipos in 'MFC.Modelo.Tipos.pas',
  uVerCadastro in 'uVerCadastro.pas' {frmVerCadastro},
  uReconhecimento in 'uReconhecimento.pas' {frmReconhecimento},
  uCapturaCadastro in 'uCapturaCadastro.pas' {frmCapturaCadastro},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  ocv.calib3d_c in 'DelphiOpenCV\ocv.calib3d_c.pas',
  ocv.compat in 'DelphiOpenCV\ocv.compat.pas',
  ocv.core.types_c in 'DelphiOpenCV\ocv.core.types_c.pas',
  ocv.core_c in 'DelphiOpenCV\ocv.core_c.pas',
  ocv.editor in 'DelphiOpenCV\ocv.editor.pas',
  ocv.fmxutils in 'DelphiOpenCV\ocv.fmxutils.pas',
  ocv.haar in 'DelphiOpenCV\ocv.haar.pas',
  ocv.highgui_c in 'DelphiOpenCV\ocv.highgui_c.pas',
  ocv.imgproc.types_c in 'DelphiOpenCV\ocv.imgproc.types_c.pas',
  ocv.imgproc_c in 'DelphiOpenCV\ocv.imgproc_c.pas',
  ocv.legacy in 'DelphiOpenCV\ocv.legacy.pas',
  ocv.lib in 'DelphiOpenCV\ocv.lib.pas',
  ocv.lock in 'DelphiOpenCV\ocv.lock.pas',
  ocv.nonfree in 'DelphiOpenCV\ocv.nonfree.pas',
  ocv.objdetect_c in 'DelphiOpenCV\ocv.objdetect_c.pas',
  ocv.photo_c in 'DelphiOpenCV\ocv.photo_c.pas',
  ocv.tracking_c in 'DelphiOpenCV\ocv.tracking_c.pas',
  ocv.utils in 'DelphiOpenCV\ocv.utils.pas',
  ocv.cls.contrib in 'DelphiOpenCV\classes\ocv.cls.contrib.pas',
  ocv.cls.core in 'DelphiOpenCV\classes\ocv.cls.core.pas',
  ocv.cls.features2d in 'DelphiOpenCV\classes\ocv.cls.features2d.pas',
  ocv.cls.highgui in 'DelphiOpenCV\classes\ocv.cls.highgui.pas',
  ocv.cls.imgproc in 'DelphiOpenCV\classes\ocv.cls.imgproc.pas',
  ocv.cls.objdetect in 'DelphiOpenCV\classes\ocv.cls.objdetect.pas',
  ocv.cls.types in 'DelphiOpenCV\classes\ocv.cls.types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
