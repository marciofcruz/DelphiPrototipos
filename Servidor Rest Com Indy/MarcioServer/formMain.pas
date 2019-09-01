unit formMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.AppEvnts, Vcl.Buttons,
  Vcl.Imaging.pngimage,
  ToviasurFramework,
  System.Actions, Vcl.ActnList,
  Toviasur.Proxy,
  MarcioServer.SController.Base;

type
  TfrmMain = class(TForm)
    pnlBase: TPanel;
    pnlTop: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    panMemo: TPanel;
    GroupBox1: TGroupBox;
    logApp: TMemo;
    GroupBox2: TGroupBox;
    memoReq: TMemo;
    GroupBox3: TGroupBox;
    memoResp: TMemo;
    edtPorta: TLabeledEdit;
    edtUsuario: TLabeledEdit;
    edtSenha: TLabeledEdit;
    ActionList1: TActionList;
    actAtivar: TAction;
    actParar: TAction;
    actLimparLog: TAction;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ckbTemAutenticacao: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPararUpdate(Sender: TObject);
    procedure actLimparLogUpdate(Sender: TObject);
    procedure actAtivarUpdate(Sender: TObject);
    procedure actAtivarExecute(Sender: TObject);
    procedure actPararExecute(Sender: TObject);
    procedure actLimparLogExecute(Sender: TObject);
  private
    FEngine: TTVSEngine;
    FProxyNegocio: TProxy;

    procedure HabilitarParametros(AHabilitar: Boolean);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FEngine := TTVSEngine.Create(Self);

  FProxyNegocio := TProxy.Create;

  ProxyRaptor.MemoAplicacao := logApp;
  ProxyRaptor.MemoRequisicoes := memoReq;
  ProxyRaptor.MemoRespostas := memoResp;
  ProxyRaptor.OnGet := FProxyNegocio.OnGet;
  ProxyRaptor.OnPost := FProxyNegocio.OnPost;
  ProxyRaptor.OnPut := FProxyNegocio.OnPut;
  ProxyRaptor.OnDelete := FProxyNegocio.OnDelete;

  actAtivar.Execute;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FProxyNegocio);
  FreeAndNil(FEngine);
end;

procedure TfrmMain.HabilitarParametros(AHabilitar: Boolean);
begin
  edtPorta.Enabled := AHabilitar;
  edtSenha.Enabled := AHabilitar;
  edtUsuario.Enabled := AHabilitar;
  ckbTemAutenticacao.Enabled := AHabilitar;
end;

procedure TfrmMain.actAtivarExecute(Sender: TObject);
begin
  FEngine.ServerParams.HasAuthentication := ckbTemAutenticacao.Checked;
  FEngine.Porta := StrToIntDef(edtPorta.Text,8080);
  FEngine.ServerParams.UserName := edtUsuario.Text;
  FEngine.ServerParams.Password := edtSenha.Text;

  FEngine.Ativar;

  HabilitarParametros(False);
end;

procedure TfrmMain.actAtivarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=  Assigned(FEngine) and (not FEngine.EstahAtivado);
end;

procedure TfrmMain.actLimparLogExecute(Sender: TObject);
begin
  ProxyRaptor.LimparLog;
end;

procedure TfrmMain.actLimparLogUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(FEngine);
end;

procedure TfrmMain.actPararExecute(Sender: TObject);
begin
  FEngine.Desativar;
  HabilitarParametros(True);
end;

procedure TfrmMain.actPararUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=  Assigned(FEngine) and FEngine.EstahAtivado;
end;

end.
