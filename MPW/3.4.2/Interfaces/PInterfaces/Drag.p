{
 	File:		Drag.p
 
 	Contains:	Drag and Drop Interfaces.
 
 	Version:	Technology:	Macintosh Drag and Drop 1.1
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Drag;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRAG__}
{$SETC __DRAG__ := 1}

{$I+}
{$SETC DragIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{		ConditionalMacros.p										}
{	Types.p														}
{	Memory.p													}
{		MixedMode.p												}
{	OSUtils.p													}
{	Events.p													}
{		Quickdraw.p												}
{			QuickdrawText.p										}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ Flavor Flags }
	flavorSenderOnly			= $00000001;					{ flavor is available to sender only }
	flavorSenderTranslated		= $00000002;					{ flavor is translated by sender }
	flavorNotSaved				= $00000004;					{ flavor should not be saved }
	flavorSystemTranslated		= $00000100;					{ flavor is translated by system }

	
TYPE
	FlavorFlags = LONGINT;


CONST
{ Drag Attributes }
	dragHasLeftSenderWindow		= $00000001;					{ drag has left the source window since TrackDrag }
	dragInsideSenderApplication	= $00000002;					{ drag is occurring within the sender application }
	dragInsideSenderWindow		= $00000004;					{ drag is occurring within the sender window }

	
TYPE
	DragAttributes = LONGINT;


CONST
{ Special Flavor Types }
	flavorTypeHFS				= 'hfs ';						{ flavor type for HFS data }
	flavorTypePromiseHFS		= 'phfs';						{ flavor type for promised HFS data }
	flavorTypeDirectory			= 'diry';

{ Drag Tracking Handler Messages }
	dragTrackingEnterHandler	= 1;							{ drag has entered handler }
	dragTrackingEnterWindow		= 2;							{ drag has entered window }
	dragTrackingInWindow		= 3;							{ drag is moving within window }
	dragTrackingLeaveWindow		= 4;							{ drag has exited window }
	dragTrackingLeaveHandler	= 5;							{ drag has exited handler }

	
TYPE
	DragTrackingMessage = INTEGER;


CONST
{ Drag Drawing Procedure Messages }
	dragRegionBegin				= 1;							{ initialize drawing }
	dragRegionDraw				= 2;							{ draw drag feedback }
	dragRegionHide				= 3;							{ hide drag feedback }
	dragRegionIdle				= 4;							{ drag feedback idle time }
	dragRegionEnd				= 5;							{ end of drawing }

	
TYPE
	DragRegionMessage = INTEGER;


CONST
{ Zoom Acceleration }
	zoomNoAcceleration			= 0;							{ use linear interpolation }
	zoomAccelerate				= 1;							{ ramp up step size }
	zoomDecelerate				= 2;							{ ramp down step size }

	
TYPE
	ZoomAcceleration = INTEGER;

{ Drag Manager Data Types }
	DragReference = LONGINT;

	ItemReference = LONGINT;

	FlavorType = ResType;

{ HFS Flavors }
	HFSFlavor = RECORD
		fileType:				OSType;									{ file type }
		fileCreator:			OSType;									{ file creator }
		fdFlags:				INTEGER;								{ Finder flags }
		fileSpec:				FSSpec;									{ file system specification }
	END;

	PromiseHFSFlavor = RECORD
		fileType:				OSType;									{ file type }
		fileCreator:			OSType;									{ file creator }
		fdFlags:				INTEGER;								{ Finder flags }
		promisedFlavor:			FlavorType;								{ promised flavor containing an FSSpec }
	END;

{ Application-Defined Drag Handler Routines }
	DragTrackingHandlerProcPtr = ProcPtr;  { FUNCTION DragTrackingHandler(message: DragTrackingMessage; theWindow: WindowPtr; handlerRefCon: UNIV Ptr; theDragRef: DragReference): OSErr; }
	DragTrackingHandlerUPP = UniversalProcPtr;

CONST
	uppDragTrackingHandlerProcInfo = $00003FA0; { FUNCTION (2 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewDragTrackingHandlerProc(userRoutine: DragTrackingHandlerProcPtr): DragTrackingHandlerUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDragTrackingHandlerProc(message: DragTrackingMessage; theWindow: WindowPtr; handlerRefCon: UNIV Ptr; theDragRef: DragReference; userRoutine: DragTrackingHandlerUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	DragTrackingHandler = DragTrackingHandlerUPP;

	DragReceiveHandlerProcPtr = ProcPtr;  { FUNCTION DragReceiveHandler(theWindow: WindowPtr; handlerRefCon: UNIV Ptr; theDragRef: DragReference): OSErr; }
	DragReceiveHandlerUPP = UniversalProcPtr;

CONST
	uppDragReceiveHandlerProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewDragReceiveHandlerProc(userRoutine: DragReceiveHandlerProcPtr): DragReceiveHandlerUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDragReceiveHandlerProc(theWindow: WindowPtr; handlerRefCon: UNIV Ptr; theDragRef: DragReference; userRoutine: DragReceiveHandlerUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	DragReceiveHandler = DragReceiveHandlerUPP;

{ Application-Defined Routines }
	DragSendDataProcPtr = ProcPtr;  { FUNCTION DragSendData(theType: FlavorType; dragSendRefCon: UNIV Ptr; theItemRef: ItemReference; theDragRef: DragReference): OSErr; }
	DragSendDataUPP = UniversalProcPtr;

CONST
	uppDragSendDataProcInfo = $00003FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewDragSendDataProc(userRoutine: DragSendDataProcPtr): DragSendDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDragSendDataProc(theType: FlavorType; dragSendRefCon: UNIV Ptr; theItemRef: ItemReference; theDragRef: DragReference; userRoutine: DragSendDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	DragSendDataProc = DragSendDataUPP;

	DragInputProcPtr = ProcPtr;  { FUNCTION DragInput(VAR mouse: Point; VAR modifiers: INTEGER; dragInputRefCon: UNIV Ptr; theDragRef: DragReference): OSErr; }
	DragInputUPP = UniversalProcPtr;

CONST
	uppDragInputProcInfo = $00003FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewDragInputProc(userRoutine: DragInputProcPtr): DragInputUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDragInputProc(VAR mouse: Point; VAR modifiers: INTEGER; dragInputRefCon: UNIV Ptr; theDragRef: DragReference; userRoutine: DragInputUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	DragInputProc = DragInputUPP;

	DragDrawingProcPtr = ProcPtr;  { FUNCTION DragDrawing(message: DragRegionMessage; showRegion: RgnHandle; showOrigin: Point; hideRegion: RgnHandle; hideOrigin: Point; dragDrawingRefCon: UNIV Ptr; theDragRef: DragReference): OSErr; }
	DragDrawingUPP = UniversalProcPtr;

CONST
	uppDragDrawingProcInfo = $000FFFA0; { FUNCTION (2 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewDragDrawingProc(userRoutine: DragDrawingProcPtr): DragDrawingUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDragDrawingProc(message: DragRegionMessage; showRegion: RgnHandle; showOrigin: Point; hideRegion: RgnHandle; hideOrigin: Point; dragDrawingRefCon: UNIV Ptr; theDragRef: DragReference; userRoutine: DragDrawingUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	DragDrawingProc = DragDrawingUPP;

{ Drag Manager Routines }
{ Installing and Removing Drag Handlers }

FUNCTION InstallTrackingHandler(trackingHandler: DragTrackingHandler; theWindow: WindowPtr; handlerRefCon: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $ABED;
	{$ENDC}
FUNCTION InstallReceiveHandler(receiveHandler: DragReceiveHandler; theWindow: WindowPtr; handlerRefCon: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $ABED;
	{$ENDC}
FUNCTION RemoveTrackingHandler(trackingHandler: DragTrackingHandler; theWindow: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $ABED;
	{$ENDC}
FUNCTION RemoveReceiveHandler(receiveHandler: DragReceiveHandler; theWindow: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $ABED;
	{$ENDC}
{ Creating and Disposing Drag References }
FUNCTION NewDrag(VAR theDragRef: DragReference): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $ABED;
	{$ENDC}
FUNCTION DisposeDrag(theDragRef: DragReference): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $ABED;
	{$ENDC}
{ Adding Drag Item Flavors }
FUNCTION AddDragItemFlavor(theDragRef: DragReference; theItemRef: ItemReference; theType: FlavorType; dataPtr: UNIV Ptr; dataSize: Size; theFlags: FlavorFlags): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $ABED;
	{$ENDC}
FUNCTION SetDragItemFlavorData(theDragRef: DragReference; theItemRef: ItemReference; theType: FlavorType; dataPtr: UNIV Ptr; dataSize: Size; dataOffset: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $ABED;
	{$ENDC}
{ Providing Drag Callback Procedures }
FUNCTION SetDragSendProc(theDragRef: DragReference; sendProc: DragSendDataProc; dragSendRefCon: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $ABED;
	{$ENDC}
FUNCTION SetDragInputProc(theDragRef: DragReference; inputProc: DragInputProc; dragInputRefCon: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $ABED;
	{$ENDC}
FUNCTION SetDragDrawingProc(theDragRef: DragReference; drawingProc: DragDrawingProc; dragDrawingRefCon: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $ABED;
	{$ENDC}
FUNCTION TrackDrag(theDragRef: DragReference; {CONST}VAR theEvent: EventRecord; theRegion: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $ABED;
	{$ENDC}
{ Getting Drag Item Information }
FUNCTION CountDragItems(theDragRef: DragReference; VAR numItems: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $ABED;
	{$ENDC}
FUNCTION GetDragItemReferenceNumber(theDragRef: DragReference; index: INTEGER; VAR theItemRef: ItemReference): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $ABED;
	{$ENDC}
FUNCTION CountDragItemFlavors(theDragRef: DragReference; theItemRef: ItemReference; VAR numFlavors: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $ABED;
	{$ENDC}
FUNCTION GetFlavorType(theDragRef: DragReference; theItemRef: ItemReference; index: INTEGER; VAR theType: FlavorType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7011, $ABED;
	{$ENDC}
FUNCTION GetFlavorFlags(theDragRef: DragReference; theItemRef: ItemReference; theType: FlavorType; VAR theFlags: FlavorFlags): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7012, $ABED;
	{$ENDC}
FUNCTION GetFlavorDataSize(theDragRef: DragReference; theItemRef: ItemReference; theType: FlavorType; VAR dataSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7013, $ABED;
	{$ENDC}
FUNCTION GetFlavorData(theDragRef: DragReference; theItemRef: ItemReference; theType: FlavorType; dataPtr: UNIV Ptr; VAR dataSize: Size; dataOffset: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $ABED;
	{$ENDC}
FUNCTION GetDragItemBounds(theDragRef: DragReference; theItemRef: ItemReference; VAR itemBounds: Rect): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7015, $ABED;
	{$ENDC}
FUNCTION SetDragItemBounds(theDragRef: DragReference; theItemRef: ItemReference; {CONST}VAR itemBounds: Rect): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7016, $ABED;
	{$ENDC}
FUNCTION GetDropLocation(theDragRef: DragReference; VAR dropLocation: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7017, $ABED;
	{$ENDC}
FUNCTION SetDropLocation(theDragRef: DragReference; {CONST}VAR dropLocation: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7018, $ABED;
	{$ENDC}
{ Getting Information About a Drag }
FUNCTION GetDragAttributes(theDragRef: DragReference; VAR flags: DragAttributes): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7019, $ABED;
	{$ENDC}
FUNCTION GetDragMouse(theDragRef: DragReference; VAR mouse: Point; VAR pinnedMouse: Point): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701A, $ABED;
	{$ENDC}
FUNCTION SetDragMouse(theDragRef: DragReference; pinnedMouse: Point): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701B, $ABED;
	{$ENDC}
FUNCTION GetDragOrigin(theDragRef: DragReference; VAR initialMouse: Point): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701C, $ABED;
	{$ENDC}
FUNCTION GetDragModifiers(theDragRef: DragReference; VAR modifiers: INTEGER; VAR mouseDownModifiers: INTEGER; VAR mouseUpModifiers: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701D, $ABED;
	{$ENDC}
{ Drag Highlighting }
FUNCTION ShowDragHilite(theDragRef: DragReference; hiliteFrame: RgnHandle; inside: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701E, $ABED;
	{$ENDC}
FUNCTION HideDragHilite(theDragRef: DragReference): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701F, $ABED;
	{$ENDC}
FUNCTION DragPreScroll(theDragRef: DragReference; dH: INTEGER; dV: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7020, $ABED;
	{$ENDC}
FUNCTION DragPostScroll(theDragRef: DragReference): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7021, $ABED;
	{$ENDC}
FUNCTION UpdateDragHilite(theDragRef: DragReference; updateRgn: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7022, $ABED;
	{$ENDC}
{ Drag Manager Utilities }
FUNCTION WaitMouseMoved(initialMouse: Point): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7023, $ABED;
	{$ENDC}
FUNCTION ZoomRects({CONST}VAR fromRect: Rect; {CONST}VAR toRect: Rect; zoomSteps: INTEGER; acceleration: ZoomAcceleration): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7024, $ABED;
	{$ENDC}
FUNCTION ZoomRegion(region: RgnHandle; zoomDistance: Point; zoomSteps: INTEGER; acceleration: ZoomAcceleration): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7025, $ABED;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DragIncludes}

{$ENDC} {__DRAG__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
