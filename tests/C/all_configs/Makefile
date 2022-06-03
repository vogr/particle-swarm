
# Debug flags
CPPFLAGS+=-I../../../opus/src

# Release flags
RELEASE_FLAGS:=-DNDEBUG -O2 -flto -fcf-protection=none -fno-stack-protector -ffast-math -g

CFLAGS+= -std=gnu17 $(RELEASE_FLAGS) 
CXXFLAGS+= -std=gnu++17 $(RELEASE_FLAGS) 
LDFLAGS+=-no-pie $(RELEASE_FLAGS)


LDLIBS+=-lpso -L../../../opus

OBJFILES := src/main.o

# Optionnal sanitizers
# CFLAGS += -fsanitize=undefined -fsanitize=address
#LDFLAGS += -fsanitize=undefined -fsanitize=address

test: $(OBJFILES)
	$(CXX) -o $@ $(LDFLAGS) $^ $(LDLIBS)


.PHONY: clean
clean:
	rm $(OBJFILES) ||:
	rm test ||: