unit MarcioServer.Model.DMBase;

interface

uses
  Forms,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Toviasur.HandleContext,
  Winapi.Windows,
  System.JSON;

type
  TMetodoJSONObject = reference to function:TJSONObject;

  TDMBase = class(TDataModule)
    FDConexao: TFDConnection;
    FDCriarEsquema: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  protected
    function Processar(AMetodo: TMetodoJSONObject): TJSONObject;
  public
  end;

var
  NegocioCriticalSection: TRTLCriticalSection;

implementation

{$R *.dfm}

function TDMBase.Processar(AMetodo: TMetodoJSONObject): TJSONObject;
begin
  try
    EnterCriticalSection(NegocioCriticalSection);
    FDConexao.Open;

    Result := AMetodo;
  finally
    FDConexao.Close;
    LeaveCriticalSection(NegocioCriticalSection);
  end;
end;

procedure TDMBase.DataModuleCreate(Sender: TObject);
begin
  FDConexao.Params.Database := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'banco\Marcio.db';
end;

initialization
  InitializeCriticalSection(NegocioCriticalSection);

finalization
  DeleteCriticalSection(NegocioCriticalSection);


end.
