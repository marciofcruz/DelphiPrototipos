unit RaptorWS.ServerUtils;

interface

Uses
  System.Classes,
  RaptorWS.SysTypes, System.SysUtils, RegularExpressions, REST.JSon, System.JSON, IdURI, IdGlobal;

type
  (* rotinas diversas *)
  TServerUtils = class
    class function Result2JSON(AStatus: Integer; const AMensagem: String): String;

    class function ReturnMethodNotFound:String;
    class function getMensagemJsonObject(AStatus: Integer; const AMensagem: String):TJSONObject;

  end;

  (* Parametros do Servidor *)
  TServerParams = class
  private
    fUsername: string;
    fPassword: String;
    fHasAuthenticacion: Boolean;
    function GetUserName: String;
    function GetPassword: String;
    function GetHasAuthentication: Boolean;
  Public
    property HasAuthentication: Boolean read GetHasAuthentication
      write fHasAuthenticacion;
    property UserName: string read GetUserName write fUsername;
    property Password: string read GetPassword write fPassword;

    constructor Create; overload;
  end;

implementation

class function TServerUtils.getMensagemJsonObject(AStatus: Integer; const AMensagem: String):TJsonObject;
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

  //Result := TJSONObject.Create;
  //Result.AddPair(TJSONPair.Create('STATUS', AStatus.ToString));
  //Result.AddPair(TJSONPair.Create('MENSAGEM', TJSONString.Create(AMensagem)));
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

    Result := TJSON.ObjectToJsonString(RetornoJSON);
  finally
    FreeAndNil(RetornoJSON);
  end;


  (*SB := TStringBuilder.Create();
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

constructor TServerParams.Create;
begin
  HasAuthentication := False;
end;

function TServerParams.GetUserName: String;
begin
  Result := fUsername;
end;

function TServerParams.GetPassword: String;
begin
  Result := fPassword;
end;

function TServerParams.GetHasAuthentication: Boolean;
Begin
  Result := fHasAuthenticacion;
End;

end.
