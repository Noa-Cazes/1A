Require Import Naturelle.
Section Session1_2018_Logique_Exercice_2.

Variable A B : Prop.

Theorem Exercice_2_Naturelle : ~(A /\ B) -> (~A \/ ~B).
Proof.
intro.
cut (B \/ ~B). (* le faire très tôt, avant de décomposer, correspond au TE *)
intro.
destruct H0.
left.
intro.
absurd (A/\B).
exact H.
split.
exact H1.
exact H0.
right.
exact H0.
apply(classic B). (* quand conclusion de la forme B\/~B *)
Qed.

Theorem Exercice_2_Coq : ~(A /\ B) -> (~A \/ ~B).
Proof.
I_imp H.
E_imp B.
I_imp H1.
I_ou_g.
I_imp H2.
Qed.

End Session1_2018_Logique_Exercice_2.

