/* Exemple d'itilisation des primitives Unix : un père et ses fils */
/* Calcul distribué du maximumd'un tableau : communication par fichier */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>

#define NB_FILS 3
#define NB_FLEM_FILS 100000
#define NB_ELEM NB_FILS*NB_FLEM_FILS

/* Calcul duu max d'un sous-tableau */
int cal_max_tab(int tab[], int i1, int i2) {
    int i, max;

    max = tab[i1];

    for (i = i1 + 1; i < i2; i++) {
	if (tab[i] > max) {
	    max = tab[i];
        }
    }
    return max; 
}

int main() {
    int fils, retour, desc_fic, fils_termine, wstatus, max, max_lu; 
    
    int tab[NB_ELEM];

    char fichier[] = "fic_3f_maxtab";

    /* Initialiser le tableau */
    for (int i = 0; i < NB_ELEM; i++) {
	tab[i] = i + 1;
    }

    /* Ouverture du fichier en écriture */
    desc_fic = open(fichier, O_WRONLY | O_CREAT | O_TRUNC, 0640);
    /* Traiter les retours d'erreur des appels */
    if (desc_fic < 0) {
	printf("Erreur ouverture %s\n", fichier);
	exit(1);
    }

    for (fils = 1; fils <= NB_FILS; fils++) {
	retour = fork();

	if (retour < 0) {
	    printf("Erreur avec le fork\n");
	    exit(1);
	} else if (retour == 0) {
	    /* Calculer mex du sous-tableau */
	    max = cal_max_tab(tab, (fils-1)*NB_FLEM_FILS, fils*NB_FLEM_FILS);
	    /* Enregistrer le max en binaire */
	    write(desc_fic, &max,sizeof(int)); 
	    /* Imp : terminer un processu par exit */
	    exit(EXIT_SUCCESS);

       } else {
	   printf("Processus de pid %d a crée un fils de numéro %d, de pid %d\n",
		   getpid(), fils, retour);
	 }
    }
    /* Fermer le fichier en écriture */
    close(desc_fic);

    /* Ouverture du fichier en lecture */
    desc_fic = open(fichier, O_RDONLY);
    /* Traiter les retours d'erreur des appels */
    if (desc_fic < 0) {
	printf("Erreur ouverture du fichier %s\n", fichier);
	exit(1);
    }

    max = 0;
    /* Attendre la fin des fils */
    for (fils = 1; fils <= NB_FILS; fils++) {
	/* attendre la fin d'un fils */
	fils_termine = wait(&wstatus);

	if (WIFEXITED(wstatus)) {
	    printf("\nMon fils de pid %d s'est terminé par un exit %d\n",
		    fils_termine, WEXITSTATUS(wstatus));
	} else if (WIFSIGNALED(wstatus)) {
	    printf("\nMon fils de pid %d a été tué par un signal %d\n",
		    fils_termine, WTERMSIG(wstatus));
	}
	/* Lire les nouvelles valeurs communiqées par les fils */
	/* et calculer le max intermédiaire */
	while (read(desc_fic, &max_lu, sizeof(int)) > 0) {
	    if (max_lu > max) {
		max = max_lu;
            }
       }
    
   }
    close(desc_fic);
    printf("\nProcessus Principal terminé, Max = %d\n", max);
    return EXIT_SUCCESS;
}

