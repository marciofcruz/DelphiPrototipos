unit Toviasur.ControllerAutenticacao;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Winapi.Windows,
  Toviasur.ControllerBase, Toviasur.Comuns;

type
  [TVSController]
  TControllerAutenticacao = class(TTVSControllerBase)
  private
  public
    [TVSPathAttribute('/gettokenusuario', [verboPOST])]
    function ValidarToken(const aToken: String; var aMensagem: String):Boolean;
  end;

implementation

uses
  Toviasur.Token,
  Toviasur.Estrutura.Token;

function TControllerAutenticacao.ValidarToken(const aToken: String;
  var aMensagem: String): Boolean;
var
  Token: TTVSToken;
  Informacao: TInfoRequisicaoToken;
begin
  Result := False;
  Token := TTVSToken.Create;
  try
    Informacao := Token.getInformacaoRequisicao(aToken);

    if Informacao.AssinaturaValida then
    begin
      if Informacao.Expiracao<=now then
      begin
        aMensagem := 'Necessário gerar outro Token. O atual venceu em: '+
                     FormatDateTime('dd/mm/yyyy hh:nn', Informacao.Expiracao);
      end
      else
      begin
        Result := True;
      end;
    end
    else
    begin
      aMensagem := 'Token não possui assinatura válida!';
    end;
  finally
    FreeAndNil(Token);
  end;
end;

end.
