#define _POSIX_C_SOURCE 200112L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

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

static inline double wall_time_s(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main(int argc, char **argv) {
    size_t n = (argc > 1) ? strtoull(argv[1], NULL, 10) : 10000000;
    float a = 2.5f;

    float *x = NULL, *y = NULL;
    if (posix_memalign((void**)&x, 64, n * sizeof(float)) != 0 ||
        posix_memalign((void**)&y, 64, n * sizeof(float)) != 0) {
        perror("posix_memalign failed");
        return 1;
    }

    srand(42);
    for (size_t i = 0; i < n; ++i) {
        x[i] = (float)rand() / RAND_MAX;
        y[i] = (float)rand() / RAND_MAX;
    }

    // Warm-up
    saxpy_scalar(a, x, y, n);

    double t0 = wall_time_s();
    saxpy_scalar(a, x, y, n);
    double t1 = wall_time_s();

    double seconds = t1 - t0;
    double flops = 2.0 * (double)n; // 1 mul + 1 add per element
    double gflops = (flops / seconds) / 1e9;

    // checksum to prevent optimizer removing loop
    double checksum = 0.0;
    for (size_t i = 0; i < n; ++i) checksum += y[i];

    // CSV row: kernel,n,time_s,gflops,checksum
    printf("saxpy,%zu,%.9f,%.6f,%.6e\n", n, seconds, gflops, checksum);

    free(x);
    free(y);
    return 0;
}
