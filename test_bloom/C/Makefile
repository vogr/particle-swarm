
# Debug flags
CFLAGS+=-O0 -ggdb3 \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal \
-pedantic-errors -Werror=format-security \
-Werror=vla \
-I../../opus/src

# Release flags
#CFLAGS += -O2 -flto -march=native


LDLIBS+=-lroundingbloom -L..

CFILES := src/main.c
OBJFILES := $(CFILES:.c=.o)


test: $(OBJFILES)
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)


.PHONY: clean
clean:
	rm $(OBJFILES) ||:
	rm test ||: