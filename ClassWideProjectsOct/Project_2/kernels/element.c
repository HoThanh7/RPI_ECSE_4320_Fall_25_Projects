#define _POSIX_C_SOURCE 200112L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/**
 * element - elementwise multiply z[i] = x[i] * y[i]
 */
void element_scalar(float *z, const float *x, const float *y, size_t n) {
    for (size_t i = 0; i < n; ++i) z[i] = x[i] * y[i];
}

static inline double wall_time_s(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main(int argc, char **argv) {
    size_t n = (argc > 1) ? strtoull(argv[1], NULL, 10) : 10000000;
    float *x = NULL, *y = NULL, *z = NULL;
    if (posix_memalign((void**)&x, 64, n * sizeof(float)) != 0 ||
        posix_memalign((void**)&y, 64, n * sizeof(float)) != 0 ||
        posix_memalign((void**)&z, 64, n * sizeof(float)) != 0) {
        perror("posix_memalign failed");
        return 1;
    }

    srand(42);
    for (size_t i = 0; i < n; ++i) {
        x[i] = (float)rand() / RAND_MAX;
        y[i] = (float)rand() / RAND_MAX;
        z[i] = 0.0f;
    }

    element_scalar(z, x, y, n); // warmup

    double t0 = wall_time_s();
    element_scalar(z, x, y, n);
    double t1 = wall_time_s();

    double seconds = t1 - t0;
    double flops = 1.0 * (double)n; // 1 mul per element
    double gflops = (flops / seconds) / 1e9;

    double checksum = 0.0;
    for (size_t i = 0; i < n; ++i) checksum += z[i];

    printf("element,%zu,%.9f,%.6f,%.6e\n", n, seconds, gflops, checksum);

    free(x);
    free(y);
    free(z);
    return 0;
}
