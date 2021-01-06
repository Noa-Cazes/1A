package Unlock;
import java.awt.FlowLayout;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
//package Unlock;


public class Jeu implements Plateau {

	/** La zone de jeu */
	private Integer[][] cases;

	/** Jeu de cartes possible */ //add
	private Carte[] jeuCartes; //add


	/** Le nombres de cartes sur le plateau */
	private int nbCarte;
	
	public int getNombreCarte() {
		return nbCarte;
	}
	
	public Carte[] getJeuCarte() {
		return jeuCartes;
	}

	public Jeu() {
		// Créer le damier
		this.cases = new Integer[Plateau.TAILLE][Plateau.TAILLE];
		this.jeuCartes = new Carte[nbCarte]; //add

		// Commencer une partie
		initialiser();
	}
	
	/** Est-ce que la case (i,j) est vide ? */
	private boolean estVide(int i, int j) {
		return AfficherCarte(i,j) == 0;
	}

	public Integer AfficherCarte(int x, int y) {
		return this.cases[x][y];
	}
	

	public void SaisirNumero(int n) { //modif
		for (Carte c : jeuCartes) {
			if (c.getNumero() == n) {
				c.decouvrir();
			}
		}
	}
	

	public void SaisirCode (int n) {
		if (n == 9372) {
			JFrame fenetrefin = new JFrame();
			fenetrefin.setTitle("Vous avez gagné");
			fenetrefin.setLocation(0,0);
			fenetrefin.setResizable(true);
			fenetrefin.pack();
			fenetrefin.setVisible(true);
			JPanel panel = new JPanel();
			panel.setLayout(new FlowLayout());
			JLabel label = new JLabel("Félicitation vous avez trouvé le bon code!");
			panel.add(label);
			quitter();
		}
		else {
			
		}
		
	}

	/** Initialiser le jeu pour faire une nouvelle partie */
	private void initialiser() {
		// Initialiser les cases
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				this.cases[i][j] = 0;
			}
		}
		// initialiser la partie
		this.cases[0][0] = 1;
	}

	

	/** Jouer en (i,j) pour le joueur */
	//@ requires estVide(i,j);
	//@ ensures getValeur(i,j) == joueur;
	private void jouer(int i, int j, Integer n) {
		this.cases[i][j] = n;
		
	}


	public void quitter() {
	}

	public void recommencer() {
		this.initialiser();
	}

	public void remplir(int x, int y,Integer n) throws CaseOccupeeException {
			if (this.estVide(x, y)) {
				// Jouer la case
				this.jouer(x, y, n);
			} else {
				throw new CaseOccupeeException("Impossible, la case est occupée !");
			}
	}
	
	public void defausser(int x, int y) {
		this.cases[x][y] = 0;
	}

}

