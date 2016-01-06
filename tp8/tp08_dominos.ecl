% TP8 Laurent AMYARD et Blandine SEZNEC


% choose(+, -, -): 'a list * 'a * 'a list


choose(L,E,R):-
	append(Pg,[E|Pd],L),
	append(Pg,Pd,R).



stones([stone(2, 2), stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]).

s_double([stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2)]).

% stones([stone(2, 2), stone(4, 6), stone(1, 2), stone(2, 4), stone(6, 2), stone(5, 1), stone(5, 5), stone(4, 5), stone(2, 3), stone(3, 6)]).
% stones([stone(6, 6), stone(6, 5), stone(6, 4), stone(6, 3), stone(6, 2), stone(6, 1), stone(6, 0),
%         stone(5, 5), stone(5, 4), stone(5, 3), stone(5, 2), stone(5, 1), stone(5, 0),
%         stone(4, 4), stone(4, 3), stone(4, 2), stone(4, 1), stone(4, 0),
%         stone(3, 3), stone(3, 2), stone(3, 1), stone(3, 0),
%         stone(2, 2), stone(2, 1), stone(2, 0),
%         stone(1, 1), stone(1, 0),
%         stone(0, 0)]).


%chains(+,+,-)

chains([],R,R).

chains(S,Acc,Res):-
	choose(S,stone(X,Y),R),
	choose(Acc,Ch,R2),
	poser(stone(X,Y),Ch,Res2),
	chains(R,[Res2|R2],Res).

poser(stone(X,Y),chain([X|L1],L2),chain(R1,L2)):-
	\==(X,Y),
	append([Y],[X|L1],R1).
	
poser(stone(X,Y),chain([Y|L1],L2),chain(R1,L2)):-
	\==(X,Y),
	append([X],[Y|L1],R1).

poser(stone(X,Y),chain(L1,[X|L2]),chain(L1,R2)):-
	\==(X,Y),
	append([Y],[X|L2],R2).
	
poser(stone(X,Y),chain(L1,[Y|L2]),chain(L1,R2)):-
	\==(X,Y),
	append([X],[Y|L2],R2).




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
