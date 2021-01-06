/* Exemple d'illustration des primitives Unix : un père et ses fils */
/* Traitement du signal SIGINT : SIG_IGN et SIG_DFL avec exec */

#include <stdio.h>      /* E/S */
#include <unistd.h>     /* primitives de base */
#include <stdlib.h>     /* exit */
#include <signal.h>     /* pour le traitement des signaux */

#define NB_FILS 3

/* Traitant du signal SIGINT */
void handler_sigint(int signal_num) {
    printf("\n     Processus de pid %d : J'ai reçu le signal %d\n",
	    getpid(), signal_num);
    return;
}

/* dormir pendant nb_secondes secondes */
/* à utiliser à la place de sleep(duree), car sleep s'arrête */
/* dès qu'un signal non ignoré est reçu */
void dormir (int nb_secondes) {
    int duree = 0;
    while (duree < nb_secondes) {
	sleep(1);
	duree++;
   }
}

int main() {

    int fils, retour;
    int duree_sommeil = 600;

    char ref_exec[] = "./dormir";  /* exécutable */
    char arg0_exec[] = "je dors";  /* argument 0 du exec : nom donné au processus */
    char arg1_exec[] = "600";      /* argument 1 du exec : durée du sommeil */

    /* Associer un traitant au signal SIGINT */
    signal(SIGINT, handler_sigint);

    printf("\nJe suis le processus principal de pid %d\n", getpid());

    for(fils=1; fils <= NB_FILS; fils++) {
	retour = fork();

	if (retour < 0){
	    printf("Erreur fork\n");
	    exit(1);
	}

	/* Fils */
	if (retour == 0) {
	    if (fils == 1) {
		signal(SIGINT, SIG_IGN);
	    } else if (fils == 2) {
		signal(SIGINT, SIG_DFL);
	    }

	    printf("\n     Processus fils numéro %d, de pid %d, de père %d.\n",
		    fils, getpid(), getppid());
	    
	    execl(ref_exec, arg0_exec, arg1_exec, NULL);

	    /* Si cela échoue */
	    printf("\n     Processus fils numéro %d : ERREUR EXEC\n", fils);
	    /* perror : affiche un message relatif à l'erreur du dernier appelant système */
	    exit(fils);

       }

        /* Père */
	else {
	    printf("\nProcessus de pid %d a créé un fils de numéro %d, de pid %d.\n",
		    getpid(), fils, retour);
	}
}
    dormir(duree_sommeil + 2);
    return EXIT_SUCCESS;
}
