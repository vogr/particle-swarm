
# Debug flags
CFLAGS+=-O0 -ggdb3 \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal \
-pedantic-errors -Werror=format-security \
-Werror=vla

# Release flags
#CFLAGS += -O2 -flto -march=native

# Optionnal sanitizers
CFLAGS += -fsanitize=undefined -fsanitize=address
LDFLAGS += -fsanitize=undefined -fsanitize=address


LDLIBS+=-lm


CFILES := src/helpers.c src/local_refinement.c src/logging.c src/main.c src/plu_factorization.c src/pso.c
OBJFILES := $(CFILES:.c=.o)

pgm: $(OBJFILES)
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)

.PHONY: clean
clean:
	rm $(OBJFILES)
	rm pgm
