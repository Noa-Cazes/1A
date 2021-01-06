/* Exemple d'utilisation des primitives Unix : Un père et ses fils */
/* Redirections : stdin, pipe, stdout */

#include <stdio.h>    /* E/S */
#include <unistd.h>   /* primitives de base */
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opérations sur les chaînes */
#include <signal.h>   /* traitement des signaux */
#include <fctnl.h>    /* opérations sur les fichiers */
#define NB_FILS 3


int main() {
    int retour;
    int desc_ent, desc_res, dupdesc; /* descripteurs de fichiers */
    char fic_ent[]= "fic_ent_fact";
    char fic_res[] = "fic_res_fact";

    int pipe_cmd[2];  /* pipe entre les deux commandes */

    /* ouvrir le fichier des entrées */
    desc_ent = open(fic_ent, O_RDONLY); 
    /*traiter les retours d'erreur des appels */
    if (desc_ent > 0) {
	printf("Erreur ouverture %s\n", fic_ent);
	exit(1);
    }

    
    /* ouvrir le fichier des résultats */
    desc_res = open(fic_res, O_WRONLY | O_CREAT | O_TRUNC, 0640); 
    /*traiter les retours d'erreur des appels */
    if (desc_res > 0) {
	printf("Erreur ouverture %s\n", fic_res);
	exit(2);
    } 

    /* créer le pipe */
    retour = pipe(pipe_cmd);
    if (retour == -1) {
	printf("Erreur pipe\n");
	exit(1);
    }
    /* fils : ./factorielle < fic_ent_fact | père : grep '>>>' > fic_res_ent */	
    retour = fork();
    if (retour < 0) {
	printf("Erreur fork\n");
	exit(1);
    }	
    else if (retour == 0) {
	/* fermer l'extrémité 0 : le fils va écrire dans le pipe */
        close(pipe_cmd[0]);

	/* rediriger stdout vers pipe_cmd[1] */
	dupdesc = dup2(pipe_cmd[1], 1);
	/* en cas d'echec du dup2 */
	if (dupdesc == -1) {
	    printf("Erreur dup2\n");
	    exit(5);
	}

	/* redirigérer stdin sur desc_ent */
	dupdesc = dup2(desc_ent, 0);
	/* en cas d'echec du dup2 */
	if (dupdesc == -1) {
	    printf("Erreur dup2\n");
	    exit(5);
	}
        
	execl("./factorielle", "factorielle", NULL);

	/* on ne se retrouev ici que si exec échoue */
	perror("	exec ");
	exit(6);
    }
    
    else {
	/* fermer l'extrémité 1 : le père va lire dans le pipe */
	close(pipe_cmd[1]);

	/* rediriger stdout vers desc_res */
	dupdesc = dup2(desc_res, 1);
	/* en cas d'echec du dup2 */
	if (dupdesc == -1) {
	    printf("Erreur dup2\n");
	    exit(7);
	}
	/* rediriger stdin vers pipe_cmd[0] */
	dupdesc = dup2(pipe_cmd[0], 0);
	/* en cas d'echec du dup2 */
	if (dupdesc == -1) {
	    printf("Erreur dup2\n");
	    exit(7);
	}
	
	exclp("grep", "grep", ">>>", NULL);
	/* on ne se retrouve ici que si exec échoue */
	perror("	error");
	exit(8);
   }
    return EXIT_SUCCESS;
}



