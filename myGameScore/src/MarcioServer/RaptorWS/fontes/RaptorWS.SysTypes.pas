unit RaptorWS.SysTypes;

interface
type
  TRetornoJSON = class
     FStatus: Integer;
     FMensagem: String;
  public
     property STATUS: Integer read FStatus write FStatus;
     property MENSAGEM: String read FMensagem write FMensagem;
  end;

implementation

end.
