//package Unlock;

/** Les objets peuvent parfois interagir avec d'autres objets
 * 
 */
 public class CarteObjet implements Carte {
	 
	 /** Nombre de la carte */
		private int numCarte;
	 /** Information de la découverte de la carte */ 
		private boolean decouvCarte; //add
	/**Couleur de la carte */
		public enum Couleur { Bleu , Rouge };
		private Couleur couleur;
		private String nomImg;
		private String nomImg_dos;
	
	 /** Constructeur de la classe CarteObjet.
		 *
		 * @param n le numéro de la carte
		 * @param color la couleur de la carte soit bleu, soit rouge
		 */
		public CarteObjet(int n, Couleur color, String nomImg_dos, String nomImg) {
			assert n >= 1;
			assert n <= 100;
			this.numCarte = n;
			this.couleur = color;
			this.decouvCarte = false;
			this.nomImg=nomImg;
			this.nomImg_dos=nomImg_dos;
		}
		
		/** Obtenir le numéro de la carte.
		 * @return  le numéro de la carte
		 */
		public int getNumero() {
			return numCarte;
			
		}
		
		public String getNomImg() {
			if (this.estDecouverte()) {
				return this.nomImg;
			}
			else {
				return this.nomImg_dos;
			}
		}
		
		/** Informer si la carte a été découverte.
		 * @return un boolean informant si la carte a été découverte.
		 */
		public boolean estDecouverte() { //add
			return decouvCarte;
		}
		
		/** Découvrir la carte.
		 * @param le numéro de la carte.
		 */
		
		public void decouvrir() { //add
			this.decouvCarte = true;
		}
		
		/** Obtenir la couleur de la carte.
		 * @return  la couleur de la carte
		 */
		public Couleur getCouleur() {
			return couleur;
		}
		
		public void defausser() {
			this.decouvCarte=false;
		}
			
}