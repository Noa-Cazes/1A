-------------------------------------------------------------------------------
--  Fichier  : arbre_genealogique.ads
--  Auteur   : MOUDDENE Hamza & CAZES Noa
--  Objectif : Spécification du module Arbre_Genealogique
--  Crée     : Dimanche Nov 10 2019
--------------------------------------------------------------------------------


with Arbre_Binaire;
with Ensemble;
with Registre; 		use Registre;


package Arbre_Genealogique is
	

    type T_ABG is private; -- Type Arbre genealogique.

    
    ARBRE_VIDE_EXCEPTION : Exception;			-- Arbre est vide.
    ARBRE_NON_VIDE_EXCEPTION : Exception;		-- Arbre n'est pas vide.
    ID_PRESENT_EXCEPTION : Exception; 			-- ID Present.
    ID_ABSENT_EXCEPTION : Exception;   			-- ID Absent.
    DEUX_PARENTS_PRESENTS_EXCEPTION : Exception; 	-- Deux parents existants.
	

    -- Instancier Ensemble avec T_Element comme Integer. 
    package Ens is
            New Ensemble (T_Element => Integer);
    use Ens;
    

    -- Nom : Generate_ID
    -- Sémantique : Générer un ID unique.
    -- Type_De_Retour : Integer  -- l'ID généré
    -- Paramètre : 
    --     Ab : L'Ab que l'on va parcourir.
    function Generate_ID (Ab : in T_ABG) return Integer;
    

    -- Nom : Creer_Arbre_Minimal
    -- Sémantique : Initialiser un Ab.  L'Ab contient la racine.
    -- Exception : ARBRE_NON_VIDE_EXCEPTION.
    -- Paramètre : 
    --     Ab     -- L'Ab que l'on va initialiser avec sa racine.
    procedure Creer_Arbre_Minimal (Ab : out T_ABG; ID : in Integer);


    -- Nom : Ajouter_Parent
    -- Sémantique : Ajouter un parent (mère ou père) à un noeud donné.
    -- Exception : 
    --     ARBRE_VIDE_EXCEPTION.
    --     ID_ABSENT_EXCEPTION.
    --     DEUX_PARENTS_PRESENTS_EXCEPTION.
    -- Paramètre : 
    --     Ab     -- L'Ab auquel on va ajouter un parent.
    procedure Ajouter_Parent (Ab : in out T_ABG; ID, New_ID, Flag : in Integer);


    -- Nom : Nombre_Ancetres
    -- Sémantique : Obtenir le nombre d'ancêtres connus (lui compris) d'un individu donné.
    -- Type_De_Retour : Integer -- nombre d'ancêtres, entier strictement positif
    -- Exception : ID_ABSENT_EXCEPTION.
    -- Paramètres : 
    --     Ab : L'Ab que l'on va parcourir.
    --     ID : identifiant unique d'un individu dans l'Ab.
    function Nombre_Ancetres (Ab : in T_ABG; ID : in Integer) return Integer;
            
	
    -- Nom : Ancetres_N_Generation
    -- Sémantique : Obtenir l'ensemble des ancêtres situé à une certaine génération d'un noeud donné.
    -- Type_De_Retour : T_Ensemble : Retourne un ensemble non vide d'ancêtres.
    -- Exception : ID_ABSENT_EXCEPTION.
    -- Paramètres : 
    --     Ab          --  L'Ab que l'on va parcourir.
    --     ID          --  identifiant unique d'un individu dans l'Ab.
    --     Generation  -- le niveau d'ancêtres que l'on cherche. 
    procedure Ancetres_N_Generation (Ab : in T_ABG; ID : in Integer; Generation : in Integer);
    

    -- Nom : Afficher_Arbre_Noeud
    -- Sémantique : Afficher l'arbre à partir d'un noeud donné.
    -- Paramètres :
    --     Ab          --  L'Ab que l'on va parcourir.
    --     ID          --  identifiant unique d'un individu dans l'Ab.
    procedure Afficher_Arbre_Noeud (Ab : in T_ABG; ID : in Integer);
	

    -- Nom : Supprimer
    -- Sémantique : Supprimer, pour un arbre, un noeud et ses ancêtres.
    -- Exception : ID_ABSENT_EXCEPTION.
    -- Paramètres : 
    --     Ab          --  L'Ab que l'on va parcourir.
    --     ID          --  identifiant unique d'un individu dans l'Ab.
    procedure Supprimer (Ab : in out T_ABG; ID : in Integer);


    -- Nom : Individus_1_Parent_Connu
    -- Sémantique : Obtenir l'ensemble des individus qui n'ont qu'un parent connu.
    -- Type_De_Retour : T_Ensemble  -- ensemble vide ou non vide de parents.
    -- Paramètre : 
    --     Ab          --  L'Ab que l'on va parcourir.
    procedure Individus_1_Parent_Connu (Ab : in T_ABG);


    -- Nom : Individus_2_Parent_Connu
    -- Sémantique : Obtenir l'ensemble des individus dont les deux parents sont connus.
    -- Type_De_Retour : T_Ensemble  -- ensemble vide ou non vide de parents.
    -- Paramètre : 
    --     Ab          --  L'Ab que l'on va parcourir.
    procedure Individus_2_Parent_Connu (Ab : in T_ABG);


    -- Nom : Ensemble_Feuilles
    -- Sémantique : Obtenir l'ensemble des individus dont les deux parents sont inconnus.
    -- Type_De_Retour : T_Ensemble  -- ensemble vide ou non vide de parents.
    -- Paramètre : 
    --     Ab          --  L'Ab que l'on va parcourir.
    procedure Ensemble_Feuilles (Ab : in T_ABG);


    -- Nom : Ancetres_Sur_N_Generation
    -- Sémantique : Identifier les ancêtres d'un individu donné sur N generations données par un noeud donné.
    -- Type_De_Retour : T_Ensemble  -- ensemble vide ou non vide de parents.
    -- Exception : ID_ABSENT_EXCEPTION.
    -- Paramètres : 
    --     Ab          --  L'Ab que l'on va parcourir.
    --     ID          --  identifiant unique d'un individu dans l'Ab.
    --     Generation  --  Le niveau d'ancêtres que l'on cherche. 
    procedure Ancetres_Sur_N_Generation (Ab : in T_ABG; ID : in Integer; Generation : in Integer);
    

    -- Nom : Ancetres_Homonymes
    -- Sémantique : Vérifier que deux individus n et m ont un ou plusieurs ancêtres homonymes (mêmes non et prénom).
    -- Type_De_Retour :  Boolean   -- True si ID1 et ID2 ont des ancêtres homonymes, sinon False.
    -- Exception : ID_ABSENT_EXCEPTION.
    -- Paramètres : 
    --     Ab                      --  L'Ab que l'on va parcourir.
    --     ID                      --  identifiant unique d'un individu dans l'Ab.
    function Ancetres_Homonymes (Ab : in T_ABG; R : in T_Registre; ID1 : in Integer; ID2 : in Integer) return Boolean;


private
    
    -- Instancier Arbre_Binaire avec T_ID comme Integer.
    package Ab_Genealogique is
            New Arbre_Binaire (T_ID => Integer);
    use Ab_Genealogique;


    type T_ABG is new T_BT;


end Arbre_Genealogique;
