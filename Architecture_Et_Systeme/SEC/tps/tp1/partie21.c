# include <stdio.h> /* printf */
# include <unistd.h> /* fork */
# include <stdlib.h> /* EXIT_SUCCESS */

int main () {
    fork (); printf ("fork 1\n");
    fork (); printf ("fork 2\n");
    fork (); printf ("fork 3\n");
    return EXIT_SUCCESS ;
}
