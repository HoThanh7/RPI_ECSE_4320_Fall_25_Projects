#define _POSIX_C_SOURCE 200112L
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <string.h>

/**
 * Compilation examples
 *
 * Scalar build (no SIMD):
 * gcc -O0 -fno-tree-vectorize -std=c11 -S saxpy.c -o saxpy_scalar.s
 * gcc -O0 -fno-tree-vectorize -std=c11 saxpy.c -o saxpy_scalar
 * gcc -O0 -std=c11 -fopt-info-vec-optimized kernels.c > scalar_vec_report.txt
 *
 * SIMD build (optimized):
 * gcc -O3 -march=native -ffast-math -funroll-loops -std=c11 -S saxpy.c -o simd_saxpy.s
 * gcc -O3 -march=native -ffast-math -funroll-loops -std=c11 saxpy.c -o simd_saxpy
 * gcc -O3 -march=native -ffast-math -funroll-loops -std=c11 -fopt-info-vec-optimized kernels.c > simd_vec_report.txt
 */

/** 
 * Compilation Flags Explanation
 *
 * -O0 → No optimization
 * Prevents compiler optimizations, including auto-vectorization; useful for scalar baseline.
 *
 * -O3 → High-level optimization
 * Enables aggressive optimizations including inlining, loop unrolling, and auto-vectorization.
 *
 * -march=native → Target architecture = host CPU
 * Lets the compiler generate instructions for your exact CPU, enabling AVX, FMA, SSE, etc.
 *
 * -ffast-math → Fast floating-point math
 * Allows reordering, contraction (FMA), and ignoring strict IEEE rules for higher performance.
 *
 * -funroll-loops → Loop unrolling
 * Expands loops to reduce branching overhead, improving SIMD vectorization opportunities.
 *
 * -std=c11 → C standard = C11
 * Specifies the C language standard; ensures compatibility with your code.
 *
 * -S → Generate assembly
 * Stops after compilation; produces a .s file with readable assembly code.
 *
 * -fopt-info-vec-optimized → Vectorization report
 * Outputs information about which loops/functions were vectorized by the compiler.
 */

// ---------------- Kernels ----------------

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

// ---------------- Timer ----------------

static inline double wall_time() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

// ---------------- Experiment Runners ----------------

void run_saxpy(size_t n, int repeats, FILE *csv) {
    float a = 2.5f;

    // Allocate aligned memory (SIMD-friendly)
    float *x, *y;
    if (posix_memalign((void**)&x, 64, n * sizeof(float)) != 0 ||
        posix_memalign((void**)&y, 64, n * sizeof(float)) != 0) {
        perror("posix_memalign");
        exit(1);
    }

    // Initialize with reproducible pseudo-random values
    srand(42);
    for (size_t i = 0; i < n; i++) {
        x[i] = (float)rand() / RAND_MAX;
        y[i] = (float)rand() / RAND_MAX;
    }

    // Warm-up run
    saxpy_scalar(a, x, y, n);

    // Timed runs
    for (int r = 0; r < repeats; r++) {
        double t0 = wall_time();
        saxpy_scalar(a, x, y, n);
        double t1 = wall_time();

        double time_s = t1 - t0;
        double flops = 2.0 * n; // 1 mul + 1 add per element
        double gflops = flops / (time_s * 1e9);

        // checksum (to prevent dead-code elimination)
        double checksum = 0.0;
        for (size_t i = 0; i < n; i++) {
            checksum += y[i];
        }

        fprintf(csv, "saxpy,%zu,%f,%f,%e\n", n, time_s, gflops, checksum);
        fflush(csv);
    }

    free(x);
    free(y);
}


// ---------------- Main ----------------

int main(int argc, char **argv) {
    // CLI usage: ./kernels [csv_file]
    const char *csv_file = (argc > 1) ? argv[1] : "results.csv";  // <-- FIXED

    int repeats = 3;

    FILE *csv = fopen(csv_file, "w");
    if (!csv) {
        perror("fopen");
        return 1;
    }

    // CSV header
    fprintf(csv, "kernel,n,time_s,gflops,checksum\n");

    // Problem sizes to sweep
    size_t sweep_sizes[] = {
        1,
        2,
        4,
        8,
        16,
        32,
        64,
        128,
        256,
        512,
        1024,
        2048,
        4096,
        8192,
        16384,
        32768,
        65536,
        131072,
        262144,
        524288,
        1048576,
        2097152,
        4194304,
        8388608,
        16777216,
        33554432,
        67108864
    };
    size_t num_sizes = sizeof(sweep_sizes) / sizeof(sweep_sizes[0]);

    // Run experiments
    for (size_t i = 0; i < num_sizes; i++) {
        run_saxpy(sweep_sizes[i], repeats, csv);
    }

    fclose(csv);
    printf("Results written to %s\n", csv_file);
    return 0;
}
