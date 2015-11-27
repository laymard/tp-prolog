% Septembre 2012
% TP2 TERMES CONSTRUITS - A compléter et faire tourner sous Eclipse Prolog
% ==============================================================================
% ============================================================================== 
%	FAITS
% ============================================================================== 
/*
	hauteur(Valeur)
*/
hauteur(deux).
hauteur(trois).
hauteur(quatre).
hauteur(cinq).
hauteur(six).
hauteur(sept).
hauteur(huit).
hauteur(neuf).
hauteur(dix).
hauteur(valet).
hauteur(dame).
hauteur(roi).
hauteur(as).

/*
	couleur(Valeur)
*/
couleur(trefle).
couleur(carreau).
couleur(coeur).
couleur(pique).

/*
	succ_hauteur(H1, H2)
*/
succ_hauteur(deux, trois).
succ_hauteur(trois, quatre).
succ_hauteur(quatre, cinq).
succ_hauteur(cinq, six).
succ_hauteur(six, sept).
succ_hauteur(sept, huit).
succ_hauteur(huit, neuf).
succ_hauteur(neuf, dix).
succ_hauteur(dix, valet).
succ_hauteur(valet, dame).
succ_hauteur(dame, roi).
succ_hauteur(roi, as).

/*
	succ_couleur(C1, C2)
*/
succ_couleur(trefle, carreau).
succ_couleur(carreau, coeur).
succ_couleur(coeur, pique).

/*
  carte_test
  cartes pour tester le prédicat EST_CARTE

*/

carte_test(c1,carte(sept,trefle)).
carte_test(c2,carte(neuf,carreau)).
carte_test(ce1,carte(7,trefle)).
carte_test(ce2,carte(sept,t)).

/* 
	main_test(NumeroTest, Main) 
	mains pour tester le prédicat EST_MAIN 
*/

main_test(main_triee_une_paire, main(carte(sept,trefle), carte(valet,coeur), carte(dame,carreau), carte(dame,pique), carte(roi,pique))).
% attention ici m2 représente un ensemble de mains	 
main_test(m2, main(carte(valet,_), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(as,pique))).
main_test(main_triee_deux_paires, main(carte(valet,trefle), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(roi,pique))).
main_test(main_triee_brelan, main(carte(sept,trefle), carte(dame,carreau), carte(dame,coeur), carte(dame,pique), carte(roi,pique))).	
main_test(main_triee_suite,main(carte(sept,trefle),carte(huit,pique),carte(neuf,coeur),carte(dix,carreau),carte(valet,carreau))).
main_test(main_triee_full,main(carte(deux,coeur),carte(deux,pique),carte(quatre,trefle),carte(quatre,coeur),carte(quatre,pique))).

main_test(merreur1, main(carte(sep,trefle), carte(sept,coeur), carte(dame,pique), carte(as,trefle), carte(as,pique))).
main_test(merreur2, main(carte(sep,trefle), carte(sept,coeur), carte(dame,pique), carte(as,trefle))).

% ============================================================================= 
%        QUESTION 1 : est_carte(carte(Hauteur,Couleur))
% ==============================================================================
est_carte(carte(Hauteur,Couleur)) :-  
	hauteur(Hauteur),
	couleur(Couleur).


% ============================================================================= 
%	QUESTION 2 : est_main(main(C1,C2,C3,C4,C5))
% ============================================================================= 
est_main(main(C1,C2,C3,C4,C5)) :- 
	est_carte(C1),
	est_carte(C2),
	est_carte(C3),
	est_carte(C4),
	est_carte(C5),
	\==(C1,C2),
	\==(C1,C3),
	\==(C1,C4),
	\==(C1,C5),
	\==(C2,C3),
	\==(C2,C4),
	\==(C2,C5),
	\==(C3,C4),
	\==(C3,C5),
	\==(C4,C5).
% ==============================================================================
%       QUESTION 3 : inf_carte(C1,C2) première version
% ============================================================================= 
inf_hauteur(Haut1,Haut2) :-
	succ_hauteur(Haut1,Haut2).

inf_hauteur(Haut1,Haut2) :-
	succ_hauteur(Haut1,Haut3),
	inf_hauteur(Haut3,Haut2).

inf_couleur(Coul1,Coul2) :-
	succ_couleur(Coul1,Coul2).

inf_couleur(Coul1,Coul2) :-
	succ_couleur(Coul1,Coul3),
	inf_couleur(Coul3,Coul2).

inf_carte(carte(Haut1,Coul1),carte(Haut2,Coul2)) :-
	est_carte(carte(Haut1,Coul1)),
	est_carte(carte(Haut2,Coul2)),
	inf_hauteur(Haut1,Haut2),
	\==(Haut1,Haut2).
	
inf_carte(carte(Haut1,Coul1),carte(Haut1,Coul2)) :-
	est_carte(carte(Haut1,Coul1)),
	est_carte(carte(Haut1,Coul2)),
	inf_couleur(Coul1,Coul2).
	

% ============================================================================= 
%       QUESTION 3 : inf_carte_b(C1,C2) deuxième version
% ==============================================================================
%?


% ==============================================================================
%       QUESTION 4 : est_main_triee(main(C1,C2,C3,C4,C5))
% ==============================================================================
est_main_triee(main(C1,C2,C3,C4,C5)) :-
	est_main(main(C1,C2,C3,C4,C5)),
	inf_carte(C1,C2),
	inf_carte(C2,C3),
	inf_carte(C3,C4),
	inf_carte(C4,C5).



% ==============================================================================
%       QUESTION 5 : une_paire(main(C1,C2,C3,C4,C5))
% ==============================================================================



% ==============================================================================
%       QUESTION 6 : deux_paires(main(C1,C2,C3,C4,C5))
% ==============================================================================



% ============================================================================= 
%       QUESTION 7 : brelan(main(C1,C2,C3,C4,C5))
% ============================================================================= 




% ============================================================================= 
%       QUESTION 8 : suite(main(C1,C2,C3,C4,C5))
% ==============================================================================



% ============================================================================= 
%       QUESTION 9 : full(main(C1,C2,C3,C4,C5))
% ============================================================================= 





% ==============================================================================

/* TESTS QUESTION 1 : carte_test

est_carte(carte(deux, X)).
X = trefle
Yes (0.00s cpu, solution 1, maybe more)
X = carreau
Yes (0.02s cpu, solution 2, maybe more)
X = coeur
Yes (0.03s cpu, solution 3, maybe more)
X = pique
Yes (0.03s cpu, solution 4)

*/

% ============================================================================= 

/*  TESTS QUESTION 2 : est_main
main_test(merreur1,Y),est_main(Y).
?- main_test(merreur1, Y), est_main(Y).
No (0.00s cpu)

?- main_test(X, Y), est_main(Y).
X = main_triee_une_paire
Y = main(carte(sept, trefle), carte(valet, coeur), carte(dame, carreau), carte(dame, pique), carte(roi, pique))
Yes (0.00s cpu, solution 1, maybe more)
X = m2
Y = main(carte(valet, trefle), carte(valet, coeur), carte(dame, carreau), carte(roi, coeur), carte(as, pique))
Yes (0.01s cpu, solution 2, maybe more)
X = m2
Y = main(carte(valet, carreau), carte(valet, coeur), carte(dame, carreau), carte(roi, coeur), carte(as, pique))
Yes (0.03s cpu, solution 3, maybe more)
X = m2
Y = main(carte(valet, pique), carte(valet, coeur), carte(dame, carreau), carte(roi, coeur), carte(as, pique))
Yes (0.04s cpu, solution 4, maybe more)
X = main_triee_deux_paires
Y = main(carte(valet, trefle), carte(valet, coeur), carte(dame, carreau), carte(roi, coeur), carte(roi, pique))
Yes (0.04s cpu, solution 5, maybe more)
X = main_triee_brelan
Y = main(carte(sept, trefle), carte(dame, carreau), carte(dame, coeur), carte(dame, pique), carte(roi, pique))
Yes (0.08s cpu, solution 6, maybe more)
X = main_triee_suite
Y = main(carte(sept, trefle), carte(huit, pique), carte(neuf, coeur), carte(dix, carreau), carte(valet, carreau))
Yes (0.08s cpu, solution 7, maybe more)
X = main_triee_full
Y = main(carte(deux, coeur), carte(deux, pique), carte(quatre, trefle), carte(quatre, coeur), carte(quatre, pique))
Yes (0.10s cpu, solution 8, maybe more)
No (0.11s cpu)


*/

% ============================================================================= 

/* TESTS QUESTION 3 premiere version

*/

% ==============================================================================

/* TESTS QUESTION 3 deuxieme version

*/

% ==============================================================================

/* TESTS QUESTION 4
?- inf_carte(carte(X, Y), carte(cinq, coeur)).
X = deux
Y = trefle
Yes (0.05s cpu, solution 1, maybe more)
X = deux
Y = carreau
Yes (0.07s cpu, solution 2, maybe more)
X = deux
Y = coeur
Yes (0.07s cpu, solution 3, maybe more)
X = deux
Y = pique
Yes (0.07s cpu, solution 4, maybe more)
X = trois
Y = trefle
Yes (0.08s cpu, solution 5, maybe more)
X = trois
Y = carreau
Yes (0.08s cpu, solution 6, maybe more)
X = trois
Y = coeur
Yes (0.09s cpu, solution 7, maybe more)
X = trois
Y = pique
Yes (0.09s cpu, solution 8, maybe more)
X = quatre
Y = trefle
Yes (0.10s cpu, solution 9, maybe more)
X = quatre
Y = carreau
Yes (0.10s cpu, solution 10, maybe more)
X = quatre
Y = coeur
Yes (0.11s cpu, solution 11, maybe more)
X = quatre
Y = pique
Yes (0.12s cpu, solution 12, maybe more)
X = cinq
Y = trefle
Yes (0.12s cpu, solution 13, maybe more)
X = cinq
Y = carreau
Yes (0.14s cpu, solution 14, maybe more)
No (0.14s cpu)

*/

% ============================================================================= 

/* TESTS QUESTION 5
?- main_test(X, Y), est_main_triee(Y).
X = main_triee_une_paire
Y = main(carte(sept, trefle), carte(valet, coeur), carte(dame, carreau), carte(dame, pique), carte(roi, pique))
Yes (0.00s cpu, solution 1, maybe more)
X = m2
Y = main(carte(valet, trefle), carte(valet, coeur), carte(dame, carreau), carte(roi, coeur), carte(as, pique))
Yes (0.00s cpu, solution 2, maybe more)
X = m2
Y = main(carte(valet, carreau), carte(valet, coeur), carte(dame, carreau), carte(roi, coeur), carte(as, pique))
Yes (0.01s cpu, solution 3, maybe more)
X = main_triee_deux_paires
Y = main(carte(valet, trefle), carte(valet, coeur), carte(dame, carreau), carte(roi, coeur), carte(roi, pique))
Yes (0.01s cpu, solution 4, maybe more)
X = main_triee_brelan
Y = main(carte(sept, trefle), carte(dame, carreau), carte(dame, coeur), carte(dame, pique), carte(roi, pique))
Yes (0.01s cpu, solution 5, maybe more)
X = main_triee_suite
Y = main(carte(sept, trefle), carte(huit, pique), carte(neuf, coeur), carte(dix, carreau), carte(valet, carreau))
Yes (0.01s cpu, solution 6, maybe more)
X = main_triee_full
Y = main(carte(deux, coeur), carte(deux, pique), carte(quatre, trefle), carte(quatre, coeur), carte(quatre, pique))
Yes (0.01s cpu, solution 7, maybe more)
No (0.02s cpu)

*/

% ==============================================================================

/* TESTS QUESTION 6


*/

% ==============================================================================


/* TESTS QUESTION 7


*/

% ==============================================================================

/* TESTS QUESTION 8


*/

% ============================================================================= 

/* TESTS QUESTION 9


*/
