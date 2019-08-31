unit Entidade.Base;

interface

uses
  System.SysUtils, System.Classes,
  System.Generics.Collections;

type
  TEntidadeBase = class
  private
    FToken: String;
  public
    constructor Create(const AToken: String); virtual;
  end;

type
  TContainerBase<T> = class // para eventualmente listar todos os jogos em uma proxima versao
  private
    FLinhas: TArray<T>;
  public
    procedure AddLinha(Entidade: T);
    destructor Destroy; override;

    property Linhas:TArray<T> read FLinhas write FLinhas;
  end;

implementation

{ TEntidadeBase<T> }

procedure TContainerBase<T>.AddLinha(Entidade: T);
begin
  SetLength(FLinhas, Length(FLinhas)+1);
  FLinhas[Length(FLinhas)-1] := Entidade;
end;

destructor TContainerBase<T>.Destroy;
var
  Cont: Integer;
begin
  for Cont := 0 to Length(FLinhas)-1 do
  begin
    FreeAndNil(FLinhas[Cont]);
  end;

  SetLength(FLinhas, 0);

  inherited;
end;

{ TEntidadeBase }

constructor TEntidadeBase.Create(const AToken: String);
begin
  FToken := AToken;
end;

end.
