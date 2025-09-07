#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

/* Use c11 throughout to keep it consistent.
 * Use this compilation command to do a generic compile with no optimizations. 
 * gcc -O0 -std=c11 -o saxpy_scalar saxpy_scalar.c

 * Use this compilation command to ensure true scalar baseline.
 * gcc -O3 -fno-tree-vectorize -march=native -std=c11 -o saxpy_scalar_only saxpy_scalar_only.c
 */



/**
 * saxpy_scalar - baseline scalar implementation of SAXPY
 * @a: scalar multiplier
 * @x: input array of floats
 * @y: in/out array of floats (modified in place)
 * @n: number of elements
 *
 * Performs y[i] = a*x[i] + y[i] for i = 0..n-1
 */
void saxpy_scalar(float a, const float *x, float *y, size_t n) {
    for (size_t i = 0; i < n; i++) {
        y[i] = a * x[i] + y[i];
    }
}

int main(int argc, char **argv) {
    // Initialize the size of x and y arrays and set the scalar a value
    size_t n = (argc > 1) ? strtoull(argv[1], NULL, 10) : 10000000; // default 10M
    float a = 2.5f;

    // Allocate memory (aligned to 64 bytes for SIMD friendliness)
    float *x, *y;
    if (posix_memalign((void**)&x, 64, n * sizeof(float)) != 0 ||
        posix_memalign((void**)&y, 64, n * sizeof(float)) != 0) {
        perror("posix_memalign failed");
        return 1;
    }

    // Initialize with random floats in [0,1)
    srand(42);
    for (size_t i = 0; i < n; i++) {
        x[i] = (float)rand() / RAND_MAX;
        y[i] = (float)rand() / RAND_MAX;
    }

    // Warm-up run
    saxpy_scalar(a, x, y, n);

    // Timing run
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    saxpy_scalar(a, x, y, n);

    clock_gettime(CLOCK_MONOTONIC, &end);

    double seconds = (end.tv_sec - start.tv_sec) +
                     (end.tv_nsec - start.tv_nsec) / 1e9;

    // Compute FLOPs: 2 per element (1 mul + 1 add)
    double flops = 2.0 * n;
    double gflops = (flops / seconds) / 1e9;

    // Checksum (avoid compiler optimizing loop away)
    double checksum = 0.0;
    for (size_t i = 0; i < n; i++) {
        checksum += y[i];
    }

    printf("N = %zu | Time = %.6f s | GFLOP/s = %.2f | Checksum = %.5e\n",
           n, seconds, gflops, checksum);

    free(x);
    free(y);
    return 0;
}