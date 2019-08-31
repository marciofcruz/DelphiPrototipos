unit uReconhecimento;

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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Menus, Vcl.ImgList, System.ImageList, Data.DB,
  Vcl.Buttons, Vcl.DBCtrls, System.Actions, Vcl.ActnList,
  VCL.Imaging.jpeg,
  MFC.Uteis.GerenciaRefObjeto,
  MFC.Configuracao,
  MFC.DM.CadastroEntidade,
  MFC.Modelo.Tipos,
  MFC.CV.FuncoesImagem,
  MFC.CV.Captura,
  MFC.CV.Reconhecimento,
  System.Generics.Collections,
  Vcl.Imaging.pngimage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmReconhecimento = class(TForm)
    pnlBase: TPanel;
    pnlBottom: TPanel;
    pnlBotoes: TPanel;
    SpeedButton2: TSpeedButton;
    ActionList1: TActionList;
    actFechar: TAction;
    dsFotos: TDataSource;
    ImageList1: TImageList;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    lblQtdeFacesCadastradas: TLabel;
    GroupBox2: TGroupBox;
    imgSaidaCamera: TImage;
    lbl1: TLabel;
    lblIdentificados: TLabel;
    lbl2: TLabel;
    lblNaoIdentificados: TLabel;
    lbl3: TLabel;
    lblPorcentagemAcertos: TLabel;
    lblUltimoReconhecido: TLabel;
    Label3: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actFecharExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FConfiguracao: TConfiguracao;

    Fsize: TCvSize;

    FNaoIdentificados, FIdentificados: Integer;

    FDMCadastroEntidade: TDMEntidade;
    FIDDispositivoVideo: Integer;

    FCVCaptura: TCVCaptura;
    FCVReconhecimento: TCVReconhecimento;

    FFuncoesImagem: TFuncoesImagem;

    procedure setPorcentagemAcertos;

    procedure LimparResultados;

    function CarregarBanco:Integer;

    procedure AoDetectarFace(BMP: TBitMap);
  public
    MemoReconhecimento: TMemo;

    property DMCadastroEntidade: TDMEntidade read FDMCadastroEntidade write FDMCadastroEntidade;
    property IDDispositivoVideo: Integer read FIDDispositivoVideo write FIDDispositivoVideo;
  end;

implementation

{$R *.dfm}

procedure TfrmReconhecimento.AoDetectarFace(
  BMP: TBitmap);
var
  Provavel: TPredicao;
  Auxiliar: String;
begin
  Auxiliar := '';

  FFuncoesImagem.getImagemEscalonada(BMP, BMP);
  FFuncoesImagem.getImagemEscalaCinza(BMP, BMP);

  Provavel := FCVReconhecimento.VerificarProvavelEntidade(BMP, FConfiguracao.PathConfiguracao+'\');

  if (Provavel.lab<=0) then
  begin
    inc(FNaoIdentificados);

    lblNaoIdentificados.Caption := IntToStr(FNaoIdentificados);

    lblUltimoReconhecido.Caption := '-';

    setPorcentagemAcertos;
  end
  else
  begin
    inc(FIdentificados);

    lblIdentificados.Caption := IntToStr(FIdentificados);

    setPorcentagemAcertos;

    if DMCadastroEntidade.cdsEntidade.Locate('ENTIDADE', Provavel.lab, []) then
    begin
      Auxiliar := Auxiliar+'PROVAVEL: '+IntToStr(Provavel.lab)+' -'+DMCadastroEntidade.cdsEntidadeNOMECOMPLETO.AsString;

      lblUltimoReconhecido.Caption := DMCadastroEntidade.cdsEntidadeNOMECOMPLETO.AsString;
    end;

    MemoReconhecimento.Lines.Add(Auxiliar);
  end;
end;

function TfrmReconhecimento.CarregarBanco:Integer;
var
  Cont: Integer;
  BMP: TBitMap;
  FacesPorEntidade: Integer;
begin
  try
    Result := 0;

    FacesPorEntidade := FConfiguracao.FacesPorEntidade;

    FDMCadastroEntidade.cdsEntidade.Close;
    FDMCadastroEntidade.cdsEntidade.Open;

    while not FDMCadastroEntidade.cdsEntidade.Eof do
    begin
      if FDMCadastroEntidade.cdsEntidadeQTDEIMAGENS.AsInteger<>0 then
      begin
        inc(Result);

        FDMCadastroEntidade.cdsImagemEntidade.Close;
        FDMCadastroEntidade.cdsImagemEntidade.Params.ParamByName('ENTIDADE').AsInteger := FDMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger;
        FDMCadastroEntidade.cdsImagemEntidade.Open;

        Cont := 0;
        while (not FDMCadastroEntidade.cdsImagemEntidade.Eof) and (Cont<FacesPorEntidade) do
        begin
          BMP := FFuncoesImagem.StringToBmp(FDMCadastroEntidade.cdsImagemEntidadeFACE.AsString);

          FFuncoesImagem.getImagemEscalonada(BMP, BMP);
          FFuncoesImagem.getImagemEscalaCinza(BMP, BMP);

          FFuncoesImagem.DoBCSHistogram(BMP, BMP, C_FatorHistograma);

          FCVReconhecimento.AdicionarImagem(
                                      FDMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger,
                                      BMP);

          FDMCadastroEntidade.cdsImagemEntidade.Next;
          inc(Cont);
        end;
      end;

      FDMCadastroEntidade.cdsEntidade.Next;
    end;
  finally
    FDMCadastroEntidade.cdsEntidade.First;
  end;
end;

procedure TfrmReconhecimento.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Assigned(FCVCaptura) and (not FCVCaptura.EstahEmExecucao);
end;

procedure TfrmReconhecimento.FormCreate(Sender: TObject);
begin
  lblUltimoReconhecido.Caption := '';

  FConfiguracao := TConfiguracao.Create;

  Fsize := cvSize(C_Width, C_Height);

  FNaoIdentificados := 0;
  FIdentificados := 0;

  lblIdentificados.Caption := '';
  lblNaoIdentificados.Caption := '';

  lblPorcentagemAcertos.Caption := '';

  FFuncoesImagem := TGerenciaRefObjeto<TFuncoesImagem>.Create(TFuncoesImagem.Create).Instancia;

  LimparResultados;
end;

procedure TfrmReconhecimento.setPorcentagemAcertos;
var
  Auxiliar: Double;
begin
  Auxiliar := (FIdentificados / (FIdentificados+FNaoIdentificados))*100;

  if Auxiliar>0 then
  begin
    lblPorcentagemAcertos.Caption := FormatFloat('0.0000', Auxiliar)+'%';
  end;
end;

procedure TfrmReconhecimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FConfiguracao);

  FreeAndNil(FCVReconhecimento);
  FreeAndNil(FCVCaptura);
end;

procedure TfrmReconhecimento.FormShow(Sender: TObject);
var
  QuantidadeEntidadesComFoto: Integer;
begin

  FCVReconhecimento := TCVReconhecimento.Create(Self.Handle);
  FCVReconhecimento.ComponentesEigenFace := FConfiguracao.ComponentesEigenFace;
  FCVReconhecimento.ThreSholdEigenFace := FConfiguracao.ThreSholdEigenFace;
  FCVReconhecimento.ComponentesFischerFace := FConfiguracao.ComponentesFischerFace;
  FCVReconhecimento.ThreSholdFischerFace := FConfiguracao.ThreSholdFischerFace;
  FCVReconhecimento.ThreSholdLBPH := FConfiguracao.ThreSholdLBPH;

  QuantidadeEntidadesComFoto := CarregarBanco;

  FCVReconhecimento.ConfiguracaoInicial(QuantidadeEntidadesComFoto);

  lblQtdeFacesCadastradas.Caption := IntToStr(FCVReconhecimento.getQtdeFaces);

  FCVCaptura := TCVCaptura.Create(Self.Handle);
  FCVCaptura.IDDispositivoVideo := FIDDispositivoVideo;
  FCVCaptura.ImagemSaidaCamera := imgSaidaCamera;
  FCVCaptura.AoDetectarFace := AoDetectarFace;
  FCVCaptura.AoLimparResultados := LimparResultados;
  FCVCaptura.MaximoFacesSimultaneas := 50;
  FCVCaptura.Iniciar;
end;

procedure TfrmReconhecimento.LimparResultados;
begin
end;

procedure TfrmReconhecimento.actFecharExecute(Sender: TObject);
begin
  FCVCaptura.Parar;
  Close;
end;

end.