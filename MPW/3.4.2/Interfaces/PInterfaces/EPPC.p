{
 	File:		EPPC.p
 
 	Contains:	High Level Event Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
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
 UNIT EPPC;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __EPPC__}
{$SETC __EPPC__ := 1}

{$I+}
{$SETC EPPCIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}
{	Types.p														}
{	OSUtils.p													}
{		MixedMode.p												}
{		Memory.p												}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	Finder.p													}

{$IFC UNDEFINED __PPCTOOLBOX__}
{$I PPCToolbox.p}
{$ENDC}

{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{	Events.p													}
{		Quickdraw.p												}
{			QuickdrawText.p										}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ postOptions currently supported }
	receiverIDMask				= $0000F000;
	receiverIDisPSN				= $00008000;
	receiverIDisSignature		= $00007000;
	receiverIDisSessionID		= $00006000;
	receiverIDisTargetID		= $00005000;
	systemOptionsMask			= $00000F00;
	nReturnReceipt				= $00000200;
	priorityMask				= $000000FF;
	nAttnMsg					= $00000001;

{ constant for return receipts }
	HighLevelEventMsgClass		= 'jaym';
	rtrnReceiptMsgID			= 'rtrn';

	msgWasPartiallyAccepted		= 2;
	msgWasFullyAccepted			= 1;
	msgWasNotAccepted			= 0;


TYPE
	TargetID = RECORD
		sessionID:				LONGINT;
		name:					PPCPortRec;
		location:				LocationNameRec;
		recvrName:				PPCPortRec;
	END;

	TargetIDPtr = ^TargetID;
	TargetIDHandle = ^TargetIDPtr;
	TargetIDHdl = ^TargetIDPtr;

	SenderID = TargetID;

	SenderIDPtr = ^SenderID;

	HighLevelEventMsg = RECORD
		HighLevelEventMsgHeaderLength: INTEGER;
		version:				INTEGER;
		reserved1:				LONGINT;
		theMsgEvent:			EventRecord;
		userRefcon:				LONGINT;
		postingOptions:			LONGINT;
		msgLength:				LONGINT;
	END;

	HighLevelEventMsgPtr = ^HighLevelEventMsg;
	HighLevelEventMsgHandle = ^HighLevelEventMsgPtr;
	HighLevelEventMsgHdl = ^HighLevelEventMsgPtr;

	GetSpecificFilterProcPtr = ProcPtr;  { FUNCTION GetSpecificFilter(contextPtr: UNIV Ptr; msgBuff: HighLevelEventMsgPtr; (CONST)VAR sender: TargetID): BOOLEAN; }
	GetSpecificFilterUPP = UniversalProcPtr;

CONST
	uppGetSpecificFilterProcInfo = $00000FD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 1 byte result; }

FUNCTION NewGetSpecificFilterProc(userRoutine: GetSpecificFilterProcPtr): GetSpecificFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGetSpecificFilterProc(contextPtr: UNIV Ptr; msgBuff: HighLevelEventMsgPtr; {CONST}VAR sender: TargetID; userRoutine: GetSpecificFilterUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION PostHighLevelEvent({CONST}VAR theEvent: EventRecord; receiverID: UNIV Ptr; msgRefcon: LONGINT; msgBuff: UNIV Ptr; msgLen: LONGINT; postingOptions: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0034, $A88F;
	{$ENDC}
FUNCTION AcceptHighLevelEvent(VAR sender: TargetID; VAR msgRefcon: LONGINT; msgBuff: UNIV Ptr; VAR msgLen: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0033, $A88F;
	{$ENDC}
FUNCTION GetProcessSerialNumberFromPortName({CONST}VAR portName: PPCPortRec; VAR pPSN: ProcessSerialNumber): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0035, $A88F;
	{$ENDC}
FUNCTION GetPortNameFromProcessSerialNumber(VAR portName: PPCPortRec; {CONST}VAR pPSN: ProcessSerialNumber): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0046, $A88F;
	{$ENDC}
FUNCTION GetSpecificHighLevelEvent(aFilter: GetSpecificFilterUPP; contextPtr: UNIV Ptr; VAR err: OSErr): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0045, $A88F;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := EPPCIncludes}

{$ENDC} {__EPPC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
