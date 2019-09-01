unit uFrmCadastroEquipamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmCadastroBase, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.WinXPickers,
  Comum.Pesquisa.Equipamento, uFrmBaseEquipamento;

type
  TfrmCadastroEquipamento = class(TfrmBaseEquipamento)
    StaticText2: TStaticText;
    dtEntrada: TDateTimePicker;
    StaticText4: TStaticText;
    edtNome: TEdit;
    StaticText5: TStaticText;
    edtSerie: TEdit;
    StaticText6: TStaticText;
    edtCategoria: TEdit;
    cobModelo: TComboBoxEx;
    StaticText7: TStaticText;
    FDModelos: TFDMemTable;
    FDModelosCHAVEINTERNA: TIntegerField;
    FDModelosEXCLUIDO: TIntegerField;
    FDModelosREVISAO: TIntegerField;
    FDModelosALTERADO: TIntegerField;
    FDModelosDESCRICAO: TStringField;
    FDModelosFABRICANTE: TIntegerField;
    FDModelosDESCFABRICANTE: TStringField;
    FDModelosCAPTION: TStringField;
    FDModelosITEMINDEX: TIntegerField;
    actDevolver: TAction;
    actCancelarDevolucao: TAction;
    Button6: TButton;
    Button7: TButton;
    procedure FormShow(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actDevolverUpdate(Sender: TObject);
    procedure actDevolverExecute(Sender: TObject);
    procedure actCancelarDevolucaoUpdate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    procedure Devolver(const aChave: Integer; AData: TDateTime);

    procedure AtualizarRegistro;

    procedure CarregarListaModelo;
    procedure getModeloSelecionado(var ACodigo: Integer; var ADescricao: String;
      var ACodigoFabricante: Integer; var ADescricaoFabricante: String);
  protected
    function UpdatePesquisar: Boolean; override;
    function UpdateEdit: Boolean; override;

    procedure AtualizarCampos; override;
    procedure LimparCampos; override;
  end;

implementation

uses
  formDataSimples,
  MarcioClient.CController.Base,
  MarcioClient.CController.Modelo,
  MarcioClient.CController.Equipamento;

{$R *.dfm}

procedure TfrmCadastroEquipamento.AtualizarRegistro;
begin
end;

procedure TfrmCadastroEquipamento.Button7Click(Sender: TObject);
begin
  inherited;
  if MessageBox(Self.Handle, 'Cancelar Devolução?', 'Atenção', mb_YesNO+mb_IconQuestion)=idYes then
  begin
    Devolver(FDMainCHAVEINTERNA.AsInteger, 0);
    actPesquisar.Execute;
  end;
end;

procedure TfrmCadastroEquipamento.actCancelarDevolucaoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (inherited UpdateEdit) and
    (not FDMainDATASAIDA.IsNull);
end;

procedure TfrmCadastroEquipamento.actCancelarExecute(Sender: TObject);
begin
  pnlParametrosPesquisa.Visible := True;

  inherited;
end;

procedure TfrmCadastroEquipamento.actDevolverExecute(Sender: TObject);
var
  DataDevolucao: TDateTime;
begin
  inherited;
  if TfrmDataSimples.getData(Self, 'Data Devolução',
    FDMainDATAENTRADA.AsDateTime, DataDevolucao) then
  begin
    Devolver(FDMainCHAVEINTERNA.AsInteger, DataDevolucao);
    actPesquisar.Execute;
  end;
end;

procedure TfrmCadastroEquipamento.actDevolverUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := UpdateEdit;
end;

procedure TfrmCadastroEquipamento.actEditarExecute(Sender: TObject);
begin
  inherited;

  pnlParametrosPesquisa.Visible := False;
  edtNome.SetFocus;
end;

procedure TfrmCadastroEquipamento.actNovoExecute(Sender: TObject);
begin
  inherited;

  pnlParametrosPesquisa.Visible := False;
  edtNome.SetFocus;
end;

procedure TfrmCadastroEquipamento.actSalvarExecute(Sender: TObject);
var
  CodigoModelo, CodigoFabricante: Integer;
  DescricaoModelo, DescricaoFabricante: String;
begin
  try
    edtNome.Text := Trim(edtNome.Text);

    if edtNome.Text = '' then
    begin
      raise Exception.Create('Digite um nome de Equipamento!');
    end;

    if dtEntrada.Date < 0 then
    begin
      raise Exception.Create('Data de entrada inválida!');
    end;

    getModeloSelecionado(CodigoModelo, DescricaoModelo, CodigoFabricante,
      DescricaoFabricante);

    if CodigoModelo <= 0 then
    begin
      raise Exception.Create('Selecione o Modelo!');
    end;

    FDMainDESCRICAO.AsString := edtNome.Text;
    FDMainMODELO.AsInteger := CodigoModelo;
    FDMainDESCMODELO.AsString := DescricaoModelo;
    FDMainSERIE.AsString := Trim(edtSerie.Text);
    FDMainCATEGORIA.AsString := Trim(edtCategoria.Text);
    FDMainDATAENTRADA.AsDateTime := dtEntrada.Date;
    FDMainFABRICANTE.AsInteger := CodigoFabricante;
    FDMainDESCFABRICANTE.AsString := DescricaoFabricante;

    pnlParametrosPesquisa.Visible := True;

    inherited;

    actPesquisar.Execute;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TfrmCadastroEquipamento.AtualizarCampos;
begin
  inherited;

  lblcodigo.Caption := FDMainCHAVEINTERNA.AsString;
  edtNome.Text := FDMainDESCRICAO.AsString;
  edtSerie.Text := FDMainSERIE.AsString;
  edtCategoria.Text := FDMainCATEGORIA.AsString;

  if FDModelos.Locate('CHAVEINTERNA', FDMainMODELO.AsInteger, []) then
  begin
    cobModelo.ItemIndex := FDModelosITEMINDEX.AsInteger;
  end;
end;

procedure TfrmCadastroEquipamento.CarregarListaModelo;
var
  Controller: TControllerBase;
  ItemIndex: Integer;
begin
  try
    Controller := TControllerModelo.Create;
    Controller.BaseURL := EnderecoHost + ':' + Porta.ToString;
    Controller.User := User;
    Controller.Token := Token;
    Controller.Password := Password;
    Controller.TemAutenticacao := TemAutenticacao;
    Controller.CarregarLista('modelo', FDModelos);

    cobModelo.Items.Clear;
    FDModelos.First;
    ItemIndex := 0;
    while not FDModelos.Eof do
    begin
      FDModelos.Edit;
      FDModelosITEMINDEX.AsInteger := ItemIndex;
      FDModelosCAPTION.AsString := FDModelosDESCFABRICANTE.AsString + ' - ' +
        FDModelosDESCRICAO.AsString;
      FDModelos.Post;

      cobModelo.Items.Add(FDModelosCAPTION.AsString);

      FDModelos.Next;

      inc(ItemIndex);
    end;
  finally
    FreeAndNil(Controller);
  end;
end;

procedure TfrmCadastroEquipamento.Devolver(const aChave: Integer; AData: TDateTime);
var
  RetornoJSON: TRetornoJSON;
begin
  try
    try
      RetornoJSON := TControllerEquipamento(FControllerMain).setRegistro(FDMainCHAVEINTERNA.AsInteger, AData, FMetodo, FDMain);

      if RetornoJSON.STATUS <> 200 then
      begin
        ShowMessage(RetornoJSON.MENSAGEM);
      end;
    finally
      FreeAndNil(RetornoJSON);
    end;
  except
    on E: Exception do
    begin
      if FDMain.State = dsEdit then
      begin
        FDMain.Cancel;
      end;

      FDMain.Edit;
      FDMainDATASAIDA.Clear;
      FDMain.Post;

      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TfrmCadastroEquipamento.FormShow(Sender: TObject);
begin
  inherited;
  CarregarListaModelo;
end;

procedure TfrmCadastroEquipamento.getModeloSelecionado(var ACodigo: Integer;
  var ADescricao: String; var ACodigoFabricante: Integer;
  var ADescricaoFabricante: String);
begin
  if cobModelo.ItemIndex >= 0 then
  begin
    if FDModelos.Locate('ITEMINDEX', cobModelo.ItemIndex, []) then
    begin
      ACodigo := FDModelosCHAVEINTERNA.AsInteger;
      ADescricao := FDModelosDESCRICAO.AsString;
      ACodigoFabricante := FDModelosFABRICANTE.AsInteger;
      ADescricaoFabricante := FDModelosDESCFABRICANTE.AsString;
    end;
  end
  else
  begin
    ACodigo := -1;
    ADescricao := EmptyStr;
  end;
end;

procedure TfrmCadastroEquipamento.LimparCampos;
begin
  inherited;

  lblcodigo.Caption := '';
  edtNome.Text := '';
  dtEntrada.DateTime := Date;
  edtSerie.Text := '';
  edtCategoria.Text := '';
  cobModelo.ItemIndex := -1;
end;

function TfrmCadastroEquipamento.UpdateEdit: Boolean;
begin
  Result := (inherited UpdateEdit) and FDMainDATASAIDA.IsNull;
end;

function TfrmCadastroEquipamento.UpdatePesquisar: Boolean;
begin
  Result := UpdateInsert;
end;

end.
