import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/** Classe de test des exigences E12, E13, E14 de la classe Cercle.
* @author noa cazes
*/
public class CercleTest{
	
	// précision sur les comparaisons réelle
	public final static double EPSILON = 0.001;
	
	// Les points du sujet
	private Point A, B, C, D, E;
	
	// Les cercles du sujet
	private Cercle C1, C2, C3, C4, C5;
	

	@Before public void setUp(){
		// Construire les points
		A = new Point(1, 2);
		B = new Point(2, 1);
		C = new Point(4, 1);
		D = new Point(8, 1);
		E = new Point(8, 4);
		
		// Construire les cercles
		C1 = new Cercle(B, C);
		C2 = new Cercle(E, D);
		C4 = Cercle.creerCercle(D, B);
		C5 = new Cercle(A, B);
		C3 = new Cercle(A, B, Color.RED);
		
	}
	
	/** Vérifier si deux points ont même coordonnées.
	 * @param message qui s'affiche lorsque le assert n'est pas vérifié. 
	 * @param p1
	 * @param p2
	 * @return True si les deux points ont les mêmes coordonnées, False sinon.
	 */
	static void memeCoordonnees(String message, Point p1, Point p2) {
		assertEquals(message + "(x)", p1.getX(), p2.getX(), EPSILON);
		assertEquals(message + "(y)", p1.getY(), p2.getY(), EPSILON);
	}
	
	/** Déterminer le milieu d'un segment, cela correspondra au rayon des cercles tracés.
	 * @param p1
	 * @param p2
	 * @return milieu du segment [p1, p2]
	 */
	static Point milieu (Point p1, Point p2) {
		return (new Point((p1.getX() + p2.getX()) / 2,
			    (p1.getY() + p2.getY()) / 2));
	}
	
	
	@Test public void testerE12() {
		memeCoordonnees("E12: Centre de C1 incorrect", milieu(B, C), C1.getCentre());
		assertEquals("E12: Rayon de C1 incorrect ", 1.0, C1.getRayon(), EPSILON);
		assertEquals("E12: Couleur de C1 incorrecte", Color.BLUE, C1.getCouleur());
	
		memeCoordonnees("E12: Centre de C2 incorrect", milieu(E, D), C2.getCentre());
		assertEquals("E12: Rayon de C2 incorrect", 1.5, C2.getRayon(), EPSILON);
		assertEquals("E12: Couleur de C2 incorrecte", Color.BLUE, C2.getCouleur()); 
		
		memeCoordonnees("E12: Centre de C5 incorrect", milieu(A, B), C5.getCentre());
		assertEquals("E12: Rayon de C5 incorrect", Math.sqrt(2) / 2, C5.getRayon(), EPSILON);
		assertEquals("E12: Couleur de C5 incorrecte", Color.BLUE, C5.getCouleur()); 
	}
	
	@Test public void testerE13() {
		memeCoordonnees("E13: Centre de C3 incorrect", milieu(A, B), C3.getCentre());
		assertEquals("E13: Rayon de C3 incorrect", Math.sqrt(2) / 2, C3.getRayon(), EPSILON);
		assertEquals("E13: Couleur de C3 incorrecte", Color.RED, C3.getCouleur());
	}
	
	@Test public void testerE14() {
		memeCoordonnees("E14: Centre de C4 incorrect", D, C4.getCentre());
		assertEquals("E14: Rayon de C4 incorrect", 6.0, C4.getRayon(), EPSILON);
		assertEquals("E14: Couleur de C4 incorrecte", Color.BLUE, C4.getCouleur());
	}
}
