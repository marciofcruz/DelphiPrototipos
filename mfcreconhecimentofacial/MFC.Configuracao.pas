unit MFC.Configuracao;

interface

uses
  IniFiles, Forms, Dialogs, SysUtils, MFC.Modelo.Tipos;

type
  TConfiguracao = class(TObject)
  private
    FPathConfiguracao: String;
    FPathAplicacao: String;
    FIniFile: TIniFile;
    FPathCascadeXML: String;

    function getNomeXMLCascade: String;
    procedure setNomeXMLCascade(const AValue: String);

    function getNomeDispositivoVideo: String;
    procedure setNomeDispositivoVideo(const Value: String);
    function getFacesPorEntidade: Integer;
    procedure setFacesPorEntidade(const Value: Integer);

    procedure SetComponentesFischerFace(const Value: Integer);
    procedure SetThreSholdFischerFace(const Value: Double);
    function getComponentesFischerFace: Integer;
    function getThreSholdFischerFace: Double;

    function getThreSholdLBPH: Double;
    procedure setThreSholdLBPH(const Value: Double);

    function getComponentesEigenFace: Integer;
    procedure SetComponentesEigenFace(const Value: Integer);

    function getThreSholdEigenFace: Double;
    procedure SetThreSholdEigenFace(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;

    function getConfigSqlServer:TConfigSQLServer;

    procedure setConfigSql(AConfigSQLServer: TConfigSQLServer);

    property PathConfiguracao: String read FPathConfiguracao;

    property PathAplicacao: String read FPathAplicacao;
    property PathCascadeXML: String read FPathCascadeXML;

    property NomeXMLCascade: String read getNomeXMLCascade write setNomeXMLCascade;
    property NomeDispositivoVideo: String read getNomeDispositivoVideo write setNomeDispositivoVideo;
    property FacesPorEntidade: Integer read getFacesPorEntidade write setFacesPorEntidade;

    property ComponentesFischerFace: Integer read getComponentesFischerFace write SetComponentesFischerFace;
    property ThreSholdFischerFace: Double read getThreSholdFischerFace write SetThreSholdFischerFace;

    property ComponentesEigenFace: Integer read getComponentesEigenFace write SetComponentesEigenFace;
    property ThreSholdEigenFace: Double read getThreSholdEigenFace write SetThreSholdEigenFace;

    property ThreSholdLBPH: Double read getThreSholdLBPH write setThreSholdLBPH;
  end;

implementation

uses
  IOUtils;

constructor TConfiguracao.Create;
begin
  inherited;

  FPathAplicacao := ExtractFilePath(Application.ExeName);

  FIniFile := nil;
  FPathConfiguracao :=
    IncludeTrailingPathDelimiter(TDirectory.GetParent(ExcludeTrailingPathDelimiter(FPathAplicacao)))+'CONFIG';

  FPathCascadeXML := IncludeTrailingPathDelimiter(TDirectory.GetParent(ExcludeTrailingPathDelimiter(FPathAplicacao)))+
  'resource\facedetectxml\';

  if ForceDirectories(FPathConfiguracao) then
  begin
    FIniFile := TIniFile.Create(FPathConfiguracao+'\MFCReconhecimentoFacial.ini');
  end
  else
  begin
    raise Exception.Create('Não foi possível criar o diretório: '+FPathConfiguracao);
  end;
end;

destructor TConfiguracao.Destroy;
begin
  FreeAndNil(FIniFile);

  inherited;
end;

function TConfiguracao.getComponentesEigenFace: Integer;
begin
  Result := FIniFile.ReadInteger('EigenFace', 'Componentes', 20);
end;

function TConfiguracao.getComponentesFischerFace: Integer;
begin
  Result := FIniFile.ReadInteger('FischerFace', 'Componentes', 10);
end;

function TConfiguracao.getConfigSqlServer: TConfigSQLServer;
begin
  Result.Host := FIniFile.ReadString('SqlServer', 'Host', '');
  Result.Banco := FIniFile.ReadString('SqlServer', 'Banco', '');
  Result.Usuario := FIniFile.ReadString('SqlServer', 'Usuario', '');
  Result.Senha := FIniFile.ReadString('SqlServer', 'Senha', '');
end;

function TConfiguracao.getFacesPorEntidade: Integer;
begin
  Result := FIniFile.ReadInteger('Video', 'FacesPorEntidade', 12);
end;

function TConfiguracao.getNomeDispositivoVideo: String;
begin
  Result := FIniFile.ReadString('Video', 'Dispositivo', '');
end;

function TConfiguracao.getNomeXMLCascade: String;
begin
  Result := FIniFile.ReadString('Cascade', 'XML', '');
end;

function TConfiguracao.getThreSholdEigenFace: Double;
begin
  Result := FIniFile.ReadFloat('EigenFace', 'ThreShold', 0);
end;

function TConfiguracao.getThreSholdFischerFace: Double;
begin
  Result := FIniFile.ReadFloat('FischerFace', 'ThreShold', 0);
end;

function TConfiguracao.getThreSholdLBPH: Double;
begin
  Result := FIniFile.ReadFloat('LBPH', 'ThreShold', 0);
end;

procedure TConfiguracao.SetComponentesEigenFace(const Value: Integer);
begin
  FIniFile.WriteInteger('EigenFace', 'Componentes', Value);
end;

procedure TConfiguracao.SetComponentesFischerFace(const Value: Integer);
begin
  FIniFile.WriteInteger('FischerFace', 'Componentes', Value);
end;

procedure TConfiguracao.setConfigSql(AConfigSQLServer: TConfigSQLServer);
begin
  FIniFile.WriteString('SqlServer', 'Host', AConfigSQLServer.Host);
  FIniFile.WriteString('SqlServer', 'Banco', AConfigSQLServer.Banco);
  FIniFile.WriteString('SqlServer', 'Usuario', AConfigSQLServer.Usuario);
  FIniFile.WriteString('SqlServer', 'Senha', AConfigSQLServer.Senha);
  FIniFile.UpdateFile;
end;

procedure TConfiguracao.setFacesPorEntidade(const Value: Integer);
begin
  FIniFile.WriteInteger('Video', 'FacesPorEntidade', Value);
end;

procedure TConfiguracao.setNomeDispositivoVideo(const Value: String);
begin
  FIniFile.WriteString('Video', 'Dispositivo', Value);
  FIniFile.UpdateFile;
end;

procedure TConfiguracao.setNomeXMLCascade(const AValue: String);
begin
  FIniFile.WriteString('Cascade', 'XML', AValue);
  FIniFile.UpdateFile;
end;

procedure TConfiguracao.SetThreSholdEigenFace(const Value: Double);
begin
  FIniFile.WriteFloat('EigenFace', 'ThreShold', Value);
end;

procedure TConfiguracao.SetThreSholdFischerFace(const Value: Double);
begin
  FIniFile.WriteFloat('FischerFace', 'ThreShold', Value);
end;

procedure TConfiguracao.setThreSholdLBPH(const Value: Double);
begin
  FIniFile.WriteFloat('LBPH', 'ThreShold', Value);
end;

end.
