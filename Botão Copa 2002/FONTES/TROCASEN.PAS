unit trocasen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Tfrmtrocarsenha = class(TForm)
    btntrocar: TButton;
    btnfechar: TButton;
    edtsenhaatual: TEdit;
    Label2: TLabel;
    Bevel1: TBevel;
    edtnovasenha: TEdit;
    Label1: TLabel;
    edtconfirmarnovasenha: TEdit;
    Label3: TLabel;
    procedure btnfecharClick(Sender: TObject);
    procedure btntrocarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    iapostador: integer;
  end;

var
  frmtrocarsenha: Tfrmtrocarsenha;

implementation

uses dtMod;

{$R *.dfm}

procedure Tfrmtrocarsenha.btnfecharClick(Sender: TObject);
begin
  btnfechar.tag := 1;
  close;
end;

procedure Tfrmtrocarsenha.btntrocarClick(Sender: TObject);
begin
  btntrocar.enabled := false;

  if (Trim(edtsenhaatual.text) <> '') and
     (Trim(edtnovasenha.text) <> '') and (Trim(edtconfirmarnovasenha.Text) <> '') then
  begin
    with Modulo.dtsexecutar, Modulo.dtsexecutar.sql do
    begin
      clear;
      Add('SELECT');
      Add('COUNT(*) AAA');
      Add('FROM');
      Add('PESSOA.DB');
      Add('WHERE CODIGO = :P_CODIGO');
      Add('AND SENHA = :P_SENHA');

      ParamBYName('P_CODIGO').AsInteger := iapostador;
      ParambyName('P_SENHA').AsString := trim(edtsenhaatual.text);
      Open;

      if FieldByName('AAA').AsInteger = 1 then
      begin
        if trim(edtnovasenha.text) = trim(edtconfirmarnovasenha.text) then
        begin
          if MessageBox(Self.Handle,'Confirma troca de senha?','Atenção',
                        mb_YesNO+mb_IconQuestion) = idYes then
          begin
            with modulo.dtsexecutar,modulo.dtsexecutar.sql do
            begin
              clear;
              Add('UPDATE PESSOA.DB');
              Add('SET SENHA = :P_SENHA');
              Add('WHERE CODIGO = :P_CODIGO');
              ParamBYName('P_CODIGO').AsInteger := iapostador;
              ParambyName('P_SENHA').AsString := trim(edtnovasenha.text);
              ExecSql;
            end;

            MessageBox(Self.Handle,'Troca de senha efetuada.','Atenção',
                       mb_Ok+mb_IconInformation);

            btntrocar.tag := 1;
            Self.Close;
          end;
        end
        else
          MessageBox(Self.Handle,'Nova senha e sua confirmação não conferem.','Atenção',
                     mb_Ok+mb_IconInformation);
      end
      else
      begin
        MessageBox(Self.Handle,'Código/senha atuais não conferem.','Atenção',
                   mb_Ok+mb_IconInformation);
      end;
    end;
  end
  else
  begin
    MessageBox(Self.Handle,'Preencha os campos.','Atenção',mb_Ok+mb_IconInformation);
  end;


  btntrocar.enabled := true;
end;

procedure Tfrmtrocarsenha.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := (btnfechar.tag = 1) or (btntrocar.tag = 1);
end;

end.
