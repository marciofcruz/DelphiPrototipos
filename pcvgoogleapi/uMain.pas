unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  ComCtrls, ExtCtrls,
  REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Data.DB, Datasnap.DBClient,
  System.Math,
  marciofcruz.GeoCodificacao, System.Actions, Vcl.ActnList, Vcl.Buttons,
  marciofcruz.GeoMatrizDistancia,
  Vcl.Grids, Vcl.DBGrids, Vcl.OleCtrls, SHDocVw,
  marciofcruz.GeoUteis, Vcl.CheckLst, Vcl.Samples.Spin, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    pagina: TPageControl;
    tabParametros: TTabSheet;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    edtGoogleAPIKey: TEdit;
    Proxy: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtHost: TEdit;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtRua: TEdit;
    edtNumero: TEdit;
    edtBairro: TEdit;
    edtComplemento: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtCEP: TEdit;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    edtPorta: TEdit;
    dtsCoordenadas: TDataSource;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    ActionList1: TActionList;
    actSubir: TAction;
    actDescer: TAction;
    actExcluir: TAction;
    btnGeocodificar: TButton;
    Button2: TButton;
    cdsMatrizDistancia: TFDMemTable;
    stbResultado: TStatusBar;
    cdsMatrizDistanciaCHAVE: TIntegerField;
    cdsMatrizDistanciaLATITUDE: TFloatField;
    cdsMatrizDistanciaPLACEID: TStringField;
    cdsMatrizDistanciaTIPO: TStringField;
    panMatriz: TPanel;
    panGridMatrizDistancia: TPanel;
    panOperacaoMatrizDistancia: TPanel;
    dtsMatrizDistancia: TDataSource;
    DBGrid2: TDBGrid;
    actTipoOrigem: TAction;
    actTipoDestino: TAction;
    actTipoNenhum: TAction;
    cdsMatrizDistanciaLONGITUDE: TFloatField;
    actInverso: TAction;
    GroupBox6: TGroupBox;
    btnInverso: TSpeedButton;
    GroupBox7: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel1: TPanel;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    cobModoTransporte: TComboBox;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    btnProcessarMatrizDistancia: TSpeedButton;
    actProcessarMatrizDistancia: TAction;
    Button1: TButton;
    Label14: TLabel;
    lblTrafegoTrajeto: TLabel;
    cobOpcaoTrafego: TComboBox;
    GroupBox4: TGroupBox;
    dtHorario: TDateTimePicker;
    cobHorario: TComboBox;
    lblPreferenciaTransportePublico: TLabel;
    ckbPreferenciaTransportePublico: TCheckListBox;
    cobRoteamentoTransportePublico: TComboBox;
    lblRoteamentoTransportePublico: TLabel;
    cobRestricao: TComboBox;
    grbResultadoMatriz: TGroupBox;
    memResultado: TMemo;
    actProcessarGoogleMaps: TAction;
    cdsGoogleMaps: TFDMemTable;
    dtsGoogleMaps: TDataSource;
    cdsGoogleMapsCHAVE: TIntegerField;
    cdsGoogleMapsLATITUDE: TFloatField;
    cdsGoogleMapsLONGITUDE: TFloatField;
    cdsGoogleMapsTIPO: TStringField;
    cdsGoogleMapsPLACEID: TStringField;
    actDefault: TAction;
    cdsCoordenadas: TFDMemTable;
    cdsCoordenadasCHAVE: TIntegerField;
    cdsCoordenadasPLACEID: TStringField;
    cdsCoordenadasLATITUDE: TFloatField;
    cdsCoordenadasLONGITUDE: TFloatField;
    cdsCoordenadasORDEM: TSmallintField;
    cdsCoordenadasDISTANCIALINHARETA: TFloatField;
    cdsCoordenadasTEMPOPROCESSAMENTO: TIntegerField;
    btnMockar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGeocodificarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure actSubirUpdate(Sender: TObject);
    procedure actDescerUpdate(Sender: TObject);
    procedure actSubirExecute(Sender: TObject);
    procedure actDescerExecute(Sender: TObject);
    procedure actExcluirUpdate(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actTipoNenhumUpdate(Sender: TObject);
    procedure actTipoNenhumExecute(Sender: TObject);
    procedure actTipoOrigemUpdate(Sender: TObject);
    procedure actTipoOrigemExecute(Sender: TObject);
    procedure actTipoDestinoUpdate(Sender: TObject);
    procedure actTipoDestinoExecute(Sender: TObject);
    procedure actInversoUpdate(Sender: TObject);
    procedure actInversoExecute(Sender: TObject);
    procedure actProcessarMatrizDistanciaUpdate(Sender: TObject);
    procedure actProcessarMatrizDistanciaExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cobModoTransporteSelect(Sender: TObject);
    procedure actDefaultUpdate(Sender: TObject);
    procedure cobTipoMapaSelect(Sender: TObject);
    procedure btnMockarClick(Sender: TObject);
  private
    FGeoCodificacao: TMFCGeoCodificacao;
    FGeoMatrizDistancia: TMFCGeoMatrizDistancia;

    FQtdeOrigens, FQtdeDestinos: smallint;

    procedure GerarGoogleMaps;
    procedure GerarMatrizDistancia;

    procedure CalcularDistanciaLinhaReta;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.actDefaultUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := cdsGoogleMaps.Active and (cdsGoogleMapsTIPO.AsString<>'DEFAULT');
end;

procedure TForm1.actDescerExecute(Sender: TObject);
var
  Posicao: TBookmark;
  ChaveAtual: Integer;
  OrdemAtual, OrdemAnterior: integer;
begin
  try
    cdsCoordenadas.DisableControls;

    Posicao := cdsCoordenadas.GetBookmark;

    ChaveAtual := cdsCoordenadasCHAVE.AsInteger;
    OrdemAtual := cdsCoordenadasORDEM.AsInteger;

    cdsCoordenadas.Next;

    OrdemAnterior := cdsCoordenadasORDEM.AsInteger;

    cdsCoordenadas.Edit;
    cdsCoordenadasORDEM.AsInteger := OrdemAtual;
    cdsCoordenadas.Post;

    if cdsCoordenadas.Locate('CHAVE', ChaveAtual, []) then
    begin
      cdsCoordenadas.Edit;
      cdsCoordenadasORDEM.AsInteger := OrdemAnterior;
      cdsCoordenadas.post;
    end;

    CalcularDistanciaLinhaReta;
  finally
    cdsCoordenadas.GotoBookmark(Posicao);
    cdsCoordenadas.FreeBookmark(Posicao);

    cdsCoordenadas.EnableControls;
  end;
end;

procedure TForm1.actDescerUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := cdsCoordenadas.Active and (cdsCoordenadas.RecordCount>0) and not (cdsCoordenadas.Eof);
end;

procedure TForm1.actExcluirExecute(Sender: TObject);
begin
  cdsCoordenadas.Delete;
  CalcularDistanciaLinhaReta;
  GerarMatrizDistancia;
  GerarGoogleMaps;
end;

procedure TForm1.actExcluirUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := cdsCoordenadas.Active and (cdsCoordenadas.RecordCount<>0);
end;

procedure TForm1.actInversoExecute(Sender: TObject);
begin
  try
    try
      btnInverso.Enabled := False;

      Screen.Cursor := crHourGlass;

      stbResultado.Panels[0].Text := 'Processando...';

      Application.ProcessMessages;

      FGeoCodificacao.ProxyPassword := edtSenha.Text;
      FGeoCodificacao.ProxyServer := edtHost.Text;
      FGeoCodificacao.ProxyUserName := edtUsuario.Text;
      FGeoCodificacao.ProxyPort := StrToIntDef(edtPorta.Text,0);

      stbResultado.Panels[0].Text := 'Concluído em ' +IntToStr(FGeoCodificacao.TempoProcessamento) + ' milsecs';
      ShowMessage(FGeoCodificacao.getInverso(cdsCoordenadasLATITUDE.AsFloat, cdsCoordenadasLONGITUDE.AsFloat));
    except
      on E: Exception do
      begin
        stbResultado.Panels[0].Text := E.Message;
      end;
    end;
  finally
    Screen.Cursor := crDefault;

    btnInverso.Enabled := True;
  end;
end;

procedure TForm1.actInversoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := cdsCoordenadas.Active and (cdsCoordenadas.RecordCount>0);
end;

procedure TForm1.actProcessarMatrizDistanciaExecute(Sender: TObject);
begin
  try
    try
      btnProcessarMatrizDistancia.Enabled := False;
      Screen.Cursor := crHourGlass;

      stbResultado.Panels[0].Text := 'Processando...';

      Application.ProcessMessages;

      FGeoMatrizDistancia.Reset;

      memResultado.Lines.Clear;

      try
        cdsMatrizDistancia.DisableControls;
        cdsMatrizDistancia.First;

        while not cdsMatrizDistancia.Eof do
        begin
          if cdsMatrizDistanciaTIPO.AsString='ORIGEM' then
          begin
            FGeoMatrizDistancia.setCoordenadaOrigem(cdsMatrizDistanciaLATITUDE.AsFloat, cdsMatrizDistanciaLONGITUDE.AsFloat);
          end
          else if cdsMatrizDistanciaTIPO.AsString='DESTINO' then
          begin
            FGeoMatrizDistancia.setCoordenadaDestino(cdsMatrizDistanciaLATITUDE.AsFloat, cdsMatrizDistanciaLONGITUDE.AsFloat);
          end;

          cdsMatrizDistancia.Next;
        end;
      finally
        cdsMatrizDistancia.First;
        cdsMatrizDistancia.EnableControls;
      end;

      FGeoMatrizDistancia.ProxyPassword := edtSenha.Text;
      FGeoMatrizDistancia.ProxyServer := edtHost.Text;
      FGeoMatrizDistancia.ProxyUserName := edtUsuario.Text;
      FGeoMatrizDistancia.ProxyPort := StrToIntDef(edtPorta.Text,0);

      FGeoMatrizDistancia.KeyAPI := edtGoogleAPIKey.Text;

      case cobModoTransporte.ItemIndex of
        1: FGeoMatrizDistancia.setModoTransporte(mtPedestre);
        2: FGeoMatrizDistancia.setModoTransporte(mtBicicleta);
        3: FGeoMatrizDistancia.setModoTransporte(mtTransportePublico);
      else
        FGeoMatrizDistancia.setModoTransporte(mtCondutor);
      end;

      case cobRestricao.ItemIndex of
        1: FGeoMatrizDistancia.setRestricao(trPedagio);
        2: FGeoMatrizDistancia.setRestricao(trRodovia);
        3: FGeoMatrizDistancia.setRestricao(trEstradaDeFerro);
        4: FGeoMatrizDistancia.setRestricao(trInterior);
      end;

      if cobModoTransporte.ItemIndex=0 then
      begin
        case cobOpcaoTrafego.ItemIndex of
          1: FGeoMatrizDistancia.setOpcaoTrafego(moPessimista);
          2: FGeoMatrizDistancia.setOpcaoTrafego(moOtimista);
        else
          FGeoMatrizDistancia.setOpcaoTrafego(moMelhorChute);
        end;
      end
      else
      begin
        FGeoMatrizDistancia.setOpcaoTrafego(moNenhum);
      end;

      if cobModoTransporte.ItemIndex=3 then
      begin
        FGeoMatrizDistancia.setPreferenciaOnibus(ckbPreferenciaTransportePublico.Checked[0]);
        FGeoMatrizDistancia.setPreferenciaMetro(ckbPreferenciaTransportePublico.Checked[1]);
        FGeoMatrizDistancia.setPreferenciaTrem(ckbPreferenciaTransportePublico.Checked[2]);
        FGeoMatrizDistancia.setPreferenciaBonde(ckbPreferenciaTransportePublico.Checked[3]);
        FGeoMatrizDistancia.setPreferenciaEstradaFerro(ckbPreferenciaTransportePublico.Checked[4]);
      end;

      if cobHorario.Items[cobHorario.ItemIndex]='Partida' then
      begin
        FGeoMatrizDistancia.setTipoHorario(mhPartida);
      end
      else
      begin
        FGeoMatrizDistancia.setTipoHorario(mhChegada);
      end;

      FGeoMatrizDistancia.setHorario(dtHorario.DateTime);

      if FGeoMatrizDistancia.Executar then
      begin
        if FGeoMatrizDistancia.Status=stOk then
        begin
          if FGeoMatrizDistancia.Distancia.Valor<>0 then
          begin
            memResultado.Lines.Add('Distancia (metros): '+IntToStr(FGeoMatrizDistancia.Distancia.Valor));
            memResultado.Lines.Add('Distancia (Km): '+FGeoMatrizDistancia.Distancia.Texto);
          end;

          if FGeoMatrizDistancia.Duracao.Valor<>0 then
          begin
            memResultado.Lines.Add('');
            memResultado.Lines.Add('Duração sem trânsito (minutos): '+IntToStr(FGeoMatrizDistancia.Duracao.Valor));
            memResultado.Lines.Add('Duração sem trânsito (literal): '+FGeoMatrizDistancia.Duracao.Texto);
          end;

          if FGeoMatrizDistancia.Transito.Valor<>0 then
          begin
            memResultado.Lines.Add('');
            memResultado.Lines.Add('Duração com trânsito (minutos): '+IntToStr(FGeoMatrizDistancia.Transito.Valor));
            memResultado.Lines.Add('Duração com trânsito (literal): '+FGeoMatrizDistancia.Transito.Texto);
          end;

          if FGeoMatrizDistancia.CustoTransporte.Valor<>0 then
          begin
            memResultado.Lines.Add('');
            memResultado.Lines.Add('Custo (Moeda): '+FGeoMatrizDistancia.CustoTransporte.Moeda);
            memResultado.Lines.Add('Custo (literal): '+FGeoMatrizDistancia.CustoTransporte.Texto);
            memResultado.Lines.Add('Custo (valor): '+FloatToStr(FGeoMatrizDistancia.CustoTransporte.Valor));
          end;
        end
        else
        begin
          memResultado.Lines.Add('Retorno: '+FGeoMatrizDistancia.getDescricaoStatusGoogle(FGeoMatrizDistancia.Status));
        end;

        stbResultado.Panels[0].Text := 'Concluído em ' +IntToStr(FGeoMatrizDistancia.TempoProcessamento) + ' milsecs';
      end;
    except
      on E: Exception do
      begin
        memResultado.Lines.Add(E.Message);
        stbResultado.Panels[0].Text := E.Message;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    btnProcessarMatrizDistancia.Enabled := True;
  end;
end;

procedure TForm1.actProcessarMatrizDistanciaUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := cdsMatrizDistancia.Active and (cdsMatrizDistancia.RecordCount>0) and
                             (FQtdeOrigens>0) and (FQtdeDestinos>0);
end;

procedure TForm1.actSubirExecute(Sender: TObject);
var
  ChaveAtual: Integer;
  OrdemAtual, OrdemAnterior: integer;
  Posicao: TBookmark;
begin
  try
    cdsCoordenadas.DisableControls;

    Posicao := cdsCoordenadas.GetBookmark;

    ChaveAtual := cdsCoordenadasCHAVE.AsInteger;
    OrdemAtual := cdsCoordenadasORDEM.AsInteger;

    cdsCoordenadas.Prior;

    OrdemAnterior := cdsCoordenadasORDEM.AsInteger;

    cdsCoordenadas.Edit;
    cdsCoordenadasORDEM.AsInteger := OrdemAtual;
    cdsCoordenadas.Post;

    if cdsCoordenadas.Locate('CHAVE', ChaveAtual, []) then
    begin
      cdsCoordenadas.Edit;
      cdsCoordenadasORDEM.AsInteger := OrdemAnterior;
      cdsCoordenadas.post;
    end;

    CalcularDistanciaLinhaReta;
  finally
    cdsCoordenadas.GotoBookmark(Posicao);
    cdsCoordenadas.FreeBookmark(Posicao);

    cdsCoordenadas.EnableControls;
  end;
end;

procedure TForm1.actSubirUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := cdsCoordenadas.Active and (cdsCoordenadas.RecordCount>0) and not (cdsCoordenadas.Bof);
end;

procedure TForm1.actTipoDestinoExecute(Sender: TObject);
begin
  if cdsMatrizDistanciaTIPO.AsString='ORIGEM' then
  begin
    dec(FQtdeOrigens);
  end;

  cdsMatrizDistancia.Edit;
  cdsMatrizDistanciaTIPO.AsString:= 'DESTINO';
  cdsMatrizDistancia.Post;

  inc(FQtdeDestinos);
end;

procedure TForm1.actTipoDestinoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := cdsMatrizDistancia.Active and
                             (cdsMatrizDistancia.RecordCount<>0) and
                             (cdsMatrizDistanciaTIPO.AsString<>'DESTINO') and
                             (FQtdeDestinos = 0);
end;

procedure TForm1.actTipoNenhumExecute(Sender: TObject);
begin
  if cdsMatrizDistanciaTIPO.AsString='ORIGEM' then
  begin
    dec(FQtdeOrigens);
  end
  else if cdsMatrizDistanciaTIPO.AsString='DESTINO' then
  begin
    dec(FQtdeDestinos);
  end;

  cdsMatrizDistancia.Edit;
  cdsMatrizDistanciaTIPO.AsString:= '';
  cdsMatrizDistancia.Post;
end;

procedure TForm1.actTipoNenhumUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := cdsMatrizDistancia.Active and
                             (cdsMatrizDistancia.RecordCount<>0) and
                             (cdsMatrizDistanciaTIPO.AsString<>'');
end;

procedure TForm1.actTipoOrigemExecute(Sender: TObject);
begin
  if cdsMatrizDistanciaTIPO.AsString='DESTINO' then
  begin
    dec(FQtdeDestinos);
  end;

  cdsMatrizDistancia.Edit;
  cdsMatrizDistanciaTIPO.AsString:= 'ORIGEM';
  cdsMatrizDistancia.Post;

  inc(FQtdeOrigens);
end;

procedure TForm1.actTipoOrigemUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := cdsMatrizDistancia.Active and
                             (cdsMatrizDistancia.RecordCount<>0) and
                             (cdsMatrizDistanciaTIPO.AsString<>'ORIGEM') and
                             (FQtdeOrigens = 0);
end;

procedure TForm1.btnGeocodificarClick(Sender: TObject);
begin
  try
    try
      btnGeocodificar.Enabled := False;

      Screen.Cursor := crHourGlass;

      stbResultado.Panels[0].Text := 'Processando...';

      Application.ProcessMessages;

      FGeoCodificacao.ProxyPassword := edtSenha.Text;
      FGeoCodificacao.ProxyServer := edtHost.Text;
      FGeoCodificacao.ProxyUserName := edtUsuario.Text;
      FGeoCodificacao.ProxyPort := StrToIntDef(edtPorta.Text,0);

      FGeoCodificacao.KeyAPI := edtGoogleAPIKey.Text;
      FGeoCodificacao.Rua := edtRua.Text;
      FGeoCodificacao.Numero := edtNumero.Text;
      FGeoCodificacao.Bairro := edtBairro.Text;
      FGeoCodificacao.CEP := edtCEP.Text;
      FGeoCodificacao.Cidade := edtCidade.Text;
      FGeoCodificacao.UF := edtUF.Text;

      if FGeoCodificacao.Executar then
      begin
        try
          cdsCoordenadas.DisableControls;

          cdsCoordenadas.Filter := 'PLACEID='+QuotedStr(FGeoCodificacao.Endereco);
          cdsCoordenadas.Filtered := True;

          if cdsCoordenadas.RecordCount=0 then
          begin
            cdsCoordenadas.Filtered := False;

            cdsCoordenadas.Append;
            cdsCoordenadasCHAVE.AsInteger := cdsCoordenadas.RecordCount;
            cdsCoordenadasPLACEID.AsString := FGeoCodificacao.Endereco;
            cdsCoordenadasLATITUDE.AsFloat :=FGeoCodificacao.Latitude;
            cdsCoordenadasLONGITUDE.AsFloat := FGeoCodificacao.Longitude;
            cdsCoordenadasTEMPOPROCESSAMENTO.AsInteger := FGeoCodificacao.TempoProcessamento;
            cdsCoordenadasORDEM.AsInteger := cdsCoordenadasCHAVE.AsInteger;
            cdsCoordenadas.Post;

            CalcularDistanciaLinhaReta;

            GerarMatrizDistancia;
            GerarGoogleMaps;

            stbResultado.Panels[0].Text := 'Concluído em ' +IntToStr(FGeoCodificacao.TempoProcessamento) + ' milsecs';
          end
          else
          begin
            stbResultado.Panels[0].Text := 'Registro já incluido!';
          end;

          edtRua.Text := '';
          edtNumero.Text := '';
          edtComplemento.Text := '';
          edtCEP.Text := '';
          edtBairro.Text := '';
          edtCidade.Text := '';
        finally
          cdsCoordenadas.Filter := '';
          cdsCoordenadas.Filtered := False;
          cdsCoordenadas.EnableControls;
        end;
      end;
    except
      on E: Exception do
      begin
        stbResultado.Panels[0].Text := E.Message;
      end;
    end;
  finally
    Screen.Cursor := crDefault;

    btnGeocodificar.Enabled := True;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FGeoMatrizDistancia.AbrirExemplo;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FGeoCodificacao.AbrirExemplo;
end;

procedure TForm1.btnMockarClick(Sender: TObject);
begin
  edtRua.Text := 'Av. Francisco Matarazzo';
  edtNumero.Text := '1705';
  edtBairro.Text := 'ÁGUA BRANCA';
  edtCEP.Text := '05001-200';
  edtCidade.Text := 'SAO PAULO';
  btnGeocodificar.Click;
  Sleep(400);

  edtRua.Text := 'Av. Miguel Ignácio Curi';
  edtNumero.Text := '111';
  edtBairro.Text := 'Artur Alvim';
  edtCEP.Text := '08295-005';
  edtCidade.Text := 'SAO PAULO';
  btnGeocodificar.Click;
  Sleep(400);

  edtRua.Text := 'Praça Roberto Gomes Pedrosa';
  edtNumero.Text := '1';
  edtBairro.Text := 'Morumbi';
  edtCEP.Text := '05653-070';
  edtCidade.Text := 'SAO PAULO';
  btnGeocodificar.Click;
  Sleep(400);

  edtRua.Text := 'R. Comendador Nestor Pereira';
  edtNumero.Text := '33';
  edtBairro.Text := 'Canindé';
  edtCEP.Text := '01142-300';
  edtCidade.Text := 'SAO PAULO';
  btnGeocodificar.Click;
  Sleep(400);

  edtRua.Text := 'Av. Imperatriz Dona Tereza Cristina';
  edtNumero.Text := '11';
  edtBairro.Text := 'Jardim Guarani';
  edtCEP.Text := '13100-200';
  edtCidade.Text := 'CAMPINAS';
  btnGeocodificar.Click;
  Sleep(400);

  edtRua.Text := 'Praça Dr. Francisco Ursaia';
  edtNumero.Text := '1900';
  edtBairro.Text := 'Jardim Proença';
  edtCEP.Text := '13026-350';
  edtCidade.Text := 'CAMPINAS';
  btnGeocodificar.Click;
  Sleep(400);

  edtRua.Text := 'Rua Dr. Belmiro Fanelli';
  edtNumero.Text := '342';
  edtBairro.Text := 'Jardim Canaa';
  edtCEP.Text := '13486-710';
  edtCidade.Text := 'LIMEIRA';
  btnGeocodificar.Click;
  Sleep(400);

  edtRua.Text := 'R. Silva Jardim';
  edtNumero.Text := '849';
  edtBairro.Text := 'Alto';
  edtCEP.Text := '13419-140';
  edtCidade.Text := 'PIRACICABA';
  btnGeocodificar.Click;
  Sleep(400);

  edtRua.Text := 'Rua Wenceslau Braz';
  edtNumero.Text := '';
  edtBairro.Text := 'Vila Santa Terezinha';
  edtCEP.Text := '17051-390';
  edtCidade.Text := 'BAURU';
  btnGeocodificar.Click;

end;

procedure TForm1.CalcularDistanciaLinhaReta;
var
  LatAnt, LongAnt: double;

begin
  try
    Screen.Cursor := crHourGlass;

    cdsCoordenadas.DisableControls;

    cdsCoordenadas.First;


    LatAnt := 0;
    LongAnt := 0;

    while not cdsCoordenadas.Eof do
    begin
      if cdsCoordenadas.Bof then
      begin
        cdsCoordenadas.Edit;
        cdsCoordenadasDISTANCIALINHARETA.AsFloat := 0;
        cdsCoordenadas.Post;
      end
      else
      begin
        cdsCoordenadas.Edit;
        cdsCoordenadasDISTANCIALINHARETA.AsFloat :=
          SimpleRoundTo(FGeoCodificacao.GeoUteis.LinhaReta(LatAnt, LongAnt,
                                cdsCoordenadasLATITUDE.AsFloat,
                                cdsCoordenadasLONGITUDE.AsFloat),-3);
        cdsCoordenadas.Post;
      end;

      LatAnt := cdsCoordenadasLATITUDE.AsFloat;
      LongAnt := cdsCoordenadasLONGITUDE.AsFloat;

      cdsCoordenadas.Next;
    end;
  finally
    cdsCoordenadas.First;
    cdsCoordenadas.EnableControls;

    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.cobModoTransporteSelect(Sender: TObject);
begin
  cobHorario.Items.Clear;

  if cobModoTransporte.ItemIndex in [0,3] then // trnasporte publico ou condução
  begin
    cobHorario.Items.Add('Partida');
  end;

  cobHorario.Items.Add('Chegada');
  cobHorario.ItemIndex := 0;

  cobOpcaoTrafego.Enabled := cobModoTransporte.ItemIndex=0;
  lblTrafegoTrajeto.Enabled := cobModoTransporte.ItemIndex=0;

  ckbPreferenciaTransportePublico.Enabled := cobModoTransporte.ItemIndex=3;
  lblPreferenciaTransportePublico.Enabled := cobModoTransporte.ItemIndex=3;

  cobRoteamentoTransportePublico.Enabled := cobModoTransporte.ItemIndex=3;
  lblRoteamentoTransportePublico.Enabled := cobModoTransporte.ItemIndex=3;
end;

procedure TForm1.cobTipoMapaSelect(Sender: TObject);
begin
  actProcessarGoogleMaps.Execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FQtdeOrigens := 0;
  FQtdeDestinos := 0;

  cobRestricao.ItemIndex := 0;

  cobModoTransporte.ItemIndex := 0;
  cobOpcaoTrafego.ItemIndex := 0;

  dtHorario.DateTime := now+1;
  cobHorario.ItemIndex := 0;

  cobRoteamentoTransportePublico.ItemIndex := 0;

  cobModoTransporteSelect(nil);

  FGeoMatrizDistancia := nil;
  FGeoCodificacao := nil;

  FGeoMatrizDistancia := TMFCGeoMatrizDistancia.Create(Self.Handle);
  FGeoCodificacao := TMFCGeoCodificacao.Create(Self.Handle);

  cdsCoordenadas.IndexFieldNames := 'ORDEM';
  cdsCoordenadas.Close;
  cdsCoordenadas.Open;

  cdsMatrizDistancia.Close;
  cdsMatrizDistancia.Open;

  cdsGoogleMaps.Close;
  cdsGoogleMaps.Open;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FGeoCodificacao);
  FreeAndNil(FGeoMatrizDistancia);
end;

procedure TForm1.GerarGoogleMaps;
begin
  try
    cdsCoordenadas.DisableControls;
    cdsCoordenadas.First;

    cdsGoogleMaps.EmptyDataSet;
    while not cdsCoordenadas.Eof do
    begin
      cdsGoogleMaps.Append;
      cdsGoogleMapsCHAVE.AsInteger := cdsGoogleMaps.RecordCount;
      cdsGoogleMapsLATITUDE.AsFloat := cdsCoordenadasLATITUDE.AsFloat;
      cdsGoogleMapsLONGITUDE.AsFloat := cdsCoordenadasLONGITUDE.AsFloat;
      cdsGoogleMapsPLACEID.AsString := cdsCoordenadasPLACEID.AsString;

      if cdsGoogleMaps.RecordCount=1 then
      begin
        cdsGoogleMapsTIPO.AsString := 'DEFAULT';
      end;

      cdsGoogleMaps.Post;

      cdsCoordenadas.Next;
    end;

  finally
    cdsGoogleMaps.First;

    cdsCoordenadas.First;
    cdsCoordenadas.EnableControls;
  end;
end;

procedure TForm1.GerarMatrizDistancia;
begin
  try
    FQtdeOrigens := 0;
    FQtdeDestinos := 0;

    cdsCoordenadas.DisableControls;
    cdsCoordenadas.First;

    cdsMatrizDistancia.EmptyDataSet;
    while not cdsCoordenadas.Eof do
    begin
      cdsMatrizDistancia.Append;
      cdsMatrizDistanciaCHAVE.AsInteger := cdsMatrizDistancia.RecordCount;
      cdsMatrizDistanciaLATITUDE.AsFloat := cdsCoordenadasLATITUDE.AsFloat;
      cdsMatrizDistanciaLONGITUDE.AsFloat := cdsCoordenadasLONGITUDE.AsFloat;
      cdsMatrizDistanciaPLACEID.AsString := cdsCoordenadasPLACEID.AsString;

      if FQtdeOrigens=0 then
      begin
        cdsMatrizDistanciaTIPO.AsString := 'ORIGEM';
        inc(FQtdeOrigens);
      end
      else if FQtdeDestinos=0 then
      begin
        cdsMatrizDistanciaTIPO.AsString := 'DESTINO';
        inc(FQtdeDestinos);
      end;

      cdsMatrizDistancia.Post;
      cdsCoordenadas.Next;
    end;

  finally
    cdsMatrizDistancia.First;

    cdsCoordenadas.First;
    cdsCoordenadas.EnableControls;
  end;
end;

end.
