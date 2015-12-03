/**
TP Listes Prolog

@author Prenom1 NOM1
@author Prenom2 NOM2
@version Annee scolaire 20__/20__

% ==============================================================================
% ==============================================================================
%	QUESTION 1
% ==============================================================================
/* membre(?A,+X) : A est élément de X */

membre(A,[A|_]).

membre(A,[X|Y]) :-
	membre(A,Y),
	\==(X,A).
/*
TEST
?- membre(X, [1, 2, 3, 4, 5]).
X = 1
Yes (0.00s cpu, solution 1, maybe more)
X = 2
Yes (0.02s cpu, solution 2, maybe more)
X = 3
Yes (0.02s cpu, solution 3, maybe more)
X = 4
Yes (0.03s cpu, solution 4, maybe more)
X = 5
Yes (0.03s cpu, solution 5, maybe more)
No (0.04s cpu)
*/

/* compte(+A,+X,?N) : N est le nombre d'occurences de A dans la liste X. */

compte(A,X,N) :-
	compter(A,X,0,N).

compter(A,[],C,C).

compter(A,[A|Y],C,N):-
	D is C+1,
	compter(A,Y,D,N).

compter(A,[X|Y],C,N):-
	\==(A,X),
	compter(A,Y,C,N).

/* TEST
[eclipse 33]: ?-compte(1,[1,2],N).

N = 1
Yes (0.00s cpu, solution 1, maybe more) ?
[eclipse 34]: ?-compte(1,[1,1],N).

N = 2
Yes (0.00s cpu, solution 1, maybe more) ?
[eclipse 35]: ?-compte(1,[2,2],N).

N = 0
Yes (0.00s cpu)
*/

/* renverser(+X,?Y) : Y est la liste à l'envers de X */

renverser(X,Y) :- renverseur(X,[],Y).

renverseur([],Res,Res).

renverseur([A|Y],L,Res) :-
	renverseur(Y,[A|L],Res).

/* TEST

?- renverser([1, 2, 3, 4, 5], Y).
Y = [5, 4, 3, 2, 1]
Yes (0.00s cpu)

?- renverser([2], Y).
Y = [2]
Yes (0.00s cpu)

?- renverser([], Y).
Y = []
Yes (0.00s cpu)

*/

/* palindrome(+X) : X est une liste palindrome */

ote_dernier([A],[],A).

ote_dernier([_|X],[_|Y],Res) :-
	ote_dernier(X,Y,Res).

palindrome([A,A]).
palindrome([A]).

palindrome([Prem|X]):-
	ote_dernier(X,_,Prem).

/* TEST
?- palindrome([1, 2, 3, 2, 1]).
Yes (0.00s cpu, solution 1, maybe more)
No (0.01s cpu)

?- palindrome([1, 2, 2, 1]).
Yes (0.00s cpu, solution 1, maybe more)
No (0.02s cpu)

?- palindrome([1]).
Yes (0.00s cpu, solution 1, maybe more)
No (0.02s cpu)

*/

/* nieme(+X,+N,-A) : A est l'élément de rang N dans la liste X. */


nieme([X|_],Res,Res).

nieme([_|L],N,R):-
	nieme(L,M,R),
	M is N+1.

/* TEST
?- nieme([0, 1, 2, 3, 4, 5], 0, X).
X = 0
Yes (0.00s cpu, solution 1, maybe more)
?- nieme([0, 1, 2, 3, 4, 5], 1, X).
X = 1
Yes (0.00s cpu, solution 1, maybe more)
?- nieme([0, 1, 2, 3, 4, 5], 2, X).
X = 2
Yes (0.00s cpu, solution 1, maybe more)
?- nieme([0, 1, 2, 3, 4, 5], 3, X).
X = 3
Yes (0.00s cpu, solution 1, maybe more)

?- nieme([], 0, X).
No (0.00s cpu)
*/

/* hors_de(+A,+X) : A n'appartient pas à la liste X. */

hors_de(A,[]).

hors_de(A,[X|L]):-
	\==(A,X),
	hors_de(A,L).

/* TEST?- hors_de(1, [1, 2, 4, 5]).
No (0.00s cpu)
?- hors_de(3, [1, 2, 4, 5]).
Yes (0.00s cpu)
*/

/* tous_diff(+X) : les éléments de la liste X sont tous différents. */

tous_diff([_]).

tous_diff([A|L]):-
	hors_de(A,L),
	tous_diff(L).

/* TEST
?- tous_diff([1, 2, 3, 4, 5]).
Yes (0.00s cpu, solution 1, maybe more)
?- tous_diff([1, 3, 3, 4, 5]).
No (0.00s cpu)
?- tous_diff([3]).
Yes (0.00s cpu, solution 1, maybe more)
?- tous_diff([3, 3]).
No (0.00s cpu)
?- tous_diff([]).
No (0.00s cpu)
*/
