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
	
	

% dana likes cody
% bess does not like dana
% cody does not like abby
% nobody likes someone who does not like her
% abby likes everyone who likes bess
% dana likes everyone bess likes
% everybody likes somebody

people([abby, bess, cody, dana]).

% Questions 1.6 and 1.7
test_possible_worlds :-
        possible_worlds(World),
        writeln(World),
        fail.
