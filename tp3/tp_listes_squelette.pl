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

/*probleme à partir de la deuxieme occurence de A*/
compte(A,X,N) :-
	compteur(A,X,0,N).

compteur(_,[],Res,Res).

compteur(A,[A|Y],N,Res) :-
	compteur(A,Y,M,Res),
	M is N+1.

compteur(A,[X|Y],N,Res) :-
	compteur(A,Y,N,Res),
	\==(X,A).

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

/* palind(+X) : X est une liste palindrome */

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

nieme([X|_],0,X).

nieme([],Res,Res).

nieme([_|L],N,R):-
	nieme(L,M,R),
	M is N+1.



