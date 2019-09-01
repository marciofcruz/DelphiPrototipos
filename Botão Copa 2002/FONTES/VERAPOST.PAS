unit verapost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables;

type
  Tfrmveraposta = class(TForm)
    btnacessar: TButton;
    btnfechar: TButton;
    dcGridAposta: TDBGrid;
    dtsgeral: TQuery;
    dsgeral: TDataSource;
    procedure btnfecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnacessarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iapostador: integer;
    procedure montasql;
  end;

var
  frmveraposta: Tfrmveraposta;

implementation

uses dtMod, impress;

{$R *.dfm}

procedure Tfrmveraposta.montasql;
begin
  with dcGridAposta do
  begin
    Columns.Clear;
    Columns.Add;
    Columns[0].FieldName := 'NOME';
    Columns[0].Title.Caption := 'Nome';
    Columns[0].Width := 220;
  end;

  with dtsgeral, dtsgeral.sql do
  begin
    databasename := modulo.sdatabase;

    clear;
    Add('SELECT');
    Add('CODIGO,');
    Add('NOME');
    Add('FROM');
    Add('PESSOA.DB');
    Add('WHERE CODIGO <> :P_CODIGO');
    Add('ORDER BY NOME');

    ParamBYName('P_CODIGO').AsInteger := iapostador;
    
    Open;

    btnacessar.Enabled := Recordcount <> 0;
  end;
end;

procedure Tfrmveraposta.btnfecharClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmveraposta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dtsgeral.Close;
end;

procedure Tfrmveraposta.btnacessarClick(Sender: TObject);
begin
  btnacessar.Enabled := false;

  frmimpressao := Tfrmimpressao.create(Self);
  frmimpressao.iapostador := dtsGeral.FieldByname('CODIGO').AsInteger;
  frmimpressao.montasql(dtsGeral.Fieldbyname('NOME').AsString);
  frmimpressao.QRGeral.PreviewModal;
  FreeAndNil(frmimpressao);

  btnacessar.enabled := true;
end;

end.
