/* Exemple d'itilisation des primitives Unix : un père et ses fils */
/* Fichiers : lecture partagée entre un père et ses fils avec ouverture unique */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>

#define NB_FILS 3

int main() {
    int fils, retour, desc_fic, fils_termine, wstatus;
    int duree_sommeil = 3;

    char fichier[] = "fic_centaines.txt";
    char buffer[8]; /* buffer de lecture */

    /* Initialiser le buffer avec zerp */
    bzero(buffer, sizeof(buffer));

    /* Ouverture du fichier en lecture */
    desc_fic = open(fichier, O_RDONLY);
    /* Traiter les retours d'erreurs des appels */
    if (desc_fic <0 ) {
	printf("Erreurd d'ouverture %s\n", fichier);
	exit(1);
    }
    
    for (fils = 1; fils <= NB_FILS; fils++) {
	retour = fork();

	if (retour < 0) {
	    printf("Erreur avec le fork\n");
	    exit(1);
	} else if (retour == 0) {
	    /* décaler les lectures des différents fils */
	    sleep(NB_FILS - fils);

	    /* Lire le fichier par blocs de 4 octets */
	    while (read(desc_fic, buffer, 4) >00) {
		printf("Processus fils de numéro %d a lu %s\n",
			fils, buffer);
		sleep(duree_sommeil);
		bzero(buffer, sizeof(buffer));
	    }
	    /* Imp : terminer un processu par exit */
	    exit(EXIT_SUCCESS);

       } else {
	   printf("Processus de pid %d a crée un fils de numéro %d, de pid %d\n",
		   getpid(), fils, retour);
	 }
    }
    /* Attendre la fin des fils */
    for (fils = 1; fils <= NB_FILS; fils++) {
	/* attendre la fin d'un fils */
	fils_termine = wait(&wstatus);

	if (WIFEXITED(wstatus)) {
	    printf("\nMon fils de pid %d s'est terminé par un exit %d\n",
		    fils_termine, WEXITSTATUS(wstatus));
	} else if (WIFSIGNALED(wstatus)) {
	    printf("\nMon fils de pid %d a été tué par un signal %d\n",
		    fils_termine, WTERMSIG(wstatus));
	}
   }
    close(desc_fic);
    printf("\nProcessus Principal terminé\n");
    return EXIT_SUCCESS;
}

