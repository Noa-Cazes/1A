#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/types.h>

char* base; 
size_t taillepage; 

/* traitant des signaux SIGSEGV et SIGBUS*/
void handler(int sig) {
    int retour;
    retour = mprotect(base, taillepage, PROT_WRITE|PROT_READ);
    printf("signal : %d, résultat mprotect : %d\n", sig, retour); 
}

int main(int argc, char *argv[]) {
    int i, retour;
    /* taille d'une page (mémoire virtuelle) */
    int taillepage = sysconf(_SC_PAGESIZE); 

    /* affecter le traitant à SIGSEGV et SIGBUS */
    signal(SIGSEGV, handler); 
    signal(SIGBUS, handler);
 
    /* couplage */
    base = mmap(NULL, taillepage, PROT_NONE, MAP_PRIVATE | MAP_ANON, -1, 0); 
    if (base == MAP_FAILED) {
        printf("mmap failed\n");
        exit(EXIT_FAILURE);
    }

    /* tests */
    printf("début, base = %d\n", base); 
    /* accès en écriture de cette zone */
    base[0] = 'c'; /* ça va lever un signal */
    printf("essai2 %c\n", base[0]); 
    base[0] = 'd'; /* ok car dans le traitant du signal précédent, l'accès en écriture a été ajouté */
    printf("fin\n"); 
    return(0); 
}
    
    

