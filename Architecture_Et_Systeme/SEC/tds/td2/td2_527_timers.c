/* Imprimer le numéro de tous les signaux reçus.
 * Indiquer toutes les trois secondes qu'il est toujours actif,
 * et en attente de signaux.
 * Au bout de 5s ignaux reçus ou de 27 secondes, il devra s'arrêter.
 * Utiliser les timers  envoyer les SIGALRM. */

#include <signal.h>   /* traitement des signaux */
#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   
#include <sys/time.h>

static int nbrecus = 0;
static int nbalrm = 0;
struct itimerval duree;

void affsig(int signal_num) {
    printf("Réception du signal %d\n", signal_num);
    nbrecus++;
}

void actif(int signal_num) {
    getitimer(ITIMER_REAL, &duree);
    printf("Reception du signal %d (SIGALRM)\n", signal_num);
    printf("Toujours actif, restait %ld s, %ld µs ...\n",
	    duree.it_value.tv_sec, duree.it_value.tv_usec);
    if ((duree.it_value.tv_sec == 2) && (duree.it_value.tv_usec >= 999500)) {
	nbalrm++;
    } else {
	nbrecus++;
    }
}

int main(){
    int i, ret;

    for(i=1; i<=NSIG; i++) {
	signal(i, affsig);
    }
    signal(SIGALRM, actif);
    
    duree.it_value.tv_sec = 3;
    duree.it_value.tv_usec = 0;
    duree.it_interval.tv_sec = 3;
    duree.it_interval.tv_usec = 0;
    
    setitimer(ITIMER_REAL, &duree, NULL); /* armement du timer temps-réel */

    while((nbrecus != 5) && (nbalrm != 9)) {
	pause(); /* en attente d'un signal quelconque */
    }
    printf("recus %d, alarm %d\n", nbrecus, nbalrm);
    return 0;

}
