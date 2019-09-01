unit Toviasur.Proxy;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Winapi.Windows,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdContext,   Vcl.StdCtrls,
  Toviasur.Comuns;

type
  {Marcio - Consinco}
  TOperacaoVerbo = function(ARequestInfo: TIdHTTPRequestInfo): string of object;

  TProxy = class
  private
    FOnGet: TOperacaoVerbo;
    FOnPost: TOperacaoVerbo;

    FMemoAplicacao: TMemo;
    FMemoRequisicoes: TMemo;
    FMemoRespostas: TMemo;
    FOnPut: TOperacaoVerbo;
    FonDelete: TOperacaoVerbo;
  public
    constructor Create;

    procedure LimparLog;

      // Loga especialmente dados do negócio
    procedure LogBusiness(AIdServerContext: TIdServerContext; const s: String);
    procedure LogRequisicao(ARequestInfo: TIdHTTPRequestInfo);
    procedure LogResposta(AResponseInfo: TIdHTTPResponseInfo);

    property OnGet: TOperacaoVerbo read FOnGet write FOnGet;
    property OnPost: TOperacaoVerbo read FOnPost write FOnPost;
    property OnPut: TOperacaoVerbo read FOnPut write FOnPut;
    property OnDelete: TOperacaoVerbo read FOnDelete write FonDelete;

    property MemoAplicacao: TMemo read FMemoAplicacao write FMemoAplicacao;
    property MemoRequisicoes: TMemo read FMemoRequisicoes write FMemoRequisicoes;
    property MemoRespostas: TMemo read FMemoRespostas write FMemoRespostas;
  end;

var
  ProxyRaptor: TProxy;
  ContextCriticalSection: TRTLCriticalSection;

implementation

{ TProxy }

constructor TProxy.Create;
begin
  FOnGet := nil;
  FOnPost := nil;
  FOnPut := nil;
  FOnDelete := nil;

  FMemoAplicacao  := nil;
  FMemoRequisicoes  := nil;
  FMemoRespostas  := nil;
end;

procedure TProxy.LimparLog;
begin
  EnterCriticalSection(ContextCriticalSection);
  try
    if Assigned(FMemoAplicacao) then
    begin
      FMemoAplicacao.Lines.Clear;
    end;

    if Assigned(FMemoRequisicoes) then
    begin
      FMemoRequisicoes.Lines.Clear;
    end;

    if Assigned(FMemoRespostas) then
    begin
      FMemoRespostas.Lines.Clear;
    end;
  finally
    LeaveCriticalSection(ContextCriticalSection);
  end;
end;

procedure TProxy.LogBusiness(AIdServerContext: TIdServerContext;  const s: String);
var
  SB: TStringBuilder;
begin
  if Assigned(FMemoAplicacao) then
  begin
    EnterCriticalSection(ContextCriticalSection);
    SB := TStringBuilder.Create;
    try
      SB.Append(DateTimeToStr(Now) + ': ');

      if Assigned(AIdServerContext) then
      begin
        SB.Append('From IP : ' + AIdServerContext.Connection.Socket.Binding.PeerIP + ' - ');
      end;

      SB.Append(s);
      FMemoAplicacao.Lines.Add(SB.ToString);
    finally
      FreeAndNil(SB);
      LeaveCriticalSection(ContextCriticalSection);
    end;
  end;
end;

procedure TProxy.LogRequisicao(ARequestInfo: TIdHTTPRequestInfo);
begin
  if Assigned(FMemoRequisicoes) then
  begin
    EnterCriticalSection(ContextCriticalSection);
    try
      FMemoRequisicoes.Lines.Add(ARequestInfo.UserAgent + #13 + #10 +
        ARequestInfo.RawHTTPCommand);
    finally
      LeaveCriticalSection(ContextCriticalSection);
    end;
  end;
end;

procedure TProxy.LogResposta(AResponseInfo: TIdHTTPResponseInfo);
begin
  if Assigned(FMemoRespostas) then
  begin
    EnterCriticalSection(ContextCriticalSection);
    try
      FMemoRespostas.Lines.Add(AResponseInfo.ContentText);
    finally
      LeaveCriticalSection(ContextCriticalSection);
    end;
  end;
end;

initialization
  ProxyRaptor := TProxy.Create;
  InitializeCriticalSection(ContextCriticalSection);

finalization
  FreeAndNil(ProxyRaptor);
  DeleteCriticalSection(ContextCriticalSection);

end.
