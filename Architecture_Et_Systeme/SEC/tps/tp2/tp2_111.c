/* Partie 1.1 exercice 1*/
#include <stdio.h>    /* entrées sorties */
#include <string.h>   /* manipulation des chaines */
#include <signal.h>   /* traitement des signaux */
#include <unistd.h>   /* primitives de base */
#include <stdlib.h>   /* exit */

/* Traitant de tout signal */
void handler_sig(int signal_num) {
    printf("\n	  Processus de pid %d : J'ai reçu le signal %d\n",
	    getpid(), signal_num);
    return ;
}

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

    printf("\nJe suis le processus principal de pid %d\n", getpid());
    
    dormir(600);

    return EXIT_SUCCESS;
}
