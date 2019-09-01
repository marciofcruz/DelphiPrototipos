Na área de desenvolvimento de software, um entendimento comum é que qualquer recurso computacional é limitado, inclusive a memória de acesso aleatório (RAM).

Sendo assim, o programador não deve direcionar a preocupação somente com a  operação do sistema estar acertiva para o usuário, deve-se preocupar também com os bastidores do funcionamento.

A regra geral pelo menos até o surgimento dos sistemas de coletores de lixos (garbages collectors) era que quem criava ou alocava um recurso, era responsável por destruir ou desalocar.
Porém, mesmo os programadores mais experientes acabam por esquecer de fazer isso, ou, acidentalmente, com chamadas em pilha ou recursivas, acabam por deixar vazamentos de memória.

Foi aí que algumas linguagens (as que funcionam sobre máquinas virtuais) usam um genial recurso chamado Garbage Collector.
Basicamente falando, foi retirado a responsabilidade do programador de destruir ou desalocar seus recursos, na verdade, sequer foi deixado nos manuais ao acesso do Free, no máximo, atribuir um "nil"  para forçar o GC a eliminar o recurso...

Mas, e as outras linguagens que não tem Garbage Collector, como ficam? Bem, ficam do jeito que está... Toda linguagem tem suas vantagens e desvantagens, senão não seria necessário ter 
milhares de linguagens hoje em dia...

Porém, se a gente puder utilizar recursos para emular este funcionamento, ótimo.. É o caso desta classe...

Ela utiliza o artifício que qualquer classe que usa a interface TInterfacedObject é eliminada pelo sistema automaticamente no fim do seu uso...

Para que o programador não tenha que que associar esta intarface a todo seu conjunto de fontes, Marco Cantu em seu livro Object Pascal criou uma classe chamada TSmartPointer...

E, eu me baseei nela para criar a TPeudoGC... Na verdade, é o "aportuguesamento" desta brilhante classe... E, meu objetivo aqui é passar este conceito a comunidade. 

Artigo no linkedin: https://www.linkedin.com/pulse/uma-pseudo-garbage-collector-para-o-delphi-marcio-cruz/