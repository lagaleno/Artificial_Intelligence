/* Larissa Galeno DRE: 116083 */
/* Só calcula Fibonacci até 29 */

fibo(1, 0). %caso base
fibo(2, 1). %caso base

fibo(X, N) :-
    X > 2,  % para não repetir dos casos base
    X1 is X - 1,
    X2 is X - 2, 
    fibo(X1, N1), 
    fibo(X2, N2), 
    N is N1 + N2.