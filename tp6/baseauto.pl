/**
TP 7 Base de Données Déductives (BDD) - Prolog

@author Prenom1 NOM1
@author Prenom2 NOM2
@version Annee scolaire 20__/20__
*/


/*
===============================================================================
===============================================================================
 Définition des prédicats
===============================================================================
*/
% ============================================================================= 
% SECTION 1 : Base de données
% ============================================================================= 

assemblage(voiture, porte, 4).
assemblage(voiture, roue, 4).
assemblage(voiture, moteur, 1).
assemblage(roue, jante, 1).
assemblage(porte, tole, 1).
assemblage(porte, vitre, 1).
assemblage(roue, pneu, 1).
assemblage(moteur, piston, 4).
assemblage(moteur, soupape, 16).

           
piece(p1, tole, lyon).
piece(p2, jante, lyon).
piece(p3, jante, marseille).
piece(p4, pneu, clermontFerrand).
piece(p5, piston, toulouse).
piece(p6, soupape, lille).
piece(p7, vitre, nancy).
piece(p8, tole, marseille).
piece(p9, vitre, marseille).

                  
demandeFournisseur(dupont, lyon).
demandeFournisseur(michel, clermontFerrand).
demandeFournisseur(durand, lille).
demandeFournisseur(dupond, lille).
demandeFournisseur(martin, rennes).
demandeFournisseur(smith, paris).
demandeFournisseur(brown, marseille).
          
          
fournisseurReference(f1, dupont, lyon).
fournisseurReference(f2, durand, lille).
fournisseurReference(f3, martin, rennes).
fournisseurReference(f4, michel, clermontFerrand).
fournisseurReference(f5, smith, paris).
fournisseurReference(f6, brown, marseille).

                  
livraison(f1, p1, 300).
livraison(f2, p2, 200).
livraison(f3, p3, 200).
livraison(f4, p4, 400).
livraison(f6, p5, 500).
livraison(f6, p6, 1000).
livraison(f6, p7, 300).
livraison(f1, p2, 300).
livraison(f4, p2, 300).
livraison(f4, p1, 300).


% ============================================================================= 
% SECTION 2 : Opération relationnelles
% ============================================================================= 

% Q2.1) pièce fabriquées à Lyon : 
?-piece(X,Y,lyon).

% Q2.2) noms et origine pièce

?-piece(_,N,L).

% Q2.3) 

% union (morche pos)

union(X,Y):-
	demandeFournisseur(X,Y);
	demandeFournisseur(A,B),
	fournisseurReference(_,X,Y),
	\==(X,A),
	\==(Y,B).


% intersection

?-demandeFournisseur(X, Y),fournisseurReference(_, X, Y).

% différence

difference(X,Y):-
	demandeFournisseur(X,Y),
	fournisseurReference(_,A,B),
	\==(X,A),	
	\==(Y,B).
difference(X,Y):-
	fournisseurReference(_,X,Y),
	demandeFournisseur(A,B),
	\==(X,A),	
	\==(Y,B).

%2.4)

pcart(F1,Nom,Ville,F2,P,Q):-
	fournisseurReference(F1,Nom,Ville),
	livraison(F2,P,Q).


% Q2.5)

joint1(N,Nom,Ville,P,Q):-
	fournisseurReference(N,Nom,Ville),
	livraison(N,P,Q).

joint2(N,Nom,Ville,P,Q):-
	joint1(N,Nom,Ville,P,Q),
	Q>350.


% Q2.6)

division(F):-
	livraison(F,P,_),
	piece(P,_,lyon).


% Q2.7)

total(F,R):-
	livraison(F,_,_),
	findall(X,livraison(F,P,X),L),
	myadd(L,R).


myadd([],0).



myadd([H|L],R):-
	add(L,Q),
	R is Q + H.


% ============================================================================= 
% SECTION 3 : Au delà de l’algèbre relationnelle
% ============================================================================= 

%Q3.1)

composant(P,L):-
	assemblage(P,X),
	composant(X,[X|L]).

composant(P,L):-
	assemblage(P,L).





/*
===============================================================================
===============================================================================
 Tests
===============================================================================


---------------------------------------
Q2.1 : 
[eclipse 2]: piece(X,Y,lyon).

X = p1
Y = tole
Yes (0.00s cpu, solution 1, maybe more) ? ;

X = p2
Y = jante
Yes (0.00s cpu, solution 2)

---------------------------------------
Q2.2 : 
[eclipse 3]: piece(_,N,L).

N = tole
L = lyon
Yes (0.00s cpu, solution 1, maybe more) ? ;

N = jante
L = lyon
Yes (0.00s cpu, solution 2, maybe more) ? ;

N = jante
L = marseille
Yes (0.00s cpu, solution 3, maybe more) ? ;

N = pneu
L = clermontFerrand
Yes (0.00s cpu, solution 4, maybe more) ? ;

N = piston
L = toulouse
Yes (0.00s cpu, solution 5, maybe more) ? ;

N = soupape
L = lille
Yes (0.00s cpu, solution 6, maybe more) ? ;

N = vitre
L = nancy
Yes (0.00s cpu, solution 7, maybe more) ? ;

N = tole
L = marseille
Yes (0.00s cpu, solution 8, maybe more) ? ;

N = vitre
L = marseille
Yes (0.00s cpu, solution 9)
-------------------------------------------
Q2.3)


intersection : 
[eclipse 6]: demandeFournisseur(X, Y),fournisseurReference(_, X, Y).

X = dupont
Y = lyon
Yes (0.00s cpu, solution 1, maybe more) ? ;

X = michel
Y = clermontFerrand
Yes (0.00s cpu, solution 2, maybe more) ? ;

X = durand
Y = lille
Yes (0.00s cpu, solution 3, maybe more) ? ;

X = martin
Y = rennes
Yes (0.00s cpu, solution 4, maybe more) ? ;

X = smith
Y = paris
Yes (0.01s cpu, solution 5, maybe more) ? ;

X = brown
Y = marseille
Yes (0.01s cpu, solution 6)

------------------------------------------
Q2.4)
[eclipse 33]: pcart(F1,Nom,Ville,F2,P,Q).

F1 = f1
Nom = dupont
Ville = lyon
F2 = f1
P = p1
Q = 300
Yes (0.00s cpu, solution 1, maybe more) ? ;

F1 = f1
Nom = dupont
Ville = lyon
F2 = f2
P = p2
Q = 200
Yes (0.00s cpu, solution 2, maybe more) ? ;

F1 = f1
Nom = dupont
Ville = lyon
F2 = f3
P = p3
Q = 200
Yes (0.00s cpu, solution 3, maybe more) ? ;

F1 = f1
Nom = dupont
Ville = lyon
F2 = f4
P = p4
Q = 400
Yes (0.00s cpu, solution 4, maybe more) ? ;

F1 = f1
Nom = dupont
Ville = lyon
F2 = f6
P = p5
Q = 500
Yes (0.00s cpu, solution 5, maybe more) ? ;

F1 = f1
Nom = dupont
Ville = lyon
F2 = f6
P = p6
Q = 1000
Yes (0.01s cpu, solution 6, maybe more) ? ;

F1 = f1
Nom = dupont
Ville = lyon
F2 = f6
P = p7
Q = 300
Yes (0.01s cpu, solution 7, maybe more) ? ;

F1 = f1
Nom = dupont
Ville = lyon
F2 = f1
P = p2
Q = 300
Yes (0.01s cpu, solution 8, maybe more) ? ;

F1 = f1
Nom = dupont
Ville = lyon
F2 = f4
P = p2
Q = 300
Yes (0.01s cpu, solution 9, maybe more) ? ;

F1 = f1
Nom = dupont
Ville = lyon
F2 = f4
P = p1
Q = 300
Yes (0.01s cpu, solution 10, maybe more) ? ;

F1 = f2
Nom = durand
Ville = lille
F2 = f1
P = p1
Q = 300
Yes (0.01s cpu, solution 11, maybe more) ? ;

F1 = f2
Nom = durand
Ville = lille
F2 = f2
P = p2
Q = 200

etc....


-----------------------------------------
Q2.5)
[eclipse 30]: joint1(N,Nom,Ville,P,Q).

N = f1
Nom = dupont
Ville = lyon
P = p1
Q = 300
Yes (0.00s cpu, solution 1, maybe more) ? ;

N = f1
Nom = dupont
Ville = lyon
P = p2
Q = 300
Yes (0.00s cpu, solution 2, maybe more) ? ;

N = f2
Nom = durand
Ville = lille
P = p2
Q = 200
Yes (0.00s cpu, solution 3, maybe more) ? ;

N = f3
Nom = martin
Ville = rennes
P = p3
Q = 200
Yes (0.00s cpu, solution 4, maybe more) ? ;

N = f4
Nom = michel
Ville = clermontFerrand
P = p4
Q = 400

etc...

[eclipse 31]: joint1(f6,Nom,Ville,Piece,Qt).

Nom = brown
Ville = marseille
Piece = p5
Qt = 500
Yes (0.00s cpu, solution 1, maybe more) ? ;

Nom = brown
Ville = marseille
Piece = p6
Qt = 1000
Yes (0.00s cpu, solution 2, maybe more) ? ;

Nom = brown
Ville = marseille
Piece = p7
Qt = 300
Yes (0.00s cpu, solution 3)




Yes (0.01s cpu)
[eclipse 35]: joint2(N,Nom,Ville,P,Q).

N = f4
Nom = michel
Ville = clermontFerrand
P = p4
Q = 400
Yes (0.00s cpu, solution 1, maybe more) ? ;

N = f6
Nom = brown
Ville = marseille
P = p5
Q = 500
Yes (0.00s cpu, solution 2, maybe more) ? ;

N = f6
Nom = brown
Ville = marseille
P = p6
Q = 1000
Yes (0.00s cpu, solution 3, maybe more) ? ;

No (0.00s cpu)

------------------------------------------------------





*/

