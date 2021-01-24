%Larissa Galeno | DRE: 116083017

%representação Jarra: [J1, J2] -> [Quantos litros tem na Jarra1, Quantos litros tem na Jarra2]
%----- LETRA A ------
objetivo([2, 0]).
objetivo([2, 1]).
objetivo([2, 2]).
objetivo([2, 3]).

%----- LETRA B -----
%ações possíveis: encher1, encher2, esvaziar1, esvaziar2, passar12 (joga agua de 1 em 2), passar21
%acoes([J1, J2], ação, [J1_Novo, J2_Novo])

%enche J1 e J2 permanece o mesmo
acao([J1, J2], encher1, [4, J2]) :- J1 < 4.
%enche J2 e J1 permanece o mesmo
acao([J1, J2], encher2, [J1, 3]) :- J2 < 3.
%joga água de J1 fora e J2 permanece o mesmo
acao([J1, J2], esvaziar1, [0, J2]) :- J1 > 0.
%joga água de J2 fora e J1 permanece o mesmo
acao([J1, J2], esvaziar2, [J1, 0]) :- J2 > 0.

%joga água de J1 em J2, podendo completar J2 e ainda assim sobrar algo em J1
acao([J1, J2], passar12, [0, J2_novo]) :- 
    J2 < 3,
    J1 > 0, %se não tiver pode dar problmas no estado [0, 0]
    Falta is 3 - J2,
    Falta >= J1,
    J2_novo is J2 + J1.
acao([J1, J2], passar12, [J1_novo, J2_novo]) :-
    J2 < 3, 
    J1 > 0, %se não tiver pode dar problmas no estado [0, 0]
    Falta is 3 - J2, 
    Falta < J1,
    J1_novo is J1 - Falta, 
    J2_novo is J2 + Falta. 
%joga água de J2 em J1, podendo completar J1 e ainda assim sobrar algo em J2
acao([J1, J2], passar21, [J1_novo, 0]) :- 
    J1 < 4,
    J2 > 0,
    Falta is 4 - J1,
    Falta >= J2,
    J1_novo is J2 + J1.
acao([J1, J2], passar21, [J1_novo, J2_novo]) :-
    J1 < 4, 
    J2 > 0, %se não tiver pode dar problmas no estado [0, 0]
    Falta is 4 - J1, 
    Falta < J2,
    J2_novo is J2 - Falta, 
    J1_novo is J1 + Falta. 

%------ LETRA C ------
%vizinhos(N, FilhosN)
%N -> um estado que a jarra pode estar
%filhosN -> configurações possíveis aplicando cada uma das ações

vizinhos([J1, J2], FilhosN) :-
    %variável anonima na açõa, pois assim tentará com todas
    findall([J1_r, J2_r], acao([J1, J2], _, [J1_r, J2_r]), FilhosN).
	
	%consultas feitas: vizinhos([4, 1], L), vizinhos([3, 1], L), vizinhos([0, 0], L)...

%------ LETRA D -----
%ATENÇÃO: consulta deve ser feita: buscaLargura_D([[0, 0]]). usando lista de listas
buscaLargura_D([Node | _]) :- objetivo(Node).
buscaLargura_D([Node | F1]) :- 
    vizinhos(Node, FilhosN), 
    addFronteiraLargura_D(FilhosN, F1, F2),
    buscaLargura_D(F2).

addFronteiraLargura_D(FilhosN, F1, F2) :- append(F1, FilhosN, F2). %como é em Largura FilhosN vem depois de F1

%Programa retornou true, indicando que encontra algum estado objetivo, e fica encontrando vários "true".
%O programa não retorna por quais estados passou ou o caminho

%---- LETRA E ----
%Retorna uma lista com todos os estados gerados (não necessariamente do caminho escolhido)
%Exemplo de consulta: buscaLargura_E([[0, 0]], X).
buscaLargura_E([Node | _], [Node]) :- objetivo(Node).
buscaLargura_E([Node | F1], [Node | Tail]) :- 
    vizinhos(Node, FilhosN), 
    addFronteiraLargura_E(FilhosN, F1, F2),
    buscaLargura_E(F2, Tail).

addFronteiraLargura_E(FilhosN, F1, F2) :- append(F1, FilhosN, F2). %como é em Largura FilhosN vem depois de F1

%---- LETRA F ----
%desconsiderar repetições de estados já gerados
%buscaLargura_F([[0, 0]], [[0, 0]], X).
%passa o estado inicial já para a lista de gerados para o preenchime
buscaLargura_F([Node | _], _, [Node]) :- objetivo(Node).
buscaLargura_F([Node | F1], Gerados, [Node | Tail]) :- 
    vizinhos(Node, FilhosN), 
    dif(FilhosN, Gerados, Filhos_sem_repeticao),
    append(Filhos_sem_repeticao, Gerados, Gerados_atualizado),
    addFronteiraLargura_F(Filhos_sem_repeticao, F1, F2),
    buscaLargura_F(F2, Gerados_atualizado, Tail).

addFronteiraLargura_F(FilhosN, F1, F2) :- 
    append(F1, FilhosN, F2). %como é em Largura FilhosN vem depois de F1

%montar uma lista L3 que tem os elementos de L1 mas não estão em L2
%dif(L1, L2, L3).

dif([], _, []).
dif([Head | Tail], L2, [Head | L3]) :-
	not(member(Head, L2)),
    !,
    dif(Tail, L2, L3).

dif([Head | Tail], L2, L3) :-
    member(Head, L2),
    !,
    dif(Tail, L2, L3).

%------ LETRA G ------
buscaProfundidade([Node | _], _, [Node]) :- objetivo(Node).
buscaProfundidade([Node | F1], Gerados, [Node | Tail]) :- 
    vizinhos(Node, FilhosN), 
    dif(FilhosN, Gerados, Filhos_sem_repeticao),
    reverse(Filhos_sem_repeticao, Filhos),
    append(Filhos, Gerados, Gerados_atualizado),
    addFronteiraProfundidade(Filhos, F1, F2),
    buscaProfundidade(F2, Gerados_atualizado, Tail).

addFronteiraProfundidade(FilhosN, F1, F2) :- 
    append(FilhosN, F1, F2). %como é em Largura FilhosN vem antes de F1 por ser uma pilha