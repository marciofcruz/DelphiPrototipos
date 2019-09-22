unit MFC.CSVtoDataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.Text, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Vcl.Grids, Vcl.DBGrids;

type
  TCSVToDataSet = class(TObject)
  private
    FMemTable: TFDMemTable;
    FFDBatchMoveTextReader: TFDBatchMoveTextReader;
    FFDBatchMoveDataSetWriter: TFDBatchMoveDataSetWriter;
    FFDGUIxWaitCursor: TFDGUIxWaitCursor;
    FFDBatchMove: TFDBatchMove;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;

    procedure carregarDataSet(const aCSV: String);

    property MemTable: TFDMemTable read FMemTable write FMemTable;
  end;

implementation

{ TCSVToDataSet }

procedure TCSVToDataSet.carregarDataSet(const aCSV: String);
begin
  if not FileExists(aCSV) then
  begin
    raise Exception.Create('Arquivo '+aCSV+' não encontrado!');
  end;

  FMemTable.Close;

  FFDBatchMoveTextReader.FileName := aCSV;
  FFDBatchMove.Execute;
end;

constructor TCSVToDataSet.Create(AOwner: TComponent);
begin
  inherited Create;

  FMemTable := TFDMemTable.Create(AOwner);
  FMemTable.FetchOptions.AssignedValues := [evMode];
  FMemTable.FetchOptions.Mode := fmAll;
  FMemTable.ResourceOptions.AssignedValues := [rvSilentMode];
  FMemTable.ResourceOptions.SilentMode := True;
  FMemTable.UpdateOptions.AssignedValues := [uvCheckRequired, uvAutoCommitUpdates];
  FMemTable.UpdateOptions.CheckRequired := False;
  FMemTable.UpdateOptions.AutoCommitUpdates := True;

  FFDBatchMoveTextReader := TFDBatchMoveTextReader.Create(AOwner);
  FFDBatchMoveTextReader.Encoding := ecUTF8;

  FFDBatchMoveDataSetWriter := TFDBatchMoveDataSetWriter.Create(AOwner);
  FFDBatchMoveDataSetWriter.DataSet := FMemTable;

  FFDGUIxWaitCursor := TFDGUIxWaitCursor.Create(AOwner);
  FFDGUIxWaitCursor.Provider := 'Forms';
  FFDGUIxWaitCursor.ScreenCursor := gcrAppWait;

  FFDBatchMove := TFDBatchMove.Create(AOwner);
  FFDBatchMove.Reader := FFDBatchMoveTextReader;
  FFDBatchMove.Writer := FFDBatchMoveDataSetWriter;
  FFDBatchMove.CommitCount := 500;
  FFDBatchMove.Analyze := [taHeader, taFields];
end;

destructor TCSVToDataSet.Destroy;
begin
  FreeAndNil(FFDBatchMoveTextReader);
  FreeAndNil(FFDBatchMoveDataSetWriter);
  FreeAndNil(FFDGUIxWaitCursor);
  FreeAndNil(FFDBatchMove);
  FreeAndNil(FMemTable);

  inherited;
end;

end.
