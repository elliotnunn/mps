#   File:       NotPPC.make
#   Target:     NotPPC
#   Sources:    NotPPC.c NotPPC.r
#   Created:    Thursday, May 27, 1993 9:48:50
#   Modified:   Thursday, January 6, 1994 3:09:52


OBJECTS = NotPPC.c.o


NotPPC ƒƒ NotPPC.make NotPPC.r
	Rez NotPPC.r -append -d SystemSevenOrLater=1 -o NotPPC

NotPPC ƒƒ NotPPC.make {OBJECTS}
#
# Note that the Link step is merging the segments 'Main' and '%A5Init'
# into one called 'PPCOnly'.  You might be able to use 'PPCOnly' to 
# differentiate between a Power Macintosh only application versus
# a FAT application (such as from an installer).
#
	Link -t APPL -c '????' -sg PPCOnly=Main,%A5Init ∂
		{OBJECTS} ∂
		"{Libraries}"MacRuntime.o ∂
		"{Libraries}"Interface.o ∂
		-o NotPPC
		
NotPPC.c.o ƒ NotPPC.make NotPPC.c
	 SC -proto strict  NotPPC.c