unit uFrmCadastroFabricante;

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
  Entidade.Base, Entidade.Fabricante,
  MarcioClient.CController.Fabricante;

type
  TfrmCadastroFabricante = class(TfrmCadastroBase)
    FDMainDESCRICAO: TStringField;
    edtNome: TEdit;
    StaticText3: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
  private
  protected
    procedure AtualizarCampos; override;
    procedure LimparCampos; override;
  public
  end;

implementation

{$R *.dfm}

procedure TfrmCadastroFabricante.actEditarExecute(Sender: TObject);
begin
  inherited;

  edtNome.SetFocus;
end;

procedure TfrmCadastroFabricante.actNovoExecute(Sender: TObject);
begin
  inherited;

  edtNome.SetFocus;
end;

procedure TfrmCadastroFabricante.actSalvarExecute(Sender: TObject);
begin
  edtNome.Text := Trim(edtNome.Text);

  if edtNome.Text = '' then
  begin
    raise Exception.Create('Digite um nome!');
  end;

  FDMainDESCRICAO.AsString := edtNome.Text;

  inherited;
end;

procedure TfrmCadastroFabricante.FormCreate(Sender: TObject);
begin
  inherited;

  FMetodo := 'fabricante';

  FControllerMain := TControllerFabricante.Create;
end;

procedure TfrmCadastroFabricante.LimparCampos;
begin
  lblCodigo.Caption := '';
  edtNome.Text := '';
end;

procedure TfrmCadastroFabricante.AtualizarCampos;
begin
  lblCodigo.Caption := FDMainCHAVEINTERNA.AsString;
  edtNome.Text := FDMainDESCRICAO.AsString;
end;

end.
