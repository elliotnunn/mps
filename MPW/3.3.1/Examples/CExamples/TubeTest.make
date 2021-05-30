#
#	Macintosh Developer Technical Support
#
#	Simple Color QuickDraw Animation Sample Application
#
#	TubeTest
#
#	TubeTest.make	-	Make Source
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0					8/88
#				1.01				4/91	Updated for MPW 3.2
#
#	Components:	TubeTest.p			August 1, 1988
#				TubeTest.c			August 1, 1988
#				TubeTest.r			August 1, 1988
#				PTubeTest.make		August 1, 1988
#				CTubeTest.make		August 1, 1988
#
#	The TubeTest program is a simple demonstration of how to use the Palette 
#	Manager in a color program.  It has a special color palette that is associated
#	with the main window.  The colors are animated using the Palette Manager 
#	to give a flowing tube effect.  The program is very simple, and the Palette
#	Manager and drawing parts are put in separate subroutines to make it easier
#	to figure out what is happening.
#	
#	The program is still a complete Macintosh application with a Main Event Loop,
#	so there is the extra code to run the MEL.  
#	
#	There is a resource file that is necessary as well, to define the Menus, Window,
#	Dialog, and Palette resources used in the program.  
#
#	See Sample and TESample for the general structure and MultiFinder techniques that
#	we recommend that you use when building a new application.
#
# MPW 3.0 and later: We override the default COptions to turn on strict prototyping;
#	add '-r' to your UserStartup when you tire of the warning from Make.
# If you are using MPW 3.0 or later, uncomment the following line:
#COptions = -r
# For MPW 2.0 we use the following line so that the the complete interfaces are there:
COptions = -d __ALLNU__

CObjs			=	TubeTest.c.o ∂
					"{Libraries}"Interface.o ∂
					"{Libraries}"Runtime.o 

TubeTest		ƒƒ	{CObjs} TubeTest.make
		Link -o {Targ} {CObjs}
		SetFile {Targ} -t APPL -c '????'

TubeTest		ƒƒ	TubeTest.r TubeTest.make
		Rez -rd -o {Targ} TubeTest.r -append
