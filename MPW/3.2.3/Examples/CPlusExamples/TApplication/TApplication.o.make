#------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	TApplication
#
#	This file: TApplication.make	-	Make source
#
#	Copyright © 1988-1991 Apple Computer, Inc.
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

Make			=	TApplication.o.make

LocalHeaders	=	TApplication.h

DistantHeaders	=	"{CPlusIncludes}"TDocument.h			∂
					"{CPlusIncludes}"TApplicationCommon.h
					
LocalSources	=	TApplication.cp
	
Resources		=	TApplication.r

Compilation		=	TApplication.cp.o

Library			=	TApplication.o

# turn on/off SADE symbols
SymOpts = -sym off

# C++ options
CPlusOptions = -mf {SymOpts} -i "{CPlusIncludes}"

{Compilation} ƒƒ {Make} {LocalHeaders} {DistantHeaders} {LocalSources}   
	CPlus {LocalSources} -o {Compilation} -i "{CPlusIncludes}"

# Include the resources
{Compilation} ƒƒ {Make} {LocalHeaders} {DistantHeaders} {LocalSources} {Resources} 
	Rez -append -o {targ} {Resources} -i "{CPlusIncludes}"

# Save the compilation into its library
{Library} ƒƒ {Make} {Compilation} 
	Lib -o {Targ} {SymOpts} {Compilation}
