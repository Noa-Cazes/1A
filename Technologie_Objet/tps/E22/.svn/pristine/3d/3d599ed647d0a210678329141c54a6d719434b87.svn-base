//package Unlock;

import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.util.*;

/** Programmation du jeu Unlock avec une interface graphique Swing.
 * 
 * @author ncaze
 *
 */

public class UnlockSwing {

	// les images à utiliser en fonction de l'état du jeu.
	private static final Map<Integer, ImageIcon> images
		= new HashMap<Integer, ImageIcon>();
	static {
		images.put( 0, new ImageIcon("blanc.jpg"));
		images.put( 1, new ImageIcon("un.jpg"));
	}

	// Le plateau du jeu Unlock
	private Plateau modele;	

    //  Les éléments de la vue (IHM)

	/** Fenêtre principale */
	private JFrame fenetre;


	/** Cases du jeu */
	private final JLabel[][] cases = new JLabel[3][3];
	
	/** Petit menu */
	private final JMenuBar menuBar = new JMenuBar();


// Le constructeur
// ---------------

	/** Construire le jeu Unlock */
	public UnlockSwing() {
		this(new Jeu());
	}

	/** Construire le jeu de morpion */
	public UnlockSwing(Jeu modele) {
		// Initialiser le modèle
		this.modele = modele;

		// Créer les cases du jeu Unlock
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				this.cases[i][j] = new JLabel();
			}
		}

		// Initialiser le jeu
		this.recommencer();
		

		// Construire la vue (présentation)
		//	Définir la fenêtre principale
		this.fenetre = new JFrame();
		// Ajouter un titre
		fenetre.setTitle("Unlock");
		// Emplacement de la fenêtre
		this.fenetre.setLocation(400 ,0);
		Dimension dimension = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
		this.fenetre.setPreferredSize(dimension);
		// Taille de la fenêtre
		//this.fenetre.setSize(700, 100);
		// Redimensionner la fenêtre
		this.fenetre.setResizable(true);
		
		java.awt.Container contenu = this.fenetre.getContentPane(); // contenu de la fenêtre principale
		contenu.setLayout(new GridLayout(Plateau.TAILLE, Plateau.TAILLE));
		
		//contenu.add(new GridLayout(3,3), BorderLayout.WEST);
		
		// Définir la position des Plateau.TAILLE JLabel des cases
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				contenu.add(this.cases[i][j]);
			}
		}
		
		// Crétion du petit menu
		JMenu menu = new JMenu("Jouer");
		this.menuBar.add(menu);
		
		JMenuItem itemNouvellePartie = new JMenuItem("Nouvelle partie");
		itemNouvellePartie.addActionListener(new ActionNouvellePartie(this));
	    menu.add(itemNouvellePartie);
	    
	    JMenuItem itemQuitter = new JMenuItem("Quitter");
	    itemQuitter.addActionListener(new ActionQuitter());
	    menu.add(itemQuitter);
	    
	    JMenuItem itemSaisirCode = new JMenuItem("Saisir un code");
	    itemSaisirCode.addActionListener(new ActionSaisirCode(this));
	    menu.add(itemSaisirCode);
	    
	    fenetre.setJMenuBar(this.menuBar);
		

		// Construire le contrôleur (gestion des événements)
		this.fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	
		
		/*
		 * for (int i = 0; i < this.cases.length; i++) { for (int j = 0; j <
		 * this.cases[i].length; j++) { selecCarte clique = new selecCarte(this, i, j);
		 * this.cases[i][j].addMouseListener(clique);
		 * 
		 * }
		 * 
		 * }
		 */

		// afficher la fenêtre
		this.fenetre.pack();			// redimmensionner la fenêtre
		this.fenetre.setVisible(true);	// l'afficher
	}
// Les getters utiles
		
		
		/** Obtenir les cases.
		 * @return cases les cases du jeu
		 */
		public JLabel[][] getCases() {
			return this.cases;
		}
		
		/** Obtenir images.
		 * @return images 
		 */
		static public Map<Integer, ImageIcon> getImages() {
			return images;
		}
		
		/** Obtenir le modéle.
		 * @return modele le modéle
		 */
		public Plateau getModele() {
			return this.modele; 
		}
// Quelques réactions aux interactions de l'utilisateur
// ----------------------------------------------------

	/** Recommencer une nouvelle partie. */
	public void recommencer() {
		this.modele.recommencer();

		// Vider les cases
		for (int k = 0; k < this.cases.length; k++) {
			for (int l = 0; l < this.cases[k].length; l++) {
				this.cases[k][l].setIcon(images.get(this.modele.AfficherCarte(k, l)));
			}
		}
		

	}


// La méthode principale
// ---------------------

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new UnlockSwing();
			}
		});
	}

}
