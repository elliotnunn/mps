#   File:       ICONCDEF.make
#   Target:     ICONCDEF
#   Sources:    ICONCDEF.c

ICONCDEF ƒƒ ICONCDEF.make ICONCDEF.make ICONCDEF.c.o
	link ICONCDEF.c.o -o ICONCDEF -rt CDEF -m CICONCTL -ra resPurgeable -sn ICONCDEF
	delete ICONCDEF.c.o

ICONCDEF.c.o ƒ ICONCDEF.make ICONCDEF.c
	 C  ICONCDEF.c
