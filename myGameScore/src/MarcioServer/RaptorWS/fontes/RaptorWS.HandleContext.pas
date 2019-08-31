unit RaptorWS.HandleContext;

interface

Uses
  System.SysUtils, System.Variants, System.Classes, Winapi.Windows,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer, IdContext, RaptorWS.ServerUtils, RaptorWS.Systypes,
  MarcioServer.RaptorWS.Proxy, Dialogs;

type
  TServerContext = class(TIdServerContext)
  Private
    function CallGETServerMethod(ARequestInfo: TIdHTTPRequestInfo): string;
    function CallPOSTServerMethod(ARequestInfo: TIdHTTPRequestInfo): string;
    function CallPUTServerMethod(ARequestInfo: TIdHTTPRequestInfo): string;
    function CallDELETEServerMethod(ARequestInfo: TIdHTTPRequestInfo): string;
  public
    // Dispara (Dispatch) os vários ServerMethods
    Function HandleRequest(aRequestInfo: TIdHTTPRequestInfo; aResponseInfo: TIdHTTPResponseInfo; Const aCmd: String): string;
  end;

implementation

Function TServerContext.HandleRequest(aRequestInfo: TIdHTTPRequestInfo;
  aResponseInfo: TIdHTTPResponseInfo; Const aCmd: String): String;
begin
  Result := '';

  If UpperCase(Copy(aCmd, 1, 3)) = 'GET' Then
  begin
    Result := CallGETServerMethod(aRequestInfo);
  end
  else If UpperCase(Copy(aCmd, 1, 4)) = 'POST' Then
  begin
    Result := CallPOSTServerMethod(aRequestInfo);
  end
  else if UpperCase(Copy(aCmd, 1, 3)) = 'PUT' Then
  begin
    Result := CallPUTServerMethod(aRequestInfo);
  end
  else If UpperCase(Copy(aCmd, 1, 6)) = 'DELETE' Then
  begin
    Result := CallDELETEServerMethod(aRequestInfo);
  end;
end;

function TServerContext.CallGETServerMethod(ARequestInfo: TIdHTTPRequestInfo): string;
begin
  if Assigned(ProxyRaptor.OnGet) then
  begin
    Result := ProxyRaptor.OnGet(ARequestInfo);
  end
  else
  begin
    Result := TServerUtils.ReturnMethodNotFound;
  end;
end;

function TServerContext.CallPOSTServerMethod(ARequestInfo: TIdHTTPRequestInfo): string;
begin
  if Assigned(ProxyRaptor.OnPost) then
  begin
    Result := ProxyRaptor.OnPost(ARequestInfo);
  end
  else
  begin
    Result := TServerUtils.ReturnMethodNotFound;
  end;
end;

function TServerContext.CallPUTServerMethod(ARequestInfo: TIdHTTPRequestInfo): string;
begin
  if Assigned(ProxyRaptor.OnPut) then
  begin
    Result := ProxyRaptor.OnPut(ARequestInfo);
  end
  else
  begin
    Result := TServerUtils.ReturnMethodNotFound;
  end;
end;

function TServerContext.CallDELETEServerMethod(ARequestInfo: TIdHTTPRequestInfo): string;
begin
  if Assigned(ProxyRaptor.OnDelete) then
  begin
    Result := ProxyRaptor.OnDelete(ARequestInfo);
  end
  else
  begin
    Result := TServerUtils.ReturnMethodNotFound;
  end;
end;

end.
