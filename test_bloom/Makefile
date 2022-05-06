
# Debug flags
CFLAGS+=-O0 -ggdb3 \
-Wall -Wextra -Wpedantic -Wformat=2 -Wswitch-default -Wswitch-enum -Wfloat-equal \
-pedantic-errors -Werror=format-security \
-Werror=vla

# Release flags
#CFLAGS += -O2 -flto -march=native


LDLIBS+=-lm

OPUS_SRC := ../opus

CFILES := src/bloom.c src/rounding_bloom.c src/murmurhash.c src/helpers.c
OBJFILES := $(addprefix $(OPUS_SRC)/, $(CFILES:.c=.o))


UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
target := libroundingbloom.dylib
CFLAGS += -dynamiclib
LDFLAGS += -dynamiclib
else
target := libroundingbloom.so
CFLAGS += -fPIC
LDFLAGS += -shared
endif



$(target): $(OBJFILES)
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)


.PHONY: clean
clean:
	rm $(OBJFILES) ||:
	rm libroundingbloom.so libroundingbloom.dylib ||:
