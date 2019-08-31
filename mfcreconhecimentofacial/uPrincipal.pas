unit uPrincipal;

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
  Vcl.Imaging.jpeg,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  Vcl.Buttons,
  MFC.Configuracao,
  MFC.Uteis.GerenciaRefObjeto,
  MFC.CV.FuncoesImagem,
  MFC.Modelo.Tipos,
  MFC.DM.Conexao,
  MFC.DM.CadastroEntidade,
  MFC.CV.Dispositivos,
  MFC.CV.Captura,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Samples.Spin, Vcl.ExtDlgs;

type
  TfrmPrincipal = class(TForm)
    ActionList1: TActionList;
    actSalvarConfiguracao: TAction;
    actTestarConexaoBanco: TAction;
    actAppend: TAction;
    actEdit: TAction;
    actSave: TAction;
    actCancel: TAction;
    actDelete: TAction;
    actCarregarYale: TAction;
    actTreinamento: TAction;
    ImageList2: TImageList;
    pnlPrincipal: TPanel;
    pnlFuncoes: TPanel;
    pagina: TPageControl;
    tabCadastro: TTabSheet;
    panBotoesCadastro: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    DBGEntidade: TDBGrid;
    tabReconhecimento: TTabSheet;
    tabConfiguracoes: TTabSheet;
    grbSQLServer: TGroupBox;
    SpeedButton2: TSpeedButton;
    edtSQLServerHost: TLabeledEdit;
    edtSQLServerBanco: TLabeledEdit;
    edtSqlServerUsuario: TLabeledEdit;
    edtSQLServerSenha: TLabeledEdit;
    GroupBox1: TGroupBox;
    lstDispositivosVideo: TListBox;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    dsEntidade: TDataSource;
    Panel2: TPanel;
    ToolBar2: TToolBar;
    ToolButton7: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    actReconhecimento: TAction;
    actVisualizarImagens: TAction;
    ToolButton17: TToolButton;
    panConfiguracao1: TPanel;
    GroupBox2: TGroupBox;
    speQuantidadeFotosEntidade: TSpinEdit;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    speComponentesFischerFace: TSpinEdit;
    edtThreSholdFischerFace: TEdit;
    Panel3: TPanel;
    tabReconhecimentoBase: TTabSheet;
    Panel4: TPanel;
    Button1: TButton;
    actTesteBase: TAction;
    memTesteBase: TMemo;
    lblProcessamentoBase: TLabel;
    btn1: TButton;
    saveArquivoCSV: TSaveTextFileDialog;
    GroupBox5: TGroupBox;
    Label6: TLabel;
    edtThreSholdLBPH: TEdit;
    memReconhecimento: TMemo;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    seComponentesEigenFace: TSpinEdit;
    edtThreSholdEigenFace: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actTreinamentoExecute(Sender: TObject);
    procedure actTreinamentoUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actAppendUpdate(Sender: TObject);
    procedure actEditUpdate(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actAppendExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure paginaChanging(Sender: TObject; var AllowChange: Boolean);
    procedure actSalvarConfiguracaoExecute(Sender: TObject);
    procedure actTestarConexaoBancoExecute(Sender: TObject);
    procedure actReconhecimentoExecute(Sender: TObject);
    procedure actVisualizarImagensExecute(Sender: TObject);
    procedure actTesteBaseExecute(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    FConfiguracao: TConfiguracao;
    DMConexao: TDMConexao;
    DMCadastroEntidade: TDMEntidade;
    FConfigSQLServer: TConfigSQLServer;

    FCVDispositivos: TCVDispositivos;

    FFuncoesImagem: TFuncoesImagem;

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uCapturaCadastro, uVerCadastro, uReconhecimento, MFC.CV.Reconhecimento;

{$R *.dfm}

procedure TfrmPrincipal.actAppendExecute(Sender: TObject);
begin
  DMCadastroEntidade.cdsEntidade.Append;
  DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger := DMCadastroEntidade.getChaveEntidade;
  DMCadastroEntidade.cdsEntidadeSITUACAO.AsInteger := 1;
  DMCadastroEntidade.cdsEntidadeDTCADASTRO.AsDateTime := now;
  DMCadastroEntidade.cdsEntidadeORIGEM.AsString := 'MANUAL';

end;

procedure TfrmPrincipal.actAppendUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.State=dsBrowse);

end;

procedure TfrmPrincipal.actCancelExecute(Sender: TObject);
begin
  DMCadastroEntidade.cdsEntidade.Cancel;

end;

procedure TfrmPrincipal.actCancelUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.State in [dsEdit, dsInsert]);

end;

procedure TfrmPrincipal.actDeleteExecute(Sender: TObject);
begin
  if MessageBox(Self.Handle, 'Confirma exclusão?', 'Atenção', mb_YesNO+mb_IconQuestion)=idYes then
  begin
    DMCadastroEntidade.cdsEntidade.Edit;
    DMCadastroEntidade.cdsEntidadeSITUACAO.AsInteger := 0;
    DMCadastroEntidade.cdsEntidade.Post;
    DMCadastroEntidade.cdsEntidade.ApplyUpdates(0);
    DMCadastroEntidade.cdsEntidade.Refresh;
  end;

end;

procedure TfrmPrincipal.actDeleteUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.RecordCount<>0) and
                             (DMCadastroEntidade.cdsEntidade.State=dsBrowse);

end;

procedure TfrmPrincipal.actEditExecute(Sender: TObject);
begin
  DMCadastroEntidade.cdsEntidade.Edit;
end;

procedure TfrmPrincipal.actEditUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.RecordCount<>0) and
                             (DMCadastroEntidade.cdsEntidade.State=dsBrowse);

end;

procedure TfrmPrincipal.actReconhecimentoExecute(Sender: TObject);
var
  Tela: TfrmReconhecimento;
begin
  try
    memReconhecimento.Lines.Clear;

    Tela := TfrmReconhecimento.Create(Self);
    Tela.MemoReconhecimento := memReconhecimento;
    Tela.DMCadastroEntidade := DMCadastroEntidade;
    Tela.IDDispositivoVideo := lstDispositivosVideo.ItemIndex;
    Tela.ShowModal;
  finally
    FreeAndNil(Tela);
  end;
end;

procedure TfrmPrincipal.actSalvarConfiguracaoExecute(Sender: TObject);
begin
  if lstDispositivosVideo.ItemIndex=-1 then
  begin
    raise Exception.Create('Selecine um dispositivo de video!');
  end;

  FConfiguracao.ComponentesEigenFace := seComponentesEigenFace.Value;
  FConfiguracao.ThreSholdEigenFace := StrToFloatDef(edtThreSholdEigenFace.Text,0);

  FConfiguracao.ComponentesFischerFace := speComponentesFischerFace.Value;
  FConfiguracao.ThreSholdFischerFace := StrToFloatDef(edtThreSholdFischerFace.Text,0);

  FConfiguracao.ThreSholdLBPH := StrToFloatDef(edtThreSholdLBPH.Text,0);

  FConfigSQLServer.Host := edtSQLServerHost.Text;
  FConfigSQLServer.Banco := edtSQLServerBanco.Text;
  FConfigSQLServer.Usuario := edtSqlServerUsuario.Text;
  FConfigSQLServer.Senha := edtSQLServerSenha.Text;

  FConfiguracao.FacesPorEntidade := speQuantidadeFotosEntidade.Value;
  FConfiguracao.NomeDispositivoVideo := lstDispositivosVideo.Items[lstDispositivosVideo.ItemIndex];

  FConfiguracao.setConfigSql(FConfigSQLServer);

  if MessageBox(Self.Handle, 'Reconectar ao Banco?', 'Atenção', mb_YesNO+mb_IconInformation+mb_DefButton2)=idYes then
  begin
    DMConexao.Configurar(FConfigSQLServer);

    DMCadastroEntidade.cdsEntidade.Close;
    DMCadastroEntidade.cdsEntidade.Open;
  end;

end;

procedure TfrmPrincipal.actSaveExecute(Sender: TObject);
begin
  DMCadastroEntidade.cdsEntidade.Post;
  DMCadastroEntidade.cdsEntidade.ApplyUpdates(0);

end;

procedure TfrmPrincipal.actSaveUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.State in [dsEdit, dsInsert]);

end;

procedure TfrmPrincipal.actTestarConexaoBancoExecute(Sender: TObject);
var
  Teste: TConfigSQLServer;
begin
  Teste.Host := edtSQLServerHost.Text;
  Teste.Banco := edtSQLServerBanco.Text;
  Teste.Usuario := edtSqlServerUsuario.Text;
  Teste.Senha := edtSQLServerSenha.Text;

  DMConexao.Configurar(Teste);

  ShowMessage('Teste realizado com sucesso!');
end;

procedure TfrmPrincipal.actTesteBaseExecute(Sender: TObject);
var
  Reconhecimento: TCVReconhecimento;
  Size: TCvSize;
  CandidataReconhecimento: pIplImage;
  PredicaoFischer, PredicaoLBPH, PredicaoEigen: TPredicao;
  BitMap: TBitMap;
  IndiceFoto: Integer;
  Auxiliar: String;
  QuantidadeEntidadesComFoto: Integer;
  BMP: TBitmap;
  Entidade: Integer;

  procedure TodosMenosEntidade;
  var
    TempoVerificacao: Cardinal;
  begin
    try
      DMCadastroEntidade.cdsTodasImagens.Filtered := False;
      DMCadastroEntidade.cdsTodasImagens.Filter := 'ENTIDADE<>'+DMCadastroEntidade.cdsEntidadeENTIDADE.AsString;
      DMCadastroEntidade.cdsTodasImagens.Filtered := True;

      Reconhecimento := TCVReconhecimento.Create(Self.Handle);

      Reconhecimento.ComponentesEigenFace := seComponentesEigenFace.Value;
      Reconhecimento.ThreSholdEigenFace := StrToFloatDef(edtThreSholdEigenFace.Text,0);
      Reconhecimento.ComponentesFischerFace := speComponentesFischerFace.Value;
      Reconhecimento.ThreSholdFischerFace := StrToFloatDef(edtThreSholdFischerFace.Text,0);
      Reconhecimento.ThreSholdLBPH := StrToFloatDef(edtThreSholdLBPH.Text,0);

      DMCadastroEntidade.cdsTodasImagens.First;
      memTesteBase.Lines.Add('Faces a Comparar: '+DMCadastroEntidade.cdsTodasImagens.RecordCount.ToString);
      while not DMCadastroEntidade.cdsTodasImagens.Eof do
      begin
        BMP := FFuncoesImagem.StringToBmp(DMCadastroEntidade.cdsTodasImagensFACE.AsString);

        FFuncoesImagem.getImagemEscalonada(BMP, BMP);
        FFuncoesImagem.getImagemEscalaCinza(BMP, BMP);

        FFuncoesImagem.DoBCSHistogram(BMP, BMP, C_FatorHistograma);

        Reconhecimento.AdicionarImagem(
                                      DMCadastroEntidade.cdsTodasImagensENTIDADE.AsInteger,
                                      BMP);

        DMCadastroEntidade.cdsTodasImagens.Next;
      end;

      Reconhecimento.ConfiguracaoInicial(QuantidadeEntidadesComFoto);

      DMCadastroEntidade.cdsImagemEntidade.Close;
      DMCadastroEntidade.cdsImagemEntidade.Params.ParamByName('ENTIDADE').AsInteger := DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger;
      DMCadastroEntidade.cdsImagemEntidade.Open;

      Indicefoto := 0;
      while not DMCadastroEntidade.cdsImagemEntidade.Eof do
      begin
        CandidataReconhecimento := nil;
        inc(IndiceFoto);

        if DMCadastroEntidade.cdsImagemEntidadeFACE.AsString<>'' then
        begin
          try
            BitMap := FFuncoesImagem.StringToBmp(DMCadastroEntidade.cdsImagemEntidadeFACE.AsString);

            FFuncoesImagem.getImagemEscalonada(BitMap, BitMap);
            FFuncoesImagem.getImagemEscalaCinza(BitMap, BitMap);
            FFuncoesImagem.DoBCSHistogram(BitMap, BitMap, C_FatorHistograma);
            CandidataReconhecimento := FFuncoesImagem.BitmapToImageGray(BitMap);
            //FFuncoesImagem.SalvarBMPTeste(CandidataReconhecimento, 'c:\temp\CandidataReconhecimento.bmp');
          finally
            BitMap.FreeImage;
            FreeAndNil(BitMap);
          end;
        end;

        TempoVerificacao := GetTickCount;

        PredicaoFischer := Reconhecimento.VerificarFischerFace(CandidataReconhecimento);
        PredicaoLBPH := Reconhecimento.VerificarLBPH(CandidataReconhecimento);
        PredicaoEigen := Reconhecimento.VerificarEigenFace(CandidataReconhecimento);

        Auxiliar := DMCadastroEntidade.cdsEntidadeENTIDADE.AsString+';'+
                    DMCadastroEntidade.cdsEntidadeNOMECOMPLETO.AsString;

        Auxiliar := Auxiliar+';OUTROS';

        Auxiliar := Auxiliar+';'+IntToStr(IndiceFoto);


        if PredicaoFischer.lab=DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger then
        begin
          Auxiliar := Auxiliar+';OK'+';'+FloatToStr(PredicaoFischer.Confianca);
        end
        else
        begin
          Auxiliar := Auxiliar+';'+IntToSTr(PredicaoFischer.lab)+';'+FloatToStr(PredicaoFischer.Confianca);
        end;

        if PredicaoLBPH.lab=DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger then
        begin
          Auxiliar := Auxiliar+';OK'+';'+FloatToStr(PredicaoLBPH.Confianca);
        end
        else
        begin
          Auxiliar := Auxiliar+';'+IntToSTr(PredicaoLBPH.lab)+';'+FloatToStr(PredicaoLBPH.Confianca);
        end;

        if PredicaoEigen.lab=DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger then
        begin
          Auxiliar := Auxiliar+';OK'+';'+FloatToStr(PredicaoEigen.Confianca);
        end
        else
        begin
          Auxiliar := Auxiliar+';'+IntToSTr(PredicaoEigen.lab)+';'+FloatToStr(PredicaoEigen.Confianca);
        end;

        Auxiliar := Auxiliar+';'+IntToStr(GetTickCount-TempoVerificacao);

        memTesteBase.Lines.Add(Auxiliar);

        if Assigned(CandidataReconhecimento) then
        begin
          cvReleaseImage(CandidataReconhecimento);
        end;

        DMCadastroEntidade.cdsImagemEntidade.Next;

        Application.ProcessMessages;
      end;
    finally
      FreeAndNil(Reconhecimento);
    end;
  end;

  procedure TodaBase;
  var
    TempoVerificacao: Cardinal;
  begin
    DMCadastroEntidade.cdsImagemEntidade.Close;
    DMCadastroEntidade.cdsImagemEntidade.Params.ParamByName('ENTIDADE').AsInteger := DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger;
    DMCadastroEntidade.cdsImagemEntidade.Open;

    Indicefoto := 0;
    DMCadastroEntidade.cdsTodasImagens.Filtered := False;
    memTesteBase.Lines.Add('Faces a Comparar: '+IntToStr(DMCadastroEntidade.cdsTodasImagens.RecordCount-1));

    while not DMCadastroEntidade.cdsImagemEntidade.Eof do
    begin
      DMCadastroEntidade.cdsTodasImagens.Filtered := False;
      DMCadastroEntidade.cdsTodasImagens.Filter := 'IMAGEMENTIDADE<>'+DMCadastroEntidade.cdsImagemEntidadeIMAGEMENTIDADE.AsString;
      DMCadastroEntidade.cdsTodasImagens.Filtered := True;

      inc(Indicefoto);

      try
        Reconhecimento := TCVReconhecimento.Create(Self.Handle);

        Reconhecimento.ComponentesEigenFace := seComponentesEigenFace.Value;
        Reconhecimento.ThreSholdEigenFace := StrToFloatDef(edtThreSholdEigenFace.Text,0);
        Reconhecimento.ComponentesFischerFace := speComponentesFischerFace.Value;
        Reconhecimento.ThreSholdFischerFace := StrToFloatDef(edtThreSholdFischerFace.Text,0);
        Reconhecimento.ThreSholdLBPH := StrToFloatDef(edtThreSholdLBPH.Text,0);

        DMCadastroEntidade.cdsTodasImagens.First;
        while not DMCadastroEntidade.cdsTodasImagens.Eof do
        begin
          CandidataReconhecimento := nil;

          BMP := FFuncoesImagem.StringToBmp(DMCadastroEntidade.cdsTodasImagensFACE.AsString);

          FFuncoesImagem.getImagemEscalonada(BMP, BMP);
          FFuncoesImagem.getImagemEscalaCinza(BMP, BMP);
          FFuncoesImagem.DoBCSHistogram(BMP, BMP, C_FatorHistograma);

          Reconhecimento.AdicionarImagem(
                                        DMCadastroEntidade.cdsTodasImagensENTIDADE.AsInteger,
                                        BMP);

          DMCadastroEntidade.cdsTodasImagens.Next;
          Application.ProcessMessages;
        end;

        Reconhecimento.ConfiguracaoInicial(QuantidadeEntidadesComFoto);

        if DMCadastroEntidade.cdsImagemEntidadeFACE.AsString<>'' then
        begin
          try
            BitMap := FFuncoesImagem.StringToBmp(DMCadastroEntidade.cdsImagemEntidadeFACE.AsString);
            FFuncoesImagem.getImagemEscalonada(BitMap, BitMap);
            FFuncoesImagem.getImagemEscalaCinza(BitMap, BitMap);
            FFuncoesImagem.DoBCSHistogram(BitMap, BitMap, C_FatorHistograma);
            CandidataReconhecimento := FFuncoesImagem.BitmapToImageGray(BitMap);
            //FFuncoesImagem.SalvarBMPTeste(CandidataReconhecimento, 'c:\temp\CandidataReconhecimento.bmp');
          finally
            BitMap.FreeImage;
            FreeAndNil(BitMap);
          end;
        end;

        TempoVerificacao := GetTickCount;

        PredicaoFischer := Reconhecimento.VerificarFischerFace(CandidataReconhecimento);
        PredicaoLBPH := Reconhecimento.VerificarLBPH(CandidataReconhecimento);
        PredicaoEigen := Reconhecimento.VerificarEigenFace(CandidataReconhecimento);

        if Assigned(CandidataReconhecimento) then
        begin
          cvReleaseImage(CandidataReconhecimento);
        end;

        Auxiliar := DMCadastroEntidade.cdsEntidadeENTIDADE.AsString+';'+
                    DMCadastroEntidade.cdsEntidadeNOMECOMPLETO.AsString;

        Auxiliar := Auxiliar+';OUTROS';

        Auxiliar := Auxiliar+';'+IntToStr(IndiceFoto);


        if PredicaoFischer.lab=DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger then
        begin
          Auxiliar := Auxiliar+';OK'+';'+FloatToStr(PredicaoFischer.Confianca);
        end
        else
        begin
          Auxiliar := Auxiliar+';'+IntToSTr(PredicaoFischer.lab)+';'+FloatToStr(PredicaoFischer.Confianca);
        end;

        if PredicaoLBPH.lab=DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger then
        begin
          Auxiliar := Auxiliar+';OK'+';'+FloatToStr(PredicaoLBPH.Confianca);
        end
        else
        begin
          Auxiliar := Auxiliar+';'+IntToSTr(PredicaoLBPH.lab)+';'+FloatToStr(PredicaoLBPH.Confianca);
        end;

        if PredicaoEigen.lab=DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger then
        begin
          Auxiliar := Auxiliar+';OK'+';'+FloatToStr(PredicaoEigen.Confianca);
        end
        else
        begin
          Auxiliar := Auxiliar+';'+IntToSTr(PredicaoEigen.lab)+';'+FloatToStr(PredicaoEigen.Confianca);
        end;

        Auxiliar := Auxiliar+';'+IntToStr(GetTickCount-TempoVerificacao);

        memTesteBase.Lines.Add(Auxiliar);
      finally
        FreeAndNIl(Reconhecimento);
      end;

      DMCadastroEntidade.cdsImagemEntidade.Next;
      Application.ProcessMessages;
    end;
  end;

begin
  try
    Size := cvSize(C_Width, C_Height);
    CandidataReconhecimento := cvCreateImage(Size, IPL_DEPTH_8U, 1); // 1 porque original para GRAY(BGR[0])

    Button1.Enabled := False;

    memTesteBase.Lines.Clear;
    memTesteBase.Lines.Add('Configuração Eigen -> Componentes: '+IntToStr(seComponentesEigenFace.Value)+' ThreShold: '+edtThreSholdEigenFace.Text);
    memTesteBase.Lines.Add('Configuração Fischer -> Componentes: '+IntToStr(speComponentesFischerFace.Value)+' ThreShold: '+edtThreSholdFischerFace.Text);
    memTesteBase.Lines.Add('Configuração LBPH-> ThreShold: '+edtThreSholdLBPH.Text);


    memTesteBase.Lines.Add('ENTIDADE;NOME;TESTE;NRO FOTO;'+
                            'FISCHERFACE ENTIDADE;FISCHERFACE CONFIANÇA;LBPH ENTIDADE;LBPH CONFIANÇA;EIGENFACE ENTIDADE;EIGENFACE CONFIANÇA;TEMPO VERIFICAÇÃO');

    DMCadastroEntidade.cdsTodasImagens.Open;

    if DMCadastroEntidade.cdsEntidadeQTDEIMAGENS.AsInteger<>0 then
    begin
      Entidade := DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger;

      DMCadastroEntidade.cdsEntidade.Filter := 'QTDEIMAGENS<>0';
      DMCadastroEntidade.cdsEntidade.Filtered := True;
      QuantidadeEntidadesComFoto := DMCadastroEntidade.cdsEntidade.RecordCount;

      DMCadastroEntidade.cdsEntidade.Filtered := False;
      DMCadastroEntidade.cdsEntidade.Filter := '';

      if DMCadastroEntidade.cdsEntidade.Locate('ENTIDADE', Entidade, []) then
      begin
        lblProcessamentoBase.Caption := 'Verificando:' +DMCadastroEntidade.cdsEntidadeNOMECOMPLETO.AsString;

        TodosMenosEntidade;
        TodaBase;
      end;

      memTesteBase.Lines.Add('');
    end;
  finally
    DMCadastroEntidade.cdsEntidade.Filter := '';
    DMCadastroEntidade.cdsEntidade.Filtered := False;

    cvReleaseImage(CandidataReconhecimento);

    lblProcessamentoBase.Caption := 'Processamento concluido';

    Button1.Enabled := True;
  end;
end;

procedure TfrmPrincipal.actTreinamentoExecute(Sender: TObject);
var
  Tela: TfrmCapturaCadastro;
begin
  try
    Tela := TfrmCapturaCadastro.Create(Self);
    Tela.DMCadastroEntidade := DMCadastroEntidade;
    Tela.IDDispositivoVideo := lstDispositivosVideo.ItemIndex;
    Tela.IDEntidade := DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger;

    Tela.ShowModal;

    DMCadastroEntidade.cdsEntidade.Refresh;
  finally
    FreeAndNil(Tela);
  end;
end;

procedure TfrmPrincipal.actTreinamentoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(DMCadastroEntidade) and
                             DMCadastroEntidade.cdsEntidade.Active and
                             (DMCadastroEntidade.cdsEntidade.RecordCount<>0) and
                             (DMCadastroEntidade.cdsEntidade.State=dsBrowse);

end;

procedure TfrmPrincipal.actVisualizarImagensExecute(Sender: TObject);
var
  Tela: TfrmVerCadastro;
begin
  try
    Tela := TfrmVerCadastro.Create(Self);
    Tela.DMCadastroEntidade := DMCadastroEntidade;
    Tela.IDDispositivoVideo := lstDispositivosVideo.ItemIndex;
    Tela.IDEntidade := DMCadastroEntidade.cdsEntidadeENTIDADE.AsInteger;

    Tela.ShowModal;
  finally
    FreeAndNil(Tela);
  end;
end;

procedure TfrmPrincipal.btn1Click(Sender: TObject);
begin
  if saveArquivoCSV.Execute then
  begin
    memTesteBase.Lines.SaveToFile(saveArquivoCSV.FileName);
  end;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
var
Tela: TfrmCapturaCadastro;
begin
  try
    Tela := TfrmCapturaCadastro.Create(Self);
    Tela.ShowModal;
  finally
    FreeAndNil(Tela);
  end;

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  Auxiliar: String;
begin
  FFuncoesImagem := TGerenciaRefObjeto<TFuncoesImagem>.Create(TFuncoesImagem.Create).Instancia;

  pagina.ActivePage := tabCadastro;

  lblProcessamentoBase.Caption := '';

  DMConexao := TDMConexao.Create(Self);

  FConfiguracao := TConfiguracao.Create;

  seComponentesEigenFace.Value := FConfiguracao.ComponentesEigenFace;
  edtThreSholdEigenFace.Text := FloatToStr(FConfiguracao.ThreSholdEigenFace);

  speComponentesFischerFace.Value := FConfiguracao.ComponentesFischerFace;
  edtThreSholdFischerFace.Text := FloatToStr(FConfiguracao.ThreSholdFischerFace);
  edtThreSholdLBPH.Text := FloatToStr(FConfiguracao.ThreSholdLBPH);

  FConfigSQLServer := FConfiguracao.getConfigSqlServer;

  edtSQLServerHost.Text := FConfigSQLServer.Host;
  edtSQLServerBanco.Text := FConfigSQLServer.Banco;
  edtSqlServerUsuario.Text := FConfigSQLServer.Usuario;
  edtSQLServerSenha.Text := FConfigSQLServer.Senha;
  speQuantidadeFotosEntidade.Value := FConfiguracao.FacesPorEntidade;

  DMCadastroEntidade := TDMEntidade.Create(Self);
  DMCadastroEntidade.Configurar(DMConexao);

  dsEntidade.DataSet := DMCadastroEntidade.cdsEntidade;

  if (FConfigSQLServer.Host<>'') and (FConfigSQLServer.Banco<>'') and (FConfigSQLServer.Usuario<>'') and (FConfigSQLServer.Senha<>'') then
  begin
    try
      DMConexao.Configurar(FConfigSQLServer);
      DMCadastroEntidade.cdsEntidade.Open;
    except
      on E:Exception do
      begin
        pagina.ActivePage := tabConfiguracoes;
      end;
    end;
  end;

  FCVDispositivos := TCVDispositivos.Create;
  FCVDispositivos.setLista(lstDispositivosVideo.Items);

  Auxiliar := FConfiguracao.NomeDispositivoVideo;
  if (Auxiliar<>'') then
  begin
    lstDispositivosVideo.ItemIndex := lstDispositivosVideo.Items.IndexOf(Auxiliar);
  end;

  Auxiliar := FConfiguracao.NomeXMLCascade;
  if (Auxiliar<>'') then
  begin
  end;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCVDispositivos);

  FreeAndNil(DMCadastroEntidade);
  FreeAndNil(DMConexao);
  FreeandNil(FConfiguracao);
end;

procedure TfrmPrincipal.paginaChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (DMCadastroEntidade.cdsEntidade.State=dsBrowse);

end;

end.
