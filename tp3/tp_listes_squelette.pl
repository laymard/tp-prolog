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

/* conc3(+X,+Y,+Z,?T) : T est la concaténation de X|Y|Z */



conc3([X|W],Y,Z,[X|Reste]):-
	conc3(W,Y,Z,Reste).


conc3([],[X|Y],Z,[X|Reste]):-
	conc3([],Y,Z,Reste).

conc3([],[],Z,Z).

/*Test

[eclipse 47]: ?-conc3([1,2,3],[4,5,6],[7,8,9],N).

N = [1, 2, 3, 4, 5, 6, 7, 8, 9]
*/

/* conc2 pour le délire */

conc2([],Y,Y).

conc2([H|X],Y,[H|R]):-
	conc2(X,Y,R).

/*debute_par(+X,?Y) : la liste X débute par la liste Y*/

debute_par([H|X],[H|Y]):-
	debute_par(X,Y).

debute_par(X,[]).
debute_par([],[]).

/* TEST

[eclipse 49]: debute_par([1,2,3],[1,2]).

Yes (0.00s cpu, solution 1, maybe more) ?
[eclipse 50]: debute_par([1,2,3],[2,1]).

No (0.00s cpu)
*/

/*sous_liste(+X,?Y) : la liste Y est une sous-liste de X*/


sous_liste(X,Y):-
	sous_liste2(X,Y,Y).

sous_liste2(X,[],Z).
sous_liste2([],[],Z).

sous_liste2([H|X],[T|Y],Z):-
	\==(H,T),
	sous_liste2([H|X],Z,Z).

sous_liste2([H|X],[H|Y],Z):-
	sous_liste2(X,Y,Z).
/*test
[eclipse 2]: sous_liste([1,2,1,2,1,3],[1,2,3]).
*** Overflow of the local/control stack!
You can use the "-l kBytes" (LOCALSIZE) option to have a larger stack.
Peak sizes were: local stack 2984 kbytes, control stack 37080 kbytes
Abort
[eclipse 3]: sous_liste([1,2,1,2,3],[1,2,3]).

Yes (0.00s cpu, solution 1, maybe more) ?
*/

/*elim(X,Y) : la liste Y contient une seule instance de chaque nombre de X : [1,1] => [1]*/

elim([],Y).
elim([X],[X]).
elim([H|X],Y):-
	membre(H,Y),
	elim(X,Y).
elim([H|X],Y):-
	elim(X,[H|Y]).

/*TEST
[eclipse 6]: elim([1,1],Y).

Y = [1]
Yes (0.00s cpu, solution 1, maybe more) ?
[eclipse 7]: elim([1,2],Y).

Y = [1, 2|_178]
Yes (0.00s cpu, solution 1, maybe more) ?
[eclipse 8]: elim([1,2,1],Y).

Y = [1, 2|_180]
Yes (0.00s cpu, solution 1, maybe more) ?
*/

/* tri(X,Y) */

tri(X, Y):-
	trier(X, Y, []).
trier([], Acc, Acc).
trier([X|R], Y, Acc):-
	inserer(X, Acc, NewAcc),
	trier(R, Y, NewAcc).

inserer(E, [], [E]).
inserer(E, [P|R], [E,P|R]):-
	E =< P.
inserer(E, [P|R], [P|Z]):-
	E > P,
	inserer(E, R, Z).

/*TEST

[eclipse 39]: tri([3,2,1],Y).

Y = [1, 2, 3]
*/

/*inclus(X,Y) : tout les éléments de X sont membres de Y*/

inclus([],Y).

inclus([H|X],Y):-
	membre(H,Y),
	inclus(X,Y).

/*TEST
Yes (0.02s cpu)
[eclipse 41]: inclus([2,3],[1,2,3]).

Yes (0.00s cpu, solution 1, maybe more) ?
[eclipse 42]: inclus([4,5],[1,2,3]).

No (0.00s cpu)
*/

/*non_inclus(X,Y) : au moins un élément n'est pas membre de Y '*/

non_inclus([H|X],Y):-
	hors_de(H,Y).

non_inclus([H|X],Y):-
	membre(H,Y),
	non_inclus(X,Y).

/*TEST
[eclipse 44]: non_inclus([1,2],[1,2,3]).

No (0.00s cpu)
[eclipse 45]: non_inclus([2,4],[1,2,3]).

Yes (0.00s cpu, solution 1, maybe more) ?
[eclipse 46]: non_inclus([4,5],[1,2,3]).

Yes (0.00s cpu, solution 1, maybe more) ?
*/

/*union_ens(X,Y,Z) : Z est l'union ensembliste de X et de Y  '*/

union_ens(X,Y,Z):-
	union_ens2(X,Y,A,Z).


union_ens2([],[],A,A).
union_ens2([H|X],Y,A,Z):-
	membre(H,Y),
	hors_de(H,A),
	union_ens2(X,Y,[H|A],Z).

union_ens2([H|X],Y,A,Z):-
	hors_de(H,Y),
	union_ens2(X,Y,A,Z).

union_ens2([],[H|Y],A,Z):-
	membre(H,A),
	union_ens2([],Y,A,Z).

union_ens2([],[H|Y],A,Z):-
	hors_de(H,A),
	union_ens2([],Y,[H|A],Z).

/*TEST
[eclipse 61]: union_ens([1,2,3],[1,2],L).

L = [2, 1]
Yes (0.00s cpu, solution 1, maybe more) ?
[eclipse 62]: union([1,2],[3],L).

L = [1, 2, 3]
Yes (0.00s cpu)
*/
