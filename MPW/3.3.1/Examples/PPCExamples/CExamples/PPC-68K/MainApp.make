#   File:       MainApp.make
#   Target:     MainApp
#   Sources:    MainApp.r
#               MainApp.c
#   Created:    Friday, November 5, 1993 12:33:06 PM

# Usage:
#	BuildProgram MainApp

SymOpt = off
PPCCOpt = off

# Make our application

MainApp  ƒƒ MainApp.r Wrapper.rsrc
	Rez MainApp.r -append -o MainApp

MainApp ƒƒ  MainApp.o
	PPCLink  -sym on ∂
		MainApp.o ∂
		"{PPCLibraries}"InterfaceLib.xcoff ∂
		"{PPCLibraries}"StdCLib.xcoff ∂
		"{PPCLibraries}"StdCRuntime.o ∂
		"{PPCLibraries}"PPCCRuntime.o ∂
		-export gCodePointers ∂
		-o MainApp.xcoff
	makePEF MainApp.xcoff -o MainApp ∂
		-l InterfaceLib.xcoff=InterfaceLib ∂
		-l MathLib.xcoff=MathLib ∂
		-l StdCLib.xcoff=StdCLib ∂
		-ft APPL -fc '????'
	MakeSYM MainApp.xcoff -o MainApp.xSYM

MainApp.o ƒ MainApp.make MainApp.c
	 PPCC -w conformance -appleext on -shared_lib_export on -sym {SymOpt} -opt {PPCCOpt} MainApp.c -o MainApp.o


# Make our wrapper routine

Wrapper.rsrc ƒƒ  Wrapper.c.o Library.o
	Link -t 'rsrc' -c 'RSED' -rt WRAP=128 -m WRAPPER -sg Wrapper ∂
		Wrapper.c.o Library.o ∂
 		"{Libraries}"Interface.o ∂
		-o Wrapper.rsrc

Wrapper.c.o ƒ Wrapper.c
	 C -r Wrapper.c


# Make our library

Library.o ƒ Library.c.o
	Lib Library.c.o -o Library.o

Library.c.o ƒ Library.c
	C -r Library.c

