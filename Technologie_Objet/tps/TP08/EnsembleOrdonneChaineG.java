
public class EnsembleOrdonneChaineG<E> extends EnsembleChaineG<E> implements EnsembleOrdonneG<E>{
	
	
	public EnsembleOrdonneChaineG() {
		super();
	}
	
	/** Ajouter un élément dans l'ensemble.
	 * @param x l'élément à ajouter 
	 */
	@Override
//	public void ajouter(int x) {
//		Cellule cell = new Cellule(x, null);
//		while (super.getCourante().getNext() != null && cell.getElt() < x) {
//			super.setCourante(super.getCourante().getNext());
//		}
//		super.setNext(cell);
//	}
	
	public void ajouter(E x) {
		if (super.getCourante() == null || this.getCourante().getElt().compareTo(x) < 0) {
			super.setCourante(new CelluleG<E> (x, this.getCourante()));
			super.nbModifications ++;
		} else {
			// Chercher la cellule après laquelle insérer
			CelluleG<E> curseur = super.getCourante();
			while (curseur.getNext() != null && curseur.getNext().getElt().compareTo(x) < 0) {
				curseur = curseur.getNext();
			}
			if (curseur.getElt() != x) {
				curseur.setNext(curseur.getNext().getNext());
				super.nbModifications ++;
			}
		}
	}
	/** Obtenir l'élément minimial de cet ensemble.
	 * @return l'entier minimal de l'ensemble
	 */
	@Override public void supprimer(E x) {
		if (super.getCourante() != null) {
			if (super.getCourante().getElt().equals(x)) {
				// Supprimer la première cellule
				this.setCourante(this.getCourante().getNext());
				this.nbModifications++;
			} else {
				// Chercher la cellule avant l'élément à supprimer
				CelluleG<E> curseur = super.getCourante();
				while (curseur.getNext() != null && ! curseur.getNext().getElt().equals(x)) {
					curseur = curseur.getNext();
				}

				if (curseur.getNext() != null) {
					curseur.setNext(curseur.getNext().getNext());
					this.nbModifications++;
				}
			}
		}
	}
	public E min() {
		return this.getCourante().getElt();
	}
	

}
