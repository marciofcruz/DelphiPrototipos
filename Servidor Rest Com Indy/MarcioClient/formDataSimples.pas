unit formDataSimples;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmDataSimples = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    dtData: TDateTimePicker;
    StaticText2: TStaticText;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FDataMinima: TDateTime;
  public
    class function getData(AOwner: TComponent; ACaption: String; ADataMinima: TDateTime; var aSelecionada: TDateTime):Boolean;
  end;

implementation

{$R *.dfm}

{ TfrmDataSimples }

procedure TfrmDataSimples.Button1Click(Sender: TObject);
begin
  if dtData.Date<FDataMinima then
  begin
    raise Exception.Create('Data mínima a ser informada: '+FormatDateTime('dd/mm/yyyy', FDataMinima)+'!');
  end;

  ModalResult := mrOk;
end;

procedure TfrmDataSimples.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmDataSimples.FormCreate(Sender: TObject);
begin
  dtData.DateTime := date;
end;

class function TfrmDataSimples.getData(AOwner: TComponent; ACaption: String;
  ADataMinima: TDateTime; var aSelecionada: TDateTime): Boolean;
var
  Tela: TfrmDataSimples;
begin
  Result := False;

  Tela := TfrmDataSimples.Create(AOwner);
  try
    Tela.Caption := ACaption;
    Tela.FDataMinima := ADataMinima;

    if Tela.ShowModal=mrOk then
    begin
      Result := true;
      aSelecionada := Tela.dtData.Date;
    end
    else
    begin
      aSelecionada := 0;
    end;
  finally
    FreeAndNil(Tela);
  end;
end;

end.
