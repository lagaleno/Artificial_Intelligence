%Larissa Galeno | DRE: 116083017

%Ideia: fazer uma primeira chamada para pintar, preencher o primeiro com amarelo, depois fazer chamadas recursivas
%para ir preemnchendo o resto avaliando as fronteiras; na hora de tentar pintar seguir uma ordem: primeiro tentar de amarelo
%avaliar se é válido, se não for, tentar azul, se não for, tentar vermelho, se não for, tentar verde.
%

%---README---
%pintar(Mapa, Resultado) -> Consulta deve ser feito com pintar(Mapa, Resultado)
% Mapa é [[a, b], [b, a, c], [c, b, d], [d, c, e], [e, d]], cada "lista interior" descreve as fronteiras que a cabeça da 
% "lista interior" tem com outros territórios. Por exemplo:"a" faz fronteira com "b";
% "b" faz fronteira com "a", "c"; "c" faz fronteira com "b" e "d"...
% pintarRecurssivo(Mapa, Resultado Temporário, Resultado)
% Temp -> é uma lista que vou preenchendo ao longo do caminho, para poder usar como comparação de quais territórios
% estão pintados
% Resultado -> é a lista que o prolog vai devolver e vai ser preenchida na volta da recursão. 
%checar(Fronteiras, Cores, Resultado) -> analisar as fronteiras
%cores definidas do programa: amarelo, azul, vermelho, verde

%---Exemplos de consulta---:
%pintar([[a, b], [b,a]], Res).
%Res =  [[a, amarelo], [b, azul]]
%pintar([[a, b, c], [b, a, c, d, e], [c, a, b, d, e], [d, c, e], [e, d]], Res).
%Res = [[a, amarelo], [b, azul], [c, vermelho], [d, amarelo], [e, azul]]
%pintar([[a, b, c, d, e, f], [b, a], [c, a], [d, a],  [e, a, f], [f, a, e]], Res). 
%Res =  [[a, amarelo], [b, azul], [c, azul], [d, azul], [e, azul], [f, vermelho]]
%pintar([[a, b, c], [b, a, c, d], [c, a, b, d], [d, b, c, e, f],  [e, d, f, g], [f, d, e, g], [g, d, e, f]], Res). 
%Res = [[a, amarelo], [b, azul], [c, vermelho], [d, amarelo], [e, azul], [f, vermelho], [g, verde]]

%regras auxiliares
add(X, Y, [X | Y]).
head_lista([Head | _], Head).

%primeira chamada de pintar
pintar([Head_Mapa | Tail_Mapa], [[Head, amarelo] | Res]) :-
    head_lista(Head_Mapa, Head), 
    Temp = [[Head, amarelo]], % Colocar assim para quando chamar o pintar1 ir com valor atualizado
    pintarRecursivo(Tail_Mapa, Temp, Res).

%pintar o resto
pintarRecursivo([], _, []).
pintarRecursivo([[Head_do_Head_Mapa | Tail_do_Head_Mapa]| Tail_Mapa], Temp, [[Head_do_Head_Mapa, amarelo]| Res ]) :-
  	checar(Tail_do_Head_Mapa, amarelo, Temp), %checar se na fronteira tem alguém amarelo, não tendo: 
    !,
	add([Head_do_Head_Mapa, amarelo], Temp, Temp2),
    pintarRecursivo(Tail_Mapa, Temp2, Res). %com isso sendo verdade quero analisar o próximo território

pintarRecursivo([[Head_do_Head_Mapa | Tail_do_Head_Mapa]| Tail_Mapa], Temp, [[Head_do_Head_Mapa, azul]| Res ]) :- %se na fronteira tiver alguém amarelo
    checar(Tail_do_Head_Mapa, azul, Temp), %checar se na fronteira tem alguém azul, não tendo:
    !,
    add([Head_do_Head_Mapa, azul], Temp, Temp2),
    pintarRecursivo(Tail_Mapa, Temp2, Res). %com isso sendo verdade quero analisar o próximo território

pintarRecursivo([[Head_do_Head_Mapa | Tail_do_Head_Mapa]| Tail_Mapa], Temp, [[Head_do_Head_Mapa, vermelho]| Res ]) :- %se na fronteira tiver alguém amarelo e azul
    checar(Tail_do_Head_Mapa, vermelho, Temp), %checar se na fronteira tem alguém vermelho, não tendo:
    !,
    add([Head_do_Head_Mapa, vermelho], Temp, Temp2),
    pintarRecursivo(Tail_Mapa, Temp2, Res). %com isso sendo verdade quero analisar o próximo território

pintarRecursivo([[Head_do_Head_Mapa | Tail_do_Head_Mapa]| Tail_Mapa], Temp, [[Head_do_Head_Mapa, verde]| Res ]) :- %se na fronteira tiver alguém amarelo, azul e vermelho
    checar(Tail_do_Head_Mapa, verde, Temp), %checar se na fronteira tem alguém verde, não tendo:
    !,
    add([Head_do_Head_Mapa, verde], Temp, Temp2),
    pintarRecursivo(Tail_Mapa, Temp2, Res). %com isso sendo verdade quero analisar o próximo território

checar([], _, _).
checar([Head_Fronteira | Tail_Fronteira], Cor, Temp) :-
    not(member([Head_Fronteira, Cor], Temp)), % Head não sendo membro de Temp
    !,
    checar(Tail_Fronteira, Cor, Temp). %sigo checando a lista

checar([Head_Fronteira | _], Cor, Temp) :-
    member([Head_Fronteira, Cor], Temp), %se for membro tenho que voltar para onde chamei e trocar de cor
    !,
    fail. %se for membero quero que dê errado, para que o programa vá para próxima regra trocando a cor.


%---Observações finais---
%Se fizermos pintar(X, [[a, amarelo], [b, azul], [c, vermelho], [d, amarelo], [e, azul], [f, vermelho], [g, verde]]), por exemplo
%X vai ter como resultado os territórios, e não quem faz fronteira com quem.