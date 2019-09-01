unit uFrmCadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, Data.DB, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter,
  MarcioClient.CController.Base, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TModoTela = (modoBrowse, modoInsert, modoEdit);

  TfrmCadastroBase = class(TForm)
    pnlOperacoes: TPanel;
    pnlPrincipal: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ActionList1: TActionList;
    actNovo: TAction;
    actEditar: TAction;
    actExcluir: TAction;
    actSalvar: TAction;
    actCancelar: TAction;
    dtsMain: TDataSource;
    actSincronizar: TAction;
    btnSincronizar: TButton;
    FDMain: TFDMemTable;
    FDMainCHAVEINTERNA: TIntegerField;
    FDMainEXCLUIDO: TIntegerField;
    FDMainREVISAO: TIntegerField;
    FDMainALTERADO: TIntegerField;
    pagina: TPageControl;
    tabVisualizacao: TTabSheet;
    DBGridPrincipal: TDBGrid;
    tabManutencao: TTabSheet;
    StaticText1: TStaticText;
    lblcodigo: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure actNovoUpdate(Sender: TObject);
    procedure actEditarUpdate(Sender: TObject);
    procedure actExcluirUpdate(Sender: TObject);
    procedure actSalvarUpdate(Sender: TObject);
    procedure actCancelarUpdate(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actSincronizarUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSincronizarExecute(Sender: TObject);
  private
    FEnderecoHost: String;
    FPorta: Integer;
    FPassword: String;
    FUser: String;
    FTemAutenticacao: Boolean;
    FToken: String;

    procedure Sincronizar;

    procedure AtualizarAcessoHost;

    procedure setEnderecoHost(const Value: String);
    procedure setPorta(const Value: Integer);
    procedure setPassword(const Value: String);
    procedure setTemAutenticacao(const Value: Boolean);
    procedure setUser(const Value: String);
    procedure setToken(const Value: String);
  protected
    FModotela: TModoTela;

    FControllerMain: TControllerBase;

    FCarregarListaInicializacao: Boolean;

    FMetodo: String;

    procedure AtualizarCampos; virtual; abstract;
    procedure LimparCampos; virtual; abstract;

    function UpdateInsert: Boolean; virtual;
    function UpdateEdit: Boolean; virtual;
    function UpdateCancel: Boolean; virtual;

    function getQtdeRegistros: Integer;
  public
    property Token: String read FToken write setToken;
    property EnderecoHost: String read FEnderecoHost write setEnderecoHost;
    property Porta: Integer read FPorta write setPorta;
    property User: String read FUser write setUser;
    property Password: String read FPassword write setPassword;
    property TemAutenticacao: Boolean read FTemAutenticacao
      write setTemAutenticacao;
  end;

implementation

{$R *.dfm}

procedure TfrmCadastroBase.actCancelarExecute(Sender: TObject);
begin
  FDMain.Cancel;
  pagina.ActivePage := tabVisualizacao;
  FModotela := modoBrowse;
end;

procedure TfrmCadastroBase.actCancelarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := UpdateCancel;
end;

procedure TfrmCadastroBase.actEditarExecute(Sender: TObject);
begin
  AtualizarCampos;

  FDMain.Edit;
  FDMainALTERADO.AsInteger := 1;

  pagina.ActivePage := tabManutencao;
  FModotela := modoEdit;
end;

procedure TfrmCadastroBase.actEditarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := UpdateEdit;
end;

procedure TfrmCadastroBase.actExcluirExecute(Sender: TObject);
begin
  if MessageBox(Self.Handle, 'Confirma exclusão?', 'Atenção',
    mb_YesNO + mb_IconQuestion) = idYes then
  begin
    try
      FDMain.DisableControls;

      FDMain.Edit;
      FDMainEXCLUIDO.AsInteger := 1;
      FDMain.Post;

      Sincronizar;

      FControllerMain.CarregarLista(FMetodo, FDMain);
    finally
      FDMain.EnableControls;
    end;
  end;
end;

procedure TfrmCadastroBase.actExcluirUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := UpdateEdit;
end;

procedure TfrmCadastroBase.actNovoExecute(Sender: TObject);
begin
  LimparCampos;

  FDMain.Append;
  FDMainEXCLUIDO.AsInteger := 0;
  FDMainALTERADO.AsInteger := 1;

  pagina.ActivePage := tabManutencao;
  FModotela := modoInsert;
end;

procedure TfrmCadastroBase.actNovoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := UpdateInsert;
end;

procedure TfrmCadastroBase.actSalvarExecute(Sender: TObject);
begin
  try
    FDMain.Post;

    Sincronizar;

    FControllerMain.CarregarLista(FMetodo, FDMain);

    pagina.ActivePage := tabVisualizacao;
    FModotela := modoBrowse;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao Salvar Registro: ' + E.Message);
      FControllerMain.CarregarLista(FMetodo, FDMain);
      actCancelar.Execute;
    end;
  end;
end;

procedure TfrmCadastroBase.actSalvarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := UpdateCancel;
end;

procedure TfrmCadastroBase.actSincronizarExecute(Sender: TObject);
begin
  FControllerMain.CarregarLista(FMetodo, FDMain);
end;

procedure TfrmCadastroBase.actSincronizarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := FCarregarListaInicializacao and UpdateInsert;
end;

procedure TfrmCadastroBase.AtualizarAcessoHost;
begin
  FControllerMain.BaseURL := FEnderecoHost + ':' + FPorta.ToString;
  FControllerMain.User := FUser;
  FControllerMain.Password := FPassword;
  FControllerMain.TemAutenticacao := FTemAutenticacao;
  FControllerMain.Token := FToken;
end;

procedure TfrmCadastroBase.setEnderecoHost(const Value: String);
begin
  FEnderecoHost := Value;

  AtualizarAcessoHost;
end;

procedure TfrmCadastroBase.setPassword(const Value: String);
begin
  FPassword := Value;
  AtualizarAcessoHost;
end;

procedure TfrmCadastroBase.setPorta(const Value: Integer);
begin
  FPorta := Value;

  AtualizarAcessoHost;
end;

procedure TfrmCadastroBase.setTemAutenticacao(const Value: Boolean);
begin
  FTemAutenticacao := Value;
  AtualizarAcessoHost;
end;

procedure TfrmCadastroBase.setToken(const Value: String);
begin
  if Trim(Value)='' then
  begin
    raise Exception.Create('Token não definido!');
  end;

  FToken := Trim(Value);

  AtualizarAcessoHost;
end;

procedure TfrmCadastroBase.setUser(const Value: String);
begin
  FUser := Value;
  AtualizarAcessoHost;
end;

procedure TfrmCadastroBase.Sincronizar;
var
  RetornoJSON: TRetornoJSON;
begin
  try
    RetornoJSON := FControllerMain.EnviarLista(FMetodo, FDMain);

    if RetornoJSON.STATUS <> 200 then
    begin
      ShowMessage(RetornoJSON.MENSAGEM);
    end;
  finally
    FreeAndNil(RetornoJSON);
  end;
end;

procedure TfrmCadastroBase.FormCreate(Sender: TObject);
begin
  FCarregarListaInicializacao := True;

  Self.Width := Trunc(Screen.Width * 0.9);
  Self.Height := Trunc(Screen.Height * 0.8);

  FModotela := modoBrowse;
  FControllerMain := nil;

  tabVisualizacao.TabVisible := False;
  tabManutencao.TabVisible := False;

  pagina.ActivePage := tabVisualizacao;
end;

procedure TfrmCadastroBase.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FControllerMain);
end;

procedure TfrmCadastroBase.FormShow(Sender: TObject);
begin
  FDMain.Close;
  FDMain.Open;

  if FCarregarListaInicializacao then
  begin
    FControllerMain.CarregarLista(FMetodo, FDMain);
  end
  else
  begin
    btnSincronizar.Visible := False;
  end;

  FDMain.Filter := 'EXCLUIDO=0';
  FDMain.Filtered := True;
end;

function TfrmCadastroBase.getQtdeRegistros: Integer;
begin
  Result := FDMain.RecordCount;
end;

function TfrmCadastroBase.UpdateCancel: Boolean;
begin
  Result := FModotela in [modoInsert, modoEdit];
end;

function TfrmCadastroBase.UpdateEdit: Boolean;
begin
  Result := (FModotela = modoBrowse) and (getQtdeRegistros > 0);
end;

function TfrmCadastroBase.UpdateInsert: Boolean;
begin
  Result := FModotela = modoBrowse;
end;

end.
