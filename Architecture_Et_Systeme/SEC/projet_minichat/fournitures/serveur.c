/* version 0.2 (PM, 13/5/19) :
	Le serveur de conversation
	- crée un tube (fifo) d'écoute (avec un nom fixe : ./ecoute)
	- gère un maximum de maxParticipants conversations : select
		* tube d'écoute : accepter le(s) nouveau(x) participant(s) si possible
			-> initialiser et ouvrir les tubes de service (entrée/sortie) fournis
		* tubes (fifo) de service en entrée -> diffuser sur les tubes de service en sortie
	- détecte les déconnexions lors du select
	- se termine à la connexion d'un client de pseudo "fin"
	Protocole
	- suppose que les clients ont créé les tube d'entrée/sortie avant
		la demande de connexion, nommés par le nom du client, suffixés par _C2S/_S2C.
	- les échanges par les tubes se font par blocs de taille fixe, dans l'idée d'éviter
	  le mode non bloquant
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

#include <stdbool.h>
#include <sys/stat.h>

#define MAXPARTICIPANTS 5			/* seuil au delà duquel la prise en compte de nouvelles
								 						 	   connexions sera différée */
#define TAILLE_MSG 128				/* nb caractères message complet (nom+texte) */
#define TAILLE_NOM 25					/* nombre de caractères d'un pseudo */
#define NBDESC FD_SETSIZE-1		/* pour le select (macros non definies si >= FD_SETSIZE) */
#define TAILLE_RECEPTION 512	/* capacité du tampon de messages reçus */

typedef struct ptp { 					/* descripteur de participant */
    bool actif;
    char nom [TAILLE_NOM];
    int in;		/* tube d'entrée */
    int out;	/* tube de sortie (S2C) */
} participant;


participant participants [MAXPARTICIPANTS];

char buf[TAILLE_RECEPTION]; 	/* tampon de messages reçus/à rediffuser */
int nbactifs = 0;

void effacer(int i) { /* efface le descripteur pour le participant i */
    participants[i].actif = false;
    bzero(participants[i].nom, TAILLE_NOM*sizeof(char));
    participants[i].in = -1;
    participants[i].out = -1;
}

void diffuser(char *dep) { /* envoi du message référencé par dep à tous les actifs */
/* à faire */
    for (int j = 0; j < MAXPARTICIPANTS; j++) {
        if (participants[j].actif) { // Si le participant est actif
            /* Envoi du message dep reçu dans tous les pipes de sortie (s2c) */
            write(participants[j].out, dep, TAILLE_MSG); 
        }
    }
}

void desactiver (int p) {
/* traitement d'un participant déconnecté (à faire) */ 
    /* Effacer le descripteur pour le participant p */
    effacer(p);
    /* Fermer les descripteurs du participant p */
    close(participants[p].in); 
    close(participants[p].out); 
    nbactifs--;     
}

void ajouter(char *dep) { // traite la demande de connexion du pseudo référencé par dep
/*  Si le participant est "fin", termine le serveur (et gère la terminaison proprement)
	Sinon, ajoute le participant de pseudo référencé par dep
	(à faire)
*/
    if ((strcmp(dep, "fin")) == 0) {
        /* Gérer la terminaison du serveur */
        /* Désactiver tous les participants actifs */
        for (int p = 0; p < MAXPARTICIPANTS; p++) {
            desactiver(p); 
        }
        /* Détruire le tube d'écoute */
        unlink("ecoute"); 
        /* Quitter */
        exit(0); 
    } else {
        /* Ajouter le participant de pseudo référencé par dep */
       // if (nbactifs < MAXPARTICIPANTS) {
            /* Recherche du plus petit descripteur disponible */
            int i = 0; 
            while (participants[i].actif) {
                i++;
            }
        
            nbactifs++; 
            /* Ouvrir les descripteurs du nouveau participant */
            char fc2s[TAILLE_NOM+5];
            char fs2c[TAILLE_NOM+5]; 
            sprintf(fc2s, "%s_C2S", dep); 
            sprintf(fs2c, "%s_S2C", dep); 
            participants[i].in = open(fc2s, O_RDONLY); 
            participants[i].out = open(fs2c, O_WRONLY); 
            /* Le mettre  à actif */
            participants[i].actif = true; 
            /* Mettre son pseudo en place */
            strcpy(participants[i].nom, dep);
           
        //}
    }
}

int main (int argc, char *argv[]) {
    int i,nlus,necrits,res;
    int ecoute;					/* descripteur d'écoute */
    fd_set readfds; 		/* ensemble de descripteurs écoutés par le select */
    char * buf0; 				/* pour parcourir le contenu du tampon de réception */
	char bufDemandes [TAILLE_NOM*sizeof(char)*MAXPARTICIPANTS]; 
	/* tampon requêtes de connexion. Inutile de lire plus de MAXPARTICIPANTS requêtes */
    char bufFin[TAILLE_MSG]; /* pour le message au revoir */

    /* création (puis ouverture) du tube d'écoute */
    mkfifo("./ecoute",S_IRUSR|S_IWUSR); // mmnémoniques sys/stat.h: S_IRUSR|S_IWUSR = 0600
    ecoute=open("./ecoute",O_RDONLY);

    /* Nouvelle session */
    for (i=0; i<= MAXPARTICIPANTS; i++) {
        effacer(i);
    }

		
    while (true) {
        printf("participants actifs : %d\n", nbactifs);
        /* Ajouter de nouveaux participants */
        FD_ZERO(&readfds);
        FD_SET(ecoute, &readfds); 

        /* Ajouter les descripteurs */
        for (i = 0; i < MAXPARTICIPANTS; i++) {
            if (participants[i].actif) {
                FD_SET(participants[i].in, &readfds); 
            }
        }

        /* Déterminer les descripteurs prêts à écouter */
        res = select(NBDESC, &readfds, NULL, NULL, NULL);

        /* Evaluer les demandes de connexion */
        if (FD_ISSET(ecoute, &readfds)) {
                    nlus = read(ecoute, bufDemandes, TAILLE_NOM); 
                    if (nbactifs < MAXPARTICIPANTS) {
                        ajouter(bufDemandes); 
                    }    
         }

        

        

        /* Lire les messages sur les tubes c2s */
        
            //FD_SET(participants[i].in, &readfds); 
            //FD_SET(0, &readfds); 
          
        if (res > 0) {
                for (i = 0; i < MAXPARTICIPANTS; i++) {
                    if (FD_ISSET(participants[i].in, &readfds)) {
                    nlus = read(participants[i].in, buf, TAILLE_MSG);

                    if (nlus != 0) {
                        buf[nlus-1]= '\0'; 
                        snprintf(bufFin, TAILLE_MSG, "[%s] au revoir", participants[i].nom);
                        if (strcmp(buf, bufFin) == 0) {
                            desactiver(i);
                        } else {
                            /* Diffuser le message envoyé*/
                            diffuser(buf); 
                        }
                   }
                }
            }
        }
        
        /* Tous les messages à diffuser sont dans buf */
        /* Les diffuser */
        /* while (sizeof(buf) != 0) {
            read(buf, buf0, TAILLE_MSG); 
            diffuser(buf0); 
        } */
        
                    
                

		/* boucle du serveur : traiter les requêtes en attente 
				 * sur le tube d'écoute : lorsqu'il y a moins de MAXPARTICIPANTS actifs.
				 	ajouter de nouveaux participants et les tubes d'entrée.			  
				 * sur les tubes de service : lire les messages sur les tubes c2s, et les diffuser.
				   Note : tous les messages comportent TAILLE_MSG caractères, et les constantes
           sont fixées pour qu'il n'y ait pas de message tronqué, ce qui serait  pénible 
           à gérer. Enfin, on ne traite pas plus de TAILLE_RECEPTION/TAILLE_MSG*sizeof(char)
           à chaque fois.
           - dans le cas où la terminaison d'un participant est détectée, gérer sa déconnexion
			
			(à faire)
		*/
    }
}
