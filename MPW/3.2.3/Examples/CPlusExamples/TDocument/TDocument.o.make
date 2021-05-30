#------------------------------------------------------------------------------
#
#	TDocument
#
#	This file: TDocument.o.make	-	Make source
#
#	Copyright © 1988-1991 Apple Computer, Inc. & Öner M. Biçakçi 1991
#	All rights reserved.
#
#
#   	TDocuments are objects that are associated with a window. Methods are
#	provided to deal with update, activate, mouse-click, key down, and other events.
#	Some additional classes which implement a linked list of TDocument objects are
#	provided. 
#   
#		TDocument is an object class which models the basic needs of a document.
#	Although it is not intended to be THE difinitive implementation of the 
#	fundamental components of a document class, it may serve to provide a stepping
#	stone in the creation of your own implementation. Additionally, TDocument 
#	serves as the base class to create other document subclasses.
#
#		Note that this make file creates a library file, TDocument.o in the
#	current directory. Therefore, changes made to this class will not propogate
#	to other classes or applications. If and when any changes are made that should
#	be made available to dependent files, simply COPY the TDocument.o file to the
#	C++ library folder and COPY the TDocument.h file to the C++ Includes folder.
#
#   	The TApplication and TDocument classes together define a basic framework
#	for Mac applications, without having any specific knowledge about the type of
#	data being displayed by the application's documents. They are a (very) crude
#	implementation of the MacApp application model, without the sophisticated view
#	heirarchies or any real error handling. 
#
#------------------------------------------------------------------------------


Make			=	TDocument.o.make
	
LocalHeaders	=	TDocument.h

LocalSources	=	TDocument.cp

Compilation		=	TDocument.cp.o

Library			=	TDocument.o
	
# turn on/off SADE symbols as desired
SymOpts = -sym off

# C++ options
CPlusOptions = -mf {SymOpts} -i "{CPlusIncludes}" -p

{Compilation} ƒƒ {LocalSources} {LocalHeaders} {Make}  
	CPlus {LocalSources} -o {Compilation} -i "{CPlusIncludes}"

# Save the compilation into its library
{Library} ƒƒ {Make} {Compilation} 
	Lib -o {Targ} {SymOpts} {Compilation}

