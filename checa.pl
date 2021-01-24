checar2([], _, _).
checar2([Head_Fronteira | Tail_Fronteira], Cor, R) :-
    not(member([Head_Fronteira, Cor], R)), % Head não sendo membro de R
    !,
    checar2(Tail_Fronteira, Cor, R). %sigo checando a lista

%checar([Head_Fronteira | Tail_Front], Cor, R)
checar2([Head_Fronteira | _], Cor, R) :-
    member([Head_Fronteira, Cor], R), %se for membro tenho que voltar para onde chamei e trocar de cor
    !.
