unit uSelec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, FileCtrl, uSearch, Spin;

type
  TContagem = record
                Arquivo: string;
                Total: integer;
              end;

  TfrmSelecionarArquivos = class(TForm)
    cobTipoSelecao: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtCaminho: TEdit;
    ckbPararErro: TCheckBox;
    btnOk: TBitBtn;
    BitBtn1: TBitBtn;
    btnBrowse: TButton;
    Label3: TLabel;
    edtBPLDependente: TEdit;
    speNiveis: TSpinEdit;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure cobTipoSelecaoClick(Sender: TObject);
  private
    { Private declarations }

    ProcuraArquivo: TProcuraArquivo;
    aContagem: array of TContagem;

    function TemDependencia(sArq: string):boolean;

    procedure EventoProcura(Sender: TObject; Path:String; FileName:String);

    function PegarTotalString(sLinha:string):integer;
    function PegarTotalArrayContagem(sArq: string):integer;
    procedure Contabilizar(sArq: string);
    procedure FazerContagem(sArq: string);

    procedure AcumularLista;
    procedure SelecionarArquivos;
  public
    { Public declarations }
    dtHoraIni,
    dtHoraFim: TDateTime;

    sttListaArquivos: TStringList;
    sttListaAuxiliar: TStringList;

    sArquivoLista: string;
    sArquivoErro: string;

    function ExecutarProcesso(sPath, sProcesso: string; PrgOut : TStrings):boolean;

    function PegarTemporario:String;
  end;

var
  frmSelecionarArquivos: TfrmSelecionarArquivos;

implementation

{$R *.dfm}

procedure TfrmSelecionarArquivos.EventoProcura(Sender: TObject; Path:String; FileName:String);
var
  bAdd: boolean;
  iCont: integer;
begin
  if Trim(edtBPLDependente.Text) = '' then
  begin
    bAdd := true;
  end
  else
  begin
    if edtBPLDependente.Text = copy(UpperCase(FileName),1,pos('.',FileName)-1)  then
    begin
      bAdd := true;
    end
    else
    begin
      bAdd := TemDependencia(Path+FileName);
    end;
  end;

  if bAdd then
  begin
    if sttListaArquivos.Count = 0 then
    begin
      bAdd := true;
    end
    else
    begin
      bAdd := true;

      for iCont := 0 to sttListaArquivos.Count-1 DO
      begin
        if (Path+FileName) = sttListaArquivos[iCont] then
        begin
          exit;
        end;   
      end;
    end;

    if bAdd then
    begin
      sttListaArquivos.Add(Path+FileName);
    end;
  end;
end;

function TfrmSelecionarArquivos.PegarTotalString(sLinha:string):integer;
var
  iPosIni, iTamanho: integer;
begin
  if (pos('(', sLinha) > 0) and ((pos(')', sLinha) > 0) and
     (pos(')', sLinha) > pos('(', sLinha))) then
  begin
    iPosIni  := pos('(', sLinha)+1;
    iTamanho := pos(')', sLinha)-pos('(', sLinha)-1;

    if iTamanho = 0 then
      Application.ProcessMessages;

    Result := StrToInt(copy(sLinha, iPosIni, iTamanho));
  end
  else
    Result := -1;
end;

function TfrmSelecionarArquivos.PegarTotalArrayContagem(sArq: string):integer;
var
  sFileName: string;
  i: integer;
begin
  Result := 0;

  sArq := UpperCase(sArq);
  sFileName := ExtractFileName(sArq); // Somente o nome do arquivo para não deixar lento o processo

  for i := 0 to length(aContagem)-1 do
  begin
    if sFileName = aContagem[i].Arquivo then
      Result := aContagem[i].Total; 
  end;
end;

procedure TfrmSelecionarArquivos.Contabilizar(sArq: string);
var
  i: integer;
  bEncontrou: boolean;
begin
  sArq := UpperCase(sArq)+'.DPK';

  if length(aContagem) = 0 then
  begin
    SetLength(aContagem, length(aContagem)+1);
    aContagem[length(aContagem)-1].Arquivo := sArq;
    aContagem[length(aContagem)-1].Total := 1;
  end
  else
  begin
    bEncontrou := false;
    for i := 0 to length(aContagem)-1 do
    begin
      if aContagem[i].Arquivo = sArq then
      begin
        aContagem[i].Total := aContagem[i].Total+1;
        bEncontrou := true;
      end;
    end;

    if not bEncontrou then
    begin
      SetLength(aContagem, length(aContagem)+1);
      aContagem[length(aContagem)-1].Arquivo := sArq;
      aContagem[length(aContagem)-1].Total := 1;
    end;
  end;
end;

function TfrmSelecionarArquivos.TemDependencia(sArq: string):boolean;
var
  fArq: TextFile;
  sAuxiliar: string;
  sLinha: string;
  bIniciarAnalise: boolean;
  bFinalizarAnalise: boolean;
  sUltimoChar: string[1];
  sArqReduzido: string;
begin
  Result := false;

  bIniciarAnalise := false;
  bFinalizarAnalise := false;

  if UpperCase(ExtractFileExt(sArq)) = '.DPK' then
  begin
    try
      AssignFile(fArq, sArq);
      reset(fArq);

      while ((not Eof(fArq)) and (not bFinalizarAnalise)) and (not Result) do
      begin
        readln(fArq, sLinha);
        sLinha := UpperCase(sLinha);

        if bIniciarAnalise then
        begin
          if pos(';', sLinha) > 0 then
          begin
            bFinalizarAnalise := true;
            sUltimoChar := ';';
          end
          else
            sUltimoChar := ',';

          sArqReduzido := Trim(UpperCase(ExtractFileName(sLinha)));

          while pos(',', sArqReduzido) <> 0 do
          begin
            delete(sArqReduzido, pos(',', sArqReduzido), 1);
          end;

          while pos('.', sArqReduzido) <> 0 do
          begin
            delete(sArqReduzido, pos('.', sArqReduzido), 1);
          end;

          while pos(';', sArqReduzido) <> 0 do
          begin
            delete(sArqReduzido, pos(';', sArqReduzido), 1);
          end;

          Result := sArqReduzido = edtBPLDependente.Text;
        end;

        if pos('REQUIRES', sLinha) > 0 then bIniciarAnalise := true;
      end;

      CloseFile(fArq);
    except
      on E:Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  end
  else if UpperCase(ExtractFileExt(sArq)) = '.DPR' then
  begin
    sArq := copy(sArq,1,pos('.DPR',UpperCase(sArq))-1)+'.DOF';

    if FileExists(sArq) then
    begin
      with TIniFile.Create(sArq) do
      begin
        sLinha := Trim(ReadString('Directories','Packages',''));

        while pos(';',sLinha) <> 0 do
        begin
          sAuxiliar := Trim(copy(sLinha,1,pos(';',sLinha)-1));
          Contabilizar(sAuxiliar);

          delete(sLinha,1,pos(';',sLinha));
        end;

        sLinha := Trim(sLinha);

        if sLinha <> '' then
        begin
          sAuxiliar := Trim(copy(sLinha,1,pos(';',sLinha)-1));
          Result := pos(edtBPLDependente.Text, sAuxiliar) > 0;
        end;
      end;
    end;
  end;
end;

procedure TfrmSelecionarArquivos.FazerContagem(sArq: string);
var
  fArq: TextFile;
  sAuxiliar: string;
  sLinha: string;
  bIniciarAnalise: boolean;
  bFinalizarAnalise: boolean;
  sUltimoChar: string[1];
begin
  bIniciarAnalise := false;
  bFinalizarAnalise := false;

  if UpperCase(ExtractFileExt(sArq)) = '.DPK' then
  begin
    try
      AssignFile(fArq, sArq);
      reset(fArq);

      while (not Eof(fArq)) and (not bFinalizarAnalise) do
      begin
        readln(fArq, sLinha);
        sLinha := UpperCase(sLinha);

        if bIniciarAnalise then
        begin
          if pos(';', sLinha) > 0 then
          begin
            bFinalizarAnalise := true;
            sUltimoChar := ';';
          end
          else
            sUltimoChar := ',';

          Contabilizar(Trim(copy(sLinha,1,pos(sUltimoChar, sLinha)-1)));
        end;

        if pos('REQUIRES', sLinha) > 0 then bIniciarAnalise := true;
      end;

      CloseFile(fArq);
    except
      on E:Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  end
  else if UpperCase(ExtractFileExt(sArq)) = '.DPR' then
  begin
    sArq := copy(sArq,1,pos('.DPR',UpperCase(sArq))-1)+'.DOF';

    if FileExists(sArq) then
    begin
      with TIniFile.Create(sArq) do
      begin
        sLinha := Trim(ReadString('Directories','Packages',''));

        while pos(';',sLinha) <> 0 do
        begin
          sAuxiliar := Trim(copy(sLinha,1,pos(';',sLinha)-1));
          Contabilizar(sAuxiliar);

          delete(sLinha,1,pos(';',sLinha));
        end;

        sLinha := Trim(sLinha);

        if sLinha <> '' then
        begin
          sAuxiliar := Trim(copy(sLinha,1,pos(';',sLinha)-1));
          Contabilizar(sAuxiliar);
        end;
      end;
    end;
  end;
end;


function TfrmSelecionarArquivos.ExecutarProcesso(sPath,
                                                 sProcesso: string;
                                                 PrgOut : TStrings):boolean;
const
  ReadBuffer = 2400;
var
  Buffer : Pchar;

  Security : TSecurityAttributes;
  ReadPipe,WritePipe : THandle;

  InfoIniciar : TStartupInfo;
  InfoProcesso : TProcessInformation;
  BytesRead : DWord;
  iErros: integer;
begin
  dtHoraIni := now;

  if PrgOut <> nil then PrgOut.Clear;

  Result := false;
  with Security do
  begin
    nlength := SizeOf(TSecurityAttributes);
    lpsecuritydescriptor := nil;
    binherithandle := true;
  end;

  if Createpipe (ReadPipe, WritePipe, @Security, 0) then
  begin
    Buffer := AllocMem(ReadBuffer + 1);

    FillChar(InfoIniciar, Sizeof(InfoIniciar),#0);
    with InfoIniciar do
    begin
      cb           := SizeOf(InfoIniciar);
      dwFlags      := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
      wShowWindow  := SW_HIDE;
      hStdInput    := ReadPipe;
      hStdOutput   := WritePipe;
    end;

    if CreateProcess(Nil,
                     PChar(sProcesso),
                     @Security,
                     @Security,
                     True,
                     NORMAL_PRIORITY_CLASS,
                     Nil,
                     PChar(sPath),
                     InfoIniciar,
                     InfoProcesso) then
    begin
      iErros := 0;
      while (iErros < 40) and
            (WaitForSingleObject(InfoProcesso.hProcess, 100) = WAIT_TIMEOUT) do
      begin
        inc(iErros);
        Application.ProcessMessages;
      end;

      if Assigned(PrgOut) then
      begin
        //Atualiza o memo
        repeat
          BytesRead := 0;
          ReadFile(ReadPipe, Buffer[0], ReadBuffer, BytesRead, nil);
          Buffer[BytesRead] := #0;
          OemToAnsi(Buffer, Buffer);
          PrgOut.Text := PrgOut.Text + String(Buffer);
        until (BytesRead < ReadBuffer);
      end;

      Result := true;
    end;

    FreeMem(Buffer);

    CloseHandle(InfoProcesso.hProcess);
    CloseHandle(InfoProcesso.hThread);
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);
  end;
  dtHoraFim := now;
end;


function TfrmSelecionarArquivos.PegarTemporario:String;
var
  Buffer: Array[0..144] of Char;
  sAuxiliar: string;
begin
  GetTempPath(144, Buffer);
  sauxiliar := StrPas(Buffer);

  Result := IncludeTrailingBackslash(sAuxiliar);
end;

procedure TfrmSelecionarArquivos.AcumularLista;
var
  fArq: TextFile;
  sLinha: string;
begin
  if not FileExists(sArquivoLista) then exit;

  AssignFile(fArq, sArquivoLista);
  reset(fArq);

  while not Eof(fArq) do
  begin
    readln(fArq, sLinha);
    sttListaArquivos.Add(sLinha);
  end;

  CloseFile(fArq);
end;

procedure TfrmSelecionarArquivos.SelecionarArquivos;
var
  sCaminho: string;
  i: integer;

  sNomeAuxiliar: string;
  iTotalAuxiliar: integer;
  iTotalAuxiliar2: integer;

  iNiveis: integer;
  iCont: integer;
  sAuxiliar: string;
  sBPLDependenteOriginal: string;
begin
  if not DirectoryExists(frmSelecionarArquivos.edtCaminho.Text) then
  begin
    MessageBox(Self.Handle,'Caminho não existe.','Atenção',mb_Ok+mb_IconError);
  end;

  edtBPLDependente.Text := Trim(edtBPLDependente.Text);

  sttListaArquivos.Clear;

  sCaminho := IncludeTrailingBackslash(frmSelecionarArquivos.edtCaminho.Text);

  if frmSelecionarArquivos.cobTipoSelecao.ItemIndex = 0 then
  begin
    ProcuraArquivo.ExecutarAcao(IncludeTrailingBackslash(ExtractFilePath(sCaminho)),
                                '*.DPR', 0, true);
    ProcuraArquivo.ExecutarAcao(IncludeTrailingBackslash(ExtractFilePath(sCaminho)),
                                '*.DPK', 0, true);
    AcumularLista;

    if (speNiveis.Value <> 0) and (edtBPLDependente.Text <> '') then
    begin
      sBPLDependenteOriginal := edtBPLDependente.Text; 

      for iNiveis := 1 to speNiveis.Value do
      begin
        sttListaAuxiliar.Assign(sttListaArquivos);

        for iCont := 0 to sttListaAuxiliar.Count-1 do
        begin
          sAuxiliar := UpperCase(ExtractFileName(sttListaAuxiliar[iCont]));
          sAuxiliar := copy(sAuxiliar, 1, pos('.', sAuxiliar)-1);

          edtBPLDependente.Text := sAuxiliar;

          ProcuraArquivo.ExecutarAcao(IncludeTrailingBackslash(ExtractFilePath(sCaminho)),
                                      '*.DPR', 0, true);
          ProcuraArquivo.ExecutarAcao(IncludeTrailingBackslash(ExtractFilePath(sCaminho)),
                                      '*.DPK', 0, true);
        end;
      end;

      edtBPLDependente.Text := sBPLDependenteOriginal;
    end;
  end
  else
  begin
    ProcuraArquivo.ExecutarAcao(IncludeTrailingBackslash(ExtractFilePath(sCaminho)),
                                '*.EXE', 0, true);
    AcumularLista;

    ProcuraArquivo.ExecutarAcao(IncludeTrailingBackslash(ExtractFilePath(sCaminho)),
                                '*.bpl', 0, true);
    AcumularLista;

    ProcuraArquivo.ExecutarAcao(IncludeTrailingBackslash(ExtractFilePath(sCaminho)),
                                '*.dll', 0, true);
    AcumularLista;
  end;


  if sttListaArquivos.Count = 0 then exit;

  // Analisar lista
  SetLength(aContagem, 0);
  for i := 0 to sttListaArquivos.Count-1 do
  begin
    FazerContagem(sttListaArquivos[i]);

    Application.ProcessMessages;
  end;

  if length(aContagem) <> 0 then
  begin
    // Recriar Lista
    for i := 0 to sttListaArquivos.Count-1 do
    begin
      iTotalAuxiliar := PegarTotalArrayContagem(sttListaArquivos[i]);

      if iTotalAuxiliar <> 0 then
        sttListaArquivos[i] := sttListaArquivos[i]+' ('+IntToStr(iTotalAuxiliar)+')';
    end;
  end;

  if sttListaArquivos.Count > 2 then
  begin
    i := 0;

    while i <= sttListaArquivos.Count-2 do
    begin
      iTotalAuxiliar := PegarTotalString(sttListaArquivos[i]);
      iTotalAuxiliar2 := PegarTotalString(sttListaArquivos[i+1]);

      if iTotalAuxiliar >= iTotalAuxiliar2 then
        inc(i)
      else
      begin
        sNomeAuxiliar := sttListaArquivos[i];

        sttListaArquivos[i] := sttListaArquivos[i+1];

        sttListaArquivos[i+1] := sNomeAuxiliar;

        i := 0;
      end;
    end;
  end;
end;

procedure TfrmSelecionarArquivos.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSelecionarArquivos.btnOkClick(Sender: TObject);
begin
  btnOk.Enabled := false;

  if not DirectoryExists(edtCaminho.Text) then
  begin
    MessageBox(Self.Handle,'Caminho não existe.','Atenção',mb_Ok+mb_IconError);
  end
  else
  begin
    SelecionarArquivos;

    btnOk.Tag := 1;
    Close;
  end;

  btnOk.Enabled := true;
end;

procedure TfrmSelecionarArquivos.FormCreate(Sender: TObject);
begin
  sttListaArquivos := TStringList.Create;
  sttListaAuxiliar := TStringList.Create;  

  ProcuraArquivo := TProcuraArquivo.Create(Self);
  ProcuraArquivo.AoChamarEvento := EventoProcura;

  SetLength(aContagem, 0);

  sArquivoLista := PegarTemporario+IntToStr(Self.Handle)+'.txt';
  sArquivoErro  := PegarTemporario+'erro'+IntToStr(Self.Handle)+'.txt';
  ForceDirectories(PegarTemporario);
end;

procedure TfrmSelecionarArquivos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sttListaAuxiliar);
  FreeAndNil(sttListaArquivos);
  FreeAndNil(ProcuraArquivo);

  DeleteFile(sArquivoLista);
//  DeleteFile(sArquivoErro);
end;

procedure TfrmSelecionarArquivos.btnBrowseClick(Sender: TObject);
var
  S: string;
begin
  S := '';
  if SelectDirectory('Selecionar Diretório', copy(GetCurrentDir,1,2), S) then
    edtCaminho.Text := S;
end;

procedure TfrmSelecionarArquivos.cobTipoSelecaoClick(Sender: TObject);
begin
  edtBPLDependente.Enabled := cobTipoSelecao.ItemIndex = 0;
  speNiveis.Enabled := cobTipoSelecao.ItemIndex = 0; 
end;

end.
