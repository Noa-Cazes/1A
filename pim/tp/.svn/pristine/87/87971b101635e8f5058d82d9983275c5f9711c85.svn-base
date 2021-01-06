with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

-- Objectif : Afficher un tableau trié suivant le principe du tri par sélection.

procedure Tri_Selection is

    CAPACITE: constant Integer := 10;   -- la capacité du tableau
    Min : Integer;
    Pos : Integer;
    
    type Tableau_Entier is array (1..CAPACITE) of Integer;

    type Tableau is
        record
            Elements : Tableau_Entier;
            Taille   : Integer;         --{ Taille in [0..CAPACITE] }
        end record;


    -- Objectif : Afficher le tableau Tab.
    -- Paramètres :
    --     Tab : le tableau à afficher
    -- Nécessite : ---
    -- Assure : Le tableau est affiché.
    procedure Afficher (Tab : in Tableau) is
    begin
        Put ("[");
        if Tab.Taille > 0 then
            -- Afficher le premier élément
            Put (Tab.Elements (1), 1);

            -- Afficher les autres éléments
            for Indice in 2..Tab.Taille loop
                Put (", ");
                Put (Tab.Elements (Indice), 1);
            end loop;
        end if;
        Put ("]");
    end Afficher;


    Tab1 : Tableau;
begin
    -- Initialiser le tableau
    Tab1 := ( (1, 3, 4, 2, others => 0), 4);

    -- Afficher le tableau
    Afficher (Tab1);
    New_Line;
    For i in 1..Tab1.Taille loop
	For j in i..Tab1.Taille loop
	    Min :=Tab1.Elements(i);
	    Pos := i;
	    For k in i..Tab1.Taille loop
	        If Tab1.Elements(k) < Tab1.Elements(i) then
		        Min := Tab1.Elements(k);
			Pos := k;
		end if;
	    Tab1.Elements(Pos) := Tab1.Elements(i);
	    Tab1.Elements(i) := Min;
	    end loop; 
        end loop;
    end loop;
    Afficher (Tab1);
end Tri_Selection;
