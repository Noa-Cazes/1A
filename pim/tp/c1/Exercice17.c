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
    for (int i = 0; i <= taille-1; i++) {
        *(tab + i) = 0.0;
        
    }
}

int main(void){
    t_tableau T;
    //Initialiser les éléments d'une variable tableau à 0.0
    initialiser(T,15);
    
    return EXIT_SUCCESS;
}
