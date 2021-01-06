#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

#define TAILLE 10
#define INC 1e14

int main() {

    // Allouer un tableau de TAILLE entiers initialisés à 1
    int* tab = malloc(TAILLE*sizeof(int));
    assert(tab != NULL);
    for (int i = 0; i < TAILLE; i++) {
	tab[i] = 1;
   }

    // Augmenter la taille du tableau pour enregistrer TAILLE + INC entiers
    int* new = realloc(tab, (TAILLE + INC)*sizeof(int));
    if (new) {
	tab = new;
    }
    assert(tab[0]==1);
    printf("Good coco");
    return EXIT_SUCCESS;
}
