/** Définition d'une cellule. */
public class Cellule {
	private int elt;       // L'élément de la cellule
	private Cellule next;  // Pour passer à la cellule suivante
	
	/** Construire une cellule à partir d'un entier,
	 * et de la cellule suivante.
	 * @param elt à inscrire dans la cellule
	 * @param suivante cellule suivante
	 */
	public Cellule(int elt, Cellule suivante) {
		this.elt = elt;
		this.next = suivante;
	}
	
	/** Afficher les cellules.
	 * @return la cellule
	 */
	@Override
	public String toString() {
		return "[" + this.elt + "]--"
				+ (this.next == null ? 'E' : ">" + this.next);
	}
	
	/** Obtenir l'élément de la cellule.
	 * @return élément de la cellule
	 */
	public int getElt() {
		return this.elt;
	}
	
	/** Obtenir la cellule suivante.
	 * @return la cellule suivante
	 */
	public Cellule getNext() {
		return this.next;
	}
	
	/** Changer l'élément de la cellule.
	 * @param nouvelElt le nouvel élément
	 */
	public void setElt (int nouvelElt) {
		this.elt = nouvelElt;
	}
	
	/** Changer la cellule courante.
	 * @param nouvelleCourante la nouvelle cellule courante
	 */
	public void setCourante (Cellule nouvelleCourante) {
		this.elt = nouvelleCourante.getElt();
		this.next = nouvelleCourante.getNext();
	}
	/** Changer la cellule suivante.
	 * @param nouvelleNext la nouvelle cellule suivante
	 */
	public void setNext (Cellule nouvelleNext) {
		this.next = nouvelleNext;
	}
	

	
	
	
	
}
