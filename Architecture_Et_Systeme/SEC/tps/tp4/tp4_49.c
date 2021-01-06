/* Exemple d'itilisation des primitives Unix : un père et ses fils */
/* Calcul distribué du maximumd'un tableau : communication par pipe */

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
    int fils, retour, desc_fic, fils_termine, wstatus, max, max_lu, nb_resultats; 
    
    int tab[NB_ELEM];

    int pipe_f2p[2];

    /* Initialiser le tableau */
    for (int i = 0; i < NB_ELEM; i++) {
	tab[i] = i + 1;
    }
    
    /* Création du pipe */
    pipe(pipe_f2p);

     printf("\nJe suis le processus principal de pid %d\n", getpid());

    for (fils = 1; fils <= NB_FILS; fils++) {
	retour = fork();

	if (retour < 0) {
	    printf("Erreur avec le fork\n");
	    exit(1);
	} else if (retour == 0) {
	    /* le fils écrit */
	    close(pipe_f2p[0]);
	    /* Calculer mex du sous-tableau */
	    max = cal_max_tab(tab, (fils-1)*NB_FLEM_FILS, fils*NB_FLEM_FILS);
	    /* Enregistrer le max en binaire */
	    write(pipe_f2p[1], &max, sizeof(int));
	    close(pipe_f2p[1]);
	    /* Imp : terminer un processu par exit */
	    exit(EXIT_SUCCESS);

       } else {
	   printf("Processus de pid %d a crée un fils de numéro %d, de pid %d\n",
		   getpid(), fils, retour);
	 }
    }
    /* le père lit */
    close(pipe_f2p[1]);

    max = 0;
    nb_resultats =0;
    /* lire les résultats envoyés par les fils et calcuer le max */
    while((read(pipe_f2p[0], &max_lu, sizeof(int)))>0){
	nb_resultats++;
	if (max_lu > max) {
	    max = max_lu;
        }
   }
        /* Attendre la fin des fils */
    for (fils = 1; fils <= NB_FILS; fils++) {
	/* attendre la fin d'un fils */
	fils_termine = wait(&wstatus);

	if (WIFEXITED(wstatus)) {
	    printf("\nMon fils de pid %d s'est terminé par un exit %d\n",
		    fils_termine, WEXITSTATUS(wstatus));
        }
    }
    close(pipe_f2p[1]);
    printf("\nProcessus Principal terminé - Nombre de résultats reçus %d -  Max = %d\n",
	    nb_resultats, max);
    return EXIT_SUCCESS;
}

