#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Sample Application
#
#	Sample
#
#	[A]Sample.make	-	Make Source
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
#				Sample.p			April 1, 1989
#				Sample.c			April 1, 1989
#				Sample.a			April 1, 1989
#				Sample.inc1.a		April 1, 1989
#				SampleMisc.a		April 1, 1989
#				Sample.r			April 1, 1989
#				Sample.h			April 1, 1989
#				[P]Sample.make		April 1, 1989
#				[C]Sample.make		April 1, 1989
#				[A]Sample.make		April 1, 1989
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

#    NOTE: The Asm has warnings turned off here.  This is because the
#    Macro "Case#" builds a list of BEQ instructions that could be
#    optimized into BEQ.S.  Everyone of these causes a warning
#    message to appear while building this sample.  With warnings
#    turned off, they don't appear.  Code generation is NOT effected.

# If ANY changes are made to the include file, you MUST perform
# a full build of ALL source files.  The dependencies below will
# cause all source file to be assembled if the Sample.inc1.a is updated.

AOptions		= -w

AObjs			= Sample.a.o ∂
					SampleMisc.a.o ∂
					"{Libraries}"Runtime.o ∂
					"{Libraries}"Interface.o

Sample.a.o		ƒƒ Sample.make Sample.inc1.a

SampleMisc.a.o	ƒƒ Sample.make Sample.inc1.a

Sample			ƒƒ {AObjs} Sample.make
					Link -o {Targ} {AObjs}
					SetFile {Targ} -t APPL -c 'MOOS' -a B

Sample			ƒƒ Sample.r Sample.h Sample.make
					Rez -rd -o {Targ} Sample.r -append
