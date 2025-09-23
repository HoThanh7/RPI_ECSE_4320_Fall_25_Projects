CC = gcc
SRCDIR = kernels
BINDIR = bin
ASMDIR = asm
REPORTDIR = build/reports
CFLAGS_COMMON = -D_POSIX_C_SOURCE=200112L -Wall -Wextra -std=c11
CFLAGS_SCALAR = -O0 -fno-tree-vectorize $(CFLAGS_COMMON)
CFLAGS_SIMD   = -O3 -march=native -ffast-math -funroll-loops $(CFLAGS_COMMON)
LDFLAGS =

KERNELS = saxpy dot element

.PHONY: all scalar simd clean asm dirs

all: dirs scalar simd

dirs:
	mkdir -p $(BINDIR) $(ASMDIR) $(REPORTDIR)

# scalar: builds *_scalar executables
scalar: dirs $(patsubst %,$(BINDIR)/%_scalar,$(KERNELS))

# simd: builds *_simd executables and emits vec reports + assembly
simd: dirs $(patsubst %,$(BINDIR)/%_simd,$(KERNELS))

$(BINDIR)/%_scalar: $(SRCDIR)/%.c
	$(CC) $(CFLAGS_SCALAR) $< -o $@ $(LDFLAGS)

$(BINDIR)/%_simd: $(SRCDIR)/%.c
	$(CC) $(CFLAGS_SIMD) $< -o $@ \
		-fopt-info-vec-optimized=$(REPORTDIR)/$*_vec.txt $(LDFLAGS)
	$(CC) $(CFLAGS_SIMD) -S $< -o $(ASMDIR)/$*_simd.s


asm: dirs
    @echo "asm dir: $(ASMDIR)"

clean:
	rm -rf $(BINDIR) $(ASMDIR) $(REPORTDIR) data/*.csv
