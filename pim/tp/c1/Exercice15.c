#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

#define CAPACITE 20
// Definition du type tableau
typedef int t_tableau[20];


/**
 * \brief Initialiser les éléments d'un tableau de réels avec 0.0
 * \param[out] tab tableau à initialiser
 * \param[in] taille nombre d'éléments du tableau
 * \pre taille <= CAPACITE
 */ 
void initialiser(t_tableau tab, int taille){
    assert(taille <= CAPACITE);
    for (int i=0; i<=taille-1;i++){
        tab[i] = 0.0;
    }
}

/**
 * \brief le tableau est-il vide ?
 * \param[in out] tab tableau à tester
 * \param[in] taille nombre d'éléments du tableau
 * \pre taille <= CAPACITE
 */ 
bool est_vide(t_tableau tab, int taille){
    assert(taille <= CAPACITE);
    bool vide = false;
    int cpt = 0;
    for(int i = 0; i <= taille-1; i++){
        if (tab[i]==0.0) {
            cpt = cpt + 1;
        }
        else {
            cpt = cpt + 0;
        }
    }
    if (cpt == taille) {
        vide = true;
    }
    else {
        vide = false; 
    }
    return vide;
}

int main(void){
    t_tableau T;
    //Initialiser les éléments d'une variable tableau à 0.0
    initialiser(T,CAPACITE);
    //Vérifier avec assert que tous les éléments vallent bien 0.0
    assert(est_vide(T,CAPACITE));
    
}
