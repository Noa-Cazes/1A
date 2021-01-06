import java.awt.FlowLayout;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class Tuto implements Plateau{
	/** La zone de jeu */
	private Integer[][] cases;

	/** Jeu de cartes possible */ //add
	private Carte[] jeuCartes; //add


	/** Le nombres de cartes sur le plateau */
	private int nbCarte = 10;
	
	public int getNombreCarte() {
		return nbCarte;
	}
	
	public Carte[] getJeuCarte() {
		return jeuCartes;
	}

	public Tuto() {
		this.jeuCartes = new Carte[nbCarte]; //add
		CarteLieu carteBureau = new CarteLieu("Bureau", "un_resized.png");
		jeuCartes[0]=carteBureau;
		Carte carte21 = new CarteCodes(21, "img21_dos_resized.png", "img21_resized.png");
		jeuCartes[1]=carte21;
		Carte carte69 = new CarteMachine(69, "img69_dos_resized.png", "img69_resized.png",4567);
		jeuCartes[2]=carte69;
		Carte carte35 = new CarteObjet(35, CarteObjet.Couleur.Rouge, "img35_dos_resized.png", "img35_resized.png");
		jeuCartes[3]=carte35;
		Carte carte16 = new CarteObjet(16, CarteObjet.Couleur.Bleu, "img16_dos_resized.png", "img16_resized.png");
		jeuCartes[4]=carte16;
		Carte carte11 = new CarteObjet(11, CarteObjet.Couleur.Bleu, "img11_dos_resized.png", "img11_resized.png");
		jeuCartes[5]=carte11;
		Carte carte42 = new CarteObjet(42, CarteObjet.Couleur.Rouge, "img42_dos_resized.png", "img42_resized.png");
		jeuCartes[6]=carte42;
		Carte carte46 = new CarteInteraction(46,"img46_dos_resized.png", "img46_resized.png");
		jeuCartes[7]=carte46;
		Carte carte48 = new CarteInteraction(48, "img48_dos_resized.png", "img48_resized.png");
		jeuCartes[8]=carte48;
		Carte carte25 = new CarteInteraction(25,"img25_dos_resized.png", "img25_resized.png");
		jeuCartes[9]=carte25;

		// Créer le damier
		this.cases = new Integer[Plateau.TAILLE+1][Plateau.TAILLE];

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
		for (int i=0; i<nbCarte; i++) {
			boolean carteADecouvrir = jeuCartes[i].getNumero()==n;
			if (carteADecouvrir) {
				jeuCartes[i].decouvrir();
			}
		}
	}
	
        public JPanel buildContentPane(String message) {
                        JPanel panel = new JPanel();
			panel.setLayout(new FlowLayout());
			JLabel label = new JLabel(message);
			panel.add(label);
                        return panel;
        }

        public JFrame fenetrefin(String titre) {
                       	JFrame fenetrefin = new JFrame();
			fenetrefin.setTitle(titre);
                        fenetrefin.setSize(320,240);
			fenetrefin.setResizable(true);
                        fenetrefin.setLocationRelativeTo(null);
			fenetrefin.setVisible(true);
                        return fenetrefin;
        }

	public void SaisirCode (int n) {
		if (n == 9372) {
                        JFrame fenetrefin = fenetrefin("Vous avez gagné!");
                        fenetrefin.setContentPane(buildContentPane("Félicitations vous avez trouvé le bon code!"));
			quitter();
		}
		else {
                        JFrame fenetrefin = fenetrefin("Code incorrect");
                        fenetrefin.setContentPane(buildContentPane("Le code est faux. Cherchez encore!"));
		}
		
	}

	/** Initialiser le jeu pour faire une nouvelle partie */
	private void initialiser() {
		// Initialiser les cases
		int indice=0;
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				if (indice<nbCarte) {
					this.cases[i][j] = this.jeuCartes[indice].getNumero();
					indice+=1;
				}
			}
		}
	}

	public void decouvrir(int x, int y) {	
		for (int i=0; i<nbCarte; i++) {
			boolean carteADecouvrir = jeuCartes[i].getNumero()==21 | jeuCartes[i].getNumero()==11 | jeuCartes[i].getNumero()==69 | jeuCartes[i].getNumero()==35 | jeuCartes[i].getNumero()==42;
			if (carteADecouvrir) {
				jeuCartes[i].decouvrir();
			}
		}
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
		for (int i=0; i<nbCarte; i++) {
			if (jeuCartes[i].getNumero()==this.cases[x][y]) {
				jeuCartes[i].defausser();
			}
		}
		this.cases[x][y] = 0;
	}
}
