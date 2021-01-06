#include "compteurm.h"
#include <stdio.h>

// accès au compteur du module compteur
extern int compteur;

int main() {
    // ini
    re_initialiser();
    printf("Ini de c = %d\n", valeur());
    // incrémenter
    incrementer();
    printf("Incrémentation de c = %d\n", valeur());
    // accès au compteur sans appel à valeur()
    incrementer();
    incrementer();
    printf("Acces direct au compteur c = %d\n", compteur);

    return 0;
}

