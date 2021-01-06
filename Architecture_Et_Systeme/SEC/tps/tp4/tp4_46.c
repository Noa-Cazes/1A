/* Exemple d'utilisation des primitives Unix : Un père et ses fils */
/* 1 pipe par fils : depuis le père vers les fils */

#include <stdio.h>    /* E/S */
#include <unistd.h>   /* primitives de base */
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opértaions sur les chaînes */
#include <signal.h>   /* traitement des signaux */

#define NB_FILS 3


int main() {
    int fils, retour, pid, v_lue;

    int pipe_p2f[NB_FILS + 1][2]; /* pipe_p2f[0] non utilisé */

	
    /* Création de NB_FILS pipes */
    for (int i = 1; i <= NB_FILS; i++) {
	retour = pipe(pipe_p2f[i]);
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
	    /* fermer l'extrémité 1 : le fils va lire */
	    close(pipe_p2f[fils][1]);

	    /* fermer tous les autres pipes */
	    for (int i = 1; i <= NB_FILS; i++) {
		if (i!=fils) {
		    close(pipe_p2f[i][0]);
		    close(pipe_p2f[i][1]);
		}
	    }
	    /* Seuls les fils 2 et 3 lisent */
	    if (fils > 1) {
		/* lire ce qui arrive dans le pipe */
        	while((read(pipe_p2f[fils][0], &v_lue, sizeof(int)))>0) {
		    printf("\n	Processus de pid %d - reçu : %d\n", 
			    getpid(), v_lue);

		}
            }
	    
	    /* Fermer l'extrémité 0 : fin de lecture */
	    /* Le prochaine écriture sur ce pipe renverra 0 */
	    close(pipe_p2f[fils][0]);

	    /* Terminer le processus */
	    exit(EXIT_SUCCESS);
	} else {
	    printf("\nProcessus de pid %d a crée un fils de numéro %d et de pid %d\n",
		    getpid(), fils, retour);
	}
    }


    /* Fermer toutes les extrémités 0 */
    for (int i = 1; i <= NB_FILS; i++) {
	close(pipe_p2f[i][0]);
    }
    pid = getpid();
    /* Envoyer son pid aux fils */
    for(fils = 1; fils <= NB_FILS; fils++) {
	sleep(1);
	retour = write(pipe_p2f[fils][1], &pid, sizeof(int));
	if (retour < 0) {
	    printf("\nProcessus Principal : Erreur write %d.\n", retour);
	}
    }
    /* Fermer les extrémités 1 : l'écriture est finie */
    for (int i = 1; i <= NB_FILS; i++) {
	close(pipe_p2f[i][1]);
    }
    printf("\nProcessus Principal terminé.\n");

    return EXIT_SUCCESS;
}



