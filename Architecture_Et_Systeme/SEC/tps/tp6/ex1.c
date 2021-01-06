#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>

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
    int ind, desc, pid, cr, retour; 
    /* récupérer la taille d'une page (mémoire virtuelle) */
	int taillepage = sysconf(_SC_PAGESIZE);
    /* tampon de la taille de deux pages pour écrire le tampon en mémoire réelle */
    char tampon[2*taillepage];
    /* adresse virtuelle du début du segment mémoire adressable */
    char* base; 
    
    /* créer un fichier contenant deux paes de caractères 'a' */
    /* ouvrir un fichier en mode écriture */
    desc = open("tempo", O_WRONLY | O_CREAT, 0777);
    /* gestion de l'erreur */
    if (desc == -1) {
        perror("open"); 
        exit(EXIT_FAILURE);
    }
    /* remplir le tampon de 'a' */
    garnir(tampon, 2*taillepage, 'a');
    /* l'écrire dans le fichier */
    retour = write(desc, tampon, 2*taillepage);
    if (retour == -1) {
        perror("write");
    } else {
        printf("Ecriture de %d caractères\n", 2*taillepage);
    }
    /* fermer ce fichier */
    close(desc); 

    /* ouvrir ce dernier fichier en lecture/écriture */
    desc = open("tempo", O_RDWR); 
    /* gestion des erreurs */
    if (desc ==  -1) {
        perror("open rdwr");
        exit(EXIT_FAILURE);
    }

    /* coupler un segment de taille 2*taillepage en mode partageable et lecture/écriture */
    base = mmap(NULL, 2*taillepage, PROT_READ | PROT_WRITE, MAP_SHARED, desc, 0); 
    /* gestion des erreurs */
    if (base ==  MAP_FAILED) {
        perror("mmap");
        exit(EXIT_FAILURE);
    }

    /* créer un processus fils */
    pid = fork(); 

    if (pid < 0) { /* erreur */
        perror("fork"); 
        exit(EXIT_FAILURE);
    } else if (pid == 0) { /* fils */
        /* attendre deux secondes */
        sleep(2);
        printf("fils \n");
        /* lister les 10 premier octets de chaque page du segment */
        printf("page 1 : "); 
        lister(base, 10);
        printf("page 2 : ");
        lister(base + taillepage, 10); 
        /* remplir la première page avec le caractère 'c' */
        garnir(base, taillepage, 'c');
        exit(EXIT_SUCCESS);
    } else { /* père */
        /* remplir la deuxième page du segment de carcatères 'b' */
        garnir(base + taillepage, taillepage, 'b');
        /* attendre la fin du fils */
        wait(&cr); 
        /* lister les 10 premiers octets de la première page */
        printf("page 1 père : "); 
        lister(base, 10); 
        /* terminer */
        exit(EXIT_SUCCESS);
    }

     
}
