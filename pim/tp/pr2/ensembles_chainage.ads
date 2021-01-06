-- spécification du module Ensembles_Chainage.
generic

        type T_Elts is private; -- type des elts dans le tableau

package Ensembles_Chainage is

        type T_Cellule is private;
        type T_Ensemble is limited private;

        -- Sous-programme permet d'initialiser un ensemble.
	procedure Initialiser (Ens : out T_Ensemble) with
            Post => Est_Vide(Ens);

        -- Sous-programme qui permet de détruire un ensemble.
        procedure Detruire (Ens : in out T_Ensemble);

	-- Savoir si l'ensemble est vide ou non.
	function Est_Vide (Ens : in T_Ensemble) return Boolean;

	-- Obtenir la taille d'un ensemble.
	function Taille_Ensemble (Ens : in T_Ensemble) return Integer;

	-- savoir si un élément est présent dans un ensemble.
        function Present (Ens : in T_Ensemble; Elt : in T_Elts) return Boolean;

	-- Ajouter un élément dans un ensemble au début.
	procedure Ajouter (Ens : in out T_Ensemble; Elt : in T_Elts) with
	      Post => Present(Ens,Elt);
	-- Supprimer un élément dans un ensemble.
	procedure Supprimer (Ens : in out T_Ensemble; Elt : in T_Elts) with
	    Pre => Not(Est_Vide(Ens)),
            Post => Not(Present(Ens,Elt));


        -- Sous-programme qui permet d'appliquer une opérateur sur tous les éléments de l'ensemble
        generic
            with procedure Operation (Elt : in T_Elts);
        procedure Appliquer_Sur_Tous (Ens : in T_Ensemble);


private
    type T_Ensemble is access T_Cellule;
    type T_Cellule is record
        Element : T_Elts;
        Suivant : T_Ensemble;
    end record;
end Ensembles_Chainage;
