-------------------------------------------------------------------------------
--  Fichier  : foret.ads
--  Auteur   : MOUDDENE Hamza & CAZES Noa
--  Objectif : Spécification du module Foret
--  Crée     : Dimanche Déc 12 2019
--------------------------------------------------------------------------------


with Ensemble;
with Arbre_Genealogique;	use Arbre_Genealogique;


package Foret is


    -- Type du package Foret qui est privé.
    type Forest is private;


    -- Instancier Ensemble avec T_Element comme Integer.
    package Ens is
            New Ensemble (T_Element => T_ABG);
    use Ens;


    -- Nom : Add_Cohabitant
    -- Sémantique : Ajouter un concubain à un individu donné.
    -- Paramètre :
    --     F : La foret qu'on va parcourir.
    --    ID  : identifiant unique d'un individu dans la foret.
    procedure Add_Cohabitant (F : in out Forest; ID : in Integer);


    -- Nom : Add_Half_Brother
    -- Sémantique : Ajouter un demi frère ou demie soeur.
    -- Paramètre :
    --     F : La foret qu'on va parcourir.
    --    ID  : identifiant unique d'un individu dans la foret.
    procedure Add_Half_Brother (F : in out Forest; ID : in Integer);


    -- Nom : Get_Set_Half_Brother
    -- Sémantique : Obtenir l'ensemble des demis frères et demie-soeur d'un individu donné.
    -- Type_De_Retour : T_ensemble l'ensemble des demis frères et demies soeures.
    -- Paramètre :
    --     F  : La foret qu'on va parcourir.
    --    ID  : identifiant unique d'un individu dans la foret.
    function Get_Set_Half_Brother (F : in Forest; ID : in Integer) return T_Ensemble;


private


    -- Déclaration du type forest comme une liste chainée.
    type Forest is new T_Ensemble;


end Foret;
