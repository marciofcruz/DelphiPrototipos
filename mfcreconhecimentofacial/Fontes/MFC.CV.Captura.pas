// Desenvolvido por Marcio Fernandes Cruz - Março / 2015
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/


unit MFC.CV.Captura;

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
  MFC.Modelo.Tipos,
  MFC.CV.FuncoesImagem,
  MFC.Uteis.GerenciaRefObjeto,
  Math,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  DateUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  TlHelp32,
  Winapi.ActiveX,
  Vcl.ComCtrls, Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList, PsAPI,
  Vcl.Buttons;

type
  TDetectarFace = procedure(BitMap: TBitMap) of object;
  TProc = procedure of object;

  TCVCaptura = class(TObject)
  private
    FIDDispositivoVideo: Integer;

    FMaximoFacesSimultaneas: SmallInt;

    FIimagemSaidaCamera: TImage;

    FHandle: THandle;

    FNomeCascadeRosto: AnsiString;

    FFuncoesImagem: TFuncoesImagem;

    FCtx: pCtx;
    FFrameBitmap: TBitmap;

    FClassificadorRosto: pCvHaarClassifierCascade;

    FDetectarFace: TDetectarFace;

    FLimparResultados: TProc;

    Fsize: TCvSize;

    procedure OnIdle(Sender: TObject; var Done: Boolean);

    procedure DetectareDesenhar;
  public
    constructor Create(AHandle: THandle);
    destructor Destroy; override;

    procedure Iniciar;
    procedure Parar;

    function EstahEmExecucao: Boolean;

    property ImagemSaidaCamera: TImage read FIimagemSaidaCamera write FIimagemSaidaCamera;
    property AoDetectarFace: TDetectarFace read FDetectarFace write FDetectarFace;

    property AoLimparResultados: TProc read FLimparResultados write FLimparResultados;
    property IDDispositivoVideo: Integer read FIDDispositivoVideo write FIDDispositivoVideo;

    property MaximoFacesSimultaneas: SmallInt read FMaximoFacesSimultaneas write FMaximoFacesSimultaneas;
  end;

implementation

constructor TCVCaptura.Create(AHandle: THandle);
begin
  inherited Create;

  FCtx := nil;

  FMaximoFacesSimultaneas := 1;

  FHandle := AHandle;

  FFuncoesImagem := TGerenciaRefObjeto<TFuncoesImagem>.Create(TFuncoesImagem.Create).Instancia;

  FClassificadorRosto := nil;

  FNomeCascadeRosto := cResourceFaceDetect + 'haarcascade_frontalface_alt.xml';

  Fsize := cvSize(C_Width, C_Height);
end;

destructor TCVCaptura.Destroy;
begin
  inherited;
end;


procedure TCVCaptura.DetectareDesenhar;
var
  Cont: Integer;

  FacesEntrada: pCvSeq;
  FaceSaida: pCvRect;
  Pt1Saida, Pt2Saida: TCvPoint;

  Auxiliar: pIplImage;

  FrameEntradaInicial: pIplImage;
  FaceCapturada: pIplImage;
  FaceEscalonada: pIplImage;
  FaceEscalaCinza: pIplImage;

  AuxBMP: TBitMap;
  BMPArmazenamento: TBitmap;

  procedure DesenharRetangulo(FaceEntrada: pCvSeq; IndiceImagem: integer);
  var
    Scale: Integer;
    R: pCvRect;
    Pt1, Pt2: TCvPoint;
    Auxiliar: TCVPoint;
  begin
    Scale := 1;

    R := pCvRect(cvGetSeqElem(FaceEntrada, IndiceImagem));
    Pt1.x := R^.x * Scale;
    Pt2.x := (R^.x + R^.width) * Scale;
    Pt1.y := R^.y * Scale;
    Pt2.y := (R^.y + R^.height) * Scale;

    cvRectangle(FCtx.MyInputImage, Pt1, Pt2, CV_RGB(64, 180, 30), 3, 8, 0);
  end;


begin
  if Assigned(FClassificadorRosto) then
  begin
    FacesEntrada := cvHaarDetectObjects(FCtx.MyInputImage, FClassificadorRosto, FCtx.MyStorage, 1.2, 5,
      CV_HAAR_SCALE_IMAGE, cvSize(C_WIDTH,C_HEight), cvSize(0, 0));

    FCtx.TotalFaceDetect := FacesEntrada.total;

    for Cont := 1 to FacesEntrada^.total do
    begin
      FaceEscalonada := nil;
      BMPArmazenamento := nil;
      FaceCapturada := nil;
      FrameEntradaInicial := nil;
      FaceEscalaCinza := nil;

      try
        FaceEscalaCinza := cvCreateImage(FSize, IPL_DEPTH_8U, 1);
        FaceEscalonada := cvCreateImage(FSize, IPL_DEPTH_8U, 3); // 3 porque está original
        FrameEntradaInicial := cvCloneImage(FCtx.MyInputImage);

        DesenharRetangulo(FacesEntrada, Cont);

        if (Cont<=FMaximoFacesSimultaneas) then
        begin
          if MaximoFacesSimultaneas=1 then
          begin
            Sleep(20);
          end
          else
          begin
            Sleep(10);
          end;

          FaceSaida := pCvRect(cvGetSeqElem(FacesEntrada, Cont));

          Pt1Saida.x := FaceSaida^.x;
          Pt2Saida.x := (FaceSaida^.x + FaceSaida^.Width);
          Pt1Saida.y := FaceSaida^.y;
          Pt2Saida.y := (FaceSaida^.y + FaceSaida^.Height);

          FaceCapturada := CropIplImage(FrameEntradaInicial,
                                          CvRect(Pt1Saida.x, Pt1Saida.y, Pt2Saida.y - Pt1Saida.y, Pt2Saida.x - Pt1Saida.x));
          //FFuncoesImagem.SalvarBMPTeste(FaceCapturada, 'c:\temp\testes\FaceCapturada.bmp');

          cvResize(FaceCapturada, FaceEscalonada, CV_INTER_LINEAR);
          //FFuncoesImagem.SalvarBMPTeste(FaceEscalonada, 'c:\temp\testes\FaceEscalonada.bmp');

          cvCvTColor(FaceEscalonada, FaceEscalaCinza, Cv_BGR2GRAY);
          //FFuncoesImagem.SalvarBMPTeste(FaceEscalaCinza, 'c:\temp\testes\FaceEscalaCinza.bmp');

          if Assigned(FDetectarFace) then
          begin
            BMPArmazenamento := TBitmap.Create;
            BMPArmazenamento.PixelFormat := pf24bit;
            IplImage2Bitmap(FaceCapturada, BMPArmazenamento);

            FDetectarFace(BMPArmazenamento);

            FreeAndNil(BMPArmazenamento);
          end;
        end;
      finally
        if Assigned(FaceEscalaCinza) then
        begin
          cvReleaseImage(FaceEscalaCinza);
        end;

        if Assigned(FrameEntradaInicial) then
        begin
          cvReleaseImage(FrameEntradaInicial);
        end;

        if Assigned(FaceCapturada) then
        begin
          cvReleaseImage(FaceCapturada);
        end;

        if Assigned(FaceEscalonada) then
        begin
          cvReleaseImage(FaceEscalonada);
        end;
      end;
    end;
  end;
end;

function TCVCaptura.EstahEmExecucao: Boolean;
begin
  Result := Assigned(FCtx);
end;

procedure TCVCaptura.Iniciar;
begin
  if not Assigned(FCtx) then
  begin
    FCtx := nil;
    FCtx := AllocMem(SizeOf(TCtx));
    try
      FCtx.MyCapture := cvCreateCameraCapture(FIDDispositivoVideo);
      cvSetCaptureProperty(FCtx.MyCapture, CV_CAP_PROP_FRAME_WIDTH, 1280);
      cvSetCaptureProperty(FCtx.MyCapture, CV_CAP_PROP_FRAME_HEIGHT, 960);
    except
      on E: Exception do
      begin
        FCtx := nil;
        FreeMem(FCtx, SizeOf(TCtx));
        raise Exception.Create('Erro ao capturar inicializar camera!'#13+E.Message);
      end;
    end;

    FClassificadorRosto := cvLoad(pCVChar(@FNomeCascadeRosto[1]), 0, 0, 0);
    if not Assigned(FClassificadorRosto) then
    begin
      raise Exception.Create('Não foi possível carregar o Classificador Haar Cascade: '+FNomeCascadeRosto);
    end;

    FCtx.MyStorage := cvCreateMemStorage(524280);
    if Assigned(FCtx.MyCapture) then
    begin
      FCtx.MyInputImage := cvCreateImage(cvSize(1280, 960), IPL_DEPTH_8U, 3); // HD OUTPUT

      FFrameBitmap := TBitmap.Create;
      FFrameBitmap.PixelFormat := pf24bit;
      Application.OnIdle := OnIdle;
    end
    else
    begin
      FCtx := nil;
      FreeMem(FCtx, SizeOf(TCtx));
    end;
  end;
end;

procedure TCVCaptura.OnIdle(Sender: TObject; var Done: Boolean);
begin
  FCtx.MyInputImage := cvQueryFrame(FCtx.MyCapture);

  if Assigned(FCtx.MyInputImage) then
  begin
    if Assigned(FLimparResultados) then
    begin
      FLimparResultados;
    end;

    DetectareDesenhar;

    IplImage2Bitmap(FCtx.MyInputImage, FFrameBitmap);

    if Assigned(FIimagemSaidaCamera) then
    begin
      FIimagemSaidaCamera.Picture.Graphic := FFrameBitmap;
    end;

    Done := False;
  end
  else
  begin
    Application.OnIdle := nil;
  end;
end;

procedure TCVCaptura.Parar;
begin
  Application.OnIdle := nil;

  try
    if Assigned(FCtx) then
    begin
      if Assigned(FCtx.MyCapture) then
      begin
        cvReleaseCapture(FCtx.MyCapture);
      end;

      if Assigned(FFrameBitmap) then
      begin
        FFrameBitmap.FreeImage;
        FreeAndNil(FFrameBitmap);
      end;

      cvClearMemStorage(FCtx.MyStorage);

      FreeMem(FCtx, SizeOf(TCtx));
      FCtx := nil;
    end;
  except
    on E:Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

end.
