
-- Auteur: 
-- Gérer un stock de matériel informatique.

package Stocks_Materiel is


    CAPACITE : constant Integer := 10;      -- nombre maximum de matériels dans un stock

    type T_Nature is (UNITE_CENTRALE, DISQUE, ECRAN, CLAVIER, IMPRIMANTE);
    
    type T_Fonctionnement is (MAUVAIS, BON);
    
    type T_Materiel is record
        Nature: T_Nature;        -- la nature de l'élément.
        Etat: T_Fonctionnement;  -- état du matériel, bon ou mauvais.
        Annee: Integer;          -- année d'achat
        Num: Integer;            -- numéro de série
    end record; 


    type T_Stock is limited private;
    type T_Tableau is limited private;


    -- Créer un stock vide.
    --
    -- paramètres
    --     Stock : le stock à créer
    --
    -- Assure
    --     Nb_Materiels (Stock) = 0
    --
    procedure Creer (Stock : out T_Stock) with
        Post => Nb_Materiels (Stock) = 0;

        
   
    -- Obtenir le nombre de matériels dans le stock Stock
    --
    -- Paramètres
    --    Stock : le stock dont ont veut obtenir la taille
    --
    -- Nécessite
    --     Vrai
    --
    -- Assure
    --     Résultat >= 0 Et Résultat <= CAPACITE
    --
    function Nb_Materiels (Stock: in T_Stock) return Integer with
        Post => Nb_Materiels'Result >= 0 and Nb_Materiels'Result <= CAPACITE;


    -- Enregistrer un nouveau métériel dans le stock.  Il est en
    -- fonctionnement.  Le stock ne doit pas être plein.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du nouveau matériel
    --    Nature       : la nature du nouveau matériel
    --    Annee_Achat  : l'année d'achat du nouveau matériel
    -- 
    -- Nécessite
    --    Nb_Materiels (Stock) < CAPACITE
    -- 
    -- Assure
    --    Nouveau matériel ajouté
    --    Nb_Materiels (Stock) = Nb_Materiels (Stock)'Avant + 1
    procedure Enregistrer (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            Nature       : in     T_Nature;
            Annee_Achat  : in     Integer
        ) with
            Pre => Nb_Materiels (Stock) < CAPACITE,
            Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old + 1;
    
    -- Obtenir le nombre de matériels qui sont hors d'état de fonctionnement.
    --
    -- Paramètres
    --    Stock: T_Stock
    --
    -- Nécessite
    --    Vrai
    --
    -- Assure
    --    Résultat >= 0 Et Résultat <= CAPACITE
    -- 
    function Nb_Materiels_Mauvais (Stock: in T_Stock) return Integer with Post => Nb_Materiels_Mauvais'Result >= 0 and Nb_Materiels_Mauvais'Result <= CAPACITE;
private
    type T_Stock is record
        Elements: T_Materiel;
        Nbre_Elements: Integer;
    end record 
    with Type_Invariant => 0 <= Nbre_Elements and Nbre_Elements <= 10; 
    
    type T_Tableau is array (1..CAPACITE) of T_Stock    
    
    
    
end Stocks_Materiel;
