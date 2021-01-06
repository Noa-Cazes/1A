/* Exemple d'utilisation des primitives Unix : Un père et ses fils */
/* 1 pipe depuis chaque fils vers le père, retard de lecture */

#include <stdio.h>    /* E/S */
#include <unistd.h>   /* primitives de base */
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opérations sur les chaînes */
#include <signal.h>   /* traitement des signaux */

#define NB_FILS 3


int main() {
    int fils, retour, pid;

    int pipe_f2p[NB_FILS + 1][2]; /* pipe_f2p[0] non utilisé */

	
    /* Création de NB_FILS pipes */
    for (int i = 1; i <= NB_FILS; i++) {
	retour = pipe(pipe_f2p[i]);
	if (retour == -1) {
	    printf("Erreur pipe\n");
	    exit(1);
	}
    }

    printf("\nJe suis le processus principal de pid %d\n", getpid());

    for (fils = 1; fils <= 3; fils++){
	retour = fork();

	if (retour < 0) {
	    printf("Erreur fork\n");
	    exit(1);
	}
	else if (retour == 0) {
	    /* fermer l'extrémité 0 : le fils va écrire dans le pipe */
	    close(pipe_f2p[fils][0]);

	    /* fermer tous les autres pipes */
	    for (int i = 1; i <= NB_FILS; i++) {
		if (i!=fils) {
		    close(pipe_f2p[i][0]);
		    close(pipe_f2p[i][1]);
		}
	    }
	    pid = getpid();

	    /* écrire 5 fois son pid dans le pipe */
	    for (int i = 1; i <= 5; i++) {
		sleep(2 * (NB_FILS - fils));
		printf("\n	Processus de pid %d effectue un envoi\n", pid);
		write(pipe_f2p[fils][1], &pid, sizeof(int));
	    }

	    /* Fermer l'extrémité 1 : fin des envois */
	    close(pipe_f2p[fils][1]);

	    /* Terminer le processus */
	    exit(EXIT_SUCCESS);
	} else {
	    printf("\nProcessus de pid %d a crée un fils de numéro %d et de pid %d\n",
		    getpid(), fils, retour);
	}
    }


    /* Fermer toutes les extrémités 1 : père lecteur */
    for (int i = 1; i <= NB_FILS; i++) {
	close(pipe_f2p[i][1]);
    }
    /* Lire ce que les fils envoient */
    for (fils = 1; fils <= NB_FILS; fils++) {
	while(read(pipe_f2p[fils][0], &pid, sizeof(int)) > 0) {
	    printf("\nProcessus Principal - reçu : %d\n", pid);
	}
    }
    /* Fermer les extrémités 0 */
    for (int i = 1; i <= NB_FILS; i++) {
	close(pipe_f2p[i][0]);
    }
    printf("\nProcessus Principal terminé.\n");

    return EXIT_SUCCESS;
}



