unit MFC.Classes.Amostragem;

interface

uses
  Windows,
  System.SysUtils, System.Classes;

type
  TItem = class
  private
    FValores: array of double;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddValor(const aValor: double);

    function getMedia:extended;
    function getVarianciaPopulacional:Double;
  end;

implementation

procedure TItem.AddValor(const aValor: double);
begin
  SetLength(FValores, Length(FValores)+1);
  FValores[Length(FValores)-1] := aValor;
end;

constructor TItem.Create;
begin
  SetLength(FValores, 0);
end;

destructor TItem.Destroy;
begin
  SetLength(FValores, 0);
  inherited;
end;

function TItem.getMedia: extended;
var
  Cont: integer;
  Soma: extended;
begin
  Soma := 0;

  if Length(FValores)=0 then
  begin
    Result := 0;
  end
  else
  begin
    for Cont := 0 to Length(FValores)-1 do
    begin
      Soma := Soma+FValores[Cont];
    end;

    Result := Soma / Length(FValores);
  end;
end;

function TItem.getVarianciaPopulacional: Double;
var
  Media: extended;
  Cont: Integer;
  Auxiliar: extended;

begin
  Media := getMedia;
  Auxiliar := 0;

  if (Media=0) or (Length(FValores)=1) then
  begin
    Result := 0;
  end
  else
  begin
    for Cont := 0 to Length(FValores)-1 do
    begin
      Auxiliar := Auxiliar+Sqr(FValores[Cont]-Media);
    end;

    Result := Auxiliar / Length(FValores);
  end;
end;

end.
