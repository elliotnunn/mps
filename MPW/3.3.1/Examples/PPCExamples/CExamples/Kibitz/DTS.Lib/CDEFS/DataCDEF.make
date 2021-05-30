#   File:       DataCDEF.make
#   Target:     DataCDEF
#   Sources:    DataCDEF.c

DataCDEF ƒƒ DataCDEF.make DataCDEF.make DataCDEF.c.o
	link DataCDEF.c.o -o DataCDEF -rt CDEF -m CDATACTL -ra resPurgeable -sn DataCDEF
	delete DataCDEF.c.o

DataCDEF.c.o ƒ DataCDEF.make DataCDEF.c
	 C  DataCDEF.c
