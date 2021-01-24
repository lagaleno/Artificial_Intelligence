% soma(5, S) S = 15

soma(0, 0).
soma(N, S) :-
	N > 0,
	N1 is N - 1,
	soma(N1, S1),
	S is  N + S1.
