/* Exemple d'utilisation des primitives Unix : Un père et ses fils */
/* 1 pipe depuis chaque fils vers le père, en mode non bloquant fcntl*/
/* SIGUSR1 envoyé par le fils après chaque écriture dans le pipe */

#include <stdio.h>    /* E/S */
#include <unistd.h>   /* primitives de base */
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opérations sur les chaînes */
#include <signal.h>   /* traitement des signaux */
#include <fcntl.h>    /* fcntl */
#include <errno.h>    /* errno */

#define NB_FILS 3     /* nombre de fils */

/* Variables globales acr utilisées par le handler */
int nb_pipes_fermes;
int pipe_ferme[NB_FILS+1];  /* Savoir si un pipe est fermé ou non */
int pipe_f2p[NB_FILS+1][2]; /* pipe pour communiquer des fils vers le père */

/* Traitant du signal SIGUSR1 : activé par l'envoi d'un signal SIGUSR1 par un des fils */
/* Lecture des données envoyées par les fils */
void handler_sigusr1(int signal_num) {
    int retour, pid, fils;
    for (fils = 1; fils <= NB_FILS; fils++) {
	if(!pipe_ferme[fils]) {
	    while((retour = read(pipe_f2p[fils][0], &pid, sizeof(int))) > 0) {
		printf("\nProcessus Principal - reçu : %d\n", pid);
	    }
	    if (retour == 0) { /* pipe fermé en écriture */
		pipe_ferme[fils] = 1; 
		nb_pipes_fermes++;
		printf("Processus Principal - Fils %d a fermé son pipe\n", fils);
	    }
	    /* cas d'erreur */
	    else if (!(retour == -1 && errno == EAGAIN)) {
		printf("Processus Principal - Erreur sur lecture pipe du fils %d : \n", fils);
	    }
	}
    }
    /* réarmer l'alarme */
    return;
}


int main() {
    int fils, retour, pid;
    
    /* Création de NB_FILS pipes */
    for (int i = 1; i <= NB_FILS; i++) {
	retour = pipe(pipe_f2p[i]);
	if (retour == -1) {
	    printf("Erreur pipe\n");
	    exit(1);
	}
    }
    
    /* Associer un traitant au signal SIGUSR1 */
    signal(SIGUSR1, handler_sigusr1);

    printf("\nJe suis le processus principal de pid %d\n", getpid());

    for (fils = 1; fils <= 3; fils++){
	retour = fork();

	if (retour < 0) {
	    printf("Erreur fork\n");
	    exit(1);
	}
	else if (retour == 0) {
	    /* fermer l'extrémité 0 : le fils va écrire dans le pipe */
	    close(pipe_f2p[fils][0]);

	    /* fermer tous les autres pipes */
	    for (int i = 1; i <= NB_FILS; i++) {
		if (i!=fils) {
		    close(pipe_f2p[i][0]);
		    close(pipe_f2p[i][1]);
		}
	    }
	    pid = getpid();

	    /* écrire 5 fois son pid dans le pipe */
	    for (int i = 1; i <= 5; i++) {
		sleep(2 * (NB_FILS - fils));
		printf("\n	Processus de pid %d effectue un envoi\n", pid);
		write(pipe_f2p[fils][1], &pid, sizeof(int));
		kill(getppid(), SIGUSR1);
	    }

	    /* Fermer l'extrémité 1 : fin des envois */
	    close(pipe_f2p[fils][1]);

	    /* Terminer le processus */
	    exit(EXIT_SUCCESS);
	} else {
	    printf("\nProcessus de pid %d a crée un fils de numéro %d et de pid %d\n",
		    getpid(), fils, retour);
	}
    }


    /* Fermer toutes les extrémités 1 : père lecteur */
    for (int i = 1; i <= NB_FILS; i++) {
	close(pipe_f2p[i][1]);
    }

    /* mettre les extrémités 0 des pipes en mode non bloquant */
    for (fils = 1; fils <= NB_FILS; fils++) {
	retour = fcntl(pipe_f2p[fils][0], F_SETFL, fcntl(pipe_f2p[fils][0], F_GETFL) | O_NONBLOCK);
	pipe_ferme[fils] = 0;
	if (retour == -1) {
	    printf("Processus Pricipal - Echec fcntl\n");
	}
    }

    nb_pipes_fermes = 0;
    
    /* faire ce qu'on a à faire sans se soucier des lectures dans les pipes */
    do {
	/* attente d'un signal : peut être remplacé par tout autre traitement */
	pause();
    } while (nb_pipes_fermes < NB_FILS); 

    /* Fermer les extrémités 0 de tous les pipes */
    for (int i = 1; i <= NB_FILS; i++) {
	close(pipe_f2p[i][0]);
    }
    printf("\nProcessus Principal terminé.\n");

    return EXIT_SUCCESS;
}



