unit uSearch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type TChamaEvento = procedure (Sender: TObject; Path:String; FileName:String) of object;

type
  TProcuraArquivo = class(TComponent)

  private
    bestaprocurando: boolean;
    ChamaEvento: TChamaEvento;
    bprimeiro: boolean;
    ffiltro: string;
    fpath: string;
    fatributo: integer;
    sr: TSearchRec;

  protected

  public
    constructor Create(AOwner: TComponent); override;
    procedure Abrirbusca(path:string; filtro:string; atributos:integer);
    procedure Fecharbusca;
    procedure ExecutarAcao(path:string;filtro:string;  atributos:integer;
              bsubdiretorio:boolean);
    function Proximo(var SearchRec:TSearchRec):boolean;

  published
    property AoChamarEvento: TChamaEvento read ChamaEvento write ChamaEvento;
  end;

implementation

procedure ajustar(var s:string);
begin
  if s[length(s)] <> '\' then s := s + '\';
end;

procedure TProcuraArquivo.ExecutarAcao(path:string; filtro:string;atributos:integer;
                                   bsubdiretorio:boolean);
var
  x: TSearchRec;
  s: TstringList;
  i: integer;
  fs: TProcuraArquivo;
begin
  Abrirbusca(path, filtro, atributos);

  while Proximo(x) do
  begin
    if Assigned(ChamaEvento) then ChamaEvento(self, fpath, x.Name);
  end;

  Fecharbusca;

  if bsubdiretorio then
  begin
    s := TStringList.create;
    
    Abrirbusca(path, '*.*', faDirectory);

    while Proximo(x) do
    begin
      if ((x.Attr and fadirectory) <> 0) and
          (x.Name <> '.') and (x.Name <> '..') then
      begin
        s.Add(x.Name);
      end;
    end;

    Fecharbusca;

    ajustar(path);

    fs := TProcuraArquivo.Create(self);
    fs.AoChamarEvento := ChamaEvento;

    for i:=0 to s.Count-1 do fs.ExecutarAcao(path+s[i], filtro, atributos, true);

    fs.free;
  end;
end;

constructor TprocuraArquivo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
  bestaprocurando := false;
  
  bprimeiro := false;
end;

function TProcuraArquivo.Proximo(var SearchRec:TSearchRec):boolean;
begin
  if bprimeiro then
  begin
    result := FindFirst(fpath + ffiltro, fatributo, sr) = 0;
    bprimeiro := false;
  end
  else
   result:= FindNext(sr) = 0;

  SearchRec:=sr;
end;

procedure TProcuraArquivo.Abrirbusca(path:string; filtro:string; atributos:integer);
begin
  if bestaprocurando then
    raise Exception.Create('Erro: Abrir busca já foi chamado...');

  ajustar(path);

  ffiltro := filtro;
  fpath := path;
  fatributo := atributos;

  bestaprocurando := true;

  bprimeiro := true;
end;

procedure TProcuraArquivo.Fecharbusca;
begin
  if not bestaprocurando then raise Exception.Create('Erro: Não foi chamado o Abrirbusca');

  FindClose(sr);
  
  bestaprocurando := false;

  bprimeiro := true;
end;

{procedure Register;
begin
  RegisterComponents('CAP', [TProcuraArquivo]);
end; }

end.
