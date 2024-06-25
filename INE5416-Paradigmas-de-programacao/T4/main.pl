cor(amarelo).
cor(azul).
cor(branco).
cor(verde).
cor(vermelho).

homem(antonio).
homem(caio).
homem(igor).
homem(mauricio).
homem(renan).

mulher(ana).
mulher(claudia).
mulher(denise).
mulher(laura).
mulher(monica).

local(churrasco).
local(faculdade).
local(festa).
local(praia).
local(trabalho).

tempo(1).
tempo(2).
tempo(3).
tempo(4).
tempo(5).

presente(anel).
presente(bolsa).
presente(perfume).
presente(sandalia).
presente(vestido).

solucao(Resposta) :-
    Resposta = [
        posicao(Cor1, Homem1, Mulher1, Local1, Tempo1, Presente1),
        posicao(Cor2, Homem2, Mulher2, Local2, Tempo2, Presente2),
        posicao(Cor3, Homem3, Mulher3, Local3, Tempo3, Presente3),
        posicao(Cor4, Homem4, Mulher4, Local4, Tempo4, Presente4),
        posicao(Cor5, Homem5, Mulher5, Local5, Tempo5, Presente5)
    ],

    % 1. O casal que namora há um ano está ao lado da mulher que ganhou uma Bolsa.
    ao_lado(posicao(_, _, _, _, _, bolsa), posicao(_, _, _, _, 1, _), Resposta),

    % 2. A mulher de Branco está exatamente à direita da de Amarelo.
    exatamente_a_direita(posicao(branco, _, _, _, _, _), posicao(amarelo, _, _, _, _, _), Resposta),

    % 3. Na primeira posição está a mulher que ganhou um Perfume.
    Presente1 = perfume,

    % 4. O casal que se conheceu na Praia está em uma das pontas.
    noCanto(posicao(_, _, _, praia, _, _), Resposta),

    % 5. Mônica está em algum lugar à direita da mulher de Vermelho.
    qualquer_lugar_a_direita(posicao(_, _, monica, _, _, _), posicao(vermelho, _, _, _, _, _), Resposta),

    % 6. A mulher do vestido Branco está exatamente à esquerda de Maurício.
    exatamente_a_esquerda(posicao(branco, _, _, _, _, _), posicao(_, mauricio, _, _, _, _), Resposta),

    % 7. A mulher que ganhou um Anel está na terceira posição.
    Presente3 = anel,

    % 8. Laura está ao lado da mulher de Verde.
    ao_lado(posicao(_, _, laura, _, _, _), posicao(verde, _, _, _, _, _), Resposta),

    % 9. Renan namora Denise.
    member(posicao(_, renan, denise, _, _, _), Resposta),

    % 10. Quem ganhou um Perfume está exatamente à esquerda do casal que se conheceu num Churrasco.
    exatamente_a_esquerda(posicao(_, _, _, _, _, perfume), posicao(_, _, _, churrasco, _, _), Resposta),

    % 11. A mulher que ganhou uma Bolsa está em algum lugar entre o Igor e a mulher de Vermelho, nessa ordem.
    entre(posicao(_, igor, _, _, _, _), posicao(_, _, _, _, _, bolsa), posicao(vermelho, _, _, _, _, _), Resposta),

    % 12. Antônio namora Mônica.
    member(posicao(_, antonio, monica, _, _, _), Resposta),

    % 13. Na quarta posição está o casal que namora há 3 anos.
    Tempo4 = 3,

    % 14. O casal que namora há 2 anos está ao lado de Maurício.
    ao_lado(posicao(_, _, _, _, 2, _), posicao(_, mauricio, _, _, _, _), Resposta),

    % 15. O casal do namoro mais longo é aquele que se conheceu numa Festa.
    member(posicao(_, _, _, festa, 5, _), Resposta),

    % 16. Renan está exatamente à esquerda do casal que namora há 4 anos.
    exatamente_a_esquerda(posicao(_, renan, _, _, _, _), posicao(_, _, _, _, 4, _), Resposta),

    % 17. Claudia está na segunda posição.
    Mulher2 = claudia,

    % 18. A mulher que ganhou um Vestido está exatamente à esquerda do casal que se conheceu na Faculdade.
    exatamente_a_esquerda(posicao(_, _, _, _, _, vestido), posicao(_, _, _, faculdade, _, _), Resposta),

    % Garantindo que as posições são distintas
    cor(Cor1), cor(Cor2), cor(Cor3), cor(Cor4), cor(Cor5),
    todos_diferentes([Cor1, Cor2, Cor3, Cor4, Cor5]),
    
    homem(Homem1), homem(Homem2), homem(Homem3), homem(Homem4), homem(Homem5),
    todos_diferentes([Homem1, Homem2, Homem3, Homem4, Homem5]),
    
    mulher(Mulher1), mulher(Mulher2), mulher(Mulher3), mulher(Mulher4), mulher(Mulher5),
    todos_diferentes([Mulher1, Mulher2, Mulher3, Mulher4, Mulher5]),

    local(Local1), local(Local2), local(Local3), local(Local4), local(Local5),
    todos_diferentes([Local1, Local2, Local3, Local4, Local5]),

    tempo(Tempo1), tempo(Tempo2), tempo(Tempo3), tempo(Tempo4), tempo(Tempo5),
    todos_diferentes([Tempo1, Tempo2, Tempo3, Tempo4, Tempo5]),

    presente(Presente1), presente(Presente2), presente(Presente3), presente(Presente4), presente(Presente5),
    todos_diferentes([Presente1, Presente2, Presente3, Presente4, Presente5]).

% % Regras auxiliares

% Verifica se A está ao lado de B
ao_lado(A, B, Lista) :- nextto(A, B, Lista) ; nextto(B, A, Lista).

% Verifica se A está exatamente à direita de B
exatamente_a_direita(A, B, Lista) :- nth0(Ia, Lista, A), nth0(Ib, Lista, B), Ia is Ib + 1.

% Verifica se A está em qualquer lugar à direita de B
qualquer_lugar_a_direita(A, B, Lista) :-
    append(_, [B | T], Lista), % Divide a Lista em [_, B | T], onde B é o primeiro elemento depois de _
    member(A, T). % Verifica se A é membro da lista T, ou seja, está à direita de B

% Verifica se A está exatamente à esquerda de B
exatamente_a_esquerda(A, B, Lista) :- exatamente_a_direita(B, A, Lista).

% Verifica se B está entre A e C
entre(A, B, C, Lista) :- nth0(Ia, Lista, A), nth0(Ib, Lista, B), nth0(Ic, Lista, C), Ia < Ib, Ib < Ic.

% Verifica se todos os elementos de uma lista são diferentes
todos_diferentes(List) :- sort(List, Sorted), length(List, Len), length(Sorted, Len).
% todos_diferentes([]).
% todos_diferentes([H|T]) :- not(member(H,T)), todos_diferentes(T).

% X está no canto se ele é o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).