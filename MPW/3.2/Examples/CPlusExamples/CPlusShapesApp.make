#------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	CPlusShapesApp
#
#	This file: CPlusShapesApp.make	-	Make source
#
#	Copyright © 1988 Apple Computer, Inc.
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
#   The TShapesApp class is a subclass of TApplication. It
#   overrides several TApplication methods, including those
#   for handling menu commands and cursor adjustment, and
#   it does some necessary initialization.
#   
#   The TShapesDocument class is a subclass of TDocument. This
#   class contains most of the special purpose code for
#   shape drawing. In addition to overriding several of the
#   TDocument methods, it defines a few additional
#   methods which are used by the TShapesApp class to get
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
	Shapes.cp.o ∂
	ShapesDocument.cp.o ∂
	ShapesApp.cp.o ∂

Srcs =	∂
	Shapes.cp ∂
	ShapesDocument.cp ∂
	ShapesApp.cp

Hdrs =	∂
	Shapes.h ∂
	ShapesDocument.h ∂
	ShapesAppCommon.h ∂
	ShapesApp.h

# turn on/off SADE symbols
SymOpts = -sym off

# C++ options
CPlusOptions = -mf {SymOpts}

CPlusShapesApp ƒƒ {Objs} CPlusAppLib.o CPlusShapesApp.make
	Link -d -mf -o {Targ} {SymOpts} ∂
		{Objs} ∂
		CPlusAppLib.o ∂
		"{CLibraries}"CPlusLib.o ∂
		"{CLibraries}"CRuntime.o ∂
		"{CLibraries}"StdCLib.o ∂
		"{CLibraries}"CInterface.o ∂
		"{Libraries}"Interface.o
	SetFile {Targ} -t APPL -c 'MOOT' -a B

CPlusShapesApp ƒƒ ShapesApp.r ShapesAppCommon.h CPlusShapesApp.make
	Rez -append -o {Targ} ShapesApp.r

CPlusShapesApp ƒƒ TApplication.r TApplicationCommon.h CPlusShapesApp.make
	Rez -append -o {Targ} TApplication.r

# if ANY headers change, recompile everything
{Objs} ƒƒ {Hdrs} {AppLibHdrs}

CPlusAppLib.o ƒƒ {AppLibObjs} CPlusShapesApp.make  
	Lib -o {Targ} {SymOpts} {AppLibObjs}

# if AppLib headers change, recompile AppLib Objects
{AppLibObjs} ƒƒ {AppLibHdrs}

