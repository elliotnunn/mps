{
 	File:		FileTransfers.p
 
 	Contains:	CommToolbox File Transfer Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
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
 UNIT FileTransfers;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FILETRANSFERS__}
{$SETC __FILETRANSFERS__ := 1}

{$I+}
{$SETC FileTransfersIncludes := UsingIncludes}
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

{$IFC UNDEFINED __CTBUTILITIES__}
{$I CTBUtilities.p}
{$ENDC}
{	Dialogs.p													}
{		Errors.p												}
{		TextEdit.p												}
{	StandardFile.p												}
{		Files.p													}
{			Finder.p											}
{	AppleTalk.p													}

{$IFC UNDEFINED __CONNECTIONS__}
{$I Connections.p}
{$ENDC}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}

{$IFC UNDEFINED __TERMINALS__}
{$I Terminals.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ current file transfer manager version	}
	curFTVersion				= 2;
{ FTErr    }
	ftGenericError				= -1;
	ftNoErr						= 0;
	ftRejected					= 1;
	ftFailed					= 2;
	ftTimeOut					= 3;
	ftTooManyRetry				= 4;
	ftNotEnoughDSpace			= 5;
	ftRemoteCancel				= 6;
	ftWrongFormat				= 7;
	ftNoTools					= 8;
	ftUserCancel				= 9;
	ftNotSupported				= 10;

	
TYPE
	FTErr = OSErr;


CONST
	ftIsFTMode					= 1 * (2**(0));
	ftNoMenus					= 1 * (2**(1));
	ftQuiet						= 1 * (2**(2));
	ftConfigChanged				= 1 * (2**(4));
	ftSucc						= 1 * (2**(7));

	
TYPE
	FTFlags = LONGINT;


CONST
	ftSameCircuit				= 1 * (2**(0));
	ftSendDisable				= 1 * (2**(1));
	ftReceiveDisable			= 1 * (2**(2));
	ftTextOnly					= 1 * (2**(3));
	ftNoStdFile					= 1 * (2**(4));
	ftMultipleFileSend			= 1 * (2**(5));

	
TYPE
	FTAttributes = INTEGER;


CONST
	ftReceiving					= 0;
	ftTransmitting				= 1;
	ftFullDuplex 				= 2;							{ (16) added ftFullDuplex bit }
	
TYPE
	FTDirection = INTEGER;

{	application routines type definitions }
	FTPtr = ^FTRecord;
	FTHandle = ^FTPtr;

	FileTransferDefProcPtr = ProcPtr;  { FUNCTION FileTransferDef(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT): LONGINT; }
	FileTransferReadProcPtr = ProcPtr;  { FUNCTION FileTransferRead(VAR count: LONGINT; pData: Ptr; refCon: LONGINT; fileMsg: INTEGER): OSErr; }
	FileTransferWriteProcPtr = ProcPtr;  { FUNCTION FileTransferWrite(VAR count: LONGINT; pData: Ptr; refCon: LONGINT; fileMsg: INTEGER): OSErr; }
	FileTransferSendProcPtr = ProcPtr;  { FUNCTION FileTransferSend(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; channel: CMChannel; flag: CMFlags): Size; }
	FileTransferReceiveProcPtr = ProcPtr;  { FUNCTION FileTransferReceive(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; channel: CMChannel; VAR flag: CMFlags): Size; }
	FileTransferEnvironsProcPtr = ProcPtr;  { FUNCTION FileTransferEnvirons(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec): OSErr; }
	FileTransferNotificationProcPtr = ProcPtr;  { PROCEDURE FileTransferNotification(hFT: FTHandle; (CONST)VAR pFSSpec: FSSpec); }
	FileTransferChooseIdleProcPtr = ProcPtr;  { PROCEDURE FileTransferChooseIdle; }
	FileTransferDefUPP = UniversalProcPtr;
	FileTransferReadUPP = UniversalProcPtr;
	FileTransferWriteUPP = UniversalProcPtr;
	FileTransferSendUPP = UniversalProcPtr;
	FileTransferReceiveUPP = UniversalProcPtr;
	FileTransferEnvironsUPP = UniversalProcPtr;
	FileTransferNotificationUPP = UniversalProcPtr;
	FileTransferChooseIdleUPP = UniversalProcPtr;

	FTRecord = PACKED RECORD
		procID:					INTEGER;
		flags:					FTFlags;
		errCode:				FTErr;
		refCon:					LONGINT;
		userData:				LONGINT;
		defProc:				FileTransferDefUPP;
		config:					Ptr;
		oldConfig:				Ptr;
		environsProc:			FileTransferEnvironsUPP;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ftPrivate:				Ptr;
		sendProc:				FileTransferSendUPP;
		recvProc:				FileTransferReceiveUPP;
		writeProc:				FileTransferWriteUPP;
		readProc:				FileTransferReadUPP;
		owner:					WindowPtr;
		direction:				FTDirection;
		theReply:				SFReply;
		writePtr:				LONGINT;
		readPtr:				LONGINT;
		theBuf:					^CHAR;
		bufSize:				LONGINT;
		autoRec:				Str255;
		attributes:				FTAttributes;
	END;


CONST
{ FTReadProc messages }
	ftReadOpenFile				= 0;							{ count = forkFlags, buffer = pblock from PBGetFInfo }
	ftReadDataFork				= 1;
	ftReadRsrcFork				= 2;
	ftReadAbort					= 3;
	ftReadComplete				= 4;
	ftReadSetFPos				= 6;							{ count = forkFlags, buffer = pBlock same as PBSetFPos }
	ftReadGetFPos				= 7;							{ count = forkFlags, buffer = pBlock same as PBGetFPos }
{ FTWriteProc messages }
	ftWriteOpenFile				= 0;							{ count = forkFlags, buffer = pblock from PBGetFInfo }
	ftWriteDataFork				= 1;
	ftWriteRsrcFork				= 2;
	ftWriteAbort				= 3;
	ftWriteComplete				= 4;
	ftWriteFileInfo				= 5;
	ftWriteSetFPos				= 6;							{ count = forkFlags, buffer = pBlock same as PBSetFPos }
	ftWriteGetFPos				= 7;							{ count = forkFlags, buffer = pBlock same as PBGetFPos }
{	fork flags }
	ftOpenDataFork				= 1;
	ftOpenRsrcFork				= 2;

	uppFileTransferDefProcInfo = $0000FEF0; { FUNCTION (4 byte param, 2 byte param, 4 byte param, 4 byte param, 4 byte param): 4 byte result; }
	uppFileTransferReadProcInfo = $00002FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 2 byte param): 2 byte result; }
	uppFileTransferWriteProcInfo = $00002FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 2 byte param): 2 byte result; }
	uppFileTransferSendProcInfo = $0000AFF0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 2 byte param, 2 byte param): 4 byte result; }
	uppFileTransferReceiveProcInfo = $0000EFF0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 2 byte param, 4 byte param): 4 byte result; }
	uppFileTransferEnvironsProcInfo = $000003E0; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }
	uppFileTransferNotificationProcInfo = $000003C0; { PROCEDURE (4 byte param, 4 byte param); }
	uppFileTransferChooseIdleProcInfo = $00000000; { PROCEDURE ; }

FUNCTION NewFileTransferDefProc(userRoutine: FileTransferDefProcPtr): FileTransferDefUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileTransferReadProc(userRoutine: FileTransferReadProcPtr): FileTransferReadUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileTransferWriteProc(userRoutine: FileTransferWriteProcPtr): FileTransferWriteUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileTransferSendProc(userRoutine: FileTransferSendProcPtr): FileTransferSendUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileTransferReceiveProc(userRoutine: FileTransferReceiveProcPtr): FileTransferReceiveUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileTransferEnvironsProc(userRoutine: FileTransferEnvironsProcPtr): FileTransferEnvironsUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileTransferNotificationProc(userRoutine: FileTransferNotificationProcPtr): FileTransferNotificationUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewFileTransferChooseIdleProc(userRoutine: FileTransferChooseIdleProcPtr): FileTransferChooseIdleUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallFileTransferDefProc(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT; userRoutine: FileTransferDefUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallFileTransferReadProc(VAR count: LONGINT; pData: Ptr; refCon: LONGINT; fileMsg: INTEGER; userRoutine: FileTransferReadUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallFileTransferWriteProc(VAR count: LONGINT; pData: Ptr; refCon: LONGINT; fileMsg: INTEGER; userRoutine: FileTransferWriteUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallFileTransferSendProc(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; channel: CMChannel; flag: CMFlags; userRoutine: FileTransferSendUPP): Size;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallFileTransferReceiveProc(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; channel: CMChannel; VAR flag: CMFlags; userRoutine: FileTransferReceiveUPP): Size;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallFileTransferEnvironsProc(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec; userRoutine: FileTransferEnvironsUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallFileTransferNotificationProc(hFT: FTHandle; pFSSpec: FSSpecPtr; userRoutine: FileTransferNotificationUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallFileTransferChooseIdleProc(userRoutine: FileTransferChooseIdleUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InitFT: FTErr;
FUNCTION FTGetVersion(hFT: FTHandle): Handle;
FUNCTION FTGetFTVersion: INTEGER;
FUNCTION FTNew(procID: INTEGER; flags: FTFlags; sendProc: FileTransferSendUPP; recvProc: FileTransferReceiveUPP; readProc: FileTransferReadUPP; writeProc: FileTransferWriteUPP; environsProc: FileTransferEnvironsUPP; owner: WindowPtr; refCon: LONGINT; userData: LONGINT): FTHandle;
PROCEDURE FTDispose(hFT: FTHandle);
FUNCTION FTStart(hFT: FTHandle; direction: FTDirection; {CONST}VAR fileInfo: SFReply): FTErr;
FUNCTION FTAbort(hFT: FTHandle): FTErr;
FUNCTION FTSend(hFT: FTHandle; numFiles: INTEGER; pFSSpec: FSSpecArrayPtr; notifyProc: FileTransferNotificationUPP): FTErr;
FUNCTION FTReceive(hFT: FTHandle; pFSSpec: FSSpecPtr; notifyProc: FileTransferNotificationUPP): FTErr;
PROCEDURE FTExec(hFT: FTHandle);
PROCEDURE FTActivate(hFT: FTHandle; activate: BOOLEAN);
PROCEDURE FTResume(hFT: FTHandle; resume: BOOLEAN);
FUNCTION FTMenu(hFT: FTHandle; menuID: INTEGER; item: INTEGER): BOOLEAN;
FUNCTION FTChoose(VAR hFT: FTHandle; where: Point; idleProc: FileTransferChooseIdleUPP): INTEGER;
PROCEDURE FTEvent(hFT: FTHandle; {CONST}VAR theEvent: EventRecord);
FUNCTION FTValidate(hFT: FTHandle): BOOLEAN;
PROCEDURE FTDefault(VAR theConfig: Ptr; procID: INTEGER; allocate: BOOLEAN);
FUNCTION FTSetupPreflight(procID: INTEGER; VAR magicCookie: LONGINT): Handle;
PROCEDURE FTSetupSetup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR magicCookie: LONGINT);
FUNCTION FTSetupFilter(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR theEvent: EventRecord; VAR theItem: INTEGER; VAR magicCookie: LONGINT): BOOLEAN;
PROCEDURE FTSetupItem(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; VAR theItem: INTEGER; VAR magicCookie: LONGINT);
PROCEDURE FTSetupXCleanup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogPtr; OKed: BOOLEAN; VAR magicCookie: LONGINT);
PROCEDURE FTSetupPostflight(procID: INTEGER);
FUNCTION FTGetConfig(hFT: FTHandle): Ptr;
FUNCTION FTSetConfig(hFT: FTHandle; thePtr: UNIV Ptr): INTEGER;
FUNCTION FTIntlToEnglish(hFT: FTHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): FTErr;
FUNCTION FTEnglishToIntl(hFT: FTHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): FTErr;
PROCEDURE FTGetToolName(procID: INTEGER; VAR name: Str255);
FUNCTION FTGetProcID(name: ConstStr255Param): INTEGER;
PROCEDURE FTSetRefCon(hFT: FTHandle; refCon: LONGINT);
FUNCTION FTGetRefCon(hFT: FTHandle): LONGINT;
PROCEDURE FTSetUserData(hFT: FTHandle; userData: LONGINT);
FUNCTION FTGetUserData(hFT: FTHandle): LONGINT;
PROCEDURE FTGetErrorString(hFT: FTHandle; id: INTEGER; VAR errMsg: Str255);

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FileTransfersIncludes}

{$ENDC} {__FILETRANSFERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
