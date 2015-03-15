FC      = gfortran
FFLAGS  = -Wall -Wextra -O3 -fimplicit-none -march=native -ffast-math
LDFLAGS = 
LIBS    =
#FFLAGS += $(shell pkg-config --cflags plplotd-f95)
#LIBS += $(shell pkg-config --libs plplotd-f95)



COMPILE = $(FC) $(FFLAGS)
LINK = $(FC) $(LDFLAGS)

TARGET = polymer.exe # Name of final executable to produce
OBJS =
OBJS += global.o # List of object dependencies
OBJS += monte_carlo.o
OBJS += chain_grow.o
OBJS += plotting.o
OBJS += main.o

$(TARGET): $(OBJS)
	$(LINK) -o $@ $^ $(LIBS)

%.o:%.f95
	$(COMPILE) -c $<
