#------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	TApplication
#
#	This file: TApplication.make	-	Make source
#
#	Copyright © 1988-1994 Apple Computer, Inc.
#	All rights reserved.
#
#
#   There are four main classes in this program. Each of
#   these classes has a definition (.h) file and an
#   implementation (.cp) file.  
#   
#   The TApplication class does all of the basic event
#   handling and initialization necessary for Mac Toolbox
#   applications. It maintains a list of TDocument objects,
#   and passes events to the correct TDocument class when
#   apropriate. 
#   
#   The TDocument class does all of the basic document
#   handling work. TDocuments are objects that are
#   associated with a window. Methods are provided to deal
#   with update, activate, mouse-click, key down, and other
#   events. Some additional classes which implement a
#   linked list of TDocument objects are provided. 
#   
#   The TApplication and TDocument classes together define
#   a basic framework for Mac applications, without having
#   any specific knowledge about the type of data being
#   displayed by the application's documents. They are a
#   (very) crude implementation of the MacApp application
#   model, without the sophisticated view heirarchies or
#   any real error handling. 
#   
#------------------------------------------------------------------------------



### added 2 new defines to avoid conflict with MacApp variables   920225 rjd

CPlusExampleIncludes 	=	{MPW}Examples:CPlusExamples:CPlusIncludes:
CPlusExampleLibraries 	=	{MPW}Examples:CPlusExamples:CPlusLibraries:


Make			=	TApplication.o.make

LocalHeaders	=	TApplication.h
					
DistantHeader1	=	{CPlusExampleIncludes}TDocument.h

DistantHeader2	=	{CPlusExampleIncludes}TApplicationCommon.h
					
LocalSources	=	TApplication.cp
	
Resources		=	TApplication.r

Compilation		=	TApplication.cp.o

Library			=	TApplication.o

# turn on/off SADE symbols
SymOpts = -sym off

# C++ options
CPlusOptions = -mf {SymOpts} -d OBSOLETE

{Compilation} ƒƒ {Make} {LocalHeaders} "{DistantHeader1}" "{DistantHeader2}" {LocalSources}   
	CPlus {CPlusOptions} {LocalSources} -o {Compilation} -i "{CPlusExampleIncludes}"

# Include the resources
{Compilation} ƒƒ {Make} {LocalHeaders} "{DistantHeader1}" "{DistantHeader2}" {LocalSources} {Resources} 
	Rez -append -o {Compilation} {Resources} -i "{CPlusExampleIncludes}"

# Save the compilation into its library
{Library} ƒƒ {Make} {Compilation} 
	Lib -o "{CPlusExampleLibraries}{Library}" {SymOpts} {Compilation}
