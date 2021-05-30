{
     File:       Terminals.p
 
     Contains:   Communications Toolbox Terminal tool Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1988-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Terminals;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TERMINALS__}
{$SETC __TERMINALS__ := 1}

{$I+}
{$SETC TerminalsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __CTBUTILITIES__}
{$I CTBUtilities.p}
{$ENDC}
{$IFC UNDEFINED __CONNECTIONS__}
{$I Connections.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }

CONST
	curTMVersion				= 2;							{  current Terminal Manager version  }

	curTermEnvRecVers			= 0;							{  current Terminal Manager Environment Record version  }

																{  error codes     }
	tmGenericError				= -1;
	tmNoErr						= 0;
	tmNotSent					= 1;
	tmEnvironsChanged			= 2;
	tmNotSupported				= 7;
	tmNoTools					= 8;


TYPE
	TMErr								= OSErr;
	TMFlags 					= UInt32;
CONST
	tmInvisible					= $01;
	tmSaveBeforeClear			= $02;
	tmNoMenus					= $04;
	tmAutoScroll				= $08;
	tmConfigChanged				= $10;


TYPE
	TMSelTypes 					= SInt16;
CONST
	selTextNormal				= $01;
	selTextBoxed				= $02;
	selGraphicsMarquee			= $04;
	selGraphicsLasso			= $08;


TYPE
	TMSearchTypes 				= UInt16;
CONST
	tmSearchNoDiacrit			= $0100;
	tmSearchNoCase				= $0200;


TYPE
	TMCursorTypes 				= UInt16;
CONST
	cursorText					= 1;
	cursorGraphics				= 2;


TYPE
	TMTermTypes 				= UInt16;
CONST
	tmTextTerminal				= $01;
	tmGraphicsTerminal			= $02;


TYPE
	TermDataBlockPtr = ^TermDataBlock;
	TermDataBlock = RECORD
		flags:					TMTermTypes;
		theData:				Handle;
		auxData:				Handle;
		reserved:				LONGINT;
	END;

	TermDataBlockH						= ^TermDataBlockPtr;
	TermDataBlockHandle					= ^TermDataBlockPtr;
	TermEnvironRecPtr = ^TermEnvironRec;
	TermEnvironRec = RECORD
		version:				INTEGER;
		termType:				TMTermTypes;
		textRows:				INTEGER;
		textCols:				INTEGER;
		cellSize:				Point;
		graphicSize:			Rect;
		slop:					Point;
		auxSpace:				Rect;
	END;

	TermEnvironPtr						= ^TermEnvironRec;
	TMSelectionPtr = ^TMSelection;
	TMSelection = RECORD
		CASE INTEGER OF
		0: (
			selRect:			Rect;
			);
		1: (
			selRgnHandle:		RgnHandle;
			);
	END;

	TermRecordPtr = ^TermRecord;
	TermPtr								= ^TermRecord;
	TermHandle							= ^TermPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	TerminalSendProcPtr = FUNCTION(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; flags: CMFlags): LONGINT;
{$ELSEC}
	TerminalSendProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalBreakProcPtr = PROCEDURE(duration: LONGINT; refCon: LONGINT);
{$ELSEC}
	TerminalBreakProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalCacheProcPtr = FUNCTION(refCon: LONGINT; theTermData: TermDataBlockPtr): LONGINT;
{$ELSEC}
	TerminalCacheProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalSearchCallBackProcPtr = PROCEDURE(hTerm: TermHandle; refNum: INTEGER; VAR foundRect: Rect);
{$ELSEC}
	TerminalSearchCallBackProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalClikLoopProcPtr = FUNCTION(refCon: LONGINT): BOOLEAN;
{$ELSEC}
	TerminalClikLoopProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalEnvironsProcPtr = FUNCTION(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec): CMErr;
{$ELSEC}
	TerminalEnvironsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalChooseIdleProcPtr = PROCEDURE;
{$ELSEC}
	TerminalChooseIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TerminalToolDefProcPtr = FUNCTION(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT): LONGINT;
{$ELSEC}
	TerminalToolDefProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TerminalSendUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TerminalSendUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TerminalBreakUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TerminalBreakUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TerminalCacheUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TerminalCacheUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TerminalSearchCallBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TerminalSearchCallBackUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TerminalClikLoopUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TerminalClikLoopUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TerminalEnvironsUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TerminalEnvironsUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TerminalChooseIdleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TerminalChooseIdleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TerminalToolDefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TerminalToolDefUPP = UniversalProcPtr;
{$ENDC}	
	{	    TMTermTypes     	}
	TermRecord = RECORD
		procID:					INTEGER;
		flags:					TMFlags;
		errCode:				TMErr;
		refCon:					LONGINT;
		userData:				LONGINT;
		defProc:				TerminalToolDefUPP;
		config:					Ptr;
		oldConfig:				Ptr;
		environsProc:			TerminalEnvironsUPP;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		tmPrivate:				Ptr;
		sendProc:				TerminalSendUPP;
		breakProc:				TerminalBreakUPP;
		cacheProc:				TerminalCacheUPP;
		clikLoop:				TerminalClikLoopUPP;
		owner:					WindowRef;
		termRect:				Rect;
		viewRect:				Rect;
		visRect:				Rect;
		lastIdle:				LONGINT;
		selection:				TMSelection;
		selType:				TMSelTypes;
		mluField:				LONGINT;
	END;

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	uppTerminalSendProcInfo = $00002FF0;
	uppTerminalBreakProcInfo = $000003C0;
	uppTerminalCacheProcInfo = $000003F0;
	uppTerminalSearchCallBackProcInfo = $00000EC0;
	uppTerminalClikLoopProcInfo = $000000D0;
	uppTerminalEnvironsProcInfo = $000003E0;
	uppTerminalChooseIdleProcInfo = $00000000;
	uppTerminalToolDefProcInfo = $0000FEF0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewTerminalSendUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewTerminalSendUPP(userRoutine: TerminalSendProcPtr): TerminalSendUPP; { old name was NewTerminalSendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTerminalBreakUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTerminalBreakUPP(userRoutine: TerminalBreakProcPtr): TerminalBreakUPP; { old name was NewTerminalBreakProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTerminalCacheUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTerminalCacheUPP(userRoutine: TerminalCacheProcPtr): TerminalCacheUPP; { old name was NewTerminalCacheProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTerminalSearchCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTerminalSearchCallBackUPP(userRoutine: TerminalSearchCallBackProcPtr): TerminalSearchCallBackUPP; { old name was NewTerminalSearchCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTerminalClikLoopUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTerminalClikLoopUPP(userRoutine: TerminalClikLoopProcPtr): TerminalClikLoopUPP; { old name was NewTerminalClikLoopProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTerminalEnvironsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTerminalEnvironsUPP(userRoutine: TerminalEnvironsProcPtr): TerminalEnvironsUPP; { old name was NewTerminalEnvironsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTerminalChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTerminalChooseIdleUPP(userRoutine: TerminalChooseIdleProcPtr): TerminalChooseIdleUPP; { old name was NewTerminalChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTerminalToolDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTerminalToolDefUPP(userRoutine: TerminalToolDefProcPtr): TerminalToolDefUPP; { old name was NewTerminalToolDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeTerminalSendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTerminalSendUPP(userUPP: TerminalSendUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTerminalBreakUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTerminalBreakUPP(userUPP: TerminalBreakUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTerminalCacheUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTerminalCacheUPP(userUPP: TerminalCacheUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTerminalSearchCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTerminalSearchCallBackUPP(userUPP: TerminalSearchCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTerminalClikLoopUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTerminalClikLoopUPP(userUPP: TerminalClikLoopUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTerminalEnvironsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTerminalEnvironsUPP(userUPP: TerminalEnvironsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTerminalChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTerminalChooseIdleUPP(userUPP: TerminalChooseIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTerminalToolDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTerminalToolDefUPP(userUPP: TerminalToolDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeTerminalSendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeTerminalSendUPP(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; flags: CMFlags; userRoutine: TerminalSendUPP): LONGINT; { old name was CallTerminalSendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTerminalBreakUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeTerminalBreakUPP(duration: LONGINT; refCon: LONGINT; userRoutine: TerminalBreakUPP); { old name was CallTerminalBreakProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTerminalCacheUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeTerminalCacheUPP(refCon: LONGINT; theTermData: TermDataBlockPtr; userRoutine: TerminalCacheUPP): LONGINT; { old name was CallTerminalCacheProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTerminalSearchCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeTerminalSearchCallBackUPP(hTerm: TermHandle; refNum: INTEGER; VAR foundRect: Rect; userRoutine: TerminalSearchCallBackUPP); { old name was CallTerminalSearchCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTerminalClikLoopUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeTerminalClikLoopUPP(refCon: LONGINT; userRoutine: TerminalClikLoopUPP): BOOLEAN; { old name was CallTerminalClikLoopProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTerminalEnvironsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeTerminalEnvironsUPP(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec; userRoutine: TerminalEnvironsUPP): CMErr; { old name was CallTerminalEnvironsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTerminalChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeTerminalChooseIdleUPP(userRoutine: TerminalChooseIdleUPP); { old name was CallTerminalChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTerminalToolDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeTerminalToolDefUPP(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT; userRoutine: TerminalToolDefUPP): LONGINT; { old name was CallTerminalToolDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InitTM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitTM: TMErr;

{
 *  TMGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMGetVersion(hTerm: TermHandle): Handle;

{
 *  TMGetTMVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMGetTMVersion: INTEGER;

{
 *  TMNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMNew({CONST}VAR termRect: Rect; {CONST}VAR viewRect: Rect; flags: TMFlags; procID: INTEGER; owner: WindowRef; sendProc: TerminalSendUPP; cacheProc: TerminalCacheUPP; breakProc: TerminalBreakUPP; clikLoop: TerminalClikLoopUPP; environsProc: TerminalEnvironsUPP; refCon: LONGINT; userData: LONGINT): TermHandle;

{
 *  TMDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMDispose(hTerm: TermHandle);

{
 *  TMKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMKey(hTerm: TermHandle; {CONST}VAR theEvent: EventRecord);

{
 *  TMUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMUpdate(hTerm: TermHandle; visRgn: RgnHandle);

{
 *  TMPaint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMPaint(hTerm: TermHandle; {CONST}VAR theTermData: TermDataBlock; {CONST}VAR theRect: Rect);

{
 *  TMActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMActivate(hTerm: TermHandle; activate: BOOLEAN);

{
 *  TMResume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMResume(hTerm: TermHandle; resume: BOOLEAN);

{
 *  TMClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMClick(hTerm: TermHandle; {CONST}VAR theEvent: EventRecord);

{
 *  TMIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMIdle(hTerm: TermHandle);

{
 *  TMStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMStream(hTerm: TermHandle; theBuffer: UNIV Ptr; theLength: LONGINT; flags: CMFlags): LONGINT;

{
 *  TMMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMMenu(hTerm: TermHandle; menuID: INTEGER; item: INTEGER): BOOLEAN;

{
 *  TMReset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMReset(hTerm: TermHandle);

{
 *  TMClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMClear(hTerm: TermHandle);

{
 *  TMResize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMResize(hTerm: TermHandle; {CONST}VAR newViewRect: Rect);

{
 *  TMGetSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMGetSelect(hTerm: TermHandle; theData: Handle; VAR theType: ResType): LONGINT;

{
 *  TMGetLine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMGetLine(hTerm: TermHandle; lineNo: INTEGER; VAR theTermData: TermDataBlock);

{
 *  TMSetSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMSetSelection(hTerm: TermHandle; {CONST}VAR theSelection: TMSelection; selType: TMSelTypes);

{
 *  TMScroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMScroll(hTerm: TermHandle; dh: INTEGER; dv: INTEGER);

{
 *  TMValidate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMValidate(hTerm: TermHandle): BOOLEAN;

{
 *  TMDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMDefault(VAR theConfig: Ptr; procID: INTEGER; allocate: BOOLEAN);

{
 *  TMSetupPreflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMSetupPreflight(procID: INTEGER; VAR magicCookie: LONGINT): Handle;

{
 *  TMSetupSetup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMSetupSetup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; VAR magicCookie: LONGINT);

{
 *  TMSetupFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMSetupFilter(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; VAR theEvent: EventRecord; VAR theItem: INTEGER; VAR magicCookie: LONGINT): BOOLEAN;

{
 *  TMSetupItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMSetupItem(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; VAR theItem: INTEGER; VAR magicCookie: LONGINT);

{
 *  TMSetupXCleanup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMSetupXCleanup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; OKed: BOOLEAN; VAR magicCookie: LONGINT);

{
 *  TMSetupPostflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMSetupPostflight(procID: INTEGER);

{
 *  TMGetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMGetConfig(hTerm: TermHandle): Ptr;

{
 *  TMSetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMSetConfig(hTerm: TermHandle; thePtr: UNIV Ptr): INTEGER;

{
 *  TMIntlToEnglish()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMIntlToEnglish(hTerm: TermHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;

{
 *  TMEnglishToIntl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMEnglishToIntl(hTerm: TermHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;

{
 *  TMGetToolName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMGetToolName(id: INTEGER; VAR name: Str255);

{
 *  TMGetProcID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMGetProcID(name: Str255): INTEGER;

{
 *  TMSetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMSetRefCon(hTerm: TermHandle; refCon: LONGINT);

{
 *  TMGetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMGetRefCon(hTerm: TermHandle): LONGINT;

{
 *  TMSetUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMSetUserData(hTerm: TermHandle; userData: LONGINT);

{
 *  TMGetUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMGetUserData(hTerm: TermHandle): LONGINT;

{
 *  TMAddSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMAddSearch(hTerm: TermHandle; theString: Str255; {CONST}VAR where: Rect; searchType: TMSearchTypes; callBack: TerminalSearchCallBackUPP): INTEGER;

{
 *  TMRemoveSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMRemoveSearch(hTerm: TermHandle; refnum: INTEGER);

{
 *  TMClearSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMClearSearch(hTerm: TermHandle);

{
 *  TMGetCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMGetCursor(hTerm: TermHandle; cursType: TMCursorTypes): Point;

{
 *  TMGetTermEnvirons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMGetTermEnvirons(hTerm: TermHandle; VAR theEnvirons: TermEnvironRec): TMErr;

{
 *  TMChoose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMChoose(VAR hTerm: TermHandle; where: Point; idleProc: TerminalChooseIdleUPP): INTEGER;

{
 *  TMEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMEvent(hTerm: TermHandle; {CONST}VAR theEvent: EventRecord);

{
 *  TMDoTermKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMDoTermKey(hTerm: TermHandle; theKey: Str255): BOOLEAN;

{
 *  TMCountTermKeys()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TMCountTermKeys(hTerm: TermHandle): INTEGER;

{
 *  TMGetIndTermKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMGetIndTermKey(hTerm: TermHandle; id: INTEGER; VAR theKey: Str255);

{
 *  TMGetErrorString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TMGetErrorString(hTerm: TermHandle; id: INTEGER; VAR errMsg: Str255);


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TerminalsIncludes}

{$ENDC} {__TERMINALS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
