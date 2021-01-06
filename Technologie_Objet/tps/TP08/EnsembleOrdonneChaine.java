
public class EnsembleOrdonneChaine extends EnsembleChaine implements EnsembleOrdonne {
	
	
	public EnsembleOrdonneChaine() {
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
	
	public void ajouter(int x) {
		if (super.getCourante() == null || x < this.getCourante().getElt()) {
			super.setCourante(new Cellule (x, this.getCourante()));
			super.nbModifications ++;
		} else {
			// Chercher la cellule après laquelle insérer
			Cellule curseur = super.getCourante();
			while (curseur.getNext() != null && curseur.getNext().getElt() > x) {
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
//	public int min() {
//		int min = super.getCourante().getElt();
//		while (super.getCourante().getNext() != null) {
//			if (super.getCourante().getNext().getElt() < min) {
//				min = super.getCourante().getNext().getElt();
//			}
//			super.setCourante(super.getNext());
//		}
//	}
//	
	public int min() {
		return this.getCourante().getElt();
	}
	

}
