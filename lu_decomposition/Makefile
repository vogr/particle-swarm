CFLAGS+=\
-O0 -ggdb3 \
-march=native \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal \
-pedantic-errors -Werror=format-security \
-Werror=vla \
-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS \
-fexceptions \
-flto -fPIE

LDFLAGS+=-Wl,-z,noexecstack,-z,relro,-z,defs,-z,now,-pie

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
