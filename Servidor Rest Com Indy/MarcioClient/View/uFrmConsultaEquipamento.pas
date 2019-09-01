unit uFrmConsultaEquipamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBaseEquipamento, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TfrmConsultaEquipamento = class(TfrmBaseEquipamento)
    procedure FormCreate(Sender: TObject);
  protected
    function UpdateInsert: Boolean; override;
    function UpdateEdit: Boolean; override;
    function UpdateCancel: Boolean; override;
    function UpdatePesquisar:Boolean; override;
  end;

implementation

{$R *.dfm}

{ TfrmConsultaEquipamento }

procedure TfrmConsultaEquipamento.FormCreate(Sender: TObject);
begin
  inherited;

  pnlOperacoes.Visible := False;
end;

function TfrmConsultaEquipamento.UpdateCancel: Boolean;
begin
  Result := False;
end;

function TfrmConsultaEquipamento.UpdateEdit: Boolean;
begin
  Result := False;
end;

function TfrmConsultaEquipamento.UpdateInsert: Boolean;
begin
  Result := False;
end;

function TfrmConsultaEquipamento.UpdatePesquisar: Boolean;
begin
  Result := True;
end;

end.
