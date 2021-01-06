/* Question 4 */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <signal.h>   /* signaux */
#include <string.h>   /* manipulation des chaines */
#include "readcmd.c"  /* lecture et analyse de la ligne de commande */
#include <stdbool.h>  /* les booléens */

#define NB_FILS 1

int nb_fils_termines;

struct cmdline *cmd; // la ligne saisie
char ***seq;         // tubes de la ligne saisie 

/* Dormir pendant nb_secondes sans être interrompu par un signal */
void dormir(int nb_secondes) {
    int duree = 0;
    while (duree < nb_secondes) {
	sleep(1);
	duree++;
    }
    return;
}

/* Lancer la commande par le processus de pid pid */
void lancerCmd(char ***seq) {
    
    int exe; 

    if (seq[0][0] != NULL) { // la ligne de commande est non vide
        exe = execvp(seq[0][0], seq[0]);
    }
    if (exe == -1) {
        perror("Erreur ");
        exit(0);
    }
    
}

/* Lancer une commande interne (ici soit cd, soit exit) */
void lancerCmdIntCd(char ***seq) {
    
      if (seq[0][1] != NULL) { // un chemin est spécifié
        chdir(seq[0][1]);
       } else { // aucun chemin n'est spécifié
                /* ON recherche dans la liste des variables
                /* environnements une variable nommée home */
         char *racine = getenv("HOME");
         chdir(racine);
       }
}
   
     
/* Traitant du signal SIGCHLD */
void handler_sigchld(int signal_num) {
    int wstatus, fils_termine;

    fils_termine = wait(&wstatus);
    nb_fils_termines++;
    if WIFEXITED(wstatus) {   /* fils terminé avec exit */
        //printf("\nMon fils de pid %d a terminé avec exit %d\n", 
        //       fils_termine, WEXITSTATUS(wstatus));
    }
    else if WIFSIGNALED(wstatus) {  /* fils tué par un signal */
        printf("\nMon fils de pid %d a ete tue par le signal %d\n", 
                fils_termine, WTERMSIG(wstatus));
    }
    return;
}



int main() {
    int retour, pid;
    int duree_sommeil = 1;
    
    /* Associer les signaux à des traitants*/
    signal(SIGKILL, SIG_DFL);
    signal(SIGINT, SIG_DFL);
    signal(SIGTSTP, SIG_DFL);
    signal(SIGCHLD, handler_sigchld);

    /* Créer un ensemble de signaux */
    sigset_t ens_signaux;
    sigemptyset(&ens_signaux);
    sigaddset(&ens_signaux, SIGINT);
    sigaddset(&ens_signaux, SIGTSTP);

    while (true) {
        printf("> ");
        /* Lecture d'une ligne sur l'entrée standard */
        /* Interprétation comme une commande */
        cmd = readcmd();
        seq = cmd -> seq;

        if (seq[0] != NULL) {
            if (strcmp(seq[0][0], "exit") == 0) { // la commande entrée est exit
                exit(0);
            } else if (strcmp(seq[0][0], "cd") == 0) { // la commande entrée est cd
                lancerCmdIntCd(seq);
            } else {
                 /* Création d'un processsu fils */
                 retour = fork();
        
                 if (retour < 0) {   /* échec du fork */
                 printf("Erreur fork\n");
                 /* Convention : s'arrêter avec une valeur > 0 en cas d'erreur */
                 exit(1);
                  }

                  /* fils */
                  if (retour == 0) {
                     /* Bloquer les signaux pour ne pas que que readcmd() renvoie null */
                     sigprocmask(SIG_BLOCK, &ens_signaux, NULL);
                     /* Lancement de la commande par le processus fils */
                     lancerCmd(seq);
                   }

                  /* père */
                   else {
           
                   }
                   do {
                    sleep(1);
                   } while (nb_fils_termines < NB_FILS);
            }
        } 
     
    }
    return(EXIT_SUCCESS);
}
    
