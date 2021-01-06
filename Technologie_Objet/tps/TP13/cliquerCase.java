import java.awt.event.*;
import java.util.HashMap;
import java.util.Map;
import javax.swing.*;

import javax.swing.ImageIcon;

/** Permet de définir l'action engendrée lors de l'évènement
 * cliquer sur une case.
 *  * @author ncaze
 *
 */
public class cliquerCase implements MouseListener {
	
	private MorpionSwing vue;
	private int i;
	private int j;
    
	public cliquerCase(MorpionSwing vue, int i, int j) {
		this.vue = vue;
		this.i = i;
		this.j = j;
	}
	

	@Override
	public void mouseClicked(MouseEvent clicked) {
		try {
			this.vue.getModele().cocher(i, j);
		} catch (CaseOccupeeException e) {
			System.out.println("Cette case a déjà été jouée!");
		}
		this.vue.getCases()[this.i][this.j].setIcon(this.vue.getImages().get(this.vue.getModele().getValeur(this.i, this.j)));
		this.vue.getJoueur().setIcon(this.vue.getImages().get(this.vue.getModele().getJoueur()));
	}

	@Override
	public void mouseEntered(MouseEvent arg0) {

		
	}

	@Override
	public void mouseExited(MouseEvent arg0) {
		
		
	}

	@Override
	public void mousePressed(MouseEvent arg0) {
		
		
	}

	@Override
	public void mouseReleased(MouseEvent arg0) {
		
		
	}

}
