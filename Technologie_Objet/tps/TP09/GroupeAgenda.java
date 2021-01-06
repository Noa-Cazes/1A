import java.util.List;

public class GroupeAgenda extends AgendaAbstrait {
	
	protected List<Agenda> agendas;
	
	/** Créer un groupe d'agendas vides.
	 * 
	 * @param nom le nom de l'agenda
	 * @throws IllegalArgumentException si nom nul ou vide
	 */
	public GroupeAgenda(String nom) {
		super(nom);
		this.agendas = new ArrayList<>();
	}
	
	
	/** Ajouter un nouvel agenda dans le groupe d'agendas.
	 * @param a le nouvel agenda à ajouter
	 * @throws IllegalArgumentException si a est null ou déjà dans le groupe
	 */
	public void ajouter(Agenda a) {
		verifierNotNull(a);
		
		if (this.contient(a)) {
			throw new IllegalArgumentException("Cet agenda est dékà dans le groupe d'agendas" + this.getNom() + " : " + a.getNom());
		}
		if (a instanceof GroupeAgenda && ((GroupeAgenda) a).contient(this)) {
			throw new IllegalArgumentException("refus de créer un cycle : " + a.getNom() + " contient " + this.getNom());
		}
		this.agendas.add(a);
	}
	
	/** Savoir si un agenda est dans le groupe.
	 * @param a l'agenda cherché
	 * @return vrai si l'agenda appartient à ce groupe
	 */
	public boolean contient(Agenda a) {
		for (Agenda a1 : this.agendas) {
			if (a1.equals(a)) {
				return true;
			} else if (a instanceof GroupeAgenda) {
				GroupeAgenda sousGroupe = (GroupeAgenda) a;
				if (sousGroupe.contient(a)) {
					return true;
				}
			}
		 return false;
	  }
	
	/** Enregistrer un rendez-vous sur tous les agendas
	 * Si cela n'est pas possible, l'exception
	 * OccupeException est levée
	 * @param creneau le créneau sur lequel on veut enregistrer le rdv
	 * @param rdv le rendez-vous à enregister
	 * @throws OccupeException
	 */
	@Override
	public void enregistrer(int creneau, String rdv) throws OccupeException{
		verifierCreneauValide(creneau);
		verifierNotNull(rdv);
		verifierChaineNonVide(rdv);
		
		List<Agenda> agendasModifies = new Array<list<>();
		try {
			// Enregistrer dans les différents agendas
			for (Agenda a : this.agendas) {
				a.enregistrer(creneau, rdv);
				agendasModifies.add(a);
			}
		} catch (OccupeException e) {
			// Supprimer les enregistrements faits
			for (Agenda a : agendasModifies) {
				a.annuler(creneau);
			}
			throw e;
		}
	}
	
	@Override
	public boolean annuler(int creneau) {
		verifierCreneauValide(creneau);
		
		boolean mod = false;
		for (Agenda a : this.agendas) {
			mod = a.annuler(creneau) || mod;
		}
		return mod;
	}
	
	/** Demander le rdv qu'il y a sur un créneau.
	 * @param creneau créneau surlequel on cherche à connaître le rdv.
	 * @return rdv le rdv commun à tous les agendas
	 * @throws LibreException si au moins deux créneaux sont libres
	 */
	@Override
	public String getRendezVous(int creneau) throws LibreException{
		verifierCreneauValide(creneau);
		
		String rdv1 = null;
		int nb = 0;
		for (Agenda a : this.agendas) {
			String rdv = a.getRendezVous(creneau);
			if (rdv == null) {
				// a est un groupe sans rdv communs
				return null;
			} else {
				if
			}
		}
	
	

}
