package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Partie {

	static final int NB_ALL = 13;
	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		try {
			verifierNombreArguments(args);

			/** On définit le joueur 1 */
            Joueur j1;

            /** On définit le joueur 2 */
            Joueur j2;

            /** On définit un bouléen pour savoir
            si l'arbitre est confiant ou non */
            boolean confiant;

            // Un jeu de 13 allumettes
            Jeu jeu = new UnJeu(NB_ALL);

            // Est-ce que l'arbitre est confiant?
            if (args[0].equals("-confiant")) {

            	// On récupère les noms et stratégies des deux joueurs
                j1 = splitAr(args[1]);
                j2 = splitAr(args[2]);
            	confiant = true;
            } else {
            	// On récupère les noms et stratégies des deux joueurs
                j1 = splitAr(args[0]);
                j2 = splitAr(args[1]);
            	confiant = false;
            }
            Arbitre arbitre = new Arbitre(j1, j2, confiant);
            arbitre.arbitrer(jeu);

		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
	}
    /** Vérifier le nombre d'argume,ts de la ligne de commande.
     * @param args chaine de caractère représentant la les arguments saisis
     */
	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Séparer un argument de la forme nom@stratégie
	 * en un nom de joueur et une stratégie associée.
	 * @param arg un argument
	 * @return joueur le joueur avec son nom et sa stratégie
	 */
	public static Joueur splitAr(String arg) {
		String[] result;
		result = arg.split("@", 2);
		// On associe au joueur la stratégie
		// correspondant à celle saisie
		if (result[1].equals("naif")) {
			return new Joueur(result[0], new StrategieNaive());
		} else if (result[1].equals("rapide")) {
			return new Joueur(result[0], new StrategieRapide());
		} else if (result[1].equals("expert")) {
			return new Joueur(result[0], new StrategieExperte());
		} else if (result[1].equals("humain")) {
			return new Joueur(result[0], new StrategieHumaine());
		} else if (result[1].equals("tricheur")) {
			return new Joueur(result[0], new StrategieTricheur());
		} else {
			throw new ConfigurationException("L'argument doit être "
					+ "de la forme "
					+ "nom@strategie avec "
					+ "strategie = naif | rapide | expert "
					+ "| humain | tricheur");
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Partie joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert "
						+ "| humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Partie Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}
}
