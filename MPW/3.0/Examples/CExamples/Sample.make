#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Sample Application
#
#	Sample
#
#	[C]Sample.make	-	Make Source
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0					08/88
#				1.01				11/88
#
#	Components:	Sample.p			November 1, 1988
#				Sample.c			November 1, 1988
#				Sample.a			November 1, 1988
#				Sample.inc1.a		November 1, 1988
#				SampleMisc.a		November 1, 1988
#				Sample.r			November 1, 1988
#				Sample.h			November 1, 1988
#				[P]Sample.make		November 1, 1988
#				[C]Sample.make		November 1, 1988
#				[A]Sample.make		November 1, 1988
#
#	Sample is an example application that demonstrates how to
#	initialize the commonly used toolbox managers, operate 
#	successfully under MultiFinder, handle desk accessories, 
#	and create, grow, and zoom windows.
#
#	It does not by any means demonstrate all the techniques 
#	you need for a large application. In particular, Sample 
#	does not cover exception handling, multiple windows/documents, 
#	sophisticated memory management, printing, or undo. All of 
#	these are vital parts of a normal full-sized application.
#
#	This application is an example of the form of a Macintosh 
#	application; it is NOT a template. It is NOT intended to be 
#	used as a foundation for the next world-class, best-selling, 
#	600K application. A stick figure drawing of the human body may 
#	be a good example of the form for a painting, but that does not 
#	mean it should be used as the basis for the next Mona Lisa.
#
#	We recommend that you review this program or TESample before 
#	beginning a new application.
#

# MPW 3.0 and later: We override the default COptions to turn on strict prototyping;
#	add '-r' to your UserStartup when you tire of the warning from Make.
# If you are using MPW 3.0 or later, uncomment the following line:
COptions = -d MPW3 -r	# define MPW3, turn on strict prototyping (-r option)

CObjs		= Sample.c.o ∂
		"{CLibraries}"CRuntime.o ∂
		"{CLibraries}"CInterface.o ∂
		"{Libraries}"Interface.o

Sample		ƒƒ {CObjs} Sample.make
		Link -o {Targ} {CObjs}
		SetFile {Targ} -t APPL -c 'MOOS' -a B

Sample		ƒƒ Sample.r Sample.make
		Rez -rd -o {Targ} Sample.r -append

Sample.c.o	ƒƒ Sample.c Sample.make
