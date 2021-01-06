/* Imprimer le numéro de tous les signaux reçus.
 * Indiquer toutes les trois secondes qu'il est toujours actif,
 * et en attente de signaux.
 * Au bout de 5s ignaux reçus ou de 27 secondes, il devra s'arrêter.
 * Utiliser alarm our envoyer les SIGALRM.
 * Utiliser sigaction. 
 * Pas de distinction quant à la source des signaux SIGALRM. */

#include <signal.h>   /* traitement des signaux */
#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   

static int nbrecus = 0;
static int nbalrm = 0;

void affsig(int signal_num) {
    printf("Réception du signal %d\n", signal_num);
    nbrecus++;
}

void actif(int signal_num) {
    printf("Reception du signal %d (SIGALRM)\n", signal_num);
    printf("Toujours actif ...\n");
    alarm(3);
    nbalrm++;
}

int main(){
    struct sigaction mon_action;
    int i, ret;

    mon_action.sa_handler = affsig;

    for(i=1; i<=NSIG; i++) {
	ret = sigaction(i, &mon_action, NULL);
    }

    mon_action.sa_handler = actif;
    ret = sigaction(SIGALRM, &mon_action, NULL);

    alarm(3);
    while((nbrecus != 5) && (nbalrm != 9)) {
	pause(); /* en attente d'un signal quelconque */
    }
    printf("recus %d, alarm %d\n", nbrecus, nbalrm);
    return 0;

}
