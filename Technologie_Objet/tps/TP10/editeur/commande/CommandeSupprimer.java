package editeur.commande;

import editeur.Ligne;

public class CommandeSupprimer extends CommandeLigne {

	/** Initialiser la ligne sur laquelle 
	 * s'applique la commande.
	 * @param l la ligne en question
	 */
	public CommandeSupprimer(Ligne l) {
		super(l);
	}
	
	public void executer() {
		super.ligne.supprimer();
	}
	
	public boolean estExecutable() {
		return super.ligne.getLongueur() > 0;
	}
}
