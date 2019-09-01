unit Toviasur.ControllerBase;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Winapi.Windows;

type

  TTVSControllerBase = class
  end;

  TClasseController = class of TTVSControllerBase;

  TRota = class(TObject)
  private
    FURI: String;
    FController: TClasseController;
    FNomeMetodo: String;
  public
    constructor Create(AController: TClasseController; AURI, ANomeMetodo: String);

    property URI: String read FURI;
    property Controller: TClasseController read FController;
    property NomeMetodo: String read FNomeMetodo;
  end;

implementation

constructor TRota.Create(AController: TClasseController; AURI, ANomeMetodo: String);
begin
  FController := AController;
  FURI := AURI;
  FNomeMetodo := ANomeMetodo;
end;

end.
