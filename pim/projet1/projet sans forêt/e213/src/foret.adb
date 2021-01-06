-------------------------------------------------------------------------------
--  Fichier  : foret.adb
--  Auteur   : MOUDDENE Hamza & CAZES Noa
--  Objectif : Implantation du module Foret
--  Crée     : Dimanche Déc 12 2019
--------------------------------------------------------------------------------


package body Foret is
    
   
    -- Ajouter un concubain à un individu donné.
    procedure Add_Cohabitant (F : in out Forest; ID : in Integer) is
    begin
        Null;
    end Add_Cohabitant;
    
    
    -- Ajouter un demi frère ou demie soeur à un individu donné.
    procedure Add_Half_Brother (F : in out Forest; ID : in Integer) is
    begin
        Null;
    end Add_Half_Brother;
    
    
    -- Obtenir l'ensemble des demis frères et demie-soeur d'un individu donné.
    function Get_Set_Half_Brother (F : in Forest; ID : in Integer) return T_Ensemble is
        
        E : T_Ensemble;
    
    begin
        Initialiser (E);
        return E;
    end Get_Set_Half_Brother;


end Foret;
