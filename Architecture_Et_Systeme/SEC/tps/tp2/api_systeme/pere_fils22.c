/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* Création de fils : fork et exit */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <string.h>   /* manipulation des chaines */
#include <signal.h>   /* traitement des signaux */

#define NB_FILS 3     /* nombre de fils */

/* Traitant du signal SIGINT */
void handler_sigint(int signal_num) {
    printf("\n	  Processus de pid %d : J'ai reçu le signal %d\n",
	    getpid(), signal_num);
    return ;
}


/* dormir pendant nb_secondes secondes */
void dormir(int nb_secondes) {

    int duree = 0;
    while (duree < nb_secondes) {
	sleep(1);
	duree++;
    }
}


int main(int argc, char *argv[])
{
    int fils, retour;
    int duree_sommeil = 600;
    char progname[]="pere_fils.c";

    if (argc > 1) {
        write(atoi(argv[1]), progname, strlen(progname));
    }
    
    /* associer un traitant au signal SIGINT */
    signal(SIGINT, handler_sigint);

    /* associer le même traitant aux signaux SIGTSTP et SIGCONT */
    signal(SIGTSTP, handler_sigint);
    signal(SIGCONT, handler_sigint);

    printf("\nJe suis le processus principal de pid %d\n", getpid());

    for (fils = 1; fils <= NB_FILS; fils++) {
        retour = fork();

        /* Bonne pratique : tester systématiquement le retour des appels système */
        if (retour < 0) {   /* échec du fork */
            printf("Erreur fork\n");
            /* Convention : s'arrêter avec une valeur > 0 en cas d'erreur */
            exit(1);
        }

        /* fils */
        if (retour == 0) {
            printf("\n     Processus fils numero %d, de pid %d, de pere %d\n", 
                    fils, getpid(), getppid());
            sleep(duree_sommeil);
            /* Important : terminer un processus par exit */
            exit(EXIT_SUCCESS);   /* Terminaison normale (0 = sans erreur) */
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
        }
    }
    sleep(duree_sommeil + 2);
    return EXIT_SUCCESS;
}
