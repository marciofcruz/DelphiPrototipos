unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FPEditFloat, DB, DBTables;

type
  Tfrmlogin = class(TForm)
    Label1: TLabel;
    edtcodigo: TFPEditFloat;
    edtsenha: TEdit;
    Label2: TLabel;
    btnacessar: TButton;
    btnfechar: TButton;
    dtsapostador: TQuery;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnfecharClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnacessarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iapostador: integer;
  end;

var
  frmlogin: Tfrmlogin;

implementation

uses dtMod;

{$R *.dfm}

procedure Tfrmlogin.btnfecharClick(Sender: TObject);
begin
  btnfechar.tag := 1;
  close;
end;

procedure Tfrmlogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (btnfechar.tag = 1) or (btnacessar.tag = 1);
end;

procedure Tfrmlogin.FormShow(Sender: TObject);
begin
  Modulo.Abrirsecao;
  with dtsapostador, dtsapostador.sql do
  begin
    databasename := Modulo.sdatabase;

    Clear;
    Add('SELECT');
    Add('COUNT(*) AAA');
    Add('FROM');
    Add('PESSOA.DB');
    Add('WHERE CODIGO = :P_CODIGO');
    Add('AND SENHA = :P_SENHA');
  end;
end;

procedure Tfrmlogin.btnacessarClick(Sender: TObject);
begin
  btnacessar.enabled := false;

  if (Trunc(edtcodigo.value) = 0) and (edtsenha.text = 'BOLAO') then
  begin
    iapostador := 0;
    btnacessar.tag := 1;
    Close;
  end
  else
  begin
    Modulo.abrirsecao;
    dtsapostador.close;
    dtsapostador.ParamByName('P_CODIGO').AsInteger := Trunc(edtcodigo.value);
    dtsapostador.ParamByName('P_SENHA').AsString := Trim(edtsenha.text);
    dtsapostador.open;

    if dtsapostador.FieldByName('AAA').AsInteger = 1 then
    begin
      iapostador := Trunc(edtcodigo.value);
      btnacessar.tag := 1;
      close;
    end
    else
    begin
      MessageBox(Self.Handle,'Código/senha não conferem.','Atenção',
                 mb_Ok+mb_IconInformation);
    end;

    dtsapostador.close;
  end;

  btnacessar.enabled := true;
end;

end.
