#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h> /* définit mmap  */
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
 int fin, fout, taille;
 char *src, *dst;
 char qq [1];
 struct stat statbuf;

 if (argc != 3) {
   printf("usage: %s <fichier source> <fichier destination>\n", argv[0]);
   exit(1);
}
 /* ouvrir et coupler source */
 if ((fin = open (argv[1], O_RDONLY)) == -1) {
   printf("erreur ouverture source\n");
   exit(2);
}
 /* recuperer la taille de la source */
 if (fstat (fin,&statbuf) < 0){
   printf("erreur fstat");
   exit(3);
}
 taille = statbuf.st_size;
 if ((src = mmap (NULL, taille, PROT_READ, MAP_PRIVATE, fin, 0)) == (caddr_t) -1) {
   printf("erreur couplage source\n");
   exit(4);
}

 /* ouvrir et coupler destination */
 if ((fout = open (argv[2], O_RDWR | O_CREAT | O_TRUNC, 0644)) == -1) {
 /* O_RDWR (plutôt que O_WRONLY) necessaire car mmap impose qu'un fichier couplé
 	 soit toujours (au moins) ouvert en lecture
 */
   printf("erreur ouverture destination\n");
   exit(5);
}

 /*	mmap ne spécifie pas quel est le resultat d'une ecriture *apres* la fin d'un fichier
	couple (SIGBUS est une possibilite, frequente). Il faut donc fixer la taille du fichier
	destination à la taille du fichier source avant le couplage. Le plus simple serait
	d'utiliser truncate, mais ici on prefere lseek(a la taille du fichier source) + write
	d'un octet, qui sont deja connus des etudiants */
	qq[0]='x';
 	lseek (fout, taille - 1, SEEK_SET);
 	write (fout,qq, 1);
 	
 if ((dst = mmap (NULL, statbuf.st_size, PROT_WRITE, MAP_SHARED, fout, 0)) == (caddr_t) -1) {
 /* MAP_SHARED est necessaire pour que les ecritures soient visibles dans le fichier */
   printf("erreur couplage destination\n");
   exit(6);
}

 /* la copie est le plus facile :) */
 memcpy (dst, src, statbuf.st_size);
 close(fin);
 close(fout);
 exit(0);
}