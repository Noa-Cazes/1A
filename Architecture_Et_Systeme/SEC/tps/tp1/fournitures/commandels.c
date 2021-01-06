#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
// Exécuter la comande ls -l <nom_fichier>
// Affiche un message pour savoir susi la commande a étté correctement exécutée ou non
int main(int argc, char *argv[])
{
    if (argc > 0) {
	String nom = *argv[1];
	int res = ls -l nom;
    }
    if (res == 0) {
	printf("La commande s'est bien exécutée!");
    } else {
	printf("La commande ne s'est pas bien exécutée");
    }
}
