% �valuation
%

Remarque : �valuation automatique dans evaluation-auto.txt

# Sp�cification du module ensemble (5 pt) : 3

Fichiers : ensembles_tableau.ads et ensembles_chainage.ads

(E5) Dans le tableau suivant, X ou un nombre de points de p�nalit� dans une
case indique que l'erreur appara�t pour ce SP.  Les num�ros de sous-programme
correspondent � :

1. Savoir si un ensemble est vide ou pas
2. Obtenir la taille d�un ensemble (le nombre d��l�ments qu�il contient).
3. Savoir si un �l�ment est pr�sent dans un ensemble.
4. Ajouter un �l�ment dans un ensemble.
5. Supprimer un �l�ment d�un ensemble.
6. Initialiser et D�truire
7. Appliquer_Sur_Tous n'est pas dans le tableau

+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
|                                 |      Ensembles_Tableau            ||     Ensembles_Chainage            |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
|                           | pts | SP1 | SP2 | SP3 | SP4 | SP5 | SP6 || SP1 | SP2 | SP3 | SP4 | SP5 | SP6 |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Signature incorrecte      |  1  |     |     |     |     |     |     ||     |     |     |     |     |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Objectifs impr�cis        | .5  |     |     |     |     |     |     ||     |     |     |     |     |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Param�tres mal d�crits    | .5  |   Param�tre non expliqu�s        ||  Param�tre non expliqu�s     |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Erreur sur pr�condition   | .5  |     |     |     |     |     |     ||     |     |     |  X  |     |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Erreur sur postcondition  | .5  |     |     |     |     |     |     ||     |  X  |     |     |     |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+


# Implantation du module ensemble (7 pt) : 7

Fichiers : ensembles_tableau.adb et ensembles_chainage.adb

1 pt perdu pas erreur d'implantation d'un sous-programme (.5 pt si maladresse non list�e dans la suite) :

+--------------+------------------------------+------------------------------+
| sous-prog.   |      Ensembles_Tableau       |      Ensembles_Chainage      |
+--------------+------------------------------+------------------------------+
| est vide     |                              |                              |
+--------------+------------------------------+------------------------------+
| taille       |                              |                              |
+--------------+------------------------------+------------------------------+
| est_present  |                              |                              | 
+--------------+------------------------------+------------------------------+
| ajouter      |                              |                              |
+--------------+------------------------------+------------------------------+
| supprimer    |                              |                              |
+--------------+------------------------------+------------------------------+
| initialiser  |                              |                              |
+--------------+------------------------------+------------------------------+
| detruire     |                              |                              |
+--------------+------------------------------+------------------------------+
| appliquer    |                              |                              |
+--------------+------------------------------+------------------------------+


# Les programmes (5 pt) : 3

Fichiers : scenario_tableau.adb, scenario_chainage.adb, nombre_moyen_tirages_tableau.adb, nombre_moyen_tirages_chainage.adb, test_ensembles_tableau.adb et test_ensembles_chainage.adb.

+---------------------------------+----------+--------+--------++----------+--------+--------+
|                                 |       Ensembles_Tableau    ||     Ensembles_Chainage     |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+
|                       |   pts   | Sc�nario | Nombre |  Test  || Sc�nario | Nombre |  Test  |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+
| Erreur de compilation |  2 * 1  |          |   X    |        ||          |        |        |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+
| Erreur d'ex�cution    | 2 * .5  |          |   X    |        ||          |        |        |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+
| Erreur valgrind       | 2 * .5  |          |   X    |        ||          |        |        |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+


    
    
# LISEZ-MOI.txt (3 pt) : 2

Mauvaises r�ponses (ou pas de r�ponse) aux questions suivantes (.5 pt) :

* Question 5 (Supprimer avec une affectation)
* Question 6 (Efficacit�)

# Note finale : 15
