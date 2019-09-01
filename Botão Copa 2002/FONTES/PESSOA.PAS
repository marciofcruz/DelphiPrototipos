unit pessoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Menus, StdCtrls, ExtCtrls, Buttons, Mask,
  Grids, DBGrids, dtMod, DB, DBTables, FPEditFloat;

type
  Tfrmpessoa = class(TForm)
    TbBarraBotoes: TToolBar;
    btnFechar: TToolButton;
    ToolButton1: TToolButton;
    btnPrimeiro: TToolButton;
    btnAnterior: TToolButton;
    btnProximo: TToolButton;
    btnUltimo: TToolButton;
    btnLocalizar: TToolButton;
    btnDetalhes: TToolButton;
    ToolButton2: TToolButton;
    btnNovo: TToolButton;
    btnAlterar: TToolButton;
    btnExcluir: TToolButton;
    btnSalvar: TToolButton;
    btnCancelar: TToolButton;
    mnutblGeral: TMainMenu;
    mniOpcoes: TMenuItem;
    mniPrimeiro: TMenuItem;
    mniAnterior: TMenuItem;
    mniProximo: TMenuItem;
    mniUltimo: TMenuItem;
    mniLocalizar: TMenuItem;
    mniDetalhes: TMenuItem;
    N2: TMenuItem;
    mniNovo: TMenuItem;
    mniAlterar: TMenuItem;
    mniExcluir: TMenuItem;
    mniSalvar: TMenuItem;
    mniCancelar: TMenuItem;
    N1: TMenuItem;
    mniImpressao: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    mniFechar: TMenuItem;
    pagGeral: TPageControl;
    tabprocura: TTabSheet;
    tabmanutencao: TTabSheet;
    panprocura: TPanel;
    cobIndice: TComboBox;
    edtProcurar: TMaskEdit;
    btnProcurar: TSpeedButton;
    dcGridPrincipal: TDBGrid;
    StatusBar1: TStatusBar;
    dtsgeral: TQuery;
    dsGeral: TDataSource;
    Label3: TLabel;
    edtnome: TEdit;
    ckbpago: TCheckBox;
    Label1: TLabel;
    edtsenha: TEdit;
    btngerarsenha: TButton;
    btnpreencher: TToolButton;
    mnipreencher: TMenuItem;
    Label2: TLabel;
    lblcodigo: TLabel;
    btnimpressao: TToolButton;
    procedure dsGeralDataChange(Sender: TObject; Field: TField);
    procedure mniFecharClick(Sender: TObject);
    procedure mniPrimeiroClick(Sender: TObject);
    procedure mniAnteriorClick(Sender: TObject);
    procedure mniProximoClick(Sender: TObject);
    procedure mniUltimoClick(Sender: TObject);
    procedure mniLocalizarClick(Sender: TObject);
    procedure mniDetalhesClick(Sender: TObject);
    procedure mniNovoClick(Sender: TObject);
    procedure mniAlterarClick(Sender: TObject);
    procedure mniExcluirClick(Sender: TObject);
    procedure mniSalvarClick(Sender: TObject);
    procedure mniCancelarClick(Sender: TObject);
    procedure dcGridPrincipalKeyPress(Sender: TObject; var Key: Char);
    procedure btnProcurarClick(Sender: TObject);
    procedure edtProcurarKeyPress(Sender: TObject; var Key: Char);
    procedure cobIndiceChange(Sender: TObject);
    procedure cobIndiceClick(Sender: TObject);
    procedure cobIndiceExit(Sender: TObject);
    procedure cobIndiceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cobIndiceKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btngerarsenhaClick(Sender: TObject);
    procedure mnipreencherClick(Sender: TObject);
    procedure mniImpressaoClick(Sender: TObject);
  private
    { Private declarations }
    smensagem: string;
    TipoOperacao: TTipoOperacao;
    tempoini,tempofim: TTime;

    procedure CriarTabelaJogo(ipessoa:integer);
    function gerarsenha:string;
    procedure qtdecadastrados;
    procedure FocalizarPaginaProcura;
    function Incluir:boolean;
    procedure Deletar;
    function Alterar:boolean;

    procedure LimparCampos;
    function LocalizarRepetido:boolean;
    procedure Focalizar;
  public
    { Public declarations }

    procedure EnabledButtons;
    procedure pesquisar(trazertudo:boolean = TRUE);
  end;

const
    C_TABELA = 'PESSOA.DB';

var
  frmpessoa: Tfrmpessoa;

implementation

uses impress, result;

{$R *.dfm}

procedure Tfrmpessoa.CriarTabelaJogo(ipessoa:integer);
var
  dtsaposta: TQuery;
  i: integer;
begin
  dtsaposta := TQuery.Create(Self);
  TQuery(dtsaposta).Name := 'dtsaposta';

  with dtsaposta, dtsaposta.sql do
  begin
    databasename := modulo.sdatabase;

    Add('INSERT INTO APOSTA.DB (COD_APOSTADOR,COD_JOGO,COD_SELECAO1,COD_SELECAO2,');
    Add('PLACAR1,PLACAR2,ENCERRADO)');
    Add('VALUES (:P_COD_APOSTADOR,:P_COD_JOGO,:P_COD_SELECAO1,:P_COD_SELECAO2,');
    Add(':P_PLACAR1,:P_PLACAR2,:P_ENCERRADO)');

    for i := 1 to 64 do
    begin
      close;
      ParamByName('P_COD_APOSTADOR').AsInteger := ipessoa;
      ParamByName('P_COD_JOGO').AsInteger := i;
      ParamByName('P_ENCERRADO').AsInteger := 0;
      ParamByName('P_PLACAR1').AsInteger := 0;
      ParamByName('P_PLACAR2').AsInteger := 0;

      if i <= 48 then
      begin
        if Modulo.dtsmatriz.Locate('CODIGO',i,[locaseinsensitive]) then
        begin
          ParamByName('P_COD_SELECAO1').AsInteger :=
            Modulo.dtsmatriz.FieldByName('COD_SELECAO1').AsInteger;
          ParamByName('P_COD_SELECAO2').AsInteger :=
            Modulo.dtsmatriz.FieldByName('COD_SELECAO2').AsInteger;
        end;
      end
      else
      begin
        ParamByName('P_COD_SELECAO1').AsInteger := 0;
        ParamByName('P_COD_SELECAO2').AsInteger := 0;
      end;

      try
        ExecSql;
      except
        FreeAndNil(dtsaposta);
      end;

      Application.processmessages;
    end;
  end;

  FreeAndNil(dtsaposta);
end;

function Tfrmpessoa.gerarsenha:string;
var
  y: integer;
  i: integer;
  sletra: string;
begin
  sletra := 'MARCIOFRU';
  randomize;
  
  for i := 1 to 6 do
  begin
    y := Random(9);

    if Odd(y) then
      Result := Result+sletra[y]
    else
      Result := Result+IntToStr(Random(9));

    Application.ProcessMessages;
  end;
end;

procedure Tfrmpessoa.qtdecadastrados;
var
  dtsQtde: TQuery;
begin
  dtsQtde := TQuery.Create(Self);
  TQuery(dtsQtde).Name := 'dtsqtde';

  with dtsqtde do
  begin
    DataBaseName := modulo.sDataBase;

    with sql do
    begin
      Add('SELECT COUNT(*) AAA FROM '+C_TABELA);
    end;
    Open;

    StatusBar1.Panels[1].Text :=
      Format('%d cadastrado(s)',[FieldByName('AAA').AsInteger]);

    Close;
  end;

  FreeAndNil(dtsQtde);
end;

procedure Tfrmpessoa.FocalizarPaginaProcura;
begin
  edtProcurar.SetFocus;
  Application.ProcessMessages;
end;

function Tfrmpessoa.Incluir:boolean;
var
  dtsTmp: TQuery;
begin
  Result := false;

  if not LocalizarRepetido then
  begin
    Self.Enabled := false;
    dtsTmp := TQuery.Create(Self);
    try
      TQuery(dtsTmp).Name := 'dtsTmp';

      with dtsTmp do
      begin
        DataBaseName := modulo.sdatabase;

        with Sql do
        begin
          Add('INSERT INTO '+C_TABELA+' (NOME,PAGO,SENHA)');
          Add('VALUES (:P_NOME,:P_PAGO,:P_SENHA)');
        end;

        ParamByName('P_NOME').AsString := Trim(edtNome.Text);
        ParamByName('P_PAGO').AsBoolean := ckbpago.checked;
        ParamByName('P_SENHA').AsString := edtsenha.text;

        ExecSql;

        Sql.Clear;
        Sql.Add('SELECT MAX(CODIGO) AAA FROM PESSOA.DB');
        Open;

        CriarTabelaJogo(FieldByName('AAA').AsInteger);
        Close;
      end;

      Result := true;

      Pesquisar;
    finally
      dtsTmp.Close;
      FreeAndNil(dtsTmp);
    end;

    Self.Enabled := true;
  end
  else
  begin
    MessageBox(Handle,PChar('Linha já existe.'),'Atenção',
              mb_Ok+mb_IconInformation);

    // Habilitar botão para usuário poder gravar
    btnSalvar.Enabled := true;
    mniSalvar.Enabled := true;

    Focalizar;
  end;
end;

procedure Tfrmpessoa.Deletar;
var
  dtsTmp: TQuery;
begin
  dtsTmp := TQuery.Create(Self);

  try
    TQuery(dtsTmp).Name := 'dtsTmp';

    with dtsTmp,dtsTmp.Sql do
    begin
      DataBaseName := modulo.sdatabase;

      Clear;
      Add('DELETE FROM '+C_TABELA);
      Add('WHERE CODIGO = :P_CODIGO');
      ParamByName('P_CODIGO').AsInteger := dtsgeral.FieldByname('CODIGO').AsInteger;
      ExecSql;

      Clear;
      Add('DELETE FROM APOSTA.DB');
      Add('WHERE COD_APOSTADOR = :P_CODIGO');
      ParamByName('P_CODIGO').AsInteger := dtsgeral.FieldByname('CODIGO').AsInteger;
      ExecSql;
    end;
  finally
    dtsTmp.Close;
    FreeAndNil(dtsTmp);
  end;
end;

function Tfrmpessoa.Alterar:boolean;
var
  dtsTmp: TQuery;
begin
  if not LocalizarRepetido then
  begin
    dtsTmp := TQuery.Create(Self);

    try
      TQuery(dtsTmp).Name := 'dtsTmp';

      with dtsTmp do
      begin
        DataBaseName := modulo.sDataBase;

        with Sql do
        begin
          Add('UPDATE '+C_TABELA);
          Add('SET NOME = :P_NOME,');
          Add('PAGO = :P_PAGO,');
          Add('SENHA = :P_SENHA');
          Add('WHERE CODIGO = :P_CODIGO');
        end;

        ParamByName('P_NOME').AsString := Trim(edtNome.Text);
        ParamByName('P_PAGO').AsBoolean := ckbpago.checked;
        ParamByName('P_SENHA').AsString := edtsenha.text;
        ParamByName('P_CODIGO').AsInteger := dtsGeral.FieldByName('CODIGO').AsInteger;

        ExecSql;

        Result := true;
      end;
    finally
      dtsTmp.Close;
      FreeAndNil(dtsTmp);
    end;
  end
  else
  begin
    MessageBox(Handle,PChar('Linha já existe.'),'Atenção',
               mb_Ok+mb_IconInformation);

    Result := false;

    // Habilitar botão para usuário poder gravar
    btnSalvar.Enabled := true;
    mniSalvar.Enabled := true;

    Focalizar;
  end;
end;

procedure Tfrmpessoa.LimparCampos;
begin
  lblcodigo.caption := '';
  edtnome.Text := '';
  ckbpago.Checked := false;
  edtsenha.text := gerarsenha;
end;

function Tfrmpessoa.LocalizarRepetido:boolean;
var
  dtsTmp: TQuery;
begin
  Result := false;

  dtsTmp := TQuery.Create(Self);
  try
    TQuery(dtsTmp).Name := 'dtsTmp';

    with dtsTmp do
    begin
      DataBaseName := modulo.sDataBase;

      with Sql do
      begin
        Add('SELECT NOME FROM '+C_TABELA);
        Add('WHERE NOME = :P_NOME');
      end;

      ParamByName('P_NOME').AsString := Trim(edtNome.text);

      Prepare;
      Open;

       if TipoOperacao = tpoInclusao then
       begin
         Result := RecordCount <> 0;
       end
       else
       begin
         if Trim(edtNome.text) = dtsGeral.FieldByName('NOME').AsString then
           Result := false
         else
           Result := RecordCount <> 0;
       end;
    end;
  finally
    dtsTmp.Close;
    FreeAndNil(dtsTmp);
  end;
end;

procedure Tfrmpessoa.Focalizar;
begin
  btnSalvar.Enabled := true;
  mniSalvar.Enabled := true;

  edtnome.setfocus;
end;

procedure Tfrmpessoa.EnabledButtons;
begin
  case TipoOperacao of
    tpoConsulta: begin
                   statusbar1.Panels[2].Text := 'CONSULTA';
                   mniCancelar.ShortCut := 0;
                   mniFechar.ShortCut := 27;
                 end;
    tpoInclusao: begin
                   statusbar1.Panels[2].Text := 'INCLUSÃO';
                   StatusBar1.Panels[0].Text :=  '';
                   mniCancelar.ShortCut := 27;
                   mniFechar.ShortCut := 0;
                 end;
    tpoAlteracao: begin
                    statusbar1.Panels[2].Text := 'ALTERAÇÃO';
                    StatusBar1.Panels[0].Text :=  '';
                    mniCancelar.ShortCut := 27;
                    mniFechar.ShortCut := 0;
                  end;
  end;

  btnpreencher.Enabled := (TipoOperacao = tpoconsulta) and (dtsGeral.Active) and
                          (dtsGeral.RecordCount <> 0) and (Modulo.bapostasliberadas);
  mnipreencher.Enabled := btnpreencher.Enabled;
  btnpreencher.Visible := btnpreencher.Enabled;
  mnipreencher.Visible := btnpreencher.Enabled;

  btnimpressao.Enabled := (TipoOperacao = tpoconsulta) and (dtsGeral.Active) and
                          (dtsGeral.RecordCount <> 0);
  mniimpressao.Enabled := btnimpressao.Enabled;
  btnimpressao.Visible := btnimpressao.Enabled;
  mniimpressao.Visible := btnimpressao.Enabled;

  btngerarsenha.Enabled := TIpoOperacao in [tpoalteracao,tpoinclusao];
  btngerarsenha.Visible := btngerarsenha.Enabled;

  btnDetalhes.Enabled := (TipoOperacao = tpoconsulta) and (dtsGeral.Active) and
                         (dtsGeral.RecordCount <> 0) and
                         (paggeral.ActivePage = tabprocura);

  mniDetalhes.Enabled := btnDetalhes.Enabled;

  // Parte dos botoes de navegacao
  btnPrimeiro.Enabled := (TipoOperacao = tpoConsulta) and (not dtsGeral.BOF);
  mniPrimeiro.Enabled := btnPrimeiro.Enabled;
  btnAnterior.Enabled := btnPrimeiro.Enabled;
  mniAnterior.Enabled := btnPrimeiro.Enabled;
  btnProximo.Enabled := (TipoOperacao = tpoConsulta) and (not dtsGeral.EOF);
  mniProximo.Enabled := btnProximo.Enabled;
  btnUltimo.Enabled := btnProximo.Enabled;
  mniUltimo.Enabled := btnProximo.Enabled;

  btnLocalizar.Enabled := (TipoOperacao = tpoConsulta) and
                          (pagGeral.activepage = tabmanutencao);
  mniLocalizar.Enabled := btnLocalizar.Enabled;

  // Parte dos botoes de manutencao
  btnFechar.Enabled := (TipoOperacao = tpoconsulta);
  mniFechar.Enabled := btnFechar.Enabled;

  btnNovo.Enabled := (TipoOperacao = tpoconsulta) and (modulo.bapostasliberadas);
  mniNovo.Enabled := btnNovo.Enabled;

  btnAlterar.Enabled := (TipoOperacao = tpoconsulta) and
                        dtsGeral.Active and (dtsGeral.RecordCount <> 0);
  mniAlterar.Enabled := btnAlterar.Enabled;

  btnSalvar.Enabled := (TipoOperacao <> tpoconsulta) and
                       (pagGeral.activepage = tabmanutencao);
  mniSalvar.Enabled := btnSalvar.Enabled;
  btnCancelar.Enabled := btnSalvar.Enabled;
  mniCancelar.Enabled := btnSalvar.Enabled;

  btnExcluir.Enabled := (TipoOperacao = tpoconsulta) and 
                        (dtsGeral.Active) and (dtsGeral.RecordCount <> 0);
  mniExcluir.Enabled := btnExcluir.Enabled;

  if paggeral.activepage = tabmanutencao then
  begin
    pagGeral.Enabled := (TipoOperacao <> tpoConsulta);
    mniDetalhes.ShortCut := 0;
    mniLocalizar.ShortCut := 122;
  end
  else if paggeral.activepage = tabprocura then
  begin
    pagGeral.Enabled := true;
    mniDetalhes.ShortCut := 122;
    mniLocalizar.ShortCut := 0;
  end;

  btnFechar.Visible := btnFechar.Enabled;
  btnprimeiro.Visible := (TipoOperacao = tpoconsulta) and dtsGeral.Active and
                         (dtsGeral.RecordCount <> 0);
  ToolButton1.Visible := btnprimeiro.Visible;
  btnanterior.Visible := btnprimeiro.Visible;
  btnproximo.Visible := btnprimeiro.Visible;
  btnultimo.Visible := btnprimeiro.Visible;
  btnLocalizar.Visible := btnLocalizar.Enabled;
  btnDetalhes.Visible := btnDetalhes.Enabled;
  ToolButton2.Visible := btnNovo.Enabled;
  btnNovo.Visible := btnNovo.Enabled;
  btnAlterar.Visible := btnAlterar.Enabled;
  btnExcluir.Visible := btnExcluir.Enabled;
  btnSalvar.Visible := btnSalvar.Enabled;
  btnCancelar.Visible := btnCancelar.Enabled;

  mniprimeiro.visible := btnprimeiro.visible;
  mnianterior.Visible := btnanterior.visible;
  mniproximo.visible := btnproximo.visible;
  mniultimo.visible := btnultimo.visible;
  mnilocalizar.visible := btnlocalizar.visible;
  mnidetalhes.visible := btndetalhes.visible;
  N2.Visible := ToolButton2.Visible;
  mniNovo.Visible := btnNovo.Visible;
  mnialterar.visible := btnalterar.visible;
  mniexcluir.visible := btnexcluir.visible;
  mnisalvar.visible := btnsalvar.Visible;
  mnicancelar.Visible := btnCancelar.Visible;
  mnifechar.Visible := btnFechar.Visible;
  N3.Visible := ToolButton1.Visible;

  Application.ProcessMessages;
end;

procedure Tfrmpessoa.pesquisar(trazertudo:boolean = TRUE);
var
  sSufixo: string;
  iIdAnt: Longint;
  sProcura:string;
begin
  {Caso o campo digitado contiver % ou _, utilizaremos o LIKE para procura
    imprecisa. Esta consistencia deve ser feita para agilizar a procura. }

  if trazertudo or (Trim(edtProcurar.Text) <> '') then
  begin
    tempoini := time;

    sProcura := '%'+edtProcurar.Text+'%';

    sSufixo := Modulo.SeSufixo(sProcura);
    sProcura := Modulo.LimpaAcentos(sProcura);

    with dtsGeral do
    begin
      DisableControls;

      if Active then
      begin
        iIdAnt := FieldByName('CODIGO').AsInteger;
      end
      else
        iIdAnt := 0;

      Close;
      Unprepare;
      DataBaseName := modulo.sDataBase;

      with Sql do
      begin
        Clear;

        Add('SELECT');
        Add('CODIGO,');
        Add('NOME,');
        Add('PAGO,');
        Add('PONTORESULTADO,');
        Add('PONTOCLASSIFICACAO,');
        Add('PONTOPLACAR,');
        Add('TOTALPONTOS,');
        Add('SENHA');
        Add('FROM '+C_TABELA);

        if not trazertudo then
        begin
          Add('WHERE NOME '+sSufixo+' :P_NOME');
          ParamByName('P_NOME').AsString := sProcura;
        end;

        Add('ORDER BY NOME');
      end;

      try
        Open;

        qtdecadastrados;
        tempofim := time;
      except
        dtsGeral.Sql.SaveToFile('c:\temp\erro.txt');
        showmessage('erro');
      end;
      EnableControls;

      Locate('CODIGO',iIdant,[loCaseInsensitive]);
    end;
  end;
end;

procedure Tfrmpessoa.dsGeralDataChange(Sender: TObject;
  Field: TField);
begin
  // Desatribuir referencia da procedure ao objeto dsGeral
  dsGeral.OnDataChange := nil;

  if dtsGeral.Active then // Se tabela aberta
  begin
    if TipoOperacao = tpoConsulta then
    begin
      lblcodigo.caption := dtsGeral.FieldByName('CODIGO').AsString;
      edtNome.text := dtsGeral.FieldByName('NOME').AsString;
      ckbpago.Checked := dtsGeral.FieldByName('PAGO').AsBoolean;
      edtsenha.text := dtsGeral.FieldByName('SENHA').AsString;

      StatusBar1.Panels[0].Text := Format('%d linha(s)',[dtsGeral.RecordCount])+' '+
            modulo.RetornaTempoSQL(tempoini,tempofim);
    end;
  end
  else
    StatusBar1.Panels[0].Text :=  'Nenhuma linha selecionada.';

  EnabledButtons;

  // Atribui novamente a referencia
  dsGeral.OnDataChange := dsGeralDataChange;

  // Isto é bom para que o Windows não dê a impressão que está travado
  Application.processMessages;
end;

procedure Tfrmpessoa.mniFecharClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmpessoa.mniPrimeiroClick(Sender: TObject);
begin
  dtsGeral.First;
  EnabledButtons;
end;

procedure Tfrmpessoa.mniAnteriorClick(Sender: TObject);
begin
  dtsGeral.Prior;
  EnabledButtons;
end;

procedure Tfrmpessoa.mniProximoClick(Sender: TObject);
begin
  dtsGeral.Next;
  EnabledButtons;
end;

procedure Tfrmpessoa.mniUltimoClick(Sender: TObject);
begin
  dtsGeral.Last;
  EnabledButtons;
end;

procedure Tfrmpessoa.mniLocalizarClick(Sender: TObject);
begin
  pagGeral.ActivePage := tabprocura;
  btnDetalhes.Tag := 0; 
  EnabledButtons;
  FocalizarPaginaProcura;
end;

procedure Tfrmpessoa.mniDetalhesClick(Sender: TObject);
begin
  if btnDetalhes.Enabled then
  begin
    pagGeral.ActivePage := tabmanutencao;
    dsGeralDataChange(Self,nil);

    btnDetalhes.Tag := 1; // apertou detalhes

    if (not dtsGeral.Active) or (dtsGeral.RecordCount = 0) then LimparCampos;

    EnabledButtons;
  end;
end;

procedure Tfrmpessoa.mniNovoClick(Sender: TObject);
begin
  btnNovo.Enabled := false;
  pagGeral.Hint := UpperCase(paggeral.ActivePage.Name);
  TipoOperacao := tpoInclusao;
  dsGeral.OnDataChange := nil;
  pagGeral.ActivePage := tabmanutencao;
  LimparCampos;
  EnabledButtons;
  Focalizar;
end;

procedure Tfrmpessoa.mniAlterarClick(Sender: TObject);
begin
  btnAlterar.Enabled := false;

  pagGeral.Hint := UpperCase(paggeral.ActivePage.Name);

  if (not dtsGeral.Active) or (dtsGeral.RecordCount = 0) then
  begin
    MessageBox(Handle,PChar('Nenhuma linha selecionada.'),
               'Atenção',mb_Ok+mb_IconInformation);
    btnAlterar.Enabled := true;
  end
  else
  begin
    dsGeral.OnDataChange := nil;
    pagGeral.ActivePage := tabmanutencao;
    dsGeralDataChange(Self,nil);
    TipoOperacao := tpoAlteracao;
    EnabledButtons;
    Focalizar;
  end;
end;

procedure Tfrmpessoa.mniExcluirClick(Sender: TObject);

  function PodeExcluir: boolean;
  begin
    Result := true;
  end;

begin
  btnExcluir.Enabled := false;

  if (not dtsGeral.Active) or (dtsGeral.recordcount = 0) then
    MessageBox(Handle,PChar('Nenhuma linha selecionada.'),
               'Atenção',mb_Ok+mb_IconInformation)
  else
  begin
    if PodeExcluir then
    begin
      if MessageBox(Handle,PChar('Excluir linha?'),'Atenção',
                    mb_YesNo+mb_IconQuestion) =idYes then
      begin
        Deletar;

        Pesquisar;

        if dtsGeral.RecordCount = 0 then
        begin
          pagGeral.ActivePage := tabprocura;
          btndetalhes.tag := 0;
          EnabledButtons;
        end;
      end;
    end
    else
    begin
      Application.MessageBox('Esta linha tem ligação com outras tabelas.','Atenção',
                             mb_Ok+mb_IconInformation);
    end;
  end;

  btnExcluir.Enabled := true;
end;

procedure Tfrmpessoa.mniSalvarClick(Sender: TObject);
  function ConsistirGravacao:boolean;
  begin
    Result := true;

    if Trim(edtNome.text) = '' then
    begin
      sMensagem := 'Digite um nome.';
      Result := false;
    end
    else if Trim(edtsenha.text) = '' then
    begin
      smensagem := 'Digite a senha';
      Result := false;
    end;
  end;

begin
  btnSalvar.Enabled := false;
  mniSalvar.Enabled := true;

  try
    sMensagem := '';
    Focalizar;
    if not ConsistirGravacao then
    begin
      MessageBox(Handle,PChar(sMensagem),'Erro',mb_Ok+mb_IconError);

      mniSalvar.Enabled := true;
      btnSalvar.Enabled := true;

      Focalizar;
    end
    else
    begin
      edtNome.Text := Modulo.LimpaAcentos(Trim(edtNome.Text));

      if TipoOperacao = tpoInclusao then // Mode de alteracao
      begin
        if Messagebox(Handle,'Confirma gravação?','Atenção',
                        mb_YesNo+mb_IconQuestion) = idyes then
        begin
          if Incluir then
          begin
            qtdecadastrados;

            limparcampos;

            TipoOperacao := tpoConsulta;

            // referencia da procedure ao objeto dsGeral
            dsGeral.OnDataChange := dsGeralDataChange;

            MessageBox(Handle,PChar('Linha incluída.'),'Atenção',
                       mb_Ok+Mb_IconInformation);

            pesquisar;

            // Somente para voltar para a página do Notebook que anteriormente foi
            // originado o Click
            if (pagGeral.Hint = 'PROCURA') or (dtsGeral.RecordCount = 0) then
            begin
              pagGeral.ActivePage := tabprocura;
              btndetalhes.tag := 0;
            end;

            Enabledbuttons;

            if pagGeral.ActivePage = tabprocura then FocalizarPaginaProcura;

            // referencia da procedure ao objeto dsGeral
            dsGeral.OnDataChange := dsGeralDataChange;
          end;
        end
        else
        begin
          Focalizar;
        end;
      end
      else
      begin // Modo de inclusao
        if MessageBox(Handle,'Confirma alteração?','Atenção',
                      mb_YesNo+mb_IconQuestion)=idYes then
        begin
          if Alterar then
          begin
            TipoOperacao := tpoConsulta;

            pesquisar;

           // Somente para voltar para a página do Notebook que anteriormente foi
            // originado o Click
            if (pagGeral.Hint = 'PROCURA') or (dtsGeral.RecordCount = 0) then
            begin
              pagGeral.ActivePage := tabprocura;
              btndetalhes.tag := 0;
            end;

            Enabledbuttons;

           // referencia da procedure ao objeto dsGeral
            dsGeral.OnDataChange := dsGeralDataChange;
          end
          else
          begin
            Focalizar;
          end;
        end
        else
          Focalizar;
      end;
    end;
  except
    btnSalvar.Enabled := true;
    mniSalvar.Enabled := true;
  end;

  dsGeral.OnDataChange := dsGeralDataChange;
end;

procedure Tfrmpessoa.mniCancelarClick(Sender: TObject);
var
  sMsg: string;
begin
  btnCancelar.Enabled := false;

  if TipoOperacao = tpoInclusao then
    sMsg := 'Sair do processo de inclusão?'
  else
    sMsg := 'Sair do processo de alteração?';

  if MessageBox(Handle,PChar(sMsg),'Atenção',mb_YesNO+mb_IconQuestion) = idYes then
  begin
    TipoOperacao := tpoConsulta;

    dsGeralDataChange(Self,nil);

    pagGeral.ActivePage := tabprocura;
    btndetalhes.tag := 0;

{
    if pagGeral.Hint = 'PROCURA' then
    begin
      pagGeral.ActivePage := tabprocura;
      btndetalhes.tag := 0;
    end; }

    EnabledButtons;

    if pagGeral.ActivePage = tabprocura then FocalizarPaginaProcura;

    dsGeral.OnDataChange := dsGeralDataChange;
  end
  else
  begin
    btnCancelar.Enabled := true;
  end;
end;

procedure Tfrmpessoa.dcGridPrincipalKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then btnDetalhes.Click;
end;

procedure Tfrmpessoa.btnProcurarClick(Sender: TObject);
begin
  btnProcurar.Enabled := false;
  pesquisar(false);
  btnProcurar.Enabled := true;
end;

procedure Tfrmpessoa.edtProcurarKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btnProcurar.Click;
end;

procedure Tfrmpessoa.cobIndiceChange(Sender: TObject);
begin
  edtProcurar.Text := '';
end;

procedure Tfrmpessoa.cobIndiceClick(Sender: TObject);
begin
  edtProcurar.SetFocus;
end;

procedure Tfrmpessoa.cobIndiceExit(Sender: TObject);
begin
  cobIndice.OnClick := cobIndiceClick;
end;

procedure Tfrmpessoa.cobIndiceKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  (Sender as TComboBox).OnClick := nil;
end;

procedure Tfrmpessoa.cobIndiceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    Key := #0;
    SelectNext((Sender as TWinControl),true,true);
  end;
end;

procedure Tfrmpessoa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dtsGeral.Close;
end;

procedure Tfrmpessoa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := btnFechar.Enabled;
end;

procedure Tfrmpessoa.FormResize(Sender: TObject);
begin
  StatusBar1.Panels[0].Width := Self.Width-259;
  Application.ProcessMessages;
end;

procedure Tfrmpessoa.FormShow(Sender: TObject);
begin
  // Atribuir variável para fazer consistencia em toda a Unit

  TbBarraBotoes.Images := Modulo.imgbotoes;
  mnutblGeral.Images := Modulo.imgbotoes;
  tabmanutencao.tabvisible := false;
  tabprocura.tabvisible := false;

  Self.Caption := 'Apostadores';
  Self.Height := 400;
  Self.Width := 760;
  Self.Constraints.MinHeight := Self.Height;
  Self.Constraints.MinWidth := Self.Width;

  cobindice.items.clear;
  cobindice.items.add('Nome');
  cobIndice.ItemIndex := 0;

  pesquisar;

  with dcGridPrincipal do
  begin
    Columns.Clear;
    Columns.Add;
    Columns[0].FieldName := 'CODIGO';
    Columns[0].Title.Caption := 'Código';
    Columns[0].Width := 60;
    Columns.Add;
    Columns[1].FieldName := 'NOME';
    Columns[1].Title.Caption := 'Nome';
    Columns[1].Width := 220;
    Columns.Add;
    Columns[2].FieldName := 'PAGO';
    Columns[2].Title.Caption := 'Pago';
    Columns.Add;
    Columns[3].FieldName := 'SENHA';
    Columns[3].Title.Caption := 'Senha';
    Columns[3].Font.Name := 'Courier New';
    Columns[3].Width := 60;
    Columns.Add;
    Columns[4].FieldName := 'PONTORESULTADO';
    Columns[4].Title.Caption := 'Pontos de result.';
    Columns.Add;
    Columns[5].FieldName := 'PONTOPLACAR';
    Columns[5].Title.Caption := 'Pontos de placar';
    Columns.Add;
    Columns[6].FieldName := 'PONTOCLASSIFICACAO';
    Columns[6].Title.Caption := 'Pontos de classif.';
    Columns.Add;
    Columns[7].FieldName := 'TOTALPONTOS';
    Columns[7].Title.Caption := 'Total Pontos';
    Columns[7].Font.Style := [fsBold];
  end;

  TipoOperacao := tpoConsulta;

  pagGeral.ActivePage := tabprocura;

  EnabledButtons;

  LimparCampos;

  FocalizarPaginaProcura;
end;

procedure Tfrmpessoa.btngerarsenhaClick(Sender: TObject);
begin
  edtsenha.text := gerarsenha;
end;

procedure Tfrmpessoa.mnipreencherClick(Sender: TObject);
begin
  Self.Enabled := false;
  btnpreencher.Enabled := false;
  frmresultado := TfrmResultado.Create(Self);
  frmresultado.iapostador := dtsGeral.FieldByName('CODIGO').AsInteger;
  frmresultado.Caption := 'Aposta de '+dtsGeral.FieldByName('NOME').AsString;
  frmresultado.showmodal;
  FreeAndNil(frmresultado);
  btnpreencher.Enabled := true;
  Self.Enabled := true;

  if edtprocurar.canfocus then edtprocurar.setfocus;
  if dcGridPrincipal.CanFocus then dcGridPrincipal.SetFocus;
end;

procedure Tfrmpessoa.mniImpressaoClick(Sender: TObject);
begin
  btnimpressao.Enabled := false;
  frmimpressao := Tfrmimpressao.create(Self);
  frmimpressao.iapostador := dtsGeral.FieldByname('CODIGO').AsInteger;
  frmimpressao.montasql(dtsGeral.Fieldbyname('NOME').AsString);
  frmimpressao.QRGeral.PreviewModal;
  FreeAndNil(frmimpressao);
  btnimpressao.Enabled := true;
end;

end.
