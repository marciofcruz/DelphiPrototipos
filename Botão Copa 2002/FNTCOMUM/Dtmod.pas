unit dtMod;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, DB, DBTables, Printers;

type
  TTipoOperacao = (tpoConsulta,tpoInclusao,tpoAlteracao);

  TModulo = class(TDataModule)
    imgbotoes: TImageList;
    dtsmatriz: TQuery;
    dtsselecao: TQuery;
    dtsaposta: TQuery;
    dtsexecutar: TQuery;
    tblauxiliar: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
    sdatabase:string;
    bapostasliberadas: boolean;

    procedure Abrirtabelas;
    function RetornaTempoSQL(hora_ini:TTime;var hora_fim:TTime):string;
    function DiferencaData(data1,data2: TDateTime):string;
    function TestaData(s:string):boolean;
    function SeSufixo(s:string):string;
    function LimpaAcentos(S: string): string;
    function PegarLpt1:integer;
    function verificar:boolean;
    function ApostasLiberadas:boolean;
    procedure abrirsecao;
  end;

  {$IFDEF BOLAO}
  const
    C_TEMP = 'C:\TEMP\1';
    nomecurto = 'BOLAO';
  {$ENDIF}

  VAR
  Modulo: TModulo;

implementation

{$R *.DFM}

function TModulo.ApostasLiberadas:boolean;
var
  bcopajacomecou: boolean;
begin
  with dtsexecutar, dtsexecutar.sql do
  begin
    clear;
    Add('SELECT');
    Add('COUNT(*) AAA');
    Add('FROM');
    Add('MATRIZ.DB');
    Add('WHERE ENCERRADO = 1');
    Open;

    bcopajacomecou := FieldByName('AAA').AsInteger <> 0;

    if bcopajacomecou then
    begin
      clear;
      Add('UPDATE CONTROLE.DB');
      Add('SET  FLAG = 1');
      Add('WHERE CODIGO = 1'); // encerrado
      ExecSql;
      Result := false;
    end
    else
    begin
      clear;
      Add('SELECT FLAG FROM CONTROLE.DB');
      Add('WHERE CODIGO = 1');
      Open;
      Result := FieldByName('FLAG').AsInteger = 0;
      Close;
    end;
  end;
end;

function TModulo.verificar:boolean;
begin
  Result := false;

  if FileExists(Modulo.sdatabase+'\MATRIZ.DB') and
     FileExists(Modulo.sdatabase+'\MATRIZ.PX') and
     FileExists(Modulo.sdatabase+'\APOSTA.DB') and
     FileExists(Modulo.sdatabase+'\APOSTA.PX') and
     FileExists(Modulo.sdatabase+'\PESSOA.DB') and
     FileExists(Modulo.sdatabase+'\PESSOA.PX') and
     FileExists(Modulo.sdatabase+'\SELECAO.DB') and
     FileExists(Modulo.sdatabase+'\SELECAO.PX') then
  begin
    CreateDir(C_TEMP);
    Session.PrivateDir := C_TEMP;

    abrirsecao;

    with dtsexecutar do
    begin
      databasename := Modulo.sdatabase;

      with sql do
      begin
        Clear;
        Add('SELECT COUNT(*) FROM MATRIZ.DB');
      end;
      Open;
      Close;
    end;

    Modulo.Abrirtabelas;

    Result := true;
  end
  else
  begin
    showmessage('Base de dados não encontrada...');
    Application.Terminate;
  end;
end;

procedure TModulo.Abrirtabelas;
begin
  with dtsselecao,dtsselecao.sql do
  begin
    databasename := modulo.sdatabase;
    clear;
    Add('SELECT');
    Add('CODIGO,');
    Add('SIGLA,');
    Add('NOME');
    Add('FROM');
    Add('SELECAO.DB');
    Add('ORDER BY CODIGO');
    Open;
  end;

  with dtsmatriz,dtsmatriz.sql do
  begin
    databasename := modulo.sdatabase;
    clear;
    Add('SELECT');
    Add('CODIGO,');
    Add('COD_SELECAO1,');
    Add('COD_SELECAO2,');
    Add('PLACAR1,');
    Add('PLACAR2,');
    Add('ENCERRADO');
    Add('FROM');
    Add('MATRIZ.DB');
    Add('ORDER BY CODIGO');
    Open;
  end;

  with dtsaposta,dtsaposta.sql do
  begin
    databasename := modulo.sdatabase;
    clear;
    Add('SELECT');
    Add('COD_JOGO CODIGO,');
    Add('COD_SELECAO1,');
    Add('COD_SELECAO2,');
    Add('PLACAR1,');
    Add('PLACAR2,');
    Add('ENCERRADO');
    Add('FROM');
    Add('APOSTA.DB');
    Add('WHERE COD_APOSTADOR = :P_APOSTADOR');
    Add('ORDER BY COD_JOGO');
  end;
end;

function TModulo.RetornaTempoSQL(hora_ini:TTime;var hora_fim:TTime):string;
var
  hor,min,sec,milsec: word;
begin
  if hora_fim = 0 then hora_fim := time;

  DecodeTime(hora_fim-hora_ini,hor,min,sec,milsec);

  Result := '';

  if hor <> 0 then Result := IntToStr(hor)+'hor';
  if min <> 0 then Result := Result+' '+IntToStr(min)+'min';
  if sec <> 0 then Result := Result+' '+IntToStr(sec)+' seg';
  if milsec <> 0 then Result := Result+' '+IntToStr(milsec)+' milseg';

  if Result = '' then Result := '0 seg';
end;



function StringAno(i:integer):string;
begin
  if i = 0 then
    Result := ''
  else
  begin
    Result := IntToStr(i);
    if i = 1 then
      Result := Result+'ano '
    else
      Result := Result+'anos ';
  end;
end;

function StringMes(i:integer):string;
begin
  if i = 0 then
    Result := ''
  else
  begin
    Result := InttoStr(i);
    if i = 1 then
      Result := Result+'mês '
    else
      Result := Result+'meses ';
  end;
end;

function StringDia(i:integer):string;
begin
  if i = 0 then
    Result := ''
  else
  begin
    Result := inttostr(i);
    if i = 1 then
      Result := Result+'dia'
    else
      Result := Result+'dias';
  end;
end;


function TModulo.DiferencaData(data1,data2: TDateTime):string;
var
  iDiferencaDias: integer;

  function DiasDe(data:TDateTime):integer;
  var
    ano,mes,dia: word;
  begin
    DecodeDate(data,ano,mes,dia);
    Result := (ano*360)+(mes*30)+dia;
  end;

  function ConverteDiasEmTexto(i:integer):string;
  var
    iAno,iMes,iDia:real;

    function pegarAnos:extended;
    begin
      if i > 360 then
      begin
        Result := (i div 360);
        i := (i mod 360);
      end
      else
        Result := 0;
    end;

    function pegarMeses:extended;
    begin
      if i > 30 then
      begin
        Result := (i div 30);
        i := (i mod 30);
      end
      else
        Result := 0;
    end;

  begin
    iAno := PegarAnos;
    iMes := PegarMeses;
    iDia := i;

    Result :=  StringAno(Trunc(iAno))+StringMes(Trunc(iMes))+Stringdia(Trunc(iDia));
  end;

begin
  Result := '';

  if data2 >= data1 then
  begin
    iDiferencaDias := DiasDe(data2)-DiasDe(Data1);
    Result := ConverteDiasEmTexto(iDiferencaDias);
  end;
end;

function TModulo.SeSufixo(s:string):string;
begin
  if (pos('%',s) <> 0) or (pos('_',s) <> 0) then
    Result := ' LIKE '
  else
    Result := ' = ';
end;

function TModulo.TestaData(s:string):boolean;
begin
  if s = '__/__/____' then
    Result := false
  else
  begin
    try
      StrToDate(s);
      Result := true;
    except
      Result := false;
    end;
  end;
end;

function Tmodulo.LimpaAcentos(S: string): string;
const
  C_COMACENTO = 'ÁÉÍÓÚ ÄËÏÖÜ ÀÈÌÒÙ ÃÕ ÂÊÎÔÛ ÇÑ áéíóú äëïöü àèìòù ãõ âêîôû çñ';
  C_SEMACENTO = 'AEIOU AEIOU AEIOU AO AEIOU CN aeiou aeiou aeiou ao aeiou cn';
var
  i, aux : integer;

begin
  for i := 1 to Length(S) do
  begin
    aux := Pos(S[i], C_COMACENTO);

    if (aux > 0) then S[i] := C_SEMACENTO[aux];
  end;

  Result := S;
end;

function TModulo.PegarLpt1:integer;
begin
  Result := Printer.Printers.IndexOf('matricial on LPT1:');

  if Result = -1 then
    Application.MessageBox('Impressora não encontrada.','Erro',
                           mb_Ok + mb_IconError);
end;

procedure Tmodulo.abrirsecao;
begin
  Session.AddPassword('supercopa');
  Session.AddPassword('SUPERCOPA');
  tblauxiliar.DatabaseName := Modulo.sdatabase;
  tblauxiliar.TableName := 'SELECAO.DB';
  tblauxiliar.open;
  tblauxiliar.close;
end;

end.

