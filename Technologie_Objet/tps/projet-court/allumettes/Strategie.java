package allumettes;
/** Permet de définir différentes stratégies
 * sans avoir à tout modifier.
 * @author ncazes2
 *
 */
public interface Strategie {

	/** Demander à un joueur le nombre d'allumettes
	 * qu'il veut retirer pour un jeu donné.
	 * @param jeu le jeu donné
	 * @return nbAllumettes le nombre d'allumettes que le joueur veut prendre
	 * @throws OperationInterditeException
	 * @throws CoupInvalideException
	 */
	int getPrise(Jeu jeu) throws OperationInterditeException,
	CoupInvalideException;

}
