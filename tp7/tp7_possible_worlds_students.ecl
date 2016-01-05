%TP7
%Laurent AYMARD & Blandine SEZNEC

%Q1.1 : make_all_pairs(+,-) :'a list * likes ('a, 'a) list


make_all_pairs([],[]).

make_all_pairs([H],[likes(H,H)]).

make_all_pairs([H|T],Res):-
	mk2(H,[H|T],[H|T],T,[],Res).

mk2(E,[H|T],L,L2,Acc,Res):-
	mk2(E,T,L ,L2,[likes(E,H)|Acc],Res).

mk2(E,[],L,[H|T],Acc,Res):-
	mk2(H,L,L,T,Acc,Res).

mk2(_,[],_,[],Acc,Acc).

%Q1.2 sub_list(+,-) : 'a list * 'a list

sub_list([],[]).

sub_list([Elem|Rest],[Elem|Res]):-
	sub_list(Rest,Res).

sub_list([_|Rest],Res):-
	sub_list(Rest,Res).



% dana likes cody

prop1(L):-
	member(likes(dana,cody),L).

% bess does not like dana
prop2(L):-
	not(member(likes(bess,dana),L)).

% cody does not like abby

prop3(L):-
	not(member(likes(cody,abby),L)).


% nobody likes someone who does not like her

prop4(ListeLikes) :-
	pr4(ListeLikes,ListeLikes).

pr4([likes(X,Y)|Reste],ListeLikes) :-
	member(likes(Y,X),ListeLikes),
	pr4(Reste,ListeLikes).

pr4([],_).


% abby likes everyone who likes bess
prop5(ListeLikes) :-
	pr5(ListeLikes,ListeLikes).

pr5([],_).

pr5([likes(X,bess)|Reste],ListeLikes) :-
	member(likes(abby,X),ListeLikes),
	pr5(Reste,ListeLikes).

pr5([likes(_,Y)|Reste],ListeLikes) :-
	\==(Y,bess),
	pr5(Reste,ListeLikes).

% dana likes everyone bess likes

prop6(ListeLikes) :-
	pr6(ListeLikes,ListeLikes).

pr6([],_).

pr6([likes(bess,X)|Reste],ListeLikes) :-
	member(likes(dana,X),ListeLikes),
	pr6(Reste,ListeLikes).

pr6([likes(Y,_)|Reste],ListeLikes) :-
	\==(Y,bess),
	pr6(Reste,ListeLikes).


% everybody likes somebody

prop7(ListeLikes) :-
        people(ListePersonnes),
        pr7(ListePersonnes,ListeLikes).

pr7([],_).

pr7([Personne|RestePersonne],ListeLikes) :-
        member(likes(Personne,_),ListeLikes),
        prop7(RestePersonne,ListeLikes),
        !.

people([abby, bess, cody, dana]).


%possible_worlds(-) : likes('a, 'a) list

possible_worlds(Monde) :-
        people(ListePersonnes),
        make_all_pairs(ListePersonnes,ListePaires),
        sub_list(ListePaires,Monde),
        prop1(Monde),
        prop2(Monde),
        prop3(Monde),
        prop4(Monde),
        prop5(Monde),
        prop6(Monde),
        prop7(Monde).

% Questions 1.6 and 1.7
test_possible_worlds :-
        possible_worlds(World),
        writeln(World),
        fail.
