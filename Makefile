FC      = gfortran
FFLAGS  = -Wall -Wextra -O3 -fimplicit-none -march=native -ffast-math
#FFLAGS += -pedantic -fbounds-check -fmax-errors=1 -g
#FFLAGS += $(shell pkg-config --cflags plplotd-f95)
#LDFLAGS = $(shell pkg-config --libs plplotd-f95)
LDFLAGS = 
LIBS    =

COMPILE = $(FC) $(FFLAGS)
LINK = $(FC) $(LDFLAGS)

TARGET = ain.exe       # Name of final executable to produce
#OBJS = md_plot.o 
OBJS =
OBJS += simulation.o # List of object dependencies

$(TARGET): $(OBJS)
	$(LINK) -o $@ $^ $(LIBS)

%.o:%.f95
	$(COMPILE) -c $<
