CPP      = g++
CFLAGS   = -Wall
LDFLAGS  = -lgsl -lgslcblas -lm
SRCDIR   = src
OBJDIR   = obj
LIBDIR   = $(SRCDIR)

TARGET  = optimize

SRCS     = $(wildcard $(SRCDIR)/main.cpp) $(wildcard $(LIBDIR)/**/*.cpp)
OBJS     = $(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.o,$(SRCS))
#HEADERS  = $(wildcard $(LIBDIR)/**/*.h) $(wildcard $(LIBDIR)/**/*.hpp)
HEADERS = $(shell find $(LIBDIR) -type f -name '*.h' -o -name '*.hpp')
INCLUDES = $(patsubst %,-I$(LIBDIR)/%,$(wildcard $(LIBDIR)/*))

ifdef VERBOSE
    CFLAGS += -DVERBOSE=true
endif

all: $(TARGET)

$(TARGET): $(OBJS)
	@echo "Compiling $(TARGET)..."
	$(CPP) $(CFLAGS) $(INCLUDES) $^ -o $@ $(LDFLAGS)
	@echo "$(TARGET) succesfully compiled."

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp $(HEADERS)
	@mkdir -p $(@D)
	@echo "Compiling $<..."
	$(CPP) $(CFLAGS) $(INCLUDES) -c -o $@ $<

clean:
	rm -rf $(OBJDIR) $(TARGET)

.PHONY: all clean