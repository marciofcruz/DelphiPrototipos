unit Entidade.Equipamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Entidade.Base, Entidade.Modelo;

type
  TEquipamento = class(TEntidadeBase)
  private
    FDescricao: String;
    FModelo: TModelo;
    FSerie: String;
    FCategoria: String;
    FDataSaida: TDateTime;
    FDataEntrada: TDateTime;
    procedure setDescricao(const Value: String);
    procedure setModelo(const Value: TModelo);
    procedure setDataEntrada(const Value: TDateTime);
    procedure setDataSaida(const Value: TDateTime);
  public
    constructor Create(const APK, ARevisao, AExcluido, AAlterado: Integer;
      const ADescricao: String; const AModelo: TModelo;
      const ADataEntrada, ADataSaida: TDateTime;
      const ASerie, ACategoria: String); reintroduce;
    destructor Destroy; override;

    property Descricao: String read FDescricao write setDescricao;
    property Modelo: TModelo read FModelo write setModelo;
    property DataEntrada: TDateTime read FDataEntrada write setDataEntrada;
    property DataSaida: TDateTime read FDataSaida write setDataSaida;
    property Serie: String read FSerie write FSerie;
    property Categoria: String read FCategoria write FCategoria;
  end;

  TContainerEquipamento = class(TContainerBase<TEquipamento>);

implementation

{ TEquipamento }

constructor TEquipamento.Create(const APK, ARevisao, AExcluido,
  AAlterado: Integer; const ADescricao: String; const AModelo: TModelo;
  const ADataEntrada, ADataSaida: TDateTime; const ASerie, ACategoria: String);
begin
  inherited Create(APK, ARevisao, AExcluido, AAlterado);

  Descricao := ADescricao;
  FModelo := AModelo;
  DataEntrada := ADataEntrada;
  DataSaida := ADataSaida;
  Serie := ASerie;
  Categoria := ACategoria;
end;

destructor TEquipamento.Destroy;
begin
  if FModelo <> nil then
  begin
    FreeAndNil(FModelo);
  end;

  inherited;
end;

procedure TEquipamento.setDataEntrada(const Value: TDateTime);
begin
  if Value <= 0 then
  begin
    raise Exception.Create('Data de Entrada deve ser informada!');
  end;

  FDataEntrada := Value;
end;

procedure TEquipamento.setDataSaida(const Value: TDateTime);
begin
  if (Value > 0) and (Value < FDataEntrada) then
  begin
    raise Exception.Create
      ('Data de Saída não pode ser menor que a data de entrada!');
  end;

  FDataSaida := Value;
end;

procedure TEquipamento.setDescricao(const Value: String);
begin
  if Trim(Value) = '' then
  begin
    raise Exception.Create('Descrição do Equipamento deve ser informado!');
  end;

  FDescricao := Trim(Value);
end;

procedure TEquipamento.setModelo(const Value: TModelo);
begin
  if Value = nil then
  begin
    raise Exception.Create('Modelo deve ser associado ao equipamento!');
  end;

  FModelo := Value;
end;

end.
