
//package Unlock
import javax.imageio.ImageIO;
import javax.swing.*;

import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.io.File;
import java.io.IOException;
import java.util.*;
import java.awt.color.*;

import java.lang.Object;
import java.util.Timer; 
import java.util.Calendar;
import java.text.SimpleDateFormat; 


/* Créer un chronomètre.
 */
public class FenetreChrono {
	
	private long TempsDepart=0;
	private long TempsFin=0;
	private long PauseDepart=0;
	private long PauseFin=0;
	private long Duree=0;
	private final int delais = 1000; 
	/* Heure du chrono */
	private int h = 0;  
	/* Minute du chrono */
	private int mn = 0;
	/* Seconde du chrono */
	private int s = 0;
	
	private JFrame fenetreChrono = new JFrame(); 
	/* Bouton du chrono */
	private JButton boutonChrono = new JButton("Start");
	/* Afficher le temps */
	private JTextField temps = new JTextField(5);
	/* Le chronomètre */
	private javax.swing.Timer chrono; 
	
	
	// Construire la fenêtre du chronomètre
	public FenetreChrono() {
		this.fenetreChrono.setTitle("Chronomètre"); 
	
	    // Créer un chronomètre
		this.chrono = new javax.swing.Timer(delais, new ActionChrono(this));
		//chrono.start(); 
		// Créer la zone où sera affichée le temps
		temps.setEditable(false);
		temps.setFont(new Font("sansserif", Font.PLAIN, 16));
		
		// Récupérer les dimensions de l'écran
		//Dimension dimension = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
		//this.fenetreChrono.setPreferredSize(dimension);
		this.fenetreChrono.setLocation(0,600);
		
		// Ajouter une image de fond
		ImageIcon fond = null;
		try {
			fond = new ImageIcon(ImageIO.read(new File("chrono2.jpg")));
		} catch(IOException e) {
			// En cas de problème de chargement de l'image
			e.printStackTrace();
		}
		
		JLabel contentPane = new JLabel(fond) {
			@Override
			public void paintComponent(Graphics g) {
				super.paintComponent(g);
				if (getIcon() != null) {
					g.drawImage(((ImageIcon) getIcon()).getImage(),0, 0, getWidth(), getHeight(), null);
				}
			}
		};



		// Appliquer le contenu
		this.fenetreChrono.setContentPane(contentPane);
		// Organiser la fenêtre
		this.fenetreChrono.getContentPane().setLayout(new FlowLayout());

		// Définir le bouton
		// Couleur du texte
		boutonChrono.setForeground(Color.black);
		// Rendre le bouton transparent
		boutonChrono.setContentAreaFilled(false); // fond du bouton transparent
		boutonChrono.setBorderPainted(false);     // pas d'encadrement supplémentaire  
		// Ajouter une action : ouvrir la fenêtre principale du jeu
		boutonChrono.addActionListener(new ActionChronoStartPause(this));
		// Ajouter le bouton au contenu
		this.fenetreChrono.getContentPane().add(boutonChrono);
		
		// Ajouter le chronomètre
		this.fenetreChrono.getContentPane().add(temps, FlowLayout.LEFT);
		
   
		// Afficher la fenêtre
		// Redimensionner la fenêtre
		this.fenetreChrono.setVisible(true);
		this.fenetreChrono.pack();
		this.fenetreChrono.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
	}
	
	
	public void start() {
		TempsDepart=System.currentTimeMillis();
		TempsFin=0;
		PauseDepart=0;
		PauseFin=0;
		Duree=0;
	}

	public void pause() {
		PauseFin=System.currentTimeMillis();
		TempsDepart=TempsDepart+PauseFin-PauseDepart;
		TempsFin=0;
		Duree=0;
		PauseDepart=0;
		PauseFin=0;
		
	}
	
	public void resume() {
		PauseFin=TempsDepart+PauseFin-PauseDepart;
		TempsFin=0;
		PauseDepart=0;
		PauseFin=0;
		Duree=0;
		
	}
	
	public void stop() {
		TempsFin=System.currentTimeMillis();
		Duree=(TempsFin-TempsDepart)-(PauseFin-PauseDepart);
		TempsDepart=0;
		TempsFin=0;
		PauseDepart=0;
		PauseFin=0;
	}
	
	public static String TimeToHMS(long TempsS) {
		int h=(int) (TempsS/3600);
		int m=(int) ((TempsS%3600)/60);
		int s=(int) (TempsS%60);
		String r="";
		if(h>0) {
			r+=h+" h ";
		}
		if(m>0) {
			r+=m+" min";
		}
		if(s>0) {
			r+=s+" s";
		}
		if(h<=0 && m<=0 && s<=0) {
			r=" 0 s";
		}
		return r;
	}
	
	// Les getters utiles
	
	public long GetDureeS() {
		return Duree/1000;
	}
	
	public String GetDureeTxt() {
		return TimeToHMS(GetDureeS());
	}
	
	public JTextField getTemps() {
		return this.temps; 
	}
	
	public javax.swing.Timer getChrono() {
		return this.chrono; 
	}
	
	public int getH() {
		return this.h;
	}
	
	public int getMn() {
		return this.mn;
	}
	
	public int getS() {
		return this.s;
	}
	
	/** Obtenir le texte du bouton boutonStartPause.
	 * @return boutonStartPause le bouton qui permet de lancer et 
	 * de mettre sur pause le chrono
	 */
	public JButton getBoutonChrono() {
		return this.boutonChrono;
	}
	
	// Les setters utiles
	public void setH(int h) {
		this.h = h;
	}
	
	public void setMn(int mn) {
		this.mn = mn;
	}
	
	public void setS(int s) {
		this.s = s;
	}
	
	/*
	 * public static void main(String[] args) { new FenetreChrono(); }
	 */
	
	
}
