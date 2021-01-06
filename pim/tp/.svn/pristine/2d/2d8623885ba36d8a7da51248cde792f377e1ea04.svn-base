with Ada.Text_IO;
use Ada.Text_IO;

-- Dans ce programme, les commentaires de spécification
-- ont **volontairement** été omis !

procedure Comprendre_Mode_Parametre is

    function Double (N : in Integer) return Integer is
    begin
        return 2 * N;
    end Double;

    procedure Incrementer (N : in out Integer) is
    begin
        N := N + 1;
    end Incrementer;

    procedure Mettre_A_Zero (N : out Integer) is
    begin
        N := 0;
    end Mettre_A_Zero;

    procedure Comprendre_Les_Contraintes_Sur_L_Appelant is
        A, B, R : Integer;
    begin
        A := 5;
        -- Indiquer pour chacune des instructions suivantes si elles sont
        -- acceptées par le compilateur.
        R := Double (A);  --acceptée
        R := Double (10); --acceptée
        R := Double (10 * A); --acceptée
        R := Double (B); --acceptée

        Incrementer (A);
        Incrementer (10); --pas acceptée, car il attend une variable N
        Incrementer (10 * A);  --pas acceptée, car il attend une variable N
        Incrementer (B);

        Mettre_A_Zero (A);
        Mettre_A_Zero (10);  --pas acceptée, car il attend une variable N
        Mettre_A_Zero (10 * A);  --pas acceptée, car il attend une variable N
        Mettre_A_Zero (B);  --pas acceptée
    end Comprendre_Les_Contraintes_Sur_L_Appelant;


    procedure Comprendre_Les_Contrainte_Dans_Le_Corps (
            A      : in Integer;
            B1, B2 : in out Integer;
            C1, C2 : out Integer)
    is
        L: Integer;
    begin
        -- pour chaque affectation suivante indiquer si elle est autorisée
        L := A;  --pas acceptée, car affectée en dessous
        A := 1;  --pas acceptée, car A es en in, on ne peut pas faire d'affectation

        B1 := 5; --acceptée

        L := B2; --acceptée
        B2 := B2 + 1; --acceptée

        C1 := L;

        L := C2;  --pas acceptée, car déja affectée au dessus

        C2 := A; --acceptée
        C2 := C2 + 1; --acceptée
    end Comprendre_Les_Contrainte_Dans_Le_Corps;


begin
    Comprendre_Les_Contraintes_Sur_L_Appelant;
    Put_Line ("Fin");
end Comprendre_Mode_Parametre;
