/* Question 5 */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <signal.h>   /* signaux */
#include <string.h>   /* manipulation des chaines */
#include "readcmd.c"  /* lecture et analyse de la ligne de commande */
#include <stdbool.h>  /* les booléens */

#define NB_FILS 1

/* Variables globales */
int nb_fils_termines;
struct cmdline *cmd; // la ligne saisie
char ***seq;         // tubes de la ligne saisie 




/* Création d'une liste de processus */

enum Etat {A, S}; // A pour ACtif, S pour supendu
typedef enum Etat Etat;

typedef struct liste_processus *liste_proc; 
struct liste_processus {
    
    int id;              // identifiant propre au mini shell // Nombre d'éléments 
    int pid;             // pid du processus  
    Etat etat;           // processus actif ou suspendu
    struct cmdline *cmd; // ligne de commande lancée
    liste_proc suivant; 
};



/* Opérations sur liste_proc */
    /* Savoir si un processu est déja présent ou non dans la liste */
bool estPresent(int pid, liste_proc *liste) {
    bool present = false;

    if ((*liste) != NULL) {
        if (((*liste) -> pid) == pid) {
            present = true;
        } else {
            present = estPresent(pid, (*liste) -> suivant);
        } 
    }
    return present;
}
    /* Ajouter un processus de la liste */
void ajouter(int pid, Etat etat, struct cmdline *cmd, liste_proc *liste) {
    // On crée le nouvel élément
    liste_proc nliste = malloc(sizeof(struct liste_processus));
    if ((*liste) == NULL) {
        nliste -> id = 1;
    } else {
        nliste -> id = ((*liste) -> id) + 1;
    }
    nliste -> pid = pid;
    nliste -> etat = etat;
    nliste -> cmd = cmd;
    nliste -> suivant = NULL;
    // On ajoute en début de chaîne
    nliste -> suivant = (*liste);
    (*liste) = nliste; 

}
    
    /* Supprimer un processu de la liste */
void supprimer(int pid, liste_proc *liste) {
    if (estPresent(pid, *liste)) {
        if ((*liste)->pid == pid) {
            (*liste) = (*liste)->suivant;
        } else {
            supprimer(pid, (*liste)->suivant);
        }
    }
}

    /* Changer l'état d'un processus dans la liste */
void changerEtat(int pid, Etat etat, liste_proc *liste) {
     if (estPresent(pid, *liste)) {
        if ((*liste)->pid == pid) {
            (*liste)->etat = etat;
        } else {
            changerEtat(pid, etat, (*liste) -> suivant);
        }
        
     }
}

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
    if (signal_num == SIGCHLD) {
        while ((fils_termine == (int) waitpid(-1, &wstatus, WNOHANG | WUNTRACED | WCONTINUED)) > 0) {
            if WIFEXITED(wstatus) {   /* fils terminé avec exit */
                nb_fils_termines++;
            } else if WIFSIGNALED(wstatus) {  /* fils tué par un signal */
                nb_fils_termines++;
            } else if WIFCONTINUED(wstatus) {

            } else if WIFSTOPPED(wstatus) {

            }
        }
    }
}



int main() {
    int retour, pid;
    int duree_sommeil = 1;
    int nb_processus = 0;
    
    nb_fils_termines = 0; 

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
                 nb_processus++;
        
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
                      /* Traitement du cas où on veutr lancer une commande en tâche de fond */
                      if ((cmd -> backgrounded) == NULL) {
                        nb_processus = nb_processus - 1;
                        // On ne peut pas saisir de nouvelle commande
                        // tant que le processus fils est tojours actif
                        do {
                           sleep(1);
                         } while (nb_fils_termines < NB_FILS);
                         // waitpid(retour, NULL, WUNTRACED);
                      }  else {   
                         // Que le processus fils soit actif ou non,
                         // le processus père peut toujours traiter
                         // une nouvelle commande
                         printf("[%d] %d\n", nb_processus, retour);
                        
                      }
                   }
                  
            }
        } 
        
     
    }
     return(EXIT_SUCCESS);
 }
