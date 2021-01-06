

/**
 * requière une combinaison pour continuer l'aventure.
 * @author ipeltier
 *
 */

public class CarteCodes implements Carte {
	 
	 /** Nombre de la carte */
		private int numCarte;
	 /** Information la découverte de la carte */
		private boolean decouvCarte; //add
	
		private String nomImg_dos;
		private String nomImg;
	 /** Constructeur de la classe CarteObjet.
		 *
		 * @param n le numéro de la carte
		 */
		public CarteCodes(int n,String nomImg_dos, String nomImg ) {
			assert n >= 1;
			assert n <= 100;
			this.numCarte = n;
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
		
		public void defausser() {
			this.decouvCarte=false;
		}
		
			
}