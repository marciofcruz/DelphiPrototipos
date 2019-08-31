program PCVGoogleAPI;

uses
  Forms,
  marciofcruz.GeoCodificacao in 'marciofcruz.GeoCodificacao.pas',
  marciofcruz.GeoMatrizDistancia in 'marciofcruz.GeoMatrizDistancia.pas',
  marciofcruz.GeoUteis  in 'marciofcruz.GeoUteis.pas',
  marciofcruz.RestClient in 'marciofcruz.RestClient.pas',
  uMain in 'uMain.pas' {Form1};

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
