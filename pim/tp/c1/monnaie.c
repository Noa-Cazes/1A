#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#define nb_monnaie 5

// Definition du type monnaie
struct t_monnaie{
    float  valeur;
    char devise;
};
typedef struct t_monnaie t_monnaie; 
/**
 * \brief Initialiser une monnaie 
 * \param[out] t_monnaie* monnaie pointeur vers la monnaie à initilaiser
 * \param[in] valeur 
 * \param[in] devise
 * \pre valeur > 0
 */ 
void initialiser(t_monnaie* monnaie, float valeur, char devise) {
    assert(valeur > 0);
    (*monnaie).valeur = valeur;
    (*monnaie).devise = devise;
}


/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param[in] t_monnaie* m1 pointeur vers la monnaie 1
 * \param[in] t_monnaie* m2 pointeur vers la monnaie 2
 * \pre (*m1).devise = (*m2).devise 
 */ 
bool ajouter(t_monnaie* m1, t_monnaie* m2) {
    bool booleen;
    if ((*m1).devise == (*m2).devise){
       initialiser(m2, (*m1).valeur + (*m2).valeur, (*m2).devise);
       booleen = true;
    }
    else {
       booleen = false;
    }	
    return booleen;
}


/**
 * \brief Tester Initialiser 
 */ 
void tester_initialiser() {
    float valeur = 3;
    char devise = 'e';
    t_monnaie* m;
    initialiser(m, valeur, devise);
    assert((*m).valeur == valeur && (*m).devise == devise);
    
}

/**
 * \brief Tester Ajouter 
 */ 
void tester_ajouter() {
   t_monnaie* m1;
   t_monnaie* m2;
   initialiser(m1, 3, 'e');
   initialiser(m2, 4, 'e');
   assert(ajouter(m1, m2) && (*m2).valeur == 7 && (*m2).devise == 'e');

   initialiser(m2, 4, '$');
   assert(ajouter(m1, m2) == false && (*m2).valeur != 7 && (*m2).devise != 'e');
  
}


int main(void) {
    // Déclarer un tableau de 5 monnaies
    typedef t_monnaie t_tab_monnaie[nb_monnaie];
    t_tab_monnaie tab_monnaie;
    //Initialiser les monnaies
    float valeur;
    char devise;
    for (int i = 0; i <= nb_monnaie - 1; i ++) {
	printf("Saisir une valeur et une devise pour la monnaie %i.\n", i);
	scanf("%f %c", &valeur, &devise);
        initialiser((tab_monnaie + i), valeur, devise);
    }
    // Saisir la devise pour laquelle on veut sommer les valeur des monnaies
    printf("Saisir la devise des monnaies que vous voulez ajouter.\n");
    scanf(" %c", &devise);
    // Introduction d'un pointeur sur une monnaie, qui va stocker la somme des valeurs des monnaies
    t_monnaie* m;
    (*m).valeur = 0;
    (*m).devise = devise;
    // Somme des valeurs des monnaies pour la devise choisie
    for (int j = 0; j <= nb_monnaie - 1; j ++) {
	ajouter((tab_monnaie + j), m);
    }
    printf("La somme des monnaies de devise %c est: %f.\n", devise, (*m).valeur);
}
