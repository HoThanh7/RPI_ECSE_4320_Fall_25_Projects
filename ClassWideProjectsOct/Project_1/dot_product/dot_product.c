#define _POSIX_C_SOURCE 200112L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

/**
 * gcc -O0 -fno-tree-vectorize -std=c11 -S dot_product.c -o dot.s
 * gcc -O0 -fno-tree-vectorize -std=c11 dot_product.c -o dot
 * gcc -O0 -std=c11 -fopt-info-vec-optimized saxpy.c > scalar_vec_report.txt

 * gcc -O3 -march=native -ffast-math -funroll-loops -std=c11 -S dot_product.c -o simd_dot.s
 * gcc -O3 -march=native -ffast-math -funroll-loops -std=c11 dot_product.c -o simd_dot
 * gcc -O3 -march=native -ffast-math -funroll-loops -std=c11 -fopt-info-vec-optimized saxpy.c > simd_vec_report.txt
 */


float dot(const float *x, const float *y, size_t n) {
    float s = 0.0f;
    for (size_t i = 0; i < n; i++) {
        s += x[i] * y[i];
    }
    return s;
}

int main(int argc, char **argv){
    // Initialize the size of x and y arrays and set the scalar a value
    size_t n = (argc > 1) ? strtoull(argv[1], NULL, 10) : 10000000; // default 10M

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
    volatile float warm = dot(x, y, n);

    // Timing run
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    float s = dot(x, y, n);

    clock_gettime(CLOCK_MONOTONIC, &end);

    double seconds = (end.tv_sec - start.tv_sec) +
                     (end.tv_nsec - start.tv_nsec) / 1e9;

    // Compute FLOPs
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