#   File:       StatTextCDEF.make
#   Target:     StatTextCDEF
#   Sources:    StatTextCDEF.c

SegmentMappings	=	-sn Main=StatTextCDEF

StatTextCDEF ƒƒ StatTextCDEF.make StatTextCDEF.make StatTextCDEF.c.o
	link {SegmentMappings} StatTextCDEF.c.o "{Libraries}Interface.o" -o StatTextCDEF -rt CDEF -m CSTATTEXTCTL -ra resPurgeable -sn StatTextCDEF
	delete StatTextCDEF.c.o

StatTextCDEF.c.o ƒ StatTextCDEF.make StatTextCDEF.c
	 C  StatTextCDEF.c
