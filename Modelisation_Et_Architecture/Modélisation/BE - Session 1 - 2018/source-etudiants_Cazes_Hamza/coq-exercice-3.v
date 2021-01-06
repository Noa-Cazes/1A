Section Session1_2018_Induction_Exercice_3.

(* Déclaration d’un domaine pour les éléments des listes *)
Variable A : Set.

Inductive liste : Set :=
Nil
: liste
| Cons : A -> liste -> liste.

(* Déclaration du nom de la fonction append *)
Variable append_spec : liste -> liste -> liste.

(* Spécification du comportement de append pour Nil en premier paramètre *)
Axiom append_Nil : forall (l : liste), append_spec Nil l = l.

(* Spécification du comportement de append pour Cons en premier paramètre *)
Axiom append_Cons : forall (t : A), forall (q l : liste),
   append_spec (Cons t q) l = Cons t (append_spec q l).

(* Spécification du comportement de append pour Nil en second paramètre *)
Axiom append_Nil_right : forall (l : liste), (append_spec l Nil) = l.

(* append est associative à gauche et à droite *)
Axiom append_associative : forall (l1 l2 l3 : liste),
   (append_spec l1 (append_spec l2 l3)) = (append_spec (append_spec l1 l2) l3).

(* Déclaration du nom de la fonction snoc *)
Variable snoc_spec : A -> liste -> liste.

(* Spécification du comportement de snoc pour Nil en second paramètre *)
Axiom snoc_Nil : (* A COMPLETER *).

(* Spécification du comportement de snoc pour Cons en second paramètre *)
Axiom snoc_Cons : (* A COMPLETER *).

(* snoc pourrais être spécifié avec append *)
Theorem snoc_alternative : (* A COMPLETER *).
Proof.
(* A COMPLETER *)
Qed.

(* snoc commute avec append *)
Theorem snoc_append : (* A COMPLETER *).
Proof.
(* A COMPLETER *)
Qed.

(* Implantation de la fonction snoc *)
Fixpoint snoc_impl (e : A) (l : liste) {struct l} : liste :=
(* A COMPLETER *)
end.

Theorem snoc_correctness : forall (e : A), forall (l : liste),
   (snoc_spec e l) = (snoc_impl e l).
Proof.
(* A COMPLETER *)
Qed.
		     
End Session1_2018_Induction_Exercice_3.
