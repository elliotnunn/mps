#
#	File:		InlineInputSample.make
#
#	Contains:	make file for InlineInputSample variants
#
#	Copyright:	© 1989, 1993 Apple Computer, Inc. All rights reserved.
#

#	Build Information
#	-----------------
#	InlineInputSample uses the universal interfaces which are now
#	part of the MPW development system.
#
#	This makefile lets you build the application in three versions:
#		- 68K, which runs native on 68K Macs and emulated on Power Macs
#		- PPC, which runs native on Power Macs
#		- Fat, which runs native on either platform
#	You can execute
#		Make -f InlineInputSample.make All
#	to get the build commands for all three versions.
		

Obj = :Objects:

SymOpt = off
PPCCOpt = off

GenericObjs68K = ∂
			{Obj}InlineInputSample.a.o ∂
			"{Libraries}"Runtime.o ∂
			"{Libraries}"Interface.o

GenericObjsPPC = ∂
			"{PPCLibraries}"StdCLib.xcoff ∂
			"{PPCLibraries}"MathLib.xcoff ∂
			"{PPCLibraries}"StdCRuntime.o ∂
			"{PPCLibraries}"PPCCRuntime.o ∂
			"{PPCLibraries}"InterfaceLib.xcoff

LibEquates = -l InterfaceLib.xcoff=InterfaceLib -l StdCLib.xcoff=StdCLib -l MathLib.xcoff=MathLib


.68KCode ƒ .c.o
	Link -o {targDir}{default}.68KCode {depDir}{default}.c.o {GenericObjs68K}

{Obj}InlineInputSample.68KCode ƒ {Obj}InlineInputSample.a.o

.PPCCode ƒ .o
	PPCLink -o {targDir}{default}.xcoff {depDir}{default}.o {GenericObjsPPC}
	MakePef -o {targDir}{default}.PPCCode {depDir}{default}.xcoff {LibEquates}

{Obj} ƒ {Obj}


All ƒ	InlineInputSample.68K ∂
		InlineInputSample.PPC ∂
		InlineInputSample.Fat

InlineInputSample.68K ƒ {Obj}InlineInputSample.68KCode InlineInputSample.r InlineInputSample.h
	Duplicate -r -y {Obj}InlineInputSample.68KCode {Targ}
	Rez -d qAppleEvents=1 -d qInline=1 -d qPowerPC=0 -rd -append -o {Targ} InlineInputSample.r
	SetFile {Targ} -t APPL -c 'issa' -a Bi

InlineInputSample.PPC ƒ {Obj}InlineInputSample.PPCCode InlineInputSample.r InlineInputSample.h
	Duplicate -d -y {Obj}InlineInputSample.PPCCode {Targ}
	Rez -d qAppleEvents=1 -d qInline=1 -d qPowerPC=1 -rd -append -o {Targ} InlineInputSample.r
	SetFile {Targ} -t APPL -c 'issa' -a Bi

InlineInputSample.Fat ƒ {Obj}InlineInputSample.68KCode {Obj}InlineInputSample.PPCCode InlineInputSample.r InlineInputSample.h
	Duplicate -d -y {Obj}InlineInputSample.PPCCode {Targ}
	Duplicate -r -y {Obj}InlineInputSample.68KCode {Targ}
	Rez -d qAppleEvents=1 -d qInline=1 -d qPowerPC=1 -rd -append -o {Targ} InlineInputSample.r
	SetFile {Targ} -t APPL -c 'issa' -a Bi


{Obj}InlineInputSample.c.o ƒƒ InlineInputSample.c InlineInputSample.h
	C -d qAppleEvents=1 -d qInline=1 -r InlineInputSample.c -o {targ}

#	turn off optimization for inline input version, optimization doesn't work correctly in all cases yet

{Obj}InlineInputSample.o ƒ InlineInputSample.c InlineInputSample.h
	PPCC -sym {SymOpt} -opt {PPCCOpt} -d qAppleEvents=1 -d qInline=1 -appleext on InlineInputSample.c -o {targ}

{Obj}InlineInputSample.a.o ƒ InlineInputSample.a
	Asm InlineInputSample.a -o {Obj}InlineInputSample.a.o