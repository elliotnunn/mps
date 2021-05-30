{
     File:       FileTransfers.p
 
     Contains:   CommToolbox File Transfer Manager Interfaces.
 
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
 UNIT FileTransfers;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FILETRANSFERS__}
{$SETC __FILETRANSFERS__ := 1}

{$I+}
{$SETC FileTransfersIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __STANDARDFILE__}
{$I StandardFile.p}
{$ENDC}
{$IFC UNDEFINED __CTBUTILITIES__}
{$I CTBUtilities.p}
{$ENDC}
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

{$IFC CALL_NOT_IN_CARBON }

CONST
	curFTVersion				= 2;							{  current file transfer manager version }

																{  FTErr     }
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
	FTErr								= OSErr;

CONST
	ftIsFTMode					= $01;
	ftNoMenus					= $02;
	ftQuiet						= $04;
	ftConfigChanged				= $10;
	ftSucc						= $80;


TYPE
	FTFlags								= UInt32;

CONST
	ftSameCircuit				= $01;
	ftSendDisable				= $02;
	ftReceiveDisable			= $04;
	ftTextOnly					= $08;
	ftNoStdFile					= $10;
	ftMultipleFileSend			= $20;


TYPE
	FTAttributes						= UInt16;

CONST
	ftReceiving					= 0;
	ftTransmitting				= 1;
	ftFullDuplex				= 2;							{  (16) added ftFullDuplex bit. }


TYPE
	FTDirection							= UInt16;
{$IFC TYPED_FUNCTION_POINTERS}
	FileTransferDefProcPtr = FUNCTION(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT): LONGINT;
{$ELSEC}
	FileTransferDefProcPtr = ProcPtr;
{$ENDC}

	{	  application routines type definitions 	}
	FTRecordPtr = ^FTRecord;
	FTPtr								= ^FTRecord;
	FTHandle							= ^FTPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	FileTransferReadProcPtr = FUNCTION(VAR count: UInt32; pData: Ptr; refCon: LONGINT; fileMsg: INTEGER): OSErr;
{$ELSEC}
	FileTransferReadProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FileTransferWriteProcPtr = FUNCTION(VAR count: UInt32; pData: Ptr; refCon: LONGINT; fileMsg: INTEGER): OSErr;
{$ELSEC}
	FileTransferWriteProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FileTransferSendProcPtr = FUNCTION(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; channel: CMChannel; flag: CMFlags): Size;
{$ELSEC}
	FileTransferSendProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FileTransferReceiveProcPtr = FUNCTION(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; channel: CMChannel; VAR flag: CMFlags): Size;
{$ELSEC}
	FileTransferReceiveProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FileTransferEnvironsProcPtr = FUNCTION(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec): OSErr;
{$ELSEC}
	FileTransferEnvironsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FileTransferNotificationProcPtr = PROCEDURE(hFT: FTHandle; {CONST}VAR pFSSpec: FSSpec);
{$ELSEC}
	FileTransferNotificationProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FileTransferChooseIdleProcPtr = PROCEDURE;
{$ELSEC}
	FileTransferChooseIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	FileTransferDefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileTransferDefUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FileTransferReadUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileTransferReadUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FileTransferWriteUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileTransferWriteUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FileTransferSendUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileTransferSendUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FileTransferReceiveUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileTransferReceiveUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FileTransferEnvironsUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileTransferEnvironsUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FileTransferNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileTransferNotificationUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FileTransferChooseIdleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileTransferChooseIdleUPP = UniversalProcPtr;
{$ENDC}	
	FTRecord = RECORD
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
		owner:					WindowRef;
		direction:				FTDirection;
		theReply:				SFReply;
		writePtr:				LONGINT;
		readPtr:				LONGINT;
		theBuf:					Ptr;
		bufSize:				LONGINT;
		autoRec:				Str255;
		attributes:				FTAttributes;
	END;

	FTCompletionKind					= UInt16;

CONST
																{  FTReadProc messages  }
	ftReadOpenFile				= 0;							{  count = forkFlags, buffer = pblock from PBGetFInfo  }
	ftReadDataFork				= 1;
	ftReadRsrcFork				= 2;
	ftReadAbort					= 3;
	ftReadComplete				= 4;
	ftReadSetFPos				= 6;							{  count = forkFlags, buffer = pBlock same as PBSetFPos  }
	ftReadGetFPos				= 7;							{  count = forkFlags, buffer = pBlock same as PBGetFPos  }

																{  FTWriteProc messages  }
	ftWriteOpenFile				= 0;							{  count = forkFlags, buffer = pblock from PBGetFInfo  }
	ftWriteDataFork				= 1;
	ftWriteRsrcFork				= 2;
	ftWriteAbort				= 3;
	ftWriteComplete				= 4;
	ftWriteFileInfo				= 5;
	ftWriteSetFPos				= 6;							{  count = forkFlags, buffer = pBlock same as PBSetFPos  }
	ftWriteGetFPos				= 7;							{  count = forkFlags, buffer = pBlock same as PBGetFPos  }

																{     fork flags  }
	ftOpenDataFork				= 1;
	ftOpenRsrcFork				= 2;

	uppFileTransferDefProcInfo = $0000FEF0;
	uppFileTransferReadProcInfo = $00002FE0;
	uppFileTransferWriteProcInfo = $00002FE0;
	uppFileTransferSendProcInfo = $0000AFF0;
	uppFileTransferReceiveProcInfo = $0000EFF0;
	uppFileTransferEnvironsProcInfo = $000003E0;
	uppFileTransferNotificationProcInfo = $000003C0;
	uppFileTransferChooseIdleProcInfo = $00000000;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewFileTransferDefUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewFileTransferDefUPP(userRoutine: FileTransferDefProcPtr): FileTransferDefUPP; { old name was NewFileTransferDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFileTransferReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFileTransferReadUPP(userRoutine: FileTransferReadProcPtr): FileTransferReadUPP; { old name was NewFileTransferReadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFileTransferWriteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFileTransferWriteUPP(userRoutine: FileTransferWriteProcPtr): FileTransferWriteUPP; { old name was NewFileTransferWriteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFileTransferSendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFileTransferSendUPP(userRoutine: FileTransferSendProcPtr): FileTransferSendUPP; { old name was NewFileTransferSendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFileTransferReceiveUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFileTransferReceiveUPP(userRoutine: FileTransferReceiveProcPtr): FileTransferReceiveUPP; { old name was NewFileTransferReceiveProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFileTransferEnvironsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFileTransferEnvironsUPP(userRoutine: FileTransferEnvironsProcPtr): FileTransferEnvironsUPP; { old name was NewFileTransferEnvironsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFileTransferNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFileTransferNotificationUPP(userRoutine: FileTransferNotificationProcPtr): FileTransferNotificationUPP; { old name was NewFileTransferNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFileTransferChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFileTransferChooseIdleUPP(userRoutine: FileTransferChooseIdleProcPtr): FileTransferChooseIdleUPP; { old name was NewFileTransferChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeFileTransferDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileTransferDefUPP(userUPP: FileTransferDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFileTransferReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileTransferReadUPP(userUPP: FileTransferReadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFileTransferWriteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileTransferWriteUPP(userUPP: FileTransferWriteUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFileTransferSendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileTransferSendUPP(userUPP: FileTransferSendUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFileTransferReceiveUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileTransferReceiveUPP(userUPP: FileTransferReceiveUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFileTransferEnvironsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileTransferEnvironsUPP(userUPP: FileTransferEnvironsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFileTransferNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileTransferNotificationUPP(userUPP: FileTransferNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFileTransferChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileTransferChooseIdleUPP(userUPP: FileTransferChooseIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeFileTransferDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeFileTransferDefUPP(hTerm: TermHandle; msg: INTEGER; p1: LONGINT; p2: LONGINT; p3: LONGINT; userRoutine: FileTransferDefUPP): LONGINT; { old name was CallFileTransferDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFileTransferReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeFileTransferReadUPP(VAR count: UInt32; pData: Ptr; refCon: LONGINT; fileMsg: INTEGER; userRoutine: FileTransferReadUPP): OSErr; { old name was CallFileTransferReadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFileTransferWriteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeFileTransferWriteUPP(VAR count: UInt32; pData: Ptr; refCon: LONGINT; fileMsg: INTEGER; userRoutine: FileTransferWriteUPP): OSErr; { old name was CallFileTransferWriteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFileTransferSendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeFileTransferSendUPP(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; channel: CMChannel; flag: CMFlags; userRoutine: FileTransferSendUPP): Size; { old name was CallFileTransferSendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFileTransferReceiveUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeFileTransferReceiveUPP(thePtr: Ptr; theSize: LONGINT; refCon: LONGINT; channel: CMChannel; VAR flag: CMFlags; userRoutine: FileTransferReceiveUPP): Size; { old name was CallFileTransferReceiveProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFileTransferEnvironsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeFileTransferEnvironsUPP(refCon: LONGINT; VAR theEnvirons: ConnEnvironRec; userRoutine: FileTransferEnvironsUPP): OSErr; { old name was CallFileTransferEnvironsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFileTransferNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeFileTransferNotificationUPP(hFT: FTHandle; {CONST}VAR pFSSpec: FSSpec; userRoutine: FileTransferNotificationUPP); { old name was CallFileTransferNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFileTransferChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeFileTransferChooseIdleUPP(userRoutine: FileTransferChooseIdleUPP); { old name was CallFileTransferChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
{
 *  InitFT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitFT: FTErr;

{
 *  FTGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTGetVersion(hFT: FTHandle): Handle;

{
 *  FTGetFTVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTGetFTVersion: INTEGER;

{
 *  FTNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTNew(procID: INTEGER; flags: FTFlags; sendProc: FileTransferSendUPP; recvProc: FileTransferReceiveUPP; readProc: FileTransferReadUPP; writeProc: FileTransferWriteUPP; environsProc: FileTransferEnvironsUPP; owner: WindowRef; refCon: LONGINT; userData: LONGINT): FTHandle;

{
 *  FTDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTDispose(hFT: FTHandle);

{
 *  FTStart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTStart(hFT: FTHandle; direction: FTDirection; {CONST}VAR fileInfo: SFReply): FTErr;

{
 *  FTAbort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTAbort(hFT: FTHandle): FTErr;

{
 *  FTSend()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTSend(hFT: FTHandle; numFiles: INTEGER; pFSSpec: FSSpecArrayPtr; notifyProc: FileTransferNotificationUPP): FTErr;

{
 *  FTReceive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTReceive(hFT: FTHandle; pFSSpec: FSSpecPtr; notifyProc: FileTransferNotificationUPP): FTErr;

{
 *  FTExec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTExec(hFT: FTHandle);

{
 *  FTActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTActivate(hFT: FTHandle; activate: BOOLEAN);

{
 *  FTResume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTResume(hFT: FTHandle; resume: BOOLEAN);

{
 *  FTMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTMenu(hFT: FTHandle; menuID: INTEGER; item: INTEGER): BOOLEAN;

{
 *  FTChoose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTChoose(VAR hFT: FTHandle; where: Point; idleProc: FileTransferChooseIdleUPP): INTEGER;

{
 *  FTEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTEvent(hFT: FTHandle; {CONST}VAR theEvent: EventRecord);

{
 *  FTValidate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTValidate(hFT: FTHandle): BOOLEAN;

{
 *  FTDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTDefault(VAR theConfig: Ptr; procID: INTEGER; allocate: BOOLEAN);

{
 *  FTSetupPreflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTSetupPreflight(procID: INTEGER; VAR magicCookie: LONGINT): Handle;

{
 *  FTSetupSetup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTSetupSetup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; VAR magicCookie: LONGINT);

{
 *  FTSetupFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTSetupFilter(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; VAR theEvent: EventRecord; VAR theItem: INTEGER; VAR magicCookie: LONGINT): BOOLEAN;

{
 *  FTSetupItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTSetupItem(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; VAR theItem: INTEGER; VAR magicCookie: LONGINT);

{
 *  FTSetupXCleanup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTSetupXCleanup(procID: INTEGER; theConfig: UNIV Ptr; count: INTEGER; theDialog: DialogRef; OKed: BOOLEAN; VAR magicCookie: LONGINT);

{
 *  FTSetupPostflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTSetupPostflight(procID: INTEGER);

{
 *  FTGetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTGetConfig(hFT: FTHandle): Ptr;

{
 *  FTSetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTSetConfig(hFT: FTHandle; thePtr: UNIV Ptr): INTEGER;

{
 *  FTIntlToEnglish()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTIntlToEnglish(hFT: FTHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): FTErr;

{
 *  FTEnglishToIntl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTEnglishToIntl(hFT: FTHandle; inputPtr: UNIV Ptr; VAR outputPtr: Ptr; language: INTEGER): FTErr;

{
 *  FTGetToolName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTGetToolName(procID: INTEGER; VAR name: Str255);

{
 *  FTGetProcID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTGetProcID(name: Str255): INTEGER;

{
 *  FTSetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTSetRefCon(hFT: FTHandle; refCon: LONGINT);

{
 *  FTGetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTGetRefCon(hFT: FTHandle): LONGINT;

{
 *  FTSetUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTSetUserData(hFT: FTHandle; userData: LONGINT);

{
 *  FTGetUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTGetUserData(hFT: FTHandle): LONGINT;

{
 *  FTGetErrorString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FTGetErrorString(hFT: FTHandle; id: INTEGER; VAR errMsg: Str255);

{
    These Async routines were added to InterfaceLib in System 7.5
}
{
 *  FTSendAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTSendAsync(hFT: FTHandle; numFiles: INTEGER; pFSSpec: FSSpecArrayPtr; notifyProc: FileTransferNotificationUPP): FTErr;

{
 *  FTReceiveAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTReceiveAsync(hFT: FTHandle; pFSSpec: FSSpecPtr; notifyProc: FileTransferNotificationUPP): FTErr;

{
 *  FTCompletionAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FTCompletionAsync(hFT: FTHandle; completionCall: FTCompletionKind): FTErr;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FileTransfersIncludes}

{$ENDC} {__FILETRANSFERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
