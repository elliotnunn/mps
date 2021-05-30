#	File MakeFile.c -  Make instructions for C examples.
#
#	Copyright Apple Computer, Inc. 1986
#	All rights reserved.
#
#	This makefile builds:
#		The sample C application:		Sample
#		The sample C tool:				Count
#		The sample desk accessory:		Memory
#


Sample			ƒƒ	Sample.r
	Rez Sample.r -o Sample
Sample			ƒƒ	Sample.r Sample.c.o
	Link Sample.c.o ∂
		"{CLibraries}"CRuntime.o ∂
		"{CLibraries}"CInterface.o ∂
		-o Sample
Sample.c.o		ƒ	Sample.c
	C Sample.c



Count			ƒ	Count.c.o Stubs.c.o
	Link -w -c "MPS " -t "MPST" Count.c.o Stubs.c.o ∂
		-sn STDIO=Main ∂
		-sn INTENV=Main ∂
		-sn %A5Init=Main ∂
		"{CLibraries}"CRuntime.o ∂
		"{CLibraries}"StdCLib.o ∂
		"{CLibraries}"CSANELib.o ∂
		"{CLibraries}"CInterface.o ∂
		"{Libraries}"ToolLibs.o ∂
		-o Count
Count.c.o		ƒ	Count.c
	C Count.c
Stubs.c.o		ƒ	Stubs.c
	C Stubs.c



Memory			ƒ	Memory.DRVW Memory.r
	Rez -rd -c DMOV -t DFIL Memory.r -o Memory
Memory.DRVW 	ƒ	Memory.c.o
	Link -w -rt DRVW=0 ∂
		-sn Main=Memory ∂
		"{Libraries}"DRVRRuntime.o	# This must preceed CRuntime.o ∂
		Memory.c.o ∂
		"{CLibraries}"CRuntime.o ∂
		"{CLibraries}"CInterface.o ∂
		-o Memory.DRVW	
Memory.c.o		ƒ	Memory.c
	C Memory.c
