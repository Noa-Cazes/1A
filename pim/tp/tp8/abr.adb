with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body ABR is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Noeud, Name => T_ABR);


	procedure Initialiser(Abr: out T_ABR) is
	begin
            Abr := Null;
	end Initialiser;


	function Est_Vide (Abr : T_Abr) return Boolean is
	begin
		return (Abr = Null);
	end;


        function Taille (Abr : in T_ABR) return Integer is
	begin
            if Abr = Null then
                return 0;
            else
                return( 1 + Taille (Abr.all.Sous_Arbre_Gauche) + Taille (Abr.all.Sous_Arbre_Droit));
            end if;
	end Taille;


	procedure Inserer (Abr : in out T_ABR ; Cle : in Character ; Donnee : in Integer) is
	begin
            if Abr = Null then
                Abr := new T_Noeud'(Cle, Donnee, Null, Null);
            elsif Abr.all.Cle < Cle then
                Inserer(Abr.all.Sous_Arbre_Droit, Cle, Donnee);
            elsif Abr.all.Cle > Cle then
                Inserer(Abr.all.Sous_Arbre_Gauche, Cle, Donnee);
            else -- Abr.all.Cle = Cle
                raise Cle_Presente_Exception;
            end if;

	end Inserer;

        function Le_Noeud (Abr : in T_ABR; Cle : Character) return T_ABR is

        begin
            if Abr = Null then
                raise Cle_Absente_Exception;
            elsif Abr.all.Cle < Cle then
                return Le_Noeud (Abr.all.Sous_Arbre_Droit, Cle);
            elsif Abr.all.Cle > Cle then
                return Le_Noeud (Abr.all.Sous_Arbre_Gauche, Cle);
            else -- Abr.all.Cle = Cle
                return Abr;
            end if;
        end Le_Noeud;

	procedure Modifier (Abr : in out T_ABR ; Cle : in Character ; Donnee : in Integer) is
        begin
            Le_Noeud(Abr, Cle).all.Donnee := Donnee;
	end Modifier;


        function La_Donnee (Abr : in T_ABR ; Cle : in Character) return Integer is
   	begin
            return(Le_Noeud(Abr, Cle).all.Donnee);
	end La_Donnee;


        procedure Decrocher_Min (Abr : in out T_ABR; Min : out T_Abr) is

        begin
            if Abr.all.Sous_Arbre_Gauche = Null then  -- car les plus petites clés sont à gauche
                Min := Abr;
                Abr := Abr.all.Sous_Arbre_Droit;  -- on le décroche
            else
                Decrocher_Min (Abr.all.Sous_Arbre_Gauche, Min);
            end if;
        end Decrocher_Min;


    procedure Supprimer (Abr : in out T_ABR ; Cle : in Character) is
        A_Detruire : T_ABR;
    begin
        if Abr = Null then
            raise Cle_Absente_Exception;
        elsif Abr.all.Cle < Cle then
            Supprimer(Abr.all.Sous_Arbre_Droit, Cle);
        elsif Abr.all.Cle > Cle then
            Supprimer(Abr.all.Sous_Arbre_Gauche, Cle);
        else -- Abr.all.Cle = Cle
             -- Supprimer le noeud Abr
            A_Detruire := Abr;
            if Abr.all.Sous_Arbre_Gauche = Null then
                Abr := Abr.all.Sous_Arbre_Droit;
            elsif Abr.all.Sous_Arbre_Droit = Null then
                Abr := Abr.all.Sous_Arbre_Gauche;
            else
                declare
                    Min : T_ABR;
                begin
                    Decrocher_Min(Abr.all.Sous_Arbre_Droit, Min);
                    Min.all.Sous_Arbre_Gauche := Abr.all.Sous_Arbre_Gauche;
                    Min.all.Sous_Arbre_Gauche := Abr.all.Sous_Arbre_Gauche;
                    Abr := Min;
                end;
            end if;
        Free (A_Detruire);
        end if;
    end Supprimer;




    procedure Vider (Abr : in out T_ABR) is
	begin
            if Abr = Null then
                Null;
            else
                Vider(Abr.all.Sous_Arbre_Gauche);
                Vider(Abr.all.Sous_Arbre_Droit);
                Free(Abr);
        end if;
    end Vider;


    procedure Afficher (Abr : in T_Abr) is
    begin
        if Abr = Null then
            Null;
        else
            Afficher (Abr.all.Sous_Arbre_Gauche);
            Put (Abr.all.Cle);
            Put (" : ");
            Put (Abr.all.Donnee, 0);
            New_Line;
            Afficher(Abr.all.Sous_Arbre_Droit);
        end if;
    end Afficher;


    procedure Afficher_Debug (Abr : in T_Abr) is

        procedure Indenter (Decalage : in Integer) is
        begin
            for I in 1..Decalage loop
                Put(' ');
            end loop;
        end Indenter;

        -- Afficher un arbre à la profondeur Profondeur et qui a du côté
        -- indiqué (< pour Gauche et > pour droit, - pour la racine).
        procedure Afficher_Profondeur (Abr : in T_ABR ; Profondeur : in Integer ; Cote : in Character) is
        begin
            if Abr = Null then
                Null;
            else
                Indenter (Profondeur * 4);
                Put (Cote & ' ');
                Put (Abr.all.Cle);
                Put (" : ");
                Put (Abr.all.Donnee, 0);
                New_Line;

                Afficher_Profondeur (Abr.all.Sous_Arbre_Gauche, Profondeur + 1, '<');
                Afficher_Profondeur (Abr.all.Sous_Arbre_Droit, Profondeur + 1, '>');
            end if;
        end Afficher_Profondeur;
    begin
        Afficher_Profondeur(Abr, 0, '-');
    end Afficher_Debug;




end ABR;
