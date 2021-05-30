{
     File:       Connections.p
 
     Contains:   Communications Toolbox Connection Manager Interfaces.
 
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
 UNIT Connections;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONNECTIONS__}
{$SETC __CONNECTIONS__ := 1}

{$I+}
{$SETC ConnectionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }

CONST
	curCMVersion				= 2;							{  current Connection Manager version }

	curConnEnvRecVers			= 0;							{     current Connection Manager Environment Record version }

																{  CMErr  }
	cmGenericError				= -1;
	cmNoErr						= 0;
	cmRejected					= 1;
	cmFailed					= 2;
	cmTimeOut					= 3;
	cmNotOpen					= 4;
	cmNotClosed					= 5;
	cmNoRequestPending			= 6;
	cmNotSupported				= 7;
	cmNoTools					= 8;
	cmUserCancel				= 9;
	cmUnknownError				= 11;


TYPE
	CMErr								= OSErr;


CONST
	cmData						= $00000001;
	cmCntl						= $00000002;
	cmAttn						= $00000004;
	cmDataNoTimeout				= $00000010;
	cmCntlNoTimeout				= $00000020;
	cmAttnNoTimeout				= $00000040;
	cmDataClean					= $00000100;
	cmCntlClean					= $00000200;
	cmAttnClean					= $00000400;					{        Only for CMRecFlags (not CMChannel) in the rest of this enum   }
	cmNoMenus					= $00010000;
	cmQuiet						= $00020000;
	cmConfigChanged				= $00040000;

	{	 CMRecFlags and CMChannel     	}
	{	      Low word of CMRecFlags is same as CMChannel 	}

TYPE
	CMRecFlags							= LONGINT;
	CMChannel							= INTEGER;



CONST
	cmStatusOpening				= $00000001;
	cmStatusOpen				= $00000002;
	cmStatusClosing				= $00000004;
	cmStatusDataAvail			= $00000008;
	cmStatusCntlAvail			= $00000010;
	cmStatusAttnAvail			= $00000020;
	cmStatusDRPend				= $00000040;					{  data read pending   }
	cmStatusDWPend				= $00000080;					{  data write pending  }
	cmStatusCRPend				= $00000100;					{  cntl read pending   }
	cmStatusCWPend				= $00000200;					{  cntl write pending  }
	cmStatusARPend				= $00000400;					{  attn read pending   }
	cmStatusAWPend				= $00000800;					{  attn write pending  }
	cmStatusBreakPend			= $00001000;
	cmStatusListenPend			= $00002000;
	cmStatusIncomingCallPresent	= $00004000;
	cmStatusReserved0			= $00008000;


TYPE
	CMStatFlags							= UInt32;

CONST
	cmDataIn					= 0;
	cmDataOut					= 1;
	cmCntlIn					= 2;
	cmCntlOut					= 3;
	cmAttnIn					= 4;
	cmAttnOut					= 5;
	cmRsrvIn					= 6;
	cmRsrvOut					= 7;


TYPE
	CMBufFields							= UInt16;
	CMBuffers							= ARRAY [0..7] OF Ptr;
	CMBufferSizes						= ARRAY [0..7] OF LONGINT;
	ConstCMBufferSizesParam				= ^LONGINT;

CONST
	cmSearchSevenBit			= $00000001;


TYPE
	CMSearchFlags						= UInt16;

CONST
	cmFlagsEOM					= $00000001;


TYPE
	CMFlags								= UInt16;
	ConnEnvironRecPtr = ^ConnEnvironRec;
	ConnEnvironRec = RECORD
		version:				INTEGER;
		baudRate:				LONGINT;
		dataBits:				INTEGER;
		channels:				CMChannel;
		swFlowControl:			BOOLEAN;
		hwFlowControl:			BOOLEAN;
		flags:					CMFlags;
	END;

	ConnRecordPtr = ^ConnRecord;
	ConnPtr								= ^ConnRecord;
	ConnHandle							= ^ConnPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ConnectionToolDefProcPtr = FUNCTION(hConn: ConnHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT): LONGINT;
{$ELSEC}
	ConnectionToolDefProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ConnectionSearchCallBackProcPtr = PROCEDURE(hConn: ConnHandle; matchPtr: Ptr; refNum: LONGINT);
{$ELSEC}
	ConnectionSearchCallBackProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ConnectionCompletionProcPtr = PROCEDURE(hConn: ConnHandle);
{$ELSEC}
	ConnectionCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ConnectionChooseIdleProcPtr = PROCEDURE;
{$ELSEC}
	ConnectionChooseIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ConnectionToolDefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ConnectionToolDefUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ConnectionSearchCallBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ConnectionSearchCallBackUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ConnectionCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ConnectionCompletionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ConnectionChooseIdleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ConnectionChooseIdleUPP = UniversalProcPtr;
{$ENDC}	
	ConnRecord = RECORD
		procID:					INTEGER;
		flags:					CMRecFlags;
		errCode:				CMErr;
		refCon:					LONGINT;
		userData:				LONGINT;
		defProc:				ConnectionToolDefUPP;
		config:					Ptr;
		oldConfig:				Ptr;
		asyncEOM:				LONGINT;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		cmPrivate:				Ptr;
		bufferArray:			CMBuffers;
		bufSizes:				CMBufferSizes;
		mluField:				LONGINT;
		asyncCount:				CMBufferSizes;
	END;


CONST
																{  CMIOPB constants and structure  }
	cmIOPBQType					= 10;
	cmIOPBversion				= 0;


TYPE
	CMIOPBPtr = ^CMIOPB;
	CMIOPB = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;								{  cmIOPBQType  }
		hConn:					ConnHandle;
		theBuffer:				Ptr;
		count:					LONGINT;
		flags:					CMFlags;
		userCompletion:			ConnectionCompletionUPP;
		timeout:				LONGINT;
		errCode:				CMErr;
		channel:				CMChannel;
		asyncEOM:				LONGINT;
		reserved1:				LONGINT;
		reserved2:				INTEGER;
		version:				INTEGER;								{  cmIOPBversion  }
		refCon:					LONGINT;								{  for application  }
		toolData1:				LONGINT;								{  for tool  }
		toolData2:				LONGINT;								{  for tool  }
	END;


CONST
	uppConnectionToolDefProcInfo = $0000FEF0;
	uppConnectionSearchCallBackProcInfo = $00000FC0;
	uppConnectionCompletionProcInfo = $000000C0;
	uppConnectionChooseIdleProcInfo = $00000000;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewConnectionToolDefUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewConnectionToolDefUPP(userRoutine: ConnectionToolDefProcPtr): ConnectionToolDefUPP; { old name was NewConnectionToolDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewConnectionSearchCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewConnectionSearchCallBackUPP(userRoutine: ConnectionSearchCallBackProcPtr): ConnectionSearchCallBackUPP; { old name was NewConnectionSearchCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewConnectionCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewConnectionCompletionUPP(userRoutine: ConnectionCompletionProcPtr): ConnectionCompletionUPP; { old name was NewConnectionCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewConnectionChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewConnectionChooseIdleUPP(userRoutine: ConnectionChooseIdleProcPtr): ConnectionChooseIdleUPP; { old name was NewConnectionChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeConnectionToolDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeConnectionToolDefUPP(userUPP: ConnectionToolDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeConnectionSearchCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeConnectionSearchCallBackUPP(userUPP: ConnectionSearchCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeConnectionCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeConnectionCompletionUPP(userUPP: ConnectionCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeConnectionChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeConnectionChooseIdleUPP(userUPP: ConnectionChooseIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeConnectionToolDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeConnectionToolDefUPP(hConn: ConnHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT; userRoutine: ConnectionToolDefUPP): LONGINT; { old name was CallConnectionToolDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeConnectionSearchCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeConnectionSearchCallBackUPP(hConn: ConnHandle; matchPtr: Ptr; refNum: LONGINT; userRoutine: ConnectionSearchCallBackUPP); { old name was CallConnectionSearchCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeConnectionCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeConnectionCompletionUPP(hConn: ConnHandle; userRoutine: ConnectionCompletionUPP); { old name was CallConnectionCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeConnectionChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeConnectionChooseIdleUPP(userRoutine: ConnectionChooseIdleUPP); { old name was CallConnectionChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InitCM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitCM: CMErr;

{
 *  CMGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetVersion(hConn: ConnHandle): Handle;

{
 *  CMGetCMVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetCMVersion: INTEGER;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  CMNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMNew(procID: INTEGER; flags: CMRecFlags; VAR desiredSizes: CMBufferSizes; refCon: LONGINT; userData: LONGINT): ConnHandle;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  CMDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMDispose(hConn: ConnHandle);

{
 *  CMListen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMListen(hConn: ConnHandle; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT): CMErr;

{
 *  CMAccept()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMAccept(hConn: ConnHandle; accept: BOOLEAN): CMErr;

{
 *  CMOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMOpen(hConn: ConnHandle; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT): CMErr;

{
 *  CMClose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMClose(hConn: ConnHandle; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT; now: BOOLEAN): CMErr;

{
 *  CMAbort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMAbort(hConn: ConnHandle): CMErr;

{
 *  CMStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMStatus(hConn: ConnHandle; VAR sizes: CMBufferSizes; VAR flags: CMStatFlags): CMErr;

{
 *  CMIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMIdle(hConn: ConnHandle);

{
 *  CMReset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMReset(hConn: ConnHandle);

{
 *  CMBreak()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMBreak(hConn: ConnHandle; duration: LONGINT; async: BOOLEAN; completor: ConnectionCompletionUPP);

{
 *  CMRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMRead(hConn: ConnHandle; theBuffer: UNIV Ptr; VAR toRead: LONGINT; theChannel: CMChannel; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT; VAR flags: CMFlags): CMErr;

{
 *  CMWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMWrite(hConn: ConnHandle; theBuffer: UNIV Ptr; VAR toWrite: LONGINT; theChannel: CMChannel; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT; flags: CMFlags): CMErr;

{
 *  CMIOKill()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMIOKill(hConn: ConnHandle; which: INTEGER): CMErr;

{
 *  CMActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMActivate(hConn: ConnHandle; activate: BOOLEAN);

{
 *  CMResume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMResume(hConn: ConnHandle; resume: BOOLEAN);

{
 *  CMMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMMenu(hConn: ConnHandle; menuID: INTEGER; item: INTEGER): BOOLEAN;

{
 *  CMValidate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMValidate(hConn: ConnHandle): BOOLEAN;

{
 *  CMDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMDefault(VAR theConfig: Ptr; procID: INTEGER; allocate: BOOLEAN);

{
 *  CMSetupPreflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMSetupPreflight(procID: INTEGER; VAR magicCookie: LONGINT): Handle;

{
 *  CMSetupFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMSetupFilter(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; VAR theEvent: EventRecord; VAR theItem: INTEGER; VAR magicCookie: LONGINT): BOOLEAN;

{
 *  CMSetupSetup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMSetupSetup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; VAR magicCookie: LONGINT);

{
 *  CMSetupItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMSetupItem(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; VAR theItem: INTEGER; VAR magicCookie: LONGINT);

{
 *  CMSetupXCleanup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMSetupXCleanup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; OKed: BOOLEAN; VAR magicCookie: LONGINT);

{
 *  CMSetupPostflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMSetupPostflight(procID: INTEGER);

{
 *  CMGetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetConfig(hConn: ConnHandle): Ptr;

{
 *  CMSetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMSetConfig(hConn: ConnHandle; thePtr: UNIV Ptr): INTEGER;

{
 *  CMIntlToEnglish()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMIntlToEnglish(hConn: ConnHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;

{
 *  CMEnglishToIntl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMEnglishToIntl(hConn: ConnHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;

{
 *  CMAddSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMAddSearch(hConn: ConnHandle; theString: Str255; flags: CMSearchFlags; callBack: ConnectionSearchCallBackUPP): LONGINT;

{
 *  CMRemoveSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMRemoveSearch(hConn: ConnHandle; refnum: LONGINT);

{
 *  CMClearSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMClearSearch(hConn: ConnHandle);

{
 *  CMGetConnEnvirons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetConnEnvirons(hConn: ConnHandle; VAR theEnvirons: ConnEnvironRec): CMErr;

{
 *  CMChoose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMChoose(VAR hConn: ConnHandle; where: Point; idle: ConnectionChooseIdleUPP): INTEGER;

{
 *  CMEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMEvent(hConn: ConnHandle; {CONST}VAR theEvent: EventRecord);

{
 *  CMGetToolName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMGetToolName(procID: INTEGER; VAR name: Str255);

{
 *  CMGetProcID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetProcID(name: Str255): INTEGER;

{
 *  CMSetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMSetRefCon(hConn: ConnHandle; refCon: LONGINT);

{
 *  CMGetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetRefCon(hConn: ConnHandle): LONGINT;

{
 *  CMGetUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetUserData(hConn: ConnHandle): LONGINT;

{
 *  CMSetUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMSetUserData(hConn: ConnHandle; userData: LONGINT);

{
 *  CMGetErrorString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CMGetErrorString(hConn: ConnHandle; id: INTEGER; VAR errMsg: Str255);

{
 *  CMNewIOPB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMNewIOPB(hConn: ConnHandle; VAR theIOPB: CMIOPBPtr): CMErr;

{
 *  CMDisposeIOPB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMDisposeIOPB(hConn: ConnHandle; theIOPB: CMIOPBPtr): CMErr;

{
 *  CMPBRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMPBRead(hConn: ConnHandle; theIOPB: CMIOPBPtr; async: BOOLEAN): CMErr;

{
 *  CMPBWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMPBWrite(hConn: ConnHandle; theIOPB: CMIOPBPtr; async: BOOLEAN): CMErr;

{
 *  CMPBIOKill()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMPBIOKill(hConn: ConnHandle; theIOPB: CMIOPBPtr): CMErr;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ConnectionsIncludes}

{$ENDC} {__CONNECTIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
