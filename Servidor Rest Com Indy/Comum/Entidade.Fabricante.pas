unit Entidade.Fabricante;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Entidade.Base;

type
  TFabricante = class(TEntidadeBase)
  private
    FDescricao: String;

    procedure setDescricao(const Value: String);
  public
    property Descricao: String read FDescricao write setDescricao;
    constructor Create(const APK, ARevisao, AExcluido, AAlterado: Integer; const ADescricao: String); reintroduce;
  end;

  TContainerFabricante = class(TContainerBase<TFabricante>);

implementation

constructor TFabricante.Create(const APK, ARevisao, AExcluido, AAlterado: Integer; const ADescricao: String);
begin
  inherited Create(APK, ARevisao, AExcluido, AAlterado);

  Descricao := ADescricao;
end;

procedure TFabricante.setDescricao(const Value: String);
begin
  if Trim(Value)='' then
  begin
    raise Exception.Create('Nome do Fabricante deve ser informado!');
  end;

  FDescricao := Trim(Value);
end;

end.
