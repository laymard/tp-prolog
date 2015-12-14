/**
TP 4 Arbres binaires - Prolog

@author Laurent AYMRAD
@author Blandine SEZNEC
@version Annee scolaire 2015/2016
*/


/*
-------------------------------------------------------------------------------
 D�finition des pr�dicats
-------------------------------------------------------------------------------
*/


/*
Q1
*/

arbre_binaire(arb_bin(R,G,D)):-
	integer(R),
	arbre_binaire(G),
	arbre_binaire(D).

arbre_binaire(vide).

/*test
Yes (0.00s cpu)
[eclipse 21]: arbre_binaire(arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide))).

Yes (0.00s cpu)
[eclipse 22]: arbre_binaire(arb_bin(3,vide,vide)).

Yes (0.00s cpu)

*/

/*
Question 2: dans_arbre_binaire(+E,+B) : v�rifie si est l'une des �tiquettes de l'abre binaire B  
*/ 

dans_arbre_binaire(E,arb_bin(E,_,_)):-
	!.

dans_arbre_binaire(E,arb_bin(R,G,D)):-
	\==(E,R),
	dans_arbre_binaire(E,G).

dans_arbre_binaire(E,arb_bin(R,G,D)):-
	\==(E,R),
	dans_arbre_binaire(E,D).

/*

[eclipse 52]: dans_arbre_binaire(7,arb_bin(7, arb_bin(4, vide, vide), arb_bin(7, arb_bin(6, vide, vide), arb_bin(7, vide, vide)))).

Yes (0.00s cpu)

*/

/*
Question 3 : sous_arbre_binaire(+S,+B) : v�rifie sir S est un sous arbre de B
*/


sous_arbre_binaire(S,S) :-
	!.
sous_arbre_binaire(S,arb_bin(_,G,_)) :-
	sous_arbre_binaire(S,G),
	!. 					
sous_arbre_binaire(S,arb_bin(_,_,D)) :-
	sous_arbre_binaire(S,D),
	!. 	

	
/*

[eclipse 12]:  sous_arbre_binaire(arb_bin(5,vide,vide),arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide)))).

Yes (0.00s cpu)

*/

/*
Question 4 : remplacer(+SA1,+SA2,+B,-B1)
*/

remplacer(_,_,vide,vide).
remplacer(SA1,SA2,SA1,SA2).

remplacer(SA1,SA2,arb_bin(R1,G1,D1),arb_bin(R1,G2,D2)):-
	\==(SA1,arb_bin(R1,G1,D1)),
	remplacer(SA1,SA2,G1,G2),
	remplacer(SA1,SA2,D1,D2).


/*
remplacer(	arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide)),
		arb_bin(7,vide,vide),
		arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide))),
		R).

R = arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(7, vide, vide))

*/

/*
Question 5 : isomorphe(+B1,+B2)
*/

isomorphe(S,S).

isomorphe(arb_bin(R1,G1,D1),arb_bin(R2,G2,D2)):-
	\==(arb_bin(R1,G1,D1),arb_bin(R2,G2,D2)),
	isomorphe(G1,G2),
	isomorphe(D1,D2).

isomorphe(arb_bin(R1,G1,D1),arb_bin(R2,G2,D2)):-
	\==(arb_bin(R1,G1,D1),arb_bin(R2,G2,D2)),
	isomorphe(G1,D2),
	isomorphe(D1,G2).

/*


[eclipse 16]: isomorphe(	arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide))),
		arb_bin(3, arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide)), arb_bin(4, vide, vide))).	

Yes (0.00s cpu, solution 1, maybe more) ? 

isomorphe(arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide))),
	arb_bin(3, arb_bin(6, vide, vide), arb_bin(5, arb_bin(4, vide, vide), arb_bin(7, vide, vide)))).

arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide)))

arb_bin(3, arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide)), arb_bin(4, vide, vide)) 

arb_bin(3, arb_bin(6, vide, vide), arb_bin(5, arb_bin(4, vide, vide), arb_bin(7, vide, vide)))
*/



/*
Question 6 : infixe(+B,-L)
*/


infixe(vide,[]).

infixe(arb_bin(R,G,D),L):-
	infixe(G,L1),
	infixe(D,L2),
	append(L1,[R|L2],L).

/*
[eclipse 26]: infixe(arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide))),R).

R = [6, 2, 1, 4, 3, 5]

*/


/*
Question 7 : insertion_arbre_ordonne(+X,+B1,-B2)
*/


insertion_arbre_ordonne(R,vide,arb_bin(R,vide,vide)).
insertion_arbre_ordonne(R,arb_bin(R,G,D),arb_bin(R,G,D)).
insertion_arbre_ordonne(X,arb_bin(R,G1,D1),arb_bin(R	,G1,D2)):-
	>(X,R),
	insertion_arbre_ordonne(X,D1,D2).

insertion_arbre_ordonne(X,arb_bin(R,G1,D1),arb_bin(R,G2,D1)):-
	<(X,R),
	insertion_arbre_ordonne(X,G1,G2).
	

/*
[eclipse 36]:  insertion_arbre_ordonne(5,arb_bin(8, arb_bin(4, arb_bin(2, vide, vide), arb_bin(6, vide, vide)), arb_bin(12, arb_bin(10, vide, vide), vide)),R).

R = arb_bin(8, arb_bin(4, arb_bin(2, vide, vide), arb_bin(6, arb_bin(5, vide, vide), vide)), arb_bin(12, arb_bin(10, vide, vide), vide))

*/

/*
Question 8 : insertion_arbre_ordonne(+X,+B)

*/

/*
-------------------------------------------------------------------------------
 Tests
-------------------------------------------------------------------------------






*/

% Quelques arbres � copier coller pour vous faire gagner du temps, mais
% n'h�sitez pas � en d�finir d'autres

/*
arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide)))

arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide))

arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, 7, vide))

arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide)))
arb_bin(7, arb_bin(4, vide, vide), arb_bin(7, arb_bin(6, vide, vide), arb_bin(7, vide, vide)))

arb_bin(3, arb_bin(5, arb_bin(6, vide, vide), arb_bin(7, vide, vide)), arb_bin(4, vide, vide)) 

arb_bin(3, arb_bin(6, vide, vide), arb_bin(5, arb_bin(4, vide, vide), arb_bin(7, vide, vide)))

arb_bin(8, arb_bin(4, arb_bin(2, vide, vide), arb_bin(6, vide, vide)), arb_bin(12, arb_bin(10, vide, vide), vide))

arb_bin(8, arb_bin(4, arb_bin(2, _, _), arb_bin(6, _, _)), arb_bin(12, arb_bin(10, _, _), _))

arb_bin(6,arb_bin(2,arb_bin(1,vide,vide),arb_bin(4,vide,vide)),arb_bin(8,vide,arb_bin(10,vide,vide)))

arb_bin(8,arb_bin(2,arb_bin(1,vide,vide),arb_bin(4,vide,vide)),arb_bin(6,vide,arb_bin(10,vide,vide)))

arb_bin(6,arb_bin(2,arb_bin(1,vide,vide),arb_bin(4,vide,vide)),arb_bin(8,arb_bin(2,arb_bin(1,vide,vide),arb_bin(4,vide,vide)),arb_bin(10,vide,vide)))

*/
