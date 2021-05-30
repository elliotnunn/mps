{
 	File:		QD3DDrawContext.p
 
 	Contains:	Draw context class types and routines				   			
 
 	Version:	Technology:	Quickdraw 3D 1.0.6
 				Release:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DDrawContext;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DDRAWCONTEXT__}
{$SETC __QD3DDRAWCONTEXT__ := 1}

{$I+}
{$SETC QD3DDrawContextIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __FIXMATH__}
{$I FixMath.p}
{$ENDC}
{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
*****************************************************************************
 **																			 **
 **							DrawContext Data Structures						 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3DrawContextClearImageMethod  = LONGINT;
CONST
	kQ3ClearMethodNone			= {TQ3DrawContextClearImageMethod}0;
	kQ3ClearMethodWithColor		= {TQ3DrawContextClearImageMethod}1;


TYPE
	TQ3DrawContextDataPtr = ^TQ3DrawContextData;
	TQ3DrawContextData = RECORD
		clearImageMethod:		TQ3DrawContextClearImageMethod;
		clearImageColor:		TQ3ColorARGB;
		pane:					TQ3Area;
		paneState:				TQ3Boolean;
		mask:					TQ3Bitmap;
		maskState:				TQ3Boolean;
		doubleBufferState:		TQ3Boolean;
	END;

{
*****************************************************************************
 **																			 **
 **								DrawContext Routines						 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3DrawContext_GetType(drawContext: TQ3DrawContextObject): TQ3ObjectType; C;
FUNCTION Q3DrawContext_SetData(context: TQ3DrawContextObject; {CONST}VAR contextData: TQ3DrawContextData): TQ3Status; C;
FUNCTION Q3DrawContext_GetData(context: TQ3DrawContextObject; VAR contextData: TQ3DrawContextData): TQ3Status; C;
FUNCTION Q3DrawContext_SetClearImageColor(context: TQ3DrawContextObject; {CONST}VAR color: TQ3ColorARGB): TQ3Status; C;
FUNCTION Q3DrawContext_GetClearImageColor(context: TQ3DrawContextObject; VAR color: TQ3ColorARGB): TQ3Status; C;
FUNCTION Q3DrawContext_SetPane(context: TQ3DrawContextObject; {CONST}VAR pane: TQ3Area): TQ3Status; C;
FUNCTION Q3DrawContext_GetPane(context: TQ3DrawContextObject; VAR pane: TQ3Area): TQ3Status; C;
FUNCTION Q3DrawContext_SetPaneState(context: TQ3DrawContextObject; state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_GetPaneState(context: TQ3DrawContextObject; VAR state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_SetClearImageMethod(context: TQ3DrawContextObject; method: TQ3DrawContextClearImageMethod): TQ3Status; C;
FUNCTION Q3DrawContext_GetClearImageMethod(context: TQ3DrawContextObject; VAR method: TQ3DrawContextClearImageMethod): TQ3Status; C;
FUNCTION Q3DrawContext_SetMask(context: TQ3DrawContextObject; {CONST}VAR mask: TQ3Bitmap): TQ3Status; C;
FUNCTION Q3DrawContext_GetMask(context: TQ3DrawContextObject; VAR mask: TQ3Bitmap): TQ3Status; C;
FUNCTION Q3DrawContext_SetMaskState(context: TQ3DrawContextObject; state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_GetMaskState(context: TQ3DrawContextObject; VAR state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_SetDoubleBufferState(context: TQ3DrawContextObject; state: TQ3Boolean): TQ3Status; C;
FUNCTION Q3DrawContext_GetDoubleBufferState(context: TQ3DrawContextObject; VAR state: TQ3Boolean): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Pixmap Data Structure							 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3PixmapDrawContextDataPtr = ^TQ3PixmapDrawContextData;
	TQ3PixmapDrawContextData = RECORD
		drawContextData:		TQ3DrawContextData;
		pixmap:					TQ3Pixmap;
	END;

{
*****************************************************************************
 **																			 **
 **						Pixmap DrawContext Routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3PixmapDrawContext_New({CONST}VAR contextData: TQ3PixmapDrawContextData): TQ3DrawContextObject; C;
FUNCTION Q3PixmapDrawContext_SetPixmap(drawContext: TQ3DrawContextObject; {CONST}VAR pixmap: TQ3Pixmap): TQ3Status; C;
FUNCTION Q3PixmapDrawContext_GetPixmap(drawContext: TQ3DrawContextObject; VAR pixmap: TQ3Pixmap): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Macintosh DrawContext Data Structures				 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3MacDrawContext2DLibrary 	= LONGINT;
CONST
	kQ3Mac2DLibraryNone			= {TQ3MacDrawContext2DLibrary}0;
	kQ3Mac2DLibraryQuickDraw	= {TQ3MacDrawContext2DLibrary}1;
	kQ3Mac2DLibraryQuickDrawGX	= {TQ3MacDrawContext2DLibrary}2;


TYPE
	TQ3MacDrawContextDataPtr = ^TQ3MacDrawContextData;
	TQ3MacDrawContextData = RECORD
		drawContextData:		TQ3DrawContextData;
		window:					CWindowPtr;
		library:				TQ3MacDrawContext2DLibrary;
		viewPort:				gxViewPort;
		grafPort:				CGrafPtr;
	END;

{
*****************************************************************************
 **																			 **
 **						Macintosh DrawContext Routines						 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3MacDrawContext_New({CONST}VAR drawContextData: TQ3MacDrawContextData): TQ3DrawContextObject; C;
FUNCTION Q3MacDrawContext_SetWindow(drawContext: TQ3DrawContextObject; window: CWindowPtr): TQ3Status; C;
FUNCTION Q3MacDrawContext_GetWindow(drawContext: TQ3DrawContextObject; VAR window: CWindowPtr): TQ3Status; C;
FUNCTION Q3MacDrawContext_SetGXViewPort(drawContext: TQ3DrawContextObject; viewPort: gxViewPort): TQ3Status; C;
FUNCTION Q3MacDrawContext_GetGXViewPort(drawContext: TQ3DrawContextObject; VAR viewPort: gxViewPort): TQ3Status; C;
FUNCTION Q3MacDrawContext_SetGrafPort(drawContext: TQ3DrawContextObject; grafPort: CGrafPtr): TQ3Status; C;
FUNCTION Q3MacDrawContext_GetGrafPort(drawContext: TQ3DrawContextObject; VAR grafPort: CGrafPtr): TQ3Status; C;
FUNCTION Q3MacDrawContext_Set2DLibrary(drawContext: TQ3DrawContextObject; library: TQ3MacDrawContext2DLibrary): TQ3Status; C;
FUNCTION Q3MacDrawContext_Get2DLibrary(drawContext: TQ3DrawContextObject; VAR library: TQ3MacDrawContext2DLibrary): TQ3Status; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DDrawContextIncludes}

{$ENDC} {__QD3DDRAWCONTEXT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
