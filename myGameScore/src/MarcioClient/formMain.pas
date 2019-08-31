unit formMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,   REST.Types, FireDAC.Stan.Intf,
  Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ExtCtrls, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Samples.Spin;

type
  TfrmPrincipal = class(TForm)
    grbConfiguracao: TGroupBox;
    edtHost: TLabeledEdit;
    edtPorta: TLabeledEdit;
    edtUsuario: TLabeledEdit;
    edtSenha: TLabeledEdit;
    ckbTemAutenticacao: TCheckBox;
    GroupBox3: TGroupBox;
    edtUsuarioSistema: TLabeledEdit;
    edtSenhaSistema: TLabeledEdit;
    btnAutenticacao: TButton;
    edtTokenGerado: TLabeledEdit;
    edtProvedor: TLabeledEdit;
    edtExpiracao: TLabeledEdit;
    edtMensagem: TLabeledEdit;
    edtLiberado: TLabeledEdit;
    pagina: TPageControl;
    tabLancarPontos: TTabSheet;
    tabVerResultados: TTabSheet;
    dtDataJogo: TDateTimePicker;
    spePontos: TSpinEdit;
    lblCaptionDataJogo: TLabel;
    Label1: TLabel;
    btnSalvar: TButton;
    memRecorde: TMemo;
    procedure btnAutenticacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure paginaChange(Sender: TObject);
  private
    FAcessoLiberado: Boolean;

    procedure CarregarRecorde;
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Estruturatoken,
  Entidade.Resultado,
  MarcioClient.CController.Jogo,
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

    FAcessoLiberado := Retorno.AcessoLiberado;

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

{
procedure TfrmPrincipal.setParametrosTela(Tela: TfrmCadastroBase);
begin
  Tela.EnderecoHost := edtHost.Text;
  Tela.Token := edtTokenGerado.Text;
  Tela.Porta := StrToIntDef(edtPorta.text,8080);
  Tela.TemAutenticacao := ckbTemAutenticacao.Checked;
  Tela.User := edtUsuario.Text;
  Tela.Password := edtSenha.Text;
end;
 }

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
var
  Jogo: TJogo;
  RetornoToken: TRetornoToken;
begin
  if not FAcessoLiberado then
  begin
    raise Exception.Create('Usuário não autenticado!');
  end;

  Jogo := TJogo.Create;
  RetornoToken := nil;
  try
    Jogo.BaseURL := edtHost.Text+':'+edtPorta.text;
    Jogo.Token := edtTokenGerado.Text;
    Jogo.TemAutenticacao := ckbTemAutenticacao.Checked;
    Jogo.User := edtUsuario.Text;
    Jogo.Password := edtSenha.Text;
    RetornoToken := Jogo.Lancar(dtDataJogo.DateTime, spePontos.Value);

    ShowMessage(RetornoToken.Mensagem);
  finally
    FreeAndNil(Jogo);
    FreeAndNil(RetornoToken);
  end;
end;

procedure TfrmPrincipal.CarregarRecorde;
var
  Jogo: TJogo;
  ResultadoJogo: TResultadoJogo;
begin
  memRecorde.Lines.Clear;

  if FAcessoLiberado then
  begin
    memRecorde.Lines.Add('Aguarde, carregando resultados...');


    Jogo := TJogo.Create;
    ResultadoJogo := nil;
    try
      Jogo.BaseURL := edtHost.Text+':'+edtPorta.text;
      Jogo.Token := edtTokenGerado.Text;
      Jogo.TemAutenticacao := ckbTemAutenticacao.Checked;
      Jogo.User := edtUsuario.Text;
      Jogo.Password := edtSenha.Text;
      ResultadoJogo := Jogo.getResultado;

      memRecorde.Lines.Clear;
      memRecorde.Lines.Add(ResultadoJogo.ToString);
    finally
      FreeAndNil(Jogo);
    end;
  end
  else
  begin
    memRecorde.Lines.Add('Usuário sem autenticação para buscar resultados!');
  end;
end;


procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FAcessoLiberado := False;

  pagina.ActivePage := tabLancarPontos;
end;

procedure TfrmPrincipal.paginaChange(Sender: TObject);
begin
  if pagina.ActivePage=tabVerResultados then
  begin
    CarregarRecorde;
  end;
end;

end.
