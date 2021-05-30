/******************************************************************************
 **																			 **
 ** 	Module:		QD3DDrawContext.h										 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose:	Draw context class types and routines				   	 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1993-1995 Apple Computer, Inc. All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DDrawContext_h
#define QD3DDrawContext_h

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

#if defined(WINDOW_SYSTEM_MACINTOSH) && WINDOW_SYSTEM_MACINTOSH
#include <Quickdraw.h>
#include <FixMath.h>
#include <GXTypes.h>
#endif /* WINDOW_SYSTEM_MACINTOSH */

#ifdef __cplusplus
extern "C" {
#endif /*  __cplusplus  */


/******************************************************************************
 **																			 **
 **							DrawContext Data Structures						 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3DrawContextClearImageMethod{
	kQ3ClearMethodNone,
	kQ3ClearMethodWithColor
} TQ3DrawContextClearImageMethod;


typedef struct TQ3DrawContextData {
	TQ3DrawContextClearImageMethod	clearImageMethod;
	TQ3ColorARGB					clearImageColor;
	TQ3Area							pane;
	TQ3Boolean						paneState;
	TQ3Bitmap						mask;
	TQ3Boolean						maskState;
	TQ3Boolean						doubleBufferState;
} TQ3DrawContextData;


/******************************************************************************
 **																			 **
 **								DrawContext Routines						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType Q3DrawContext_GetType(
	TQ3DrawContextObject		drawContext);

QD3D_EXPORT TQ3Status Q3DrawContext_SetData(
	TQ3DrawContextObject		context,
	const TQ3DrawContextData	*contextData);

QD3D_EXPORT TQ3Status Q3DrawContext_GetData(
	TQ3DrawContextObject		context,
	TQ3DrawContextData			*contextData);
	
QD3D_EXPORT TQ3Status Q3DrawContext_SetClearImageColor(
	TQ3DrawContextObject		context,
	const TQ3ColorARGB 			*color);

QD3D_EXPORT TQ3Status Q3DrawContext_GetClearImageColor(
	TQ3DrawContextObject		context,
	TQ3ColorARGB 				*color);

QD3D_EXPORT TQ3Status Q3DrawContext_SetPane(
	TQ3DrawContextObject		context,
	const TQ3Area	 			*pane);

QD3D_EXPORT TQ3Status Q3DrawContext_GetPane(
	TQ3DrawContextObject		context,
	TQ3Area	 					*pane);

QD3D_EXPORT TQ3Status Q3DrawContext_SetPaneState(
	TQ3DrawContextObject		context,
	TQ3Boolean					state);

QD3D_EXPORT TQ3Status Q3DrawContext_GetPaneState(
	TQ3DrawContextObject		context,
	TQ3Boolean					*state);
		
QD3D_EXPORT TQ3Status Q3DrawContext_SetClearImageMethod(
	TQ3DrawContextObject			context,
	TQ3DrawContextClearImageMethod 	method);
		
QD3D_EXPORT TQ3Status Q3DrawContext_GetClearImageMethod(
	TQ3DrawContextObject			context,
	TQ3DrawContextClearImageMethod 	*method);
		
QD3D_EXPORT TQ3Status Q3DrawContext_SetMask(
	TQ3DrawContextObject		context,
	const TQ3Bitmap				*mask);
		
QD3D_EXPORT TQ3Status Q3DrawContext_GetMask(
	TQ3DrawContextObject		context,
	TQ3Bitmap					*mask);

QD3D_EXPORT TQ3Status Q3DrawContext_SetMaskState(
	TQ3DrawContextObject		context,
	TQ3Boolean					state);

QD3D_EXPORT TQ3Status Q3DrawContext_GetMaskState(
	TQ3DrawContextObject		context,
	TQ3Boolean					*state);

QD3D_EXPORT TQ3Status Q3DrawContext_SetDoubleBufferState(
	TQ3DrawContextObject		context,
	TQ3Boolean 					state);

QD3D_EXPORT TQ3Status Q3DrawContext_GetDoubleBufferState(
	TQ3DrawContextObject		context,
	TQ3Boolean 					*state);


/******************************************************************************
 **																			 **
 **							Pixmap Data Structure							 **
 **																			 **
 *****************************************************************************/

typedef struct TQ3PixmapDrawContextData {
	TQ3DrawContextData		drawContextData;
	TQ3Pixmap				pixmap;
} TQ3PixmapDrawContextData;


/******************************************************************************
 **																			 **
 **						Pixmap DrawContext Routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3DrawContextObject Q3PixmapDrawContext_New(
	const TQ3PixmapDrawContextData	*contextData);

QD3D_EXPORT TQ3Status Q3PixmapDrawContext_SetPixmap(
	TQ3DrawContextObject			drawContext,
	const TQ3Pixmap					*pixmap);

QD3D_EXPORT TQ3Status Q3PixmapDrawContext_GetPixmap(
	TQ3DrawContextObject			drawContext,
	TQ3Pixmap						*pixmap);

#if defined(WINDOW_SYSTEM_MACINTOSH) && WINDOW_SYSTEM_MACINTOSH

/******************************************************************************
 **																			 **
 **						Macintosh DrawContext Data Structures				 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3MacDrawContext2DLibrary {
	kQ3Mac2DLibraryNone,
	kQ3Mac2DLibraryQuickDraw,
	kQ3Mac2DLibraryQuickDrawGX
} TQ3MacDrawContext2DLibrary;


typedef struct TQ3MacDrawContextData {
	TQ3DrawContextData			drawContextData;
	CWindowPtr					window;
	TQ3MacDrawContext2DLibrary	library;
	gxViewPort					viewPort;
	CGrafPtr					grafPort;
} TQ3MacDrawContextData;


/******************************************************************************
 **																			 **
 **						Macintosh DrawContext Routines						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3DrawContextObject Q3MacDrawContext_New(
	const TQ3MacDrawContextData	*drawContextData);
	
QD3D_EXPORT TQ3Status Q3MacDrawContext_SetWindow(
	TQ3DrawContextObject		drawContext,
	const CWindowPtr			window);

QD3D_EXPORT TQ3Status Q3MacDrawContext_GetWindow(
	TQ3DrawContextObject		drawContext,
	CWindowPtr					*window);

QD3D_EXPORT TQ3Status Q3MacDrawContext_SetGXViewPort(
	TQ3DrawContextObject		drawContext,
	const gxViewPort			viewPort);

QD3D_EXPORT TQ3Status Q3MacDrawContext_GetGXViewPort(
	TQ3DrawContextObject		drawContext,
	gxViewPort					*viewPort);

QD3D_EXPORT TQ3Status Q3MacDrawContext_SetGrafPort(
	TQ3DrawContextObject		drawContext,
	const CGrafPtr				grafPort);

QD3D_EXPORT TQ3Status Q3MacDrawContext_GetGrafPort(
	TQ3DrawContextObject		drawContext,
	CGrafPtr					*grafPort);

QD3D_EXPORT TQ3Status Q3MacDrawContext_Set2DLibrary(
	TQ3DrawContextObject		drawContext,
	TQ3MacDrawContext2DLibrary	library);

QD3D_EXPORT TQ3Status Q3MacDrawContext_Get2DLibrary(
	TQ3DrawContextObject		drawContext,
	TQ3MacDrawContext2DLibrary	*library);

#endif /* WINDOW_SYSTEM_MACINTOSH */

#ifdef __cplusplus
}
#endif /*  __cplusplus  */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif  /*  QD3DDrawContext_h  */
