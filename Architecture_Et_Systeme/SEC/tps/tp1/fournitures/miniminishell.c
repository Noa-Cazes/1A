/* Exercice de synthèse : Miniminishell*/


#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <stdbool.h>


int main(int argc, char *argv[])
{
    int pidfils, idfils, wstatus;
    char buf[30]; /* contient la commande saisie au clavier */

    printf("Je suis le processus principal de pid %d\n", getpid());

    /* Vidange du tampon de sortie pour que le fils le récupère vide */
    fflush(stdout);

    while (true) {
        printf("Entrez le nom d'une commande (sans paramètre) de moins de 30 caractères:\n");
        scanf("\%s", buf); /* lit et rentre dans buf la chaine entrée au clavier */
        pidfils = fork();


        /* échec du fork */
        if (pidfils < 0) {   
            printf("Erreur fork. La commande n'a donc pas pu être exécutée.\n");
            /* Convention : s'arrêter avec une valeur > 0 en cas d'erreur */
            exit(1);
        }

        /* fils */
        if (pidfils == 0) {
    printf("Pour lancer cette commande, on crée un processus fils \(%d\) de père \(%d\)\n", getpid(), getppid());
            /* On choisit execlp carle premier argument est char *file, qui est ce dont on dispose */
            execlp(buf, buf, NULL);

            /* on ne se retrouve ici que si exec échoue */
            printf("\n     Processus fils numero %d : ERREUR EXEC.\n", getpid());
            
            /* perror : affiche un message relatif à l'erreur du dernier appel systàme */
            perror("     exec ");
            exit(2);   /* sortie avec le numéro 2 si cela échoue */ 
        }
        /* pere */
        else {
            fflush(stdout);
            idfils = wait(&wstatus);
            /* On ne traite le cas que lorsque le fils a été tué par un exit */
            if (WEXITSTATUS(wstatus) == 0) {
                printf("La commande s'est correctement exécutée!\n");
            } else if (WEXITSTATUS(wstatus) == 2) {
                printf("La commande ne s'est correctement exécutée ...\n");
            }

        }
        sleep(2);
    }
    return EXIT_SUCCESS;
}

