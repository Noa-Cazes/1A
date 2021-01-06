/* Exemple d'utilisation des primitives INix : un père et et ses fils */
/* Utilisation de SIGCHLD pour prendre connaissance de la fin d'un fils pour le père,
 * au lieud 'attendre sans rien faire que tous les fils aient terminé */

#include <stdio.h>    /* E/S */
#include <unistd.h>   /* les primitives de base */
#include <stdlib.h>   /* exit */
#include <signal.h>   /* pour le traitement des signaux */
#include <sys/wait.h> /* wait */

#define NB_FILS 3
#define D_ALARM 10

int nb_fils_termines; /* variable globale car modifiée par le traitant */

/* Traitant dui signal SIGCHLD */
void handler_sigalrm (int signal_num) {
    int wstatus, fils_termine;
    if(signal_num == SIGALRM) {
	while ((fils_termine = (int) waitpid(-1, &wstatus, WNOHANG | WUNTRACED | WCONTINUED)) > 0) {
	    if WIFEXITED(wstatus) {
		printf("\nMon fils de pid %d a terminé avec un exit %d\n",
			fils_termine, WEXITSTATUS(wstatus));
		nb_fils_termines++;
	    }
            else if WIFSIGNALED(wstatus) {
	        printf("\nMon fils de pid %d a été tué par un signal %d\n",
		        fils_termine, WTERMSIG(wstatus));
		nb_fils_termines++;
            }
	    else if (WIFCONTINUED(wstatus)) {
		printf("\nMon fils de pid %d a été relancé\n", fils_termine);
	    }
	    else if (WIFSTOPPED(wstatus)) {
		printf("\nMonf fils de pid %d a été suspendu\n", fils_termine);
	    }
	    sleep(1);
        }
    }
    /* relancer alarm car cela n'est pas fait automatiquement */
    /* remet l'horlohe interne d'alarm à 0, donc permer d'enclencher le décompte
     * jusqu'à atteindre D_ALARM, ce qui permet de lancer le handler_sigchld
     * en boucle */
    alarm(D_ALARM);
    return;
}


int main() {
    int fils, retour;
    int duree_sommeil = 3;


    /*Associer un traitant au signal SIGCHLD */
    signal(SIGALRM, handler_sigalrm);

    printf("\nJe suis le processus principal de pid %d\n", getpid());
    nb_fils_termines = 0;

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
	    sleep(duree_sommeil * fils);
	    printf("\nProcessus fils numéro %d terminé", fils);
	    exit(fils);
	}

	else {
	    printf("\nProcessus de pid %d a créé un fils de numero %d, de pid %d\n",
		    getpid(), fils, retour);
	}

    }
    alarm(D_ALARM); // lance le signal, permet de vérifier si un fils a changé d'état
                    // puis à partir de ce moment, ça le fera en boucle (car 
		    // horloge remise à 0 à chaque fois que l'on passe dans le handler
    do {
	/* ce que l'on veut */
    } while (nb_fils_termines < NB_FILS);
    printf("\nProcessus Principal terminé\n");
    return EXIT_SUCCESS;
}
