unit Entidade.Base;

interface

uses
  System.SysUtils, System.Classes,
  System.Generics.Collections;

type
  TEntidadeBase = class
  private
    FPK: Integer;
    FRevisao: Integer;
    FAlterado: Integer;
    FExcluido: Integer;
  public
    constructor Create(const APK, ARevisao, AExcluido, AAlterado: Integer);

    property PK: Integer read FPK write FPK;
    property Revisao: Integer read FRevisao write FRevisao;
    property Alterado: Integer read FAlterado write FAlterado;
    property Excluido: Integer read FExcluido write FExcluido;
  end;

type
  TContainerBase<T> = class
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

constructor TEntidadeBase.Create(const APK, ARevisao, AExcluido, AAlterado: Integer);
begin
  FPK := APK;
  FRevisao := ARevisao;
  FAlterado := AAlterado;
  FExcluido := AExcluido;
end;

end.
