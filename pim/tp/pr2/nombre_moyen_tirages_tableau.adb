with Ensembles_Tableau;
with Alea;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

procedure nombre_moyen_tirage_chainage is

    -- déclaration des variables de la procédure
    Min : constant Integer := 1;                 -- Valeur de la borne min
    Max : constant Integer := 60;                -- Valeur de la borne max
    Diff : constant Integer := (Max - Min + 1);  -- Nombre d'éléments dans l'intervalle [Min,Max]

    -- déclaration du paquetage Mon_Alea
    -- pour pouvoir générer des nombres aléatoires entre Min et Max
    package Mon_Alea is new Alea (Min,Max);
    use Mon_Alea;

    -- déclaration du paquetage Mon_Ensemble
    package Mon_Ensemble is new Ensembles_Chainage(Capacite => Diff, T_Elts => Integer);
    use Mon_Ensemble;

    -- déclaration des variables de la procédure
    Nbre : Float;               -- nbre de tirages réalisés
    Nbre_Moyen : Float;         -- nombre moyen de tirages réalisés
    Genere : Integer;           -- nombre aléatoire généré
    Ens : T_Ensemble;           -- tableau où est rangé les éléments de Min à Max

begin
    Nbre := 0.0;
    for i in 1..100 loop
        Initialiser(Ens);
        loop
            Get_Random_Number(Genere);                      -- génére un nombre aléatoire entre Min et Max
            if not Present(Ens, Genere) then                -- si le nombre généré n'est pas dans le tableau, alors il est un élément "nouveau" compris entre Min et Max
                Ajouter (Ens, Genere);
            else
                null;                                       -- si le nombre généré est dans le tableau, on ne le rajoute pas, car on ne s'interesse pas aux occurences de ce nombre
            end if;
            Nbre := Nbre + 1.0;                             -- nombre de passages dans la boucle
            exit when Taille_Ensemble(Ens) = Diff ;
            -- Taille_Ensemble(Ens) = Diff
        end loop;
    end loop;
    Nbre_Moyen := Nbre / (100.0);                           -- calcul de la moyenne
    Put_Line ("Le nombre moyen de tirages est : ");
    Put (Nbre_Moyen);                                       -- affichage de la moyenne
end nombre_moyen_tirages_tableau;

