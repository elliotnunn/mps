#
#   cplus_sample.make
#
#	MPW makefile for sample C++ program
#
#	Copyright © 1994, Apple Computer, Inc.  All rights reserved.
#
AppName = cplus_sample
Creator = '????'
Type	= 'APPL'

SymOpt 	= off    # Set to "on" to build a debug version.
PPCCOpt = off

Source_Folder = :

68K_Object_Folder = :68KObjects:

PPC_Object_Folder = :PPCObjects:

{68K_Object_Folder} ƒ {Source_Folder}

{PPC_Object_Folder} ƒ {Source_Folder}

Sources = cplus_sample1.cp ∂
		  cplus_sample2.cp
		  
Headers = cplus_sample.h

Resources = {AppName}.r

PPC_Objects = 	{PPC_Object_Folder}cplus_sample1.cp.ppc.o ∂
				{PPC_Object_Folder}cplus_sample2.cp.ppc.o
				
68K_Objects = 	{68K_Object_Folder}cplus_sample1.cp.68k.o ∂
				{68K_Object_Folder}cplus_sample2.cp.68k.o
				
PPCC_Options = 	-sym {SymOpt} -opt {PPCCOPt}

CPlus_Options = -sym {SymOpt}  # Use universal headers for 68K build.

PPC_Libraries =	"{SharedLibraries}"InterfaceLib	∂
				"{SharedLibraries}"StdCLib		∂
				"{SharedLibraries}"MathLib		∂
				"{PPCLibraries}"StdCRuntime.o	∂
				"{PPCLibraries}"PPCCRuntime.o	∂
				"{PPCLibraries}"MrCPlusLib.o
				
68K_Libraries = "{CLibraries}"StdCLib.o  ∂
 				"{Libraries}"MacRuntime.o   ∂
 				"{Libraries}"Interface.o 
										
Makefile =		{AppName}.make

C =				SC

CPlus =			SCpp  # Note that not everyone has a 68K C++ compiler

PPCC = 			MrCpp

#------------------------------------------------------------------------------
		
.cp.ppc.o	ƒ	.cp {Makefile}        # Whenever the Makefile changes, all .o's get built.
	{PPCC} {PPCC_Options} {default}.cp -o {Targ}
	
.cp.68k.o	ƒ	.cp {Makefile}        # Whenever the Makefile changes, all .o's get built.
	{CPlus} {CPlus_Options} {default}.cp -o {Targ}
	
.a.68k.o	ƒ	.a {Makefile}         # Whenever the Makefile changes, all .o's get built.
	{Asm} {default}.a -o {Targ}
	
#------------------------------------------------------------------------------
		
{AppName}	ƒ {AppName}.ppc {AppName}.68K
	
	# Duplicate the PowerPC code into the fat binary package.
	
	duplicate -y {AppName}.ppc {Targ}
	
	# rez in 'CODE' resources from 68K version.  (Brute force method).
	
	derez {AppName}.68K -only CODE | rez -a -o {Targ}
	
{AppName}.ppc ƒƒ {PPC_Objects} {Resources}
	PPCLink -warn -main __cplusstart ∂
		{PPC_Objects}				 ∂
		{PPC_Libraries}				 ∂
		-sym {SymOpt}				 ∂
		-o {Targ}
	rez -append -o {Targ} -d PowerPC {Resources}
	SetFile {AppName}.ppc -a Bi 

{AppName}.68K ƒƒ {68K_Objects} {Resources}
	Link -d -t {Type} -c {Creator} ∂
		{68K_Objects} 			∂
		{68K_Libraries}		    ∂
	    -sym {SymOpt}			∂
		-o {Targ}
	rez -append -o {Targ} {Resources}
	setfile -a Bi {Targ}   # Make the system aware that we have a BNDL resource.

