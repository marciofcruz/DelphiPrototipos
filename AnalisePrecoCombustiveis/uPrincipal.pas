unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.Text, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Vcl.Grids, Vcl.DBGrids,
  MFC.CSVtoDataSet, MFC.DM.Analise, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    grpOpcoes: TGroupBox;
    openFile: TOpenTextFileDialog;
    lblEdit: TLabeledEdit;
    btnSelecionarArquivo: TSpeedButton;
    actContainer: TActionList;
    actSelecionarCSV: TAction;
    btnImportarCSV: TSpeedButton;
    actAnalisar: TAction;
    dtsMesAMes: TDataSource;
    pagina: TPageControl;
    tabMediaMesAMes: TTabSheet;
    DBGridMesAMes: TDBGrid;
    tabMediaPorRegiao: TTabSheet;
    DBGridMediaRegiao: TDBGrid;
    dtsMediaPorRegiao: TDataSource;
    tabMediaPorUF: TTabSheet;
    dtsMediaPorUf: TDataSource;
    DBMediaPorUF: TDBGrid;
    sttProcessamento: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    tabMaioresDiferencas: TTabSheet;
    Panel4: TPanel;
    dtsMaioresDiferencas: TDataSource;
    DBMaioresDiferencas: TDBGrid;
    tabCidadeProduto: TTabSheet;
    dtsCidadeProduto: TDataSource;
    Panel5: TPanel;
    DBGrid1: TDBGrid;
    tabCidade: TTabSheet;
    dtsCidade: TDataSource;
    Panel6: TPanel;
    DBGrid2: TDBGrid;
    procedure actSelecionarCSVExecute(Sender: TObject);
    procedure actAnalisarUpdate(Sender: TObject);
    procedure actAnalisarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCSVToDataSet: TCSVToDataSet;
    DMAnalise: TDMAnalise;
  public
  end;

var
  Form1: TForm1;

implementation

uses
  System.Diagnostics;

{$R *.dfm}

procedure TForm1.actAnalisarExecute(Sender: TObject);
var
  stop: TStopWatch;
begin
  try
    stop := TStopwatch.Create;

    stop.Start;

    btnImportarCSV.Enabled := False;

    dtsMesAMes.DataSet := nil;
    dtsMediaPorRegiao.DataSet := nil;
    dtsMediaPorUf.DataSet := nil;
    dtsMaioresDiferencas.DataSet := nil;
    dtsCidadeProduto.DataSet := nil;
    dtsCidade.DataSet := nil;

    DMAnalise.FDMediaPorCidade.DisableControls;
    DMAnalise.FDCidadeProduto.DisableControls;
    DMAnalise.FDMediaPorRegiao.DisableControls;
    DMAnalise.FDMediaPorUF.DisableControls;
    DMAnalise.FDDiferencaPreco.DisableControls;
    DMAnalise.FDCidade.DisableControls;

    DMAnalise.Reset;

    FCSVToDataSet.carregarDataSet(lblEdit.Text);

    DMAnalise.Analisar(FCSVToDataSet.MemTable);

    sttProcessamento.Panels[1].Text := 'Qtd. Amostras: '+FCSVToDataSet.MemTable.RecordCount.ToString;

    stop.Stop;

    sttProcessamento.Panels[0].Text := 'Analisado em: '+stop.ElapsedMilliseconds.ToString+' milsecs';
  finally
    DMAnalise.FDCidadeProduto.EnableControls;
    DMAnalise.FDMediaPorCidade.EnableControls;
    DMAnalise.FDMediaPorRegiao.EnableControls;
    DMAnalise.FDMediaPorUF.EnableControls;
    DMAnalise.FDDiferencaPreco.EnableControls;
    DMAnalise.FDCidade.EnableControls;

    dtsMesAMes.DataSet := DMAnalise.FDMediaPorCidade;
    dtsMediaPorRegiao.DataSet := DMAnalise.FDMediaPorRegiao;
    dtsMediaPorUf.DataSet := DMAnalise.FDMediaPorUF;
    dtsMaioresDiferencas.DataSet := DMAnalise.FDDiferencaPreco;
    dtsCidadeProduto.DataSet := DMAnalise.FDCidadeProduto;
    dtsCidade.DataSet := DMAnalise.FDCidade;

    btnImportarCSV.Enabled := True;
  end;
end;

procedure TForm1.actAnalisarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Trim(lblEdit.Text)<>'';
end;

procedure TForm1.actSelecionarCSVExecute(Sender: TObject);
begin
  openFile.InitialDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

  if openFile.Execute then
  begin
    DMAnalise.Reset;
    lblEdit.Text := openFile.FileName;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FCSVToDataSet := TCSVToDataSet.Create(Self);
  DMAnalise := TDMAnalise.Create(Self);

  lblEdit.Text := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'SEMANAL_MUNICIPIOS-2019.csv';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DMAnalise);
  FreeAndNil(FCSVToDataSet);
end;

end.
