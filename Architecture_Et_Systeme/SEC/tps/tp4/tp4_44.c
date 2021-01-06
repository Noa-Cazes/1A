/* Exemple d'utilisation des primitives Unix : Un père et ses fils */
/* 1 pipe : depuis les fils vers le père */

#include <stdio.h>    /* E/S */
#include <unistd.h>   /* primitives de base */
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opértaions sur les chaînes */
#include <signal.h>   /* traitement des signaux */

#define NB_FILS 3

void handler_sigchld(int signal_num) {
    int fils_termine, wstatus;

    while ((fils_termine = (int) waitpid(-1, &wstatus, WNOHANG)) > 0) {
	printf("\nMon fils %d est arrêté\n", fils_termine);
    }
}


int main() {
    int i, fils, retour, pid, num, retw;

    int pipe_f2p[2]; /* pipe pour communiquer des fils vers le père */
    char message[1024]; 

    signal(SIGCHLD, handler_sigchld);
    
    /* Mise en place du message */
    for (i = 0; i<sizeof(message); i++) {
	message[i] = 'a';
    }

    retour = pipe(pipe_f2p);

    if (retour == -1) {
	printf("Erreur pipe\n");
	exit(1);
    }

    printf("\nJe suis le processus principal de pid %d\n", getpid());

    for (fils = 1; fils <= 3; fils++){
	retour = fork();

	if (retour < 0) {
	    printf("Erreur fork\n");
	    exit(1);
	}
	else if (retour == 0) {
	    /* fermer l'extrémité 0 : le fils va écrire dans le pipe */
	    close(pipe_f2p[0]);
            pid = getpid(); 
	    printf("\n	Processus de pid %d, de père %d", pid, getppid());
    	    num = 1;       
	    /* Ecrire sans s'arrêter */
	    while(1) {
		sprintf(message, "Le bonjour du fils %d\n", fils);
	        retw = write(pipe_f2p[1], message, sizeof(message));
		printf("\n	Processus de pid %d envoie son message numéro %d de taille %d\n", pid, num, retw);
		num++;
		sleep(1);
	   }
	    
	    /* Fermet l'extrémité 1 : fin des envois */
	    /* Le prochaine lecture sur ce pipe renverra 0 */
	    close(pipe_f2p[1]);

	    /* Terminer le processus */
	    exit(EXIT_SUCCESS);
	} else {
	    printf("\nProcus de pid %d acrée un fils de numéro %d et de pid %d",
		    getpid(), fils, retour);
	}
    }


    /* Fermer l'extrémité 1 : le père lit dans le pipe */
    close(pipe_f2p[1]);
    
    /* Pas de lecture pendant longtemps */
    sleep(300);

    /* Fermerl'extrémité 0 : la lecture est finie */
    close(pipe_f2p[0]);
    printf("\nProcessus Principal terminé.\n");

    return EXIT_SUCCESS;
}



