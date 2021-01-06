package allumettes;
/** Stratégie dans laquelle l'ordinateur joue au mieux qu'il peut.
 * @author ncazes2
 */
public class StrategieExperte implements Strategie {
	static final int DIV = 4;
	/** Obtenir le nombre d'allumettes que l'ordinateur doit
	 * retirer s'il veut gagner.
	 * @param jeu le jeu donné
	 * @return nbAllumettes le nombre d'allumettes que le joueur veut prendre
	 */
	@Override
	public int getPrise(Jeu jeu) {
		int nbAllumettesEnJeu = jeu.getNombreAllumettes();
		int nbAllumettesPrises = 1;
		// Il doit rester 1, 5, 9 ou 13 allumettes pour l'adversaire
		// Si l'ordinateur veut gagner à tout prix
		for (int i = 1; i <= Jeu.PRISE_MAX; i++) {
			if ((nbAllumettesEnJeu - i) % DIV == 1) {
				nbAllumettesPrises = i;
			}
		}
		return nbAllumettesPrises;
	}
}
