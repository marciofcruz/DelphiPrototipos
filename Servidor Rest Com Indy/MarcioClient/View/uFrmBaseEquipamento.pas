unit uFrmBaseEquipamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmCadastroBase, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.WinXPickers,
  Comum.Pesquisa.Equipamento;

type
  TfrmBaseEquipamento = class(TfrmCadastroBase)
    FDMainDESCRICAO: TStringField;
    FDMainSERIE: TStringField;
    FDMainCATEGORIA: TStringField;
    FDMainDATAENTRADA: TDateTimeField;
    FDMainDATASAIDA: TDateTimeField;
    FDMainMODELO: TIntegerField;
    FDMainDESCMODELO: TStringField;
    FDMainFABRICANTE: TIntegerField;
    FDMainDESCFABRICANTE: TStringField;
    pnlParametrosPesquisa: TPanel;
    grbParametrosPesquisa: TGroupBox;
    ckbPesquisarDataEntrada: TCheckBox;
    cobOpcoesDataEntrada: TComboBox;
    dtEntradaInicial: TDateTimePicker;
    dtEntradaFinal: TDateTimePicker;
    ckbPesquisarDataSaida: TCheckBox;
    cobOpcoesDataSaida: TComboBox;
    dtSaidaInicial: TDateTimePicker;
    dtSaidaFinal: TDateTimePicker;
    cobLocalizacao: TComboBox;
    Label1: TLabel;
    ckbProcurarNomeEquipamento: TCheckBox;
    edtProcurarDescricao: TEdit;
    actPesquisar: TAction;
    btnPesquisar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ckbPesquisarDataEntradaClick(Sender: TObject);
    procedure cobOpcoesDataEntradaChange(Sender: TObject);
    procedure ckbPesquisarDataSaidaClick(Sender: TObject);
    procedure cobOpcoesDataSaidaChange(Sender: TObject);
    procedure ckbProcurarNomeEquipamentoClick(Sender: TObject);
    procedure actPesquisarUpdate(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
  private
  protected
    function UpdatePesquisar:Boolean; virtual; abstract;
  end;

implementation

uses
  MarcioClient.CController.Equipamento, DateUtils;

{$R *.dfm}

procedure TfrmBaseEquipamento.ckbProcurarNomeEquipamentoClick(Sender: TObject);
begin
  inherited;
  edtProcurarDescricao.Enabled := ckbProcurarNomeEquipamento.Checked;
end;

procedure TfrmBaseEquipamento.actPesquisarExecute(Sender: TObject);
begin
  inherited;
  try
    TControllerEquipamento(FControllerMain).ParametrosPesquisa.DataEntrada.Ativo := ckbPesquisarDataEntrada.Checked;
    TControllerEquipamento(FControllerMain).ParametrosPesquisa.DataEntrada.DTInicial := dtEntradaInicial.DateTime;
    TControllerEquipamento(FControllerMain).ParametrosPesquisa.DataEntrada.DTFinal := dtEntradaFinal.DateTime;
    TControllerEquipamento(FControllerMain).ParametrosPesquisa.DataEntrada.TipoPesquisa := cobOpcoesDataEntrada.Items[cobOpcoesDataEntrada.ItemIndex];

    TControllerEquipamento(FControllerMain).ParametrosPesquisa.DataSaida.Ativo := ckbPesquisarDataSaida.Checked;
    TControllerEquipamento(FControllerMain).ParametrosPesquisa.DataSaida.DTInicial := dtSaidaInicial.DateTime;
    TControllerEquipamento(FControllerMain).ParametrosPesquisa.DataSaida.DTFinal := dtSaidaFinal.DateTime;
    TControllerEquipamento(FControllerMain).ParametrosPesquisa.DataSaida.TipoPesquisa := cobOpcoesDataSaida.Items[cobOpcoesDataSaida.ItemIndex];

    TControllerEquipamento(FControllerMain).ParametrosPesquisa.Localizacao := cobLocalizacao.Items[cobLocalizacao.ItemIndex];

    TControllerEquipamento(FControllerMain).ParametrosPesquisa.PesquisaDescricao.Ativo := ckbProcurarNomeEquipamento.Checked;
    TControllerEquipamento(FControllerMain).ParametrosPesquisa.PesquisaDescricao.Descricao := edtProcurarDescricao.Text;

    TControllerEquipamento(FControllerMain).CarregarLista(FMetodo, FDMain);
  finally
  end;
end;

procedure TfrmBaseEquipamento.actPesquisarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := UpdatePesquisar;
end;

procedure TfrmBaseEquipamento.ckbPesquisarDataEntradaClick(
  Sender: TObject);
begin
  inherited;

  cobOpcoesDataEntrada.Enabled := ckbPesquisarDataEntrada.Checked;
  dtEntradaInicial.Enabled := ckbPesquisarDataEntrada.Checked;
  cobOpcoesDataEntradaChange(cobOpcoesDataEntrada);
end;

procedure TfrmBaseEquipamento.ckbPesquisarDataSaidaClick(
  Sender: TObject);
begin
  inherited;

  cobOpcoesDataSaida.Enabled := ckbPesquisarDataSaida.Checked;
  dtSaidaInicial.Enabled := ckbPesquisarDataSaida.Checked;
  cobOpcoesDataSaidaChange(cobOpcoesDataSaida);
end;

procedure TfrmBaseEquipamento.cobOpcoesDataEntradaChange(
  Sender: TObject);
begin
  inherited;

  dtEntradaFinal.Enabled := TComboBox(Sender).ItemIndex=3;
end;

procedure TfrmBaseEquipamento.cobOpcoesDataSaidaChange(Sender: TObject);
begin
  inherited;

  dtSaidaFinal.Enabled := TComboBox(Sender).ItemIndex=3;
end;

procedure TfrmBaseEquipamento.FormCreate(Sender: TObject);
begin
  inherited;

  FCarregarListaInicializacao := False;

  FMetodo := 'equipamento';

  FControllerMain := TControllerEquipamento.Create;

  ckbProcurarNomeEquipamento.Checked := False;
  edtProcurarDescricao.Text := '';

  cobLocalizacao.ItemIndex := 0;

  ckbPesquisarDataEntrada.Checked := False;
  cobOpcoesDataEntrada.ItemIndex := 1;
  cobOpcoesDataEntrada.Enabled := False;
  dtEntradaInicial.Enabled := False;
  dtEntradaFinal.Enabled := False;

  dtEntradaInicial.DateTime := StartOfTheYear(now);
  dtEntradaFinal.DateTime := date;

  ckbPesquisarDataSaida.Checked := False;
  cobOpcoesDataSaida.ItemIndex := 1;
  cobOpcoesDataSaida.Enabled := False;
  dtSaidaInicial.Enabled := False;
  dtSaidaFinal.Enabled := False;

  dtSaidaInicial.DateTime := StartOfTheYear(now);
  dtSaidaFinal.DateTime := date;
end;

end.
