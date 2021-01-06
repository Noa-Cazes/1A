import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.util.*;

/** Programmation d'un jeu de Morpion avec une interface graphique Swing.
  *
  * REMARQUE : Dans cette solution, le patron MVC n'a pas été appliqué !
  * On a un modéle (?), une vue et un controleur qui sont fortement liés.
  *
  * @author	Xavier Cregut
  * @version	$Revision: 1.4 $
  */

public class MorpionSwing {

	// les images à utiliser en fonction de l'état du jeu.
	private static final Map<ModeleMorpion.Etat, ImageIcon> images
		= new HashMap<ModeleMorpion.Etat, ImageIcon>();
	static {
		images.put(ModeleMorpion.Etat.VIDE, new ImageIcon("blanc.jpg"));
		images.put(ModeleMorpion.Etat.CROIX, new ImageIcon("croix.jpg"));
		images.put(ModeleMorpion.Etat.ROND, new ImageIcon("rond.jpg"));
	}

// Choix de réalisation :
// ----------------------
//
//  Les attributs correspondant à la structure fixe de l'IHM sont définis
//	« final static » pour montrer que leur valeur ne pourra pas changer au
//	cours de l'exécution.  Ils sont donc initialisés sans attendre
//  l'exécution du constructeur !

	private ModeleMorpion modele;	// le modèle du jeu de Morpion

//  Les éléments de la vue (IHM)
//  ----------------------------

	/** Fenêtre principale */
	private JFrame fenetre;

	/** Bouton pour quitter */
	private final JButton boutonQuitter = new JButton("Q");

	/** Bouton pour commencer une nouvelle partie */
	private final JButton boutonNouvellePartie = new JButton("N");

	/** Cases du jeu */
	private final JLabel[][] cases = new JLabel[3][3];

	/** Zone qui indique le joueur qui doit jouer */
	private final JLabel joueur = new JLabel();
	
	/** Petit menu */
	private final JMenuBar menuBar = new JMenuBar();


// Le constructeur
// ---------------

	/** Construire le jeu de morpion */
	public MorpionSwing() {
		this(new ModeleMorpionSimple());
	}

	/** Construire le jeu de morpion */
	public MorpionSwing(ModeleMorpion modele) {
		// Initialiser le modèle
		this.modele = modele;

		// Créer les cases du Morpion
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				this.cases[i][j] = new JLabel();
			}
		}

		// Initialiser le jeu
		this.recommencer();
		

		// Construire la vue (présentation)
		//	Définir la fenêtre principale
		this.fenetre = new JFrame("Morpion");
		this.fenetre.setLocation(100, 200); // emplacement de la fenêtre
		
		java.awt.Container contenu = this.fenetre.getContentPane(); // contenu de la fenêtre principale
		contenu.setLayout(new GridLayout(4,3));
		
		// Définir la position des 9 JLabel des cases
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				contenu.add(this.cases[i][j]);
			}
		}
		
		// Crétion du petit menu
		JMenu menu = new JMenu("Jeu");
		this.menuBar.add(menu);
		
		JMenuItem itemNouvellePartie = new JMenuItem("Nouvelle partie");
		itemNouvellePartie.addActionListener(new ActionNouvellePartie(this));
	    menu.add(itemNouvellePartie);
	    
	    JMenuItem itemQuitter = new JMenuItem("Quitter");
	    itemQuitter.addActionListener(new ActionQuitter());
	    menu.add(itemQuitter);
	    
	    fenetre.setJMenuBar(this.menuBar);
		
		// Placer les JButton des boutons NouvellePartie et Quitter
		contenu.add(boutonNouvellePartie);
		contenu.add(joueur);
		contenu.add(boutonQuitter);
		

		// Construire le contrôleur (gestion des événements)
		this.fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		boutonNouvellePartie.addActionListener(new ActionNouvellePartie(this));
		boutonQuitter.addActionListener(new ActionQuitter());
		
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
			    cliquerCase clique = new cliquerCase(this, i, j);
				this.cases[i][j].addMouseListener(clique);

			}
			
		}

		// afficher la fenêtre
		this.fenetre.pack();			// redimmensionner la fenêtre
		this.fenetre.setVisible(true);	// l'afficher
	}
// Les getters utiles
		
		/** Obtenir le JLabel correspondant au joueur.
		 * 
		 * @return joueur le JLabel correspondant au joueur
		 */
		public JLabel getJoueur() {
			return this.joueur;
			
		}
		
		/** Obtenir les cases.
		 * @return cases les cases du jeu
		 */
		public JLabel[][] getCases() {
			return this.cases;
		}
		
		/** Obtenir images.
		 * @return images 
		 */
		public Map<ModeleMorpion.Etat, ImageIcon> getImages() {
			return this.images;
		}
		
		/** Obtenir le modèle.
		 * @return modele le modèle
		 */
		public ModeleMorpion getModele() {
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
				this.cases[k][l].setIcon(images.get(this.modele.getValeur(k, l)));
			}
		}

		// Mettre à jour le joueur
		joueur.setIcon(images.get(modele.getJoueur()));
	}


// La méthode principale
// ---------------------

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new MorpionSwing();
			}
		});
	}

}
