unit sorteio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Tfrmsorteio = class(TForm)
    btnOk: TButton;
    Panel1: TPanel;
    rdgprimeiro: TRadioGroup;
    rdgsegundo: TRadioGroup;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmsorteio: Tfrmsorteio;

implementation

{$R *.dfm}

procedure Tfrmsorteio.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := btnOk.Tag = 1;
end;

procedure Tfrmsorteio.btnOkClick(Sender: TObject);
begin
  if rdgprimeiro.itemindex <> rdgsegundo.itemindex then
  begin
    btnOk.Tag := 1;
    Close;
  end
  else
  begin
    MessageBox(Self.Handle,'Foram selecionados as mesmas seleções.','Erro',
               mb_Ok+mb_IconError);
  end;
end;

end.
