/**
 * Un objet nommé est un objet qui a un nom.
 */
public abstract class ObjetNomme {

	private String nom;

	/**
	 * Initialiser le nom de l'agenda.
	 *
	 * @param nom le nom de l'agenda
	 * @throws IllegalArgumentException si nom n'a pas au moins un caractère
	 */
	public ObjetNomme(String nom) throws IllegalArgumentException {
		verifierNotNull(nom);
		verifierChaineNonVide(nom);
	    this.nom = nom;
	}


	/**
	 * Obtenir le nom de cet objet.
	 * @return le nom de cet objet
	 */
	public String getNom() {
		return this.nom;
	}
	
	/** Vérifier que la chaîne de caractères comporte au moins un caractère.
	 * @param nom le nom pour lequel on veut faire la vérification
	 * @throws IllegalArgumentException
	 */
	protected void verifierChaineNonVide(String nom) throws IllegalArgumentException {
		if (nom.length() < 1) {
			throw new IllegalArgumentException("Cette chaîne est vide");
		}
	}
	
	/** Vérifier que la poignée est non nulle.
	 * @param p la poignée pour laquelle on veut faire la vérification
	 * @throws IllegalARgumentException
	 */
	protected void verifierNotNull(Object p) throws IllegalArgumentException {
		if(p == null) {
			throw new IllegalArgumentException("La poignée est nulle");
		}
	}

}
