package allumettes;

public class StrategieTricheur implements Strategie {

	/** Obtenir le nombre d'allumettes prises par un joueur tricheur.
	 * @param jeu le jeu donné
	 * @return nbAllumettes le nombre d'allumettes que le joueur veut prendre
	 */
	@Override
	public int getPrise(Jeu jeu) throws OperationInterditeException,
	                                          CoupInvalideException {
		// Le tricheur retire toutes les allumettes sauf 2
		while (jeu.getNombreAllumettes() > 2) {
			jeu.retirer(1);
		}
		// Puis le tricheur retire une seule allumette
		// Il est alors sûr de gagner
		return 1;

	}
}
