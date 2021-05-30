#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	TESample
#
#	[P]TESample.make	-	Make Source
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

PObjs	=	TESample.p.o ∂
			TESampleGlue.a.o ∂
			"{Libraries}"Runtime.o ∂
			"{Libraries}"Interface.o ∂
			"{PLibraries}"PasLib.o

TESample		ƒƒ {PObjs} TESample.make
			Link -o {Targ} {PObjs}
			SetFile {Targ} -t APPL -c 'MOOT' -a B

TESample		ƒƒ TESample.r TESample.h TESample.make
			Rez -rd -append -o {Targ} TESample.r

TESample.p.o	ƒƒ TESample.p TESample.make
