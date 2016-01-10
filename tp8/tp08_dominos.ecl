% TP8 Laurent AMYARD et Blandine SEZNEC

stones([stone(2,2),stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]).

s_double([stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]).
/*
stones([stone(2, 2), stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2), stone(5, 1), stone(5, 5), stone(4, 5), stone(2, 3), stone(3, 6)]).	
stones([stone(6, 6), stone(6, 5), stone(6, 4), stone(6, 3), stone(6, 2), stone(6, 1), stone(6, 0),
        stone(5, 5), stone(5, 4), stone(5, 3), stone(5, 2), stone(5, 1), stone(5, 0),
        stone(4, 4), stone(4, 3), stone(4, 2), stone(4, 1), stone(4, 0),
        stone(3, 3), stone(3, 2), stone(3, 1), stone(3, 0),
        stone(2, 2), stone(2, 1), stone(2, 0),
        stone(1, 1), stone(1, 0),
        stone(0, 0)]).
*/	


/* choose(+, -, -): 'a list * 'a * 'a list */

choose(L,E,R):-
	append(Pg,[E|Pd],L),
	append(Pg,Pd,R).


/*  poser(+,+,-) : stone * chain * chain
	ajout d'un domino à une chaine */
	
poser_chain(stone(X,Y),chain([],[]),chain([X],[Y])).

poser_chain(stone(X,Y),chain([X|L1],L2),chain(R1,L2)):-
	append([Y],[X|L1],R1).
	
poser_chain(stone(X,Y),chain([Y|L1],L2),chain(R1,L2)):-
	append([X],[Y|L1],R1).

poser_chain(stone(X,Y),chain(L1,[X|L2]),chain(L1,R2)):-
	append([Y],[X|L2],R2).
	
poser_chain(stone(X,Y),chain(L1,[Y|L2]),chain(L1,R2)):-
	append([X],[Y|L2],R2).
	
/*  poser(+,+,-) : stone * chain list * chain list 
	ajout d'un domino au jeu */
		
poser(stone(X,Y), chainList([H]),chainList([Res])) :-
	\==(X,Y),
	poser_chain(stone(X,Y),H,Res).
	
poser(stone(X,X), chainList([H]),chainList([chain([X],[double]),Res])) :-
	poser_chain(stone(X,X),H,Res).	

poser(stone(X,Y), chainList([H|L]),chainList([H|Res])):-
	poser(stone(X,Y),chainList(L),chainList(Res)).
	
/* chains(+,+,-) */

chains([],R,R).

chains(Dom,Acc,Res):-
	choose(Dom,stone(X,Y),Dom2),  	% Dom2 : liste des dominos privée du domino(X,Y)
	poser(stone(X,Y),Acc,Res2),		% Res2 : liste des chaines avec domino (X,Y) ajouté
	chains(Dom2,Res2,Res).
	
/* domino(-) : chain list */

domino(Chains):-
	stones(Dominos),
	chains(Dominos,chainList([chain([],[])]),Chains).


chains_to_list_of_list([], []).
chains_to_list_of_list([chain(L, [double]) | Rest], LL) :-
        length(L, 1),
        chains_to_list_of_list(Rest, LL).
chains_to_list_of_list([chain(L1, L2) | Rest], [Stones | LL]) :-
        (
            length(L1, N), N > 1 
        ; 
            L2 \== [double]
        ),
        reverse(L2, RevL2),
        append(L1, RevL2, L),
        create_stones(L, Stones),
        chains_to_list_of_list(Rest, LL).

create_stones([_], []).
create_stones([A, B | Rest], [stone(A, B) | Stones]) :-
        create_stones([B | Rest], Stones).

print_chains(Chains) :-
        chains_to_list_of_list(Chains, LL),
        (foreach(Chain, LL) do 
            writeln(Chain)).

/* ==================================================================================
			TESTS
   ==================================================================================
?- choose(Liste, stone(X, Y), Reste), stones(Liste).
Liste = [stone(2, 2), stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]
X = 2
Y = 2
Reste = [stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]
Yes (0.00s cpu, solution 1, maybe more)
Liste = [stone(2, 2), stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]
X = 4
Y = 6
Reste = [stone(2, 2), stone(1, 2), stone(2, 4), stone(6, 2)]
Yes (0.03s cpu, solution 2, maybe more)
Liste = [stone(2, 2), stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]
X = 1
Y = 2
Reste = [stone(2, 2), stone(4, 6), stone(2, 4), stone(6, 2)]
Yes (0.03s cpu, solution 3, maybe more)
Liste = [stone(2, 2), stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]
X = 2
Y = 4
Reste = [stone(2, 2), stone(4, 6), stone(1, 2), stone(6, 2)]
Yes (0.03s cpu, solution 4, maybe more)
Liste = [stone(2, 2), stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]
X = 6
Y = 2
Reste = [stone(2, 2), stone(4, 6), stone(1, 2), stone(2, 4)]
Yes (0.05s cpu, solution 5, maybe more)
==================================================================================
?- poser(stone(4, 5), chainList([chain([1], [1]), chain([1, 2], [4])]), Res).
Res = chainList([chain([1], [1]), chain([1, 2], [5, 4])])
Yes (0.00s cpu, solution 1, maybe more)
No (0.02s cpu)

?- poser(stone(4, 5), chainList([]), Res).
No (0.00s cpu)

?- poser(stone(5, 5), chainList([chain([1, 2], [5, 4])]), Res).
Res = chainList([chain([5], [double])|chain([1, 2], [5, 5, 4])])
Yes (0.00s cpu, solution 1, maybe more)
==================================================================================
?- domino(Res).
Res = chainList([chain([2], [double]), chain([1, 2], [2, 6, 4, 2])])
Yes (0.00s cpu, solution 1, maybe more)
Res = chainList([chain([2], [double]), chain([1, 2], [2, 4, 6, 2])])
Yes (0.01s cpu, solution 2, maybe more)
Res = chainList([chain([2], [double]), chain([2, 6, 4, 2], [1, 2])])
Yes (0.01s cpu, solution 3, maybe more)
Res = chainList([chain([2], [double]), chain([2, 4, 6, 2], [1, 2])])
Yes (0.03s cpu, solution 4, maybe more)
Res = chainList([chain([2], [double]), chain([2, 6, 4, 2], [1, 2])])
Yes (0.05s cpu, solution 5, maybe more)
Res = chainList([chain([2], [double]), chain([1, 2, 6, 4, 2], [2])])
Yes (0.05s cpu, solution 6, maybe more)
...
...
*/
