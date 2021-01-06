/* Partie 1.1 exercice 4 */
#include <stdio.h>    /* entrées sorties */
#include <string.h>   /* manipulation des chaines */
#include <signal.h>   /* traitement des signaux */
#include <unistd.h>   /* primitives de base */
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */

#define D_ALARM 5
#define NB_FILS 1

int nb_fils_termines;

/* Traitant de tout signal hors SIGALRM et SIGCHLD  */
void handler_sig(int signal_num) {
    printf("\n	  Processus de pid %d : J'ai reçu le signal %d\n",
	    getpid(), signal_num);
    return ;
}

/* Traitant du signal SIGALRM */
void handler_sigalrm(int signal_num) {
    int cpt = 0; // quand le compteur a atteint 12, soit 12*5 = 60s,
                 // le processus est tué
    int courant = getpid();
    while (cpt != 12) {
	if (signal_num == SIGALRM) {
	    printf("\nProcessus de pid %d : Je suis toujours actif\n", getpid());
	    sleep(1);
	}
	alarm(D_ALARM);
	cpt++;
    }
    kill(courant, SIGKILL);
    return;
}
/* Traitant du signal SIGCHLD */
void handler_sigchld(int signal_num) {
    int wstatus, fils_termine;
     
    fils_termine = wait(&wstatus);
    
    nb_fils_termines++;
    if (signal_num == SIGCHLD) {
	if WIFEXITED(wstatus) {
	    printf("\nMon fils de pid %d a terminé avec exit %d\n",
		    fils_termine, WEXITSTATUS(wstatus));
	} else if WIFSIGNALED(wstatus) {
	    printf("\nMon fils de pid %d a été tué par le signal %d\n",
		    fils_termine, WTERMSIG(wstatus));
        }
    }
   return; 
}
/* Dormir pendant nb_secondes */
void dormir(int nb_secondes) {
    int duree = 0;
    while (duree < nb_secondes) {
	sleep(1);
	duree++;
    }
}

int main()
{   
    int duree_sommeil = 6;
    
    char ref_exec[] = "/bin/sleep";
    char arg2_exec[] = "100";
    
    nb_fils_termines = 0;

    /* associer un traitant affichant le numéro du signal à chaque signal reçu */
    signal(SIGINT, handler_sig);
    signal(SIGQUIT, handler_sig);
    signal(SIGILL, handler_sig);
    signal(SIGCHLD, handler_sigchld);
    signal(SIGTSTP, handler_sig);
    signal(SIGTERM, handler_sig);
    signal(SIGCONT, handler_sig);
    signal(SIGSTOP, handler_sig);
    signal(SIGQUIT, handler_sig);
    signal(SIGALRM, handler_sigalrm);

    printf("\nJe suis le processus principal de pid %d\n", getpid());
    
    /* Création d'un processus fils */
    int fils;
    fils = fork();

    if (fils < 0) {
	printf("\nErreur fork!");
	exit(1);
    } else if (fils == 0) {
	printf("\nProcessus de pid %d, de père de pid %d\n",
		getpid(), getppid());
	execl(ref_exec, ref_exec, arg2_exec, NULL);
	exit(2);
    } else {
	printf("\nProcessus de pid %d, j'ai créé un fils de pid %d\n",
		getpid(), fils);
    }

    do {
	//alarm(D_ALARM);
    } while (nb_fils_termines < NB_FILS);


    return EXIT_SUCCESS;
}
