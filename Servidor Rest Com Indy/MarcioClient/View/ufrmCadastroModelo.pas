unit ufrmCadastroModelo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmCadastroBase, Vcl.ComCtrls, Data.DB,
  System.Generics.Collections, System.Actions, Vcl.ActnList, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Response.Adapter,
  Entidade.Base, Entidade.Modelo,
  Vcl.DBCtrls;

type
  TfrmCadastroModelo = class(TfrmCadastroBase)
    FDMainDESCRICAO: TStringField;
    FDMainFABRICANTE: TIntegerField;
    FDMainDESCFABRICANTE: TStringField;
    StaticText3: TStaticText;
    edtModelo: TEdit;
    FDFabricantes: TFDMemTable;
    FDFabricantesCHAVEINTERNA: TIntegerField;
    FDFabricantesEXCLUIDO: TIntegerField;
    FDFabricantesDESCRICAO: TStringField;
    FDFabricantesREVISAO: TIntegerField;
    FDFabricantesALTERADO: TIntegerField;
    dtsFabricantes: TDataSource;
    cobFabricante: TComboBoxEx;
    FDFabricantesITEMINDEX: TIntegerField;
    StaticText2: TStaticText;
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure getFabricanteSelecionado(var ACodigo: Integer;
      var ADescricao: String);
    procedure CarregarListaFabricante;
  protected
    procedure AtualizarCampos; override;
    procedure LimparCampos; override;
  end;

implementation

uses
  MarcioClient.CController.Base,
  MarcioClient.CController.Modelo,
  MarcioClient.CController.Fabricante;

{$R *.dfm}

procedure TfrmCadastroModelo.actEditarExecute(Sender: TObject);
begin
  inherited;

  edtModelo.SetFocus;
end;

procedure TfrmCadastroModelo.actNovoExecute(Sender: TObject);
begin
  inherited;
  edtModelo.SetFocus;
end;

procedure TfrmCadastroModelo.actSalvarExecute(Sender: TObject);
var
  CodigoFabricante: Integer;
  DescricaoFabricante: String;
begin
  try
    edtModelo.Text := Trim(edtModelo.Text);

    if edtModelo.Text = '' then
    begin
      raise Exception.Create('Digite um nome de Modelo!');
    end;

    getFabricanteSelecionado(CodigoFabricante, DescricaoFabricante);

    if CodigoFabricante = -1 then
    begin
      raise Exception.Create('Selecione o Fabricante!');
    end;

    FDMainDESCRICAO.AsString := edtModelo.Text;
    FDMainFABRICANTE.AsInteger := CodigoFabricante;
    FDMainDESCFABRICANTE.AsString := DescricaoFabricante;

    inherited;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TfrmCadastroModelo.AtualizarCampos;
begin
  inherited;

  lblCodigo.Caption := FDMainCHAVEINTERNA.AsString;
  edtModelo.Text := FDMainDESCRICAO.AsString;

  if FDFabricantes.Locate('CHAVEINTERNA', FDMainFABRICANTE.AsInteger, []) then
  begin
    cobFabricante.ItemIndex := FDFabricantesITEMINDEX.AsInteger;
  end;
end;

procedure TfrmCadastroModelo.CarregarListaFabricante;
var
  ControllerFabricante: TControllerBase;
  ItemIndex: Integer;
begin
  try
    ControllerFabricante := TControllerFabricante.Create;
    ControllerFabricante.BaseURL := EnderecoHost + ':' + Porta.ToString;
    ControllerFabricante.User := User;
    ControllerFabricante.Password := Password;
    ControllerFabricante.Token := Token;
    ControllerFabricante.TemAutenticacao := TemAutenticacao;
    ControllerFabricante.CarregarLista('fabricante', FDFabricantes);

    cobFabricante.Items.Clear;
    FDFabricantes.First;
    ItemIndex := 0;
    while not FDFabricantes.Eof do
    begin
      cobFabricante.Items.Add(FDFabricantesDESCRICAO.AsString);

      FDFabricantes.Edit;
      FDFabricantesITEMINDEX.AsInteger := ItemIndex;
      FDFabricantes.Post;

      FDFabricantes.Next;

      inc(ItemIndex);
    end;
  finally
    FreeAndNil(ControllerFabricante);
  end;
end;

procedure TfrmCadastroModelo.FormCreate(Sender: TObject);
begin
  inherited;

  FMetodo := 'modelo';

  FControllerMain := TControllerModelo.Create;
end;

procedure TfrmCadastroModelo.FormShow(Sender: TObject);
begin
  inherited;
  CarregarListaFabricante;
end;

procedure TfrmCadastroModelo.getFabricanteSelecionado(var ACodigo: Integer;
  var ADescricao: String);
begin
  if cobFabricante.ItemIndex >= 0 then
  begin
    if FDFabricantes.Locate('ITEMINDEX', cobFabricante.ItemIndex, []) then
    begin
      ACodigo := FDFabricantesCHAVEINTERNA.AsInteger;
      ADescricao := FDFabricantesDESCRICAO.AsString;
    end;
  end
  else
  begin
    ACodigo := -1;
    ADescricao := EmptyStr;
  end;
end;

procedure TfrmCadastroModelo.LimparCampos;
begin
  inherited;

  lblCodigo.Caption := '';
  edtModelo.Text := '';
  cobFabricante.ItemIndex := -1;
end;

end.
