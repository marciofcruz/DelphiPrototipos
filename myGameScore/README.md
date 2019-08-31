
Programa teste piloto para aplicar conceitos de um servidor Rest/Json, usando componentes do Indy. Assim, quem não tem somente  o Delphi Community Edition, como é meu caso, consegue fazer um servidor sem depender de frameworks como DataSnap.

O que coloquei de funcionalidades a mais:

1) Costumo usar o JWT (*) e, estou usando a implementação de Paolo Rossi (**)
2) Como dito, como não tenho o Delphi Community, usei um servidor JSON Puro
3) Usei o servidor RaptorWS (***), baseado em Indy  e, ainda este, estou procurando melhorá-lo em meus projetos
4) Se pudesse e tivesse tempo hábil, iria aplicar um servidor de proxy reverso, no caso o NGINX.
5) Desenvolvi em Delphi Rio 10.2 Community;
6) Início do Desenvolvimento 13/06/2019 21h00 e término em 14/06/2019 09h00, apesar de ter aproveitado parte do código, demorei 6 horas de trabalho.

Funcionalidades:
1) Inclusão da data do jogo e pontuação;
2) Método para retornar o resultado estatístico;
3) Para testar o JWT, coloquei um tempo de 4 minutos com validade de Token JWT;
4) O banco se chama Marcio.DB e, é criado automaticamente pelo driver do SQLLite na pasta do binário do servidor.
5) Os fontes estão em src e, o binário em bin

(*) - https://tools.ietf.org/html/rfc7515
(**) - https://github.com/paolo-rossi/delphi-jose-jwt
(***) - https://delphisolutions.wordpress.com/raptorws/

Marcio Cruz
14/06/2019
https://www.linkedin.com/in/marciofcruz/