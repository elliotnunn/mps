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
		"{SharedLibraries}"InterfaceLib ∂
		"{SharedLibraries}"StdCLib ∂
		"{PPCLibraries}"StdCRuntime.o ∂
		"{PPCLibraries}"PPCCRuntime.o ∂
		-export gCodePointers ∂
		-o {Targ}

MainApp.o ƒ MainApp.make MainApp.c
	 MrC -w 7 -shared_lib_export on -sym {SymOpt} -opt {PPCCOpt} MainApp.c -o MainApp.o

# Make our wrapper routine

Wrapper.rsrc ƒƒ  Wrapper.c.o Library.o
	Link -t 'rsrc' -c 'RSED' -rt WRAP=128 -m WRAPPER -sg Wrapper ∂
		Wrapper.c.o Library.o ∂
 		"{Libraries}"Interface.o ∂
		"{Libraries}"MacRuntime.o ∂
		-o Wrapper.rsrc

Wrapper.c.o ƒ Wrapper.c
	 SC Wrapper.c


# Make our library

Library.o ƒ Library.c.o
	Lib Library.c.o -o Library.o

Library.c.o ƒ Library.c
	SC -proto strict Library.c

