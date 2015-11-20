hors_d_oeuvre(artichauts_Melanie).
hors_d_oeuvre(truffes_sous_le_sel).
hors_d_oeuvre(cresson_oeuf_poche).

viande(grillade_de_boeuf).
viande(poulet_au_tilleul).

poisson(bar_aux_algues).
poisson(saumon_oseille).

dessert(sorbet_aux_poires).
dessert(fraises_chantilly).
dessert(melon_en_surprise).

calories(artichauts_Melanie, 150).
calories(truffes_sous_le_sel, 202).
calories(cresson_oeuf_poche, 212).
calories(grillade_de_boeuf, 532).
calories(poulet_au_tilleul, 400).
calories(bar_aux_algues, 292).
calories(saumon_oseille, 254).
calories(sorbet_aux_poires, 223).
calories(fraises_chantilly, 289).
calories(melon_en_surprise, 122).

plat_resistance(X):- viande(X).
plat_resistance(X):- poisson(X).

repas(rep(E,P,D)):- 
    hors_d_oeuvre(E),
    plat_resistance(P),
    dessert(D).

plat24(P):- 
    plat_resistance(P),
    calories(P,X),
    X>200,
    X<400.

platbaa(P):-
    plat_resistance(P),
    calories(P,X),
    calories(bar_aux_algues,CB),
    X>CB.

val_cal_repas(rep(E,P,D),C):-
    repas(rep(E,P,D)),
    calories(E,CE),
    calories(P,CP),
    calories(D,CD),
    C is CE+CP+CD.

rep_equ(R):-
    val_cal_repas(R,X),
    X<800.

/*
 * //Q1.2
?:-(rep_equ(rep(truffes_sous_le_sel,saumon_oseille,X))).



?:-(val_cal_repas(rep(truffes_sous_le_sel,saumon_oseille,X),C)).
10 inferences, 0.000 CPU in 0.000 seconds (98% CPU, 484707 Lips)

C = 679,
X = sorbet_aux_poires

5 inferences, 0.000 CPU in 0.000 seconds (97% CPU, 478240 Lips)

8 inferences, 0.000 CPU in 0.000 seconds (97% CPU, 767312 Lips)

C = 745,
X = fraises_chantilly
C = 578,
X = melon_en_surprise


*/