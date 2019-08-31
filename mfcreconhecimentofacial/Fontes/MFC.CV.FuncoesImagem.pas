// Desenvolvido por Marcio Fernandes Cruz - Março / 2015
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/


unit MFC.CV.FuncoesImagem;

interface

uses
  ocv.imgproc_c,
  ocv.imgproc.types_c,
  ocv.core.types_c,
  ocv.core_c,
  ocv.highgui_c,
  ocv.objdetect_c,
  ocv.utils,
  ocv.cls.contrib,
  ocv.legacy,
  Soap.EncdDecd,
  Vcl.Imaging.pngimage,
  MFC.Modelo.Tipos,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Math,
  Vcl.Graphics,
  Vcl.Controls,
  System.NetEncoding,
  Vcl.Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  jpeg,
  TlHelp32,
  Winapi.ActiveX;

type
  // PRGB24 = ^TRGB24;

  TRGB24 = record
    B, G, R: Byte;
  end;

  PRGBArray = ^TRGBArray;
  TRGBArray = array [0 .. 0] of TRGB24;
  THistogram = array [0 .. 255] of Byte;

type
  TFuncoesImagem = class(TObject)
  private
    function StringToBytesStream(const base64: string): TBytesStream;

    procedure fxHistCalc(src: TBitmap; var histR, HistG, HistB: THistogram);

    function CalcImgSize(w, h, tw, th: Integer): TPoint;

    procedure SmoothReSize(src, Dest: TBitmap);

    procedure fxHistEqu(src: TBitmap; z: single);

  public
    constructor Create;
    destructor Destroy; override;

    procedure getImagemEscalonada(BMPEntrada: TBitMap; BMPSaida: TBitMap);
    procedure getImagemEscalaCinza(BMPEntrada: TBitMap; BMPSaida: TBitMap);
    procedure DoBCSHistogram(img: TBitmap; imgDest: TBitmap; adjust: Float);

    function BitmapToImageGray(BMPEntrada: TBitMap):pIplImage;


    function FileTOBMP(Caminho: String): TBitmap;
    function StringToBmp(const base64: string): TBitmap;
    function BMPToString(BitMap: TBitmap): String;

    function FileTOPNG(Caminho: String): TPngImage;
    function StringToPNG(const base64: string): TPngImage;
    function PNGToString(pngimage: TPngImage): String;

    procedure SalvarBMPTeste(pIplImage: pIplImage; Arquivo: String);
  end;

implementation

function TFuncoesImagem.BMPToString(BitMap: TBitmap): String;
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

    StringStream := TStringStream.Create;
    TBase64Encoding.base64.Encode(StreamImagem, StringStream);

    StringStream.Position := 0;

    Result := StringStream.DataString;
  finally
    FreeAndNil(StringStream);
    FreeAndNil(StreamImagem);
  end;
end;

function TFuncoesImagem.CalcImgSize(w, h, tw, th: Integer): TPoint;
begin
  Result.x := 0;
  Result.y := 0;
  if (w < tw) and (h < th) then
  begin
    Result.x := w;
    Result.y := h;
  end
  else if (w = 0) or (h = 0) then
    Exit
  else
  begin
    if w > h then
    begin
      if w < tw then
        tw := w;
      Result.x := tw;
      Result.y := Trunc(tw * h / w);
      if Result.y > th then
      begin
        Result.y := th;
        Result.x := Trunc(th * w / h);
      end;
    end
    else
    begin
      if h < th then
        th := h;
      Result.y := th;
      Result.x := Trunc(th * w / h);
      if Result.x > tw then
      begin
        Result.x := tw;
        Result.y := Trunc(tw * h / w);
      end;
    end;
  end;
end;

procedure TFuncoesImagem.SalvarBMPTeste(pIplImage: pIplImage; Arquivo: String);
var
  Teste: TBitMap;
begin
  try
    Teste := TBitmap.Create;
    Teste.PixelFormat := pf24bit;
    IplImage2Bitmap(pIplImage, Teste);
    Teste.SaveToFile(Arquivo);
  finally
    FreeAndNil(teste);
  end;
end;

procedure TFuncoesImagem.SmoothReSize(src, Dest: TBitmap);
var
  x, y, px, py: Integer;
  i, x1, x2, z, z2, iz2: Integer;
  w1, w2, w3, w4: Integer;
  Ratio: Integer;
  sDst, sDstOff: Integer;
  sScanLine: Array of PRGBArray;
  Src1, Src2: PRGBArray;
  C, C1, C2: TRGB24;
begin
  sDst := Integer(src.ScanLine[0]);
  sDstOff := Integer(src.ScanLine[1]) - Integer(sDst);
  SetLength(sScanLine, src.Height);
  for i := 0 to src.Height - 1 do
  begin
    sScanLine[i] := PRGBArray(sDst);
    sDst := sDst + sDstOff;
  end;
  sDst := Integer(Dest.ScanLine[0]);
  sDstOff := Integer(Dest.ScanLine[1]) - sDst;
  Ratio := ((src.Width - 1) shl 15) div Dest.Width;
  py := 0;
  for y := 0 to Dest.Height - 1 do
  begin
    Src1 := sScanLine[py shr 15];
    if py shr 15 < src.Height - 1 then
      Src2 := sScanLine[py shr 15 + 1]
    else
      Src2 := Src1;
    z2 := py and $7FFF;
    iz2 := $8000 - z2;
    px := 0;
    for x := 0 to Dest.Width - 1 do
    begin
      x1 := px shr 15;
      x2 := x1 + 1;
      C1 := Src1[x1];
      C2 := Src2[x1];
      z := px and $7FFF;
      w2 := (z * iz2) shr 15;
      w1 := iz2 - w2;
      w4 := (z * z2) shr 15;
      w3 := z2 - w4;
      C.R := (C1.R * w1 + Src1[x2].R * w2 + C2.R * w3 + Src2[x2].R * w4) shr 15;
      C.G := (C1.G * w1 + Src1[x2].G * w2 + C2.G * w3 + Src2[x2].G * w4) shr 15;
      C.B := (C1.B * w1 + Src2[x2].B * w2 + C2.B * w3 + Src2[x2].B * w4) shr 15;
      PRGBArray(sDst)[x] := C;
      inc(px, Ratio);
    end;
    sDst := sDst + sDstOff;
    inc(py, Ratio);
  end;
  SetLength(sScanLine, 0);
end;

function TFuncoesImagem.StringToBmp(const base64: string): TBitmap;
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

function TFuncoesImagem.StringToBytesStream(const base64: string): TBytesStream;
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
      on E: Exception do
      begin
        FreeAndNil(Input);
        raise;
      end;
    end;
  finally
    FreeAndNil(Input);
  end;
end;

function TFuncoesImagem.StringToPNG(const base64: string): TPngImage;
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

procedure TFuncoesImagem.fxHistCalc(src: TBitmap;
  var histR, HistG, HistB: THistogram);
var
  RGB: PRGBArray;
  x, y: Integer;
begin
  for x := 0 to 255 do
  begin
    histR[x] := 0;
    HistG[x] := 0;
    HistB[x] := 0;
  end;
  for y := 0 to src.Height - 1 do
  begin
    RGB := src.ScanLine[y];
    for x := 0 to src.Width - 1 do
    begin
      inc(histR[RGB[x].R]);
      inc(HistG[RGB[x].G]);
      inc(HistB[RGB[x].B]);
    end;
  end;
end;

procedure TFuncoesImagem.fxHistEqu(src: TBitmap; z: single);
type
  THistSingle = array [0 .. 255] of single;
var
  RGB: PRGBArray;
  x, y: Integer;
  q1, q2, q3: single;
  histR, HistG, HistB: THistogram;
  Hist, VCumSumR, VCumSumG, VCumSumB: THistSingle;
  G, B, cy, ccr, ccb: Byte;

  function CumSum(Hist: THistSingle): THistSingle;
  var
    x: Byte;
    Temp: THistSingle;
  begin
    Temp[0] := Hist[0];
    for x := 1 to 255 do
      Temp[x] := Temp[x - 1] + Hist[x];
    CumSum := Temp;
  end;

begin
  fxHistCalc(src, histR, HistG, HistB);
  q1 := 0; // Canal Vermelho
  for x := 0 to 255 do
  begin
    Hist[x] := power(histR[x], z);
    q1 := q1 + Hist[x];
  end;
  VCumSumR := CumSum(Hist);
  q2 := 0; // Canal Verde
  for x := 0 to 255 do
  begin
    Hist[x] := power(HistG[x], z);
    q2 := q2 + Hist[x];
  end;
  VCumSumG := CumSum(Hist);
  q3 := 0; // Canal Azul
  for x := 0 to 255 do
  begin
    Hist[x] := power(HistB[x], z);
    q3 := q3 + Hist[x];
  end;
  VCumSumB := CumSum(Hist);
  for y := 0 to src.Height - 1 do
  begin
    RGB := src.ScanLine[y];
    for x := 0 to src.Width - 1 do
    begin
      RGB[x].R := Trunc((255 / q1) * VCumSumR[RGB[x].R]);
      RGB[x].G := Trunc((255 / q2) * VCumSumG[RGB[x].G]);
      RGB[x].B := Trunc((255 / q3) * VCumSumB[RGB[x].B]);
    end;
  end;
end;

procedure TFuncoesImagem.getImagemEscalonada(BMPEntrada: TBitMap; BMPSaida: TBitMap);
var
  Fsize: TCvSize;
  ipllivefaceshow,
  FColorSaveFace: pIplImage;

begin
  try
    Fsize := cvSize(C_Width, C_Height);

    FColorSaveFace := cvCreateImage(FSize, IPL_DEPTH_8U, 3); // 3 porque está original

    ipllivefaceshow := BitmapToIplImage(BMPEntrada);
    cvResize(ipllivefaceshow, FColorSaveFace, CV_INTER_LINEAR);

    IplImage2Bitmap(FColorSaveFace, BMPSaida);
  finally
    cvReleaseImage(ipllivefaceshow);
    cvReleaseImage(FColorSaveFace);
  end;
end;

procedure TFuncoesImagem.getImagemEscalaCinza(BMPEntrada: TBitMap; BMPSaida: TBitMap);
var
  FColorSaveFace,
  FGraySaveFace: pIplImage;
  Fsize: TCvSize;
begin
  try
    Fsize := cvSize(C_Width, C_Height);
    FGraySaveFace := cvCreateImage(FSize, IPL_DEPTH_8U, 1);
    FColorSaveFace := cvCreateImage(FSize, IPL_DEPTH_8U, 3);

    FColorSaveFace := BitmapToIplImage(BMPEntrada);
    cvCvTColor(FColorSaveFace, FGraySaveFace, Cv_BGR2GRAY);
    IplImage2Bitmap(FGraySaveFace, BMPSaida);
  finally
    cvReleaseImage(FColorSaveFace);
    cvReleaseImage(FGraySaveFace);
  end;
end;

function TFuncoesImagem.BitmapToImageGray(BMPEntrada: TBitMap):pIplImage;
var
  Fsize: TCvSize;
  Auxiliar: pIplImage;
begin
  try
    Fsize := cvSize(C_Width, C_Height);
    Auxiliar := BitmapToIplImage(BMPEntrada);
    Result := cvCreateImage(FSize, IPL_DEPTH_8U, 1);
    cvCvTColor(Auxiliar, Result, Cv_BGR2GRAY);
  finally
    cvReleaseImage(Auxiliar);
  end;
end;

function TFuncoesImagem.PNGToString(pngimage: TPngImage): String;
var
  StreamImagem: TMemoryStream;
  StringStream: TStringStream;
begin
  StreamImagem := nil;
  StringStream := nil;
  try
    StreamImagem := TMemoryStream.Create;
    pngimage.SaveToStream(StreamImagem);
    StreamImagem.Position := 0;

    ShowMessage('StreamPNG ' + IntToStr(StreamImagem.Size));

    StringStream := TStringStream.Create;
    TBase64Encoding.base64.Encode(StreamImagem, StringStream);

    StringStream.Position := 0;

    Result := StringStream.DataString;
  finally
    FreeAndNil(StringStream);
    FreeAndNil(StreamImagem);
  end;
end;

constructor TFuncoesImagem.Create;
begin
  inherited;
end;

destructor TFuncoesImagem.Destroy;
begin
  inherited;
end;

procedure TFuncoesImagem.DoBCSHistogram(img: TBitmap; imgDest: TBitmap;
  adjust: Float);
var
  tmp, bmp: TBitmap;
  pt: TPoint;
begin
  try
    bmp := TBitmap.Create;
    bmp.Assign(img);
    bmp.PixelFormat := pf24Bit;

    tmp := TBitmap.Create;
    tmp.PixelFormat := pf24Bit;

    pt := CalcImgSize(bmp.Width, bmp.Height, imgDest.Width, imgDest.Height);

    tmp.Width := pt.x;
    tmp.Height := pt.y;

    SmoothReSize(bmp, tmp);

    fxHistEqu(tmp, adjust);

    imgDest.Assign(tmp);
  finally
    bmp.FreeImage;
    FreeAndNil(bmp);
    FreeAndNil(tmp);
  end;
end;

function TFuncoesImagem.FileTOBMP(Caminho: String): TBitmap;
begin
  try
    Result := TBitmap.Create;
    Result.LoadFromFile(Caminho);
  except
    on E: Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

function TFuncoesImagem.FileTOPNG(Caminho: String): TPngImage;
begin
  try
    Result := TPngImage.Create;
    Result.LoadFromFile(Caminho);
  except
    on E: Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

end.
