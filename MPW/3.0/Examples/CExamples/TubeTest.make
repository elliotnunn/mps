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
#	Versions:	1.1	(MPW 3.0 Final)	8/88
#
#	Components:	TubeTest.p			August 8, 1988
#				TubeTest.c			August 8, 1988
#				TubeTest.r			August 8, 1988
#				(P)TubeTest.make	August 8, 1988
#				(C)TubeTest.make	August 8, 1988
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
# For MPW 3.0 we override the default COptions to turn on strict prototyping;
#	add '-r' to your UserStartup when you tire of the warning from Make.
COptions = -r

Objs			=	TubeTest.c.o ∂
					"{Libraries}"Interface.o ∂
					"{CLibraries}"CRuntime.o ∂
					"{CLibraries}"CInterface.o

TubeTest	ƒƒ	TubeTest.r TubeTest.make
				Rez TubeTest.r -append -o {Targ}

TubeTest	ƒƒ	{Objs} TubeTest.make
				Link -o {Targ} {Objs}
				SetFile {Targ} -t APPL -c '????'
