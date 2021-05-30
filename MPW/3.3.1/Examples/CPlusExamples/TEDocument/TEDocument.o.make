#------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	TEDocument
#
#	This file: TEDocument.cp.o.make	 -	Make source
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
#   applications. It maintains a list of TEDocument objects,
#   and passes events to the correct TEDocument class when
#   apropriate. 
#   
#   The TEDocument class does all of the basic document
#   handling work. TEDocuments are objects that are
#   associated with a window. Methods are provided to deal
#   with update, activate, mouse-click, key down, and other
#   events. Some additional classes which implement a
#   linked list of TEDocument objects are provided. 
#   
#   The TApplication and TEDocument classes together define
#   a basic framework for Mac applications, without having
#   any specific knowledge about the type of data being
#   displayed by the application's documents. They are a
#   (very) crude implementation of the MacApp application
#   model, without the sophisticated view heirarchies or
#   any real error handling. 
#   
#   The TShapesApp class is a subclass of TApplication. It
#   overrides several TApplication methods, including those
#   for handling menu commands and cursor adjustment, and
#   it does some necessary initialization.
#   
#   The TShapesDocument class is a subclass of TEDocument. This
#   class contains most of the special purpose code for
#   shape drawing. In addition to overriding several of the
#   TEDocument methods, it defines a few additional
#   methods which are used by the TShapesApp class to get
#   information on the document state.  
#
#------------------------------------------------------------------------------



### added new define to avoid conflict with MacApp variables   920225 rjd

CPlusExampleIncludes 	=	{MPW}Examples:CPlusExamples:CPlusIncludes:

CPlusExampleLibraries 	=	{MPW}Examples:CPlusExamples:CPlusLibraries:


Make			=	TEDocument.o.make
	
LocalHeaders	=	TEDocument.h

DistantHeaders	=	{CPlusExampleIncludes}TDocument.h

LocalSources	=	TEDocument.cp		∂
					TESampleGlue.a

Resources		=	TEDocument.r

CSources		=	TEDocument.cp

ASources		=	TESampleGlue.a

CObjects		=	TEDocument.cp.o

AObjects		=	TESampleGlue.a.o

Objects			=	TEDocument.cp.o		∂
					TESampleGlue.a.o

Library			=	TEDocument.o
	
# turn on/off SADE symbols
SymOpts = -sym off

# C++ options
CPlusOptions = -mf {SymOpts} -d OBSOLETE

{CObjects} ƒƒ {Make} {LocalHeaders} "{DistantHeaders}" {LocalSources}  
	CPlus {CPlusOptions} {CSources} -o {CObjects} -i "{CPlusExampleIncludes}"
	
{AObjects} ƒƒ {Make} {LocalHeaders} "{DistantHeaders}" {LocalSources}  
	Asm {ASources} -o {AObjects} -i "{CPlusExampleIncludes}"


# Include the resources
{Library} ƒƒ {Make} {LocalHeaders} "{DistantHeaders}" {LocalSources} {Resources} 
	Rez -append -o "{CPLusExampleLibraries}{Library}" {Resources} -i "{CPlusExampleIncludes}"

# Save the compilation into its library
{Library} ƒƒ {Make} {Objects} 
	Lib -o "{CPLusExampleLibraries}{Library}" {SymOpts} {Objects}

