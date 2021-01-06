

with Ada.Unchecked_Deallocation;
with Ada.Text_IO; use Ada.Text_IO;


package body registre is


    ----------------------------------Constuctor--------------------------------

    function Initialiser_Donnee (Nom : in Unbounded_String; Prenom : in Unbounded_String;
                                 Date_N : in Integer; Lieu_N : in Unbounded_String;
                                 Date_D : in Integer; Lieu_D : in Unbounded_String;
                                 Sexe : in Character; Email : in Unbounded_String;
                                 Tel : in Integer; Concubain : in Integer; Age : in Integer) return T_Donnee is
        Donnee : T_Donnee;
    begin
        Donnee := (Nom, Prenom, Date_N, Lieu_N, Date_D, Lieu_D, Sexe, Email, Tel, Concubain, Age);
        return Donnee;
    end Initialiser_Donnee;

    -----------------------------------Getters----------------------------------

    --Obtenir le nom d'un individu.
    function Get_Last_Name (Data : in T_Donnee) return Unbounded_String is
    begin
        return Data.Nom;
    end Get_Last_Name;


    --Obtenir le prénom d'un individu.
    function Get_First_Name (Data : in T_Donnee) return Unbounded_String is
    begin
        return Data.Nom;
    end Get_First_Name;


    -- Obtenir la date de naissance d'un individu.
    function Get_Birthday (Data : in T_Donnee) return Integer is
    begin
        return Data.Date_N;
    end Get_Birthday;


    -- Obtenir le lieu de naissance d'un individu.
    function Get_Birthplace (Data : in T_Donnee) return Unbounded_String is
    begin
        return Data.Lieu_N;
    end Get_Birthplace;


    -- Obtenir la date de decés d'un individu.
    function Get_Deathday (Data : in T_Donnee) return Integer is
    begin
        return Data.Date_D;
    end Get_Deathday;


    -- Obtenir la lieu de decés d'un individu.
    function Get_Deathplace (Data : in T_Donnee) return Unbounded_String is
    begin
        return Data.Lieu_D;
    end Get_Deathplace;


    -- Obtenir le sexe d'un individu.
    function Get_Sex (Data : in T_Donnee) return Character is
    begin
        return Data.Sexe;
    end Get_Sex;


    -- Obtenir l'email d'un individu.
    function Get_Email (Data : in T_Donnee) return Unbounded_String is
    begin
        return Data.Email;
    end Get_Email;


    -- Obtenir le telephone d'un individu.
    function Get_Tel (Data : in T_Donnee) return Integer is
    begin
        return Data.Tel;
    end Get_Tel;


    -- Obtenir l'ID du concubain d'un individu.
    function Get_Cohabitant_ID (Data : in T_Donnee) return Integer is
    begin
        return Data.Concubain;
    end Get_Cohabitant_ID;


    -- Obtenir l'age d'un individu.
    function Get_Age (Data : in T_Donnee) return Integer is
    begin
        return Data.Age;
    end Get_Age;

    ----------------------------------------------------------------------------

    -- Libérer la mémoire.
    procedure Free is
            new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_Registre);



    function Ecart_Age_Parent_Enfant_R (Registre : in T_Registre ; Id : in Integer ; Parents : in T_Tab) return Boolean is
        Age_Parent1 : Integer;
        Age_Parent2 : Integer;
        Age_Enfant : Integer;
        Diff1 : Integer;
        Diff2 : Integer;
    begin
        if Parents.Taille = 0 then
            return False;
        elsif Parents.Taille = 1 then
            Age_Parent1 := La_Donnee_R(Registre, Parents.Elt(1)).Age;
            Age_Enfant :=  La_Donnee_R(Registre, Id).Age;
            Diff1 := Age_Parent1 - Age_Enfant + 1;
            if Diff1 >= 18 then
                return True;
            else
                raise Ecart_Age_Parent_Enfant_Exception;
                return False;
            end if;
        else -- Taille(Parents) = 2
            Age_Parent1 := La_Donnee_R(Registre, Parents.Elt(1)).Age;
            Age_Parent2 := La_Donnee_R(Registre, Parents.Elt(2)).Age;
            Age_Enfant :=  La_Donnee_R(Registre, Id).Age;
            Diff1 := Age_Parent1 - Age_Enfant + 1;
            Diff2 := Age_Parent2 - Age_Enfant + 1;

            if Diff1 >= 18  and then Diff2 >= 18 then
                return True;
            else
                raise Ecart_Age_Parent_Enfant_Exception;
            end if;
        end if;
    end Ecart_Age_Parent_Enfant_R;


    procedure Registre_Vide (Registre : in T_Registre) is
    begin
        if Registre = Null then
            raise Registre_Vide_Exception;
        else
            Null;
        end if;
    end Registre_Vide;


    procedure Initialiser_R (Registre : out T_Registre) is
    begin
        Registre := Null;
    end Initialiser_R;


    function Est_Vide_R (Registre : in T_Registre) return Boolean is
    begin
        return (Registre = Null);
    end Est_Vide_R;


    function Taille_R (Registre : in T_Registre) return Integer is
    begin
        if Registre = Null then
            return 0;
        else
            return (1 + Taille_R(Registre.all.Suivant));
        end if;
    end Taille_R;


    procedure Inserer_R (Registre : in out T_Registre ; Id : in Integer ; Donnee : in T_Donnee) is
        Courant : T_Registre;
        Precedent : T_Registre;
        Registre1 : T_Registre;  -- pointe vers l'élément à insérer
    begin
        if (Est_Vide_R (Registre) or else Registre.all.ID > ID) then
            Registre1 := New T_Cellule'(ID, Donnee, Registre);
            Registre := Registre1;
        else
            Courant := Registre;
            while (Courant /= Null) and then (Courant.all.Id < Id) loop
                Precedent := Courant;
                Courant := Courant.all.Suivant;

            end loop;
            Registre1 := new T_Cellule'(Id, Donnee, Null);
            Registre1.all.Suivant := Courant;
            Precedent.all.Suivant := Registre1;
        end if;
        --exception
        --  when Id_Present_Exception_R => Put_Line("L'identifiant est présent.");
    end Inserer_R;


    procedure Modifier_R (Registre : in out T_Registre ; Id : in Integer ; Donnee : in T_Donnee) is
    begin
        if Registre.all.Id = Id then
            Registre.all.Donnee := Donnee;
        else
            Modifier_R(Registre.all.Suivant, Id, Donnee);
        end if;
    exception
        when Id_Absent_Exception_R => Put_Line("L'identifiant n'est pas présent");
    end Modifier_R;


    procedure Supprimer_R (Registre : in out T_Registre ; Id : in Integer) is
        Registre1 : T_Registre;
    begin
        Registre1 := Registre;
        if Registre.all.Id = Id then
            Registre1 := Registre1.all.Suivant;
            Free(Registre);
            Registre := Registre1;
        else
            Supprimer_R(Registre.all.Suivant, Id);
        end if;
    exception
        when Id_Absent_Exception_R => Put_Line("L'identifiant n'est pas présent");
    end Supprimer_R;


    function La_Donnee_R (Registre : in T_Registre ; Id : in Integer) return T_Donnee is
        Donnee_Null : Constant T_Donnee := Initialiser_Donnee(To_Unbounded_String("Inconnu"), To_Unbounded_String("Inconnu"), 00000000, To_Unbounded_String("Inconnu"), 00000000, To_Unbounded_String("Inconnu"), '0',To_Unbounded_String("Inconnu"), 0000000000, 0, 00);
    begin

        if Registre /= Null and then Registre.all.Id = Id then
            return (Registre.all.Donnee);
        elsif Registre /= Null and then Registre.all.Id /= Id then
            return(La_Donnee_R(Registre.all.Suivant, Id));
        else
            return Donnee_Null;
        end if;
        --          else
        --              raise Registre_Vide_Exception;
        --      exception
        --          when Registre_Vide_Exception =>
        --              Put_Line("Le Registre est vide.");
        --              return Donnee_Null;
        --          when Id_Absent_Exception_R =>
        --              Put_Line("L'Id n'est pas présent dans le registre.");
        --              return Donnee_Null;

    end La_Donnee_R;




    procedure Vider_R (Registre : in out T_Registre) is
    begin
        if Registre = Null then
            Null;
        else
            Vider_R(Registre.all.Suivant);
            Free(Registre);
        end if;
    end Vider_R;


end registre;

