import java.awt.Color;

/** Exemple modélise un triangle constitué de 3 points reliés en 3 segments et d'un barycentre.
 * @author Noa Cazes <noa.cazes@enseeiht.fr>
 */
public class Exemple{

    public static void main(String[] args) {
        // Créer les trois points
        Point p1 = new Point(3,2);
        Point p2 = new Point(11,4);
        Point p3 = new Point(6,9);

        // Relier les segments
        Segment s12 = new Segment(p1,p2);
        Segment s13 = new Segment(p1,p3);
        Segment s23 = new Segment(p2,p3);

        // Déterminer le barycentre de ces points
        Point b = new Point((p1.getX() + p2.getX() + p3.getX())/3,(p1.getY() + p2.getY() + p3.getY())/3);
    }
}

