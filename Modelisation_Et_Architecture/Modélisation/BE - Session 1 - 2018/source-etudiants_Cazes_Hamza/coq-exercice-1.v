Require Import Naturelle.
Section Session1_2018_Logique_Exercice_1.

Variable A B : Prop.

Theorem Exercice_1_Naturelle : ~(A \/ B) -> (~A /\ ~B).
Proof.
intro.
split.
intro.
destruct H.
left.
exact H0.
intro.
destruct H.
right.
exact H0.
Qed.

Theorem Exercice_1_Coq : ~(A \/ B) -> (~A /\ ~B).
Proof.
I_imp H.
I_et.
I_non H1.
E_non (A\/B).
2:Hyp H.   (* pour dire que l'on veut qu'il démontre la deuxième conclusion, au lieu de la première*)
I_ou_g.
Hyp H1.
I_non H2.
E_non (A\/B).
2:Hyp H.
I_ou_d.
Hyp H2.
Qed.

End Session1_2018_Logique_Exercice_1.

