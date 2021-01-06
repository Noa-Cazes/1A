

/** Définition d'un ensemble chaîné d'entiers. */
public class EnsembleChaineG<E> implements EnsembleG<E> {
	
	private CelluleG<E> courante;
	protected long nbModifications; //nb de modifications faites sur la liste 
	
	
	/** Construction d'un ensemble vide.
	 */
	public EnsembleChaineG() {
		this.courante = null;
		this.nbModifications = 0;
	}
	
	/** Obtenir le nombre de cellules de l'ensemble.
	 * @returns le nombre de cellules de l'ensemble
	 */
	private int getNombreCellule(CelluleG<E> cell) {
		if (cell == null) {
			return 0;
		} else {
			return 1 + getNombreCellule(cell.getNext());
		}
	}
	
	/** Obtenir le nombre d'éléments dans l'ensemble.
	 * @return nombre d'éléments dans l'ensemble.  
	 */
	@Override
	public int cardinal() {
		return getNombreCellule(this.courante);
	}
	
	/** Savoir si l'ensemble est vide.
	 * @return Est-ce que l'ensemble est vide ? 
	 */
	public boolean estVide() {
		return (this.courante == null);
	}
	
	/** Savoir si un élément est présent dans l'ensemble.
	 * @param x l'élément cherché
	 * @return x est dans l'ensemble 
	 */
//	public boolean contient(int x) {
//		boolean result;
//		if (this.estVide()) {
//			result = false;
//		}
//		else {
//			while (this.courante.getNext() != null && this.courante.getElt() != x) {
//				this.courante = this.courante.getNext();
//			}
//			if (this.courante == null) {
//				result = false;
//			}
//			else {
//				result = true;
//			}
//		}
//		return result;
//	}
	
	private boolean contient(E x, CelluleG<E> cell) {
		if (cell == null) {
			return false;
		} else if (cell.getElt() == x) {
			return true;
		} else {
			return contient(x, cell.getNext());
		}
	}
	
	@Override public boolean contient(E x) {
		return contient(x, this.courante);
	}
	/** Ajouter un élément dans l'ensemble.
	 * @param x l'élément à ajouter 
	 */
	public void ajouter(E x) {
		if (!contient(x)) {
			this.courante = new CelluleG<E>(x, this.courante); // ajout en début de chaîne
			this.nbModifications ++;
		}
	}
	
	/** Enlever un élément de l'ensemble.
	  * @param x l'élément à supprimer
	  */
	public void supprimer(E x) {
		if (this.courante != null) {
			if (contient(x)) {
				if (this.courante.getElt() == x) {
					this.courante = this.courante.getNext();
					this.nbModifications++;
				} else {
					while (this.courante.getNext() != null && this.courante.getNext().getElt() != x) {
						this.courante = this.courante.getNext();
					}
					if (this.courante.getNext() != null) {
						this.courante.setNext(this.courante.getNext().getNext());
						this.nbModifications++;
					}
				} 
			}
		}
	}
	
	/** Afficher l'ensemble chaîné.
	 * @return l'ensemble chaîné
	 */
	@Override public String toString() {
		String resultat = "{";
		if (this.courante != null) {
			// Pour la première cellule
			resultat += " " + this.courante.getElt();
			
			// Pour les autres cellules
			CelluleG<E> curseur = this.courante.getNext();
			while (curseur != null) {
				resultat += " " + curseur.getElt();
				curseur = curseur.getNext();
			}
		}
		resultat +=" }";
		return resultat;
	}
	
	/** Obtenir la cellule courante.
	 * @return Cellule la cellule courante
	 */
	public CelluleG<E> getCourante() {
		return this.courante;
	}
	
	/** Obtenir la cellule suivante.
	 * @return Cellule la cellule suivante
	 */
	public CelluleG<E> getNext() {
		return this.courante.getNext();
	}
	
	/** Modifier la cellule courante.
	 */
	public void setCourante(CelluleG<E> nc) {
		this.courante = nc;
	}
	 
	/** Modifier la cellule suivante.
	 */
	public void setNext(CelluleG<E> nc) {
		this.courante.setNext(nc);
	}
	
	
}