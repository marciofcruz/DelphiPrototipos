unit Toviasur.Comuns;

interface

uses
  System.Classes,
  System.SysUtils,
  System.RTTI,
  RegularExpressions,
  REST.JSon,
  System.JSon,
  IdURI,
  IdGlobal;

type
  TRetornoJSON = class
    FStatus: Integer;
    FMensagem: String;
  public
    property STATUS: Integer read FStatus write FStatus;
    property MENSAGEM: String read FMensagem write FMensagem;
  end;

  TTVSVerbosHTTP = (verboGET, verboPOST, verboPUT, verboDELETE, berboHEAD, verboOPTIONS, verboPATCH, verboTRACE);
  TMVCSetVerbosHTTP = set of TTVSVerbosHTTP;

  TVSPathAttribute = class(TCustomAttribute)
  private
    FURI: string;
    FTVSVerbosHTTP: TMVCSetVerbosHTTP;
  public
    constructor Create(const AURI: string; const AMVCHTTPMethods: TMVCSetVerbosHTTP); overload;
    function getTVSVerbosHTTPStr: string;

    property URI: string read FURI;
    property TVCVerbosHTTP: TMVCSetVerbosHTTP read FTVSVerbosHTTP write FTVSVerbosHTTP;
  end;

  TServerUtils = class
    class function Result2JSON(AStatus: Integer;
      const AMensagem: String): String;

    class function ReturnMethodNotFound: String;
    class function getMensagemJsonObject(AStatus: Integer;
      const AMensagem: String): TJSONObject;
  end;

type
  TVSController = class(TCustomAttribute);
  TTVSClasseAtributo = class of TCustomAttribute;

type
  TTVSAtributos = class
  public
    class function TemAtributo(AClasseVerificacao: TClass; AClasseAtributo: TTVSClasseAtributo): Boolean; overload;
    class function TemAtributo(aMetodo: TRttiMethod; AClasseAtributo: TTVSClasseAtributo; var RetornaAtributo: TCustomAttribute):Boolean; overload;
  end;


implementation

uses
  System.TypInfo;

class function TServerUtils.getMensagemJsonObject(AStatus: Integer;
  const AMensagem: String): TJSONObject;
var
  Auxiliar: String;
  RetornoJSON: TRetornoJSON;
begin
  Auxiliar := TServerUtils.Result2JSON(AStatus, AMensagem);

  RetornoJSON := TRetornoJSON.Create;
  try
    RetornoJSON.STATUS := AStatus;
    RetornoJSON.MENSAGEM := Trim(AMensagem);

    Result := TJson.ObjectToJsonObject(RetornoJSON);
  finally
    FreeAndNil(RetornoJSON);

  end;

  // Result := TJSONObject.Create;
  // Result.AddPair(TJSONPair.Create('STATUS', AStatus.ToString));
  // Result.AddPair(TJSONPair.Create('MENSAGEM', TJSONString.Create(AMensagem)));
end;

class function TServerUtils.Result2JSON(AStatus: Integer;
  const AMensagem: String): String;
var
  RetornoJSON: TRetornoJSON;
  SB: TStringBuilder;
begin
  try
    RetornoJSON := TRetornoJSON.Create;
    RetornoJSON.STATUS := AStatus;
    RetornoJSON.MENSAGEM := AMensagem;

    Result := TJson.ObjectToJsonString(RetornoJSON);
  finally
    FreeAndNil(RetornoJSON);
  end;

  (* SB := TStringBuilder.Create();
    SB.Append('{');
    SB.Append('"STATUS":"' + IntToStr(AStatus) + '"');
    SB.Append(',"MENSAGEM":"' + AMensagem+ '"');
    SB.Append('}');

    Result := SB.ToString;
    SB.Free; *)
end;

class function TServerUtils.ReturnMethodNotFound: String;
begin
  Result := TServerUtils.Result2JSON(404, 'Método não encontrado');
end;

{ TTVSAtributos }

class function TTVSAtributos.TemAtributo( AClasseVerificacao: TClass;
                                          AClasseAtributo: TTVSClasseAtributo): Boolean;
var
  context: TRttiContext;
  listaAtributos: TArray<TCustomAttribute>;
  atributo: TCustomAttribute;
begin
  Result := False;

  listaAtributos := context.GetType(AClasseVerificacao).GetAttributes;

  for atributo in listaAtributos do
  begin
    if atributo.InheritsFrom(AClasseAtributo) then
    begin
      Result := True;
      break;
    end;
  end;
end;

class function TTVSAtributos.TemAtributo(aMetodo: TRttiMethod;
  AClasseAtributo: TTVSClasseAtributo; var RetornaAtributo: TCustomAttribute): Boolean;
var
  atributos: TArray<TCustomAttribute>;
  Atributo: TCustomAttribute;

begin
  Result := False;
  RetornaAtributo := nil;

  atributos := aMetodo.GetAttributes;

  for atributo in atributos do
  begin
    if atributo.InheritsFrom(AClasseAtributo) then
    begin
      RetornaAtributo := atributo;
      Result := True;
      break;
    end;
  end;
end;

constructor TVSPathAttribute.Create(const AURI: string; const AMVCHTTPMethods: TMVCSetVerbosHTTP);
begin
  inherited Create;

  FTVSVerbosHTTP := AMVCHTTPMethods;
  FURI := AURI;
end;

function TVSPathAttribute.getTVSVerbosHTTPStr: string;
var
  I: TTVSVerbosHTTP;
begin
  Result := '';

  for I := low(TTVSVerbosHTTP) to high(TTVSVerbosHTTP) do
  begin
    if I in FTVSVerbosHTTP then
    begin
      Result := Result + ',' + GetEnumName(TypeInfo(TTVSVerbosHTTP), Ord(I));
    end;
  end;

  if Result <> EmptyStr then
  begin
    Result := Result.Remove(0, 1);
  end
  else
  begin
    Result := 'any';
  end;
end;

end.
