#include "compteurm.h"
#include <stdio.h>

// déclaration de la variable globale + initialisation à 0
int compteur = 0;

void re_initialiser() {
    compteur = 0;
}

void incrementer() {
    compteur++;
}

int valeur() {
    return compteur;
}
