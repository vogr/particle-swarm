
# Debug flags
CFLAGS+=-O0 -ggdb3 \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal \
-pedantic-errors -Werror=format-security \
-march=native \
-Werror=vla

# Release flags
#CFLAGS += -O2 -flto -march=native


LDLIBS+=-lm


CXXFILES := src/perf_ge_solve.cpp
CFILES_COMMON := src/helpers.c src/local_refinement.c src/logging.c \
                 src/plu_factorization.c src/pso.c src/bloom.c src/murmurhash.c \
				 src/rounding_bloom.c src/gaussian_elimination_solver.c
OBJFILES_COMMON := $(CFILES_COMMON:.c=.o)
OBJPERF_FILES := $(CXXFILES:.cpp=.o)


UNAME_S := $(shell uname -s)


ifdef PSO_SHARED

# For the shared file we also need to include
# TEST_PERF=1

CFLAGS += -DTEST_PERF

ifeq ($(UNAME_S),Darwin)
target := libpso.dylib
CFLAGS += -dynamiclib
LDFLAGS += -dynamiclib
else
target := libpso.so
CFLAGS += -fPIC
LDFLAGS += -shared
endif

OBJFILES := $(OBJFILES_COMMON)

else # PSO_SHARED

target := pso
OBJFILES := $(OBJFILES_COMMON) src/main.o

# Optionnal sanitizers
CFLAGS += -fsanitize=undefined -fsanitize=address
LDFLAGS += -fsanitize=undefined -fsanitize=address

endif

$(target): $(OBJFILES)
ifdef PSO_SHARED
	g++ -c -std=c++0x $(LDFLAGS) $(OBJPERF_FILES)
	$(CC) -c -std=c99 $(LDFLAGS) $^ $(LDLIBS)
	g++ -o $@ $(LDFLAGS) $(OBJPERF_FILES) $^ $(LDLIBS)
else
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)
endif


.PHONY: clean
clean:
	rm $(OBJFILES_COMMON) src/main.o ||:
	rm pso libpso.so pso.dylib ||:
