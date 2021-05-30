#
#	File:		InlineInputSample.make
#
#	Contains:	make file for InlineInputSample variants
#
#	Copyright:	© 1989, 1993 Apple Computer, Inc. All rights reserved.
#

#	Build Information
#	-----------------
#	InlineInputSample relies on the Universal C interfaces, which support
#	compilation for both 68K and Power Mac, and has been successfully built
#	with the Universal interfaces of 11/9/93. It also needs the TSMTE.h
#	interface file which is included in this folder.
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
			"{Libraries}"MacRuntime.o ∂
			"{Libraries}"Interface.o

GenericObjsPPC = ∂
			"{SharedLibraries}"StdCLib ∂
			"{SharedLibraries}"MathLib ∂
			"{PPCLibraries}"StdCRuntime.o ∂
			"{PPCLibraries}"PPCCRuntime.o ∂
			"{SharedLibraries}"InterfaceLib



.68KCode ƒ .c.o
	Link -o {targDir}{default}.68KCode {depDir}{default}.c.o {GenericObjs68K}

{Obj}InlineInputSample.68KCode ƒ {Obj}InlineInputSample.a.o

.PPCCode ƒ .o
	PPCLink ∂
		-o {targDir}{default}.PPCCode ∂
		{depDir}{default}.o ∂
		{GenericObjsPPC}

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
	SC -d OLDROUTINELOCATIONS=0 -d qAppleEvents=1 -d qInline=1 -proto strict -w 17 InlineInputSample.c -o {targ}

#	turn off optimization for inline input version, optimization doesn't work correctly in all cases yet

{Obj}InlineInputSample.o ƒ InlineInputSample.c InlineInputSample.h
	MrC -sym {SymOpt} -opt {PPCCOpt} -d OLDROUTINELOCATIONS=0 -d qAppleEvents=1 -d qInline=1 -w 17 InlineInputSample.c -o {targ}

{Obj}InlineInputSample.a.o ƒ InlineInputSample.a
	Asm InlineInputSample.a -o {Obj}InlineInputSample.a.o