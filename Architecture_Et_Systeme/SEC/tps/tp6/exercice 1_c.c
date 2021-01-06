#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>

/*
 le père 
 - remplit tempo (2 pages) de a, 
 - puis le couple en mode partagé
 - lance le fils (qui attend 2s)
 - puis remplit la page 2 de b 
 - attend la fin du fils
 - lit la page 1
 le fils
  - attend deux secondes
  - lit les 2 pages
  - puis remplit la page 1 de c 
*/
void garnir(char zone[], int lg, char motif) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		zone[ind] = motif ;
	}
}

void lister(char zone[], int lg) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		printf("%c",zone[ind]);
	}
	printf("\n");
}

int main(int argc,char *argv[]) {
	int ind, desc, pid, cr;
	int taillepage = sysconf(_SC_PAGESIZE);
	char tampon[2*taillepage];
	char* base;
	
	if ((desc=open("tempo",O_WRONLY|O_CREAT,0777))==-1) {
		perror("open");
		exit(EXIT_FAILURE);
	}
	garnir(tampon, 2*taillepage, 'a');
	if ((write(desc,tampon,2*taillepage))==-1)
		perror("write");
	else
		printf("ecriture de %d caractères\n",2*taillepage);
	close(desc);
	if ((desc=open("tempo",O_RDWR))==-1) {
		perror("open rdwr");
		exit(EXIT_FAILURE);
	}
	base = mmap(NULL, 2*taillepage, PROT_READ|PROT_WRITE, MAP_SHARED, desc, 0);
	if ( fork() == 0 )   {  /*  fils*/
		sleep(2) ;
		printf("fils \n");
		printf("page 1 : "); 
		lister(base,10);
		printf("page 2 : ");
		lister(base+taillepage,10);
		garnir(base,taillepage,'c');
		exit(EXIT_SUCCESS);
	}
/* père */
	garnir(base+taillepage,taillepage,'b');
	wait(&cr);
	printf("page 1 père: "); 
	lister(base,10);
	exit(EXIT_SUCCESS);
}
