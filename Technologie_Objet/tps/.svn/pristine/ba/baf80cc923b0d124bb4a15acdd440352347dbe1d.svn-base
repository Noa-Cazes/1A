package allumettes;
import java.util.Scanner;
import java.util.InputMismatchException;

/** Stratégie qui consiste à demander au joueur ce qu'il veut jouer.
 * @author ncazes2
 */
public class StrategieHumaine implements Strategie {

	/** Le scanner va peremttre de lire le nombre
	 * d'allumettes que le joueur veut retirer.
	 */
	private Scanner scanner;
	private int prise;

	public StrategieHumaine() {
		this.scanner = new Scanner(System.in);
	}

	/** Demander à un joueur le nombre d'allumettes
	 * qu'il veut rétirer pour un jeu donné.
	 * @param jeu le jeu donné
	 * @return nbAllumettes le nombre d'allumettes que le joueur veut prendre
	 * @throws CoupInvalideException tentative de prendre
	 * un nombre invalide d'allumettes
	 */
	@Override
	public int getPrise(Jeu jeu) {
		do {
			System.out.print("Combien prenez-vous d'allumettes ? ");
			try {
				this.prise = this.scanner.nextInt();
				return this.prise;
			} catch (InputMismatchException e) {
				System.out.println("Vous devez donner un entier.\n");
				this.scanner.nextLine();
			}
		} while (true);
	}

}
