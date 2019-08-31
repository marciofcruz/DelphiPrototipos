unit uMain;

interface

uses
  uCapturaCadastro,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  Vcl.Buttons,
  HKFaceID.Configuracao,
  HKFaceID.Modelo.Tipos,
  HKFaceID.DM.Conexao,
  HKFaceID.DM.CadastroEntidade,
  uTreinamento,
  HKFaceID.CV.Dispositivos,
  HKFaceID.CV.Captura,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.FileCtrl;

type
  TfrmHKFaceIDPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    pnlLogo: TPanel;
    imgLogo: TImage;
    pnlFuncoes: TPanel;
    pagina: TPageControl;
    tabConfiguracoes: TTabSheet;
    tabTreinamento: TTabSheet;
    tabCadastro: TTabSheet;
    grbSQLServer: TGroupBox;
    edtSQLServerHost: TLabeledEdit;
    edtSQLServerBanco: TLabeledEdit;
    edtSqlServerUsuario: TLabeledEdit;
    edtSQLServerSenha: TLabeledEdit;
    ActionList1: TActionList;
    actSalvarConfiguracao: TAction;
    actTestarConexaoBanco: TAction;
    SpeedButton2: TSpeedButton;
    panBotoesCadastro: TPanel;
    ImageList2: TImageList;
    actAppend: TAction;
    actEdit: TAction;
    actSave: TAction;
    actCancel: TAction;
    actDelete: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    DBGEntidade: TDBGrid;
    dsEntidade: TDataSource;
    tabTeste: TTabSheet;
    grbYALE: TGroupBox;
    edtCaminhoYALE: TLabeledEdit;
    SpeedButton3: TSpeedButton;
    actCarregarYale: TAction;
    ToolButton8: TToolButton;
    actTreinamento: TAction;
    ToolButton9: TToolButton;
    GroupBox1: TGroupBox;
    lstDispositivosVideo: TListBox;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    GroupBox2: TGroupBox;
    flbXML: TFileListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actSalvarConfiguracaoExecute(Sender: TObject);
    procedure actTestarConexaoBancoExecute(Sender: TObject);
    procedure actAppendUpdate(Sender: TObject);
    procedure actEditUpdate(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure actAppendExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure paginaChanging(Sender: TObject; var AllowChange: Boolean);
    procedure actTreinamentoUpdate(Sender: TObject);
    procedure actTreinamentoExecute(Sender: TObject);
  private
    FConfiguracao: TConfiguracao;
    DMConexao: TDMConexao;
    DMCadastroEntidade: TDMEntidade;
    FConfigSQLServer: TConfigSQLServer;

    FCVDispositivos: TCVDispositivos;
  public
    { Public declarations }
  end;

var
  frmHKFaceIDPrincipal: TfrmHKFaceIDPrincipal;

implementation

{$R *.dfm}

procedure TfrmHKFaceIDPrincipal.actAppendExecute(Sender: TObject);
begin
  DMCadastroEntidade.cdsEntidade.Append;
  DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger := DMCadastroEntidade.getChaveEntidade;
  DMCadastroEntidade.cdsEntidadeSITUACAO.AsInteger := 1;
  DMCadastroEntidade.cdsEntidadeDTCADASTRO.AsDateTime := now;
  DMCadastroEntidade.cdsEntidadeORIGEM.AsString := 'MANUAL';
end;

procedure TfrmHKFaceIDPrincipal.actAppendUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.State=dsBrowse);

end;

procedure TfrmHKFaceIDPrincipal.actCancelExecute(Sender: TObject);
begin
  DMCadastroEntidade.cdsEntidade.Cancel;
end;

procedure TfrmHKFaceIDPrincipal.actCancelUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.State in [dsEdit, dsInsert]);
end;

procedure TfrmHKFaceIDPrincipal.actDeleteExecute(Sender: TObject);
begin
  if MessageBox(Self.Handle, 'Confirma exclusão?', 'Atenção', mb_YesNO+mb_IconQuestion)=idYes then
  begin
    DMCadastroEntidade.cdsEntidade.Edit;
    DMCadastroEntidade.cdsEntidadeSITUACAO.AsInteger := 0;
    DMCadastroEntidade.cdsEntidade.Post;
    DMCadastroEntidade.cdsEntidade.ApplyUpdates(0);
    DMCadastroEntidade.cdsEntidade.Refresh;
  end;
end;

procedure TfrmHKFaceIDPrincipal.actDeleteUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.RecordCount<>0) and
                             (DMCadastroEntidade.cdsEntidade.State=dsBrowse);
end;

procedure TfrmHKFaceIDPrincipal.actEditExecute(Sender: TObject);
begin
  DMCadastroEntidade.cdsEntidade.Edit;
end;

procedure TfrmHKFaceIDPrincipal.actEditUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.RecordCount<>0) and
                             (DMCadastroEntidade.cdsEntidade.State=dsBrowse);
end;

procedure TfrmHKFaceIDPrincipal.actSalvarConfiguracaoExecute(Sender: TObject);
begin
  if lstDispositivosVideo.ItemIndex=-1 then
  begin
    raise Exception.Create('Selecine um dispositivo de video!');
  end;

  FConfigSQLServer.Host := edtSQLServerHost.Text;
  FConfigSQLServer.Banco := edtSQLServerBanco.Text;
  FConfigSQLServer.Usuario := edtSqlServerUsuario.Text;
  FConfigSQLServer.Senha := edtSQLServerSenha.Text;

  FConfiguracao.NomeXMLCascade :=flbXML.Items[flbXML.ItemIndex];

  FConfiguracao.setConfigSql(FConfigSQLServer);

  if MessageBox(Self.Handle, 'Reconectar ao Banco?', 'Atenção', mb_YesNO+mb_IconInformation+mb_DefButton2)=idYes then
  begin
    DMConexao.Configurar(FConfigSQLServer);

    DMCadastroEntidade.cdsEntidade.Close;
    DMCadastroEntidade.cdsEntidade.Open;
  end;
end;

procedure TfrmHKFaceIDPrincipal.actSaveExecute(Sender: TObject);
begin
  DMCadastroEntidade.cdsEntidade.Post;
  DMCadastroEntidade.cdsEntidade.ApplyUpdates(0);
end;

procedure TfrmHKFaceIDPrincipal.actSaveUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.State in [dsEdit, dsInsert]);
end;

procedure TfrmHKFaceIDPrincipal.actTestarConexaoBancoExecute(Sender: TObject);
var
  Teste: TConfigSQLServer;
begin
  Teste.Host := edtSQLServerHost.Text;
  Teste.Banco := edtSQLServerBanco.Text;
  Teste.Usuario := edtSqlServerUsuario.Text;
  Teste.Senha := edtSQLServerSenha.Text;

  DMConexao.Configurar(Teste);
end;

procedure TfrmHKFaceIDPrincipal.actTreinamentoExecute(Sender: TObject);
var
  frmTreinamento: TfrmTreinamento;
  Tela: TfrmCapturaCadastro;
begin
  try
    Tela := TfrmCapturaCadastro.Create(Self);
    Tela.ShowModal;
  finally
    FreeAndNil(Tela);
  end;

//  try
//    frmTreinamento := TfrmTreinamento.Create(Self);
//    frmTreinamento.DMCadastroEntidade := DMCadastroEntidade;
//    frmTreinamento.IDDispositivoVideo := lstDispositivosVideo.ItemIndex;
//    frmTreinamento.CascadeXML :=
//    FConfiguracao.PathCascadeXML+flbXML.Items[flbXML.ItemIndex];
//
//    frmTreinamento.ShowModal;
//  finally
//    FreeAndNil(frmTreinamento);
//  end;
end;

procedure TfrmHKFaceIDPrincipal.actTreinamentoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.RecordCount<>0) and
                             (DMCadastroEntidade.cdsEntidade.State=dsBrowse);
end;

procedure TfrmHKFaceIDPrincipal.FormCreate(Sender: TObject);
var
  Auxiliar: String;
begin
  pagina.ActivePage := tabCadastro;

  DMConexao := TDMConexao.Create(Self);

  FConfiguracao := TConfiguracao.Create;

  flbXML.Directory := FConfiguracao.PathCascadeXML;

  FConfigSQLServer := FConfiguracao.getConfigSqlServer;

  edtSQLServerHost.Text := FConfigSQLServer.Host;
  edtSQLServerBanco.Text := FConfigSQLServer.Banco;
  edtSqlServerUsuario.Text := FConfigSQLServer.Usuario;
  edtSQLServerSenha.Text := FConfigSQLServer.Senha;

  DMCadastroEntidade := TDMEntidade.Create(Self);
  DMCadastroEntidade.Configurar(DMConexao);

  dsEntidade.DataSet := DMCadastroEntidade.cdsEntidade;

  if (FConfigSQLServer.Host<>'') and (FConfigSQLServer.Banco<>'') and (FConfigSQLServer.Usuario<>'') and (FConfigSQLServer.Senha<>'') then
  begin
    try
      DMConexao.Configurar(FConfigSQLServer);
      DMCadastroEntidade.cdsEntidade.Open;
    except
      on E:Exception do
      begin
        pagina.ActivePage := tabConfiguracoes;
      end;
    end;
  end;

  FCVDispositivos := TCVDispositivos.Create;
  FCVDispositivos.setLista(lstDispositivosVideo.Items);

  Auxiliar := FConfiguracao.NomeDispositivoVideo;
  if (Auxiliar<>'') then
  begin
    lstDispositivosVideo.ItemIndex := lstDispositivosVideo.Items.IndexOf(Auxiliar);
  end;

  Auxiliar := FConfiguracao.NomeXMLCascade;
  if (Auxiliar<>'') then
  begin
    flbXML.ItemIndex := flbXML.Items.IndexOf(Auxiliar);
  end;
end;

procedure TfrmHKFaceIDPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCVDispositivos);

  FreeAndNil(DMCadastroEntidade);
  FreeAndNil(DMConexao);
  FreeandNil(FConfiguracao);
end;

procedure TfrmHKFaceIDPrincipal.paginaChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (DMCadastroEntidade.cdsEntidade.State=dsBrowse);
end;

end.
