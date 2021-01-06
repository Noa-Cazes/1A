#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>

/* Gérer les erreurs dues à l'utilisation des primitives read, write etc */
int gestionErr(int retour, char message[]) {
    if (retour < 0) {
        perror(message);
        exit(1);
    }
}

int main() {
    int desc_fich, desc_fich1, fils, ecrit, lretour, clretour, elt;
    
    char temp[] = "temp.txt";
   
    /* Création d'un processus fils */
    fils = fork();
    
    if (fils < 0) {
	    printf("Erreur avec le fork\n");
	    exit(1);
	}
    else if (fils == 0) {
        /* Ouverture d'un fichier en écriture */
        desc_fich = open(temp, O_WRONLY | O_CREAT | O_TRUNC, 0640);
        /* Traiter les retours d'erreurs des appels */
        gestionErr(desc_fich, "Erreur d'ouverture du fichier temp.txt ");

        /* Ecritre les entiers de 1 à 30 dedans */
        /* En revenant en debut de fichier tous les 10 entiers */
        for (int i = 1; i <= 30; i ++) {
            ecrit = write(desc_fich, &i, sizeof(int));
            gestionErr(ecrit, "Erreur avec la primitive write ");
            if (i == 10 | i == 20) {
                lseek(desc_fich, -10, SEEK_CUR);
                gestionErr(lretour, "Erreur avec la primitive lseek ");
            }
            sleep(1);
        }
         /* Fermer le fichier */
        clretour = close(desc_fich); 
        gestionErr(clretour, "Erreur avec la primitive close ");
        exit(0);

    } else {
        /* Afficher régulièrement le contenu du fichier sur la sortie standard */ 
        /* Ouvrir le fichier en mode lecture */
        desc_fich = open(temp, O_RDONLY| O_CREAT, 0640);
        gestionErr(desc_fich, "Erreur d'ouverture du fichier temp.txt ");

        /* Lire et afficher */
        for (int j  = 1; j <= 3; j++) {
            sleep(10); 
            while(read(desc_fich, &elt, sizeof(int)) > 0) {
                printf("%d\n", elt);
            }
            /* Positionner le curseur au début du fichier */
            lseek(desc_fich, -10, SEEK_CUR);
            gestionErr(lretour, "Erreur avec la primitive lseek ");
        }
        /* Fermer le fichier */
        clretour = close(desc_fich); 
        gestionErr(clretour, "Er1reur avec la primitive close ");
        
    }
  
    
    return(EXIT_SUCCESS);
}

       /* On remarque que ce qui est affiché est bien les entiers de 1 à 30, mais leur écriture s'est superposée, pour finalement n'avoir plus que les entiers de 21 à 30 da,s le fichier*/
        
