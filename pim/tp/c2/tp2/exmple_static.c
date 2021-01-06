#include "exmple_static.h"

// fct locale au module 
// Invisible pour les autres modules
static int max(int a, int b) {
    if (a > b) {
	return a;
    } else {
	return b;
    }
 }
// fonction f() présente dans le .h
// visible par les autres modules 
int f() {
    int val1 = 2;
    int val2 = 5;
    return max(val1, val2);
    }
