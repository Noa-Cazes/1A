
//package Unlock;
/**
 * Machine qui permet d'obtenir des cartes .
 * @author ipeltier
 *
 */
public class CarteMachine implements Carte {
	
	 /** Nombre de la carte */
		private int numCarte;
	 /** Information la découverte de la carte */
		private boolean decouvCarte;
	
		private String nomImg_dos;
		private String nomImg;
		
	 /** reponse de la question */
		private int r;
		
	 /** Constructeur de la classe CarteObjet.
		 *
		 * @param n le numéro de la carte
		 */
		public CarteMachine(int n,String nomImg_dos, String nomImg,int reponse) {
			assert n >= 1;
			assert n <= 100;
			this.numCarte = n;
			this.decouvCarte = false;
			this.nomImg=nomImg;
			this.nomImg_dos=nomImg_dos;
			this.r = reponse;
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
		public boolean estDecouverte() {
			return decouvCarte;
		}
		
		/** Découvrir la carte.
		 * @param le numéro de la carte.
		 */
		
		public void decouvrir() {
			this.decouvCarte = true;
		}
		
		public void defausser() {
			this.decouvCarte=false;
		}
}
