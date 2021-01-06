with Ada.Text_IO;       use Ada.Text_IO;
with Vecteurs_Creux;    use Vecteurs_Creux;

-- Exemple d'utilisation des vecteurs creux.
procedure Exemple_Vecteurs_Creux is

	V : T_Vecteur_Creux;
begin
	Put_Line ("Début du scénario");
	Initialiser(V);
	pragma Assert (Est_Nul(V));
        Detruire(V);
	pragma Assert (Est_Nul(V));
	Modifier (V,1,3.0);
	pragma Assert (Composante_Recursif (V,1)=3.0);
	pragma Assert (Composante_Iteratif (V,1)=3.0);
	Put_Line ("Fin du scénario");
end Exemple_Vecteurs_Creux;

