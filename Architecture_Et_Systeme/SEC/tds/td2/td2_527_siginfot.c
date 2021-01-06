#include <signal.h> /* traitement des signaux */ 
#include <stdio.h>  /*entrées sorties */
#include <unistd.h> /*primitives de base */


int nbrecus = 0;
int nbalarm = 0;

void affsig(int signal_num) {
    printf("Recpetion du dignal %d\n", signal_num);
    nbrecus++;
}

void actif(int signal_num, siginfo_t *info, void *uap) {
    printf("Processud de pid %d : Reception du signal %d (SIGALRM), émetteur : %d\n",
	    getpid(), signal_num, info->si_pid);
    if (info->si_pid == 0) {
	/* les SIGALRM programmés sont envoyés par le scheduler (processus 0) */
	alarm(3);
	nbalarm++;
    } else {
	nbrecus++;
    }
}

int main(void) {
    struct sigaction mon_action;
    struct sigaction mon_action0;

    int ret, i;

    mon_action0.sa_handler = affsig;
    for (i = 1; i <= NSIG; i++) {
	ret = sigaction(i, &mon_action0, NULL);
    }
    mon_action.sa_sigaction = actif;
    mon_action.sa_flags = SA_SIGINFO;
    ret = sigaction(SIGALRM, &mon_action, NULL);

    alarm(3);
    while ((nbrecus != 5) && (nbalarm != 9)) {
	pause();
    }
    
    printf("reçus : %d, alarm : %d\n", nbrecus, nbalarm);
    return 0;
}
