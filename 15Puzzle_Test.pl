%Larissa Galeno | DRE: 116083017
%fonte: https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/

%consultas:
%solucionavel([13, 2, 10, 3, 1, 12, 8, 4, 5, *, 9, 6, 15, 14, 11, 7]). 
%Resposta esperada: true (ou seja é solucionável)
%solucionavel([6, 13, 7, 10, 8, 9, 11, *, 15, 2, 12, 5, 14, 3, 1, 4]).
%Resposta esperada: true
%solucionavel([3, 9, 1, 15, 14, 11, 4, 6, 13, *, 4, 10, 12, 2, 7, 8, 5]).
%Resposta esperada: false (não é solucionável)

solucionavel(Estado) :-
    %ver em qual LINHA está * 
    posicao(Estado, Pos),
    linha(Pos, Linha),
    %ve se é par
    par(Linha),
    !,
    %sendo par segue
    contaInversao(Estado, Res),
    impar(Res).

solucionavel(Estado) :-
	%ver em qual LINHA está * 
    posicao(Estado, Pos),
    linha(Pos, Linha),
    %ve se é impar
    impar(Linha),
    !,
    contaInversao(Estado, Res),
    par(Res).
    
posicao([* | _], 1) :- !.
posicao([_ | Tail], Pos) :-
    posicao(Tail, Pos1),
    Pos is Pos1 + 1. 

linha(Pos, 1) :-
    Pos =< 16,
    Pos >= 13,
    !.
linha(Pos, 2) :-
    Pos =< 11,
    Pos >= 9,
    !.
linha(Pos, 3) :-
    Pos =< 8,
    Pos >= 5,
    !.
linha(Pos, 4) :-
    Pos =< 4,
    Pos >= 1.

par(Num) :-
    Num mod 2 =:= 0, 
    !.
impar(Num) :-
    Num mod 2 =\= 0.

analisaDupla(Head, [* | Tail], Res) :-
    !,
    analisaDupla(Head, Tail, Res).
analisaDupla(_, [], 0).
analisaDupla(Head, [Head2 | Tail], Res) :-
    Head > Head2,
    !, 
    analisaDupla(Head, Tail, Res1),
    Res is Res1 + 1.

analisaDupla(Head, [Head2 | Tail], Res) :-
    Head < Head2,
    analisaDupla(Head, Tail, Res).

%contaInversao([13, 2, 10, 3, 1, 12, 8, 4, 5, *, 9, 6, 15, 14, 11, 7], R).
contaInversao([* | Tail_Est], Total) :-
    contaInversao(Tail_Est, Total).
contaInversao([], 0).
contaInversao([Head_Est | Tail_Est], Total) :-
    analisaDupla(Head_Est, Tail_Est, Res),
    contaInversao(Tail_Est, Total1),
    Total is Res + Total1,
    !.
