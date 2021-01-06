
//package Unlock;
import java.awt.event.*;
import java.awt.event.ActionEvent;
import javax.swing.*;
import java.awt.*;

/**  Action associée à l'évènement "appuyer sur le bouton start du chrono".
 * 
 * @author ncaze
 *
 */
 
public class ActionChronoStartPause implements ActionListener {
	
	private FenetreChrono fenetreChrono; 
	
	public ActionChronoStartPause(FenetreChrono chrono) {
		this.fenetreChrono = chrono;
	}
	
	public void actionPerformed (ActionEvent start) {
		String textButton;
		JButton bouton = this.fenetreChrono.getBoutonChrono();
		textButton = bouton.getText();
		
		if (textButton.compareTo("Start") == 0) { // On appuie sur le bouton quand il est à "Start"
			// Le bouton devient un bouton "Pause"
			bouton.setText("Pause");
			// Démarrer le chrono
			this.fenetreChrono.getChrono().start();
		} else if (textButton.compareTo("Pause") == 0) { // On appuie sur le bouton quand il est à "Pause"
			// Le bouton devient un bouton "Restart"
			bouton.setText("Restart");
			// Mettre le chrono en pause
			this.fenetreChrono.getChrono().stop();
		} else if (textButton.compareTo("Restart") == 0) { // On appuie sur le bouton quand il est à "Restart"
			// Le bouton devient un bouton "Pause"
		    bouton.setText("Pause");
		    // Reprendre le chrono là où il s'était arrêté
		    this.fenetreChrono.getChrono().start();
		} 
		
	}

}
