#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Sample Application
#
#	Sample
#
#	[A]Sample.make	-	Make Source
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
#				[A]Sample.make		November 1, 1988
#				[C]Sample.make		November 1, 1988
#				[P]Sample.make		November 1, 1988
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
# cause all source file to be assembled if the ASample.inc1.a is updated.

AObjs			= Sample.a.o ∂
					SampleMisc.a.o ∂
					"{Libraries}"Runtime.o ∂
					"{Libraries}"Interface.o

Sample.a.o		ƒ Sample.make Sample.a Sample.inc1.a
					Asm Sample.a -w

SampleMisc.a.o	ƒ Sample.make SampleMisc.a Sample.inc1.a
					Asm SampleMisc.a -w

Sample			ƒƒ {AObjs} Sample.make
					Link -o {Targ} {AObjs}
					SetFile {Targ} -t APPL -c 'MOOS' -a B

Sample			ƒƒ Sample.r Sample.h Sample.make
					Rez -rd -o {Targ} Sample.r -append
