//package Unlock;

/**
 * Présente une salle et les objects qu'elle recèle.
 * @author ipeltier
 *
 */
public class CarteLieu implements Carte{
	 
	 /** Nombre de la carte */
		private String nomCarte;
	 /** Information la découverte de la carte */
		private boolean decouvCarte;
	
		private String nomImg;
	 /** Constructeur de la classe CarteObjet.
		 *
		 * @param n le numéro de la carte
		 */
		public CarteLieu(String s, String nomImg) {
			this.nomCarte = s;
			this.decouvCarte = false;
			this.nomImg = nomImg;
		}
		
		/** Obtenir le nom de la carte.
		 * @return  le nom de la carte
		 */
		public String getNom() {
			return nomCarte;
		}
		
		public String getNomImg() {
			return this.nomImg;
		}
		
		/** Obtenir le numéro de la carte.
		 * @return  le numéro de la carte
		 */
		public int getNumero() {
			return 0;
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
		
		public void defausser() {}
}
