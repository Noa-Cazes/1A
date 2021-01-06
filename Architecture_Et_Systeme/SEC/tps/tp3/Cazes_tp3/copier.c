#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>    
#include <sys/types.h> /* open */
#include <sys/stat.h>  /* open */

#define BUFFSIZE 4096

/* Gérer les erreurs dues à l'utilisation des primitives read, write etc */
int gestionErr(int retour, char message[]) {
    if (retour < 0) {
        perror(message);
        exit(1);
    }
}

int main(int argc, char **argv) {
    int desc_fich1, desc_fich2, nb_lu, nb_ecrit, cl1, cl2;
    
    char tampon[BUFFSIZE];

    /* Ouvrir en lecture le fichier en premier argument */
    desc_fich1 = open(argv[1], O_RDONLY);
    /* Traiter les retours d'erreurs des appels */
    gestionErr(desc_fich1, "Erreur d'ouverture du fichier1");


    /* Ouvrir en écriture le fichier en deuxième argument */
    desc_fich2 = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0640);
    /* Traiter les retours d'erreurs des appels */
    gestionErr(desc_fich2, "Erreur d'ouverture du fichier2");

    /* Lire et écrire */
    while ((nb_lu = read(desc_fich1, tampon, BUFFSIZE)) > 0) {
        nb_ecrit = write(desc_fich2, tampon, nb_lu);
        gestionErr(nb_ecrit,"Erreur avec la primitive write ");
    }

    /* Fermer les fichiers ouverts */
    cl1 = close(desc_fich1);
    gestionErr(cl1, "Erreur avec la fermeture du fichier 1 ");
    cl2 = close(desc_fich2);
    gestionErr(cl2, "Erreur avec la fermeture du fichier 2 ");
    
    return(EXIT_SUCCESS); 
}
    
 
