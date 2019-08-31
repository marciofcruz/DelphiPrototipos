unit uCapturaCadastro;

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
  MFC.CV.Captura,
  System.Generics.Collections,
  Vcl.Imaging.pngimage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls;

type
  TfrmCapturaCadastro = class(TForm)
    pnlBase: TPanel;
    pnlDadosEntidade: TPanel;
    GroupBox1: TGroupBox;
    DBText1: TDBText;
    pnlBottom: TPanel;
    pnlBotoes: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    dsEntidade: TDataSource;
    ActionList1: TActionList;
    actFechar: TAction;
    actGravar: TAction;
    dsFotos: TDataSource;
    ImageList1: TImageList;
    panHeader: TPanel;
    ScrollBox1: TScrollBox;
    pnlCaptura: TPanel;
    stbFacesDetectadas: TStaticText;
    imgSaidaCamera: TImage;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actFecharExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
  private
    FDMCadastroEntidade: TDMEntidade;
    FIDDispositivoVideo: Integer;
    FCVCaptura: TCVCaptura;

    FFuncoesImagem: TFuncoesImagem;

    FIndiceImagem: SmallInt;
    FIndiceFotoAtual: Smallint;

    FIDEntidade: Integer;

    FFotos: TDictionary<SmallInt,TBitMap>;
    FFacesCapturadas: TDictionary<SmallInt,TImage>;

    function getIndiceFoto: SmallInt;
    function getIndiceImagem: SmallInt;

    procedure CarregarBanco;

    procedure AoDetectarFace(BitMap: TBitMap);
  public
    property IDEntidade: Integer read FIDEntidade write FIDEntidade;
    property DMCadastroEntidade: TDMEntidade read FDMCadastroEntidade write FDMCadastroEntidade;
    property IDDispositivoVideo: Integer read FIDDispositivoVideo write FIDDispositivoVideo;
  end;

implementation

{$R *.dfm}

procedure TfrmCapturaCadastro.actGravarExecute(Sender: TObject);
var
  Auxiliar: String;
  Cont: Smallint;
  BMP: TBitMap;
  Chave: Integer;

begin
  FCVCaptura.Parar;

  DMCadastroEntidade.cdsImagemEntidade.Close;
  DMCadastroEntidade.cdsImagemEntidade.Params.ParamByName('ENTIDADE').AsInteger := FIDEntidade;
  DMCadastroEntidade.cdsImagemEntidade.Open;

  while not DMCadastroEntidade.cdsImagemEntidade.Eof do
  begin
    DMCadastroEntidade.cdsImagemEntidade.Edit;
    DMCadastroEntidade.cdsImagemEntidadeSITUACAO.AsInteger := 0;
    DMCadastroEntidade.cdsImagemEntidade.Post;

    DMCadastroEntidade.cdsImagemEntidade.Next;
  end;

  Chave := DMCadastroEntidade.getChaveImagemEntidade;
  for Cont := 1 to C_MaximoFotosDB do
  begin
    FFotos.TryGetValue(Cont, BMP);
    if Assigned(BMP) and (not  BMP.Empty) then
    begin
      DMCadastroEntidade.cdsImagemEntidade.Append;
      DMCadastroEntidade.cdsImagemEntidadeIMAGEMENTIDADE.AsInteger := Chave;
      DMCadastroEntidade.cdsImagemEntidadeENTIDADE.AsInteger := FIDEntidade;
      DMCadastroEntidade.cdsImagemEntidadeSITUACAO.AsInteger := 1;
      DMCadastroEntidade.cdsImagemEntidadeDTCADASTRO.AsDateTime := now;
      Auxiliar := FFuncoesImagem.BMPToString(BMP);
      DMCadastroEntidade.cdsImagemEntidadeFACE.AsString := Auxiliar;
      DMCadastroEntidade.cdsImagemEntidade.Post;

      inc(Chave);
    end;

    DMCadastroEntidade.cdsImagemEntidade.ApplyUpdates(0);
  end;

  Close;
end;

procedure TfrmCapturaCadastro.AoDetectarFace(BitMap: TBitMap);
var
  Indice: Smallint;
begin
  if Assigned(BitMap) and (not BitMap.Empty) then
  begin
    FFotos.Items[getIndiceFoto].Assign(BitMap);

    Indice := getIndiceImagem;
    FFacesCapturadas.Items[Indice].Picture.Graphic := BitMap;

    ScrollBox1.HorzScrollBar.Position := Indice;
  end;
end;

procedure TfrmCapturaCadastro.CarregarBanco;
var
  BMP: TBitMap;
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
      try
        BMP := FFuncoesImagem.StringToBmp(DMCadastroEntidade.cdsImagemEntidadeFACE.AsString);

        FFotos.Items[getIndiceFoto].Assign(BMP);
        FFacesCapturadas.Items[getIndiceImagem].Picture.Assign(BMP);

        inc(Cont);
      finally
        FreeAndNil(BMP);
      end;
    end;

    DMCadastroEntidade.cdsImagemEntidade.Next;
  end;
end;

procedure TfrmCapturaCadastro.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose :=
    (Assigned(FCVCaptura) and (not FCVCaptura.EstahEmExecucao));
end;

procedure TfrmCapturaCadastro.FormCreate(Sender: TObject);
var
  cont: Integer;
begin
  Self.Width := Trunc(Screen.Width*0.9);
  Self.Height := Trunc(Screen.Height*0.85);

  imgSaidaCamera.Width := 640;
  imgSaidaCamera.Height := 480;

  imgSaidaCamera.Left := (Self.Width-imgSaidaCamera.Width) div 2;
  imgSaidaCamera.Top := 1;

  FFuncoesImagem := TGerenciaRefObjeto<TFuncoesImagem>.Create(TFuncoesImagem.Create).Instancia;

  stbFacesDetectadas.Caption := '';

  FFacesCapturadas := TDictionary<SmallInt,TImage>.Create;

  FFotos := TDictionary<SmallInt,TBitMap>.Create;

  FIndiceImagem := 0;
  FIndiceFotoAtual := 0;

  for cont := 1 to C_MaximoFotosDB do
  begin
    FFotos.Add(Cont, TBitMap.Create);
    FFotos.Items[Cont].SetSize(C_Width, C_Height);
  end;

  for cont := 1 to C_MaximoFotosDB do
  begin
    FFacesCapturadas.Add(Cont, TImage.Create(ScrollBox1));
    FFacesCapturadas.Items[Cont].Parent := ScrollBox1;
    FFacesCapturadas.Items[Cont].Width := 60;
    FFacesCapturadas.Items[Cont].Height := 60;
    FFacesCapturadas.Items[Cont].Align := alLeft;
    FFacesCapturadas.Items[Cont].Stretch := True;
  end;
end;

procedure TfrmCapturaCadastro.FormDestroy(Sender: TObject);
var
  cont: Integer;
begin
  for cont := 1 to C_MaximoFotosDB  do
  begin
    FFacesCapturadas.Items[Cont].Free;
  end;
  FreeAndNil(FFacesCapturadas);

  for cont := 1 to C_MaximoFotosDB do
  begin
    FFotos.Items[Cont].Free;
  end;
  FreeAndNil(FFotos);

  FreeAndNil(FCVCaptura);
end;

procedure TfrmCapturaCadastro.FormShow(Sender: TObject);
begin
  CarregarBanco;

  FCVCaptura := TCVCaptura.Create(Self.Handle);
  FCVCaptura.IDDispositivoVideo := FIDDispositivoVideo;
  FCVCaptura.ImagemSaidaCamera := imgSaidaCamera;

  FCVCaptura.AoDetectarFace := AoDetectarFace;
  FCVCaptura.Iniciar;
end;

function TfrmCapturaCadastro.getIndiceFoto: SmallInt;
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

function TfrmCapturaCadastro.getIndiceImagem: SmallInt;
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

procedure TfrmCapturaCadastro.actFecharExecute(Sender: TObject);
begin
  FCVCaptura.Parar;

  Close;
end;

end.

