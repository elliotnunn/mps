{
 	File:		QD3DViewer.p
 
 	Contains:	Viewer Controller Interface File.								
 
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
 UNIT QD3DViewer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DVIEWER__}
{$SETC __QD3DVIEWER__ := 1}

{$I+}
{$SETC QD3DViewerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DGROUP__}
{$I QD3DGroup.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}


TYPE
	TQ3ViewerObject						= Ptr;

CONST
	kQ3ViewerShowBadge			= $01;
	kQ3ViewerActive				= $02;
	kQ3ViewerControllerVisible	= $04;
	kQ3ViewerDrawFrame			= $08;
	kQ3ViewerDraggingOff		= $10;
	kQ3ViewerButtonCamera		= $20;
	kQ3ViewerButtonTruck		= $40;
	kQ3ViewerButtonOrbit		= $80;
	kQ3ViewerButtonZoom			= $0100;
	kQ3ViewerButtonDolly		= $0200;
	kQ3ViewerDefault			= $02E6;

	kQ3ViewerEmpty				= 0;
	kQ3ViewerHasModel			= $01;

	gestaltQD3DViewer			= 'q3vc';
	gestaltQD3DViewerNotPresent	= 0;
	gestaltQD3DViewerAvailable	= 1;

{
*****************************************************************************
 **																			 **
 **						Creation and destruction							 **
 **				Note that this is not a QuickDraw 3D object					 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerNew(port: CGrafPtr; VAR rect: Rect; flags: LONGINT): TQ3ViewerObject; C;
FUNCTION Q3ViewerDispose(theViewer: TQ3ViewerObject): OSErr; C;
{
*****************************************************************************
 **																			 **
 **					Functions to attach data to a viewer					 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerUseFile(theViewer: TQ3ViewerObject; refNum: LONGINT): OSErr; C;
FUNCTION Q3ViewerUseData(theViewer: TQ3ViewerObject; data: UNIV Ptr; size: LONGINT): OSErr; C;
{
*****************************************************************************
 **																			 **
 **		Functions to write data out from the Viewer							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerWriteFile(theViewer: TQ3ViewerObject; refNum: LONGINT): OSErr; C;
FUNCTION Q3ViewerWriteData(theViewer: TQ3ViewerObject; VAR data: UNIV Ptr): LONGINT; C;
{
*****************************************************************************
 **																			 **
 **		Use this function to force the Viewer to re-draw					 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerDraw(theViewer: TQ3ViewerObject): OSErr; C;
{
*****************************************************************************
 **																			 **
 **		Function used by the Viewer to filter and handle events				 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerEvent(theViewer: TQ3ViewerObject; VAR evt: EventRecord): BOOLEAN; C;
{
*****************************************************************************
 **																			 **
 **		This function returns a PICT of the contents of the 				 **
 **		Viewer's window.  The application should dispose the PICT.			 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerGetPict(theViewer: TQ3ViewerObject): PicHandle; C;
{
*****************************************************************************
 **																			 **
 **						Calls for dealing with Buttons						 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerGetButtonRect(theViewer: TQ3ViewerObject; button: LONGINT; VAR rect: Rect): OSErr; C;
FUNCTION Q3ViewerGetCurrentButton(theViewer: TQ3ViewerObject): LONGINT; C;
FUNCTION Q3ViewerSetCurrentButton(theViewer: TQ3ViewerObject; button: LONGINT): OSErr; C;
{
*****************************************************************************
 **																			 **
 **		Functions to set/get the group to be displayed by the Viewer.		 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerUseGroup(theViewer: TQ3ViewerObject; group: TQ3GroupObject): OSErr; C;
FUNCTION Q3ViewerGetGroup(theViewer: TQ3ViewerObject): TQ3GroupObject; C;
{
*****************************************************************************
 **																			 **
 **		Functions to set/get the color used to clear the window				 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerSetBackgroundColor(theViewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): OSErr; C;
FUNCTION Q3ViewerGetBackgroundColor(theViewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): OSErr; C;
{
*****************************************************************************
 **																			 **
 **		Getting/Setting a Viewer's View object.  Disposal is needed.		 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerGetView(theViewer: TQ3ViewerObject): TQ3ViewObject; C;
FUNCTION Q3ViewerRestoreView(theViewer: TQ3ViewerObject): OSErr; C;
{
*****************************************************************************
 **																			 **
 **		Calls for setting/getting viewer flags								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerSetFlags(theViewer: TQ3ViewerObject; flags: LONGINT): OSErr; C;
FUNCTION Q3ViewerGetFlags(theViewer: TQ3ViewerObject): LONGINT; C;
{
*****************************************************************************
 **																			 **
 **		Calls related to bounds/dimensions.  Bounds is the size of 			 **
 **		the window.  Dimensions can either be the Rect from the ViewHints	 **
 **		or the current dimensions of the window (if you do a Set).			 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerSetBounds(theViewer: TQ3ViewerObject; VAR bounds: Rect): OSErr; C;
FUNCTION Q3ViewerGetBounds(theViewer: TQ3ViewerObject; VAR bounds: Rect): OSErr; C;
FUNCTION Q3ViewerGetDimension(theViewer: TQ3ViewerObject; VAR width: LONGINT; VAR height: LONGINT): OSErr; C;
{
*****************************************************************************
 **																			 **
 **							Port related calls								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerSetPort(theViewer: TQ3ViewerObject; port: CGrafPtr): OSErr; C;
FUNCTION Q3ViewerGetPort(theViewer: TQ3ViewerObject): CGrafPtr; C;
{
*****************************************************************************
 **																			 **
 **		Adjust Cursor should be called from idle loop to allow the Viewer	 **
 **		to change the cursor according to the cursor position/object under	 **
 **		the cursor.															 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerAdjustCursor(theViewer: TQ3ViewerObject; VAR pt: Point): BOOLEAN; C;
{
*****************************************************************************
 **																			 **
 **		Returns the state of the viewer.  See the constant defined at the	 **
 **		top of this file.													 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerGetState(theViewer: TQ3ViewerObject): LONGINT; C;
{
*****************************************************************************
 **																			 **
 **							Clipboard utilities								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ViewerClear(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerCut(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerCopy(theViewer: TQ3ViewerObject): OSErr; C;
FUNCTION Q3ViewerPaste(theViewer: TQ3ViewerObject): OSErr; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DViewerIncludes}

{$ENDC} {__QD3DVIEWER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
