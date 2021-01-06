/** Définition d'une cellule. */
public class CelluleG<E> {
	private E elt;       // L'élément de la cellule
	private CelluleG<E> next;  // Pour passer à la cellule suivante
	
	/** Construire une cellule à partir d'un entier,
	 * et de la cellule suivante.
	 * @param elt à inscrire dans la cellule
	 * @param suivante cellule suivante
	 */
	public CelluleG(E elt, CelluleG<E> suivante) {
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
	public E getElt() {
		return this.elt;
	}
	
	/** Obtenir la cellule suivante.
	 * @return la cellule suivante
	 */
	public CelluleG<E> getNext() {
		return this.next;
	}
	
	/** Changer l'élément de la cellule.
	 * @param nouvelElt le nouvel élément
	 */
	public void setElt (E nouvelElt) {
		this.elt = nouvelElt;
	}
	
	/** Changer la cellule courante.
	 * @param nouvelleCourante la nouvelle cellule courante
	 */
	public void setCourante (CelluleG<E> nouvelleCourante) {
		this.elt = nouvelleCourante.getElt();
		this.next = nouvelleCourante.getNext();
	}
	/** Changer la cellule suivante.
	 * @param nouvelleNext la nouvelle cellule suivante
	 */
	public void setNext (CelluleG<E> nouvelleNext) {
		this.next = nouvelleNext;
	}
	

	
	
	
	
}
