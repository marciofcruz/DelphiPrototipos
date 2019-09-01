unit Entidade.Modelo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Entidade.Base, Entidade.Fabricante;

type
  TModelo = class(TEntidadeBase)
  private
    FDescricao: String;
    FFabricante: TFabricante;

    procedure setDescricao(const Value: String);
    procedure setFabricante(Value: TFabricante);
  public
    property Descricao: String read FDescricao write setDescricao;
    property Fabricante: TFabricante read FFabricante write setFabricante;
    constructor Create(const APK, ARevisao, AExcluido, AAlterado: Integer; const ADescricao: String; const AFabricante: TFabricante); reintroduce;
    destructor Destroy; override;
  end;

  TContainerModelo = class(TContainerBase<TModelo>);

implementation

{ TModelo }

constructor TModelo.Create(const APK, ARevisao, AExcluido, AAlterado: Integer;
  const ADescricao: String; const AFabricante: TFabricante);
begin
  inherited Create(APK, ARevisao, AExcluido, AAlterado);

  Descricao := ADescricao;

  FFabricante := AFabricante;
end;

destructor TModelo.Destroy;
begin
  if FFabricante<>nil then
  begin
    FreeAndNil(FFabricante);
  end;

  inherited;
end;

procedure TModelo.setDescricao(const Value: String);
begin
  if Trim(Value)='' then
  begin
    raise Exception.Create('Nome do Modelo deve ser informado!');
  end;

  FDescricao := Trim(Value);
end;

procedure TModelo.setFabricante(Value: TFabricante);
begin
  if Value=nil then
  begin
    raise Exception.Create('Fabricante deve ser associado ao modelo!');
  end;

  FFabricante := Value;
end;

end.
