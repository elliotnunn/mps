/*------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	CPlusShapesApp
#
#	This file: Shapes.h	-	Interface to the Shape Classes 
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0 				3/89
#
#	Components:
#			CPlusShapesApp.make		March 1, 1989
#			TApplicationCommon.h	March 1, 1989
#			TApplication.h			March 1, 1989
#			TDocument.h				March 1, 1989
#			ShapesAppCommon.h		March 1, 1989
#			ShapesApp.h				March 1, 1989
#			ShapesDocument.h		March 1, 1989
#			TApplication.cp			March 1, 1989
#			TDocument.cp			March 1, 1989
#			ShapesApp.cp			March 1, 1989
#			ShapesDocument.cp		March 1, 1989
#			TApplication.r			March 1, 1989
#			ShapesApp.r				March 1, 1989
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
#------------------------------------------------------------------------------*/

#ifndef Shape_Defs
#define Shape_Defs

#include <Types.h>
#include <QuickDraw.h>
#include <stdlib.h>

class TShape : HandleObject {
  public:
	virtual void Move(Rect* r);		// Movement is not shape specific.
	
	// Neither Draw or Erase should ever be called, they MUST be overridden!
	// We make them private and force an error so we'll know if this ever occurs.
	virtual void Draw(Pattern) 	{DebugStr("\pCall to TShape::Draw");}
	virtual void Erase()  		{DebugStr("\pCall to TShape::Erase");}
  protected:
	TShape(Rect* r);		// Only accessible to public descendants
	Rect fBoundRect;
  private:
	virtual void RandomRect(Rect* drawRect);
};

class TArc : public TShape {
  public:
	TArc(Rect* r);
	
	// Overridden since drawing and erasing are shape specific operations
	virtual void Draw(Pattern);		
	virtual void Erase();
  private:
	short fStartAngle, fArcAngle;	
};


class TRoundRect : public TShape {
  public:
	TRoundRect(Rect* r);
	
	// Overridden since drawing and erasing are shape specific operations
 	virtual void Draw(Pattern);
    virtual void Erase();
  private:
	short fOvalWidth, fOvalHeight;		// curvature of rounded corners 
};


class TOval : public TShape {
  public:
	TOval(Rect *r);
	
	// Overridden since drawing and erasing are shape specific operations
	virtual void Draw(Pattern);
	virtual void Erase();
  private:
  	short fStartAngle, fArcAngle;
};

#endif Shape_Defs
