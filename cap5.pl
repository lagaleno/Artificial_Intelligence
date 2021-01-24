p(1).
p(2) :- !.
p(3).

%uma lista gera duas listas, uma com positivos e outro com negativos
%split(L, P, N).
%com append
split2([], [], []).
split2([Head | Tail], P, N) :-
    Head >= 0,
    !,
    split(Tail, P1, N),
    append([Head], P1, P).

split2([Head | Tail], P, N) :-
    Head < 0,
    split(Tail, P, N1),
    append([Head], N1, N).

%sem append
split([], [], []).
split([Head | Tail], [Head | P1], N) :-
    Head >= 0,
    !,
    split(Tail, P1, N).

split([Head | Tail], P, [Head | N1]) :-
    Head < 0,
    split(Tail, P, N1).

%formar uma lista L de itens que estão em C, mas não estão em R

f1([], _, []).
f1([Head | Tail], R, L) :-
    f(Tail, R, L1),
    not(member(Head, R)),
    L = [Head | L1].

%Feito com cut
f2([], _, []).
f([Head | Tail], R, [Head | L1]) :-
    not(member(Head, R)),
    !,
    f(Tail, R, L1). 

f2([Head | Tail], R, L1) :-
    member(Head, R),
    !,
    f(Tail, R, L1).
    


% Resolução JC
f([], _, []).

f([Head | Tail], R, [Head | L1]) :-
    not(member(Head, R))
    f(Tail, R, L1).

f([Head | Tail], R, L1) :-
    member(Head, R),
    f(Tail, R, L1).


%------5.5------
%A - B
%difference(A, B, Set)

difference([], _, []) :- !.

difference([Head | Tail], B, [Head | TailSet]) :-
    not(member(Head, B)),
    !,
    difference(Tail, B, TailSet).

difference([Head | Tail], B, Set) :-
    member(Head, B),
    !,
    difference(Tail, B, Set).