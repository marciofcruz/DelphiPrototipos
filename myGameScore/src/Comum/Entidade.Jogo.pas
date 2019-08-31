unit Entidade.Jogo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Entidade.Base;

type
  TJogo = class(TEntidadeBase)
  private
    FPonto: Byte;
    FData: TDateTime;
    procedure setData(const Value: TDateTime);
    procedure setPonto(const Value: Byte);
  public
    property Data: TDateTime read FData write setData;
    property Ponto: Byte read FPonto write setPonto;
    constructor Create(const AToken: String; const AData: TDateTime; const APonto: Byte); reintroduce;
  end;

  TContainerJogo= class(TContainerBase<TJogo>);

implementation

constructor TJogo.Create(const AToken: String; const AData: TDateTime; const APonto: Byte);
begin
  inherited Create(AToken);

  Data := AData;
  Ponto := APonto;
end;

procedure TJogo.setData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TJogo.setPonto(const Value: Byte);
begin
  FPonto := Value;
end;

end.
