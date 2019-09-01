unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, ExtCtrls, Menus;

type
  EMain = Exception;

  TResultado = (lancarpedidos,naolancarpedidos,naofacanada);

  Tfrmmaincup = class(TForm)
    imgMin: TImage;
    imgQuit: TImage;
    imgbg: TImage;
    lblPrograma: TLabel;
    panbotoes: TPanel;
    Label1: TLabel;
    lblnomeusuario: TLabel;
    Label2: TLabel;
    lblquantidadeapostadores: TLabel;
    Label3: TLabel;
    lblconfirmados: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    lblsituacaoatual: TLabel;
    panexclusivosupervisor: TPanel;
    pantabelaoficial: TPanel;
    btnresultados: TButton;
    panimprimirtabela: TPanel;
    btnimprimirtabela: TButton;
    panapostadores: TPanel;
    btnapostadores: TButton;
    panbloqueio: TPanel;
    btnbloqueioliberacao: TButton;
    panexclusivousuario: TPanel;
    pantrocarsenha: TPanel;
    btntrocarsenha: TButton;
    panimprimirminhaaposta: TPanel;
    btnimprimirminhaaposta: TButton;
    panminhaaposta: TPanel;
    btnminhaaposta: TButton;
    panverapostas: TPanel;
    btnveroutrasapostas: TButton;
    pangeral: TPanel;
    panranking: TPanel;
    btnranking: TButton;
    panregras: TPanel;
    btnregras: TButton;
    pansair: TPanel;
    btnsair: TButton;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure imgMinClick(Sender: TObject);
    procedure imgQuitClick(Sender: TObject);
    procedure btnsairClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnapostadoresClick(Sender: TObject);
    procedure btnregrasClick(Sender: TObject);
    procedure btnrankingClick(Sender: TObject);
    procedure btnresultadosClick(Sender: TObject);
    procedure btnimprimirtabelaClick(Sender: TObject);
    procedure btnminhaapostaClick(Sender: TObject);
    procedure btnimprimirminhaapostaClick(Sender: TObject);
    procedure btntrocarsenhaClick(Sender: TObject);
    procedure btnveroutrasapostasClick(Sender: TObject);
    procedure btnbloqueioliberacaoClick(Sender: TObject);
  private
    { Private declarations }
    procedure Exibirsituacao;
  public
    { Public declarations }
    iapostador: integer; // 0 - supervisor; 1- outros
  end;

var
  frmmaincup: Tfrmmaincup;

implementation

uses
  dtMod, result, impress, pessoa, regra, impranki, trocasen, verapost;

procedure dllImgBg (img : TImage); external 'ImgMenu.dll' name 'ImgBg';
procedure IconsTitleBar(imgMin, imgQuit: TImage); external 'ImgMenu.dll';

{$R *.dfm}

procedure Tfrmmaincup.Exibirsituacao;
begin
  with modulo.dtsexecutar, modulo.dtsexecutar.sql do
  begin
    clear;
    Add('SELECT');
    Add('COUNT(*) AAA');
    Add('FROM');
    Add('PESSOA.DB');
    Open;
    lblquantidadeapostadores.Caption := FieldByName('AAA').AsString;

    clear;
    Add('SELECT');
    Add('COUNT(*) AAA');
    Add('FROM');
    Add('PESSOA.DB');
    Add('WHERE PAGO = TRUE');
    Open;
    lblconfirmados.caption := FieldByName('AAA').AsString; 
  end;

  Modulo.bapostasliberadas := Modulo.ApostasLiberadas;
  if Modulo.bapostasliberadas then
  begin
    lblsituacaoatual.caption := 'APOSTAS LIBERADAS';
  end
  else
  begin
    lblsituacaoatual.caption := 'APOSTAS BLOQUEADAS';
  end;

  panranking.Visible := not Modulo.bapostasliberadas;

  panminhaaposta.Visible := (iapostador <> 0) and Modulo.bapostasliberadas;
  panverapostas.Visible := (iapostador <> 0) and (not Modulo.bapostasliberadas);

  panbloqueio.Visible := (iapostador = 0);
end;

procedure Tfrmmaincup.FormShow(Sender: TObject);
begin
  dllImgBg(imgBg);
  IconsTitleBar(imgMin, imgQuit);

  Self.AutoSize    := True;
  Self.BorderStyle := bsNone;
  frmmaincup.Caption := nomecurto;

  pantabelaoficial.Visible := iapostador = 0;
  panapostadores.Visible := iapostador = 0;
  panimprimirminhaaposta.Visible := iapostador <> 0;
  pantrocarsenha.Visible := iapostador <> 0;

  ExibirSituacao;

  if iapostador = 0 then
  begin
    lblnomeusuario.caption := 'SUPERVISOR DO SISTEMA';
  end
  else
  begin
    with modulo.dtsexecutar, modulo.dtsexecutar.sql do
    begin
      clear;
      Add('SELECT');
      Add('NOME');
      Add('FROM');
      Add('PESSOA.DB');
      Add('WHERE CODIGO = :P_CODIGO');
      ParamBYName('P_CODIGO').AsInteger := iapostador;

      Open;
      lblnomeusuario.caption := FieldBYName('NOME').AsString;
      Close;
    end;
  end;
end;

procedure Tfrmmaincup.imgMinClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure Tfrmmaincup.imgQuitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmmaincup.btnsairClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmmaincup.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure Tfrmmaincup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RemoveDir(C_TEMP);
end;

procedure Tfrmmaincup.btnapostadoresClick(Sender: TObject);
begin
  btnapostadores.enabled := false;
  frmpessoa := Tfrmpessoa.create(Self);
  frmpessoa.showmodal;
  FreeAndNil(frmpessoa);
  Exibirsituacao;
  btnapostadores.enabled := true;
end;

procedure Tfrmmaincup.btnregrasClick(Sender: TObject);
begin
  btnregras.Enabled :=false;
  frmregra := Tfrmregra.Create(Self);
  frmregra.montarregra;
  frmregra.QrGeral.PreviewModal;
  FreeAndNil(frmregra);
  btnregras.Enabled :=true;
end;

procedure Tfrmmaincup.btnrankingClick(Sender: TObject);
begin
  btnranking.Enabled := false;
  frmranking := Tfrmranking.create(Self);
  frmranking.preparacao;
  if frmranking.dtsgeral.active then
    frmranking.QRGeral.PreviewModal
  else
    messagebox(Self.Handle,'Ainda não foi encerrada nenhuma partida.','Atenção',
               mb_Ok+mb_IconInformation);
               
  FreeAndNil(frmranking);
  btnranking.Enabled := true;
end;

procedure Tfrmmaincup.btnresultadosClick(Sender: TObject);
begin
  btnresultados.Enabled := false;
  frmresultado := Tfrmresultado.Create(Self);
  frmresultado.iapostador := 0;
  frmresultado.Caption := 'Tabela oficial da Copa do Mundo 2006';
  frmresultado.showmodal;
  FreeAndnil(frmresultado);
  Exibirsituacao;
  btnresultados.Enabled := true;
end;

procedure Tfrmmaincup.btnimprimirtabelaClick(Sender: TObject);
begin
  btnimprimirtabela.Enabled := false;

  frmimpressao := Tfrmimpressao.create(Self);
  frmimpressao.iapostador := 0;
  frmimpressao.montasql;
  frmimpressao.qrlapostador.Caption := 'Tabela oficial da Copa do Mundo 2006';
  frmimpressao.QRGeral.PreviewModal;
  FreeAndNil(frmimpressao);

  btnimprimirtabela.Enabled := true;
end;

procedure Tfrmmaincup.btnminhaapostaClick(Sender: TObject);
begin
  Self.Enabled := false;
  btnminhaaposta.Enabled := false;
  frmresultado := TfrmResultado.Create(Self);
  frmresultado.iapostador := Self.iapostador;
  frmresultado.Caption := 'Aposta de '+lblnomeusuario.caption;
  frmresultado.showmodal;
  FreeAndNil(frmresultado);
  btnminhaaposta.Enabled := true;
  Self.Enabled := true;
end;

procedure Tfrmmaincup.btnimprimirminhaapostaClick(Sender: TObject);
begin
  btnimprimirminhaaposta.Enabled := false;
  frmimpressao := Tfrmimpressao.create(Self);
  frmimpressao.iapostador := iapostador;
  frmimpressao.montasql(lblnomeusuario.caption);
  frmimpressao.QRGeral.PreviewModal;
  FreeAndNil(frmimpressao);
  btnimprimirminhaaposta.Enabled := true;
end;

procedure Tfrmmaincup.btntrocarsenhaClick(Sender: TObject);
begin
  btntrocarsenha.enabled := false;
  frmtrocarsenha := Tfrmtrocarsenha.Create(Self);
  frmtrocarsenha.iapostador := Self.iapostador;
  frmtrocarsenha.showmodal;
  FreeAndNil(frmtrocarsenha);
  btntrocarsenha.enabled := true;
end;

procedure Tfrmmaincup.btnveroutrasapostasClick(Sender: TObject);
begin
  btnveroutrasapostas.Enabled := false;
  frmveraposta := Tfrmveraposta.create(Self);
  frmveraposta.iapostador := Self.iapostador;
  frmveraposta.montasql;
  frmveraposta.showmodal;
  FreeAndNil(frmveraposta);

  btnveroutrasapostas.enabled := true;
end;

procedure Tfrmmaincup.btnbloqueioliberacaoClick(Sender: TObject);
  function podeliberar:boolean;
  begin
    with modulo.dtsexecutar,modulo.dtsexecutar.sql do
    begin
      clear;
      Add('SELECT COUNT(*) AAA FROM MATRIZ.DB');
      Add('WHERE ENCERRADO = 1');
      Open;

      Result := FieldbyName('AAA').AsInteger = 0;
      CLose;
    end;
  end;
  
begin
  btnbloqueioliberacao.Enabled := false;
  if Modulo.bapostasliberadas then
  begin
    if lblquantidadeapostadores.Caption = lblconfirmados.Caption then
    begin
      if MessageBox(Self.Handle,'Bloquear as apostas?','Atenção',
                    mb_YEsNO+mb_iconquestion) = idYes then
      begin
        with modulo.dtsexecutar, modulo.dtsexecutar.sql do
        begin
          clear;
          Add('UPDATE CONTROLE.DB');
          Add('SET FLAG = 1');
          Add('WHERE CODIGO = 1');
          ExecSql;
        end;

        Exibirsituacao;
      end;
    end
    else
    begin
      MessageBox(Self.Handle, 'Existe apostas não confirmadas.', 'Atenção',
                 mb_IconError++mb_Ok);
    end;
  end
  else
  begin
    if PodeLiberar then
    begin
      if MessageBox(Self.Handle,'Liberar as apostas?','Atenção',
                    mb_YesNO+mb_IconQuestion) = idYes then
      begin
        with modulo.dtsexecutar, modulo.dtsexecutar.sql do
        begin
          clear;
          Add('UPDATE CONTROLE.DB');
          Add('SET FLAG = 0');
          Add('WHERE CODIGO = 1');
          ExecSql;
        end;

        Exibirsituacao;
      end;
    end
    else
      MessageBox(Self.Handle,
                 'As apostas não serão liberadas pois já existem jogos em andamento.',
                 'Atenção',mb_Ok+mb_IconInformation);

  end;
  btnbloqueioliberacao.Enabled := true;
end;

end.
