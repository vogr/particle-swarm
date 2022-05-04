
# Debug flags
CFLAGS+=-O0 -ggdb3 \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal \
-pedantic-errors -Werror=format-security \
-Werror=vla

# Release flags
#CFLAGS += -O2 -flto -march=native

# optionnal sanitizers
CFLAGS += -fsanitize=undefined -fsanitize=address
LDFLAGS += -fsanitize=undefined -fsanitize=address

OBJFILES := src/main.o ../opus/src/plu_factorization.o ../opus/src/helpers.o 

pgm: $(OBJFILES)
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)

.PHONY: clean
clean:
	rm $(OBJFILES)
	rm pgm
