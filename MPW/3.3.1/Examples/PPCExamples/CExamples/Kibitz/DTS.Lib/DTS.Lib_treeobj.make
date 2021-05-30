#------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	Program:	DTS.Lib_treeobj
#	File:		DTS.Lib_treeobj.make
#
#	Copyright © 1988-1994 Apple Computer, Inc.
#	All rights reserved.
#
#------------------------------------------------------------------------------

#	The three possible targets for this makefile
#	The default name is LibName and builds the 68K library
#	Power Macintosh library is named .PPC and is built with:
#		make -f DTS.Lib_treeobj.make DTS.Lib_treeobj.PPC
#	The "Fat" version isn't actually fat, it just builds both 68K and 
#	Power Macintosh versions.  Build it with:
#		make -f DTS.Lib_treeobj.make DTS.Lib_treeobj.FAT
LibName			=	'DTS.Lib_treeobj'
LibNamePPC		=	'DTS.Lib_treeobj.PPC'
LibNameFAT		=	'DTS.Lib_treeobj.FAT'

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
# MPW C (68K) and PPCC (Power Macintosh) from the same set of sources
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
					{obj}TreeObj.c.o ∂
					{obj}TUndoObj.c.o ∂
					{obj}TUndoPartObj.c.o ∂
					{obj}TUndoTaskObj.c.o ∂
					{obj}ViewHierarchy.c.o

LibObjectsPPC	=	∂
					{objppc}TreeObj.o ∂
					{objppc}TUndoObj.o ∂
					{objppc}TUndoPartObj.o ∂
					{objppc}TUndoTaskObj.o ∂
					{objppc}ViewHierarchy.o

{LibNameFAT}		ƒ {LibName} {LibNamePPC}

{LibName}			ƒƒ {LibObjects}
	Lib {LibObjects} {LibOptions} -o {Targ}

{LibNamePPC}		ƒƒ {LibObjectsPPC}
	PPCLink	{LibObjectsPPC} {LibOptionsPPC}	-o {Targ}

