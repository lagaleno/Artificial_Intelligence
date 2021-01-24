fatorial(0, 1).
%fatorial(1, 1).
% é preciso tirar essa linha para não dar dois resultados
fatorial(N, S) :-
    N > 1,
    N1 is N - 1,
    fatorial(N1, S1),
    S is N * S1.
