unit result;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,DbTables, db, FPEditFloat, ComCtrls;

type
  Tfrmresultado = class(TForm)
    btngravar: TButton;
    btnfechar: TButton;
    Panel1: TPanel;
    grbA: TGroupBox;
    lblselecao1_1: TLabel;
    Label3: TLabel;
    lblselecao1_2: TLabel;
    lblselecao2_2: TLabel;
    Label7: TLabel;
    lblselecao2_1: TLabel;
    lblselecao3_2: TLabel;
    lblselecao3_1: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    lblselecao4_1: TLabel;
    lblselecao4_2: TLabel;
    lblselecao5_2: TLabel;
    lblselecao5_1: TLabel;
    lblselecao6_1: TLabel;
    lblselecao6_2: TLabel;
    ckbencerrado1: TCheckBox;
    ckbencerrado2: TCheckBox;
    ckbencerrado3: TCheckBox;
    ckbencerrado4: TCheckBox;
    ckbencerrado5: TCheckBox;
    ckbencerrado6: TCheckBox;
    edtplacar1_1: TFPEditFloat;
    edtplacar1_2: TFPEditFloat;
    edtplacar2_1: TFPEditFloat;
    edtplacar2_2: TFPEditFloat;
    edtplacar3_1: TFPEditFloat;
    edtplacar4_1: TFPEditFloat;
    edtplacar3_2: TFPEditFloat;
    edtplacar4_2: TFPEditFloat;
    edtplacar5_1: TFPEditFloat;
    edtplacar5_2: TFPEditFloat;
    edtplacar6_1: TFPEditFloat;
    edtplacar6_2: TFPEditFloat;
    grbB: TGroupBox;
    lblselecao7_1: TLabel;
    lblselecao7_2: TLabel;
    lblselecao8_2: TLabel;
    lblselecao8_1: TLabel;
    lblselecao9_2: TLabel;
    lblselecao9_1: TLabel;
    lblselecao10_1: TLabel;
    lblselecao10_2: TLabel;
    lblselecao11_2: TLabel;
    lblselecao11_1: TLabel;
    lblselecao12_1: TLabel;
    lblselecao12_2: TLabel;
    Label1: TLabel;
    Label26: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label35: TLabel;
    Label39: TLabel;
    ckbencerrado7: TCheckBox;
    ckbencerrado8: TCheckBox;
    ckbencerrado9: TCheckBox;
    ckbencerrado10: TCheckBox;
    ckbencerrado11: TCheckBox;
    ckbencerrado12: TCheckBox;
    edtplacar7_1: TFPEditFloat;
    edtplacar7_2: TFPEditFloat;
    edtplacar8_1: TFPEditFloat;
    edtplacar8_2: TFPEditFloat;
    edtplacar9_1: TFPEditFloat;
    edtplacar10_1: TFPEditFloat;
    edtplacar9_2: TFPEditFloat;
    edtplacar10_2: TFPEditFloat;
    edtplacar11_1: TFPEditFloat;
    edtplacar11_2: TFPEditFloat;
    edtplacar12_1: TFPEditFloat;
    edtplacar12_2: TFPEditFloat;
    grbC: TGroupBox;
    lblselecao13_1: TLabel;
    lblselecao13_2: TLabel;
    lblselecao14_2: TLabel;
    lblselecao14_1: TLabel;
    lblselecao15_2: TLabel;
    lblselecao15_1: TLabel;
    lblselecao16_1: TLabel;
    lblselecao16_2: TLabel;
    lblselecao17_2: TLabel;
    lblselecao17_1: TLabel;
    lblselecao18_1: TLabel;
    lblselecao18_2: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ckbencerrado13: TCheckBox;
    ckbencerrado14: TCheckBox;
    ckbencerrado15: TCheckBox;
    ckbencerrado16: TCheckBox;
    ckbencerrado17: TCheckBox;
    ckbencerrado18: TCheckBox;
    edtplacar13_1: TFPEditFloat;
    edtplacar13_2: TFPEditFloat;
    edtplacar14_1: TFPEditFloat;
    edtplacar14_2: TFPEditFloat;
    edtplacar15_1: TFPEditFloat;
    edtplacar16_1: TFPEditFloat;
    edtplacar15_2: TFPEditFloat;
    edtplacar16_2: TFPEditFloat;
    edtplacar17_1: TFPEditFloat;
    edtplacar17_2: TFPEditFloat;
    edtplacar18_1: TFPEditFloat;
    edtplacar18_2: TFPEditFloat;
    grbD: TGroupBox;
    lblselecao19_1: TLabel;
    lblselecao19_2: TLabel;
    lblselecao20_2: TLabel;
    lblselecao20_1: TLabel;
    lblselecao21_2: TLabel;
    lblselecao21_1: TLabel;
    lblselecao22_1: TLabel;
    lblselecao22_2: TLabel;
    lblselecao23_2: TLabel;
    lblselecao23_1: TLabel;
    lblselecao24_1: TLabel;
    lblselecao24_2: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    ckbencerrado19: TCheckBox;
    ckbencerrado20: TCheckBox;
    ckbencerrado21: TCheckBox;
    ckbencerrado22: TCheckBox;
    ckbencerrado23: TCheckBox;
    ckbencerrado24: TCheckBox;
    edtplacar19_1: TFPEditFloat;
    edtplacar19_2: TFPEditFloat;
    edtplacar20_1: TFPEditFloat;
    edtplacar20_2: TFPEditFloat;
    edtplacar21_1: TFPEditFloat;
    edtplacar22_1: TFPEditFloat;
    edtplacar21_2: TFPEditFloat;
    edtplacar22_2: TFPEditFloat;
    edtplacar23_1: TFPEditFloat;
    edtplacar23_2: TFPEditFloat;
    edtplacar24_1: TFPEditFloat;
    edtplacar24_2: TFPEditFloat;
    Panel2: TPanel;
    grbE: TGroupBox;
    lblselecao25_1: TLabel;
    lblselecao25_2: TLabel;
    lblselecao26_2: TLabel;
    lblselecao26_1: TLabel;
    lblselecao27_2: TLabel;
    lblselecao27_1: TLabel;
    lblselecao28_1: TLabel;
    lblselecao28_2: TLabel;
    lblselecao29_2: TLabel;
    lblselecao29_1: TLabel;
    lblselecao30_1: TLabel;
    lblselecao30_2: TLabel;
    Label5: TLabel;
    Label19: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    ckbencerrado25: TCheckBox;
    ckbencerrado26: TCheckBox;
    ckbencerrado27: TCheckBox;
    ckbencerrado28: TCheckBox;
    ckbencerrado29: TCheckBox;
    ckbencerrado30: TCheckBox;
    edtplacar25_1: TFPEditFloat;
    edtplacar25_2: TFPEditFloat;
    edtplacar26_1: TFPEditFloat;
    edtplacar26_2: TFPEditFloat;
    edtplacar27_1: TFPEditFloat;
    edtplacar28_1: TFPEditFloat;
    edtplacar27_2: TFPEditFloat;
    edtplacar28_2: TFPEditFloat;
    edtplacar29_1: TFPEditFloat;
    edtplacar29_2: TFPEditFloat;
    edtplacar30_1: TFPEditFloat;
    edtplacar30_2: TFPEditFloat;
    grbF: TGroupBox;
    lblselecao31_1: TLabel;
    lblselecao31_2: TLabel;
    lblselecao32_2: TLabel;
    lblselecao32_1: TLabel;
    lblselecao33_2: TLabel;
    lblselecao33_1: TLabel;
    lblselecao34_1: TLabel;
    lblselecao34_2: TLabel;
    lblselecao35_2: TLabel;
    lblselecao35_1: TLabel;
    lblselecao36_1: TLabel;
    lblselecao36_2: TLabel;
    Label8: TLabel;
    Label25: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    ckbencerrado31: TCheckBox;
    ckbencerrado32: TCheckBox;
    ckbencerrado33: TCheckBox;
    ckbencerrado34: TCheckBox;
    ckbencerrado35: TCheckBox;
    ckbencerrado36: TCheckBox;
    edtplacar31_1: TFPEditFloat;
    edtplacar31_2: TFPEditFloat;
    edtplacar32_1: TFPEditFloat;
    edtplacar32_2: TFPEditFloat;
    edtplacar33_1: TFPEditFloat;
    edtplacar34_1: TFPEditFloat;
    edtplacar33_2: TFPEditFloat;
    edtplacar34_2: TFPEditFloat;
    edtplacar35_1: TFPEditFloat;
    edtplacar35_2: TFPEditFloat;
    edtplacar36_1: TFPEditFloat;
    edtplacar36_2: TFPEditFloat;
    grbG: TGroupBox;
    lblselecao37_1: TLabel;
    lblselecao37_2: TLabel;
    lblselecao38_2: TLabel;
    lblselecao38_1: TLabel;
    lblselecao39_2: TLabel;
    lblselecao39_1: TLabel;
    lblselecao40_1: TLabel;
    lblselecao40_2: TLabel;
    lblselecao41_2: TLabel;
    lblselecao41_1: TLabel;
    lblselecao42_1: TLabel;
    lblselecao42_2: TLabel;
    Label10: TLabel;
    Label31: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label44: TLabel;
    ckbencerrado37: TCheckBox;
    ckbencerrado38: TCheckBox;
    ckbencerrado39: TCheckBox;
    ckbencerrado40: TCheckBox;
    ckbencerrado41: TCheckBox;
    ckbencerrado42: TCheckBox;
    edtplacar37_1: TFPEditFloat;
    edtplacar37_2: TFPEditFloat;
    edtplacar38_1: TFPEditFloat;
    edtplacar38_2: TFPEditFloat;
    edtplacar39_1: TFPEditFloat;
    edtplacar40_1: TFPEditFloat;
    edtplacar39_2: TFPEditFloat;
    edtplacar40_2: TFPEditFloat;
    edtplacar41_1: TFPEditFloat;
    edtplacar41_2: TFPEditFloat;
    edtplacar42_1: TFPEditFloat;
    edtplacar42_2: TFPEditFloat;
    grbH: TGroupBox;
    lblselecao43_1: TLabel;
    lblselecao43_2: TLabel;
    lblselecao44_2: TLabel;
    lblselecao44_1: TLabel;
    lblselecao45_2: TLabel;
    lblselecao45_1: TLabel;
    lblselecao46_1: TLabel;
    lblselecao46_2: TLabel;
    lblselecao47_2: TLabel;
    lblselecao47_1: TLabel;
    lblselecao48_1: TLabel;
    lblselecao48_2: TLabel;
    Label20: TLabel;
    Label43: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    ckbencerrado43: TCheckBox;
    ckbencerrado44: TCheckBox;
    ckbencerrado45: TCheckBox;
    ckbencerrado46: TCheckBox;
    ckbencerrado47: TCheckBox;
    ckbencerrado48: TCheckBox;
    edtplacar43_1: TFPEditFloat;
    edtplacar43_2: TFPEditFloat;
    edtplacar44_1: TFPEditFloat;
    edtplacar44_2: TFPEditFloat;
    edtplacar45_1: TFPEditFloat;
    edtplacar46_1: TFPEditFloat;
    edtplacar45_2: TFPEditFloat;
    edtplacar46_2: TFPEditFloat;
    edtplacar47_1: TFPEditFloat;
    edtplacar47_2: TFPEditFloat;
    edtplacar48_1: TFPEditFloat;
    edtplacar48_2: TFPEditFloat;
    panclassificacao: TPanel;
    grboitavas: TGroupBox;
    ckbencerrado49: TCheckBox;
    ckbencerrado50: TCheckBox;
    ckbencerrado51: TCheckBox;
    ckbencerrado52: TCheckBox;
    ckbencerrado53: TCheckBox;
    ckbencerrado54: TCheckBox;
    ckbencerrado55: TCheckBox;
    ckbencerrado56: TCheckBox;
    panplacar49: TPanel;
    Label49: TLabel;
    rdgplacar49_2: TRadioButton;
    rdgplacar49_1: TRadioButton;
    panplacar50: TPanel;
    Label50: TLabel;
    rdgplacar50_2: TRadioButton;
    rdgplacar50_1: TRadioButton;
    panplacar51: TPanel;
    Label51: TLabel;
    rdgplacar51_2: TRadioButton;
    rdgplacar51_1: TRadioButton;
    panplacar52: TPanel;
    Label52: TLabel;
    rdgplacar52_2: TRadioButton;
    rdgplacar52_1: TRadioButton;
    panplacar53: TPanel;
    Label53: TLabel;
    rdgplacar53_2: TRadioButton;
    rdgplacar53_1: TRadioButton;
    panplacar54: TPanel;
    Label54: TLabel;
    rdgplacar54_2: TRadioButton;
    rdgplacar54_1: TRadioButton;
    panplacar55: TPanel;
    Label55: TLabel;
    rdgplacar55_2: TRadioButton;
    rdgplacar55_1: TRadioButton;
    panplacar56: TPanel;
    Label57: TLabel;
    rdgplacar56_2: TRadioButton;
    rdgplacar56_1: TRadioButton;
    Panel3: TPanel;
    grbquartas: TGroupBox;
    lblselecao57_1: TLabel;
    lblselecao57_2: TLabel;
    lblselecao58_2: TLabel;
    lblselecao58_1: TLabel;
    lblselecao59_1: TLabel;
    lblselecao59_2: TLabel;
    lblselecao60_1: TLabel;
    lblselecao60_2: TLabel;
    ckbencerrado57: TCheckBox;
    ckbencerrado58: TCheckBox;
    ckbencerrado59: TCheckBox;
    ckbencerrado60: TCheckBox;
    panplacar57: TPanel;
    Label56: TLabel;
    rdgplacar57_2: TRadioButton;
    rdgplacar57_1: TRadioButton;
    panplacar58: TPanel;
    Label58: TLabel;
    rdgplacar58_2: TRadioButton;
    rdgplacar58_1: TRadioButton;
    panplacar59: TPanel;
    Label59: TLabel;
    rdgplacar59_2: TRadioButton;
    rdgplacar59_1: TRadioButton;
    panplacar60: TPanel;
    Label60: TLabel;
    rdgplacar60_2: TRadioButton;
    rdgplacar60_1: TRadioButton;
    grbsemifinal: TGroupBox;
    ckbencerrado61: TCheckBox;
    ckbencerrado62: TCheckBox;
    panplacar61: TPanel;
    Label61: TLabel;
    rdgplacar61_2: TRadioButton;
    rdgplacar61_1: TRadioButton;
    panplacar62: TPanel;
    Label62: TLabel;
    rdgplacar62_2: TRadioButton;
    rdgplacar62_1: TRadioButton;
    Panel4: TPanel;
    lblselecao49_1: TLabel;
    lblselecao49_2: TLabel;
    lblselecao50_2: TLabel;
    lblselecao50_1: TLabel;
    lblselecao51_1: TLabel;
    lblselecao51_2: TLabel;
    lblselecao52_1: TLabel;
    lblselecao52_2: TLabel;
    lblselecao53_1: TLabel;
    lblselecao54_1: TLabel;
    lblselecao55_1: TLabel;
    lblselecao56_1: TLabel;
    lblselecao53_2: TLabel;
    lblselecao54_2: TLabel;
    lblselecao55_2: TLabel;
    lblselecao56_2: TLabel;
    lblselecao61_1: TLabel;
    lblselecao62_1: TLabel;
    lblselecao62_2: TLabel;
    lblselecao61_2: TLabel;
    grbterceirolugar: TGroupBox;
    ckbencerrado63: TCheckBox;
    lblselecao63_1: TLabel;
    Panel5: TPanel;
    Label64: TLabel;
    rdgplacar63_2: TRadioButton;
    rdgplacar63_1: TRadioButton;
    lblselecao63_2: TLabel;
    grbfinal: TGroupBox;
    lblselecao64_1: TLabel;
    lblselecao64_2: TLabel;
    ckbencerrado64: TCheckBox;
    Panel6: TPanel;
    Label66: TLabel;
    rdgplacar64_2: TRadioButton;
    rdgplacar64_1: TRadioButton;
    dtslocalizar8: TQuery;
    dtsincluir8: TQuery;
    dtsalterar8: TQuery;
    dtslerclassificacao8: TQuery;
    dtsatualizarSG8: TQuery;
    dtsordena8: TQuery;
    dtstemsorteio8: TQuery;
    Barra: TProgressBar;
    
    procedure FormCreate(Sender: TObject);
    procedure ckbencerrado1Click(Sender: TObject);
    procedure btnfecharClick(Sender: TObject);
    procedure btngravarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    minhamatriz: TQuery;

    bcalcularclassificacao: boolean;

    lblselecao: array[1..64,1..2] of TLabel;
    rdgplacar: array[49..64,1..2] of TRadioButton;
    edtplacar: array[1..48,1..2] of TFPEditFloat;
    ckbencerrado: array[1..64] of TCheckbox;
    sletragrupo: array[1..8] of string[1];

    ifaixajogos: array[1..8,1..2] of integer;
    iposicaooitava: array[1..8,1..2] of integer;

    dtsGravaMatriz: TQuery;

    procedure atualizarpontos;
    procedure Atribuirclassificacaooitavas(igrupo:integer);
    procedure AnalisarFinal;
    procedure AnalisarSemiFinal;    
    procedure AnalisarQuartas;
    procedure AnalisarOitavas(igrupo:integer);
    procedure AlterarOitavas(iselecao,ipontos,gm,gs:integer);
    procedure criartabelatemp(bcriar:boolean = TRUE);
    procedure Enabledbuttons;
    procedure carregarmatriz;
    procedure atribuircomponentes;
  public
    { Public declarations }
    iapostador: integer;// 0- COpa do mundo; #0 apostas
  end;

var
  frmresultado: Tfrmresultado;

implementation

uses dtMod, sorteio;

{$R *.dfm}

procedure Tfrmresultado.atualizarpontos;
var
  dtsestaclassificada,
  dtsselecionaraposta,
  dtsselecionarpessoas,
  dtspontos: TQuery;
  ivencedorMatriz: integer;
  ivencedorAposta: integer;
  ipontoplacar,
  ipontoresultado,
  ioitavachecada,
  ipontoclassificacao: integer;
  icont: integer;
begin
  dtsestaclassificada := TQuery.Create(Self);
  TQuery(dtsestaclassificada).Name := 'dtsestaclassificada';
  dtsestaclassificada.DatabaseName := Modulo.sdatabase;
  with dtsestaclassificada.sql do
  begin
    Add('SELECT');
    Add('COUNT(*) AAA');
    Add('FROM');
    Add('APOSTA.DB');
    Add('WHERE COD_APOSTADOR = :P_APOSTADOR');
    Add('AND COD_JOGO BETWEEN :P_JOGOINI AND :P_JOGOFIM');
    Add('AND ((COD_SELECAO1 = :P_CODSELECAO) OR (COD_SELECAO2 = :P_CODSELECAO))');
  end;

  dtsselecionaraposta := TQuery.Create(Self);
  TQuery(dtsselecionaraposta).Name := 'dtsselecionaraposta';
  dtsselecionaraposta.databasename := Modulo.sdatabase;
  with dtsselecionaraposta.sql do
  begin
    Add('SELECT');
    Add('COD_JOGO CODIGO,');
    Add('COD_SELECAO1,');
    Add('COD_SELECAO2,');
    Add('PLACAR1,');
    Add('PLACAR2,');
    Add('ENCERRADO');
    Add('FROM');
    Add('APOSTA.DB');
    Add('WHERE COD_APOSTADOR = :P_APOSTADOR');
    Add('ORDER BY COD_JOGO');
  end;

  dtsselecionarpessoas := TQuery.Create(Self);
  TQuery(dtsselecionarpessoas).Name := 'dtsselecionarpessoas';
  dtsselecionarpessoas.databasename := Modulo.sdatabase;
  with dtsselecionarpessoas.sql do
  begin
    Add('SELECT');
    Add('CODIGO');
    Add('FROM');
    Add('PESSOA.DB');
    Add('ORDER BY CODIGO');
  end;
  dtsselecionarpessoas.Open;
  Barra.Max := dtsselecionarpessoas.Recordcount;

  dtspontos := TQuery.Create(Self);
  TQuery(dtspontos).Name := 'dtspontos';
  dtspontos.databasename := Modulo.sdatabase;

  with dtspontos,dtspontos.sql do
  begin
    Add('UPDATE PESSOA.DB');
    Add('SET PONTORESULTADO = 0,');
    Add('PONTOCLASSIFICACAO = 0,');
    Add('PONTOPLACAR = 0,');
    Add('TOTALPONTOS = 0');
    ExecSql;

    Clear;
    Add('UPDATE PESSOA.DB');
    Add('SET PONTORESULTADO = :P_RESULTADO,');
    Add('PONTOCLASSIFICACAO = :P_CLASSIFICACAO,');
    Add('PONTOPLACAR = :P_PLACAR,');
    Add('TOTALPONTOS = :P_TOTALPONTOS');
    Add('WHERE CODIGO = :P_CODIGO');
  end;

  MinhaMatriz.close;
  MinhaMatriz.open;

  dtsselecionarpessoas.First;
  while not dtsselecionarpessoas.Eof do
  begin
    dtsselecionaraposta.Close;
    dtsselecionaraposta.Parambyname('P_APOSTADOR').AsInteger :=
      dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
    dtsselecionaraposta.Open;

    ipontoplacar := 0;
    ipontoresultado := 0;
    ipontoclassificacao := 0;

    // somente primeira fase
    ioitavachecada := 1;
    application.processmessages;
    for icont := 1 to 48 do
    begin
      if MinhaMatriz.Locate('CODIGO',icont,[locaseinsensitive]) then
      begin
        if MinhaMatriz.FieldByName('ENCERRADO').AsInteger = 1 then
        begin
          if dtsselecionaraposta.Locate('CODIGO',MinhaMatriz.Fieldbyname('CODIGO').AsInteger,
                                       [locaseinsensitive]) then
          begin
            if dtsselecionaraposta.FieldByName('ENCERRADO').AsInteger = 1 then
            begin
              if MinhaMatriz.FieldbyName('PLACAR1').AsInteger =
                 MinhaMatriz.FieldbyName('PLACAR2').AsInteger then
              begin
               ivencedorMatriz := 0
              end
              else if MinhaMatriz.FieldbyName('PLACAR1').AsInteger >
                      MinhaMatriz.FieldbyName('PLACAR2').AsInteger then
                ivencedorMatriz := 1
              else
                ivencedorMatriz := 2;

              if dtsselecionaraposta.FieldbyName('PLACAR1').AsInteger =
                 dtsselecionaraposta.FieldbyName('PLACAR2').AsInteger then
              begin
                ivencedorAposta := 0
              end
              else if dtsselecionaraposta.FieldbyName('PLACAR1').AsInteger >
                      dtsselecionaraposta.FieldbyName('PLACAR2').AsInteger then
                ivencedorAposta := 1
              else
                ivencedorAposta := 2;

              if ivencedormatriz = ivencedoraposta then
              begin
                inc(ipontoresultado,3);

                if (MinhaMatriz.FieldbyName('PLACAR1').AsInteger =
                    dtsselecionaraposta.FieldbyName('PLACAR1').AsInteger) and
                   (MinhaMatriz.FieldbyName('PLACAR2').AsInteger =
                    dtsselecionaraposta.FieldbyName('PLACAR2').AsInteger) then
                  inc(ipontoplacar,2);
              end;
            end;
          end;
        end
        else
          ioitavachecada := 1000;
      end
      else
        showmessage('nao localizou');
    end;

    if ioitavachecada <> 1000 then
    begin
      // oitavas de final
      for icont := 49 to 56 do
      begin
        if MinhaMatriz.Locate('CODIGO',icont,[locaseinsensitive]) then
        begin
  //        if MinhaMatriz.FieldByName('ENCERRADO').AsInteger = 1 then
   //      begin
          if (MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger <> 0) and
             (MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger <> 0) then
          begin
            dtsestaclassificada.Close;
            dtsestaclassificada.ParamByName('P_APOSTADOR').AsInteger :=
              dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
            dtsestaclassificada.ParamByName('P_JOGOINI').AsInteger := 49;
            dtsestaclassificada.ParamByName('P_JOGOFIM').AsInteger := 56;
            dtsestaclassificada.ParamByName('P_CODSELECAO').AsInteger :=
              MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger;
            dtsestaclassificada.Open;

            if dtsestaclassificada.FieldByName('AAA').AsInteger = 1 then
              inc(ipontoclassificacao,3);

            dtsestaclassificada.Close;
            dtsestaclassificada.ParamByName('P_APOSTADOR').AsInteger :=
              dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
            dtsestaclassificada.ParamByName('P_JOGOINI').AsInteger := 49;
            dtsestaclassificada.ParamByName('P_JOGOFIM').AsInteger := 56;
            dtsestaclassificada.ParamByName('P_CODSELECAO').AsInteger :=
              MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger;
            dtsestaclassificada.Open;

            if dtsestaclassificada.FieldByName('AAA').AsInteger = 1 then
              inc(ipontoclassificacao,3);
          end;
        end
        else
          showmessage('nao localizou');

        application.processmessages;
      end;

      // quartas de final
      for icont := 57 to 60 do
      begin
        if MinhaMatriz.Locate('CODIGO',icont,[locaseinsensitive]) then
        begin
          //if MinhaMatriz.FieldByName('ENCERRADO').AsInteger = 1 then
  //        begin
          if (MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger <> 0) and
             (MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger <> 0) then
          begin
            dtsestaclassificada.Close;
            dtsestaclassificada.ParamByName('P_APOSTADOR').AsInteger :=
              dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
            dtsestaclassificada.ParamByName('P_JOGOINI').AsInteger := 57;
            dtsestaclassificada.ParamByName('P_JOGOFIM').AsInteger := 60;
            dtsestaclassificada.ParamByName('P_CODSELECAO').AsInteger :=
              MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger;
            dtsestaclassificada.Open;

            if dtsestaclassificada.FieldByName('AAA').AsInteger = 1 then
              inc(ipontoclassificacao,3);

            dtsestaclassificada.Close;
            dtsestaclassificada.ParamByName('P_APOSTADOR').AsInteger :=
              dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
            dtsestaclassificada.ParamByName('P_JOGOINI').AsInteger := 57;
            dtsestaclassificada.ParamByName('P_JOGOFIM').AsInteger := 60;
            dtsestaclassificada.ParamByName('P_CODSELECAO').AsInteger :=
              MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger;
            dtsestaclassificada.Open;

            if dtsestaclassificada.FieldByName('AAA').AsInteger = 1 then
              inc(ipontoclassificacao,3);
          end;
        end
        else
          showmessage('nao localizou');

        application.processmessages;
      end;

      // quartas de final
      for icont := 61 to 62 do
      begin
        if MinhaMatriz.Locate('CODIGO',icont,[locaseinsensitive]) then
        begin
  //        if MinhaMatriz.FieldByName('ENCERRADO').AsInteger = 1 then
  //        begin
          if (MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger <> 0) and
             (MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger <> 0) then
          begin
            dtsestaclassificada.Close;
            dtsestaclassificada.ParamByName('P_APOSTADOR').AsInteger :=
              dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
            dtsestaclassificada.ParamByName('P_JOGOINI').AsInteger := 61;
            dtsestaclassificada.ParamByName('P_JOGOFIM').AsInteger := 62;
            dtsestaclassificada.ParamByName('P_CODSELECAO').AsInteger :=
              MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger;
            dtsestaclassificada.Open;

            if dtsestaclassificada.FieldByName('AAA').AsInteger = 1 then
              inc(ipontoclassificacao,3);

            dtsestaclassificada.Close;
            dtsestaclassificada.ParamByName('P_APOSTADOR').AsInteger :=
              dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
            dtsestaclassificada.ParamByName('P_JOGOINI').AsInteger := 61;
            dtsestaclassificada.ParamByName('P_JOGOFIM').AsInteger := 62;
            dtsestaclassificada.ParamByName('P_CODSELECAO').AsInteger :=
              MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger;
            dtsestaclassificada.Open;

            if dtsestaclassificada.FieldByName('AAA').AsInteger = 1 then
              inc(ipontoclassificacao,3);
          end;
        end
        else
          showmessage('nao localizou');

        application.processmessages;
      end;

      // final
      for icont := 64 to 64 do
      begin
        if MinhaMatriz.Locate('CODIGO',icont,[locaseinsensitive]) then
        begin
  //        if MinhaMatriz.FieldByName('ENCERRADO').AsInteger = 1 then
    //      begin
          if (MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger <> 0) and
             (MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger <> 0) then
          begin
            if MinhaMatriz.FieldbyName('PLACAR1').AsInteger >
               MinhaMatriz.FieldByName('PLACAR2').AsInteger then
              ivencedormatriz := MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger
            else
              ivencedormatriz := MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger;

            if dtsselecionaraposta.Locate('CODIGO',
                                          MinhaMatriz.Fieldbyname('CODIGO').AsInteger,
                                          [locaseinsensitive]) then
            begin
              if dtsselecionaraposta.FieldByName('PLACAR1').AsInteger >
                 dtsselecionaraposta.FieldByName('PLACAR2').AsInteger then
                ivencedorAposta := dtsselecionaraposta.FieldByName('COD_SELECAO1').AsInteger
              else
                ivencedorAposta := dtsselecionaraposta.FieldByName('COD_SELECAO2').AsInteger;
            end;

            dtsestaclassificada.Close;
            dtsestaclassificada.ParamByName('P_APOSTADOR').AsInteger :=
              dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
            dtsestaclassificada.ParamByName('P_JOGOINI').AsInteger := 64;
            dtsestaclassificada.ParamByName('P_JOGOFIM').AsInteger := 64;
            dtsestaclassificada.ParamByName('P_CODSELECAO').AsInteger :=
              MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger;
            dtsestaclassificada.Open;

            if dtsestaclassificada.FieldByName('AAA').AsInteger = 1 then
            begin
              inc(ipontoclassificacao,3);
            end;

            dtsestaclassificada.Close;
            dtsestaclassificada.ParamByName('P_APOSTADOR').AsInteger :=
              dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
            dtsestaclassificada.ParamByName('P_JOGOINI').AsInteger := 64;
            dtsestaclassificada.ParamByName('P_JOGOFIM').AsInteger := 64;
            dtsestaclassificada.ParamByName('P_CODSELECAO').AsInteger :=
              MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger;
            dtsestaclassificada.Open;

            if dtsestaclassificada.FieldByName('AAA').AsInteger = 1 then
            begin
              inc(ipontoclassificacao,3);
            end;

            if MinhaMatriz.FieldByName('ENCERRADO').AsInteger = 1 then
            begin
              if ivencedoraposta = ivencedormatriz then
                inc(ipontoclassificacao,15);
            end;
          end;
        end
        else
          showmessage('nao localizou');

        application.processmessages;
      end;
    end;

    with dtspontos,dtspontos.sql do
    begin
      Close;
      ParamByName('P_PLACAR').AsInteger := ipontoplacar;
      ParamByName('P_RESULTADO').AsInteger := ipontoresultado;
      ParamByName('P_CLASSIFICACAO').AsInteger := ipontoclassificacao;
      ParamByName('P_TOTALPONTOS').AsInteger := ipontoplacar+ipontoresultado+
                                                ipontoclassificacao;
      ParambyName('P_CODIGO').AsInteger :=
        dtsselecionarpessoas.FieldByName('CODIGO').AsInteger;
      ExecSql;
    end;

    dtsselecionarpessoas.Next;
    Barra.Position := Barra.Position+1;
    Application.ProcessMessages;
  end;

  FreeAndNil(dtsestaclassificada);
  FreeAndNil(dtsselecionaraposta);
  FreeAndNil(dtsselecionarpessoas);
  FreeAndNil(dtspontos);
end;

procedure Tfrmresultado.Atribuirclassificacaooitavas(igrupo:integer);
var
  iselecaoPrimeiro,
  iselecaoSegundo: integer;

begin
  iselecaoPrimeiro := 0;
  iselecaoSegundo  := 0;

  dtstemsorteio8.Open;

  if {(iapostador <> 0) or }(dtstemsorteio8.FieldbyName('AAA').AsInteger > 1) then
  begin
    frmsorteio := Tfrmsorteio.create(Self);

    dtsordena8.open;
    while not dtsordena8.eof do
    begin
      if Modulo.dtsselecao.Locate('CODIGO',dtsordena8.FieldByName('SELECAO').AsInteger,
                                  [locaseinsensitive]) then
      begin
        frmsorteio.rdgprimeiro.items.add(Modulo.dtsselecao.FieldByName('SIGLA').AsString);
      end;

      dtsordena8.next;
      application.processmessages;
    end;

    frmsorteio.rdgsegundo.items.assign(frmsorteio.rdgprimeiro.items);

    frmsorteio.rdgprimeiro.itemindex := 0;
    frmsorteio.rdgsegundo.itemindex := 0;

    frmsorteio.caption := 'Sorteio do Grupo '+sletragrupo[igrupo];
    frmsorteio.showmodal;

    if Modulo.dtsselecao.Locate('SIGLA',
                               frmsorteio.rdgprimeiro.items[frmsorteio.rdgprimeiro.ItemIndex],
                               [locaseinsensitive]) then
      iselecaoPrimeiro := Modulo.dtsselecao.FieldbyName('CODIGO').Asinteger;

    if Modulo.dtsselecao.Locate('SIGLA',
                               frmsorteio.rdgsegundo.items[frmsorteio.rdgsegundo.ItemIndex],
                               [locaseinsensitive]) then
      iselecaoSegundo := Modulo.dtsselecao.FieldbyName('CODIGO').Asinteger;


    dtsordena8.close;

    FreeandNil(frmsorteio);
  end
  else
  begin
    dtsordena8.Open;
    iselecaoPrimeiro :=  dtsOrdena8.FieldByname('SELECAO').AsInteger;
    dtsordena8.next;
    iselecaosegundo := dtsOrdena8.FieldByname('SELECAO').AsInteger;
  end;

  // primeira colocação
  lblselecao[iposicaooitava[igrupo,1],1].tag := iselecaoprimeiro;

  if Modulo.dtsselecao.Locate('CODIGO',iselecaoprimeiro,[locaseinsensitive]) then
  begin
    lblselecao[iposicaooitava[igrupo,1],1].Caption :=
      Modulo.dtsselecao.FieldByName('SIGLA').AsString;
    lblselecao[iposicaooitava[igrupo,1],1].Hint :=
      Modulo.dtsselecao.FieldByName('NOME').AsString;
    lblselecao[iposicaooitava[igrupo,1],1].ShowHint := true;
  end;

  // segunda colocacao
  lblselecao[iposicaooitava[igrupo,2],2].tag := iselecaosegundo;
  if Modulo.dtsselecao.Locate('CODIGO',iselecaosegundo,[locaseinsensitive]) then
  begin
    lblselecao[iposicaooitava[igrupo,2],2].Caption :=
      Modulo.dtsselecao.FieldByName('SIGLA').AsString;

    lblselecao[iposicaooitava[igrupo,2],2].Hint :=
      Modulo.dtsselecao.FieldByName('NOME').AsString;
    lblselecao[iposicaooitava[igrupo,2],2].ShowHint := true;
  end;

  dtstemsorteio8.Close;
  dtsordena8.Close;
end;

procedure TfrmResultado.AnalisarFinal;
var
  i: integer;
  iperdedor,
  ivencedor: integer;
  btudochecado: boolean;
begin
  // limpar valores da final
  for i := 63 to 64 do
  begin
    if i = 63 then
      ckbencerrado[63].Checked := true
    else
      ckbencerrado[i].Checked := false;

    lblselecao[i,1].tag := 0;
    lblselecao[i,2].tag := 0;
    lblselecao[i,1].Caption := '?';
    lblselecao[i,2].Caption := '?';

    lblselecao[i,1].ShowHint := false;
    lblselecao[i,2].ShowHint := false;
                  
    rdgplacar[i,1].checked := true;
    application.processmessages;
  end;

  btudochecado := true;
  for i := 61 to 62 do // semi-final
  begin
    btudochecado := btudochecado and ckbencerrado[i].checked;
    application.processmessages;
  end;

  if btudochecado then
  begin
    for i := 61 to 62 do // quartas
    begin
      if rdgplacar[i,1].checked then // verificar vencedor do jogo
      begin
        ivencedor := 1;
        iperdedor := 2;
      end
      else
      begin
        ivencedor := 2;
        iperdedor := 1;
      end;

      case i of
        61: begin
              // grande final
              lblselecao[64,1].tag := lblselecao[61,ivencedor].tag;
              lblselecao[64,1].caption := lblselecao[61,ivencedor].caption;
              lblselecao[64,1].Hint := lblselecao[61,ivencedor].Hint;
              lblselecao[64,1].ShowHint := true;

              // terceiro
              lblselecao[63,1].tag := lblselecao[61,iperdedor].tag;
              lblselecao[63,1].caption := lblselecao[61,iperdedor].caption;
              lblselecao[63,1].Hint := lblselecao[61,iperdedor].Hint;
              lblselecao[63,1].ShowHint := true;
            end;
        62: begin
              // grande final
              lblselecao[64,2].tag := lblselecao[62,ivencedor].tag;
              lblselecao[64,2].caption := lblselecao[62,ivencedor].caption;
              lblselecao[64,2].Hint := lblselecao[62,ivencedor].Hint;
              lblselecao[64,2].ShowHint := true;

              // terceiro
              lblselecao[63,2].tag := lblselecao[62,iperdedor].tag;
              lblselecao[63,2].caption := lblselecao[62,iperdedor].caption;
              lblselecao[63,2].Hint := lblselecao[62,iperdedor].Hint;
              lblselecao[63,2].ShowHint := true;              
            end;
      end;
    end;
  end;
end;

procedure TfrmResultado.AnalisarSemiFinal;
var
  i: integer;
  ivencedor: integer;
  btudochecado: boolean;
begin
  // limpar valores da semi-final
  for i := 61 to 62 do
  begin
    ckbencerrado[i].Checked := false;
    lblselecao[i,1].tag := 0;
    lblselecao[i,2].tag := 0;
    lblselecao[i,1].Caption := '?';
    lblselecao[i,2].Caption := '?';
    lblselecao[i,1].Hint := '';
    lblselecao[i,2].Hint := '';
    lblselecao[i,1].ShowHint := false;
    lblselecao[i,2].ShowHint := false;


    rdgplacar[i,1].checked := true;
    application.processmessages;
  end;

  btudochecado := true;
  for i := 57 to 60 do // quartas
  begin
    btudochecado := btudochecado and ckbencerrado[i].checked;
    application.processmessages;
  end;

  if btudochecado then
  begin
    for i := 57 to 60 do // quartas
    begin
      if rdgplacar[i,1].checked then // verificar campeao do jogo
        ivencedor := 1
      else
        ivencedor := 2;

      case i of
        57: begin
              lblselecao[62,1].tag := lblselecao[57,ivencedor].tag;
              lblselecao[62,1].caption := lblselecao[57,ivencedor].caption;
              lblselecao[62,1].Hint:= lblselecao[57,ivencedor].Hint;
              lblselecao[62,1].ShowHint := true;
            end;
        58: begin
              lblselecao[61,1].tag := lblselecao[58,ivencedor].tag;
              lblselecao[61,1].caption := lblselecao[58,ivencedor].caption;
              lblselecao[61,1].Hint := lblselecao[58,ivencedor].Hint;
              lblselecao[61,1].ShowHint := true;              
            end;
        59: begin
              lblselecao[61,2].tag := lblselecao[59,ivencedor].tag;
              lblselecao[61,2].caption := lblselecao[59,ivencedor].caption;
              lblselecao[61,2].Hint := lblselecao[59,ivencedor].Hint;
              lblselecao[61,2].ShowHint := true;              
            end;
        60: begin
              lblselecao[62,2].tag := lblselecao[60,ivencedor].tag;
              lblselecao[62,2].caption := lblselecao[60,ivencedor].caption;
              lblselecao[62,2].Hint := lblselecao[60,ivencedor].Hint;
              lblselecao[62,2].ShowHint := true;              
            end;
      end;
    end;
  end;
end;

procedure TfrmResultado.AnalisarQuartas;
var
  i: integer;
  ivencedor: integer;
  btudochecado: boolean;
begin
  // limpar valores da quarta
  for i := 57 to 60 do
  begin
    ckbencerrado[i].Checked := false;
    lblselecao[i,1].tag := 0;
    lblselecao[i,2].tag := 0;
    lblselecao[i,1].Caption := '?';
    lblselecao[i,2].Caption := '?';
    lblselecao[i,1].Hint := '';
    lblselecao[i,2].Hint := '';
    lblselecao[i,1].ShowHint := false;
    lblselecao[i,2].ShowHint := false;
    rdgplacar[i,1].checked := true;
    application.processmessages;
  end;

  btudochecado := true;
  for i := 49 to 56 do // oitavas
  begin
    btudochecado := btudochecado and ckbencerrado[i].checked;
    application.processmessages;
  end;

  if btudochecado then
  begin
    for i := 49 to 56 do // oitavas
    begin
      if rdgplacar[i,1].checked then // verificar campeao do jogo
        ivencedor := 1
      else
        ivencedor := 2;

      case i of
        49: begin
              lblselecao[58,1].tag := lblselecao[49,ivencedor].tag;
              lblselecao[58,1].caption := lblselecao[49,ivencedor].caption;
              lblselecao[58,1].Hint := lblselecao[49,ivencedor].Hint;
              lblselecao[58,1].SHowHint := true;
            end;
        50: begin
              lblselecao[57,1].tag := lblselecao[50,ivencedor].tag;
              lblselecao[57,1].caption := lblselecao[50,ivencedor].caption;
              lblselecao[57,1].Hint := lblselecao[50,ivencedor].Hint;
              lblselecao[57,1].ShowHint := true;              
            end;
        51: begin
              lblselecao[60,1].tag := lblselecao[51,ivencedor].tag;
              lblselecao[60,1].caption := lblselecao[51,ivencedor].caption;
              lblselecao[60,1].Hint := lblselecao[51,ivencedor].Hint;
              lblselecao[60,1].ShowHint := true;
            end;
        52: begin
              lblselecao[59,1].tag := lblselecao[52,ivencedor].tag;
              lblselecao[59,1].caption := lblselecao[52,ivencedor].caption;
              lblselecao[59,1].HInt := lblselecao[52,ivencedor].Hint;
              lblselecao[59,1].ShowHint := true;              
            end;
        53: begin
              lblselecao[58,2].tag := lblselecao[53,ivencedor].tag;
              lblselecao[58,2].caption := lblselecao[53,ivencedor].caption;
              lblselecao[58,2].Hint := lblselecao[53,ivencedor].Hint;
              lblselecao[58,2].ShowHint := true;              
            end;
        54: begin
              lblselecao[57,2].tag := lblselecao[54,ivencedor].tag;
              lblselecao[57,2].caption := lblselecao[54,ivencedor].caption;
              lblselecao[57,2].Hint := lblselecao[54,ivencedor].Hint;
              lblselecao[57,2].ShowHint := true;              
            end;
        55: begin
              lblselecao[60,2].tag := lblselecao[55,ivencedor].tag;
              lblselecao[60,2].caption := lblselecao[55,ivencedor].caption;
              lblselecao[60,2].Hint := lblselecao[55,ivencedor].Hint;
              lblselecao[60,2].ShowHint := true;              
            end;
        56: begin
              lblselecao[59,2].tag := lblselecao[56,ivencedor].tag;
              lblselecao[59,2].caption := lblselecao[56,ivencedor].caption;
              lblselecao[59,2].Hint := lblselecao[56,ivencedor].Hint;
              lblselecao[59,2].ShowHint := true;              
            end;
      end;
    end;
  end;
end;

procedure TfrmResultado.AnalisarOitavas(igrupo:integer);
var
  i: integer;
  ipontos: array[1..2] of integer;
  btudochecado: boolean;
begin
  criartabelatemp;

  btudochecado := true;
  for i := ifaixajogos[igrupo,1] to ifaixajogos[igrupo,2] do
  begin
    btudochecado := btudochecado and ckbencerrado[i].checked;
    Application.Processmessages;
  end;

  if btudochecado then
  begin
    for i := ifaixajogos[igrupo,1] to ifaixajogos[igrupo,2] do
    begin
      if edtplacar[i,1].value = edtplacar[i,2].value then
      begin
        ipontos[1] := 1;
        ipontos[2] := 1;
      end
      else if edtplacar[i,1].value > edtplacar[i,2].value then
      begin
        ipontos[1] := 3;
        ipontos[2] := 0;
      end
      else
      begin
        ipontos[1] := 0;
        ipontos[2] := 3;
      end;

      AlterarOitavas(lblselecao[i,1].tag,ipontos[1],
                     Trunc(edtplacar[i,1].value),Trunc(edtplacar[i,2].value));

      AlterarOitavas(lblselecao[i,2].tag,ipontos[2],
                     Trunc(edtplacar[i,2].value),Trunc(edtplacar[i,1].value));

//      ckbencerrado[i].checked := false;

      Application.ProcessMessages;
    end;

    dtsatualizarSG8.Close;
    dtsatualizarSG8.ExecSql;

    Atribuirclassificacaooitavas(igrupo);
  end;
end;

procedure Tfrmresultado.AlterarOitavas(iselecao,ipontos,gm,gs:integer);
begin
  dtslocalizar8.close;
  dtslocalizar8.ParamByName('P_SELECAO').AsInteger := iselecao;
  dtslocalizar8.Open;

  if dtslocalizar8.FieldBYName('AAA').AsInteger = 0 then
  begin
    with dtsincluir8 do
    begin
      Close;
      ParamByName('P_SELECAO').AsInteger := iselecao;
      ParamByName('P_PG').AsInteger := ipontos;
      ParamByName('P_GM').AsInteger := gm;
      ParamByName('P_GS').AsInteger := gs;
      ExecSql;
    end;
  end
  else
  begin
    with dtsalterar8 do
    begin
      Close;
      ParamByName('P_SELECAO').AsInteger := iselecao;
      ParamByName('P_PG').AsInteger := ipontos;
      ParamByName('P_GM').AsInteger := gm;
      ParamByName('P_GS').AsInteger := gs;
      ExecSql;
    end;
  end;
end;

procedure Tfrmresultado.criartabelatemp(bcriar:boolean = TRUE);
var
  dtscriar: TQuery;
begin
  dtscriar := TQuery.Create(Self);
  TQuery(dtsCriar).Name := 'dtscriar';

  with dtscriar do
  begin
    databasename := C_TEMP;
    with Sql do
    begin
      Clear;

      if bcriar then
      begin
        if fileExists(C_TEMP+'\OITAVA.DB') then
          Add('DELETE FROM OITAVA.DB')
        else
        begin
          Add('CREATE TABLE "OITAVA.DB"');
          Add('(');
          add('SELECAO INTEGER,');
          Add('PG INTEGER,');
          Add('SG INTEGER,');
          Add('GM INTEGER,');
          Add('GS INTEGER,');
          Add('PRIMARY KEY (SELECAO))');
        end;
      end
      else
      begin
        if fileExists(C_TEMP+'\OITAVA.DB') then
          Add('DROP TABLE "OITAVA.DB"')
      end;
    end;

    ExecSql;
  end;

  FreeAndNil(dtsCriar);
end;

procedure Tfrmresultado.Enabledbuttons;
var
  i: integer;
begin
  // oitavas
  i := 1;
  while i <= 48 do
  begin
    if ckbencerrado[i].Checked then
      inc(i)
    else
      i := 1000;

    application.processmessages;
  end;

  grboitavas.Visible := i <> 1000;

  // quartas
  i := 49;
  while i <= 56 do
  begin
    if ckbencerrado[i].Checked then
      inc(i)
    else
      i := 1000;

    application.processmessages;
  end;

  grbquartas.Visible := (i <> 1000) and grboitavas.Visible;

  // semi-final
  i := 57;
  while i <= 60 do
  begin
    if ckbencerrado[i].Checked then
      inc(i)
    else
      i := 1000;

    application.processmessages;
  end;

  grbsemifinal.Visible := (i <> 1000) and grbquartas.visible;

  // terceiro e final
  i := 61;
  while i <= 62 do
  begin
    if ckbencerrado[i].Checked then
      inc(i)
    else
      i := 1000;

    application.processmessages;
  end;
  grbterceirolugar.Visible := false;
  grbfinal.Visible := (i <> 1000) and (grbsemifinal.Visible);

  if iapostador <> 0 then
    btngravar.Enabled := grbfinal.Visible and ckbencerrado[64].Checked;
end;

procedure Tfrmresultado.carregarmatriz;
var
  i: integer;
begin
  for i := 1 to 64 do
  begin
    if Minhamatriz.Locate('CODIGO',i,[locaseinsensitive]) then
    begin
      lblselecao[i,1].Tag := MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger;
      lblselecao[i,2].Tag := MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger;

      if i = 63 then
        ckbencerrado[63].Checked := true
      else
        ckbencerrado[i].Checked := Boolean(MinhaMatriz.FieldByName('ENCERRADO').AsInteger);

      if modulo.dtsselecao.Locate('CODIGO',
         MinhaMatriz.FieldByName('COD_SELECAO1').AsInteger,[locaseinsensitive]) then
      begin
        lblselecao[i,1].caption := modulo.dtsselecao.FieldByName('SIGLA').AsString;
        lblselecao[i,1].Hint := Modulo.dtsselecao.FieldByName('NOME').AsString;
        lblselecao[i,1].ShowHint := true;
      end
      else
      begin
        lblselecao[i,1].caption := '?';
        lblselecao[i,1].Hint := '';
        lblselecao[i,1].ShowHint := false;
      end;

      if modulo.dtsselecao.Locate('CODIGO',
         MinhaMatriz.FieldByName('COD_SELECAO2').AsInteger,[locaseinsensitive]) then
      begin
        lblselecao[i,2].caption := modulo.dtsselecao.FieldByName('SIGLA').AsString;
        lblselecao[i,2].Hint := Modulo.dtsselecao.FieldByName('NOME').AsString;
        lblselecao[i,2].ShowHint := true;
      end
      else
      begin
        lblselecao[i,2].caption := '?';
        lblselecao[i,2].Hint := '';
        lblselecao[i,2].ShowHint := false;
      end;

      if i <= 48 then
      begin
        edtplacar[i,1].value := MinhaMatriz.FieldByName('PLACAR1').AsInteger;
        edtplacar[i,2].value := MinhaMatriz.FieldByName('PLACAR2').AsInteger;
      end
      else
      begin
        if MinhaMatriz.FieldByName('PLACAR1').AsInteger = 0 then
          rdgplacar[i,2].Checked := true
        else
          rdgplacar[i,1].Checked := true;
      end;
    end;

    application.processmessages;
  end;
end;

procedure Tfrmresultado.atribuircomponentes;
var
  i: integer;
  cpaux: Tcomponent;
begin
  for i := 1 to 64 do
  begin
    cpAux := FindComponent('ckbencerrado'+IntToStr(i));
    ckbencerrado[i] := (cpAux as TCheckBox);

    // labels
    cpAux := FindCOmponent('lblselecao'+IntToStr(i)+'_1');
    lblselecao[i,1] := (cpAux as TLabel);

    cpAux := FindCOmponent('lblselecao'+IntToStr(i)+'_2');
    lblselecao[i,2] := (cpAux as TLabel);

    if i <=48 then
    begin
      cpAux := FindComponent('edtplacar'+IntToStr(i)+'_1');
      edtplacar[i,1] := (cpAux as TFpEditFloat);

      cpAux := FindComponent('edtplacar'+IntToStr(i)+'_2');
      edtplacar[i,2] := (cpAux as TFPEditFloat);
    end
    else
    begin
      cpAux := FindComponent('rdgplacar'+IntToStr(i)+'_1');
      rdgplacar[i,1] := (cpAux as TRadioButton);

      cpAux := FindComponent('rdgplacar'+IntToStr(i)+'_2');
      rdgplacar[i,2] := (cpAux as TRadioButton);
    end;

    try
      if i = 63 then
      begin
        ckbencerrado[63].OnClick := ckbencerrado1Click;
        ckbencerrado[63].Checked := true;
      end
      else
      begin
        ckbencerrado[i].OnClick := ckbencerrado1Click;
        ckbencerrado[i].Checked := false;
      end;
    except
      on E:Exception do
      begin
        showmessage(E.Message+'/'+IntToStr(i));
      end;
    end;

    Application.ProcessMessages;
  end;

  // a
  ifaixajogos[1,1] := 1;
  ifaixajogos[1,2] := 6;
  iposicaooitava[1,1] := 50; // colocacao
  iposicaooitava[1,2] := 51;
  sletragrupo[1] := 'A';

  // b
  ifaixajogos[2,1] := 7;
  ifaixajogos[2,2] := 12;
  iposicaooitava[2,1] := 52; // colocacao
  iposicaooitava[2,2] := 49;
  sletragrupo[2] := 'B';

  // c
  ifaixajogos[3,1] := 13;
  ifaixajogos[3,2] := 18;
  iposicaooitava[3,1] := 54; // colocacao
  iposicaooitava[3,2] := 55;
  sletragrupo[3] := 'C';

  //d
  ifaixajogos[4,1] := 19;
  ifaixajogos[4,2] := 24;
  iposicaooitava[4,1] := 56; // colocacao
  iposicaooitava[4,2] := 53;
  sletragrupo[4] := 'D';  

  // e
  ifaixajogos[5,1] := 25;
  ifaixajogos[5,2] := 30;
  iposicaooitava[5,1] := 49; // colocacao
  iposicaooitava[5,2] := 52;
  sletragrupo[5] := 'E';

  // f
  ifaixajogos[6,1] := 31;
  ifaixajogos[6,2] := 36;
  iposicaooitava[6,1] := 51; // colocacao
  iposicaooitava[6,2] := 50;
  sletragrupo[6] := 'F';

  // g
  ifaixajogos[7,1] := 37;
  ifaixajogos[7,2] := 42;
  iposicaooitava[7,1] := 53; // colocacao
  iposicaooitava[7,2] := 56;
  sletragrupo[7] := 'G';

  // h
  ifaixajogos[8,1] := 43;
  ifaixajogos[8,2] := 48;
  iposicaooitava[8,1] := 55; // colocacao
  iposicaooitava[8,2] := 54;
  sletragrupo[8] := 'H';  

  Application.ProcessMessages;
end;

procedure Tfrmresultado.FormCreate(Sender: TObject);
begin
  with dtslocalizar8, dtslocalizar8.sql do
  begin
    databasename := C_TEMP;
    Add('SELECT COUNT(*) AAA FROM OITAVA.DB');
    Add('WHERE SELECAO = :P_SELECAO');
  end;

  with dtsincluir8,dtsincluir8.sql do
  begin
    databasename := C_TEMP;
    Add('INSERT INTO OITAVA.DB (SELECAO,PG,GM,GS)');
    Add('VALUES (:P_SELECAO,:P_PG,:P_GM,:P_GS)');
  end;

  with dtstemsorteio8, dtstemsorteio8.sql do
  begin
    databasename := C_TEMP;
    Add('SELECT DISTINCT PG,SG,GM,COUNT(*) AAA FROM OITAVA.DB');
    Add('GROUP BY PG,SG,GM');
    Add('HAVING COUNT(*) > 1');
  end;

  with dtsordena8,dtsordena8.sql do
  begin
    databasename := C_TEMP;
    Add('select SELECAO,PG,SG,GM from oitava.db');
    Add('ORDER BY PG DESC, SG DESC, GM DESC');
  end;

  with dtsalterar8,dtsalterar8.sql do
  begin
    databasename := C_TEMP;
    Add('UPDATE OITAVA.DB');
    Add('SET PG = PG + :P_PG,');
    Add('GM = GM + :P_GM,');
    Add('GS = GS + :P_GS');
    Add('WHERE SELECAO = :P_SELECAO');
  end;

  with dtslerclassificacao8, dtslerclassificacao8.sql do
  begin
    databasename := C_TEMP;
    Add('SELECT * FROM OITAVA.DB');
    Add('ORDER BY PG DESC, SG DESC, GM DESC');
  end;

  with dtsatualizarSG8, dtsatualizarSG8.sql do
  begin
    databasename := C_TEMP;
    Add('UPDATE OITAVA.DB');
    Add('SET SG = GM-GS');
  end;
end;

procedure Tfrmresultado.ckbencerrado1Click(Sender: TObject);
var
  icont,
  i: integer;
begin
  try
    i := StrToInt(copy((Sender as TCheckbox).Name,13,2));

    lblselecao[i,1].Enabled := not ckbencerrado[i].Checked;
    lblselecao[i,2].Enabled := not ckbencerrado[i].Checked;

    if i <= 48 then
    begin
      edtplacar[i,1].Enabled := not ckbencerrado[i].Checked;
      edtplacar[i,2].Enabled := not ckbencerrado[i].Checked;

      if bcalcularclassificacao then
      begin
        // limpar valores da final
        for icont := 49 to 64 do
        begin
          ckbencerrado[icont].Checked := false;
          rdgplacar[icont,1].checked := true;
          application.processmessages;
        end;

        case i of
          01..06: AnalisarOitavas(1);
          07..12: AnalisarOitavas(2);
          13..18: AnalisarOitavas(3);
          19..24: AnalisarOitavas(4);
          25..30: AnalisarOitavas(5);
          31..36: AnalisarOitavas(6);
          37..42: AnalisarOitavas(7);
          43..48: AnalisarOitavas(8);
        end;
      end;
    end
    else
    begin
      rdgplacar[i,1].Enabled := (not ckbencerrado[i].Checked) and (lblselecao[i,1].Tag <> 0);
      rdgplacar[i,2].Enabled := (not ckbencerrado[i].Checked) and (lblselecao[i,2].Tag <> 0);

      if (lblselecao[i,1].Tag = 0) or (lblselecao[i,2].Tag = 0) then
        ckbencerrado[i].Checked := false;

      case i of
        49..56: AnalisarQuartas;
        57..60: AnalisarSemiFinal;
        61..62: AnalisarFinal;
      end;
    end;

    Enabledbuttons;
  except
    on E:Exception do
    begin
      showmessage(E.Message);
    end;
  end;
end;

procedure Tfrmresultado.btnfecharClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmresultado.btngravarClick(Sender: TObject);
var
  i: integer;
begin
  btngravar.enabled := false;
  btnfechar.Enabled := false;

  Barra.Position := 0;
  Barra.Max := 64;

  for i := 1 to 64 do
  begin
    with dtsgravamatriz do
    begin
      Close;
      ParambyName('P_CODIGO').AsInteger := i;

      if iapostador <> 0 then
        ParamByName('P_APOSTADOR').AsInteger := iapostador;

      ParamByName('P_COD_SELECAO1').Asinteger := lblselecao[i,1].tag;
      ParamByName('P_COD_SELECAO2').Asinteger := lblselecao[i,2].tag;

      if i <= 48 then
      begin
        ParamByName('P_PLACAR1').AsINteger := trunc(edtplacar[i,1].value);
        ParamByName('P_PLACAR2').AsINteger := trunc(edtplacar[i,2].value);
      end
      else
      begin
        if rdgplacar[i,1].checked then
        begin
          ParambyName('P_PLACAR1').AsInteger := 1;
          ParambyName('P_PLACAR2').AsInteger := 0;
        end
        else
        begin
          ParambyName('P_PLACAR1').AsInteger := 0;
          ParambyName('P_PLACAR2').AsInteger := 1;
        end;
      end;

      if ckbencerrado[i].checked then
        ParamByname('P_ENCERRADO').AsInteger := 1
      else
        ParamByname('P_ENCERRADO').AsInteger := 0;

      ExecSql;
    end;

    Barra.Position := Barra.Position+1;

    application.processmessages;
  end;

  Barra.Position := 0;

  if iapostador = 0 then
  begin
    atualizarpontos;
  end;

  btnfechar.Enabled := true;
  btngravar.enabled := true;

  MinhaMatriz.close;
  MinhaMatriz.open;

  close;
end;

procedure Tfrmresultado.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtsgravamatriz);
  criartabelatemp(false);
end;

procedure Tfrmresultado.FormShow(Sender: TObject);
begin
  dtsGravaMatriz := TQuery.Create(Self);
  TQuery(dtsgravaMatriz).name := 'dtsgravaMatriz';
  with dtsgravamatriz, dtsgravamatriz.sql do
  begin
    databasename :=  Modulo.sdatabase;

    if iapostador = 0 then
    begin
      Add('UPDATE MATRIZ.DB');
      Add('SET PLACAR1 = :P_PLACAR1,');
      Add('PLACAR2 = :P_PLACAR2,');
      Add('COD_SELECAO1 = :P_COD_SELECAO1,');
      Add('COD_SELECAO2 = :P_COD_SELECAO2,');
      Add('ENCERRADO = :P_ENCERRADO');
      Add('WHERE CODIGO = :P_CODIGO');
    end
    else
    begin
      Add('UPDATE APOSTA.DB');
      Add('SET PLACAR1 = :P_PLACAR1,');
      Add('PLACAR2 = :P_PLACAR2,');
      Add('COD_SELECAO1 = :P_COD_SELECAO1,');
      Add('COD_SELECAO2 = :P_COD_SELECAO2,');
      Add('ENCERRADO = :P_ENCERRADO');
      Add('WHERE COD_JOGO = :P_CODIGO');
      Add('AND COD_APOSTADOR = :P_APOSTADOR');
    end;
  end;

  if iapostador = 0 then
  begin
    MinhaMatriz := modulo.dtsmatriz;
  end
  else
  begin
    with modulo.dtsaposta do
    begin
      Close;
      ParamByname('P_APOSTADOR').AsInteger := iapostador;
      Open;
    end;

    MinhaMatriz := modulo.dtsaposta;
  end;

  bcalcularclassificacao := false;
  criartabelatemp;
  atribuircomponentes;
  carregarmatriz;

  Enabledbuttons;

  bcalcularclassificacao := true;
end;       

procedure Tfrmresultado.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := btnFechar.Enabled;
end;

end.
