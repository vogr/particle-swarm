
.PHONY: all
all: pso

SRC:=src/main.c
OBJ=$(SRC:.c=.o)

CFLAGS+=\
-O0 -ggdb3 \
-march=native \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal -Wsign-conversion \
-pedantic-errors -Werror=format-security \
-Werror=vla \
-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS \
-fexceptions \
-flto -fPIE -Wl,-z,noexecstack,-z,relro,-z,defs,-z,now

pso: $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: clean
clean:
	rm $(OBJ)
	rm pso
