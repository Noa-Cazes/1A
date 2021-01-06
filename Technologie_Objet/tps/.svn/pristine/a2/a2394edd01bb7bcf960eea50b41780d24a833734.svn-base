package allumettes;

/** Fait respecter les règles du jeu aux deux joueurs.
 * @author ncazes2
 */
public class Arbitre {

	private Joueur j1;
	private Joueur j2;
	private boolean confiant; // si confiant, l'arbitre transmet tout le jeu au joueur
	// sinon, il passe par la procuration

	public Arbitre(Joueur j1, Joueur j2, boolean confiant) {
		this.j1 = j1;
		this.j2 = j2;
		this.confiant = confiant;
	}

	public Arbitre(Joueur j1, Joueur j2) {
		this.j1 = j1;
		this.j2 = j2;
	}

	/** Obtenir le joueur 1.
	 * @return j1 le joueur 1
	 */

	public Joueur getJ1() {
		return this.j1;
	}

	/** Obtenir le joueur 2.
	 * @return j2 le joueur 2
	 */

	public Joueur getJ2() {
		return this.j2;
	}

	/** Modifier le joueur 1.
	 * @param j1 le joueur 1
	 */
	public void setJ1(Joueur j1) {
		this.j1 = j1;
	}

	/** Modifier le joueur 2.
	 * @param j2 le joueur 2
	 */
	public void setJ2(Joueur j2) {
		this.j2 = j2;
	}

	/** Modifier la stratégie du joueur 1.
	 * @param stratégie la nouvelle stratégie
	 */
	public void setStrategieJ1(Strategie strategie) {
		this.j1.setStrategie(strategie);
	}

	/** Modifier la stratégie du joueur 2.
	 * @param stratégie la nouvelle stratégie
	 */
	public void setStrategieJ2(Strategie strategie) {
		this.j2.setStrategie(strategie);
	}

	/** Déterminer qui est le gagnant et qui est le perdant
	 *  lorsque le jeu est terminé.
	 * @param jeu le jeu dans lequel on est
	 * @param cpt le compteur de nombre de tours du jeu
	 */
	public void afficherGagnantPerdant(Jeu jeu, int cpt) {

		// Si le jeu est terminé
		if (jeu.getNombreAllumettes() == 0) {

			// Le joueur 1 commence toujours en premier
			if (cpt % 2 == 1) { // Si cpt % 2 == 1 c'est le joueur 1
				System.out.println(j2.getNom() + " a perdu !");
				System.out.println(j1.getNom() + " a gagné !");
			} else { // Si cpt % 2 == 0 c'est le joueur 2
				System.out.println(j1.getNom() + " a perdu !");
				System.out.println(j2.getNom() + " a gagné !");
			}
		}
	}

	/** Faire jouer un joueur.
	 * @param j le joueur à faire jouer
	 * @param jeu le jeu dans lequel on est
	 * @param cpt le compteur de nombre de tours du jeu
	 * @return cpt le compteur de nombre de tours du jeu
	 */
	public int faireJouer(Joueur j, Jeu jeu, int cpt) {
		System.out.println("");
		System.out.println("Nombre d'allumettes restantes : "
		+ jeu.getNombreAllumettes());
		System.out.println("Au tour de " + j.getNom() + ".");
		int nbAllumettes = 0;
		try {
			if (confiant) { // Transmet le jeu
				nbAllumettes = j.getPrise(jeu);
			} else { // Passe par la procuration
			    nbAllumettes = j.getPrise(new Procuration(jeu));
			}
			jeu.retirer(nbAllumettes);
			if (nbAllumettes > 1) {
				System.out.println(j.getNom() + " prend "
			            + nbAllumettes + " allumettes.");
			} else {
				System.out.println(j.getNom() + " prend "
			            + nbAllumettes + " allumette.");
			}
			cpt = cpt + 1;
			return cpt;
		} catch (CoupInvalideException e) {
			if (e.getNombreAllumettes() > 1) {
				System.out.println(j.getNom() + " prend "
						+ e.getNombreAllumettes()
						+ " allumettes.");
			} else {
				System.out.println(j.getNom() + " prend "
						+ e.getNombreAllumettes()
						+ " allumette.");
			}
			System.out.println("Erreur ! " + e.getMessage());
			System.out.println("Recommencez !");
			return cpt;
        }
	}

	/** Arbitrer une partie.
	 * @param jeu le jeu dans lequel on est
	 */
	public void arbitrer(Jeu jeu) {
		// On commence la partie au tour 1
		int cpt = 1;
		try {
			while (jeu.getNombreAllumettes() != 0) {
				if (cpt % 2 == 1) {
					// On fait jouer le joueur 1
					cpt = faireJouer(this.j1, jeu, cpt);
				} else {
					// On fait jouer le joueur 2
					cpt = faireJouer(this.j2, jeu, cpt);
				}
			}
			// La partie est finie
			// On affiche qui est le gagnant
			// et qui est le perdant
			 afficherGagnantPerdant(jeu, cpt);
		} catch (OperationInterditeException e1) {
			if (cpt % 2 == 1) {
				System.out.println("Partie abandonnée car "
						+ this.j1.getNom() + " a triché !");
			} else {
				System.out.println("Partie abandonnée car "
						+ this.j2.getNom() + " a triché !");
			}
	    }
	}
}
