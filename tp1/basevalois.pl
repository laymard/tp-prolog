/*
TP Base Valois - Famille de France

@author Laurent AYMARD
@author Blandine SEZNEC
@version Annee scolaire 20__/20__
*/

homme(charles_V).
homme(charles_VI).
homme(charles_VII).
homme(louis_XI).
homme(charles_VIII).
homme(louis_XII).
homme(francois_I).
homme(henri_II).
homme(francois_II).
homme(charles_IX).
homme(henri_III).
homme(jean_II).
homme(philippe_VI).
homme(charles_d_Orleans).
homme(charles_de_Valois).
homme(louis_d_Orleans).
homme(jean_d_angouleme).
homme(charles_d_angouleme).

femme(anne_de_cleves).
femme(louise_de_Savoie).
femme(claude_de_france).
femme(anne_de_Bretagne).
femme(catherine_de_medicis).
femme(charlotte_de_Savoie).
femme(marie_d_anjou).
femme(isabeau_de_Baviere).
femme(valentine_de_milan).
femme(jeanne_de_Bourbon).
femme(bonne_de_luxembourg).
femme(jeanne_de_Bourgogne).
femme(marie_Stuart).
femme(elisabeth_d_autriche).
femme(louise_de_lorraine).
femme(marguerite_de_Rohan).

mere(marguerite_de_Rohan, charles_d_angouleme).
mere(jeanne_de_Bourgogne, jean_II).
mere(bonne_de_luxembourg, charles_V).
mere(jeanne_de_Bourbon, charles_VI).
mere(jeanne_de_Bourbon, louis_d_Orleans).
mere(valentine_de_milan, charles_d_Orleans).
mere(valentine_de_milan, jean_d_angouleme).
mere(isabeau_de_Baviere, charles_VII).
mere(marie_d_anjou, louis_XI).
mere(charlotte_de_Savoie, charles_VIII).
mere(anne_de_Bretagne, claude_de_france).
mere(claude_de_france, henri_II).
mere(anne_de_cleves, louis_XII).
mere(louise_de_Savoie, francois_I).
mere(catherine_de_medicis, francois_II).
mere(catherine_de_medicis, charles_IX).
mere(catherine_de_medicis, henri_III).

epoux(marguerite_de_Rohan, jean_d_angouleme).
epoux(louise_de_lorraine, henri_III).
epoux(elisabeth_d_autriche, charles_IX).
epoux(marie_Stuart, francois_II).
epoux(jeanne_de_Bourgogne, philippe_VI).
epoux(bonne_de_luxembourg, jean_II).
epoux(jeanne_de_Bourbon, charles_V).
epoux(valentine_de_milan, louis_d_Orleans).
epoux(isabeau_de_Baviere, charles_VI).
epoux(marie_d_anjou, charles_VII).
epoux(charlotte_de_Savoie, louis_XI).
epoux(catherine_de_medicis, henri_II).
epoux(anne_de_cleves, charles_d_Orleans).
epoux(louise_de_Savoie, charles_d_angouleme).
epoux(claude_de_france, francois_I).
epoux(anne_de_Bretagne, charles_VIII).
epoux(anne_de_Bretagne, louis_XII).
epoux(H,F) :- homme(H), femme(F), epoux(F,H).

pere(louis_XII, claude_de_france).
pere(charles_de_Valois, philippe_VI).
pere(philippe_VI, jean_II).
pere(jean_II, charles_V).
pere(charles_V, charles_VI).
pere(charles_VI, charles_VII).
pere(charles_VII, louis_XI).
pere(charles_d_Orleans, louis_XII).
pere(charles_d_angouleme, francois_I).
pere(francois_I, henri_II).
pere(henri_II, francois_II).
pere(henri_II, charles_IX).
pere(henri_II, henri_III).
pere(louis_d_Orleans, charles_d_Orleans).
pere(charles_V, louis_d_Orleans).
pere(jean_d_angouleme, charles_d_angouleme).
pere(louis_d_Orleans, jean_d_angouleme).

roi(charles_V, le_sage, 1364, 1380).
roi(charles_VI, le_bien_aime, 1380, 1422).
roi(charles_VII, xx, 1422, 1461).
roi(louis_XI, xx, 1461, 1483).
roi(charles_VIII, xx, 1483, 1498).
roi(louis_XII, le_pere_du_peuple, 1498, 1515).
roi(francois_I, xx, 1515, 1547).
roi(henri_II, xx, 1547, 1559).
roi(francois_II, xx, 1559, 1560).
roi(charles_IX, xx, 1560, 1574).
roi(henri_III, xx, 1574, 1589).
roi(jean_II, le_bon, 1350, 1364).
roi(philippe_VI, de_valois, 1328, 1350).

% Règles
enfant(E,P):-
    pere(P,E).
enfant(E,P):-
    mere(P,E).

parent(P,E):-
    pere(P,E).
parent(P,E):-
    mere(P,E).

grand_pere(G,E):-
    pere(G,X),
    pere(X,E).

frere(F,E):-
    pere(P,F),
    pere(P,E),
    mere(M,F),
    mere(M,E),
    homme(F),
    \==(F,E).

soeur(S,E):-
    pere(P,S),
    pere(P,E),
    mere(M,S),
    mere(M,E),
    femme(S),
    \==(S,E).

oncle(O,N):-
    parent(P,N),
    frere(O,P).

tante(T,N):-
    parent(P,N),
    soeur(T,P).

cousin(C,E):-
    oncle(O,E),
    enfant(C,O).

cousin(C,E):-
    tante(T,E),
    enfant(C,T).

le_roi_est_mort_vive_le_roi(R1,D,R2):-
    roi(R1,_,_,D),
    roi(R2,_,D,_).

ancetre1(A,X):-
    parent(A,X).

ancetre1(A,X):-
    ancetre1(Z,X),
	parent(A,Z).


ancetre2(A,X):-
    parent(A,X).

ancetre2(A,X):-
	parent(A,Z),
    ancetre2(Z,X).

/*

Test Enfant :

trace, (enfant(jean_II,P)).
 Call:enfant(jean_II, _G5127)
 Call:pere(_G5127, jean_II)
 Exit:pere(philippe_VI, jean_II)
 Exit:enfant(jean_II, philippe_VI)
P = philippe_VI
 Redo:enfant(jean_II, _G5127)
 Call:mere(_G5127, jean_II)
 Exit:mere(jeanne_de_Bourgogne, jean_II)
 Exit:enfant(jean_II, jeanne_de_Bourgogne)
P = jeanne_de_Bourgogne

Test Parent :
trace, (parent(jean_II,E)).
 Call:parent(jean_II, _G5171)
 Call:pere(jean_II, _G5171)
 Exit:pere(jean_II, charles_V)
 Exit:parent(jean_II, charles_V)
E = charles_V
 Redo:parent(jean_II, _G5171)
 Call:mere(jean_II, _G5171)
 Fail:mere(jean_II, _G5171)
 Fail:parent(jean_II, _G5171)
false

Test grand-parent :

trace, (grand_pere(charles_VI,E)).
 Call:grand_pere(charles_VI, _G5258)
 Call:pere(charles_VI, _G5352)
 Exit:pere(charles_VI, charles_VII)
 Call:pere(charles_VII, _G5258)
 Exit:pere(charles_VII, louis_XI)
 Exit:grand_pere(charles_VI, louis_XI)
E = louis_XI

Test frère :

trace, (frere(charles_IX,F)).
 Call:frere(charles_IX, _G5678)
 Call:pere(_G5771, charles_IX)
 Exit:pere(henri_II, charles_IX)
 Call:pere(henri_II, _G5678)
 Exit:pere(henri_II, francois_II)
 Call:mere(_G5771, charles_IX)
 Exit:mere(catherine_de_medicis, charles_IX)
 Call:mere(catherine_de_medicis, francois_II)
 Exit:mere(catherine_de_medicis, francois_II)
 Call:homme(charles_IX)
 Exit:homme(charles_IX)
 Call:charles_IX\==francois_II
 Exit:charles_IX\==francois_II
 Exit:frere(charles_IX, francois_II)
F = francois_II
 Redo:pere(henri_II, _G5678)
 Exit:pere(henri_II, charles_IX)
 Call:mere(_G5882, charles_IX)
 Exit:mere(catherine_de_medicis, charles_IX)
 Call:mere(catherine_de_medicis, charles_IX)
 Exit:mere(catherine_de_medicis, charles_IX)
 Call:homme(charles_IX)
 Exit:homme(charles_IX)
 Call:charles_IX\==charles_IX
 Fail:charles_IX\==charles_IX
 Redo:pere(henri_II, _G5678)
 Exit:pere(henri_II, henri_III)
 Call:mere(_G5882, charles_IX)
 Exit:mere(catherine_de_medicis, charles_IX)
 Call:mere(catherine_de_medicis, henri_III)
 Exit:mere(catherine_de_medicis, henri_III)
 Call:homme(charles_IX)
 Exit:homme(charles_IX)
 Call:charles_IX\==henri_III
 Exit:charles_IX\==henri_III
 Exit:frere(charles_IX, henri_III)
F = henri_II

Test oncle :
trace, (oncle(louis_d_Orleans,F)).
 Call:oncle(louis_d_Orleans, _G6212)
 Call:parent(_G6305, _G6212)
 Call:pere(_G6305, _G6212)
 Exit:pere(louis_XII, claude_de_france)
 Exit:parent(louis_XII, claude_de_france)
 Call:frere(louis_d_Orleans, louis_XII)
 Call:pere(_G6305, louis_d_Orleans)
 Exit:pere(charles_V, louis_d_Orleans)
 Call:pere(charles_V, louis_XII)
 Fail:pere(charles_V, louis_XII)
 Fail:frere(louis_d_Orleans, louis_XII)
 Redo:pere(_G6307, _G6212)
 Exit:pere(charles_de_Valois, philippe_VI)
 Exit:parent(charles_de_Valois, philippe_VI)
 Call:frere(louis_d_Orleans, charles_de_Valois)
 Call:pere(_G6305, louis_d_Orleans)
 Exit:pere(charles_V, louis_d_Orleans)
 Call:pere(charles_V, charles_de_Valois)
 Fail:pere(charles_V, charles_de_Valois)
 Fail:frere(louis_d_Orleans, charles_de_Valois)
 Redo:pere(_G6307, _G6212)
 Exit:pere(philippe_VI, jean_II)
 Exit:parent(philippe_VI, jean_II)
 Call:frere(louis_d_Orleans, philippe_VI)
 Call:pere(_G6305, louis_d_Orleans)
 Exit:pere(charles_V, louis_d_Orleans)
 Call:pere(charles_V, philippe_VI)
 Fail:pere(charles_V, philippe_VI)
 Fail:frere(louis_d_Orleans, philippe_VI)
 Redo:pere(_G6307, _G6212)
 Exit:pere(jean_II, charles_V)
 Exit:parent(jean_II, charles_V)
 Call:frere(louis_d_Orleans, jean_II)
 Call:pere(_G6305, louis_d_Orleans)
 Exit:pere(charles_V, louis_d_Orleans)
 Call:pere(charles_V, jean_II)
 Fail:pere(charles_V, jean_II)
 Fail:frere(louis_d_Orleans, jean_II)
 Redo:pere(_G6307, _G6212)
 Exit:pere(charles_V, charles_VI)
 Exit:parent(charles_V, charles_VI)
 Call:frere(louis_d_Orleans, charles_V)
 Call:pere(_G6305, louis_d_Orleans)
 Exit:pere(charles_V, louis_d_Orleans)
 Call:pere(charles_V, charles_V)
 Fail:pere(charles_V, charles_V)
 Fail:frere(louis_d_Orleans, charles_V)
 Redo:pere(_G6307, _G6212)
 Exit:pere(charles_VI, charles_VII)
 Exit:parent(charles_VI, charles_VII)
 Call:frere(louis_d_Orleans, charles_VI)
 Call:pere(_G6305, louis_d_Orleans)
 Exit:pere(charles_V, louis_d_Orleans)
 Call:pere(charles_V, charles_VI)
 Exit:pere(charles_V, charles_VI)
 Call:mere(_G6305, louis_d_Orleans)
 Exit:mere(jeanne_de_Bourbon, louis_d_Orleans)
 Call:mere(jeanne_de_Bourbon, charles_VI)
 Exit:mere(jeanne_de_Bourbon, charles_VI)
 Call:homme(louis_d_Orleans)
 Exit:homme(louis_d_Orleans)
 Call:louis_d_Orleans\==charles_VI
 Exit:louis_d_Orleans\==charles_VI
 Exit:frere(louis_d_Orleans, charles_VI)
 Exit:oncle(louis_d_Orleans, charles_VII)
F = charles_VII

Test cousin :
trace, (cousin(X,F)).
 Call:cousin(_G1941, _G1943)
F = charles_VII,
X = charles_d_Orleans
F = charles_VII,
X = jean_d_angouleme
F = louis_XII,
X = charles_d_angouleme
F = charles_d_Orleans,
X = charles_VII
F = charles_d_angouleme,
X = louis_XII
F = jean_d_angouleme,
X = charles_VII

Test succession de roi :
trace, (le_roi_est_mort_vive_le_roi(charles_V,D,R2)).
 Call:le_roi_est_mort_vive_le_roi(charles_V, _G5835, _G5837)
 Call:roi(charles_V, _G5932, _G5933, _G5835)
 Exit:roi(charles_V, le_sage, 1364, 1380)
 Call:roi(_G5837, _G5932, 1380, _G5934)
 Exit:roi(charles_VI, le_bien_aime, 1380, 1422)
 Exit:le_roi_est_mort_vive_le_roi(charles_V, 1380, charles_VI)
D = 1380,
R2 = charles_VI

Test ancetre :
Comparaison des deux méthodes.

time((ancetre1(charles_de_Valois,X))).

2 inferences, 0.000 CPU in 0.000 seconds (99% CPU, 75463 Lips)

X = philippe_VI
time((ancetre2(charles_de_Valois,X))).

2 inferences, 0.000 CPU in 0.000 seconds (97% CPU, 163066 Lips)

X = philippe_VI

ancetre(A,X):-
    parent(A,X).

ancetre(A,X):-
    ancetre(Z,X),
	parent(A,Z).
=================

plus long que

ancetre(A,X):-
    parent(A,X).

ancetre(A,X):-
	parent(A,Z),
    ancetre(Z,X).

    ============

*/
