#	File Count.make -  Make instructions for C++ example MPW Shell tool: Count.
#
#	Copyright Apple Computer, Inc. 1986-1988
#	All rights reserved.
#
#
# We need this rule since it is not built into MPW 3.0 Make
.cp.o	ƒ	.cp
	CPlus {depDir}{default}.cp -o {targDir}{default}.cp.o {CPlusOptions}

ObjectFiles	=	"{Libraries}"Stubs.o ∂
				"{Libraries}"Runtime.o ∂
				"{Libraries}"Interface.o ∂
				"{CLibraries}"CPluslib.o ∂
				"{CLibraries}"StdCLib.o ∂
				"{Libraries}"ToolLibs.o ∂
				Count.cp.o ∂
				StreamCounter.cp.o

default			ƒ	Count

Count.cp.o		ƒ	Count.cp StreamCounter.h

StreamCounter.cp.o	ƒ	StreamCounter.cp StreamCounter.h 

Count			ƒ	{ObjectFiles}
	Link -d -t MPST -c 'MPS ' {ObjectFiles} -o Count			
	