#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	TESample
#
#	[C]TESample.make	-	Make Source
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0					08/88
#				1.01				11/88
#
#	Components:	TESample.p			November 1, 1988
#				TESample.c			November 1, 1988
#				TESampleGlue.a		November 1, 1988
#				TESample.r			November 1, 1988
#				TESample.h			November 1, 1988
#				[P]TESample.make	November 1, 1988
#				[C]TESample.make	November 1, 1988
#
#	TESample is an example application that demonstrates how 
#	to initialize the commonly used toolbox managers, operate 
#	successfully under MultiFinder, handle desk accessories and 
#	create, grow, and zoom windows. The fundamental TextEdit 
#	toolbox calls and TextEdit autoscroll are demonstrated. It 
#	also shows how to create and maintain scrollbar controls.
#
#	It does not by any means demonstrate all the techniques you 
#	need for a large application. In particular, Sample does not 
#	cover exception handling, multiple windows/documents, 
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
#	We recommend that you review this program or Sample before 
#	beginning a new application. Sample is a simple app. which doesn’t 
#	use TextEdit or the Control Manager.
#


# MPW 3.0 and later: We override the default COptions to turn on strict prototyping;
#	add '-r' to your UserStartup when you tire of the warning from Make.
# If you are using MPW 3.0 or later, uncomment the following line:
COptions = -d MPW3 -r	# define MPW3, turn on strict prototyping (-r option)

CObjs	=	TESample.c.o ∂
			TESampleGlue.a.o ∂
			"{CLibraries}"CRuntime.o ∂
			"{CLibraries}"CInterface.o ∂
			"{Libraries}"Interface.o

TESample		ƒƒ {CObjs} TESample.make
		Link -o {Targ} {CObjs}
		SetFile {Targ} -t APPL -c 'MOOT' -a B

TESample		ƒƒ TESample.r TESample.h TESample.make
		Rez -rd -append -o {Targ} TESample.r

TESample.c.o	ƒƒ TESample.c TESample.make
