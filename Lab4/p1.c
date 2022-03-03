#include <stdio.h>

int proc2(int, int);

//turns the value of a into b - 2, and turns b into the value of a
//stores result of proc2 in buffer
void proc1(char *s, int *a, int *b) {
    int v;
    int t;

    t = *a; //y = the value of a 
    v = proc2(*a, *b); // v = (val of a * val of b) - 12

    sprintf(s, "The result of proc2(%d,%d) is %d.", *a, *b, v);

    *a = *b - 2; //the value of a = the value of b - 2
    *b = t; //the value of b = the original value of a

    return;
}
