// Desenvolvido por Marcio Fernandes Cruz
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/

unit marciofcruz.GeoUteis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  System.Math,
  ComCtrls, ExtCtrls;

type
  TMFCGeoUteis = class(TObject)
  private
    FFormatSettings: TFormatSettings;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function LinhaReta(LatIni, LonIni, LatFim, LonFim: Extended): Extended;
    function TratarValor(s: String): double;
  end;



implementation

function TMFCGeoUteis.TratarValor(s: String): double;
var
  posicao: SmallInt;
begin
  if pos(',', s)>0 then
  begin
    posicao := pos(',', s);
  end
  else if pos('.', s)>0 then
  begin
    posicao := pos('.', s);
  end
  else
  begin
    posicao := 0;
  end;

  if posicao=0 then
  begin
    Result := 0;
  end
  else
  begin
    Result := SimpleRoundTo(StrToFloat(copy(s,1,posicao-1)+','+Copy(s, posicao+1, length(s)), FFormatSettings), -4);
  end;
end;

constructor TMFCGeoUteis.Create;
begin
  inherited;
  FFormatSettings := TFormatSettings.Create('pt-BR');
end;

destructor TMFCGeoUteis.Destroy;
begin
  inherited;
end;

function TMFCGeoUteis.LinhaReta(LatIni, LonIni, LatFim, LonFim: Extended): Extended;
var
 arcoA, arcoB, arcoC : Extended;
 auxPI : Extended;
begin
   auxPi := Pi / 180;

   arcoA := (LonFim - LonIni) * auxPi;
   arcoB := (90 - LatFim) * auxPi;
   arcoC := (90 - LatIni) * auxPi;

   // cos (a) = cos (b) . cos (c)  + sen (b) . sen (c) . cos (A)
   Result := Cos(arcoB) * Cos(arcoC) + Sin(arcoB) * Sin(arcoC) * Cos(arcoA);
   Result := (40030 * ((180 / Pi) * ArcCos(Result))) / 360;
end;

end.
