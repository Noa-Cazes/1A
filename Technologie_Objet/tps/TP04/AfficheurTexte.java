import java.awt.Color;

import afficheur.Afficheur;

/** Afficher les points, segments et textes.
 * @author ncazes2
 */
public class AfficheurTexte implements Afficheur {
    
	@Override
	public void dessinerCercle(double x, double y, double rayon, Color c) {
		System.out.println("Cercle {");
		System.out.println("        centre_x = " + x);
		System.out.println("        centre_y = " + y);
		System.out.println("        rayon = " + rayon);
		System.out.print("        couleur = ");
		System.out.println(c);
		System.out.println("}");

	}

	@Override
	public void dessinerLigne(double x1, double y1, double x2, double y2, Color c) {
		System.out.println("Ligne {");
		System.out.println("       x1 = " + x1);
		System.out.println("       y1 = " + y1);
		System.out.println("       x2 = " + x2);
		System.out.println("       y2 = " + y2);
		System.out.print("       couleur = ");
		System.out.println(c);
		System.out.println("}");

	}

	@Override
	public void dessinerPoint(double x, double y, Color c) {
		System.out.println("Point {");
		System.out.println("       x = " + x);
		System.out.println("       y = " + y);
		System.out.print("       couleur = ");
		System.out.println(c);
		System.out.println("}");
	}

	@Override
	public void dessinerTexte(double x, double y, String texte, Color c) {
		System.out.println("Texte {");
		System.out.println("       x = " + x);
		System.out.println("       y = " + y);
		System.out.println("       valeur = " + texte);
		System.out.println("       couleur = " + c);
		System.out.println("}");

	}

}
