//package Unlock;

import java.awt.event.ActionEvent;
import java.awt.event.*;
import javax.swing.JOptionPane;

public class ActionSaisirCode implements ActionListener {
	
	//private UnlockSwing vue;
	private UnlockSwingTuto vue;
	
	//public ActionSaisirCode(UnlockSwing vue) {
	//	this.vue = vue;
	//}
	public ActionSaisirCode(UnlockSwingTuto vue) {
		this.vue = vue;
	}
	
	public void actionPerformed(ActionEvent saisirCode) {
		int n;
		JOptionPane jop = new JOptionPane(), jop2 = new JOptionPane();
		String i = jop.showInputDialog(null, "Entrez le numéro ou le code", "Saisir code", JOptionPane.QUESTION_MESSAGE);
		n = Integer.parseInt(i);
		this.vue.SaisirNumero(n);
		this.vue.SaisirCode(n);
				
	}

}
