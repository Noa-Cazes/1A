-------------------------------------------------------------------------------
--  Fichier  : display_shell.adb
--  Auteur   : MOUDDENE Hamza & CAZES Noa
--  Objectif : Implantation du module Arbre_Genealogique
--  Crée     : Dimanche Nov 10 2019
--------------------------------------------------------------------------------


with Ada.Text_IO; 		use Ada.Text_IO;
with Alea;
with Display_Shell; 		use Display_Shell;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


package body Arbre_Genealogique is 
	
    
    package Mon_Alea is
            new Alea (1000, 9999);  -- Générateur de nombre dans l'intervalle [1000, 9999].
    use Mon_Alea;

    -------------------------------------------------------------------------------
    
    -- Afficher un élement d'un ensemble.
    procedure Display_Item (Item : in Integer) is
    begin
        Put (Integer'Image(Item) & " ");
    end Display_Item;


    -- Afficher un ensemble.
    procedure To_String is new Afficher_Ensemble (Display_Item);
	
    -------------------------------------------------------------------------------

    -- Générer un ID unique.
    function Generate_ID (Ab : in T_ABG) return Integer is
        ID : Integer;
    begin
        loop
            Get_Random_Number (ID);
            exit when not (Is_Present (Ab, ID));
        end loop;
        return ID;                  
    end Generate_ID;

    -------------------------------------------------------------------------------
    
    procedure Creer_Arbre_Minimal (Ab : out T_ABG; ID : in Integer) is
    begin
        if (Is_Empty (Ab)) then
            Create_Node (Ab, ID);
        else
            raise ARBRE_NON_VIDE_EXCEPTION;
        end if;
    end Creer_Arbre_Minimal;

    -------------------------------------------------------------------------------

    procedure Ajouter_Parent (Ab : in out T_ABG; ID, New_ID, Flag : in Integer) is
    	
        procedure Find_Person (Ab : in out T_ABG; ID, Flag : in Integer) is
            L, R: T_ABG;
        begin
            if (Is_Empty (Ab)) then
                Null;
            else
                L := Get_Left (Ab);
                R := Get_Right (Ab);
                if (ID = Get_ID (Ab)) then
                    if ((not Is_empty (L)) and (not Is_empty (R))) then
                        raise DEUX_PARENTS_PRESENTS_EXCEPTION;
                    elsif (Flag = 0) then
                        Create_Node (L, New_ID);
                        Set_Left (Ab, L);   
                    elsif (Flag = 1) then 
                        Create_Node (R, New_ID);
                        Set_Right (Ab, R);
                    end if;
                else
                    Find_Person (L, ID, Flag);
                    Find_Person (R, ID, Flag);
                end if; 
            end if;
        end Find_Person;
	

    begin
        if (Is_Empty (Ab)) then
            raise ARBRE_VIDE_EXCEPTION;
        elsif (not ( Is_Present (Ab, ID))) then
            Raise ID_ABSENT_EXCEPTION;
        else
            Find_Person (Ab, ID, Flag);
        end if;
    end Ajouter_Parent;

    -------------------------------------------------------------------------------

    function Nombre_Ancetres (Ab : in T_ABG; ID : in Integer) return Integer is

        
        procedure Get_Sub_Tree (Ab : in T_ABG; ID_Tree : out T_ABG) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            else
                if (ID = Get_ID (Ab)) then
                    ID_Tree := Ab;
                else
                    Get_Sub_Tree (Get_Left (AB), ID_Tree);
                    Get_Sub_Tree (Get_Right (AB), ID_Tree);
                end if;
            end if;
        end Get_Sub_Tree;
        

        ID_Tree : T_ABG;
                
          
    begin
        if (Is_Empty (Ab)) then
            raise ARBRE_VIDE_EXCEPTION;
        elsif (not ( Is_Present (Ab, ID))) then
            Raise ID_ABSENT_EXCEPTION;
        else
            Get_Sub_Tree (Ab, ID_Tree);
            return Height (ID_Tree);
        end if;
    end Nombre_Ancetres;
	
    -------------------------------------------------------------------------------
	
    procedure Ancetres_N_Generation (Ab : in T_ABG; ID : in Integer; Generation : in Integer) is
	

        procedure Ancestor_N_Generation (Ab : in T_ABG; E : in out T_Ensemble; Generation : in Integer) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            elsif (Generation = 0 and not (Is_Empty (Ab))) then
                Ajouter (E, Get_ID (Ab));
            else
                Ancestor_N_Generation (Get_Left (Ab), E, Generation - 1);
                Ancestor_N_Generation (Get_Right (Ab), E, Generation - 1);
            end if;
        end Ancestor_N_Generation;
	

        procedure Find_Person (Ab : in T_ABG; E : in out T_Ensemble; ID : in Integer; Generation : in Integer) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            else
                if (ID = Get_ID (Ab)) then
                    Ancestor_N_Generation (Ab, E, Generation);
                else
                    Find_Person (Get_Left (AB), E, ID, Generation);
                    Find_Person (Get_Right (AB), E, ID, Generation);
                end if;
            end if;
        end Find_Person;


        E : T_Ensemble;
	
	
    begin
        if (Is_Empty (Ab)) then
            raise ARBRE_VIDE_EXCEPTION;
        elsif (not ( Is_Present (Ab, ID))) then
            Raise ID_ABSENT_EXCEPTION;
        else
            Initialiser (E);
            find_person (Ab, E, ID, Generation);
            Display_Title_Set ("L'ensemble des ancetres à ", Generation);
            To_String (E);
        end if;
    end Ancetres_N_Generation;
	
    -------------------------------------------------------------------------------

    procedure Afficher_Arbre_Noeud (Ab : in T_ABG; ID : in Integer) is
	

        procedure Indenter(Decalage : in Integer) is
        begin
            for i in 1..Decalage loop
                Put (' ');
            end loop;
        end Indenter;


        procedure Afficher_Profondeur (Abr : in T_ABG ; Profondeur : in Integer ; Cote : in String) is
        begin
            if (Is_Empty (Abr)) then
                Null;
            else
                Indenter (Profondeur * 4);
                Put (Cote);
                Put (Integer'Image (Get_ID (Abr)));
                New_Line;
                Afficher_Profondeur (Get_Left (Abr), Profondeur + 1, "-- père :");
                Afficher_Profondeur (Get_Right (Abr), Profondeur + 1, "-- mère :");
            end if;
        end Afficher_Profondeur;


        procedure Afficher_Generations (Ab : in T_ABG) is
        begin
            New_Line;
            for i in 1..depth(Ab) loop
                Put (Integer'Image(i - 1));
                Indenter(4);
            end loop;
            Put_Line ("Generation");
            for i in 0..depth (Ab) loop
                Put ("---------");
            end loop;
            New_Line;
        end Afficher_Generations;

        procedure Get_Sub_Tree (Ab : in T_ABG; ID_Tree : out T_ABG) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            else
                if (ID = Get_ID (Ab)) then
                    ID_Tree := Ab;
                else
                    Get_Sub_Tree (Get_Left (AB), ID_Tree);
                    Get_Sub_Tree (Get_Right (AB), ID_Tree);
                end if;
            end if;
        end Get_Sub_Tree;
        

        ID_Tree : T_ABG;
        
    begin
        if (Is_Empty (Ab)) then
            raise ARBRE_VIDE_EXCEPTION;
        elsif (not ( Is_Present (Ab, ID))) then
            Raise ID_ABSENT_EXCEPTION;
        else
            Get_Sub_Tree (Ab, ID_Tree);
            Afficher_Generations (ID_Tree);
            Afficher_Profondeur (ID_Tree, 0, "");
        end if;
    end Afficher_Arbre_Noeud;
	
    -------------------------------------------------------------------------------


    procedure Supprimer (Ab : in out T_ABG; ID : in Integer) is
        
        
        procedure Get_Sub_Tree (Ab : in T_ABG; ID_Tree : out T_ABG) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            else
                if (ID = Get_ID (Ab)) then
                    ID_Tree := Ab;
                else
                    Get_Sub_Tree (Get_Left (AB), ID_Tree);
                    Get_Sub_Tree (Get_Right (AB), ID_Tree);
                end if;
            end if;
        end Get_Sub_Tree;
        

        ID_Tree : T_ABG;
        
    begin
        if (Is_Empty (Ab)) then
            raise ARBRE_VIDE_EXCEPTION;
        elsif (not ( Is_Present (Ab, ID))) then
            Raise ID_ABSENT_EXCEPTION;
        else
            Get_Sub_Tree (Ab, ID_Tree);
        end if;
    end Supprimer;

    -------------------------------------------------------------------------------

    procedure Individus_1_Parent_Connu (Ab : in T_ABG) is
		

        procedure Person_1_Parent (Ab : in T_ABG; E : out T_Ensemble) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            else
                if (not (Is_Empty (Get_Left (AB))) and  Is_empty (Get_Right (AB))) then
                    Ajouter (E, Get_ID (Ab));
                elsif (Is_empty (Get_Left (AB)) and (not (Is_empty (Get_Right (AB))))) then
                    Ajouter (E, Get_ID (Ab));
                end if;
                Person_1_Parent (Get_Left (AB), E);
                Person_1_Parent (Get_Right (AB), E);
            end if;
        end Person_1_Parent;


        E : T_Ensemble;

	
    begin
        if (Is_Empty (Ab)) then
            raise ARBRE_VIDE_EXCEPTION;
        else
            Person_1_Parent (Ab, E);
            Display_Title_Set ("L'ensemble des individus qui n'ont qu'un parent connu", -1);
            To_String (E);
        end if;
    end Individus_1_Parent_Connu; 
	
    -------------------------------------------------------------------------------

    procedure Individus_2_Parent_Connu (Ab : in T_ABG) is

		
        procedure Person_2_Parent (Ab : in T_ABG; E : out T_Ensemble) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            elsif (not (Is_Empty (Get_Left (Ab))) and not(Is_Empty (Get_Right (Ab)))) then
                Ajouter (E, Get_ID (Ab));
            else
                Person_2_Parent (Get_Left (Ab), E);
                Person_2_Parent (Get_Right (Ab), E);
            end if;
        end Person_2_Parent;


        E : T_Ensemble;
        
	
    begin
        if (Is_Empty (Ab)) then
            raise ARBRE_VIDE_EXCEPTION;
        else
            Person_2_Parent (Ab, E);
            Display_Title_Set ("L'ensemble des individus qui ont les deux parents connus", -1);
            To_String (E);
        end if;
    end Individus_2_Parent_Connu;

    -------------------------------------------------------------------------------

    procedure Ensemble_Feuilles (Ab : in T_ABG) is
	        
		
        procedure Person_0_Parent (Ab : in T_ABG; E : out T_Ensemble) is
        begin 
            if (Is_Empty (Ab)) then
                Null;
            elsif (Is_Empty (Get_Left (Ab)) and Is_Empty (Get_Right (Ab))) then
                Ajouter (E, Get_ID (Ab));
            else
                Person_0_Parent (Get_Left (Ab), E);
                Person_0_Parent (Get_Right (Ab), E);
            end if;
        end Person_0_Parent;
		
        E : T_Ensemble;
    
    
    begin
        if (Is_Empty (Ab)) then
            raise ARBRE_VIDE_EXCEPTION;
        else
            Person_0_Parent (Ab, E);
            Display_Title_Set ("L'ensemble des individus qui n'ont aucun parent connu", -1);
            To_String (E);
        end if;
    end Ensemble_Feuilles;

    -------------------------------------------------------------------------------
    
    -- Identifier les ancêtres d'un individu donné sur N generations données par un noeud donné.
    procedure Ancetres_Sur_N_Generation (Ab : in T_ABG; ID : in Integer; Generation : in Integer) is
        
        
        procedure Ancestor_N_Generation (Ab : in T_ABG; E : in out T_Ensemble; Generation : in Integer) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            elsif (Generation >= 0 and not (Is_Empty (Ab))) then
                Ajouter (E, Get_ID (Ab));
            else
                Ancestor_N_Generation (Get_Left (Ab), E, Generation - 1);
                Ancestor_N_Generation (Get_Right (Ab), E, Generation - 1);
            end if;
        end Ancestor_N_Generation;
	

        procedure Find_Person (Ab : in T_ABG; E : in out T_Ensemble; ID : in Integer; Generation : in Integer) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            else
                if (ID = Get_ID (Ab)) then
                    Ancestor_N_Generation (Ab, E, Generation);
                else
                    Find_Person (Get_Left (AB), E, ID, Generation);
                    Find_Person (Get_Right (AB), E, ID, Generation);
                end if;
            end if;
        end Find_Person;


        E : T_Ensemble;
	
	
    begin
        find_person (Ab, E, ID, Generation);
        Display_Title_Set ("L'ensemble des ancetres sur", Generation);
        To_String (E);
    end Ancetres_Sur_N_Generation;

    -------------------------------------------------------------------------------
    
    -- Vérifier que deux individus n et m ont un ou plusieurs ancêtres homonymes (mêmes non et prénom).
    function Ancetres_Homonymes (Ab : in T_ABG; R : in T_Registre; ID1 : in Integer; ID2 : in Integer) return Boolean is
        
        
        procedure Get_Sub_Tree (Ab : in T_ABG; ID_Tree : out T_ABG; ID : in Integer) is
        begin
            if (Is_Empty (Ab)) then
                Null;
            else
                if (ID = Get_ID (Ab)) then
                    ID_Tree := Ab;
                else
                    Get_Sub_Tree (Get_Left (AB), ID_Tree, ID);
                    Get_Sub_Tree (Get_Right (AB), ID_Tree, ID);
                end if;
            end if;
        end Get_Sub_Tree;
        
        
        
        procedure Compare_ID_Tree (ID : in Integer; Ab2 : in T_ABG; R : in T_Registre; Res : out Boolean) is
        begin
            if (Is_Empty (Ab2)) then
                Null;
            elsif (not (Is_Empty (Ab2))) then
                
                if (Get_Last_Name (La_Donnee_R (R, ID)) = Get_Last_Name (La_Donnee_R (R, Get_ID (Ab2))) and 
                            Get_First_Name (La_Donnee_R (R, ID)) = Get_First_Name (La_Donnee_R (R, Get_ID (Ab2))))  then
                    Res := True;
                else
                    Compare_ID_Tree (ID, Get_Left (Ab2), R, Res);
                    Compare_ID_Tree (ID, Get_Right (Ab2), R, Res);
                end if;
            end if;
        end Compare_ID_Tree;
            
            
        procedure homonym_research (Ab1, Ab2 : in T_ABG; R : in T_Registre; Res : out Boolean) is
        begin
            if (Is_Empty (Ab1)) then
                Null;
            else
                Compare_ID_Tree (Get_ID (Ab1), Ab2, R, Res);
                homonym_research (Get_Left (Ab1), Ab2, R, Res);
                homonym_research (Get_Right (Ab1), Ab2, R, Res);
            end if;
        end homonym_research;
        
        
        Ab1, Ab2 : T_ABG;
        Res : Boolean;
        
        
    begin
        if (Is_Empty (Ab)) then
            raise ARBRE_VIDE_EXCEPTION;
        elsif ((not (Is_Present (Ab, ID1))) or (not (Is_Present (Ab, ID1)))) then
            Raise ID_ABSENT_EXCEPTION;
        else
            Res := False;
            Get_Sub_Tree (Ab, Ab1, ID1);
            Get_Sub_Tree (Ab, Ab2, ID2);
            homonym_research (Ab1, Ab2, R, Res);
            return Res;
        end if;
    end Ancetres_Homonymes;

    -------------------------------------------------------------------------------

end Arbre_Genealogique;
