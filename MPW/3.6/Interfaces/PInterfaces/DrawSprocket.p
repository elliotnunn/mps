{
     File:       DrawSprocket.p
 
     Contains:   Games Sprockets: DrawSprocket interfaces
 
     Version:    Technology: Draw Sprocket 1.7
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DrawSprocket;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRAWSPROCKET__}
{$SETC __DRAWSPROCKET__ := 1}

{$I+}
{$SETC DrawSprocketIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __DISPLAYS__}
{$I Displays.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
********************************************************************************
** constants
********************************************************************************
}

TYPE
	DSpDepthMask 				= SInt32;
CONST
	kDSpDepthMask_1				= $01;
	kDSpDepthMask_2				= $02;
	kDSpDepthMask_4				= $04;
	kDSpDepthMask_8				= $08;
	kDSpDepthMask_16			= $10;
	kDSpDepthMask_32			= $20;
	kDSpDepthMask_All			= -1;


TYPE
	DSpColorNeeds 				= SInt32;
CONST
	kDSpColorNeeds_DontCare		= 0;
	kDSpColorNeeds_Request		= 1;
	kDSpColorNeeds_Require		= 2;


TYPE
	DSpContextState 			= SInt32;
CONST
	kDSpContextState_Active		= 0;
	kDSpContextState_Paused		= 1;
	kDSpContextState_Inactive	= 2;

	{	 kDSpContextOption_QD3DAccel not yet implemented 	}

TYPE
	DSpContextOption 			= SInt32;
CONST
																{     kDSpContextOption_QD3DAccel       = 1<<0, }
	kDSpContextOption_PageFlip	= $02;
	kDSpContextOption_DontSyncVBL = $04;
	kDSpContextOption_Stereoscopic = $08;


TYPE
	DSpAltBufferOption 			= SInt32;
CONST
	kDSpAltBufferOption_RowBytesEqualsWidth = $01;


TYPE
	DSpBufferKind 				= SInt32;
CONST
	kDSpBufferKind_Normal		= 0;


TYPE
	DSpBlitMode 				= SInt32;
CONST
	kDSpBlitMode_Plain			= 0;
	kDSpBlitMode_SrcKey			= $01;
	kDSpBlitMode_DstKey			= $02;
	kDSpBlitMode_Interpolation	= $04;

	{	
	********************************************************************************
	** data types
	********************************************************************************
		}

TYPE
	DSpAltBufferReference    = ^LONGINT; { an opaque 32-bit type }
	DSpAltBufferReferencePtr = ^DSpAltBufferReference;  { when a VAR xx:DSpAltBufferReference parameter can be nil, it is changed to xx: DSpAltBufferReferencePtr }
	DSpContextReference    = ^LONGINT; { an opaque 32-bit type }
	DSpContextReferencePtr = ^DSpContextReference;  { when a VAR xx:DSpContextReference parameter can be nil, it is changed to xx: DSpContextReferencePtr }
	DSpContextReferenceConst    = ^LONGINT; { an opaque 32-bit type }
	DSpContextReferenceConstPtr = ^DSpContextReferenceConst;  { when a VAR xx:DSpContextReferenceConst parameter can be nil, it is changed to xx: DSpContextReferenceConstPtr }
{$IFC TYPED_FUNCTION_POINTERS}
	DSpEventProcPtr = FUNCTION(VAR inEvent: EventRecord): BOOLEAN; C;
{$ELSEC}
	DSpEventProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DSpCallbackProcPtr = FUNCTION(inContext: DSpContextReference; inRefCon: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	DSpCallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DSpEventUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DSpEventUPP = DSpEventProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DSpCallbackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DSpCallbackUPP = DSpCallbackProcPtr;
{$ENDC}	

CONST
	uppDSpEventProcInfo = $000000D1;
	uppDSpCallbackProcInfo = $000003D1;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewDSpEventUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewDSpEventUPP(userRoutine: DSpEventProcPtr): DSpEventUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDSpCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewDSpCallbackUPP(userRoutine: DSpCallbackProcPtr): DSpCallbackUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDSpEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDSpEventUPP(userUPP: DSpEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDSpCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDSpCallbackUPP(userUPP: DSpCallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDSpEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeDSpEventUPP(VAR inEvent: EventRecord; userRoutine: DSpEventUPP): BOOLEAN;
{
 *  InvokeDSpCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeDSpCallbackUPP(inContext: DSpContextReference; inRefCon: UNIV Ptr; userRoutine: DSpCallbackUPP): BOOLEAN;
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	DSpContextAttributesPtr = ^DSpContextAttributes;
	DSpContextAttributes = RECORD
		frequency:				Fixed;
		displayWidth:			UInt32;
		displayHeight:			UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
		colorNeeds:				UInt32;
		colorTable:				CTabHandle;
		contextOptions:			OptionBits;
		backBufferDepthMask:	OptionBits;
		displayDepthMask:		OptionBits;
		backBufferBestDepth:	UInt32;
		displayBestDepth:		UInt32;
		pageCount:				UInt32;
		filler:					PACKED ARRAY [0..2] OF CHAR;
		gameMustConfirmSwitch:	BOOLEAN;
		reserved3:				ARRAY [0..3] OF UInt32;
	END;

	DSpAltBufferAttributesPtr = ^DSpAltBufferAttributes;
	DSpAltBufferAttributes = RECORD
		width:					UInt32;
		height:					UInt32;
		options:				DSpAltBufferOption;
		reserved:				ARRAY [0..3] OF UInt32;
	END;

	DSpBlitInfoPtr = ^DSpBlitInfo;
{$IFC TYPED_FUNCTION_POINTERS}
	DSpBlitDoneProc = PROCEDURE(info: DSpBlitInfoPtr); C;
{$ELSEC}
	DSpBlitDoneProc = ProcPtr;
{$ENDC}

	DSpBlitInfo = RECORD
		completionFlag:			BOOLEAN;
		filler:					PACKED ARRAY [0..2] OF CHAR;
		completionProc:			DSpBlitDoneProc;
		srcContext:				DSpContextReference;
		srcBuffer:				CGrafPtr;
		srcRect:				Rect;
		srcKey:					UInt32;
		dstContext:				DSpContextReference;
		dstBuffer:				CGrafPtr;
		dstRect:				Rect;
		dstKey:					UInt32;
		mode:					DSpBlitMode;
		reserved:				ARRAY [0..3] OF UInt32;
	END;

	{	
	********************************************************************************
	** function prototypes
	********************************************************************************
		}

	{	
	** global operations
		}
	{
	 *  DSpStartup()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION DSpStartup: OSStatus; C;

{
 *  DSpShutdown()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpShutdown: OSStatus; C;

{
 *  DSpGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpGetVersion: NumVersion; C;

{
 *  DSpGetFirstContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpGetFirstContext(inDisplayID: DisplayIDType; VAR outContext: DSpContextReference): OSStatus; C;

{
 *  DSpGetNextContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpGetNextContext(inCurrentContext: DSpContextReference; VAR outContext: DSpContextReference): OSStatus; C;

{
 *  DSpGetCurrentContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpGetCurrentContext(inDisplayID: DisplayIDType; VAR outContext: DSpContextReference): OSStatus; C;

{
 *  DSpFindBestContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpFindBestContext(inDesiredAttributes: DSpContextAttributesPtr; VAR outContext: DSpContextReference): OSStatus; C;

{
 *  DSpFindBestContextOnDisplayID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpFindBestContextOnDisplayID(inDesiredAttributes: DSpContextAttributesPtr; VAR outContext: DSpContextReference; inDisplayID: DisplayIDType): OSStatus; C;

{$IFC CALL_NOT_IN_CARBON }
{
 *  DSpCanUserSelectContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpCanUserSelectContext(inDesiredAttributes: DSpContextAttributesPtr; VAR outUserCanSelectContext: BOOLEAN): OSStatus; C;

{
 *  DSpUserSelectContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpUserSelectContext(inDesiredAttributes: DSpContextAttributesPtr; inDialogDisplayLocation: DisplayIDType; inEventProc: DSpEventUPP; VAR outContext: DSpContextReference): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DSpProcessEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpProcessEvent(VAR inEvent: EventRecord; VAR outEventWasProcessed: BOOLEAN): OSStatus; C;

{
 *  DSpSetBlankingColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpSetBlankingColor({CONST}VAR inRGBColor: RGBColor): OSStatus; C;

{
 *  DSpSetDebugMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpSetDebugMode(inDebugMode: BOOLEAN): OSStatus; C;

{
 *  DSpFindContextFromPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpFindContextFromPoint(inGlobalPoint: Point; VAR outContext: DSpContextReference): OSStatus; C;

{
 *  DSpGetMouse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpGetMouse(VAR outGlobalPoint: Point): OSStatus; C;

{
** alternate buffer operations
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  DSpAltBuffer_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpAltBuffer_New(inContext: DSpContextReference; inVRAMBuffer: BOOLEAN; VAR inAttributes: DSpAltBufferAttributes; VAR outAltBuffer: DSpAltBufferReference): OSStatus; C;

{
 *  DSpAltBuffer_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpAltBuffer_Dispose(inAltBuffer: DSpAltBufferReference): OSStatus; C;

{
 *  DSpAltBuffer_InvalRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpAltBuffer_InvalRect(inAltBuffer: DSpAltBufferReference; {CONST}VAR inInvalidRect: Rect): OSStatus; C;

{
 *  DSpAltBuffer_GetCGrafPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpAltBuffer_GetCGrafPtr(inAltBuffer: DSpAltBufferReference; inBufferKind: DSpBufferKind; VAR outCGrafPtr: CGrafPtr; VAR outGDevice: GDHandle): OSStatus; C;

{
** context operations
}
{ general }
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DSpContext_GetAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_GetAttributes(inContext: DSpContextReferenceConst; outAttributes: DSpContextAttributesPtr): OSStatus; C;

{
 *  DSpContext_Reserve()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_Reserve(inContext: DSpContextReference; inDesiredAttributes: DSpContextAttributesPtr): OSStatus; C;

{
 *  DSpContext_Queue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_Queue(inParentContext: DSpContextReference; inChildContext: DSpContextReference; inDesiredAttributes: DSpContextAttributesPtr): OSStatus; C;

{
 *  DSpContext_Switch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.7 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_Switch(inOldContext: DSpContextReference; inNewContext: DSpContextReference): OSStatus; C;

{
 *  DSpContext_Release()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_Release(inContext: DSpContextReference): OSStatus; C;

{
 *  DSpContext_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_Dispose(inContext: DSpContextReference): OSStatus; C;

{
 *  DSpContext_GetDisplayID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_GetDisplayID(inContext: DSpContextReferenceConst; VAR outDisplayID: DisplayIDType): OSStatus; C;

{
 *  DSpContext_GlobalToLocal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_GlobalToLocal(inContext: DSpContextReferenceConst; VAR ioPoint: Point): OSStatus; C;

{
 *  DSpContext_LocalToGlobal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_LocalToGlobal(inContext: DSpContextReferenceConst; VAR ioPoint: Point): OSStatus; C;

{$IFC CALL_NOT_IN_CARBON }
{
 *  DSpContext_SetVBLProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_SetVBLProc(inContext: DSpContextReference; inProcPtr: DSpCallbackUPP; inRefCon: UNIV Ptr): OSStatus; C;

{
 *  DSpContext_GetFlattenedSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_GetFlattenedSize(inContext: DSpContextReference; VAR outFlatContextSize: UInt32): OSStatus; C;

{
 *  DSpContext_Flatten()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_Flatten(inContext: DSpContextReference; outFlatContext: UNIV Ptr): OSStatus; C;

{
 *  DSpContext_Restore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_Restore(inFlatContext: UNIV Ptr; VAR outRestoredContext: DSpContextReference): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DSpContext_GetMonitorFrequency()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_GetMonitorFrequency(inContext: DSpContextReferenceConst; VAR outFrequency: Fixed): OSStatus; C;

{$IFC CALL_NOT_IN_CARBON }
{
 *  DSpContext_SetMaxFrameRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_SetMaxFrameRate(inContext: DSpContextReference; inMaxFPS: UInt32): OSStatus; C;

{
 *  DSpContext_GetMaxFrameRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_GetMaxFrameRate(inContext: DSpContextReferenceConst; VAR outMaxFPS: UInt32): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DSpContext_SetState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_SetState(inContext: DSpContextReference; inState: DSpContextState): OSStatus; C;

{
 *  DSpContext_GetState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_GetState(inContext: DSpContextReferenceConst; VAR outState: DSpContextState): OSStatus; C;

{
 *  DSpContext_IsBusy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_IsBusy(inContext: DSpContextReferenceConst; VAR outBusyFlag: BOOLEAN): OSStatus; C;

{ dirty rectangles }
{$IFC CALL_NOT_IN_CARBON }
{
 *  DSpContext_SetDirtyRectGridSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_SetDirtyRectGridSize(inContext: DSpContextReference; inCellPixelWidth: UInt32; inCellPixelHeight: UInt32): OSStatus; C;

{
 *  DSpContext_GetDirtyRectGridSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_GetDirtyRectGridSize(inContext: DSpContextReferenceConst; VAR outCellPixelWidth: UInt32; VAR outCellPixelHeight: UInt32): OSStatus; C;

{
 *  DSpContext_GetDirtyRectGridUnits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_GetDirtyRectGridUnits(inContext: DSpContextReferenceConst; VAR outCellPixelWidth: UInt32; VAR outCellPixelHeight: UInt32): OSStatus; C;

{
 *  DSpContext_InvalBackBufferRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_InvalBackBufferRect(inContext: DSpContextReference; {CONST}VAR inRect: Rect): OSStatus; C;

{ underlays }
{
 *  DSpContext_SetUnderlayAltBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_SetUnderlayAltBuffer(inContext: DSpContextReference; inNewUnderlay: DSpAltBufferReference): OSStatus; C;

{
 *  DSpContext_GetUnderlayAltBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpContext_GetUnderlayAltBuffer(inContext: DSpContextReferenceConst; VAR outUnderlay: DSpAltBufferReference): OSStatus; C;

{ gamma }
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DSpContext_FadeGammaOut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_FadeGammaOut(inContext: DSpContextReference; VAR inZeroIntensityColor: RGBColor): OSStatus; C;

{
 *  DSpContext_FadeGammaIn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_FadeGammaIn(inContext: DSpContextReference; VAR inZeroIntensityColor: RGBColor): OSStatus; C;

{
 *  DSpContext_FadeGamma()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_FadeGamma(inContext: DSpContextReference; inPercentOfOriginalIntensity: SInt32; VAR inZeroIntensityColor: RGBColor): OSStatus; C;

{ buffering }
{
 *  DSpContext_SwapBuffers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_SwapBuffers(inContext: DSpContextReference; inBusyProc: DSpCallbackUPP; inUserRefCon: UNIV Ptr): OSStatus; C;

{
 *  DSpContext_GetBackBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_GetBackBuffer(inContext: DSpContextReference; inBufferKind: DSpBufferKind; VAR outBackBuffer: CGrafPtr): OSStatus; C;

{
 *  DSpContext_GetFrontBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_GetFrontBuffer(inContext: DSpContextReferenceConst; VAR outFrontBuffer: CGrafPtr): OSStatus; C;

{ clut operations }
{
 *  DSpContext_SetCLUTEntries()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_SetCLUTEntries(inContext: DSpContextReference; {CONST}VAR inEntries: ColorSpec; inStartingEntry: UInt16; inLastEntry: UInt16): OSStatus; C;

{
 *  DSpContext_GetCLUTEntries()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DSpContext_GetCLUTEntries(inContext: DSpContextReferenceConst; VAR outEntries: ColorSpec; inStartingEntry: UInt16; inLastEntry: UInt16): OSStatus; C;

{ blit operations }
{$IFC CALL_NOT_IN_CARBON }
{
 *  DSpBlit_Faster()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpBlit_Faster(inBlitInfo: DSpBlitInfoPtr; inAsyncFlag: BOOLEAN): OSStatus; C;

{
 *  DSpBlit_Fastest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DrawSprocketLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DSpBlit_Fastest(inBlitInfo: DSpBlitInfoPtr; inAsyncFlag: BOOLEAN): OSStatus; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DrawSprocketIncludes}

{$ENDC} {__DRAWSPROCKET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
