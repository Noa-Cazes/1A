#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/types.h>

char* base;
size_t taillepage;

/* handler pour les signaux SIGSEGV et SIGBUS */
void traitant (int sig) {
	int ret = mprotect(base,taillepage,PROT_WRITE|PROT_READ);
	/* a) pourquoi faut il PROT_READ ?
		-> a priori parce que sur certaines architectures (RISC) l'écriture est précédée 
		d'une lecture, pour installer les données écrites dans le cache, et en permettre 
		la gestion selon la politique du cache (LRU...) sans faire de cas particulier 
		pour l'écriture.
		A noter que sur d'autres architectures (i386), mprotect/la protection mémoire 
		positionne automatiquement PROT_READ, dès lors que l'on positionne PROT_WRITE
	   b) reprise après traitement de SIGSEGV. Non défini : selon les architectures,
	   	l'instruction ayant provoqué le SIGSEGV est reprise ou sautée. Si elle est reprise,
	   	et que PROT_READ n'est pas positionné, on boucle à l'infini.
	*/
	printf("signal : %d, résultat mprotect : %d\n", sig,ret);
}

int main(int argc, char *argv[]) {
	int i,ret;
	taillepage = sysconf(_SC_PAGESIZE);
	signal(SIGSEGV,traitant);
	signal(SIGBUS,traitant);
	base = mmap(NULL, taillepage, PROT_NONE, MAP_PRIVATE|MAP_ANON, -1, 0);
	if (base==MAP_FAILED) {
		printf("map failed \n");
		exit(1);
	}
	printf("début, base = %d\n",base);
	base[0] = 'c';
	printf("essai2 %c\n",base[0]);
	base[0] = 'd';
	printf("fin\n");
	return(0);
}