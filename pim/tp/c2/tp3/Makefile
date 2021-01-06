CC=c99
CFLAGS=-Wextra -pedantic -c
LDFLAGS=


all: ephemeride EDT

ephemeride: date.o ephemeride.o
	$(CC) $^ -o $@
ephemeride.o: ephemeride.c 
	$(CC) $(CFLAGS) $<
EDT: date.o salle.o enseignant.o cours.o EDT.o
	$(CC) $^ -o $@
depend: 
	makedepend *.c -Y.
clean:
	rm *.o ephemeride EDT 
.PHONY: clean all
# DO NOT DELETE

EDT.o: cours.h salle.h date.h enseignant.h
cours.o: cours.h salle.h date.h enseignant.h
date.o: date.h
enseignant.o: enseignant.h date.h
ephemeride.o: date.h
salle.o: salle.h date.h
