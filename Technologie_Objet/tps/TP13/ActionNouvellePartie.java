import java.awt.event.ActionEvent;
import java.awt.event.*;

/** Permet de définir l'action engendrée lors de l'évènement
 * appuie sur le bouton N.
 * @author ncaze
 *
 */
public class ActionNouvellePartie implements ActionListener {
	
	private MorpionSwing vue;
	
	public ActionNouvellePartie(MorpionSwing vue) {
		this.vue = vue;
	}
	
	public void actionPerformed(ActionEvent nouvellePartie) {
		this.vue.recommencer();
	}

}
