import java.awt.Color;
import afficheur.*;

/** Modélisation de la notion d'ObjetGéométrique,
 * qui permet de généraliser les classes
 * Segment et point.
 * @author ncazes2
 */
abstract public class ObjetGeometrique {
	private Color couleur;
	
	/** Construire un objet géometrique.
	 * @param c la couleur de l'objet géométrique
	 */
	public ObjetGeometrique(Color c) {
		this.couleur = c;
	}
	
	/** Obtenir la couleur de l'objet.
	 * @return c la couleur de l'objet géométrique
	 */
	public Color getCouleur() {
		return(this.couleur);
	}
	
	/** Modifier la couleur de l'objet.
	 * @param nouvelleCouleur la nouvelle couleur de l'objet géométrique
	 */
	public void setCouleur(Color nouvelleCouleur) {
		this.couleur = nouvelleCouleur;
	}
	
	/** Afficher sur le terminal les caractéristiques de l'objet.
	 */
	abstract public void afficher();
	
	/** Translater l'objet géométrique.
	 * @param dx déplacement le long de x
	 * @param dy déplacement le long de y
	 */
	abstract public void translater(double dx, double dy);
	
	/** Dessiner l'objet géométrique.
	 * @param afficheur sur lequel le dessiin va être visualisé
	 */
	abstract public void dessiner(afficheur.Afficheur afficheur);
}
