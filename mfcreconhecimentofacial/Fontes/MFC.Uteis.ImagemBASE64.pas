// Desenvolvido por Marcio Fernandes Cruz - Março / 2015
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/


unit MFC.Uteis.ImagemBASE64;

interface

uses
  Vcl.Graphics,
  Soap.EncdDecd,
  System.SysUtils,
  System.NetEncoding,
  Vcl.Imaging.pngimage,
  System.Classes,
  System.ZLib;

type
  TImagemBase64 = class(TObject)
  private
    function StringToBytesStream(const base64: string):TBytesStream;
  public
    function FileTOBMP(Caminho: String):TBitMap;
    function StringToBmp(const base64: string): TBitmap;
    function BMPToString(BitMap: TBitMap):String;

    function FileTOPNG(Caminho: String):TPngImage;
    function StringToPNG(const base64: string): TPngImage;
    function PNGToString(PNGImage: TPNGImage):String;

  end;

implementation

uses
  Dialogs;

function TImagemBase64.BMPToString(BitMap: TBitMap):String;
var
  StreamImagem: TMemoryStream;
  StringStream: TStringStream;
begin
  StreamImagem := nil;
  StringStream := nil;
  try
    StreamImagem := TMemoryStream.Create;
    BitMap.SaveToStream(StreamImagem);
    StreamImagem.Position := 0;

    ShowMessage('StreamBMP ' +IntToStr(StreamImagem.Size));

    StringStream := TStringStream.Create;
    TBase64Encoding.Base64.Encode(StreamImagem, StringStream);

    StringStream.Position := 0;

    Result := StringStream.DataString;
  finally
    FreeAndNil(StringStream);
    FreeAndNil(StreamImagem);
  end;
end;

function TImagemBase64.FileTOBMP(Caminho: String): TBitMap;
begin
  try
    Result := TBitMap.Create;
    Result.LoadFromFile(Caminho);
  except
    on E:Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

function TImagemBase64.FileTOPNG(Caminho: String): TPngImage;
begin
  try
    Result := TPngImage.Create;
    Result.LoadFromFile(Caminho);
  except
    on E:Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

function TImagemBase64.PNGToString(PNGImage: TPNGImage): String;
var
  StreamImagem: TMemoryStream;
  StringStream: TStringStream;
begin
  StreamImagem := nil;
  StringStream := nil;
  try
    StreamImagem := TMemoryStream.Create;
    PNGImage.SaveToStream(StreamImagem);
    StreamImagem.Position := 0;

    ShowMessage('StreamPNG ' +IntToStr(StreamImagem.Size));

    StringStream := TStringStream.Create;
    TBase64Encoding.Base64.Encode(StreamImagem, StringStream);

    StringStream.Position := 0;

    Result := StringStream.DataString;
  finally
    FreeAndNil(StringStream);
    FreeAndNil(StreamImagem);
  end;
end;

function TImagemBase64.StringToBmp(const base64: string): TBitmap;
var
  BytesStream: TBytesStream;
begin
  BytesStream := nil;
  try
    BytesStream := StringToBytesStream(base64);

    Result := TBitmap.Create;
    try
      Result.LoadFromStream(BytesStream);
    except
      Result.Free;
      raise;
    end;
  finally
    FreeAndNil(BytesStream);
  end;
end;

function TImagemBase64.StringToBytesStream(const base64: string): TBytesStream;
var
  Input: TStringStream;
begin
  Input := nil;
  Result := nil;

  try
    Input := TStringStream.Create(base64, TEncoding.ASCII);

    try
      Result := TBytesStream.Create;
      Soap.EncdDecd.DecodeStream(Input, Result);
      Result.Position := 0;
    except
      on E:Exception do
      begin
        FreeAndNil(Input);
        raise;
      end;
    end;
  finally
    FreeAndNil(Input);
  end;
end;

function TImagemBase64.StringToPNG(const base64: string): TPngImage;
var
  BytesStream: TBytesStream;
begin
  BytesStream := nil;
  try
    BytesStream := StringToBytesStream(base64);

    Result := TPngImage.Create;
    try
      Result.LoadFromStream(BytesStream);
    except
      Result.Free;
      raise;
    end;
  finally
    FreeAndNil(BytesStream);
  end;
end;

end.
