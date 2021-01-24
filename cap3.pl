%-----3.3-----
%evenlength(List)
%oddlength(List)

count([], 0).
count([_| Tail], I) :-
	count(Tail, I2),
	I is I2 + 1.

evenlength([]).
evenlength(List) :-
    count(List, I),
    Y is I mod 2,
    Y =:= 0.

oddlength([_]).
oddlength(List) :-
    count(List, I), 
    Y is I mod 2,
    Y =\= 0.

%----3.4-----
%reverse(List, ReversedList).

reverse([], []).
reverse([X], [X]).
reverse([X, Y], [Y, X]).
reverse([Head | Tail], R) :-
    reverse(Tail, R2), 
    R = [R2 | Head]. %Na parte de Tail preciso ter uma lista

%----3.7-----

means([], empty).
means(0, zero).
means(1, one).
means(2, two).
means(3, three).
means(4, four).
means(5, five).
means(6, six).
means(7, seven).
means(8, eight).
means(9, nine).

translate([], [empty]).
translate([X], [Name]) :-
    means(X, Name).

translate([Head | Tail], Name) :-
    means(Head, Name1),
    translate(Tail, X),
    Name = [Name1 | X].


%------3.8------
%subset feita em aula, ver depois

%----3.9------
%divide(List, List1, List2)
%dvidir List no meio ou aproximado

dividelist([], [], []).
dividelist([X], [X], []).
dividelist([X, Y], [X], [Y]).

dividelist([Head | Tail], L1, L2) :-
    dividelist(Tail, L11, L2),
    count(L11, R),
    Y is R div 2,
    count([Head|Tail], Tl),
    Tl > Y,
    L1 = [Head | L11].

dividelist([Head | Tail], L1, L2) :-
    dividelist(Tail, L1, L22),
    count(L22, R),
    Y is R div 2,
    count([Head|Tail], Tl),
    Tl < Y,
    L2 = [Head | L22].
    


%-----3.16-----
%max(X, Y, Max)
%Max é maior numero entre X e Y

max(X, X, X). %caso sejam iguais
max(X, Y, Max) :-
    X > Y,
    Max is X.
max(X, Y, Max) :-
    X < Y, 
    Max is Y.


%------3.17-----
%maxlist(List, Max)
%Max é o maior número da lista dada

maxlist([X], X).
maxlist([Head | Tail], Max) :-
    maxlist(Tail, Max1),
    max(Max1, Head, X),
    Max is X,
    !. %não sei se é a melhor forma de consertar, mas foi uma for de executar uma vez só

%----3.18-----
%faz a soma dos elementos na lista
sum([], 0).
sum([Head | Tail], Sum) :- %ideia ir somando as cabeças até terminar
    sum(Tail, Sum1),
    Sum is Head + Sum1.

%----3.19----
%diz se a lista está ordenada
%order(List).

order([_]).
order([Head | Tail]) :-
    [Head2 | _] = Tail,
    Head =< Head2,
    order(Tail),
    !. %para dar uma resposta só, mas não se se é o melhor jeito

%----3.20----
%?

%----3.21----
%between(N1, N2, X).
% N1 =< X <= N2, X é uma lista

between1(N, N, N).
%between1(N1, _, X) :-
%    X1 is N1,
%    X = [X1].
between1(N1, N2, X) :-
    X1 is N1 + 1,
    X1 =< N2,
    Temp is X1,
    X3 = [N1 | Temp].
    between1X1, N2, X).