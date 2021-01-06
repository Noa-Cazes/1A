--------------------------------------------------------------------------------
--  Auteur   : Cazes Noa
--  Objectif : Réviser les tables de multiplications en affichant pour une table donnée les opérations à affectuer, et en affichant des messages en fonction du
-- nombre d'erreurs commmises.
-------------------------------------------------------------------------------


-- Cazes, groupe de TP CM1C
-- R0: Réviser les tables de multiplications en affichant pour une table donnée les opérations à affectuer, et en affichant des messages en fonction du
-- nombre d'erreurs commmises.
-- procedure Multiplication
-- 


with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Calendar;          use Ada.Calendar;
With Alea;

-- Faire réviser les tables de multiplications
procedure Multiplications is

    -- déclarations des variables du programme principal
    N: Integer;                 -- entier lu au clavier
    N_Aleatoire: Integer;       -- nombre généré aléatoirement entre 1 et 10 inclus
    N_Duree_Max: Integer;       -- variable où on a placé le nombre alétoire correspondant au temps de réponse maximal
    Duree_Max: Duration;        -- temps de réponse maximal
    Temps_Debut: Time;          -- heure à laquelle la question est posée
    Temps_Fin: Time;            -- heure à laquelle la personne a répondu
    Duree: Duration;            -- temps mis pour répondre à une question
    Temps_Moyen: Duration;      -- temps de réponse moyen
    Resultat: Integer;          -- résultat de la réponse
    Nbre_Erreur: Integer;       -- nombre d'erreurs au cours de la révision d'une table
    Somme: Duration;            -- pour calculer le temps moyen de réponse
    Reponse: Character;         -- réponse à la question "On continue?"
    Stop: Boolean;              -- Condition d'arrêt du programme
    Condition_Sortie: Boolean;  -- Condition de sortie de la boucle concernant le numéro de la table à entrer
     
    -- déclaration du paquetage Mon_Alea
    package Mon_Alea is new Alea(1,10); -- gnéérateur de nombres dans l'intervalle [1,10]
    use Mon_Alea;

    -- implémentation du corps du programme
    begin
        loop                             -- les variables ont bien une valeur, elle sont initialisées au moment où il y en aura besoin.
            loop                         
                Put("Saisir le numéro N de la table, entre 1 et 10, que vous souhaitiez réviser : ");
                Get(N);                  -- entier lu au clavier
                Skip_Line;
                if N < 1 or N >10 then   -- pour expliquer à l'utilisateur son erreur
                    Put_Line("Le numéro de la table doit être compris entre 1 et 10.");
                    New_line;
                else
                    null;
                end if;
                Condition_Sortie := (N >= 1 and N <=10); 
            exit when Condition_Sortie;  -- en se basant sur la bonne compréhension de l'utilisateur, la boucle se termine. 
            end loop;                    -- N entier compris entre 1 et 10, bornes incluses
            Put("Table à réviser : ");   -- écriture de la table à réviser
            Put(N,1);
            New_Line;
            N_Aleatoire := 1;            -- initialisée de façon quelconque
            N_Duree_max := 0;            -- initialisée à 0, chiffre non tiré aléatoirement, pour enlever toute ambiguîté.
            Duree_Max := 0.0;            -- initialisée à 0, car ne sera pas gardé en tant que tant de réponse maximal, car absurde.
            Somme := 0.0;                -- pour calculer la moyenne des temps de réponse.
            Nbre_Erreur := 0;            -- initialisation du nombree d'erreurs à 0, car le joeur ne démarrre pas en ayant des "points" négatifs. 
            for i in 1..10 loop          -- affichage de 10 multiplications.
                Get_Random_Number (N_Aleatoire); -- N_Aleatoire est un entier généré entre 1 et 10.
                New_Line;
                Temps_debut := Clock;               -- plaçé avant l'écriture de la question, mais cela n'a pas d'importance, dans la mesure où on compare les valeurs entre elles. Prends l'heure courante.
                Put("(M");                          -- affichage de la question
                Put(i,1); 
                Put(") ");
                Put(N,1);
                Put(" * " );
                Put(N_Aleatoire,1);
                Put(" ?");
                Get(Resultat);                      -- résultat de la multiplication entré par l'utilisateur
                Temps_Fin := Clock;                 -- prends l'heure courante.
                Duree :=  Temps_Fin - Temps_Debut;  -- temps mis pour répondre
                Somme :=  Somme + Duree;            -- ajout du dernier temps mesuré à la somme des précédents
                if Duree > Duree_Max then           -- détermination du temps maximal de réponse
                    Duree_Max := Duree;
                    N_Duree_Max := N_Aleatoire;
                else
                    null;
                end if;
                if Resultat = N * N_Aleatoire then  -- si le résultat est bon
                    Put_Line ("Bravo !");
                    New_Line;
                else                                -- si le résultat est faux
                    Put_Line ("Mauvaise réponse.");
                    New_Line;
                    Nbre_Erreur :=  Nbre_Erreur + 1;-- incrémentation du nombre d'erreur
                end if;
            end loop;
            if Nbre_Erreur =0 then
                Put_Line("Aucune erreur. Excellent!");
                New_Line;
            elsif Nbre_Erreur =1 then
                Put_Line("Une seule erreur. Très bien.");
                New_Line;
            elsif Nbre_Erreur =10 then
                Put_Line("Tout est faux ! Volontaire ?");
                New_Line;
            elsif Nbre_Erreur <= 5 then
                Put("Seulement ");
                Put(10-Nbre_Erreur,1);
                Put(" bonnes réponses. Il faut apprendre la table de ");
                Put(N,1);
                Put_Line("!");
                New_Line;
            else
                Put(Nbre_Erreur);
                Put(" erreur(s). Il faut encore travailler la table de " );
                Put(N,1);
                Put_Line(".");
                New_Line;
            end if;
            Temps_Moyen := Somme/10;               -- moyenne des temps de réponse
            if Duree_Max >= Temps_Moyen + 1.0 then -- temps de réponse moyen + 1 seconde
                Put("Des hésitations sur la table de ");
                Put(N_Duree_Max,1);
                Put(":");
                Put(Duration'Image(Duree_Max));
                Put(" secondes contre ");
                Put(Duration'Image(Temps_Moyen));
                Put_Line(". Il faut certainement la réviser.");
                New_Line;
            else
                null;
            end if; 
            Put_Line("On continue ? -");           -- demande si l'utilisateur souhaite refaire une série de 10 questions
            Put_Line("Si vous souhaitez continuer de réviser, veuillez saisir 'O'");
            Put_Line("Sinon veuillez saisir 'N'");
            Get(Reponse);
            Stop := (Reponse='N' or Reponse='n');  -- car on prévoit que l'utilisateur puisse entrer un 'n' ou 'N', sachant qu'avec Ada, une lettre minuscule ou majuscule représentent deux choses différentes. 
        exit when Stop;                            -- lors de la saisie de n ou N, la boucle se termine. 
        end loop;                                  -- reponse=non, l'utilisateur veut arrêter de réviser
    end Multiplications;

