

/** Un joueur essaie de jouer dans une case occupée.
  * 
  */
public class CaseOccupeeException extends Exception {
	public CaseOccupeeException(String message) {
		super(message);
	}
}
