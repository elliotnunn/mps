#------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	Program:	DTS.Lib_framework
#	File:		DTS.Lib_framework.make
#
#	Copyright © 1988-1994 Apple Computer, Inc.
#	All rights reserved.
#
#------------------------------------------------------------------------------

#	The three possible targets for this makefile
#	The default name is LibName and builds the 68K library
#	PowerPC library is named .PPC and is built with:
#		make -f DTS.Lib_framework.make DTS.Lib_framework.PPC
#	The "Fat" version isn't actually fat, it just builds both 68K and 
#		PowerPC versions.  Build it with:
#		make -f DTS.Lib_framework.make DTS.Lib_framework.FAT
LibName			=	'DTS.Lib_framework'
LibNamePPC		=	'DTS.Lib_framework.PPC'
LibNameFAT		=	'DTS.Lib_framework.FAT'

DTS.Lib.hdrs    =   ":DTS.Lib.headers:"
projsrc			=	:
obj				= 	:OBJECT:
objppc			= 	:OBJECTPPC:

#	SymOptions and OptOptions are mutually exclusive.  Enable as appropriate
SymOptions		=	-sym on				# turn this on to build debug version.
COptOptions		=	#-opt on
PPCCOptOptions	=	#-opt speed

# CIncludesFolder needs to be set to your Universal Interfaces folder
CIncludesFolder	=	-i "{CIncludes}"
IncludesFolders	=	-i {DTS.Lib.hdrs}
COptions		=	{IncludesFolders} {CIncludesFolder} {SymOptions} {COptOptions} -r -mbg on
PPCCOptions		=	{IncludesFolders} {SymOptions} {PPCCOptOptions} -w conformance -appleext on
LibOptions		=	{SymOptions}
LibOptionsPPC	=	-warn -xm l {SymOptions}

#------------------------------------------------------------------------------
# These are modified default build rules.  These allow us to build using both
# MPW C (68K) and PPCC (PowerPC) from the same set of sources
#------------------------------------------------------------------------------
{obj}			ƒ	{projsrc}

.c.o			ƒ	.c
	{C} {COptions} {CAltOptions} {DepDir}{Default}.c -o {TargDir}{Default}.c.o

{objppc}		ƒ	{projsrc}

.o				ƒ	.c
	PPCC {PPCCOptions} {DepDir}{Default}.c -o {TargDir}{Default}.o

#------------------------------------------------------------------------------
# These are the objects that we want to include in the library.
#------------------------------------------------------------------------------
LibObjects		=	∂
					{obj}AEConnect.c.o ∂
					{obj}AERequired.c.o ∂
					{obj}AEWFMT.c.o ∂
					{obj}File2.c.o ∂
					{obj}Init.c.o ∂
					{obj}Print.c.o ∂
					{obj}Window2.c.o

LibObjectsPPC	=	∂
					{objppc}AEConnect.o ∂
					{objppc}AERequired.o ∂
					{objppc}AEWFMT.o ∂
					{objppc}File2.o ∂
					{objppc}Init.o ∂
					{objppc}Print.o ∂
					{objppc}Window2.o

{LibNameFAT}		ƒ {LibName} {LibNamePPC}

{LibName}			ƒƒ {LibObjects}
	Lib {LibObjects} {LibOptions} -o {Targ}

{LibNamePPC}		ƒƒ {LibObjectsPPC}
	PPCLink	{LibObjectsPPC} {LibOptionsPPC}	-o {Targ}

