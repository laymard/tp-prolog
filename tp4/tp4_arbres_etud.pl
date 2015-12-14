/**
TP 4 Arbres binaires - Prolog

@author Laurent AYMRAD
@author Blandine SEZNEC
@version Annee scolaire 20__/20__
*/


/*
-------------------------------------------------------------------------------
 Définition des prédicats
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
Question 2: dans_arbre_binaire(+E,+B) : vérifie si est l'une des étiquettes de l'abre binaire B  
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
Question 4 : sous_arbre_binaire(+S,+B) : vérifie sir S est un sous arbre de B
*/

sous_arbre_binaire(S,B) :-
	ss_ab(S,S,B).

ss_ab(vide,_,_).

ss_ab(arb_bin(R,G1,D1), S, arb_bin(R,G2,D2)):-
	ss_ab(G1,S,G2),
	ss_ab(D1,S,D2).

ss_ab(arb_bin(R1,_,_), S, arb_bin(R2,G,D)):-
	\==(R1,R2),
	ss_ab(S, S, arb_bin(R2,G,D)).

ss_ab(arb_bin(R1,G1,D1),arb_bin(R1,G1,D1),arb_bin(R,G,D)):-
	\==(R1,R),
	ss_ab(arb_bin(R1,G1,D1),arb_bin(R1,G1,D1),G),
	ss_ab(arb_bin(R1,G1,D1),arb_bin(R1,G1,D1),D).
	
/*

Cas de test vrai : 
sous_arbre_binaire(arb_bin(5,vide,vide),arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide)))).
[eclipse 54]: sous_arbre_binaire(arb_bin(5,vide,vide),arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide)))).

Yes (0.00s cpu, solution 1, maybe more) ?

sous_arbre_binaire(arb_bin(11,vide,vide),arb_bin(1, arb_bin(2, arb_bin(6, vide, vide), vide), arb_bin(3, arb_bin(4, vide, vide), arb_bin(5, vide, vide)))).

*/
	

/*
-------------------------------------------------------------------------------
 Tests
-------------------------------------------------------------------------------
*/

% Quelques arbres à copier coller pour vous faire gagner du temps, mais
% n'hésitez pas à en définir d'autres

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
