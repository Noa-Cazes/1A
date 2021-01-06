/** Tester le polymorphisme (principe de substitution) et la liaison
 * dynamique.
 * @author	Xavier Crégut
 * @version	1.5
 */
public class TestPolymorphisme {

	/** Méthode principale */
	public static void main(String[] args) {
		// Créer et afficher un point p1
		Point p1 = new Point(3, 4);	// Est-ce autorisé ? Pourquoi ? Oui car la classe Point est accessible, et la déclaration et l'initialisation peuvent être faites en même temps.
		p1.translater(10,10);		// Quel est le translater exécuté ? Celui de la super-classe Point.
		System.out.print("p1 = "); p1.afficher (); System.out.println ();
										// Qu'est ce qui est affiché ? Il est affiché "p1 = (13.0, 14.0)"

		// Créer et afficher un point nommé pn1
		PointNomme pn1 = new PointNomme (30, 40, "PN1");
										// Est-ce autorisé ? Pourquoi ? Oui car la classe PointNomme est accessible, et la déclaration et l'initialisation peuvent être faites en même temps.
		pn1.translater (10,10);		// Quel est le translater exécuté ? Celui de la sous-classe PointNomme.
		System.out.print ("pn1 = "); pn1.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? Il est affiché "pn1 = PN1:(40.0, 50.0)" 

		// Définir une poignée sur un point
		Point q;

		// Attacher un point à q et l'afficher
		q = p1;				// Est-ce autorisé ? Pourquoi ? Oui car on donne deux noms à la même poignée de classe Point.
		System.out.println ("> q = p1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?  "q = (13.0, 14.0)"

		// Attacher un point nommé à q et l'afficher
		q = pn1;			// Est-ce autorisé ? Pourquoi ? Oui car au point q on affecte le point pn1 qui est un PointNomme. 
		System.out.println ("> q = pn1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?  Rien.

		// Définir une poignée sur un point nommé
		PointNomme qn;

		// Attacher un point à q et l'afficher
		// qn = p1;			// Est-ce autorisé ? Pourquoi ? Non car on ne peut affecter un Point à un PointNomme.
		// System.out.println ("> qn = p1;");
		// System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? Rien.

		// Attacher un point nommé à qn et l'afficher
		qn = pn1;			// Est-ce autorisé ? Pourquoi ? Oui car qn et pn1 sont de classe PointNomme.
		System.out.println ("> qn = pn1;");
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? "qn = PN1: (40.0, 50.0)"

		double d1 = p1.distance (pn1);	// Est-ce autorisé ? Pourquoi ? Oui car pn1 possède la même méthode translater que p.
		System.out.println ("distance = " + d1);

		double d2 = pn1.distance (p1);	// Est-ce autorisé ? Pourquoi ? Oui car pn1 possède la même méthode translater que p.
		System.out.println ("distance = " + d2);

		double d3 = pn1.distance (pn1);	// Est-ce autorisé ? Pourquoi ? Oui car il n'y a pas de pré-condition interdisant d'obtenir la distance entre deux même points.
		System.out.println ("distance = " + d3);

		System.out.println ("> qn = q;");
		// qn = q;				// Est-ce autorisé ? Pourquoi ? Non car qn est de classe PointNomme et q de classe Point.
		// System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? Rien.

		System.out.println ("> qn = (PointNomme) q;");
		qn = (PointNomme) q;		// Est-ce autorisé ? Pourquoi ? Oui car qn est de classe PointNomme et ensuite q aussi (la dernière affectation était q = pn1).
		System.out.print ("qn = "); qn.afficher(); System.out.println ();

		System.out.println ("> qn = (PointNomme) p1;");
		//qn = (PointNomme) p1;		// Est-ce autorisé ? Pourquoi ? Non car la convertion de p1 en PointNomme ne peut se faire. 
		//System.out.print ("qn = "); qn.afficher(); System.out.println ();
	}

}
