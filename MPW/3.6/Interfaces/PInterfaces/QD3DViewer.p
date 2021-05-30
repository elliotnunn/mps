{
     File:       QD3DViewer.p
 
     Contains:   MacOS Viewer Controller Interface File.
 
     Version:    Technology: Quickdraw 3D 1.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$ENDC}  {TARGET_OS_MAC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


TYPE
	TQ3ViewerObject						= Ptr;
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewerWindowResizeCallbackMethod = FUNCTION(theViewer: TQ3ViewerObject; data: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3ViewerWindowResizeCallbackMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewerPaneResizeNotifyCallbackMethod = FUNCTION(theViewer: TQ3ViewerObject; data: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3ViewerPaneResizeNotifyCallbackMethod = ProcPtr;
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewerDrawingCallbackMethod = FUNCTION(theViewer: TQ3ViewerObject; data: UNIV Ptr): OSErr; C;
{$ELSEC}
	TQ3ViewerDrawingCallbackMethod = ProcPtr;
{$ENDC}


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
	kQ3ViewerButtonReset		= $0400;
	kQ3ViewerOutputTextMode		= $0800;
	kQ3ViewerDragMode			= $1000;
	kQ3ViewerDrawGrowBox		= $2000;
	kQ3ViewerDrawDragBorder		= $4000;
	kQ3ViewerDraggingInOff		= $8000;
	kQ3ViewerDraggingOutOff		= $00010000;
	kQ3ViewerButtonOptions		= $00020000;
	kQ3ViewerPaneGrowBox		= $00040000;
	kQ3ViewerDefault			= $80000000;

	kQ3ViewerEmpty				= 0;
	kQ3ViewerHasModel			= $01;
	kQ3ViewerHasUndo			= $02;


TYPE
	TQ3ViewerCameraView 		= SInt32;
CONST
	kQ3ViewerCameraRestore		= 0;
	kQ3ViewerCameraFit			= 1;
	kQ3ViewerCameraFront		= 2;
	kQ3ViewerCameraBack			= 3;
	kQ3ViewerCameraLeft			= 4;
	kQ3ViewerCameraRight		= 5;
	kQ3ViewerCameraTop			= 6;
	kQ3ViewerCameraBottom		= 7;


	{	*****************************************************************************
	 **                                                                          **
	 **     Return viewer version number                                         **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3ViewerGetVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3ViewerGetVersion(VAR majorRevision: UInt32; VAR minorRevision: UInt32): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **     Return viewer release version number                                 **
 **     (in 'vers' format - e.g. 0x01518000 ==> 1.5.1 release)               **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerGetReleaseVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetReleaseVersion(VAR releaseRevision: UInt32): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **                     Creation and destruction                             **
 **             Note that this is not a QuickDraw 3D object                  **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerNew(port: CGrafPtr; VAR rect: Rect; flags: UInt32): TQ3ViewerObject; C;

{
 *  Q3ViewerDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerDispose(theViewer: TQ3ViewerObject): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **                 Functions to attach data to a viewer                     **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerUseFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerUseFile(theViewer: TQ3ViewerObject; refNum: LONGINT): OSErr; C;

{
 *  Q3ViewerUseData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerUseData(theViewer: TQ3ViewerObject; data: UNIV Ptr; size: LONGINT): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **     Functions to write data out from the Viewer                          **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerWriteFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerWriteFile(theViewer: TQ3ViewerObject; refNum: LONGINT): OSErr; C;

{
 *  Q3ViewerWriteData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerWriteData(theViewer: TQ3ViewerObject; data: Handle): UInt32; C;


{*****************************************************************************
 **                                                                          **
 **     Use this function to force the Viewer to re-draw                     **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerDraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerDraw(theViewer: TQ3ViewerObject): OSErr; C;

{
 *  Q3ViewerDrawContent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerDrawContent(theViewer: TQ3ViewerObject): OSErr; C;

{
 *  Q3ViewerDrawControlStrip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerDrawControlStrip(theViewer: TQ3ViewerObject): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **     Function used by the Viewer to filter and handle events              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerEvent(theViewer: TQ3ViewerObject; VAR evt: EventRecord): BOOLEAN; C;


{*****************************************************************************
 **                                                                          **
 **     This function returns a PICT of the contents of the                  **
 **     Viewer's window.  The application should dispose the PICT.           **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerGetPict()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetPict(theViewer: TQ3ViewerObject): PicHandle; C;


{*****************************************************************************
 **                                                                          **
 **                     Calls for dealing with Buttons                       **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerGetButtonRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetButtonRect(theViewer: TQ3ViewerObject; button: UInt32; VAR rect: Rect): OSErr; C;

{
 *  Q3ViewerGetCurrentButton()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetCurrentButton(theViewer: TQ3ViewerObject): UInt32; C;

{
 *  Q3ViewerSetCurrentButton()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetCurrentButton(theViewer: TQ3ViewerObject; button: UInt32): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **     Functions to set/get the group to be displayed by the Viewer.        **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerUseGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerUseGroup(theViewer: TQ3ViewerObject; group: TQ3GroupObject): OSErr; C;

{
 *  Q3ViewerGetGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetGroup(theViewer: TQ3ViewerObject): TQ3GroupObject; C;


{*****************************************************************************
 **                                                                          **
 **     Functions to set/get the color used to clear the window              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerSetBackgroundColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetBackgroundColor(theViewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): OSErr; C;

{
 *  Q3ViewerGetBackgroundColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetBackgroundColor(theViewer: TQ3ViewerObject; VAR color: TQ3ColorARGB): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **     Getting/Setting a Viewer's View object.                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerGetView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetView(theViewer: TQ3ViewerObject): TQ3ViewObject; C;

{
 *  Q3ViewerRestoreView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerRestoreView(theViewer: TQ3ViewerObject): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **     Calls for setting/getting viewer flags                               **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerSetFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetFlags(theViewer: TQ3ViewerObject; flags: UInt32): OSErr; C;

{
 *  Q3ViewerGetFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetFlags(theViewer: TQ3ViewerObject): UInt32; C;


{*****************************************************************************
 **                                                                          **
 **     Calls related to bounds/dimensions.  Bounds is the size of           **
 **     the window.  Dimensions can either be the Rect from the ViewHints    **
 **     or the current dimensions of the window (if you do a Set).           **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerSetBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetBounds(theViewer: TQ3ViewerObject; VAR bounds: Rect): OSErr; C;

{
 *  Q3ViewerGetBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetBounds(theViewer: TQ3ViewerObject; VAR bounds: Rect): OSErr; C;

{
 *  Q3ViewerSetDimension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetDimension(theViewer: TQ3ViewerObject; width: UInt32; height: UInt32): OSErr; C;

{
 *  Q3ViewerGetDimension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetDimension(theViewer: TQ3ViewerObject; VAR width: UInt32; VAR height: UInt32): OSErr; C;

{
 *  Q3ViewerGetMinimumDimension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetMinimumDimension(theViewer: TQ3ViewerObject; VAR width: UInt32; VAR height: UInt32): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **                         Port related calls                               **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerSetPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetPort(theViewer: TQ3ViewerObject; port: CGrafPtr): OSErr; C;

{
 *  Q3ViewerGetPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetPort(theViewer: TQ3ViewerObject): CGrafPtr; C;


{*****************************************************************************
 **                                                                          **
 **     Adjust Cursor should be called from idle loop to allow the Viewer    **
 **     to change the cursor according to the cursor position/object under   **
 **     the cursor.                                                          **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerAdjustCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerAdjustCursor(theViewer: TQ3ViewerObject; VAR pt: Point): BOOLEAN; C;

{
 *  Q3ViewerCursorChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerCursorChanged(theViewer: TQ3ViewerObject): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **     Returns the state of the viewer.  See the constant defined at the    **
 **     top of this file.                                                    **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerGetState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetState(theViewer: TQ3ViewerObject): UInt32; C;


{*****************************************************************************
 **                                                                          **
 **                         Clipboard utilities                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerClear(theViewer: TQ3ViewerObject): OSErr; C;

{
 *  Q3ViewerCut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerCut(theViewer: TQ3ViewerObject): OSErr; C;

{
 *  Q3ViewerCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerCopy(theViewer: TQ3ViewerObject): OSErr; C;

{
 *  Q3ViewerPaste()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerPaste(theViewer: TQ3ViewerObject): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **                         New Event Model                                  **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerMouseDown()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerMouseDown(theViewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): BOOLEAN; C;

{
 *  Q3ViewerContinueTracking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerContinueTracking(theViewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): BOOLEAN; C;

{
 *  Q3ViewerMouseUp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerMouseUp(theViewer: TQ3ViewerObject; x: LONGINT; y: LONGINT): BOOLEAN; C;

{
 *  Q3ViewerHandleKeyEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerHandleKeyEvent(theViewer: TQ3ViewerObject; VAR evt: EventRecord): BOOLEAN; C;


{*****************************************************************************
 **                                                                          **
 **                                 CallBacks                                **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerSetDrawingCallbackMethod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetDrawingCallbackMethod(theViewer: TQ3ViewerObject; callbackMethod: TQ3ViewerDrawingCallbackMethod; data: UNIV Ptr): OSErr; C;

{
 *  Q3ViewerSetWindowResizeCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetWindowResizeCallback(theViewer: TQ3ViewerObject; windowResizeCallbackMethod: TQ3ViewerWindowResizeCallbackMethod; data: UNIV Ptr): OSErr; C;

{
 *  Q3ViewerSetPaneResizeNotifyCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetPaneResizeNotifyCallback(theViewer: TQ3ViewerObject; paneResizeNotifyCallbackMethod: TQ3ViewerPaneResizeNotifyCallbackMethod; data: UNIV Ptr): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **                                 Undo                                     **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerUndo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerUndo(theViewer: TQ3ViewerObject): OSErr; C;

{
 *  Q3ViewerGetUndoString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetUndoString(theViewer: TQ3ViewerObject; str: CStringPtr; VAR cnt: UInt32): BOOLEAN; C;


{*****************************************************************************
 **                                                                          **
 **                             Camera Support                               **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerGetCameraCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetCameraCount(theViewer: TQ3ViewerObject; VAR cnt: UInt32): OSErr; C;

{
 *  Q3ViewerSetCameraByNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetCameraByNumber(theViewer: TQ3ViewerObject; cameraNo: UInt32): OSErr; C;

{
 *  Q3ViewerSetCameraByView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetCameraByView(theViewer: TQ3ViewerObject; viewType: TQ3ViewerCameraView): OSErr; C;


{*****************************************************************************
 **                                                                          **
 **                         Pop-up Button Options                            **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewerSetRendererType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetRendererType(theViewer: TQ3ViewerObject; rendererType: TQ3ObjectType): OSErr; C;

{
 *  Q3ViewerGetRendererType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetRendererType(theViewer: TQ3ViewerObject; VAR rendererType: TQ3ObjectType): OSErr; C;

{
 *  Q3ViewerChangeBrightness()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerChangeBrightness(theViewer: TQ3ViewerObject; brightness: Single): OSErr; C;

{
 *  Q3ViewerSetRemoveBackfaces()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetRemoveBackfaces(theViewer: TQ3ViewerObject; remove: TQ3Boolean): OSErr; C;

{
 *  Q3ViewerGetRemoveBackfaces()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetRemoveBackfaces(theViewer: TQ3ViewerObject; VAR remove: TQ3Boolean): OSErr; C;

{
 *  Q3ViewerSetPhongShading()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerSetPhongShading(theViewer: TQ3ViewerObject; phong: TQ3Boolean): OSErr; C;

{
 *  Q3ViewerGetPhongShading()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewerGetPhongShading(theViewer: TQ3ViewerObject; VAR phong: TQ3Boolean): OSErr; C;


{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DViewerIncludes}

{$ENDC} {__QD3DVIEWER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
