#define _POSIX_C_SOURCE 200112L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

/**
 * dot - dot product reduction s = sum_i x[i]*y[i]
 */
float dot_scalar(const float *x, const float *y, size_t n) {
    float s = 0.0f;
    for (size_t i = 0; i < n; ++i) s += x[i] * y[i];
    return s;
}

static inline double wall_time_s(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + ts.tv_nsec * 1e-9;
}

int main(int argc, char **argv) {
    size_t n = (argc > 1) ? strtoull(argv[1], NULL, 10) : 10000000;

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

    // warmup
    volatile float warm = dot_scalar(x, y, n);
    (void)warm;

    double t0 = wall_time_s();
    float s = dot_scalar(x, y, n);
    double t1 = wall_time_s();

    double seconds = t1 - t0;
    double flops = 2.0 * (double)n; // each iteration: 1 mul + 1 add
    double gflops = (flops / seconds) / 1e9;

    // print checkpoint checksum and timing
    double checksum = 0.0;
    for (size_t i = 0; i < n; ++i) checksum += y[i];

    printf("dot,%zu,%.9f,%.6f,%.6e\n", n, seconds, gflops, checksum);

    free(x);
    free(y);
    return 0;
}
