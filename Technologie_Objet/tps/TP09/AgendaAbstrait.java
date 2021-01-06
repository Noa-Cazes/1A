/**
 * AgendaAbstrait factorise la définition du nom et de l'accesseur associé.
 */
public abstract class AgendaAbstrait extends ObjetNomme implements Agenda {

	/**
	 * Initialiser le nom de l'agenda.
	 *
	 * @param nom le nom de l'agenda
	 * @throws IllegalArgumentException si nom n'a pas au moins un caractère
	 */
	public AgendaAbstrait(String nom) {
		super(nom);
	}
	
	/** Vérifier qu'un créneau est valide ou non.
	 * @param creneau creneau pour lequel on vérifie la validité
	 * @throws IllegalArgumentException
	 */
	public void verifierCreneauValide(int creneau) throws CreneauInvalideException {
		if (creneau < CRENEAU_MIN || creneau > CRENEAU_MAX) {
			throw new CreneauInvalideException("pour créneau: " + creneau);
		}
	}


}
