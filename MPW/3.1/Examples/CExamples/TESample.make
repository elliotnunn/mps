#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	TESample
#
#	[C]TESample.make	-	Make Source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
#				1.00				08/88
#				1.01				11/88
#				1.02				04/89	MPW 3.1
#
#	Components:
#				TESample.p			April 1, 1989
#				TESample.c			April 1, 1989
#				TESampleGlue.a		April 1, 1989
#				TESample.r			April 1, 1989
#				TESample.h			April 1, 1989
#				[P]TESample.make	April 1, 1989
#				[C]TESample.make	April 1, 1989
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
# 	You can define {SymOptions} as "-sym on" or "-sym off" for use with SADE
# 	We also recommend requiring prototypes for all functions
COptions = -r {SymOptions}

CObjs	=	TESample.c.o ∂
			TESampleGlue.a.o ∂
			"{CLibraries}"CRuntime.o ∂
			"{CLibraries}"CInterface.o ∂
			"{Libraries}"Interface.o

TESample		ƒƒ {CObjs} TESample.make
		Link -o {Targ} {CObjs} {SymOptions}
		SetFile {Targ} -t APPL -c 'MOOT' -a B

TESample		ƒƒ TESample.r TESample.h TESample.make
		Rez -rd -append -o {Targ} TESample.r

TESample.c.o	ƒƒ TESample.c TESample.make
