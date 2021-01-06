/* Partie 1.1 exercice 2*/
#include <stdio.h>    /* entrées sorties */
#include <string.h>   /* manipulation des chaines */
#include <signal.h>   /* traitement des signaux */
#include <unistd.h>   /* primitives de base */
#include <stdlib.h>   /* exit */

#define D_ALARM 5

/* Traitant de tout signal hors SIGALRM */
void handler_sig(int signal_num) {
    printf("\n	  Processus de pid %d : J'ai reçu le signal %d\n",
	    getpid(), signal_num);
    return ;
}

/* Traitant du signal SIGALRM */
void handler_sigalrm(int signal_num) {
    int cpt = 0; // quand le compteur a atteint 12, soit 12*5 = 60s,
                 // le processus est tué
    int courant = getpid();
    while (cpt != 12) {
	if (signal_num == SIGALRM) {
	    printf("\nProcessus de pid %d : Je suis toujours actif", getpid());
	    sleep(1);
	}
	alarm(D_ALARM);
	cpt++;
    }
    kill(courant, SIGKILL);
    return;
}

/* Dormir pendant nb_secondes */
void dormir(int nb_secondes) {
    int duree = 0;
    while (duree < nb_secondes) {
	sleep(1);
	duree++;
    }
}

int main()
{
    /* associer un traitant affichant le numéro du signal à chaque signal reçu */
    signal(SIGINT, handler_sig);
    signal(SIGQUIT, handler_sig);
    signal(SIGILL, handler_sig);
    signal(SIGCHLD, handler_sig);
    signal(SIGTSTP, handler_sig);
    signal(SIGTERM, handler_sig);
    signal(SIGCONT, handler_sig);
    signal(SIGSTOP, handler_sig);
    signal(SIGQUIT, handler_sig);
    signal(SIGALRM, handler_sigalrm);

    printf("\nJe suis le processus principal de pid %d\n", getpid());
    
    alarm(D_ALARM);
    
    dormir(100);

    return EXIT_SUCCESS;
}
