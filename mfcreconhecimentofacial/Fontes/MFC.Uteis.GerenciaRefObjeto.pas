// Desenvolvido por Marcio Fernandes Cruz - Março / 2015
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/


unit MFC.Uteis.GerenciaRefObjeto;

interface

uses
  Generics.Defaults;

type
  TGerenciaRefObjeto<T:class, constructor> = record
  strict private
    FInstancia: T;
    FProcDestruirInstancia: IInterface;

    function ObterInstancia:T;
  private
    type
      TDestruirInstancia = class(TInterfacedObject)
      private
        FObjetoASerDestruido: TObject;
      public
        constructor Create(aObjetoASerDestruido: TObject);
        destructor Destroy; override;
      end;
  public
    constructor Create(AValue: T); overload;
    procedure Create; overload;

    class operator Implicit(AValue: T): TGerenciaRefObjeto<T>;

    property Instancia:T read ObterInstancia;
  end;

implementation

constructor TGerenciaRefObjeto<T>.Create(AValue: T);
begin
  FInstancia := AValue;
  FProcDestruirInstancia := TDestruirInstancia.Create(FInstancia);
end;

procedure TGerenciaRefObjeto<T>.Create;
begin
  TGerenciaRefObjeto<T>.Create(T.Create);
end;

function TGerenciaRefObjeto<T>.ObterInstancia: T;
begin
  if not Assigned(FProcDestruirInstancia) then
  begin
    Self := TGerenciaRefObjeto<T>.Create(T.Create);
  end;

  Result := FInstancia;
end;

class operator TGerenciaRefObjeto<T>.Implicit(AValue: T): TGerenciaRefObjeto<T>;
begin
  Result := TGerenciaRefObjeto<T>.Create(AValue);
end;

constructor TGerenciaRefObjeto<T>.TDestruirInstancia.Create(aObjetoASerDestruido: TObject);
begin
  FObjetoASerDestruido := aObjetoASerDestruido;
end;

destructor TGerenciaRefObjeto<T>.TDestruirInstancia.Destroy;
begin
  FObjetoASerDestruido.Free;

  inherited;
end;

end.
