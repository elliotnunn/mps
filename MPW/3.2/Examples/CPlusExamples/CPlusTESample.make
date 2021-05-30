#------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	CPlusTESample
#
#	This file: CPlusTESample.make	-	Make source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#
#   This version of TESample has been substantially
#   reworked in C++ to show how a "typical" object oriented
#   program could be written. To this end, what was once a
#   single source code file has been restructured into a
#   set of classes which demonstrate the advantages of
#   object-oriented programming. 
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
#   The TESample class is a subclass of TApplication. It
#   overrides several TApplication methods, including those
#   for handling menu commands and cursor adjustment, and
#   it does some necessary initialization. Note that we
#   only need to override 
#   
#   The TEDocument class is a subclass of TDocument. This
#   class contains most of the special purpose code for
#   text editing. In addition to overriding most of the
#   TDocument methods, it defines a number of additional
#   methods which are used by the TESample class to get
#   information on the document state.  
#
#------------------------------------------------------------------------------

AppLibObjs =	∂
	TApplication.cp.o ∂
	TDocument.cp.o

AppLibSrcs =	∂
	TApplication.cp ∂
	TDocument.cp

AppLibHdrs =	∂
	TApplicationCommon.h ∂
	TApplication.h ∂
	TDocument.h

Objs =	∂
	TEDocument.cp.o ∂
	TESample.cp.o ∂
	TESampleGlue.a.o

Srcs =	∂
	TEDocument.cp ∂
	TESample.cp ∂
	TESampleGlue.a

Hdrs =	∂
	TECommon.h ∂
	TEDocument.h ∂
	TESample.h

# turn on SADE symbols
SymOpts = -sym off

# C++ options
CPlusOptions = {SymOpts}

CPlusTESample ƒƒ {Objs} CPlusAppLib.o CPlusTESample.make
	Link -d -o {Targ} {SymOpts} ∂
		{Objs} ∂
		CPlusAppLib.o ∂
		"{CLibraries}"CPlusLib.o ∂
		"{CLibraries}"CRuntime.o ∂
		"{CLibraries}"StdCLib.o ∂
		"{CLibraries}"CInterface.o ∂
		"{Libraries}"Interface.o
	SetFile {Targ} -t APPL -c 'MOOT' -a B

CPlusTESample ƒƒ TESample.r TECommon.h CPlusTESample.make
	Rez -append -o {Targ} TESample.r

CPlusTESample ƒƒ TApplication.r TApplicationCommon.h CPlusTESample.make
	Rez -append -o {Targ} TApplication.r

# if ANY headers change, recompile everything
{Objs} ƒƒ {Hdrs} {AppLibHdrs}

CPlusAppLib.o ƒƒ {AppLibObjs} CPlusTESample.make  
	Lib -o {Targ} {SymOpts} {AppLibObjs}

# if AppLib headers change, recompile AppLib Objects
{AppLibObjs} ƒƒ {AppLibHdrs}

