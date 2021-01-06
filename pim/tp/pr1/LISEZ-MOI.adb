-- Cazes, groupe de TP CM1C
-- R0: Réviser les tables de multiplications en affichant pour une table donnée les opérations à affectuer, et en affichant des messages en fonction du
-- nombre d'erreurs commmises.
-- Tests:
-- 7 * 2 -> 14
-- 7 * 3 -> 21
-- 7 * 4 -> 26
-- 7 * 6 -> 42
-- 7 * 7 -> 49
-- 7 * 1 -> 7
-- 7 * 8 -> 56
-- 7 * 5 -> 35
-- 7 * 9 -> 63
-- 7 * 10 -> 70
-- => affiche "Une seule erreur. Très bien."
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Alea;
with Ada.Calendar;         use Ada.Calendar;


procedure Multiplications is

    -- déclarations des variables du programme principal
    N: Integer;             -- entier lu au clavier
    N_Aleatoire: Integer;   -- nombre généré aléatoirement entre 1 et 10 inclus
    N_Duree_Max: Float;     -- variable où on a placé le nombre alétoire correspondant au temps de réponse maximal
    Duree_Max: Duration;       -- temps de réponse maximal
    Temps_Debut: Time;     -- heure à laquelle la question est posée
    Temps_Fin: Time;       -- heure à laquelle la personne a répondu
    Duree: Duration;       -- durée de la réponse
    Temps_Moyen: Duration; -- Temps de réponse moyen
    Resultat: Float;        -- résultat de la réponse
    Nbre_Erreur: Integer;   -- nombre d'erreur au cours de la révision d'une table
    Somme: Integer;         --pour calculer le temps moyen de réponse

    -- déclaration du paquetage Mon_Alea
    package Mon_Alea is new Alea(1,10); -- gnéérateur de nombres dans l'intervalle [1,10]
    use Mon_Alea;

    -- implémentation du corps du programme
    begin
        loop
            loop
                Put("Saisir le numéro N de la table, entre 1 et 10, que vous souhaitiez réviser:");
                Get(N);      -- entier lu au clavier
            exit when N>=1 or N<=10;
            end loop;        -- N entier compris entre 1 et 10, bornes incluses
            Put_Line("Table à réviser:" & N);
            N_Aleatoire := 1; -- initialisée de façon quelconque
            N_Duree_max := 0; -- initialisée à 0, chiffre non tiré aléatoirement, pour enlever toute ambiguîté.
            Duree_Max := 0;   -- initialisée à 0, car ne sera pas gardé en tant que tant de réponse maximal, car absurde.
            Somme := 0;       -- pour calculer la moyenne des temps de réponse.
            for i in 1..10 loop
                Get_Random_Number (N_Aleatoire); -- N_Aleatoire est un entier généré entre 1 et 10.
                Temps_debut := Clock; -- plaçé avant l'écriture de la question, mais cela n'a pas d'importance, dans la mesure où on compare les valeurs entre elles.
                Put_Line ("(M" & i & ")" & N & "*" & N_Aleatoire & "?");
                Get(Resultat); -- résultat de la multiplication entré par l'utilisateur
                Temps_Fin := Clock;
                Duree :=  Temps_Fin - Temps_Debut;
                S :=  S + Duree;
                if Duree < Duree_Max then
                    Duree_Max := Duree;
                    N_Duree_Max := N_Aléatoire;
                else
                    null;
                end if;
                Nbre_Erreur := 0;
                if Resultat = N * N_Aleatoire then
                    Put ("Bravo!");
                else
                    Put ("Mauvaise réponse");
                    Nbre_Erreur :=  Nbre_Erreur + 1;
                end if;
            end for;
            if Nbre_Erreur =0 then
                Put("Aucune erreur. Excellent!");
            elsif Nbre_Erreur =1 then
                Put("Une seule erreur. Très bien.");
            elsif Nbre_Erreur =10 then
                Put("Tout est faux ! Volontaire ?");
            elsif Nbre_Erreur =< 5 then
                Put_Line ("Seulement" & Nbre_Erreur & "bonnes réponses. Il faut apprendre la table de" & N & "!");
            else
                Put(Nbre_Erreur & "erreurs. Il faut encore travailler la table de" & N & ".");
            end if;
            Temps_Moyen := S/10;
            if Duree_Max >= Temps_Moyen + 1 then -- temps de réponse moyen + 1 seconde
                Put_Line("Des hésitations sur la table de" & N_Duree_Max & ":" & Duration'Image(Duree_Max) & "secondes contre" & Duration'Image(Temps_Moyen) & ". Il faut certainement la réviser.");
            else
                null;
            end if;
        exit when Reponse = non;
	end loop; -- reponse=non, l'utilisateur veut arrêter de réviser
    end;

end Multiplications;
