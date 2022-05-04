
# Debug flags
CFLAGS+=-O0 -ggdb3 \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal \
-pedantic-errors -Werror=format-security \
-Werror=vla

# Release flags
#CFLAGS += -O2 -flto -march=native


LDLIBS+=-lm


CFILES_COMMON := src/helpers.c src/local_refinement.c src/logging.c src/plu_factorization.c src/pso.c
OBJFILES_COMMON := $(CFILES_COMMON:.c=.o)


UNAME_S := $(shell uname -s)


ifdef PSO_SHARED

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

else

target := pso
OBJFILES := $(OBJFILES_COMMON) src/main.o

# Optionnal sanitizers
CFLAGS += -fsanitize=undefined -fsanitize=address
LDFLAGS += -fsanitize=undefined -fsanitize=address

endif


$(target): $(OBJFILES)
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)


.PHONY: clean
clean:
	rm $(OBJFILES_COMMON) src/main.o ||:
	rm pso libpso.so pso.dylib ||:
