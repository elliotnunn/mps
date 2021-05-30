#   File:       AsmSample.make
#   Target:     AsmSample
#   Sources:    asm.s
#               AsmSample.c
#               AsmSample.r
#   Created:    Wednesday, October 13, 1993 05:20:00 PM
#	Modified:	Tuesday, November 15, 1994
#  By default, builds the sample program without debugging info.
#  To build with debug info:
#     make -e -f AsmSample.make -d SymOpt=on
#

AppName = AsmSample
MakeFile = {AppName}.make

OBJECTS = ∂
		asm.s.o ∂
		{AppName}.c.o 
		
PPC_LIBS = 	"{SharedLibraries}"InterfaceLib ∂
			"{SharedLibraries}"MathLib ∂
			"{SharedLibraries}"StdCLib ∂
			"{PPCLibraries}"StdCRuntime.o ∂
			"{PPCLibraries}"PPCCRuntime.o

PPCCOpt = off
SymOpt 	= off

#------------------------------------------------------------------------

.s.o ƒ .s {Makefile}
	PPCAsm -sym {SymOpt} -o asm.s.o asm.s 

.c.o ƒ .c {Makefile}
	MrC -sym {SymOpt} -opt {PPCCOpt} {default}.c -o {Targ}

#------------------------------------------------------------------------
		
{AppName}  ƒƒ  {AppName}.r
	Rez  {AppName}.r -append -o {Targ}
	
{AppName} ƒƒ {OBJECTS}
	PPCLink {OBJECTS} ∂
		{PPC_LIBS} ∂
		-sym {SymOpt} ∂
		-o {Targ}
