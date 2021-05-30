/******************************************************************************
 **									 										 **
 ** 	Module:		QD3DViewer.h											 **						
 **									 										 **
 **									 										 **
 ** 	Purpose: 	Viewer Controller Interface File.						 **			
 **									 										 **
 **									 										 **
 ** 	Copyright (C) 1994-1995 Apple Computer, Inc.  All rights reserved.	 **
 **									 										 **
 **									 										 **
 *****************************************************************************/

#ifndef QD3DViewer_h
#define QD3DViewer_h

#ifndef QD3D_h
#include <QD3D.h>
#endif  /*  QD3D_h  */

#if PRAGMA_ONCE
	#pragma once
#endif

#if defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma align_array_members off
	#pragma options align=native
#endif

#if defined(OS_MACINTOSH) && OS_MACINTOSH

#include <Events.h>
#include <Types.h>
#include <Windows.h>

#include <QD3DGroup.h>

typedef void *TQ3ViewerObject;

enum {
	kQ3ViewerShowBadge 			= 1<<0,
	kQ3ViewerActive				= 1<<1,
	kQ3ViewerControllerVisible	= 1<<2,
	kQ3ViewerDrawFrame			= 1<<3,
	kQ3ViewerDraggingOff		= 1<<4,
	
	kQ3ViewerButtonCamera		= 1<<5,
	kQ3ViewerButtonTruck		= 1<<6,
	kQ3ViewerButtonOrbit		= 1<<7,
	kQ3ViewerButtonZoom			= 1<<8,
	kQ3ViewerButtonDolly		= 1<<9,
	

	kQ3ViewerDefault = (
				kQ3ViewerActive        | kQ3ViewerControllerVisible | 
				kQ3ViewerButtonCamera  | kQ3ViewerButtonTruck       | 
				kQ3ViewerButtonOrbit   | kQ3ViewerButtonDolly )
};

enum {
	kQ3ViewerEmpty    = 0,
	kQ3ViewerHasModel = 1<<0
};

enum {
	gestaltQD3DViewer			= 'q3vc',
	gestaltQD3DViewerNotPresent	= 0,
	gestaltQD3DViewerAvailable	= 1
};

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */

/******************************************************************************
 **																			 **
 **						Creation and destruction							 **
 **				Note that this is not a QuickDraw 3D object					 **
 **																			 **
 *****************************************************************************/

TQ3ViewerObject Q3ViewerNew(
	CGrafPtr		port,
	Rect			*rect,
	unsigned long	flags);
	
OSErr Q3ViewerDispose(
	TQ3ViewerObject theViewer);

/******************************************************************************
 **																			 **
 **					Functions to attach data to a viewer					 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerUseFile(
	TQ3ViewerObject	theViewer,
	long			refNum);
	
OSErr Q3ViewerUseData(
	TQ3ViewerObject	theViewer,
	void			*data,
	long			size);

/******************************************************************************
 **																			 **
 **		Functions to write data out from the Viewer							 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerWriteFile(
	TQ3ViewerObject	theViewer,
	long			refNum);
	
unsigned long Q3ViewerWriteData(
	TQ3ViewerObject	theViewer,
	void			**data);

/******************************************************************************
 **																			 **
 **		Use this function to force the Viewer to re-draw					 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerDraw(
	TQ3ViewerObject theViewer);

/******************************************************************************
 **																			 **
 **		Function used by the Viewer to filter and handle events				 **
 **																			 **
 *****************************************************************************/

Boolean Q3ViewerEvent(
	TQ3ViewerObject	theViewer,
	EventRecord		*evt);

/******************************************************************************
 **																			 **
 **		This function returns a PICT of the contents of the 				 **
 **		Viewer's window.  The application should dispose the PICT.			 **
 **																			 **
 *****************************************************************************/

PicHandle Q3ViewerGetPict(
	TQ3ViewerObject theViewer);

/******************************************************************************
 **																			 **
 **						Calls for dealing with Buttons						 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerGetButtonRect(
	TQ3ViewerObject	theViewer,
	unsigned long	button,
	Rect			*rect);

unsigned long Q3ViewerGetCurrentButton(
	TQ3ViewerObject	theViewer);
	
OSErr Q3ViewerSetCurrentButton(
	TQ3ViewerObject	theViewer,
	unsigned long	button);

/******************************************************************************
 **																			 **
 **		Functions to set/get the group to be displayed by the Viewer.		 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerUseGroup(
	TQ3ViewerObject	theViewer,
	TQ3GroupObject	group);
	
TQ3GroupObject Q3ViewerGetGroup(
	TQ3ViewerObject	theViewer);

/******************************************************************************
 **																			 **
 **		Functions to set/get the color used to clear the window				 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerSetBackgroundColor(
	TQ3ViewerObject	theViewer,
	TQ3ColorARGB	*color);
	
OSErr Q3ViewerGetBackgroundColor(
	TQ3ViewerObject	theViewer,
	TQ3ColorARGB	*color);

/******************************************************************************
 **																			 **
 **		Getting/Setting a Viewer's View object.  Disposal is needed.		 **
 **																			 **
 *****************************************************************************/

TQ3ViewObject Q3ViewerGetView(
	TQ3ViewerObject	theViewer);

OSErr Q3ViewerRestoreView(
	TQ3ViewerObject	theViewer);

/******************************************************************************
 **																			 **
 **		Calls for setting/getting viewer flags								 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerSetFlags(
	TQ3ViewerObject	theViewer,
	unsigned long	flags);
	
unsigned long Q3ViewerGetFlags(
	TQ3ViewerObject	theViewer);

/******************************************************************************
 **																			 **
 **		Calls related to bounds/dimensions.  Bounds is the size of 			 **
 **		the window.  Dimensions can either be the Rect from the ViewHints	 **
 **		or the current dimensions of the window (if you do a Set).			 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerSetBounds(
	TQ3ViewerObject	theViewer,
	Rect			*bounds);
	
OSErr Q3ViewerGetBounds(
	TQ3ViewerObject	theViewer,
	Rect			*bounds);

OSErr Q3ViewerGetDimension(
	TQ3ViewerObject	theViewer,
	unsigned long	*width,
	unsigned long	*height);

/******************************************************************************
 **																			 **
 **							Port related calls								 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerSetPort(
	TQ3ViewerObject	theViewer,
	CGrafPtr		port);
	
CGrafPtr Q3ViewerGetPort(
	TQ3ViewerObject	theViewer);

/******************************************************************************
 **																			 **
 **		Adjust Cursor should be called from idle loop to allow the Viewer	 **
 **		to change the cursor according to the cursor position/object under	 **
 **		the cursor.															 **
 **																			 **
 *****************************************************************************/

Boolean Q3ViewerAdjustCursor(
	TQ3ViewerObject	theViewer,
	Point			*pt);

/******************************************************************************
 **																			 **
 **		Returns the state of the viewer.  See the constant defined at the	 **
 **		top of this file.													 **
 **																			 **
 *****************************************************************************/

unsigned long Q3ViewerGetState(
	TQ3ViewerObject	theViewer);

/******************************************************************************
 **																			 **
 **							Clipboard utilities								 **
 **																			 **
 *****************************************************************************/

OSErr Q3ViewerClear(
	TQ3ViewerObject	theViewer);
	
OSErr Q3ViewerCut(
	TQ3ViewerObject	theViewer);
	
OSErr Q3ViewerCopy(
	TQ3ViewerObject	theViewer);
	
OSErr Q3ViewerPaste(
	TQ3ViewerObject	theViewer);

#ifdef __cplusplus
}
#endif	/* __cplusplus */

#endif 	/* OS_MACINTOSH */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif	/* QD3DViewer_h */

