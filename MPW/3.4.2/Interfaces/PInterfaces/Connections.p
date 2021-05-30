{
 	File:		Connections.p
 
 	Contains:	Communications Toolbox Connection Manager Interfaces.
 
 	Version:	Technology:	System 7.5
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
 UNIT Connections;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONNECTIONS__}
{$SETC __CONNECTIONS__ := 1}

{$I+}
{$SETC ConnectionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	Memory.p													}
{		MixedMode.p												}
{	Quickdraw.p													}
{		QuickdrawText.p											}
{	Events.p													}
{		OSUtils.p												}
{	Controls.p													}
{		Menus.p													}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	Errors.p													}
{	TextEdit.p													}

{$IFC UNDEFINED __CTBUTILITIES__}
{$I CTBUtilities.p}
{$ENDC}
{	StandardFile.p												}
{		Files.p													}
{			Finder.p											}
{	AppleTalk.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{	current Connection Manager version	}
	curCMVersion				= 2;
{	current Connection Manager Environment Record version 	}
	curConnEnvRecVers			= 0;
{ CMErr }
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
	CMErr = OSErr;


CONST
	cmData						= 1 * (2**(0));
	cmCntl						= 1 * (2**(1));
	cmAttn						= 1 * (2**(2));
	cmDataNoTimeout				= 1 * (2**(4));
	cmCntlNoTimeout				= 1 * (2**(5));
	cmAttnNoTimeout				= 1 * (2**(6));
	cmDataClean					= 1 * (2**(8));
	cmCntlClean					= 1 * (2**(9));
	cmAttnClean					= 1 * (2**(10));
{		Only for CMRecFlags (not CMChannel) in the rest of this enum	}
	cmNoMenus					= 1 * (2**(16));
	cmQuiet						= 1 * (2**(17));
	cmConfigChanged				= 1 * (2**(18));

{ CMRecFlags and CMChannel		}
{		Low word of CMRecFlags is same as CMChannel	}
	
TYPE
	CMRecFlags = LONGINT;

	CMChannel = INTEGER;


CONST
	cmStatusOpening				= 1 * (2**(0));
	cmStatusOpen				= 1 * (2**(1));
	cmStatusClosing				= 1 * (2**(2));
	cmStatusDataAvail			= 1 * (2**(3));
	cmStatusCntlAvail			= 1 * (2**(4));
	cmStatusAttnAvail			= 1 * (2**(5));
	cmStatusDRPend				= 1 * (2**(6));					{ data read pending	}
	cmStatusDWPend				= 1 * (2**(7));					{ data write pending	}
	cmStatusCRPend				= 1 * (2**(8));					{ cntl read pending	}
	cmStatusCWPend				= 1 * (2**(9));					{ cntl write pending	}
	cmStatusARPend				= 1 * (2**(10));				{ attn read pending	}
	cmStatusAWPend				= 1 * (2**(11));				{ attn write pending	}
	cmStatusBreakPend			= 1 * (2**(12));
	cmStatusListenPend			= 1 * (2**(13));
	cmStatusIncomingCallPresent	= 1 * (2**(14));
	cmStatusReserved0			= 1 * (2**(15));

	
TYPE
	CMStatFlags = LONGINT;


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
	CMBufFields = INTEGER;

	CMBuffers = ARRAY [0..7] OF Ptr;

	CMBufferSizes = ARRAY [0..7] OF LONGINT;


CONST
	cmSearchSevenBit			= 1 * (2**(0));

	
TYPE
	CMSearchFlags = INTEGER;


CONST
	cmFlagsEOM					= 1 * (2**(0));

	
TYPE
	CMFlags = INTEGER;

	ConnEnvironRec = RECORD
		version:				INTEGER;
		baudRate:				LONGINT;
		dataBits:				INTEGER;
		channels:				CMChannel;
		swFlowControl:			BOOLEAN;
		hwFlowControl:			BOOLEAN;
		flags:					CMFlags;
	END;

	ConnEnvironRecPtr = ^ConnEnvironRec;

	ConnPtr = ^ConnRecord;
	ConnHandle = ^ConnPtr;

	ConnectionToolDefProcPtr = ProcPtr;  { FUNCTION ConnectionToolDef(hConn: ConnHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT): LONGINT; }
	ConnectionSearchCallBackProcPtr = ProcPtr;  { PROCEDURE ConnectionSearchCallBack(hConn: ConnHandle; matchPtr: Ptr; refNum: LONGINT); }
	ConnectionCompletionProcPtr = ProcPtr;  { PROCEDURE ConnectionCompletion(hConn: ConnHandle); }
	ConnectionChooseIdleProcPtr = ProcPtr;  { PROCEDURE ConnectionChooseIdle; }
	ConnectionToolDefUPP = UniversalProcPtr;
	ConnectionSearchCallBackUPP = UniversalProcPtr;
	ConnectionCompletionUPP = UniversalProcPtr;
	ConnectionChooseIdleUPP = UniversalProcPtr;

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
{ CMIOPB constants and structure }
	cmIOPBQType					= 10;
	cmIOPBversion				= 0;


TYPE
	CMIOPB = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;								{ cmIOPBQType }
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
		version:				INTEGER;								{ cmIOPBversion }
		refCon:					LONGINT;								{ for application }
		toolData1:				LONGINT;								{ for tool }
		toolData2:				LONGINT;								{ for tool }
	END;

	CMIOPBPtr = ^CMIOPB;

CONST
	uppConnectionToolDefProcInfo = $0000FEF0; { FUNCTION (4 byte param, 2 byte param, 4 byte param, 4 byte param, 4 byte param): 4 byte result; }
	uppConnectionSearchCallBackProcInfo = $00000FC0; { PROCEDURE (4 byte param, 4 byte param, 4 byte param); }
	uppConnectionCompletionProcInfo = $000000C0; { PROCEDURE (4 byte param); }
	uppConnectionChooseIdleProcInfo = $00000000; { PROCEDURE ; }

FUNCTION CallConnectionToolDefProc(hConn: ConnHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT; userRoutine: ConnectionToolDefUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallConnectionSearchCallBackProc(hConn: ConnHandle; matchPtr: Ptr; refNum: LONGINT; userRoutine: ConnectionSearchCallBackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallConnectionCompletionProc(hConn: ConnHandle; userRoutine: ConnectionCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallConnectionChooseIdleProc(userRoutine: ConnectionChooseIdleUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewConnectionToolDefProc(userRoutine: ConnectionToolDefProcPtr): ConnectionToolDefUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewConnectionSearchCallBackProc(userRoutine: ConnectionSearchCallBackProcPtr): ConnectionSearchCallBackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewConnectionCompletionProc(userRoutine: ConnectionCompletionProcPtr): ConnectionCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewConnectionChooseIdleProc(userRoutine: ConnectionChooseIdleProcPtr): ConnectionChooseIdleUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION InitCM: CMErr;
FUNCTION CMGetVersion(hConn: ConnHandle): Handle;
FUNCTION CMGetCMVersion: INTEGER;
FUNCTION CMNew(procID: INTEGER; flags: CMRecFlags; VAR desiredSizes: CMBufferSizes; refCon: LONGINT; userData: LONGINT): ConnHandle;
PROCEDURE CMDispose(hConn: ConnHandle);
FUNCTION CMListen(hConn: ConnHandle; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT): CMErr;
FUNCTION CMAccept(hConn: ConnHandle; accept: BOOLEAN): CMErr;
FUNCTION CMOpen(hConn: ConnHandle; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT): CMErr;
FUNCTION CMClose(hConn: ConnHandle; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT; now: BOOLEAN): CMErr;
FUNCTION CMAbort(hConn: ConnHandle): CMErr;
FUNCTION CMStatus(hConn: ConnHandle; VAR sizes: CMBufferSizes; VAR flags: CMStatFlags): CMErr;
PROCEDURE CMIdle(hConn: ConnHandle);
PROCEDURE CMReset(hConn: ConnHandle);
PROCEDURE CMBreak(hConn: ConnHandle; duration: LONGINT; async: BOOLEAN; completor: ConnectionCompletionUPP);
FUNCTION CMRead(hConn: ConnHandle; theBuffer: UNIV Ptr; VAR toRead: LONGINT; theChannel: CMChannel; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT; VAR flags: CMFlags): CMErr;
FUNCTION CMWrite(hConn: ConnHandle; theBuffer: UNIV Ptr; VAR toWrite: LONGINT; theChannel: CMChannel; async: BOOLEAN; completor: ConnectionCompletionUPP; timeout: LONGINT; flags: CMFlags): CMErr;
FUNCTION CMIOKill(hConn: ConnHandle; which: INTEGER): CMErr;
PROCEDURE CMActivate(hConn: ConnHandle; activate: BOOLEAN);
PROCEDURE CMResume(hConn: ConnHandle; resume: BOOLEAN);
FUNCTION CMMenu(hConn: ConnHandle; menuID: INTEGER; item: INTEGER): BOOLEAN;
FUNCTION CMValidate(hConn: ConnHandle): BOOLEAN;
PROCEDURE CMDefault(VAR theConfig: Ptr; procID: INTEGER; allocate: BOOLEAN);
FUNCTION CMSetupPreflight(procID: INTEGER; VAR magicCookie: LONGINT): Handle;
FUNCTION CMSetupFilter(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR theEvent: EventRecord; VAR theItem: INTEGER; VAR magicCookie: LONGINT): BOOLEAN;
PROCEDURE CMSetupSetup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR magicCookie: LONGINT);
PROCEDURE CMSetupItem(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR theItem: INTEGER; VAR magicCookie: LONGINT);
PROCEDURE CMSetupXCleanup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; OKed: BOOLEAN; VAR magicCookie: LONGINT);
PROCEDURE CMSetupPostflight(procID: INTEGER);
FUNCTION CMGetConfig(hConn: ConnHandle): Ptr;
FUNCTION CMSetConfig(hConn: ConnHandle; thePtr: UNIV Ptr): INTEGER;
FUNCTION CMIntlToEnglish(hConn: ConnHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;
FUNCTION CMEnglishToIntl(hConn: ConnHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): OSErr;
FUNCTION CMAddSearch(hConn: ConnHandle; theString: ConstStr255Param; flags: CMSearchFlags; callBack: ConnectionSearchCallBackUPP): LONGINT;
PROCEDURE CMRemoveSearch(hConn: ConnHandle; refnum: LONGINT);
PROCEDURE CMClearSearch(hConn: ConnHandle);
FUNCTION CMGetConnEnvirons(hConn: ConnHandle; VAR theEnvirons: ConnEnvironRec): CMErr;
FUNCTION CMChoose(VAR hConn: ConnHandle; where: Point; idle: ConnectionChooseIdleUPP): INTEGER;
PROCEDURE CMEvent(hConn: ConnHandle; {CONST}VAR theEvent: EventRecord);
PROCEDURE CMGetToolName(procID: INTEGER; VAR name: Str255);
FUNCTION CMGetProcID(name: ConstStr255Param): INTEGER;
PROCEDURE CMSetRefCon(hConn: ConnHandle; refCon: LONGINT);
FUNCTION CMGetRefCon(hConn: ConnHandle): LONGINT;
FUNCTION CMGetUserData(hConn: ConnHandle): LONGINT;
PROCEDURE CMSetUserData(hConn: ConnHandle; userData: LONGINT);
PROCEDURE CMGetErrorString(hConn: ConnHandle; id: INTEGER; VAR errMsg: Str255);
FUNCTION CMNewIOPB(hConn: ConnHandle; VAR theIOPB: CMIOPBPtr): CMErr;
FUNCTION CMDisposeIOPB(hConn: ConnHandle; theIOPB: CMIOPBPtr): CMErr;
FUNCTION CMPBRead(hConn: ConnHandle; theIOPB: CMIOPBPtr; async: BOOLEAN): CMErr;
FUNCTION CMPBWrite(hConn: ConnHandle; theIOPB: CMIOPBPtr; async: BOOLEAN): CMErr;
FUNCTION CMPBIOKill(hConn: ConnHandle; theIOPB: CMIOPBPtr): CMErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ConnectionsIncludes}

{$ENDC} {__CONNECTIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
