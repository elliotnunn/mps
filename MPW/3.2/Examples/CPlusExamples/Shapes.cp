/*------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	CPlusShapesApp
#
#	This file: ShapesApp.cp - Implementation of the TShapes Classes
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
#include "Shapes.h"

const short width = 40;
const short height = 40;

TShape::TShape(Rect *r)
{
	RandomRect(r);
}

// Assign a random fBoundRect for the shape.

void TShape::RandomRect(Rect *drawRect)
{
	short rand1, rand2;
	
	rand1 = abs(Random()) % (drawRect->right - width);
	fBoundRect.left = rand1;
	rand2 = abs(Random()) % (drawRect->bottom - (height + drawRect->top));
	fBoundRect.top = rand2 + drawRect->top;
	fBoundRect.right = fBoundRect.left + width;
	fBoundRect.bottom = fBoundRect.top + height;
}

void TShape::Move(Rect *r)
{
	RandomRect(r);
}

TArc::TArc(Rect *r) : (r)		// Calls base class constructor
{
	short rand1, rand2;

	rand1 = abs(Random()) % 270;
	fStartAngle = rand1;
	rand2 = abs(Random()) % 270;
	fArcAngle = rand2;
}

void TArc::Draw(Pattern pat)
{
	Rect bRect;

	bRect = fBoundRect;
	FillArc(&bRect, fStartAngle, fArcAngle, pat);
	FrameArc(&bRect, fStartAngle, fArcAngle);
}

void TArc::Erase()
{
	Rect bRect;

	bRect = fBoundRect;
	EraseArc(&bRect, fStartAngle, fArcAngle);
}


TRoundRect::TRoundRect(Rect *r) : (r)		// Calls base class constructor
{
	fOvalWidth = 20;
	fOvalHeight = 15;
}

void TRoundRect::Draw(Pattern pat)
{
	Rect bRect;

	bRect = fBoundRect;
	FillRoundRect(&bRect, fOvalWidth, fOvalHeight, pat);
	FrameRoundRect(&bRect, fOvalWidth, fOvalHeight); 
}

void TRoundRect::Erase()
{
	Rect bRect;

	bRect = fBoundRect;
	EraseRoundRect(&bRect, fOvalWidth, fOvalHeight);
}


TOval::TOval(Rect* r) : (r)		// Calls base class constructor
{
	;
}

void TOval::Draw(Pattern pat)
{
	Rect tempRect = fBoundRect;
	
	FillOval(&tempRect, pat);
	FrameOval(&tempRect);
}

void TOval::Erase()
{
	Rect tempRect = fBoundRect;
	
	EraseOval(&tempRect);
}




