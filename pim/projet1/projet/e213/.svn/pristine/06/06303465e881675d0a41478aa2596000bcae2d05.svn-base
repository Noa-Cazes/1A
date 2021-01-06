-------------------------------------------------------------------------------
--  Fichier  : foret.adb
--  Auteur   : MOUDDENE Hamza & CAZES Noa
--  Objectif : Implantation du module Foret
--  Crée     : Jeudi Déc 12 2019
--------------------------------------------------------------------------------


package body Foret is
    
    
    ----------------------------------Constuctor--------------------------------
    
    -- Initialiser Forest.  Forest est vide.
    procedure Initialize_Forest (F : out Forest) is
    begin
        Initialiser (F);
    end Initialize_Forest;
    
    
    -- Ajouter un Arbre dans la Forest.
    procedure Add_To_Forest (F : in out Forest; Ab : in T_ABG) is
    begin
        Ajouter (F, Ab);
    end Add_To_Forest;
    
    ----------------------------------------------------------------------------
    
    -- Vérifier si une foret donnée est vide.
    function Is_Empty_Forest (F : in Forest) return Boolean is
    begin
        return (Est_Vide (F));
    end Is_Empty_Forest;
    
    
    -- Trouver un ID dans la foret.
    procedure Find_Tree (F : in Forest; Ab : out T_ABG; ID : in Integer) is
        Tmp : Forest;
    begin
        if (Est_Vide (F)) then
            raise ABSENT_TREE_EXCEPTION;
        else
            Tmp := F;
            while (not (Est_Vide (Tmp))) loop
                if (Get_ID (Get_Element (Tmp)) = ID) then
                    Ab := Get_Element (Tmp);
                end if;
                Tmp := Get_Next (Tmp);
            end loop;
        end if;
    end Find_Tree;
    
    ----------------------------------------------------------------------------
    
    -- Mettre à jour la foret.
    procedure Update_Forest (F : in Forest; Old_Ab, New_Ab : in T_ABG) is
    begin
        Edit_Set (F, Old_Ab, New_Ab);
    end Update_Forest;
    
    ----------------------------------------------------------------------------
    
    -- Supprimer un arbre de la foret.
    procedure Remove_Tree (F : in out Forest; Ab : in T_ABG) is
    begin
        Supprimer (F, Ab);
    end Remove_Tree;
    
    ----------------------------------------------------------------------------

    -- Ajouter un concubain à un individu donné.
    procedure Add_Cohabitant (F : in out Forest; Ab : in T_ABG) is
        --tmp : Forest;
        Ab_Cohabitant : T_ABG;
        Data : T_Node;
    begin
        if (not (Est_Present (F, Ab))) then 
            raise ABSENT_TREE_EXCEPTION;
        else
            Initialize_Data (Data, Generate_ID (Ab));
            Creer_Arbre_Minimal (Ab_Cohabitant, Data);
        end if;
    end Add_Cohabitant;
  
    ----------------------------------------------------------------------------
    
    -- Ajouter un demi frère ou demie soeur à un individu donné.
    procedure Add_Half_Brother (F : in out Forest; ID : in Integer) is
        Tmp : T_ABG;
    begin
        Find_Tree (F, Tmp, ID);
        
        -- Génerer un ID unique.
        ID := Generate_ID (Ab);
        Initialize_Data (Data, ID);
                    
        -- Création du nouveau noeud.
        Initialize_Genealogical_Tree (Ab);
        Creer_Arbre_Minimal (Ab, Data);
                    
        -- Ajouter le nouvel arbre dans la foret.
        Add_To_Forest (F, Ab);
                    
        -- Insérer le nouveau parent dans le registre.
        Inserer_R (Registre, ID, Demander_Donnee);
                    
        -- Affichage.
        Display_New_ID (ID);
    end Add_Half_Brother;
    
    ----------------------------------------------------------------------------
    
    -- Obtenir l'ensemble des demis frères et demie-soeur d'un individu donné.
    procedure Get_Set_Half_Brother (F : in Forest; Father_ID, Mother_ID : in Integer) is
        
        
        -- Nom 		  : Get_Child_ID
    	-- Sémantique     : Obtenir l'ID du fils.
    	-- Type_De_Retour : Integer  -- Integer l'ID du fils. 
    	-- Paramètres     : 
    	--     Ab         -- Tree que l'on va parcourir.
    	--     Parent_ID  -- L'ID du parent passé en paramètre.
        function Get_Child_ID (Ab : in T_ABG; Parent_ID : in Integer) return Integer is
        begin
            if (Is_Empty (Ab)) then
                Null;
            else
                if (Get_ID (Ab) = Parent_ID) then
                    Null;
                end if;
                Get_Child_ID (Get_Left (Ab), Parent_ID); 
                Get_Child_ID (Get_Right (Ab), Parent_ID); 
            end if;
        end Get_Child_ID;    
        
        
        Tmp : Forest;
        Set : T_Ensemble;
    
    
    begin
        if (Is_Empty_Forest (F)) then
            Null;
        else
            Tmp := F;
            while (not (Is_Empty_Forest (Tmp))) loop
                if (not (Is_Present_ID (Get_Element (F), Father_ID)) and (not (Is_Present_ID (Get_Element (F), Mother_ID))))then
                    Tmp := Get_Next (Tmp);
                elsif ((Is_Present_ID (Get_Element (F), Father_ID))  and get_Child_ID (Get_Element(F), Father_ID) /= ID) then
                    Ajouter (Set, get_Child_ID (Get_Element(F), Father_ID));
                    Tmp := Get_Next (Tmp);
                elsif ((Is_Present_ID (Get_Element (F), Mother_ID))  and get_Child_ID (Get_Element(F), Mother_ID) /= ID) then
                    Ajouter (Set, get_Child_ID (Get_Element(F), Mother_ID));
                    Tmp := Get_Next (Tmp);
                end if;
            end loop;
        end if;
    end Get_Set_Half_Brother;

    ----------------------------------------------------------------------------
    
    -- Détruire Forest.  Forest est vide.
    procedure Destruct_Forest (F : in out Forest) is
    begin
        Detruire (F);
    end Destruct_Forest;


end Foret;
