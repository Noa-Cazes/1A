/* Exemple d'utilisation des primitives INix : un père et et ses fils */
/* Utilisation de SIGCHLD pour prendre connaissance de la fin d'un fils pour le père,
 * au lieud 'attendre sans rien faire que tous les fils aient terminé */

#include <stdio.h>    /* E/S */
#include <unistd.h>   /* les primitives de base */
#include <stdlib.h>   /* exit */
#include <signal.h>   /* pour le traitement des signaux */
#include <sys/wait.h> /* wait */

#define NB_FILS 3

int nb_fils_termines; /* variable globale car modifiée par le traitant */

/* Traitant dui signal SIGCHLD */
void handler_sigchld (int signal_num) {
    int wstatus, fils_termine;

    fils_termine = wait(&wstatus); /* quand SIGCHLD est reçu, le père est mis en wait
				      jusqu'à ce qu'il arrive un truc au fils.
				      Or quand SIGCHLD est là, c'est que par ex le 
				      fils s'est terminé. 
				      Donc le wait va durer presque pas de temps. */

    nb_fils_termines++;
    if WIFEXITED(wstatus) {
	printf("\nMon fils de pid %d a terminé avec un exit %d\n",
		fils_termine, WEXITSTATUS(wstatus));
    }
    else if WIFSIGNALED(wstatus) {
	printf("\nMon fils de pid %d a été tué par un signal %d\n",
		fils_termine, WTERMSIG(wstatus));
   }
   return;
}

int main() {
    int fils, retour;
    int duree_sommeil = 600;

    nb_fils_termines = 0;

    /*Associer un traitant au signal SIGCHLD */
    signal(SIGCHLD, handler_sigchld);

    printf("\nJe suis le processus principal de pid %d\n", getpid());

    /* Vidange du tampon de sortie pour que le fils le récupère vide */
    fflush(stdout);

    for(fils = 1; fils <= NB_FILS; fils++) {
	retour = fork();

	if (retour < 0) {
	    printf("\n Erreur fork\n");
	    exit(1);
	}

	if (retour == 0){
	    printf("\nProcessus fils numéro %d, de pid %d, de père %d\n",
		    fils, getpid(), getppid());
	    sleep(2 + duree_sommeil*(fils - 1));
	    exit(fils);
	}

	else {
	    printf("\nProcessus de pid %d a créé un fils de numero %d, de pid %d\n",
		    getpid(), fils, retour);
	}

    }

    do {
	/* ce que l'on veut */
    } while (nb_fils_termines < NB_FILS);
    printf("\nProcessus Principal terminé\n");
    return EXIT_SUCCESS;
}
