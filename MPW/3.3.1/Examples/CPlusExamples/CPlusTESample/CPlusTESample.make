#------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	CPlusTESample
#
#	This file: CPlusTESample.make	-	Make source
#
#	Copyright © 1989-1994  Apple Computer, Inc.
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
#   handling work. TDocument are objects that are
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




Make 			=	CPlusTESample.make

LocalHeaders	=	TESample.h

DistantHeader1	=	{CPlusExampleIncludes}TApplicationCommon.h

DistantHeader2	=	{CPlusExampleIncludes}TApplication.h

DistantHeader3	=	{CPlusExampleIncludes}TDocument.h

DistantHeader4	=	{CPlusExampleIncludes}TEDocument.h

DistantHeader5	=	{CPlusExampleIncludes}TECommon.h

Objects 		=	TESample.cp.o 

Sources			=	TESample.cp 

Resources		=	TESample.r

Result			=	CPlusTESample

# turn on SADE symbols
SymOpts = -sym on

# C++ options
CPlusOptions = -mf {SymOpts} 

{Result} ƒƒ {Make} {Objects}
	Link -d -o {Targ} {SymOpts} 			∂
		{Objects} 							∂
		"{Libraries}"Runtime.o 				∂
		"{Libraries}"Interface.o 			∂
		"{CLibraries}"CPluslib.o 			∂
		"{CLibraries}"StdCLib.o				∂
		"{CPlusExampleLibraries}"TApplication.o		∂
		"{CPlusExampleLibraries}"TDocument.o		∂
		"{CPlusExampleLibraries}"TEDocument.o
	SetFile {Targ} -t APPL -c 'MOOT' -a B

# if any of the local resources or headers change, re-rez the local resource file(s)
{Result} ƒƒ {Make} {Resources} {LocalHeaders}
	Rez -append -i "{CPlusExampleIncludes}" -o {Targ} {Resources}

# if ANY headers change, recompile everything
{Objects} ƒƒ {Make} {LocalHeaders} "{DistantHeader1}" "{DistantHeader2}" "{DistantHeader3}" "{DistantHeader4}" "{DistantHeader5}" {Sources}
	CPlus {CPlusOptions} {Sources} -o {Objects}  -i "{CPlusExampleIncludes}"
