#   File:       viewCDEF.make
#   Target:     viewCDEF
#   Sources:    viewCDEF.a
#   Created:    Wednesday, February 6, 1991 11:50:16 AM

viewCDEF ƒƒ viewCDEF.make viewCDEF.make viewCDEF.a.o
	Link -rt CDEF viewCDEF.a.o -o viewCDEF
	delete viewCDEF.a.o

viewCDEF.a.o ƒ viewCDEF.make viewCDEF.a
	 Asm  viewCDEF.a
