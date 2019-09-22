Este programa pega um arquivo CSV com uma série história de preços de combustíveis do Brasil.

E, usando rotinas do próprio Delphi apresenta o resultado dos seguintes itens:

Coloquei as seguintes informações:
* Mês x Ano x Cidade x Produto
* Cidade x Produto
* Cidade
* Região x Produto
* UF x Produto
* Cinco maiores diferenças por Produto

Isso visando atender os requisitos:

* Distribuição mensal de valores médios de combustíveis por cidade.
* Média do preço de combustíveis por região
* Média do preço de combustíveis por UF
* Por tipo de combustível, as 5 cidades que apresentaram a maior diferença de preço de revenda


Desenvolvi o protótipo usando o Delphi Tokyo, sem frameworks, apenas a linguagem "pura".

O executável é em 64 bits e não possui dependências, ou seja, basta baixar e executar que funciona...

Os fontes estão neste diretório e na pasta src, sendo:

uPrincipal.pas/dfm - View das chamada
src/MFC.Classes.Amostragem.pas - Classe onde principalmente fiz o cálculo da variância populacional
src/MFC.CSVtoDataSet.pas - Importação do CSV original dentro de uma estrutura de dados para análise
src/MFC.DM.Analise.pas - classe onde foram feita as análise pré estabelecidas.
