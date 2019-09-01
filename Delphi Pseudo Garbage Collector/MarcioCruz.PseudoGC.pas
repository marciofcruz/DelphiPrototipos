// *************************************************************************** }
//
// Copyright (c) 2019 Marcio Fernandes Cruz - programador@marciofcruz.com
// Linkedin: https://www.linkedin.com/in/marciofcruz/
// Classe TPseudoGC
// Baseado no livro do Marco Cantu, Object Pascal, classe TSmartPointer
//
//
//  Deixei o nome da classe como pseudo coletor pois, é o que é...
// Delphi para o bem ou para o mal não possui um Garbage Colletor, e, a classe,
// procura emular isso, facilitando a vida do usuário.
// Facilita a vida pois vai reduzir o código de try..finally e, vai inicializar
// a instancia uma única vez, reduzindo a quantidade de código...
//
// Marcio - 04/03/2019
// ***************************************************************************


unit MarcioCruz.PseudoGC;

interface

uses
  Generics.Defaults;

type
  TPseudoGC<T:class, constructor> = record
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

    class operator Implicit(AValue: T): TPseudoGC<T>;

    property Instancia:T read ObterInstancia;
  end;

implementation

constructor TPseudoGC<T>.Create(AValue: T);
begin
  FInstancia := AValue;
  FProcDestruirInstancia := TDestruirInstancia.Create(FInstancia);
end;

procedure TPseudoGC<T>.Create;
begin
  TPseudoGC<T>.Create(T.Create);
end;

function TPseudoGC<T>.ObterInstancia: T;
begin
  if not Assigned(FProcDestruirInstancia) then
  begin
    Self := TPseudoGC<T>.Create(T.Create);
  end;

  Result := FInstancia;
end;

class operator TPseudoGC<T>.Implicit(AValue: T): TPseudoGC<T>;
begin
  Result := TPseudoGC<T>.Create(AValue);
end;

constructor TPseudoGC<T>.TDestruirInstancia.Create(aObjetoASerDestruido: TObject);
begin
  FObjetoASerDestruido := aObjetoASerDestruido;
end;

destructor TPseudoGC<T>.TDestruirInstancia.Destroy;
begin
  FObjetoASerDestruido.Free;

  inherited;
end;

end.
