unit uVerCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Menus, Vcl.ImgList, System.ImageList, Data.DB,
  Vcl.Buttons, Vcl.DBCtrls, System.Actions, Vcl.ActnList,
  VCL.Imaging.jpeg,
  System.ZLib,
  MFC.Uteis.GerenciaRefObjeto,
  MFC.CV.FuncoesImagem,
  MFC.DM.CadastroEntidade,
  MFC.Modelo.Tipos,
  System.Generics.Collections,
  Vcl.Imaging.pngimage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls;

type
  TfrmVerCadastro = class(TForm)
    pnlBase: TPanel;
    pnlDadosEntidade: TPanel;
    GroupBox1: TGroupBox;
    DBText1: TDBText;
    pnlBottom: TPanel;
    pnlBotoes: TPanel;
    SpeedButton2: TSpeedButton;
    dsEntidade: TDataSource;
    ActionList1: TActionList;
    actFechar: TAction;
    dsFotos: TDataSource;
    ImageList1: TImageList;
    grbFaceArmazenada: TGroupBox;
    scrollImagensArmazenadas: TScrollBox;
    GroupBox2: TGroupBox;
    scrollImagemEscalaCinza: TScrollBox;
    GroupBox3: TGroupBox;
    scrollImagemHistograma: TScrollBox;
    procedure actFecharExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FDMCadastroEntidade: TDMEntidade;
    FIDDispositivoVideo: Integer;

    FFuncoesImagem: TFuncoesImagem;

    FIndiceImagem: SmallInt;
    FIndiceFotoAtual: Smallint;

    FIDEntidade: Integer;

    FFaceArmazenada: TDictionary<SmallInt,TBitMap>;
    FImageArmazenada: TDictionary<SmallInt,TImage>;
    FImagemEscalaCinza: TDictionary<SmallInt,TImage>;
    FImagemHistograma: TDictionary<SmallInt,TImage>;

    function getIndiceFoto: SmallInt;
    function getIndiceImagem: SmallInt;

    procedure CarregarBanco;
  public
    property IDEntidade: Integer read FIDEntidade write FIDEntidade;
    property DMCadastroEntidade: TDMEntidade read FDMCadastroEntidade write FDMCadastroEntidade;
    property IDDispositivoVideo: Integer read FIDDispositivoVideo write FIDDispositivoVideo;
  end;

implementation

{$R *.dfm}

procedure TfrmVerCadastro.CarregarBanco;
var
  BMP: TBitMap;
  BMPEscalaCinza: TBitmap;
  BMPHistograma: TBitmap;
  IndiceImagem,
  Cont: Integer;
begin
  DMCadastroEntidade.cdsImagemEntidade.Close;
  DMCadastroEntidade.cdsImagemEntidade.Params.ParamByName('ENTIDADE').AsInteger := FIDEntidade;
  DMCadastroEntidade.cdsImagemEntidade.Open;

  Cont := 0;
  while (not DMCadastroEntidade.cdsImagemEntidade.Eof) and (Cont<=C_MaximoFotosDB) do
  begin
    if Trim(DMCadastroEntidade.cdsImagemEntidadeFACE.AsString)<>'' then
    begin
      BMP := nil;
      BMPEscalaCinza := nil;
      BMPHistograma := nil;
      try
        try
          BMPEscalaCinza := TBitmap.Create;
          BMPEscalaCinza.PixelFormat := pf24bit;

          BMPHistograma:= TBitmap.Create;

          BMP := FFuncoesImagem.StringToBmp(DMCadastroEntidade.cdsImagemEntidadeFACE.AsString);

          FFaceArmazenada.Items[getIndiceFoto].Assign(BMP);

          FFuncoesImagem.getImagemEscalonada(BMP, BMPEscalaCinza);

          FFuncoesImagem.getImagemEscalaCinza(BMPEscalaCinza, BMPEscalaCinza);

          BMPHistograma.Assign(BMPEscalaCinza);
          FFuncoesImagem.DoBCSHistogram(BMPEscalaCinza, BMPHistograma, C_FatorHistograma);

          IndiceImagem := getIndiceImagem;
          FImageArmazenada.Items[IndiceImagem].Picture.Assign(BMP);
          FImagemEscalaCinza.Items[IndiceImagem].Picture.Assign(BMPEscalaCinza);
          FImagemHistograma.Items[IndiceImagem].Picture.Assign(BMPHistograma);

          inc(Cont);
        finally
          FreeAndNil(BMP);
          FreeAndNil(BMPEscalaCinza);
          FreeAndNil(BMPHistograma);
        end;
      except

      end;
    end;

    DMCadastroEntidade.cdsImagemEntidade.Next;
  end;
end;

procedure TfrmVerCadastro.FormCreate(Sender: TObject);
var
  cont: Integer;
begin
  Self.Width := Trunc(Screen.Width*0.9);

  FFuncoesImagem := TGerenciaRefObjeto<TFuncoesImagem>.Create(TFuncoesImagem.Create).Instancia;

  FImageArmazenada := TDictionary<SmallInt,TImage>.Create;
  FImagemEscalaCinza := TDictionary<SmallInt,TImage>.Create;
  FImagemHistograma := TDictionary<SmallInt,TImage>.Create;

  FFaceArmazenada := TDictionary<SmallInt,TBitMap>.Create;

  FIndiceImagem := 0;
  FIndiceFotoAtual := 0;

  for cont := 1 to C_MaximoFotosDB do
  begin
    FFaceArmazenada.Add(Cont, TBitMap.Create);
    FFaceArmazenada.Items[Cont].SetSize(C_Width, C_Height);
  end;

  for cont := 1 to C_MaximoFotosDB do
  begin
    FImageArmazenada.Add(Cont, TImage.Create(scrollImagensArmazenadas));
    FImageArmazenada.Items[Cont].Parent := scrollImagensArmazenadas;
    FImageArmazenada.Items[Cont].Width := 60;
    FImageArmazenada.Items[Cont].Height := 60;
    FImageArmazenada.Items[Cont].Align := alLeft;
    FImageArmazenada.Items[Cont].Stretch := True;

    FImagemEscalaCinza.Add(Cont, TImage.Create(scrollImagemEscalaCinza));
    FImagemEscalaCinza.Items[Cont].Parent := scrollImagemEscalaCinza;
    FImagemEscalaCinza.Items[Cont].Width := 60;
    FImagemEscalaCinza.Items[Cont].Height := 60;
    FImagemEscalaCinza.Items[Cont].Align := alLeft;
    FImagemEscalaCinza.Items[Cont].Stretch := True;

    FImagemHistograma.Add(Cont, TImage.Create(scrollImagemHistograma));
    FImagemHistograma.Items[Cont].Parent := scrollImagemHistograma;
    FImagemHistograma.Items[Cont].Width := 60;
    FImagemHistograma.Items[Cont].Height := 60;
    FImagemHistograma.Items[Cont].Align := alLeft;
    FImagemHistograma.Items[Cont].Stretch := True;
  end;
end;

procedure TfrmVerCadastro.FormDestroy(Sender: TObject);
var
  cont: Integer;
begin
  for cont := 1 to C_MaximoFotosDB  do
  begin
    FImageArmazenada.Items[Cont].Free;
    FImagemEscalaCinza.Items[Cont].Free;
    FImagemHistograma.Items[Cont].Free;
  end;
  FreeAndNil(FImageArmazenada);
  FreeAndNil(FImagemEscalaCinza);
  FreeAndNil(FImagemHistograma);

  for cont := 1 to C_MaximoFotosDB do
  begin
    FFaceArmazenada.Items[Cont].Free;
  end;
  FreeAndNil(FFaceArmazenada);
end;

procedure TfrmVerCadastro.FormShow(Sender: TObject);
begin
  dsEntidade.DataSet := DMCadastroEntidade.cdsEntidade;
  CarregarBanco;
end;

function TfrmVerCadastro.getIndiceFoto: SmallInt;
begin
  if FIndiceFotoAtual>=C_MaximoFotosDB then
  begin
    FIndiceFotoAtual := 1;
  end
  else
  begin
    inc(FIndiceFotoAtual);
  end;

  Result := FIndiceFotoAtual;
end;

function TfrmVerCadastro.getIndiceImagem: SmallInt;
begin
  if FIndiceImagem>=C_MaximoFotosDB then
  begin
    FIndiceImagem := 1;
  end
  else
  begin
    inc(FIndiceImagem);
  end;

  Result := FIndiceImagem;
end;

procedure TfrmVerCadastro.actFecharExecute(Sender: TObject);
begin
  Close;
end;

end.

