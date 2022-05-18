
######
# Makefile options
######

# Exemple: build a library in debug mode
#	$ make PSO_SHARED=1 DEBUG=1

# Build using the debug configuration? Default=yes
DEBUG ?= 1

# Build the pso solver as a library? Default=no
PSO_SHARED ?= 0

######
# Compilation flags
######

# Debug flags: no optimisations, debug symbols, extra warnings
# march=native to allow vectorisation
DEBUG_FLAGS:= \
-march=native \
-O0 -g \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal \
-pedantic-errors -Werror=format-security \
-Werror=vla

# Release flags: optimisations, NDEBUG (disable assertions)
RELEASE_FLAGS:=-DNDEBUG -O2 -flto -march=native

# Change these variables if setting the C/C++ standard is necessary
# CFLAGS += -std=gnu17
# CXXFLAGS += -std=gnu++17

ifeq ($(DEBUG), 0)
	CXXFLAGS+= $(RELEASE_FLAGS)
	CFLAGS+= $(RELEASE_FLAGS)
else
	CXXFLAGS+= $(DEBUG_FLAGS)
	CFLAGS+= $(DEBUG_FLAGS)
endif

# Libraries to link
LDLIBS+=-lm


######
# C/C++ source files
######

# Object files required for the library and the executable
# (indifferently C or C++, `make` will use the correct rule based on the
# source file extension)
OBJ_COMMON := src/helpers.o src/local_refinement.o src/logging.o \
                 src/plu_factorization.o src/pso.o src/bloom.o src/murmurhash.o \
		 src/rounding_bloom.o src/gaussian_elimination_solver.o

# Object files required for the the library
OBJ_LIB := src/perf_ge_solve.o
# Object files required for the the executable
OBJ_EXE := src/main.o



######
# Library vs executable compilation options
######

# Detect the system
UNAME_S := $(shell uname -s)


ifeq ($(PSO_SHARED), 1)
	# Option 1. Build a shared library

	# For the shared file we also need to include
	# TEST_PERF=1
	CFLAGS += -DTEST_PERF

	ifeq ($(UNAME_S),Darwin)
	target := libpso.dylib
	CFLAGS   += -dynamiclib
	CXXFLAGS += -dynamiclib
	LDFLAGS += -dynamiclib
	else
	target := libpso.so
	CFLAGS   += -fPIC
	CXXFLAGS += -fPIC
	LDFLAGS += -shared
	endif

	OBJFILES := $(OBJ_COMMON) $(OBJ_LIB)

else # PSO_SHARED
	# Option 2. Build an executable

	target := pso
	OBJFILES := $(OBJ_COMMON) $(OBJ_EXE)

	# Sanitizers are enabled for the executable in debug mode
	ifeq ($(DEBUG), 1)
	CFLAGS += -fsanitize=undefined -fsanitize=address
	LDFLAGS += -fsanitize=undefined -fsanitize=address
	endif

endif


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
