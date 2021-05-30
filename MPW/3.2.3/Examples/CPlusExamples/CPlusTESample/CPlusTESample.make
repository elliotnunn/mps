#------------------------------------------------------------------------------
#
#	Öner M. Biçakçi
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	CPlusTESample
#
#	This file: CPlusTESample.make	-	Make source
#
#	Copyright © 1989-1991  Apple Computer, Inc.
#	All rights reserved.
#
#
#   There are four main classes in this program. Each of
#   these classes has a definition (.h) file and an
#   implementation (.cp) file.  
#   
#   The MasterApp class does all of the basic event
#   handling and initialization necessary for Mac Toolbox
#   applications. It maintains a list of MasterDoc objects,
#   and passes events to the correct MasterDoc class when
#   apropriate. 
#   
#   The MasterDoc class does all of the basic document
#   handling work. MasterDocs are objects that are
#   associated with a window. Methods are provided to deal
#   with update, activate, mouse-click, key down, and other
#   events. Some additional classes which implement a
#   linked list of MasterDoc objects are provided. 
#   
#   The MasterApp and MasterDoc classes together define
#   a basic framework for Mac applications, without having
#   any specific knowledge about the type of data being
#   displayed by the application's documents. They are a
#   (very) crude implementation of the MacApp application
#   model, without the sophisticated view heirarchies or
#   any real error handling. 
#   
#------------------------------------------------------------------------------



Make 			=	CPlusTESample.make

LocalHeaders	=	TESample.h

DistantHeaders	=	"{CPlusIncludes}"TApplicationCommon.h	∂
					"{CPlusIncludes}"TApplication.h 		∂
					"{CPlusIncludes}"TDocument.h			∂
					"{CPlusIncludes}"TEDocument.h			∂
					"{CPlusIncludes}"TECommon.h

Objects 		=	TESample.cp.o 

Sources			=	TESample.cp 

Resources		=	TESample.r

Result			=	CPlusTESample

# turn on SADE symbols
SymOpts = -sym on

# C++ options
CPlusOptions = -mf {SymOpts} -i "{CPlusIncludes}"

{Result} ƒƒ {Make} {Objects}
	Link -d -o {Targ} {SymOpts} 			∂
		{Objects} 							∂
		"{Libraries}"Runtime.o 				∂
		"{Libraries}"Interface.o 			∂
		"{CLibraries}"CPluslib.o 			∂
		"{CLibraries}"StdCLib.o				∂
		"{CPlusLibraries}"TApplication.o	∂
		"{CPlusLibraries}"TDocument.o		∂
		"{CPlusLibraries}"TEDocument.o
	SetFile {Targ} -t APPL -c 'MOOT' -a B

# if any of the local resources or headers change, re-rez the local resource file(s)
{Result} ƒƒ {Make} {Resources} {LocalHeaders}
	Rez -append -i "{CPlusIncludes}" -o {Targ} {Resources}

# if ANY headers change, recompile everything
{Objects} ƒƒ {Make} {LocalHeaders} {DistantHeaders} {Sources}
