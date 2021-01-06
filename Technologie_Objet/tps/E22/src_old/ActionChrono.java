
import java.awt.event.*;
import java.awt.event.ActionEvent;
import javax.swing.*;
import java.util.Calendar;
import java.text.SimpleDateFormat; 

/** Action associée au chronomètre.
 * 
 * @author ncaze
 *
 */

public class ActionChrono implements ActionListener {
	
	private FenetreChrono chrono; 
	
	public ActionChrono(FenetreChrono chrono) {
		this.chrono = chrono;
	}

	public void actionPerformed (ActionEvent actionChrono) {
		//SimpleDateFormat afficheTemps = new SimpleDateFormat("HH:mm:ss");
		// si on ne met pas getInstance() pb car on fait une référence statique à la 
		// méthode non statique getTime(), et getInstance() est une méthode statique, 
		// qui permet donc de pallier el problème
		//this.chrono.getTemps().setText(afficheTemps.format(Calendar.getInstance().getTime()));

		// Le chrono permet d'augmenter le nombre de secondes
		this.chrono.setS(this.chrono.getS() + 1);
		int s = this.chrono.getS();
		int h = this.chrono.getH();
		int mn = this.chrono.getMn();
		
		if (this.chrono.getS() == 60) { // Si on a atteint les 60 secondes
				// On réinitialise les secondes
				this.chrono.setS(0);
				// On augmente le nombre de minutes
				this.chrono.setMn(this.chrono.getMn() + 1);
				if (this.chrono.getMn() == 10) { // Si on décide d'arrêter le chrono au bout de 10 minutes
					// On le stoppe
				    this.chrono.getChrono().stop();
					// On met tout à 0
					this.chrono.setS(0);
					this.chrono.setMn(0);
					this.chrono.setH(0);
				}
			
		} else if (this.chrono.getMn() == 60) { // Si on a atteint les 60 minutes
				// On réinitialise les minutes
				this.chrono.setMn(0);
				// On augmente le nombre d'heures
				this.chrono.setH(this.chrono.getH() + 1);
			
		} 
			
		// On met à jour l'affichage
		this.chrono.getTemps().setText(this.chrono.getH() + ":" + this.chrono.getMn() + ":" + this.chrono.getS());

	}
}
