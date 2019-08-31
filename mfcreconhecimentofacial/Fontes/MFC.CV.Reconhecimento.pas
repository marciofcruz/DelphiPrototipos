// Desenvolvido por Marcio Fernandes Cruz - Março / 2015
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/


unit MFC.CV.Reconhecimento;

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
  System.Generics.Collections,
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
  jpeg,
  TlHelp32,
  Winapi.ActiveX,
  Vcl.ComCtrls, Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList, PsAPI,
  Vcl.Buttons;

type
  TVotos = class
    Lab: Integer;
    Quantidade: Integer;
  end;
type
  TCVReconhecimento = class(TObject)
  private
    fimages: TInputArrayOfIplImage;
    flabelEntidade: TInputArrayOfInteger;
    Fsize: TCvSize;

    FQuantidadeEntidadesComFoto: Integer;

    FFuncoesImagem: TFuncoesImagem;

    Fischer: IFaceRecognizer;
    Lbph: IFaceRecognizer;
    Eigen: IFaceRecognizer;

    FIndiceInclusao: Smallint;
    FComponentesFischerFace: Integer;
    FThreSholdFischerFace: Double;
    FThreSholdLBPH: Double;
    FComponentesEigenFace: Integer;
    FThreSholdEigenFace: Double;
  public
    constructor Create(AHandle: THandle); reintroduce;
    destructor Destroy; override;

    procedure AdicionarImagem(AEntidade: Integer; Bmp: TBitMap);
    procedure ConfiguracaoInicial(const QuantidadeEntidadesComFoto: Integer);

    function VerificarLBPH(FaceAVerificar: pIplImage):TPredicao;
    function VerificarFischerFace(FaceAVerificar: pIplImage):TPredicao;
    function VerificarEigenFace(FaceAVerificar: pIplImage):TPredicao;

    function VerificarProvavelEntidade(BMPEscalaCinza: TBitMap; APastaLog: string): TPredicao;

    function getQtdeFaces:Integer;

    property ComponentesFischerFace: Integer read FComponentesFischerFace write FComponentesFischerFace;
    property ThreSholdFischerFace: Double read FThreSholdFischerFace write FThreSholdFischerFace;
    property ThreSholdLBPH: Double read FThreSholdLBPH write FThreSholdLBPH;

    property ComponentesEigenFace: Integer read FComponentesEigenFace write FComponentesEigenFace;
    property ThreSholdEigenFace: Double read FThreSholdEigenFace write FThreSholdEigenFace;
  end;

// threadvar Lbph: IFaceRecognizer;

implementation

procedure TCVReconhecimento.AdicionarImagem(AEntidade: Integer; Bmp: TBitMap);
var
  FColorSaveFace: pIplImage;
begin
  inc(FIndiceInclusao);

  SetLength(fimages, Length(fimages)+1);
  SetLength(flabelEntidade, Length(flabelEntidade)+1);

  try
    fimages[FIndiceInclusao] := cvCreateImage(Fsize, IPL_DEPTH_8U, 1);

    FColorSaveFace := BitmapToIplImage(Bmp);

    cvCvTColor(FColorSaveFace, fimages[FIndiceInclusao], Cv_BGR2GRAY);
    flabelEntidade[FIndiceInclusao] := AEntidade;
  finally
    cvReleaseImage(FColorSaveFace);

    Bmp.FreeImage;
    FreeAndNil(Bmp);
  end;
end;

procedure TCVReconhecimento.ConfiguracaoInicial(const QuantidadeEntidadesComFoto: Integer);
begin
  FQuantidadeEntidadesComFoto := QuantidadeEntidadesComFoto;

  if length(FLabelEntidade)=0 then
  begin
    raise Exception.Create('Nenhuma imagem adicionada!');
  end;

  Lbph:= TFaceRecognizer.createLBPHFaceRecognizer(1, 8, 8, 8, FThreSholdLBPH); //select 1                 //PAULO

  if FComponentesFischerFace>0 then
  begin
    if FThreSholdFischerFace=0 then
    begin
      Fischer := TFaceRecognizer.createFISHERFaceRecognizer(FComponentesFischerFace);
    end
    else
    begin
      Fischer := TFaceRecognizer.createFISHERFaceRecognizer(FComponentesFischerFace, FThreSholdFischerFace);
    end;
  end
  else
  begin
    Fischer := TFaceRecognizer.createFISHERFaceRecognizer;
  end;

  if FComponentesEigenFace>0 then
  begin
    if FThreSholdEigenFace=0 then
    begin
      Eigen := TFaceRecognizer.createEIGENFaceRecognizer(FComponentesEigenFace);
    end
    else
    begin
      Eigen := TFaceRecognizer.createEIGENFaceRecognizer(FComponentesEigenFace, FThreSholdEigenFace);
    end;
  end
  else
  begin
    Eigen := TFaceRecognizer.createEIGENFaceRecognizer;
  end;

  Lbph.Train(fimages, flabelEntidade);

  if (QuantidadeEntidadesComFoto > 1) then
  begin
    Fischer.Train(fimages, flabelEntidade);
    Eigen.Train(fimages, flabelEntidade);
  end;
end;

constructor TCVReconhecimento.Create(AHandle: THandle);
begin
  inherited Create;

  FFuncoesImagem := TGerenciaRefObjeto<TFuncoesImagem>.Create(TFuncoesImagem.Create).Instancia;

  Fsize := cvSize(C_Width, C_Height);

  SetLength(fimages, 0);
  SetLength(FLabelEntidade, 0);

  FIndiceInclusao := -1;
end;

destructor TCVReconhecimento.Destroy;
var
  Cont: Integer;
begin
  for Cont := 0 to Length(Fimages)-1 do
  begin
    cvReleaseImage(Fimages[Cont]);
  end;

  SetLength(fimages, 0);
  SetLength(FLabelEntidade, 0);

  inherited;
end;

function TCVReconhecimento.getQtdeFaces: Integer;
begin
  Result := Length(fimages);
end;

function TCVReconhecimento.VerificarEigenFace(
  FaceAVerificar: pIplImage): TPredicao;
var
  lab: Integer;
  Confianca: Double;
begin
  if FQuantidadeEntidadesComFoto>1 then
  begin
    FillChar(Result, SizeOf(Result), 0);

    Eigen.predict(FaceAVerificar, lab, Confianca);

    if lab=-1 then
    begin
      Confianca := 0;
    end;

    if (lab<>-1) and (Confianca>0) then
    begin
      Result.lab := lab;
      Result.Confianca := Confianca;
    end;
  end;
end;

function TCVReconhecimento.VerificarFischerFace(
  FaceAVerificar: pIplImage): TPredicao;
var
  lab: Integer;
  Confianca: Double;
begin
  if FQuantidadeEntidadesComFoto>1 then
  begin
    FillChar(Result, SizeOf(Result), 0);

    FFuncoesImagem.SalvarBMPTeste(FaceAVerificar, 'c:\temp\testes\FaceAVerificar.bmp');

    Fischer.predict(FaceAVerificar, lab, Confianca);

    if lab=-1 then
    begin
      Confianca := 0;
    end;

    if (lab<>-1) and (Confianca>0) then
    begin
      Result.lab := lab;
      Result.Confianca := Confianca;
    end;
  end;
end;

function TCVReconhecimento.VerificarLBPH(
  FaceAVerificar: pIplImage): TPredicao;
var
  lab: Integer;
  Confianca: Double;
begin
  FillChar(Result, SizeOf(Result), 0);

  Lbph.predict(FaceAVerificar, lab, Confianca);

  if lab=-1 then
  begin
    Confianca := 0;
  end;

  if (lab<>-1) and (Confianca>0) then
  begin
    Result.lab := lab;
    Result.Confianca := Confianca;
  end;
end;

function TCVReconhecimento.VerificarProvavelEntidade(BMPEscalaCinza: TBitMap; APastaLog: string): TPredicao;
var
  Eigen, Fischer, LBPH: TPredicao;
  FaceEscalaHistograma: pIplImage;
  Eleicao: TDictionary<Integer, TVotos>;
  Cont: Integer;
  VotosAtuais: Integer;
  LabProvavel: Integer;
  Votos: TVotos;

  procedure AddMemo(Valor: String);
  var
    Arquivo: TextFile;
  begin
    try
      AssignFile(Arquivo, APastaLog+'reconhecimento.csv');

      if FileExists(APastaLog+'reconhecimento.csv') then
      begin
        Append(Arquivo);
      end
      else
      begin
        rewrite(Arquivo);
      end;

      writeln(Arquivo, Valor);

      Flush(Arquivo);
      CloseFile(Arquivo);
    finally
    end;
  end;

  procedure AdicionarVoto(Lab: Integer);
  var
    Votos: TVotos;
  begin
    if Eleicao.TryGetValue(lab, Votos) then
    begin
      Eleicao.Items[Lab].Quantidade := Eleicao.Items[Lab].Quantidade+1;
    end
    else
    begin
      Eleicao.Add(lab, TVotos.Create);
      Eleicao.Items[Lab].Lab := Lab;
      Eleicao.Items[Lab].Quantidade := 1;
    end;
  end;

begin
  Result.Confianca := 0;
  Result.lab := -1;

  Eleicao := nil;
  FaceEscalaHistograma := nil;
  try
    Eleicao := TDictionary<Integer, TVotos>.Create;

    FaceEscalaHistograma:= cvCreateImage(FSize, IPL_DEPTH_8U, 1);

    FFuncoesImagem.DoBCSHistogram(BMPEscalaCinza, BMPEscalaCinza, C_FatorHistograma);

    FaceEscalaHistograma:= FFuncoesImagem.BitmapToImageGray(BMPEscalaCinza);

    LBPH := VerificarLBPH(FaceEscalaHistograma);
    Fischer := VerificarFischerFace(FaceEscalaHistograma);
    Eigen := VerificarEigenFace(FaceEscalaHistograma);

    if LBPH.lab>0 then
    begin
      AdicionarVoto(LBPH.lab);
    end;
    if Fischer.lab>0 then
    begin
      AdicionarVoto(Fischer.lab);
    end;
    if Eigen.lab>0 then
    begin
      AdicionarVoto(Eigen.lab);
    end;

    VotosAtuais := 0;
    LabProvavel := 0;
    for Votos in Eleicao.Values do
    begin
      if Votos.Quantidade>VotosAtuais then
      begin
        LabProvavel := Votos.Lab;
        VotosAtuais := Votos.Quantidade;
      end;
    end;

    if VotosAtuais>1 then
    begin
      Result.lab := LabProvavel;
    end;

    AddMemo(Format('Provavel: %d', [Result.lab])+' - '+
            Format('(LBPH: %d - %s)', [LBPH.lab, FloatToStr(LBPH.Confianca)])+' - '+
            Format('(Fischer: %d - %s)', [Fischer.lab, FloatToStr(Fischer.Confianca)])+' - '+
            Format('(Eigen: %d - %s)', [Eigen.lab, FloatToStr(Eigen.Confianca)]));

  finally
    if Assigned(FaceEscalaHistograma) then
    begin
      cvReleaseImage(FaceEscalaHistograma);
    end;

    for Votos in Eleicao.Values do
    begin
      Eleicao.Items[Votos.Lab].Free;
    end;
    FreeAndNil(Eleicao);
  end;
end;

end.
