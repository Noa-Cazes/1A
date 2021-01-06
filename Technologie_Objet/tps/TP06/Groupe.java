import java.awt.Color;
import java.util.ArrayList;

import afficheur.*;

public class Groupe {

		private int nb; // nombre d'éléments dans le groupe
		
		ArrayList<ObjetGeometrique> schema = new ArrayList<ObjetGeometrique>(nb - 1);
		
		/** Construire un groupe.
		 */
		public Groupe(int nombreEl) {
			assert(nombreEl > 0);
			this.nb = nombreEl;
			for (int i = 0; i < nb; i++) {
				schema.get(i).setCouleur(Color.GREEN);
			}
		}
		
		/** Peupler le groupe.
		 * @param ob l'Objet géométrique à ajouter
		 * @param indice où l'on souhaite l'ajouter
		 */
		public void ajouter(int indice, ObjetGeometrique ob) {
			assert(indice < nb);
			schema.add(indice, ob);
		}
		
		/** Translater les éléments du groupe.
		 * @param dx
		 * @param dy
		 */
		public void translater(double dx, double dy) {
			for (int i = 0; i < nb; i++) {
				schema.get(i).translater(dx, dy);
			}
		}
		/** Afficher sur le terminal les caractéristiques du groupe.
		 */
		public void afficher() {
			for (int i=0; i < nb; i++) {
				schema.get(i).afficher();
				System.out.println();
			}
			
		}
		
		/** Dessiner l'objet géométrique.
		 * @param afficheur sur lequel le dessiin va être visualisé
		 */
		public void dessiner(afficheur.Afficheur afficheur) {
			for (int i=0; i < nb; i++) {
				schema.get(i).dessiner(afficheur);
			}
		}
	

}
