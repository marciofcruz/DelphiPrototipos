
unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, DBTables, CheckLst, Buttons,
  IniFiles;

type
  TfrmMenu = class(TForm)
    grbTesteCompilacao: TGroupBox;
    Barra: TProgressBar;
    sttLog: TStatusBar;
    panListaArquivos: TPanel;
    panBottom: TPanel;
    Panel3: TPanel;
    btnChecarTodos: TButton;
    StatusBar1: TStatusBar;
    btnNaoChecarTodos: TButton;
    panTopo: TPanel;
    Panel1: TPanel;
    btnSelecionar: TBitBtn;
    btnCompilarTestar: TBitBtn;
    bttnFechar: TBitBtn;
    ckbListaArquivos: TCheckListBox;
    Button1: TButton;
    pagina: TPageControl;
    tabLog: TTabSheet;
    memLog: TMemo;
    TabSheet1: TTabSheet;
    memDOS: TMemo;
    procedure FormShow(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCompilarTestarClick(Sender: TObject);
    procedure bttnFecharClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnChecarTodosClick(Sender: TObject);
    procedure btnNaoChecarTodosClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function RetornaTempoSQL(hora_ini:TDateTime;var hora_fim:TDateTime;
                             bExibir_milsec:boolean = true):string;

    function CarregarLibrary(sLibrary: string):string;

    procedure TestarArquivos;
    procedure CompilarArquivos;
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses uSelec;

{$R *.dfm}

function TfrmMenu.RetornaTempoSQL(hora_ini:TDateTime;var hora_fim:TDateTime;
                                    bExibir_milsec:boolean = true):string;
var
  hor,min,sec,milsec: word;
begin
  if hora_fim = 0 then hora_fim := time;

  DecodeTime(hora_fim-hora_ini,hor,min,sec,milsec);

  Result := '';

  if hor <> 0 then Result := IntToStr(hor)+'hor';
  if min <> 0 then Result := Result+' '+IntToStr(min)+'min';
  if sec <> 0 then Result := Result+' '+IntToStr(sec)+' seg';

  if bExibir_milsec and (milsec <> 0) then Result := Result+' '+IntToStr(milsec)+' milseg';

  if Result = '' then Result := '0 seg';
end;

function TfrmMenu.CarregarLibrary(sLibrary: string):string;
var
  HInst: THandle;
begin
  frmSelecionarArquivos.dtHoraIni := now;

  HInst := 0;

  Result := '';
  try
    HInst := LoadLibrary(PChar(sLibrary));

    if HInst <= 0 then Result := 'Não carregou!';
  except
    on E:Exception do
    begin
      Result := E.Message;
    end;
  end;

  try
    FreeLibrary(HInst);
  except
  end;

  frmSelecionarArquivos.dtHoraFim := now;
end;

procedure TfrmMenu.TestarArquivos;
var
  iOk,
  iErro,
  iCont: integer;
  sTemErro: string;
  dtHoraIniProcesso,
  dtHoraFimProcesso: TDateTime;

begin
  Barra.Max := ckbListaArquivos.Items.Count;

  dtHoraIniProcesso := now;

  iOk := 0;
  iErro := 0;
  iCont := 0;

  while (iCont <= ckbListaArquivos.Items.Count-1) do
  begin
    if ckbListaArquivos.Checked[iCont] then
    begin
      ChDir(ExtractFilePath(ckbListaArquivos.Items[iCont]));
      sTemErro := CarregarLibrary(ckbListaArquivos.Items[iCont]);

      if sTemErro <> '' then
      begin
        inc(iErro);
        memLog.Lines.Add(ckbListaArquivos.Items[iCont]+
                         ' ('+RetornaTempoSQL(frmSelecionarArquivos.dtHoraIni,
                                              frmSelecionarArquivos.dtHoraFim)+' )'+
                                              ' -> '+sTemErro);
      end
      else
      begin
        inc(iOk);
        memLog.Lines.Add(ckbListaArquivos.Items[iCont]+
                        ' ('+RetornaTempoSQL(frmSelecionarArquivos.dtHoraIni,
                                             frmSelecionarArquivos.dtHoraFim)+' )'+
                                             ' -> OK');
      end;

      dtHoraFimProcesso := now;

      sttLog.Panels[1].Text := 'OK: '+IntToStr(iOk);
      sttLog.Panels[2].Text := 'Erro: '+IntToStr(iErro);
      sttLog.Panels[3].Text := 'Tempo:'+RetornaTempoSQL(dtHoraIniProcesso,
                                                        dtHoraFimProcesso); 
    end;

    Barra.Position := Barra.Position+1;

    if (sTemErro <> '') and frmSelecionarArquivos.ckbPararErro.Checked then
    begin
      iCont := ckbListaArquivos.Items.Count-1;
    end;

    inc(iCont);

    Application.ProcessMessages;
  end;

  ChDir(ExtractFilePath(Application.ExeName));

  MessageBox(Self.Handle, 'Processo concluído.','Atenção', mb_Ok+mb_IconInformation);
end;

procedure TfrmMenu.CompilarArquivos;
var
  iOk,
  iErro,
  iCont: integer;
  sParteInicial: string;
  sAuxiliar: string;
  sTemErro: string;
  dtHoraIniProcesso,
  dtHoraFimProcesso: TDateTime;
  sNomeArquivo: string;

  function TemErro:string;
  var
    sLinha: string;
    iCont: integer;
  begin
    Result := '';

    if memDOS.Lines.Count = 0 then exit;
     
    for iCont := 0 to memDOS.Lines.Count-1 do
    begin
      sLinha := memDOS.Lines[iCont];

      if (pos('FATAL', UpperCase(sLinha)) > 0) or
         (pos('ERROR', UpperCase(sLinha)) > 0) then Result := sLinha;
    end;
  end;

begin
  Barra.Max := ckbListaArquivos.Items.Count;

  dtHoraIniProcesso := now;

  with TIniFile.Create(
       IncludeTrailingPathDelimiter(
       ExtractFilePath(Application.ExeName))+'dcctest.ini') do
  begin
    sParteInicial  := ReadString('CONFIG', 'dcc32', '')+' ';
  end;

  iOk := 0;
  iErro := 0;
  iCont := 0;

  while (iCont <= ckbListaArquivos.Items.Count-1) do
  begin
    if ckbListaArquivos.Checked[iCont] then
    begin
      sNomeArquivo := ckbListaArquivos.Items[iCont];

      if (pos('(', sNomeArquivo) > 0) and ((pos(')', sNomeArquivo) > 0) and
         (pos(')', sNomeArquivo) > pos('(', sNomeArquivo))) then
      begin
        sNomeArquivo := Trim(copy(sNomeArquivo, 1, pos('(', sNomeArquivo)-1));
      end;

      sAuxiliar := sParteInicial+sNomeArquivo;

      if frmSelecionarArquivos.ExecutarProcesso(ExtractFilePath(sNomeArquivo),
                                                sAuxiliar,
                                                memDOS.Lines) then
      begin
        sTemErro := TemErro;
        if sTemErro <> '' then
        begin
          memLog.Lines.Add(sNomeArquivo+
                           ' ('+RetornaTempoSQL(frmSelecionarArquivos.dtHoraIni,
                                                frmSelecionarArquivos.dtHoraFim)+' )'+
                                                ' -> '+sTemErro);
          inc(iErro);
        end
        else
        begin
          memLog.Lines.Add(sNomeArquivo+
                          ' ('+RetornaTempoSQL(frmSelecionarArquivos.dtHoraIni,
                                               frmSelecionarArquivos.dtHoraFim)+' )'+
                                               ' -> OK');
          inc(iOk);
        end;
      end
      else
      begin
        sTemErro := 'qualquer coisa';
        memLog.Lines.Add(sNomeArquivo+' -> Não conseguiu executar');
        inc(iErro);
      end;

      dtHoraFimProcesso := now;

      sttLog.Panels[1].Text := 'OK: '+IntToStr(iOk);
      sttLog.Panels[2].Text := 'Erro: '+IntToStr(iErro);
      sttLog.Panels[3].Text := 'Tempo:'+RetornaTempoSQL(dtHoraIniProcesso,
                                                        dtHoraFimProcesso); 
    end;

    Barra.Position := Barra.Position+1;

    if (sTemErro <> '') and frmSelecionarArquivos.ckbPararErro.Checked then
    begin
      iCont := ckbListaArquivos.Items.Count-1;
    end;

    inc(iCont);
  end;

  MessageBox(Self.Handle, 'Processo concluído.','Atenção', mb_Ok+mb_IconInformation);
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  sttLog.Panels[1].Text := 'OK: ';
  sttLog.Panels[2].Text := 'Erro: ';
  sttLog.Panels[3].Text := 'Tempo: ';
  sttLog.Panels[4].Text := 'CAP';

  frmSelecionarArquivos.edtCaminho.Text := ExtractFilePath(Application.ExeName);
  pagina.ActivePage := tabLog;

  with frmSelecionarArquivos.cobTipoSelecao do
  begin
    Items.Clear;
    Items.Add('Fontes');
    Items.Add('Executáveis');
    ItemIndex := 0;
  end;

  memLog.Lines.Clear;
end;

procedure TfrmMenu.btnSelecionarClick(Sender: TObject);
begin
  frmSelecionarArquivos.ShowModal;

  if frmSelecionarArquivos.cobTipoSelecao.ItemIndex = 0 then
  begin
    grbTesteCompilacao.Caption := 'Compilação';
    btnCompilarTestar.Caption := 'C&ompilar';
  end
  else
  begin
    grbTesteCompilacao.Caption := 'Chamada a Executáveis';
    btnCompilarTestar.Caption := '&Testar';
  end;

  if frmSelecionarArquivos.btnOk.Tag = 1 then
  begin
    ckbListaArquivos.Items.Assign(frmSelecionarArquivos.sttListaArquivos);
    btnChecarTodos.Click;
    StatusBar1.Panels[0].Text := 'Arquivos: '+IntToStr(ckbListaArquivos.Items.Count);
  end;
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  frmSelecionarArquivos := TfrmSelecionarArquivos.Create(Self);
end;

procedure TfrmMenu.FormDestroy(Sender: TObject);
begin
  FreeAndNil(frmSelecionarArquivos);
end;

procedure TfrmMenu.btnCompilarTestarClick(Sender: TObject);
begin
  if not btnCompilarTestar.Enabled then exit;

  btnCompilarTestar.Enabled := false;
  panListaArquivos.Enabled := false;

  if ckbListaArquivos.Items.Count = 0 then
    MessageBox(Self.Handle,'Nenhum arquivo selecionado.','Atenção',mb_Ok+mb_IconError)
  else
  begin
    Barra.Position := 0;
    sttLog.Panels[0].Text := 'Total: '+IntToStr(ckbListaArquivos.Items.Count);
    sttLog.Panels[1].Text := 'OK: ';
    sttLog.Panels[2].Text := 'Erro: ';
    sttLog.Panels[3].Text := 'Tempo: ';

    memLog.Lines.Clear;

    if frmSelecionarArquivos.cobTipoSelecao.ItemIndex = 0 then
      CompilarArquivos
    else
      TestarArquivos;

    Barra.Position := 0;
  end;

  panListaArquivos.Enabled := true;
  btnCompilarTestar.Enabled := true;
end;

procedure TfrmMenu.bttnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := panListaArquivos.Enabled;
end;

procedure TfrmMenu.btnChecarTodosClick(Sender: TObject);
var
  i: integer;
begin
  if ckbListaArquivos.Items.Count <> 0 then
  begin
    for i := 0 to ckbListaArquivos.Items.Count-1 do
    begin
      ckbListaArquivos.Checked[i] := true;
    end;
  end;
end;

procedure TfrmMenu.btnNaoChecarTodosClick(Sender: TObject);
var
  i: integer;
begin
  if ckbListaArquivos.Items.Count <> 0 then
  begin
    for i := 0 to ckbListaArquivos.Items.Count-1 do
    begin
      ckbListaArquivos.Checked[i] := false;
    end;
  end;
end;

procedure TfrmMenu.Button1Click(Sender: TObject);

  procedure RunDosInMemo(DosApp:String; AMemo:TMemo);
  const
    ReadBuffer = 2400;
  var
    Security : TSecurityAttributes;
    ReadPipe,WritePipe : THandle;
    start : TStartUpInfo;
    ProcessInfo : TProcessInformation;
    Buffer : Pchar;
    BytesRead : DWord;
    Apprunning : DWord;

  begin
    with Security do
    begin
      nlength := SizeOf(TSecurityAttributes);
      binherithandle := true;
      lpsecuritydescriptor := nil;
    end;

    if Createpipe (ReadPipe, WritePipe, @Security, 0) then
    begin
      Buffer := AllocMem(ReadBuffer + 1);
      FillChar(Start,Sizeof(Start),#0);
      start.cb := SizeOf(start);
      start.hStdOutput := WritePipe;
      start.hStdInput := ReadPipe;
      start.dwFlags := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
      start.wShowWindow := SW_HIDE;

      if CreateProcess(nil,
                       PChar(DosApp),
                       @Security,
                       @Security,
                       true,
                       NORMAL_PRIORITY_CLASS,
                       nil,
                       nil,
                       start,
                       ProcessInfo) then
      begin

        repeat
          Apprunning := WaitForSingleObject (ProcessInfo.hProcess,100);
          Application.ProcessMessages;
        until (Apprunning <> WAIT_TIMEOUT);

        //Atualiza o memo
        repeat
          BytesRead := 0;
          ReadFile(ReadPipe, Buffer[0], ReadBuffer, BytesRead, nil);
          Buffer[BytesRead]:= #0;
          OemToAnsi(Buffer, Buffer);
          AMemo.Text := AMemo.text + String(Buffer);
        until (BytesRead < ReadBuffer);

      end; //if CreateProcess

      FreeMem(Buffer);
      CloseHandle(ProcessInfo.hProcess);
      CloseHandle(ProcessInfo.hThread);
      CloseHandle(ReadPipe);
      CloseHandle(WritePipe);
    end; //if Createpipe

  end; //procedure RunDosInMemo

begin
  RunDosInMemo('dcc32 -q', memlog) ;
end;

end.
