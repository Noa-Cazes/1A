with Ensembles_Chainage;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Test_Ensembles_Chainage is
    -- déclaration du paquetage Mon_Ensemble
    package Mon_Ensemble is new Ensembles_Chainage(T_Elts => Integer);
    use Mon_Ensemble;

    -- sous-programme qui permet d'afficher un entier
    procedure Afficher_Entier (Entier : in Integer) is
    begin
        Put("           ");
        Put(Entier,1);
    end Afficher_Entier;

    -- sous-programme qui permet d'afficher un ensemble
    procedure Afficher is new Appliquer_Sur_Tous(Operation => Afficher_Entier);



    -- sous-programme qui permet d'initiliser l'ensemble Ens, et d'y ajouter deux entiers.
    procedure Initialiser_Avec_78 (Ens : in out T_Ensemble) is
    begin
        Initialiser(Ens);
        Ajouter(Ens,7);
        Ajouter(Ens,8);
    end Initialiser_Avec_78;

    -- sous-programme qui teste la procedure Est_Vide et Initialiser
    procedure Tester_Est_Vide is
        Ens1, Ens2 : T_Ensemble;
    begin
        Initialiser (Ens1);
        pragma Assert (Taille_Ensemble(Ens1) = 0);

        Ajouter (Ens1,5);
        pragma Assert (not(Est_Vide(Ens1)));
        Detruire(Ens1);

        Initialiser_Avec_78 (Ens2);
        pragma Assert (not(Est_Vide(Ens2)));
        Detruire(Ens2);

    end Tester_Est_Vide;


    -- sous-programme qui permet de tester la procédure ajouter
    procedure Tester_Ajouter is
        Ens : T_Ensemble;
    begin
        Initialiser_Avec_78(Ens);
        Ajouter(Ens,9);
        pragma Assert (Present(Ens,9));
        Detruire(Ens);
    end Tester_Ajouter;

    -- sous-programme qui permet de tester la procédure supprimer
    procedure Tester_Supprimer is
        Ens : T_Ensemble;
    begin
        Initialiser_Avec_78(Ens);
        Supprimer(Ens,7);
        pragma Assert (Present(Ens,8));
        Supprimer(Ens,8);
        pragma Assert (Est_Vide(Ens));
        Detruire(Ens);
    end Tester_Supprimer;


    -- sous-programme qui permet de tester la procédure Present
    procedure Tester_Present is
        Ens : T_Ensemble;
    begin
        Initialiser_Avec_78(Ens);
        pragma Assert(Present(Ens,7));
        pragma Assert(Present(Ens,8));
        Detruire(Ens);
    end Tester_Present;

    -- sous-programme qui permet de tester la procédure Taille_Ensemble
    procedure Tester_Taille_Ensemble is
        Ens : T_Ensemble;
    begin
        Initialiser_Avec_78(Ens);
        pragma Assert(Taille_Ensemble(Ens)=2);
        Ajouter(Ens,9);
        pragma Assert(Taille_Ensemble(Ens)=3);
        Detruire(Ens);
    end Tester_Taille_Ensemble;

    -- sous-programme qui permet de tester la procédure Appliquer_Sur_Tous
    procedure Tester_Appliquer_Sur_Tous is
        Ens : T_Ensemble;
    begin
        Initialiser_Avec_78(Ens);
        Ajouter(Ens,9);
        Ajouter(Ens,10);
        Afficher(Ens);
        Detruire(Ens);
    end Tester_Appliquer_Sur_Tous;

begin
    Tester_Est_Vide;
    Tester_Ajouter;
    Tester_Supprimer;
    Tester_Present;
    Tester_Taille_Ensemble;
    Tester_Appliquer_Sur_Tous;

end Test_Ensembles_Chainage;
