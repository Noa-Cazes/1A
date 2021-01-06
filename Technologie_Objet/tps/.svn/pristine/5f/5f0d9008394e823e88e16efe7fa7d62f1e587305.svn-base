package allumettes;


/** Définir un joueur par son nom,
 * on peut lui demander le nombre d'allumettes qu'il veut prendre
 * pour un jeu donné, selon la stratégie choisie (naîf, rapide, expert ou humain).
 * @author noa cazes
 */

public class Joueur {

	/** Un joueur est défini par son nom et la stratégie choisie.
	 */
	private String nom;
	private Strategie strategie;

	public Joueur(String nom, Strategie strategie) {
		this.nom = nom;
		this.strategie = strategie;
	}

	/** Obtenir le nom du joueur.
	 * @return nom le nom du joueur
	 */
	public String getNom() {
		return this.nom;
	}

	/** Obtenir la stratégie du joueur.
	 * @return strategie la stratégie du joueur
	 */
	public Strategie getStrategie() {
		return this.strategie;
	}

	/** Changer la stratégie du joueur.
	 * @param strategie la nouvelle strategie
	 */
	public void setStrategie(Strategie strategie) {
		this.strategie = strategie;
	}

	/** Demander le nombre d'allumettes que le joueur veut prendre
	 * pour un jeu donné.
	 * @param jeu le jeu donné
	 * @return nbAllumettes le nombre d'allumettes que le joueur veut prendre
	 */
	public int getPrise(Jeu jeu) throws OperationInterditeException,
	                                      CoupInvalideException {
		return this.strategie.getPrise(jeu);
	}

}
