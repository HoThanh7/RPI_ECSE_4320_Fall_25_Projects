# Project 1: SIMD Kernel Profiling and Analysis

**Course:** ECSE 4320/6320 – Advanced Computer Systems  
**Author:** Thanh Ho  
**CPU:** AMD Ryzen 7 7800X3D  
**Cores / Threads:** 8 cores / 16 threads  
**OS:** Arch Linux x86_64 
**Kernel:** 6.16.8-arch3-1

---


## Performance graphs

The following graphs were generated from the Project 2 kernel benchmarks (scalar and SIMD). They are included here by relative path so they render on GitHub when viewing the repository.

### SAXPY
<p align="center">
  <img src="../proj2_results/plots/saxpy_scalar_saxpy_raw.png" alt="saxpy scalar raw" width="320" />
  <img src="../proj2_results/plots/saxpy_scalar_saxpy_median.png" alt="saxpy scalar median" width="320" />
  <img src="../proj2_results/plots/saxpy_simd_saxpy_raw.png" alt="saxpy simd raw" width="320" />
  <img src="../proj2_results/plots/saxpy_simd_saxpy_median.png" alt="saxpy simd median" width="320" />
</p>

### Dot product
<p align="center">
  <img src="../proj2_results/plots/dot_scalar_dot_raw.png" alt="dot scalar raw" width="320" />
  <img src="../proj2_results/plots/dot_scalar_dot_median.png" alt="dot scalar median" width="320" />
  <img src="../proj2_results/plots/dot_simd_dot_raw.png" alt="dot simd raw" width="320" />
  <img src="../proj2_results/plots/dot_simd_dot_median.png" alt="dot simd median" width="320" />
</p>

### Elementwise multiply
<p align="center">
  <img src="../proj2_results/plots/element_scalar_element_raw.png" alt="element scalar raw" width="320" />
  <img src="../proj2_results/plots/element_scalar_element_median.png" alt="element scalar median" width="320" />
  <img src="../proj2_results/plots/element_simd_element_raw.png" alt="element simd raw" width="320" />
  <img src="../proj2_results/plots/element_simd_element_median.png" alt="element simd median" width="320" />
</p>





 
From the results above, there is a scalar version of every kernel showing the gflops as the size of the arrays increase. The vectorization of all the kernels can be seen in the report. Since a lot of Project 1 and Project 2 shared the kernel codes, the vector reports can be found in proj2_results/reports.
An example of the report is

  ```
  kernels/saxpy.c:17:26: optimized: loop vectorized using 64 byte vectors
  kernels/saxpy.c:17:26: optimized:  loop versioned for vectorization because of possible aliasing
  kernels/saxpy.c:17:26: optimized: loop vectorized using 32 byte vectors
  kernels/saxpy.c:58:26: optimized: loop vectorized using 64 byte vectors
  kernels/saxpy.c:58:26: optimized: loop vectorized using 32 byte vectors
  kernels/saxpy.c:17:26: optimized: loop vectorized using 64 byte vectors
  kernels/saxpy.c:17:26: optimized:  loop versioned for vectorization because of possible aliasing
  kernels/saxpy.c:17:26: optimized: loop vectorized using 32 byte vectors
  kernels/saxpy.c:17:26: optimized: loop vectorized using 64 byte vectors
  kernels/saxpy.c:17:26: optimized:  loop versioned for vectorization because of possible aliasing
  kernels/saxpy.c:17:26: optimized: loop vectorized using 32 byte vectors
  ```

Based on the results(although poor result at the moment), SIMD greatly increase the glfops as compared with scalar. For SAXPY and Elementwise multiply, it seems that SIMD performance improves as N increase until a point where it stagnates or decreases. This point is likely when the memory use goes from cache into DRAM, and the speed of the DRAM bottlenecks or decreases performance. 

