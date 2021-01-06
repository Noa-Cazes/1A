/* Exemple d'itilisation des primitives Unix : un père et ses fils */
/* 1 fichier :  1 seule ouverture en écriture partagée */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>

#define NB_FILS 3

int main() {
    int fils, retour, desc_fic, fils_termine, wstatus, ifor;
    int duree_sommeil = 3;

    char fichier[] = "fic_centaines.txt";
    char buffer[8]; /* buffer de lecture */

    /* Initialiser le buffer avec zerp */
    bzero(buffer, sizeof(buffer));

    /* Ouverture du fichier */
    desc_fic = open(fichier, O_WRONLY | O_CREAT |O_TRUNC,0640);
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

	    /* Ecrire dans le fichier */
	    for (ifor = 1; ifor <= 4; ifor ++) {
		bzero(buffer, sizeof(buffer));
		sprintf(buffer, "%d-%d\n", fils, ifor);
		write(desc_fic, buffer, strlen(buffer));
		printf("	Processus fils numéro %d a écrit %s\n",
			fils, buffer);
		sleep(duree_sommeil);
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

