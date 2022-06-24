######
# Makefile options
######

# Exemple: build a library in debug mode
#	$ make PSO_SHARED=1 DEBUG=1

# Build using the debug configuration? Default=yes
DEBUG ?= 1

# Build the pso solver as a library? Default=no
PSO_SHARED ?= 0

# Build the baseline instead of the optimized version
BASELINE= ?= 0

# Build the run_pso_testers main file? Default=no
RUN_PERF_TESTERS ?= 0

# Build with Intel's MKL
INC_MKL ?= 0

# Pull autotune variables from the environment
AUTOTUNE_ENV ?= 0

# Papi in PerformanceTester ?
WITH_PAPI ?= 0


# Papi in PerformanceTester ?
PAPI_WHOLE_SYSTEM ?= 0

######
# Compilation flags
######

# Debug flags: no optimisations, debug symbols, extra warnings
# march=native to allow vectorisation
DEBUG_FLAGS:= \
-O0 -g \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal \
-pedantic-errors -Werror=format-security
#-Werror=vla


# Release flags: optimisations, NDEBUG (disable assertions), disable hardening, disable PIE (only for executable)
RELEASE_FLAGS:=-DNDEBUG -O3 -flto -fcf-protection=none -fno-stack-protector -ffast-math

# Flags common to debug and release
COMMON_FLAGS := -DNO_AVX512=1

# Set arch target for CI
ifeq ($(CI), true)
	COMMON_FLAGS+=-march=skylake
else
	COMMON_FLAGS+=-march=native
endif

# Set the standard, necessary for Clang
CFLAGS += -std=gnu17
CXXFLAGS += -std=gnu++17

# Libraries to link
LDLIBS+=-lm

ifeq ($(BASELINE), 1)
	CPPFLAGS+=-DFIT_SURROGATE_VERSION=fit_surrogate_0
	CPPFLAGS+=-DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_0
	CPPFLAGS+=-DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0
	CPPFLAGS+=-DSURROGATE_EVAL_VERSION=surrogate_eval_0
	CPPFLAGS+=-DSTEP1_2_VERSION=step1_2_opt0
	CPPFLAGS+=-DSTEP3_VERSION=step3_base
	CPPFLAGS+=-DSTEP4_VERSION=step4_base
	CPPFLAGS+=-DSTEP6_VERSION=step6_base
	CPPFLAGS+=-DGE_SOLVE_VERSION=gaussian_elimination_solve_0
endif

ifeq ($(AUTOTUNE_ENV), 1)
	AUTOTUNE_FLAGS = -DLU_BLOCK=${AT_LU_BLOCK}
	AUTOTUNE_FLAGS += -DM_BLOCK=${AT_M_BLOCK}
	AUTOTUNE_FLAGS += -DN_BLOCK=${AT_N_BLOCK}
	AUTOTUNE_FLAGS += -DK_BLOCK=${AT_K_BLOCK}
else
	# Default arguments
	AUTOTUNE_FLAGS = -DLU_BLOCK=64
	AUTOTUNE_FLAGS += -DM_BLOCK=192
	AUTOTUNE_FLAGS += -DN_BLOCK=2048
	AUTOTUNE_FLAGS += -DK_BLOCK=384
endif

NEED_PAPI:=0
ifeq ($(WITH_PAPI), 1)
	CPPFLAGS+="-DWITH_PAPI=1"
	NEED_PAPI:=1
endif

ifeq ($(PAPI_WHOLE_SYSTEM), 1)
	CPPFLAGS+="-DPAPI_WHOLE_SYSTEM=1"
	NEED_PAPI:=1
endif

ifeq ($(NEED_PAPI), 1)
	LDLIBS += $(shell pkg-config --libs papi)
	COMMON_FLAGS += $(shell pkg-config --cflags papi)
endif

######
# C/C++ source files
######

# Object files required for the library and the executable
# (indifferently C or C++, `make` will use the correct rule based on the
# source file extension)
OBJ_COMMON := src/helpers.o src/local_refinement.o src/logging.o \
		src/blas/dgemm.o src/blas/idamax.o src/blas/dswap.o src/blas/dlaswp.o \
		src/blas/dtrsm.o src/blas/dgetf2.o src/blas/dgetrs.o \
		src/lu_solve.o src/pso.o src/bloom.o src/murmurhash.o \
		src/distincts.o \
		src/rounding_bloom.o src/gaussian_elimination_solver.o \
		src/steps/step1_2.o \
		src/steps/step3.o src/steps/step4.o src/steps/step5.o \
		src/steps/step6.o src/steps/step7.o src/steps/step8.o \
		src/steps/step9.o src/steps/step10.o src/steps/step11.o \
		src/steps/surrogate_eval.o src/steps/fit_surrogate.o \
		src/triangular_system_solver.o src/latin_hypercube.o

# Object files required for the the library
OBJ_LIB := src/perf_testers/perf_ge_solve.o \
		src/perf_testers/perf_lu_solve.o \
		src/perf_testers/perf_mmm.o \
		src/pso_ffi.o \
		src/perf_testers/perf_block_tri_solve.o

# Object files required for the the executable
ifeq ($(RUN_PERF_TESTERS), 1)
	OBJ_EXE := src/perf_testers/run_perf_testers.o

	TEST_PERF=1
	COMMON_FLAGS += -DTEST_PERF
	OBJ_COMMON += src/perf_testers/perf_ge_solve.o \
		src/perf_testers/perf_lu_solve.o \
		src/perf_testers/perf_mmm.o \
		src/perf_testers/perf_block_tri_solve.o
else 
	OBJ_EXE := src/main.o
endif

#####
# MKL compilation options
#####

# see https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl-link-line-advisor.html
# to get an updated list of flags
ifeq ($(INC_MKL), 1)
	# link to MKL's "Single Dynamic Library"
	LDLIBS += $(shell pkg-config --libs  mkl-static-lp64-seq)
	COMMON_FLAGS += $(shell pkg-config --cflags  mkl-static-lp64-seq)
	COMMON_FLAGS+=-DTEST_MKL
endif # MKL


######
# Library vs executable compilation options
######

# Detect the system
UNAME_S := $(shell uname -s)


ifeq ($(PSO_SHARED), 1)
	# Option 1. Build a shared library

	# For the shared file we also need to pass
	# a preprocessor definition
	TEST_PERF=1
	COMMON_FLAGS += -DTEST_PERF

	# 
	# DEBUG_FLAGS+=-fsanitize=undefined -fsanitize=address

	ifeq ($(UNAME_S),Darwin)
	target := libpso.dylib
	COMMON_FLAGS += -dynamiclib
	LDFLAGS += -dynamiclib
	else
	target := libpso.so
	COMMON_FLAGS += -fPIC
	LDFLAGS += -shared
	endif

	OBJFILES := $(OBJ_COMMON) $(OBJ_LIB)

else # PSO_SHARED
	# Option 2. Build an executable

	# Disable PIE
	COMMON_FLAGS+=-fno-PIE
	LDFLAGS+=-no-pie

	# Optionnal sanitizers.
	# Only enable int the executable as loading sanitized libraries
	# from a non-sanitized executable results in an error
	DEBUG_FLAGS+=-fsanitize=undefined -fsanitize=address

	target := pso
	OBJFILES := $(OBJ_COMMON) $(OBJ_EXE)

endif


######
# Compilation flags
######


ifeq ($(DEBUG), 0)
	ALL_FLAGS := $(COMMON_FLAGS) $(RELEASE_FLAGS)
else
	ALL_FLAGS := $(COMMON_FLAGS) $(DEBUG_FLAGS)
endif

CXXFLAGS+= $(ALL_FLAGS)
CFLAGS+= $(ALL_FLAGS) $(AUTOTUNE_FLAGS)
# LTO and sanitizers: the compilation flags are needed at link time
LDFLAGS+= $(ALL_FLAGS)


######
# Build rules
######

# Note that for the compilation we rely on the implicit rules
# https://www.gnu.org/software/make/manual/html_node/Implicit-Rules.html

# Linking rule
# Note that we might be linking C and C++, use CXX as the linker
$(target): $(OBJFILES)
	$(CXX) -o $@ $(LDFLAGS) $^ $(LDLIBS)



.PHONY: clean
clean:
	rm $(OBJ_COMMON) $(OBJ_EXE) $(OBJ_LIB) ||:
	rm pso libpso.so libpso.dylib ||:
