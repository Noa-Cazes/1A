/* Exemple d'utilisation des primitives Unix : Un père et ses fils */
/* Redirections : stdin, pipe, stdout */

#include <stdio.h>    /* E/S */
#include <unistd.h>   /* primitives de base */
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opérations sur les chaînes */
#include <signal.h>   /* traitement des signaux */
#include <fcntl.h>    /* opérations sur les fichiers */


int main() {
    int retourp, retourq, dupdesc, retourcmd;

    int q[2];  /* pipe entre les commandes who et grep nom_utilisateur */
    int p[2] ; /* pipe entre les commandes grep nom_utilisateur et wc -l*/

    /* Créer le pipe p */
    retourp = pipe(p);
    /* tester les retours des appels */
    if (retourp == -1) {
	    printf("Erreur pipe\n");
	    exit(1);
    }
    /* fils : grep nom_utilisateur | père : wc -l */	
    retourp = fork();
    /* tester les retours des appels */
    if (retourp < 0) {
	    printf("Erreur fork\n");
	    exit(2);
    } else if (retourp == 0) { /* fils */

        /* Création du pipe q */
        retourq = pipe(q);
        /* tester  les retours ssystème */
        if (retourq == -1) {
	        printf("Erreur pipe\n");
	        exit(5);
        } 

        /* fermer l'extrémité 0 du pipe p : le fils est en écriture */
        close(p[0]);

        /* création du fils */
        /* fils : who | père : grep nom_utilisateur */	
        retourp = fork();
        /* tester les retours des appels */
        if (retourp < 0) {
	        printf("Erreur fork\n");
	        exit(6);
        } else if (retourq == 0) {
                /* fermer l'extrémité 0 de q : le petit-fils est en écriture */
                close(q[0]);
                
                 /* rediriger stdout vers q[1] */
                 dupdesc = dup2(q[1], 1);
                 /* en cas d'echec du dup2 */
	             if (dupdesc == -1) {
	                printf("Erreur dup2\n");
	                exit(7);
	             }
                
                  /* fermer l'extrémité 1 */
                   close(1);

                 /* exécuter la commande who */
                  execlp("who", "who", NULL);

                  /* on ne se retrouve ice que si execlp échoue */
                  perror("  ereur");
                  exit(9);
       } else {
            /* fermer l'extrémité 1 de q : le fils lit dans le pipe q */
            close(q[1]);

            /* rediriger stdin vers q[0] */
            dupdesc = dup2(q[0], 0);
             /* en cas d'echec du dup2 */
	        if (dupdesc == -1) {
                printf("Erreur dup2\n");
	            exit(7);
	        }

            /* fermer l'extrémité 0 */
            close(0);

            /* rediriger stdout vers q[1] */
            dupdesc = dup2(q[1], 1);
            /* en cas d'echec du dup2 */
	        if (dupdesc == -1) {
                printf("Erreur dup2\n");
	            exit(7);
	        }

            /* fermer l'extrémité 1 */
            close(1);

            /* exécuter la commande grep nom_utilisateur */
            execlp("grep", "grep", "-user", NULL);

            /* on ne se retrouve ici que si execlp échoue */
            perror("  ereur");
            exit(9);
       }
    } else { /* père */
        /* fermer l'extrémité 1 du pipe p : le père est en lecture */
        close(p[1]);

        /* rediriger stdin vers p[0] */
        dupdesc = dup2(p[0], 0);
        /* en cas d'echec du dup2 */
	    if (dupdesc == -1) {
            printf("Erreur dup2\n");
	        exit(7);
	    }


        /* exécuter la commande wc -l */
        execlp("wc", "wc", "-l", NULL);

        /* on ne se retrouve ici que si execlp échoue */
        perror("  ereur");
        exit(9);
    }

    return EXIT_SUCCESS;
}



