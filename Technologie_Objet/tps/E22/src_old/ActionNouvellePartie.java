
//package Unlock;
import java.awt.event.ActionEvent;

import javax.swing.JFrame;

import java.awt.event.*;

/** Permet de définir l'action engendrée lors de l'évènement
 * appuie sur le bouton N.
 * @author ncaze
 *
 */
public class ActionNouvellePartie implements ActionListener {
	
	private UnlockSwingTuto vue;

	
	public ActionNouvellePartie(UnlockSwingTuto vue) {
		this.vue = vue;
	}
	
	public void actionPerformed(ActionEvent nouvellePartie) {
		this.vue.recommencer();
	}

}
