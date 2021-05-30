#	MakeFile.p	-  Make instructions for Pascal examples.
#
#	Copyright Apple Computer, Inc. 1986
#	All rights reserved.
#
#	This makefile builds:
#		The sample Pascal application:	Sample
#		The sample Pascal tool: 		ResEqual
#		The sample desk accessory:		Memory
#		The sample Resource Editor: 	ResXXXX
#


Sample			ƒƒ	Sample.r
	Rez Sample.r -o Sample
Sample			ƒƒ	Sample.r Sample.p.o
	Link Sample.p.o ∂
		"{Libraries}"Interface.o ∂
		"{Libraries}"Runtime.o ∂
		"{PLibraries}"Paslib.o ∂
		-o Sample
Sample.p.o		ƒ	Sample.p
	Pascal Sample.p



ResEqual		ƒ	ResEqual.p.o Stubs.a.o
	Link -w -c "MPS " -t "MPST" ResEqual.p.o Stubs.a.o ∂
		-sn STDIO=Main ∂
		-sn INTENV=Main ∂
		-sn %A5Init=Main ∂
		"{Libraries}"Interface.o ∂
		"{Libraries}"Runtime.o ∂
		"{Libraries}"ToolLibs.o ∂
		"{PLibraries}"Paslib.o ∂
		-o ResEqual
ResEqual.p.o	ƒ	ResEqual.p
	Pascal ResEqual.p
Stubs.a.o		ƒ	Stubs.a
	Asm Stubs.a



Memory			ƒ	Memory.DRVW Memory.r
	Rez -rd -c DMOV -t DFIL Memory.r -o Memory
Memory.DRVW 	ƒ	Memory.p.o
	Link -w -rt DRVW=0 ∂
		-sn "Main=Memory" ∂
		"{Libraries}"DRVRRuntime.o	# This must preceed Memory.p.o ∂
		Memory.p.o ∂
		"{Libraries}"Interface.o ∂
		"{PLibraries}"Paslib.o ∂
		-o Memory.DRVW
Memory.p.o		ƒ	Memory.p
	Pascal Memory.p



ResXXXX 		ƒ	ResXXXXEd.p.o ResEd68K.a.o
	Link -b -da -c "RSED" -t "????" -rt RSSC=160 -m STDRSC ∂
		-sn Main=@XXXX ∂
		ResEd68K.a.o ∂
		ResXXXXEd.p.o ∂
		"{Libraries}"Interface.o ∂
		-o ResXXXX
ResXXXXEd.p.o	ƒ	ResXXXXEd.p ResEd.p
	Pascal ResXXXXEd.p
ResEd68K.a.o	ƒ	ResEd68K.a
	Asm ResEd68K.a



