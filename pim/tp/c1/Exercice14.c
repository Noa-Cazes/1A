#include <stdlib.h> 
#include <stdio.h>
#include <math.h>
#include <assert.h>

// Definition du type Point 
struct Point {
    int x;
    int y;
};

int main(){
    // Déclarer deux variables ptA et ptB de types Point
    struct Point ptA, ptB;
    // Initialiser ptA à (0,0)
    ptA.x = 0;
    ptA.y = 0;
    // Initialiser ptB à (10,10)
    ptB.x = 10;
    ptB.y = 10;
    // Calculer la distance entre ptA et ptB.
    float distance = 0;

    distance = sqrt((ptA.x - ptB.x)*(ptA.x - ptB.x) + (ptA.y - ptB.y)*(ptA.y - ptB.y));
    assert(distance == sqrt(200));
    
    return EXIT_SUCCESS;
}
