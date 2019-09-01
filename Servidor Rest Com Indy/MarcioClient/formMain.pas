unit formMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,   REST.Types, FireDAC.Stan.Intf,
  Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, uFrmCadastroBase, Vcl.ExtCtrls, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmPrincipal = class(TForm)
    grbConfiguracao: TGroupBox;
    edtHost: TLabeledEdit;
    edtPorta: TLabeledEdit;
    edtUsuario: TLabeledEdit;
    edtSenha: TLabeledEdit;
    ckbTemAutenticacao: TCheckBox;
    GroupBox1: TGroupBox;
    btnFabricantes: TButton;
    btnModelos: TButton;
    GroupBox2: TGroupBox;
    btnEquipamentosRetrieve: TButton;
    btnEquipamentosCadastro: TButton;
    GroupBox3: TGroupBox;
    edtUsuarioSistema: TLabeledEdit;
    edtSenhaSistema: TLabeledEdit;
    btnAutenticacao: TButton;
    edtTokenGerado: TLabeledEdit;
    edtProvedor: TLabeledEdit;
    edtExpiracao: TLabeledEdit;
    edtMensagem: TLabeledEdit;
    edtLiberado: TLabeledEdit;
    procedure btnFabricantesClick(Sender: TObject);
    procedure btnModelosClick(Sender: TObject);
    procedure btnEquipamentosRetrieveClick(Sender: TObject);
    procedure btnEquipamentosCadastroClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAutenticacaoClick(Sender: TObject);
  private
    procedure setParametrosTela(Tela: TfrmCadastroBase);
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  ufrmCadastroFabricante, uFrmCadastroModelo, uFrmConsultaEquipamento,
  uFrmCadastroEquipamento,
  Toviasur.Estrutura.Token,
  MarcioClient.CController.Autenticacao;

{$R *.dfm}

procedure TfrmPrincipal.btnAutenticacaoClick(Sender: TObject);
var
  Autenticacao: TAutenticacao;
  Retorno: TRetornoToken;
begin
  Retorno := nil;
  Autenticacao := TAutenticacao.Create;
  try
    Autenticacao.BaseURL := edtHost.Text + ':' + edtPorta.text;
    Autenticacao.User := edtUsuario.Text;
    Autenticacao.Password := edtSenha.Text;
    Autenticacao.TemAutenticacao := ckbTemAutenticacao.Checked;

    Retorno := Autenticacao.Autenticar(edtUsuarioSistema.Text, edtSenhaSistema.Text);

    edtTokenGerado.Text := Retorno.Token;
    edtProvedor.Text := Retorno.NomeGrupoEconomico;

    if Retorno.Expiracao>0 then
    begin
      edtExpiracao.Text := FormatDateTime('dd/mm/yyyy hh:nn', Retorno.Expiracao);
    end
    else
    begin
      edtExpiracao.Text := '-';
    end;

    edtMensagem.Text := Retorno.Mensagem;

    if Retorno.AcessoLiberado then
    begin
      edtLiberado.Text := 'SIM';
    end
    else
    begin
      edtLiberado.Text := 'NÃO';
    end;
  finally
    FreeAndNil(Autenticacao);
  end;
end;

procedure TfrmPrincipal.btnEquipamentosCadastroClick(Sender: TObject);
var
  Tela: TfrmCadastroEquipamento;
begin
  Tela := Nil;
  try
    Tela := TfrmCadastroEquipamento.Create(Self);
    setParametrosTela(Tela);
    Tela.ShowModal;
  finally
    FreeAndNil(Tela);
  end;
end;

procedure TfrmPrincipal.btnEquipamentosRetrieveClick(Sender: TObject);
var
  Tela: TfrmConsultaEquipamento;
begin
  Tela := Nil;
  try
    Tela := TfrmConsultaEquipamento.Create(Self);
    setParametrosTela(Tela);
    Tela.ShowModal;
  finally
    FreeAndNil(Tela);
  end;
end;

procedure TfrmPrincipal.btnFabricantesClick(Sender: TObject);
var
  Tela: TfrmCadastroFabricante;
begin
  Tela := Nil;
  try
    Tela := TfrmCadastroFabricante.Create(Self);
    setParametrosTela(Tela);
    Tela.ShowModal;
  finally
    FreeAndNil(Tela);
  end;
end;

procedure TfrmPrincipal.btnModelosClick(Sender: TObject);
var
  Tela: TfrmCadastroModelo;
begin
  Tela := Nil;
  try
    Tela := TfrmCadastroModelo.Create(Self);
    setParametrosTela(Tela);
    Tela.ShowModal;
  finally
    FreeAndNil(Tela);
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  edtTokenGerado.Text := '';
  edtProvedor.Text := '';
  edtExpiracao.Text := '';

end;

procedure TfrmPrincipal.setParametrosTela(Tela: TfrmCadastroBase);
begin
  Tela.EnderecoHost := edtHost.Text;
  Tela.Token := edtTokenGerado.Text;
  Tela.Porta := StrToIntDef(edtPorta.text,8080);
  Tela.TemAutenticacao := ckbTemAutenticacao.Checked;
  Tela.User := edtUsuario.Text;
  Tela.Password := edtSenha.Text;
end;

end.
