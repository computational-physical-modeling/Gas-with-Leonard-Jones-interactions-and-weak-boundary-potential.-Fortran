#================================================
# Compilador y banderas
FC      = gfortran
DBG     =            # Para debugging: -g -Wall -fcheck=all -fbacktrace
FFLAGS  = -O3 $(DBG)

# Nombre del ejecutable
PROGRAM = xdm

# Archivos fuente
SRCS = mod_DM.f90 DM.f90 leer.f90 inicio.f90 fuerzas.f90 integracion.f90 ran2.f90 escribir_trayectoria.f90

# Archivos objeto derivados
OBJS = $(SRCS:.f90=.o)

# Regla para compilar .f90 a .o
%.o: %.f90
	$(FC) -c $(FFLAGS) $<

# Regla para enlazar todo y crear ejecutable
$(PROGRAM): $(OBJS)
	$(FC) -o $@ $(OBJS) $(FFLAGS)

# Regla de limpieza
clean:
	rm -f *.o *.mod $(PROGRAM)
#================================================

