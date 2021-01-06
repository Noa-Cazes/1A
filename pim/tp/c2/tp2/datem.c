/**
 * Module Datem
 */

#include "date.h"

#include <stdio.h>
#include <math.h>

void intialiser(Date *date) {
    date->jour = 1;
    date->nomJour = JEUDI;
    date->mois = JAN;
    date->annee = 1970;
}

void convertir_vers_date(time_t t, Date* date) {
    struct tm now;
    localtime_r(&t, &now); // conversion time sur le fuseau horaire
    date->jour = now.tm_mday;
    date->nomJour = now.tm_wday;
    date->mois = now.tm_mon;
    date->annee = now.tm_year + 1900;
}

Date date_aujourd_hui() {
    time_t t = time(0);
    Date auj;
    convertir_vers_date(t, &auj);
    return auj;
}

static void afficher_date(Date d) {
    printf("Date %i/%i/%i \n", d.jour, (d.mois+1), d.annee);
 }
