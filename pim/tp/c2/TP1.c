// Exemple 1
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

void exemple_dynamique() {
    // allouer dynamiquement un entier
    unsigned int taille = sizeof(int);
    int* ptr_int = malloc(taille);
    assert(ptr_int != NULL); // l'allocation a bien eu lieue ou non

    // Initialiser la donnée à travers le pointeur
    *ptr_int = 10;
    printf("La donnée enregistrée est: %d\n", *ptr_int);

    //Libérer la mémoire
    free(ptr_int);
    //Oublier l'adresse mémoire
    ptr_int = NULL;
}

int main1() {
    exemple_dynamique();
 
    return EXIT_SUCCESS;
}

// Exemple 2
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int main() {
    int taille_entier = sizeof(int);
    printf("Taille d'un entier: %d\n", taille_entier);
    int taille_pointeur = sizeof(int*);
    printf("Taille d'un pointeur sur un entier: %d\n", taille_pointeur);

    // Allouer un tableau de 10 entiers
    int* ptr_tableau = malloc(10*taille_entier);
    int taille_dynamique = sizeof(ptr_tableau);
    assert(taille_dynamique == taille_pointeur);

    // Déclarer un tableau statique de 10 entiers
    int mon_tab[10];
    int taille_statique = sizeof(mon_tab);
    assert(taille_statique == 10*taille_entier);

    printf("%s", "Bravo! Tous les tests passent. \n");
    return EXIT_SUCCESS;
}

