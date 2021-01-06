// Introduction
#include <stdlib.h>
#include <stdio.h>
int main1() {
    printf("***************\n");
    printf("** Langage C **\n");
    printf("***************\n");
    return EXIT_SUCCESS;
}

// Un premier programme en Langage C
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

int main2() {
    int a = 105, b= 35;
    int na = a, nb = b;
    while (na != nb) {
	if (na > nb) {
	    na = na - nb;
	}
	else {
	    nb = nb - na;
	}
     }
    int pgcd = na;
    printf("Le pgcd de %d et de %d est %d\n", a, b, pgcd);
    return EXIT_SUCCESS;
}

// Exercice 2
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#define NDEBUG

void assert_ok () {
    int n = 10;
    assert (n>0);
    printf("(assert_ok) n = %d\n", n);
}

void assert_erreur () {
    int n = 10;
    assert (n<10);
    printf("(assert_erreur) n = %d\n", n);
}

int main3(void) {
    assert_ok();
    assert_erreur();
    return EXIT_SUCCESS;
}


// Exercice 3
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <float.h>

int main4() {
    printf("Valeur maximale d'un entier %d\n", INT_MAX);
    long int entier_long = -20000000000;
    printf("Valeur maximale d'un entier long %ld > %ld\n\n",LONG_MAX, entier_long);

    unsigned long int entier_non_signe = entier_long; 
    printf("L'entier non signé est %ld\n", entier_non_signe);
    printf("L'entier non signé est %f\n", entier_non_signe);
    printf("L'entier non signé est %lu\n", entier_non_signe);
    printf("Valeur maximale d'un entier non signé %u\n", UINT_MAX);
    printf("Valeur maximale d'un entier non signé long %lu > %lu\n\n", ULONG_MAX, entier_non_signe); 

    float flottant_simple = 20.13;
    double flottant_double;
    long double long_double = 200019199.2;
    printf("Valeur maximale d'un réel simple : \n%f \n < valeur maximale d'un long : \n%lf \n < valeur maximale d'un long double : \n%Lf", FLT_MAX, DBL_MAX, LDBL_MAX);
}

// Exercice 4
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

int main5() {
    char c_char = '1';
    int c_int = c_char - '0';
    assert(c_int == 1);

    int new_int = 1;
    char new_char = new_int + '0';
    assert (new_char == '1');

    printf("%s", "Tous les tests passent.\n");
    return EXIT_SUCCESS;
}

// Exercice 4
#define XXX -1
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

int main6(void) {
    assert(5 == 5 - 2 * 5);
    assert(5 == 25 % 10);
    assert(2 == 25 / 10);
    assert(2.5 == 25 / 10.0);


    assert(5 == '5' - '0');
    assert('7' == '0' + 7);
    assert('D' = 'A' + 3);

    printf("%s", "Tous les tests passent.\n");
    return EXIT_SUCCESS; 
}

// Exercice 5
#define XXX -1
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

int main7(void) {
    int x = 10;
   // int y = 12;
    assert (10 == x);

    {
	int y = 7;
	assert (10 == x);
	assert (7 == y);

    {
	char x = '?';
	assert ('?' == x);
	assert (7 == y);
	y = 12;

    }
    assert(10 == x);
    assert(12 == y);
    }
    assert(10 == x);

    printf("%s", "Tous les tests passent.\n");
    return EXIT_SUCCESS;
}


// Exercice 6
#include <stdlib.h>
#include <stdio.h>
#define rayon 15
#define  pi 3.14

int main8(){
    float  perimetre, aire;
    aire = pi * (rayon) * (rayon);
    perimetre  = 2 * pi * rayon;

    printf("Le périmètre d'un cercle de rayon 15 cm est de %f cm.\nL'aire d'un cercle de rayon 15 cm est de %f cm2.\n", perimetre, aire);

    return EXIT_SUCCESS;
}


// Exercice 7
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

int chiffre_unites(int nombre)
{
    assert(nombre >= 0);
    return (nombre % 10);
}

int chiffre_dizaines (int nombre)
{
    assert(nombre >= 0);
    return (chiffre_unites(nombre/10));
 }

bool est_bissextile(int annee)
{
    assert(annee >= 0);
    return (((annee % 4 == 0) && (annee % 100 != 0))|| annee % 400 == 0);

}

void test_chiffre_unite(void)
{
    assert(5 == chiffre_unites(1515));
    assert(2 == chiffre_unites(142));
    assert(0 == chiffre_unites(0));
    printf("%s","Tous les tests passent.\n");
}

void test_chiffre_dizaine(void)
{
    assert(1 == chiffre_dizaines(1515));
    assert(2 == chiffre_dizaines(142));
    assert(9 == chiffre_dizaines(91));
    assert(8 == chiffre_dizaines(80));
    assert(0 == chiffre_dizaines(7));
    assert(0 == chiffre_dizaines(0));
    printf("%s","Tous les tests passent.\n");
}

void test_annee_bissextile(void)
{
    assert( ! est_bissextile(2019));
    assert(est_bissextile(2020));
    assert(est_bissextile(2016));

    assert(! est_bissextile(1900));
    assert(! est_bissextile(2100));


    assert(est_bissextile(1600));
    assert(est_bissextile(2000));
    assert(est_bissextile(2400));

    printf("%s", "tous les tests passent.\n");
}

int main9(void) 
{
    test_chiffre_unite();
    test_chiffre_dizaine();
    test_annee_bissextile();
    printf("%s","Tout est bon mon kiki!\n");
    return EXIT_SUCCESS;
}


// Exercice 8
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

char signe(int nombre)
{
    char chara;
    if (nombre > 0) {
	chara = '>';
    } else if (nombre < 0) {
	chara = '<';
    } else {
	chara = '=';
    }
}
void test_signe() {
    assert('<' == signe(-821));
    assert('<' == signe(-1));
    assert('=' == signe(0));
    assert('>' == signe(125));
    assert('>' == signe(1));
    printf("%s", "signe... ok\n");
}

int main10(void) {
    test_signe();
    printf("%s","Tout est méga cool mon kiki!\n");
    return EXIT_SUCCESS;
}


// Exercice 9
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#define XXX -1

int f(int n) {
    int r = 0;

    switch (n) {
    case 1:
	r +=1;
	break;
    case 2:
    case 3:
	r +=8;
    case 4:
    case 5:
    case 7:
	r+=10;
    case 10:
    case 11:
        r += 5;
        break;
    case 12:
        r += 50;
        break;
    case 13:
        r += 100;
    default:
	r-=1;
    }

    return r;
}

void test_f(void)
{
    assert(16  == f(3)); 
    assert(-1 == f(-5));
    assert(-1 == f(0));
    assert(62 == f(12));
    assert(113 == f(13));
    assert(25 == f(2));
    assert(15 == f(10));
    assert(20 == f(5));
}

int main11(void) {
    test_f();
    printf("%s", "Bravo !  Pas d'erreur détectée.\n");
    return EXIT_SUCCESS;
}

// Exercice 10
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

// Exemples
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <assert.h>

int alea_borne (min, max) {
    int alea;
    assert(min >= 0);
    assert(max <= RAND_MAX);
    srand(time(NULL));
    do {
	alea = rand();
    }
    while (alea < min || alea > max);
    return alea;
 }

int main12(void) {
    int alea;
    alea = alea_borne(0,25);
    assert (alea >= 0 && alea <= 25);
    printf("La valeur aléatoire est %d.\n", alea);
    return EXIT_SUCCESS;
 }

#define LIMITE 300
int main13(void) {
    int prec = 1, un = 2;
    int nouveau, rang = 2;

    while (un < LIMITE) {
	nouveau = un + prec;
	prec = un;
	un = nouveau;
	rang ++;
    }
    printf("La valeur de la suite de fibonacci >= %d est %d.\nElle est de rang %d.\n", LIMITE, un, rang);
    return EXIT_SUCCESS;
}

#define LIM 30

int main14(void) {
    int somme = 0;
    for (int i = 1; i <= LIM; i++) {
	somme +=i;
    }
    float moyenne = somme / (float) LIM;
    printf("La moyenne des %d premiers entiers est %d.\n", LIM, somme);
    return EXIT_SUCCESS;
}


// Exercice 11
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>

int sommes_cubes_inferieurs_a (int limite) 
{
    assert(limite >= 0);

    int somme = 0, nb = 0;

    while (nb*nb*nb < limite) {
	nb ++;
	somme += nb*nb*nb;
    }

    return somme;
}

void test_sommes_cubes_inferieurs_a (void) 
{
    assert(1 == sommes_cubes_inferieurs_a(5));
    assert(1 == sommes_cubes_inferieurs_a(1));
    assert(1 == sommes_cubes_inferieurs_a(7));
    assert(9 == sommes_cubes_inferieurs_a(8));
    assert(9 == sommes_cubes_inferieurs_a(26));
    assert(36 == sommes_cubes_inferieurs_a(27));
    assert(36 == sommes_cubes_inferieurs_a(63));
    assert(100 == sommes_cubes_inferieurs_a(64));
    assert(100 == sommes_cubes_inferieurs_a(124));
    assert(225 == sommes_cubes_inferieurs_a(125));
    printf("%s", "sommes_cubes_inferieurs_a... ok\n");
}

int main15(void) {
    test_sommes_cubes_inferieurs_a();
    printf("%s", "Tout est beau dans la vie.\n");
    return EXIT_SUCCESS;
}


// Exercice 12
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

int frequence (int nombre, int chiffre)
{
    assert (chiffre >= 0);
    assert (chiffre <= 9);
    
    int cpt = 0, cptnb = 0;

    do {
	if (nombre % 10 == chiffre) {
	cpt ++;
	nombre = nombre / 10;
	}
	cptnb ++;
    }
    while (nombre != 0);
    return (cpt/cptnb);
}

void test_frequence(void) {
    assert(2 == frequence(1515, 5));
    assert(1 == frequence(123, 3));
    assert(0 == frequence(421, 0));
    assert(3 == frequence(444, 4));
    assert(1 == frequence(0, 0));
    printf("%s", "frequence... ok\n");
}


int main16(void) {
    test_frequence();
    printf("%s", "Bravo ! Tous les tests passent.\n");
    return EXIT_SUCCESS;
    
}

// Exercice 13
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

int sommes_cubes (int max) 
{
    int somme = 0;

    for (int i = 0; i <= max; i++) {
	somme += i*i*i;
    }

    return somme;
}

void test_sommes_cubes(void) {
       assert(1 == sommes_cubes(1));
    assert(9 == sommes_cubes(2));
    assert(36 == sommes_cubes(3));
    assert(100 == sommes_cubes(4));
    assert(225 == sommes_cubes(5));
    assert(0 == sommes_cubes(0));
    printf("%s", "sommes_cubes... ok\n");
}

int main17(void) {
    test_sommes_cubes();
    printf("%s", "La vie est amazing!\n");
    return EXIT_SUCCESS;
}

// Exemple

#include <stdlib.h>
#include <stdio.h>

// definition du type entier
typedef unsigned int entier;

int main18(void){
    entier h = 10, b = 20;
    float aire =  b * h/(float)2;
    printf("Aire = %f \n",aire);

    return EXIT_SUCCESS;
}

// Exercice 14
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <assert.h>

struct Point {
    int x;
    int y;
};

typedef struct Point Point;

//int main19() {
//    Point ptA;
//    Point ptB;
//    ptA.x = 0;
//    ptA.y = 0;
//    ptB.x = 10;
//    ptB.y = 10;
    
//    float distance = 0;
//    distance = sqrtf((ptA.x - ptB.x)*(ptA.x - ptB.x) + (ptA.y - ptB.y)*(ptA.y - ptB.y));

//    assert(distance == sqrt(200));
//    return EXIT_SUCCESS;
//}


// Exercice 15
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#define CAPACITE 20

typedef float t_tableau[20];

void initialiser(t_tableau tab, int taille)
{
    assert (taille <= taille);
    for (int i = 0; i <= CAPACITE; i++) {
	tab[i] = 0.0;
    }
}

bool est_vide (t_tableau tab, int taille) 
{
    assert (taille <= CAPACITE);
    bool vide = false;
    int cpt = 0;
    for (int i = 0; i <= CAPACITE; i++) {
	if (tab[i] == 0.0) {
	    cpt ++;
	}
    }
    if (cpt == taille) {
	vide = true;
    }
    return vide;
}

int main20(void) {
    t_tableau T;
    initialiser(T,10);
    assert(est_vide(T,10));
    printf("%s", " Ils ont pénétré dans le foy'... et à plusieurs.\n");
    return EXIT_SUCCESS;
}

// Exemple
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main21(void) {
    char mon_nom[] = "petit péroquet";
    printf("La longeur du '%s' est de %lu.\n", mon_nom, strlen(mon_nom));
    printf("Taille du tableau : %lu éléments.\n", sizeof(mon_nom));
    printf("Le dernier élément de mon nom est : '%i'.\n", mon_nom[sizeof(mon_nom)-1]);
    return EXIT_SUCCESS;
}

// Exercice 16
#include <stdlib.h>
#include <stdio.h>

int main22() {
    int d1 = 1;
    int d2 = 4;
    int* p_1;
    int* p_2;
    printf("*p_1 = %d, *p_2 = %d \n", *p_1, *p_2);
    printf("p_1 = %p, p_2 = %p.\n", p_1, p_2);
    return EXIT_SUCCESS;
}

int main23() {
    int d1 = 1;
    int d2 = 4;
    int* p_1 = &d1;
    int* p_2 = &d2;
    printf("*p_1 = %d, *p_2 = %d \n", *p_1, *p_2);
    return EXIT_SUCCESS;
}

int main24() {
    int d1 = 1;
    int d2 = 4;
    int* p_1;
    int* p_2;
    printf("Avant échange : *p_1 = %d, *p_2 = %d.\n", *p_1, *p_2);

    int* p;
    p = p_1;
    p_1 = p_2;
    p_2 = p;

    printf("Après échange : *p_1 = %d, *p_2 = %d.\n", *p_1, *p_2);

    return EXIT_SUCCESS;
}


// Exercice 17
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#define CAPACITE 20

typedef float t_tableau[20];

void initialiser2(t_tableau tab, int taille) {
    assert(taille <= CAPACITE);
    for (int i=0; i <= taille - 1; i++) {
	*(tab+i) = 0.0;
    }
}

int main25(void) {
    t_tableau T;
    initialiser2(T,10);
    return EXIT_SUCCESS;
}



// Exercice 18
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

struct t_note {
    float valeur;
    float coef;
};

typedef struct t_note t_note;

typedef t_note t_tab_notes[5];

void initialiser_note (t_note note, float valeur, float coef) {
    assert (valeur <= 20 && valeur >= 0);
    assert (coef <= 1 && coef >= 0);
    note.valeur = valeur;
    note.coef = coef;
}

float moyenne(t_tab_notes tab_notes, int nb_notes) {
    assert (nb_notes <= 5);

    float moyenne = 0;
    for (int i = 0; i <= nb_notes; i++) {
	moyenne += (*(tab_notes + i)).valeur * (*(tab_notes + i)).coef;
    }
    return (moyenne);
}


int main26(void) {
    t_tab_notes notes;

    initialiser_note(notes[0], 10, 0.2);
    initialiser_note(notes[1], 1, 0.3);
    initialiser_note(notes[2], 12, 0.5);

    float moy = moyenne(notes, 3);

    assert(moy == 10*0.2 + 1*0.3 + 12*0.5);

    return EXIT_SUCCESS;
}

// Exercice 19
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int main(int argc, char* argv[]){
    if (argc<2){
        exit(1);
    }
    printf("%s", "*******************************");
    for (int i = 0; i <= strlen(argv[1]) - 1; i++) {
        printf("*");
    }
    printf("\n**** Bienvenue au DU ioT %s *****\n", argv[1]);
    printf("%s","*******************************");
    for (int i = 0; i < strlen(argv[1]); i++) {
        printf("*");
        
    }
    printf("\n");
    
    return EXIT_SUCCESS;
}
