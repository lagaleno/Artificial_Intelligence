%3.1

conc([], L, L).
conc([X|L1], L2, [X|L3]):-
     conc(L1, L2, L3).
%conc(L2, [_, _, _], L1)
%conc(_, [_, _, _ | L2], L1)

%3.2
%usando conc
last([], []).
last(Item, List) :-
    conc(_, [_ | Item], List).

add(X, L, [X|L]).

del(X, [X | Tail], Tail).
del(X, [Y | Tail], [Y | Tail1]) :-
    del(X, Tail, Tail1).


%faz a soma dos elementos na lista
sum([], 0).
sum([Head | Tail], Sum) :- %ideia ir somando as cabeças até terminar
    sum(Tail, Sum1),
    Sum is Head + Sum1.
