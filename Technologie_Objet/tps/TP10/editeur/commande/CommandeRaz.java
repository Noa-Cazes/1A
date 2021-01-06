package editeur.commande;

import editeur.Ligne; 

public class CommandeRaz extends CommandeLigne {
	
	/** Initialiser la ligne sur laquelle
	 * travaille cette commande
	 * @param l la ligne en question
	 */
	public CommandeRaz(Ligne l) {
		super(l);
	}
	
	public void executer() {
		super.ligne.raz();
	}
	
	public boolean estExecutable() {
		return super.ligne.getLongueur() > 0;
	}
}
