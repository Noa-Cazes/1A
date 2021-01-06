#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h> /* définit mmap  */
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    int fin, fout, taille; 
    char *src, *dst; 
    char qq[1]; 
    struct stat statbuf; 

    if (argc != 3) {
        printf("usage : %s <fichier source> <fichier destination>\n", argv[0]);
        exit(1); 
    }

    /* ouvrir et coupler le fichier source */
     fin = open(argv[1], O_RDONLY);
    if (fin == -1) {
        printf("erreur ouverture source\n"); 
        exit(2);
    }
    /* récupérer la taile de la source */
    if ((fstat(fin, &statbuf)) < 0) {
        printf("erreur fstat");
        exit(3);
    }
    taille = statbuf.st_size; 
    src = mmap(NULL, taille, PROT_READ, MAP_PRIVATE, fin, 0);
    if (src == (caddr_t) -1) {
        printf("erreur couplage source");
        exit(4);
    } 

    /* ouvrir et coupler destination */
    fout = open(argv[2], O_RDWR | O_CREAT | O_TRUNC, 0644); 
    if (fout == -1) {
        printf("erreur ouverture destination");
        exit(5); 
    }
    
    qq[0] = 'x'; 
    lseek(fout, taille -1, SEEK_SET); /* positionne le curseur à l'endroit taille-1 du fichier */
    write(fout, qq, 1); /* met le x à cette place */

    dst = mmap(NULL, statbuf.st_size, PROT_WRITE, MAP_SHARED, fout, 0); /* MAP_SHARED nécéssaire pour que les écritures soient visibles dans le fichier */
    if (dst == (caddr_t) -1) {
        printf("erreur couplage destination\n");
        exit(6);
    }

    /* fairfe la copie */
    memcpy(dst, src, statbuf.st_size); 
    close(fin); 
    close(fout); 
    exit(0); 
}
    
