#define _POSIX_C_SOURCE 200112L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>


void dot(float *s, const float *x, float *y, size_t n) {
    *s = 0.0f;
    for (size_t i = 0; i < n; i++) {
        *s += x[i] * y[i];
    }
}


int main(int argc, char **argv){
    return 0;
}