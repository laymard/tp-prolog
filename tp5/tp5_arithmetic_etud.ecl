% ==============================================================================
%	QUESTION 1.1
% ==============================================================================

add(zero,X,X).

add(s(X),Y,s(S)):-
	add(X,Y,S).

% ==============================================================================
%	QUESTION 1.2
% ==============================================================================

sub(X,Y,Z) :-
	add(Z,Y,X).

% ==============================================================================
%	QUESTION 1.3
% ==============================================================================

prod(zero,Y,zero).

prod(s(X),Y,S):-
	prod(X,Y,R),
	add(Y,R,S).
	
% ==============================================================================
%	QUESTION 1.4
% ==============================================================================

fact(zero,s(zero)).

fact(s(X),S):-
	fact(X,R),
	prod(R,s(X),S).

% ==============================================================================
%	QUESTION 2.1
% ==============================================================================

add_l(L1,L2,Res):-
	add_ret(L1,L2,0,Res).

add_ret([],L,0,L).

add_ret(L,[],0,L).

add_ret(L,[],1,Res):-
	add_ret(L,[1],0,Res).
	
add_ret([],L,1,Res):-
	add_ret(L,[1],0,Res).

add_ret([F1|L1],[F2|L2],Cin,[H|Res]):-
	add_bit(F1,F2,Cin,H,Cout),
	add_ret(L1,L2,Cout,Res).

% ==============================================================================
%	QUESTION 2.2
% ==============================================================================

sub_bin(X,Y,Z) :- 
	add_bin(Z,Y,X).
	
% ==============================================================================
%	QUESTION 2.3
% ==============================================================================

prod_bit(_,0,[]).
prod_bit(0,_,[]).
prod_bit(X,1,X).
prod_bit(1,X,X).

prod_l(X,[],[]).
prod_l([],X,[]).

prod_l([H|X],Y,Res):-
	prod_bit(H,Y,Res1),
	prod_l(Y,X,Res2),
	add_l(Res1,[0|Res2],Res).
	
% ==============================================================================
%	QUESTION 2.4
% ==============================================================================

fact_l([],[1]).

fact_l(Z,S):-
	add_l([1],X,Z), % Z = X+1
	fact_l(X,R),
	prod_l(R,Z,S).

% ==============================================================================
%	QUESTION 3.1
% ==============================================================================


%%%%%%%%%%% Binary representation
add_bit(0, 0, 0, 0, 0).
add_bit(0, 0, 1, 1, 0).
add_bit(0, 1, 0, 1, 0).
add_bit(0, 1, 1, 0, 1).
add_bit(1, 0, 0, 1, 0).
add_bit(1, 0, 1, 0, 1).
add_bit(1, 1, 0, 0, 1).
add_bit(1, 1, 1, 1, 1).

sub_bit(0, 0, 0, 0, 0).
sub_bit(0, 0, 1, 1, 1).
sub_bit(0, 1, 0, 1, 1).
sub_bit(0, 1, 1, 0, 1).
sub_bit(1, 0, 0, 1, 0).
sub_bit(1, 0, 1, 0, 0).
sub_bit(1, 1, 0, 0, 0).
sub_bit(1, 1, 1, 1, 1).

%%%%%%%%%%% Optional part
evaluate_numbers(N1, M1, N2, M2) :-
        evaluate(N1, N2),
        evaluate(M1, M2),
        number(N2),
        number(M2).        

evaluate(N, N) :- number(N).

evaluate(add(N1, M1), N) :-
        evaluate_numbers(N1, M1, N2, M2),
        N is N2 + M2.

evaluate(sub(N1, M1), N) :-
        evaluate_numbers(N1, M1, N2, M2),
        N is N2 - M2.

evaluate(prod(N1, M1), N) :-
        evaluate_numbers(N1, M1, N2, M2),
        N is N2 * M2.

evaluate(eq(N1, M1), Res) :-
        evaluate_numbers(N1, M1, N2, M2),
        (
            N2 = M2, Res = t
        ;
            N2 \= M2, Res = f
        ).

evaluate(fun(X, Body), fun(X, Body)).


fresh_variables(Expr, Res) :-
       fresh_variables(Expr, [], Res).

fresh_variables(X, Assoc, Y) :-
        var(X),
        !,
        assoc(X, Assoc, Y).

fresh_variables(add(X1, Y1), Assoc, add(X2, Y2)) :-
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(prod(X1, Y1), Assoc, prod(X2, Y2)) :-
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(sub(X1, Y1), Assoc, sub(X2, Y2)) :-
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(eq(X1, Y1), Assoc, eq(X2, Y2)) :-
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(if(Cond1, X1, Y1), Assoc, if(Cond2, X2, Y2)) :-
        fresh_variables(Cond1, Assoc, Cond2),
        fresh_variables(X1, Assoc, X2),
        fresh_variables(Y1, Assoc, Y2).

fresh_variables(Number, _, Number) :- number(Number).

fresh_variables(fun(X, Body1), Assoc, fun(Y, Body2)) :-
        fresh_variables(Body1, [(X, Y) | Assoc], Body2).

fresh_variables(apply(Fun1, Param1), Assoc, apply(Fun2, Param2)) :-
        fresh_variables(Fun1, Assoc, Fun2),
        fresh_variables(Param1, Assoc, Param2).
        
%Fun = fun(N, fun(F, if(eq(N, 0), 1, prod(N, apply(apply(F, sub(N, 1)), F))))), Factorial = fun(N, apply(apply(Fun, N), Fun)), evaluate(apply(Factorial, 42), Res).

/*Tests*/

/* Question 1.1
[eclipse 22]: add(s(zero),zero,S).

S = s(zero)
Yes (0.00s cpu)
[eclipse 23]: add(s(s(s(zero))),s(zero),S).    

S = s(s(s(s(zero))))
Yes (0.00s cpu) 

Question 1.2

[eclipse 30]: sub(s(s(zero)), zero, S).

S = s(s(zero))
Yes (0.00s cpu)
[eclipse 31]: sub(s(zero),s(zero),S).

S = zero
Yes (0.00s cpu)
[eclipse 32]: sub(s(s(s(zero))),s(s(zero)),S).            

S = s(zero)
Yes (0.00s cpu)
[eclipse 33]: s(zero,s(zero),S).
calling an undefined procedure s(zero, s(zero), S) in module eclipse
Abort

Question 1.3
[eclipse 35]: prod(s(zero),s(zero),S).

S = s(zero)
Yes (0.00s cpu)
[eclipse 36]: prod(s(s(zero)),s(s(s(zero))),S).

S = s(s(s(s(s(s(zero))))))
Yes (0.00s cpu)


Question 1.4

[eclipse 46]: fact(s(s(zero)),S).

S = s(s(zero))
Yes (0.00s cpu)
[eclipse 47]: fact(s(s(s(zero))),S).

S = s(s(s(s(s(s(zero))))))
Yes (0.01s cpu)

Question 2.1

?- add_l([1], [0, 0, 1, 1], Sum).
Sum = [1, 0, 1, 1]
Yes (0.00s cpu, solution 1, maybe more)

?- add_l([1], [1, 1, 1, 0], Sum).
Sum = [0, 0, 0, 1]
Yes (0.00s cpu, solution 1, maybe more)


?- add_l([1, 0, 1, 0], [1, 1, 0, 0], Sum).
Sum = [0, 0, 0, 1]
Yes (0.00s cpu, solution 1, maybe more)

?- add_l([], [], Sum).
Sum = []
Yes (0.00s cpu, solution 1, maybe more)

Question 2.2

?- sub_l([1, 1, 1, 1], [], Sum).
Sum = [1, 1, 1, 1]
Yes (0.00s cpu, solution 1, maybe more)
?- sub_l([1, 1, 1, 1], [1], Sum).
Sum = [0, 1, 1, 1]
Yes (0.00s cpu, solution 1, maybe more)
?- sub_l([1, 1, 1, 1], [1, 1], Sum).
Sum = [0, 0, 1, 1]
Yes (0.00s cpu, solution 1, maybe more)

Question 2.3

?- prod_l([0, 1, 0, 0], [1, 1, 0, 0], Res).
Res = [0, 1, 1, 0, 0, 0, 0]
Yes (0.00s cpu, solution 1, maybe more)

?- prod_l([0, 1], [1, 1, 1, 1], Res).
Res = [0, 1, 1, 1, 1]
Yes (0.00s cpu, solution 1, maybe more)

?- prod_l([], [1, 1], Res).
Res = []
Yes (0.00s cpu)

Question 2.4

?- fact_l([1], Res).
Res = [1]
Yes (0.00s cpu, solution 1, maybe more)

?- fact_l([1, 1], Res).
Res = [0, 1, 1]
Yes (0.00s cpu, solution 1, maybe more)

?- fact_l([0, 0, 1], Res).
Res = [0, 0, 0, 1, 1]
Yes (0.00s cpu, solution 1, maybe more)



*/
