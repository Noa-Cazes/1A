/**
 * module datem
 */

// Biblio nécéssaires à l'interface ET au corps
#include <time.h>

// Déclaration des types
enum NomJour {DIMANCHE, LUNDI, MARDI, MERCREDI, JEUDI, VENDREDI, SAMEDI};
enum Mois {JAN, FEV, MAR, AVR, MAI, JUIN, JUIL, AOUT, SEPT, OCT, NOV, DEC};

typedef enum NomJour NomJour;
typedef enum Mois Mois;

struct Date {
    int jour;
    NomJour nomJour;
    Mois Mois;
    int annee;
    // Invariant : jour >= 1 && jour <= 31; annee > 0 
};
typedef struct Date Date;

// Déclaration des fonctions et procédures

// Initilaise une date
void initialiser(Date* date);

// Retourne la date d'ajd
Date date_aujourd_hui();

// Afficher la date
void afficher_date(Date d);

// Convertir la date au format time_t de time.h en une date de type Date
void convertir_vers_date(time_t t, Date* date);

