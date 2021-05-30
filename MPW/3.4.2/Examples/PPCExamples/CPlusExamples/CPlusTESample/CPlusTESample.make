#------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	CPlusTESample
#
#	This file: CPlusTESample.make	-	Make source
#
#	Copyright © 1989-1995  Apple Computer, Inc.
#	All rights reserved.
#
#------------------------------------------------------------------------------


### added 2 new defines to avoid conflict with MacApp variables        920225 rjd
### altered makefile to work with Macintosh on RISC SDK                930629 jma
### Altered makefile to build 68K, Power Mac and FAT versions. 		   940112 fpf
### Corrected minor nits in build process							   950109 gab

#------------------------------------------------------------------------------

AppName	=		CPlusTESample
Creator =		'????'
Type	=		'APPL'

SymOpt = off    
PPCCOptimize = local

Source_Folder = :

68K_Object_Folder = :68KObjects:

PPC_Object_Folder = :PPCObjects:

{68K_Object_Folder} ƒ {Source_Folder}

{PPC_Object_Folder} ƒ {Source_Folder}

PPC_Objects = 	{PPC_Object_Folder}TESample.cp.ppc.o ∂
				{PPC_Object_Folder}TApplication.cp.ppc.o ∂
				{PPC_Object_Folder}TDocument.cp.ppc.o ∂
				{PPC_Object_Folder}TEDocument.cp.ppc.o
				
68K_Objects = 	{68K_Object_Folder}TESample.cp.68k.o ∂
				{68K_Object_Folder}TApplication.cp.68k.o ∂
				{68K_Object_Folder}TDocument.cp.68k.o ∂
				{68K_Object_Folder}TEDocument.cp.68k.o ∂
				{68K_Object_Folder}TESampleGlue.a.68k.o  # In assembler on 68K,
				                                         # in C for Power Mac.

PPCC_Options = 	-sym {SymOpt} -opt {PPCCOptimize} -D OLDROUTINELOCATIONS=0

CPlus_Options = -sym {SymOpt} -D OLDROUTINELOCATIONS=0  # Use universal headers for 68K build.

PPC_Libraries =	"{SharedLibraries}"InterfaceLib	∂
				"{SharedLibraries}"MathLib		∂
				"{SharedLibraries}"StdCLib		∂
				"{PPCLibraries}"StdCRuntime.o	∂
				"{PPCLibraries}"PPCCRuntime.o	∂
				"{PPCLibraries}"MrCPlusLib.o
				
68K_Libraries = "{CLibraries}"CPlusLib.o ∂
				"{CLibraries}"StdCLib.o  ∂
 				"{Libraries}"MacRuntime.o   ∂
 				"{Libraries}"Interface.o 
					
68K_Resources =	TESample.r

PPC_Resources = {68K_Resources} PPCApp.r

Headers	=		TESample.h 				∂
				TApplicationCommon.h	∂
				TApplication.h 			∂
				TDocument.h				∂
				TEDocument.h			∂
				TECommon.h
					
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
	# Duplicate the Power Mac code into the fat binary package.
	duplicate -y {AppName}.ppc {Targ}
	# rez in 'CODE' resources from 68K version.  (Brute force method).
	Echo "include ∂"{AppName}.68K∂" 'CODE';" | rez -a -o {Targ}

{AppName}.ppc ƒƒ {PPC_Objects}
	PPCLink -warn -main __cplusstart ∂
		{PPC_Objects}				 ∂
		{PPC_Libraries}				 ∂
		-sym {SymOpt}				 ∂
		-o {Targ}
	SetFile {AppName}.ppc -t {Type} -c {Creator} -a Bi 
	rez -append -o {Targ} {PPC_Resources}		

{AppName}.68K ƒƒ {68K_Objects}
	Link -d -t {Type} -c {Creator} ∂
		{68K_Objects} 			∂
		{68K_Libraries}		    ∂
		-o {Targ}
	rez -append -o {Targ} {68K_Resources}
	setfile -a Bi {Targ}   # Make the system aware that we have a BNDL resource.

#------------------------------------------------------------------------------
#  Low level dependencies.

TApplication.cp.68k.o ƒƒ TApplication.cp TApplication.h TApplicationCommon.h

TDocument.cp.68k.o 	ƒƒ TDocument.cp    TDocument.h

TEDocument.cp.68k.o	ƒƒ TEDocument.cp   TEDocument.h

TESample.cp.68k.o 	ƒƒ TESample.cp     {Headers}


TApplication.cp.ppc.o ƒƒ TApplication.cp TApplication.h TApplicationCommon.h

TDocument.cp.ppc.o 	ƒƒ TDocument.cp    TDocument.h

TEDocument.cp.ppc.o	ƒƒ TEDocument.cp   TEDocument.h

TESample.cp.ppc.o 	ƒƒ TESample.cp     {Headers}

