// Desenvolvido por Marcio Fernandes Cruz - Março / 2015
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/


unit MFC.Uteis.ZIP;

interface

uses
  System.SysUtils,
  System.Classes,
  System.ZLib;

type
  TZIP = class(TObject)
  private
  public
    class function Compactar(const aNivelCompactacao: TCompressionLevel; const aStrEntrada: String):String;
    class function Descompactar(const aStrEntrada: String):String;
  end;

implementation

{ TCompactacao }

class function TZIP.Compactar(const aNivelCompactacao: TCompressionLevel; const aStrEntrada: String): String;
var
  ZIP: TZCompressionStream;
  Saida: TStringStream;
  Entrada: TStringStream;
begin
  Entrada:= TStringStream.Create(aStrEntrada);
  Saida := TStringStream.Create;

  try
    try
      ZIP := TZCompressionStream.Create(aNivelCompactacao, Saida);
      ZIP.CopyFrom(Entrada, Entrada.Size);
    finally
      FreeAndNil(ZIP);
    end;

    Result := Saida.DataString;
  finally
    FreeAndNil(Entrada);
    FreeAndNil(Saida);
  end;
end;

class function TZIP.Descompactar(const aStrEntrada: String):String;
var
  Entrada,
  Saida: TStringStream;
  ZIP: TZDecompressionStream;
begin
  try
    Entrada := TStringStream.Create(aStrEntrada);
    Entrada.Position := 0;

    Saida := TStringStream.Create;

    try
      ZIP := TZDecompressionStream.Create(Entrada);
      Saida.CopyFrom(ZIP, ZIP.Size);
    finally
      FreeAndNil(ZIP);
    end;

    Result := Saida.DataString;
  finally
    FreeAndNil(Entrada);
    FreeAndNil(Saida);
  end;
end;

end.
