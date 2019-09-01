program copa;

uses
  Forms,
  Dialogs,
  SysUtils,
  Windows,
  main in 'Main.pas' {frmmaincup},
  dtMod in '..\fntcomum\Dtmod.pas' {Modulo: TDataModule},
  result in 'result.pas' {frmresultado},
  sorteio in 'sorteio.pas' {frmsorteio},
  impress in 'impress.pas' {frmimpressao},
  UnPrev in '..\FNTCOMUM\Unprev.pas' {frmPreview},
  pessoa in 'pessoa.pas' {frmpessoa},
  login in 'login.pas' {frmlogin},
  regra in 'regra.pas' {frmregra},
  impranki in 'impranki.pas' {frmranking},
  trocasen in 'trocasen.pas' {frmtrocarsenha},
  verapost in 'verapost.pas' {frmveraposta},
  fpeditfloat in '..\..\terceiro\comum\fpeditfloat.pas';

{$R *.res}

begin
   Application.Title := '';
   Application.HelpFile := '';
   if FindWindow('Tfrmmaincup','frmmaincup') = 0 then
   begin
    Application.Initialize;
    Application.Title := 'Bolão da Copa 2006';
    Application.CreateForm(TModulo, Modulo);
  Modulo.sdatabase := ExtractFilePath(Application.ExeName)+'arquivos';

    if Modulo.verificar then
    begin
      Application.CreateForm(Tfrmmaincup, frmmaincup);

      Application.CreateForm(TfrmLogin,frmLogin);
      frmlogin.showmodal;

      if (frmlogin.btnfechar.Tag <> 1) and (frmlogin.btnacessar.Tag = 1) then
      begin
        frmmaincup.iapostador := frmlogin.iapostador;
        FreeAndNil(frmLogin);
        Application.Run;
      end
      else
      begin
        FreeAndNil(frmlogin);
        Application.Terminate;
      end;
    end;
  end;
end.
