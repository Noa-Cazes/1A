/* Partie 1.2 Exercice */
/* Question 1
 * SIGINT ne sera pas affiché.
 * 1 SIGUSR1, sur les deux envoyés, sera affiché. 
 * Les 2 SIGUSR2, sur les 2 envoyés, seront affichés, car non masqués.*/
/* Question 2
 * Les 2 SIGUSR2 seront affichés en premier, car SIGUSR2 est le
 * seul signal non masqué.
 * Ensuite, après le démasquage de SIGUSR1, le dernier signal envoyé,
 * comme il correspond à SIGUSR1, sera affiché. */
/* Question 3
 * Le message de terminaison s'affiche 25s après le début de l'exécution.
 * Cela s'est avéré être faux. 
 * Le message de terminaison ne s'affiche pas. */

#include <stdio.h>   /* entrées sorties */
#include <signal.h>  /* signaux */
#include <unistd.h>  /* primitives de base */
#include <stdlib.h>  /* exit */

/* Traitant des signaux SIGUSR1 et SIGUSR2 */
void handler_sigusr(int signal_num) {
    printf("\nProcessus de pid %d : J'ai reçu le signal %d\n",
	getpid(), signal_num);
    return;
}

/* Dormir pendant nb_secondes sans être interrompu par un signal */
void dormir(int nb_secondes) {
    int duree = 0;
    while (duree < nb_secondes) {
	sleep(1);
	duree++;
    }
    return;
}



int main() {
    int courant = getpid();

    /* Associer un traitant aux signaux */
    signal(SIGUSR1, handler_sigusr);
    signal(SIGUSR2, handler_sigusr);
    signal(SIGINT, SIG_DFL);

    /* Créer un ensemble avec les signaux SIGINT et SIGUSR1 */
    sigset_t ens_signaux;
    sigemptyset(&ens_signaux);
    sigaddset(&ens_signaux, SIGUSR1);
    sigaddset(&ens_signaux, SIGINT);

    /* Masquer les signaux qui sont dans ens_signaux */
    sigprocmask(SIG_BLOCK, &ens_signaux, NULL);

    /* Attendre 10s pendant lequelles SIGINT est envoyé */
    dormir(10);
    kill(courant, SIGINT);

    /* Envoyer deux SIGUSR1 */
    kill(courant, SIGUSR1);
    kill(courant, SIGUSR1);

    /* Attendre 5s */
    dormir(5);

    /* Envoyer 2 SIGUSR2 */
    kill(courant, SIGUSR2);
    kill(courant, SIGUSR2);

    /* Enlever SIGINT de ens_signaux */
    sigdelset(&ens_signaux, SIGINT);

    /* Démasquer SIGUSR1 */
    sigprocmask(SIG_UNBLOCK, &ens_signaux, NULL);

    /* Attendre 10s */
    dormir(10);

    /* Ajouter SIGINT à ens_signaux et enlever SIGUSR1*/
    sigaddset(&ens_signaux, SIGINT);
    sigdelset(&ens_signaux, SIGUSR1);

    /* Démasquer SIGINT */
    sigprocmask(SIG_UNBLOCK, &ens_signaux, NULL);
    
    /* Afficher un message de terminaison */
    printf("Processus de terminé");
    
    return EXIT_SUCCESS;
}


