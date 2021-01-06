/* Exemple d'utilisation des primitives INix : un père et et ses fils */
/* Utilisation de SIGCHLD pour prendre connaissance de la fin d'un fils pour le père,
 * au lieud 'attendre sans rien faire que tous les fils aient terminé */

#include <stdio.h>    /* E/S */
#include <unistd.h>   /* les primitives de base */
#include <stdlib.h>   /* exit */
#include <signal.h>   /* pour le traitement des signaux */
#include <sys/wait.h> /* wait */

#define NB_FILS 4

int nb_fils_termines; /* variable globale car modifiée par le traitant */

/* Traitant dui signal SIGCHLD */
void handler_sigchld (int signal_num) {
    int wstatus, fils_termine;
    printf("\nJ'ai reçu le signal %d\n", signal_num);
    if(signal_num == SIGCHLD) {
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
}


int main() {
    int fils, retour;
    int duree_sommeil = 2;


    /*Associer un traitant au signal SIGCHLD */
    signal(SIGCHLD, handler_sigchld);

    printf("\nJe suis le processus principal de pid %d\n", getpid());
    nb_fils_termines = 0;


    for(fils = 1; fils <= NB_FILS; fils++) {
	retour = fork();

	if (retour < 0) {
	    printf("\n Erreur fork\n");
	    exit(1);
	}

	if (retour == 0){
	    printf("\nProcessus fils numéro %d, de pid %d, de père %d\n",
		    fils, getpid(), getppid());
	    if (fils == 4) {
		duree_sommeil = 300;
	    }
	    sleep(duree_sommeil);
	    printf("\nProcessus fils numéro %d terminé", fils);
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
