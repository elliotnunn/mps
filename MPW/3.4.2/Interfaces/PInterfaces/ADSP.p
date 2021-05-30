{
 	File:		ADSP.p
 
 	Contains:	AppleTalk Data Stream Protocol (ADSP) Interfaces.
 
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
 UNIT ADSP;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ADSP__}
{$SETC __ADSP__ := 1}

{$I+}
{$SETC ADSPIncludes := UsingIncludes}
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

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	dspInit						= 255;							{ create a new connection end }
	dspRemove					= 254;							{ remove a connection end }
	dspOpen						= 253;							{ open a connection }
	dspClose					= 252;							{ close a connection }
	dspCLInit					= 251;							{ create a connection listener }
	dspCLRemove					= 250;							{ remove a connection listener }
	dspCLListen					= 249;							{ post a listener request }
	dspCLDeny					= 248;							{ deny an open connection request }
	dspStatus					= 247;							{ get status of connection end }
	dspRead						= 246;							{ read data from the connection }
	dspWrite					= 245;							{ write data on the connection }
	dspAttention				= 244;							{ send an attention message }

	dspOptions					= 243;							{ set connection end options }
	dspReset					= 242;							{ forward reset the connection }
	dspNewCID					= 241;							{ generate a cid for a connection end }
{ connection opening modes }
	ocRequest					= 1;							{ request a connection with remote }
	ocPassive					= 2;							{ wait for a connection request from remote }
	ocAccept					= 3;							{ accept request as delivered by listener }
	ocEstablish					= 4;							{ consider connection to be open }
{ connection end states }
	sListening					= 1;							{ for connection listeners }
	sPassive					= 2;							{ waiting for a connection request from remote }
	sOpening					= 3;							{ requesting a connection with remote }
	sOpen						= 4;							{ connection is open }
	sClosing					= 5;							{ connection is being torn down }
	sClosed						= 6;							{ connection end state is closed }
{ client event flags }
	eClosed						= $80;							{ received connection closed advice }
	eTearDown					= $40;							{ connection closed due to broken connection }
	eAttention					= $20;							{ received attention message }
	eFwdReset					= $10;							{ received forward reset advice }
{ miscellaneous constants }
	attnBufSize					= 570;							{ size of client attention buffer }
	minDSPQueueSize				= 100;							{ Minimum size of receive or send Queue }

{ connection control block }

TYPE
	TRCCB = PACKED RECORD
		ccbLink:				^TRCCB;									{ link to next ccb }
		refNum:					UInt16;									{ user reference number }
		state:					UInt16;									{ state of the connection end }
		userFlags:				UInt8;									{ flags for unsolicited connection events }
		localSocket:			UInt8;									{ socket number of this connection end }
		remoteAddress:			AddrBlock;								{ internet address of remote end }
		attnCode:				UInt16;									{ attention code received }
		attnSize:				UInt16;									{ size of received attention data }
		attnPtr:				Ptr;									{ ptr to received attention data }
		reserved:				PACKED ARRAY [0..219] OF UInt8;			{ for adsp internal use }
	END;

	TPCCB = ^TRCCB;

	DSPPBPtr = ^DSPParamBlock;

	{
		ADSPConnectionEventProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => sourceCCB   	A1.L
	}
	ADSPConnectionEventProcPtr = Register68kProcPtr;  { register PROCEDURE ADSPConnectionEvent(sourceCCB: TPCCB); }
	{
		ADSPCompletionProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => thePBPtr    	A0.L
	}
	ADSPCompletionProcPtr = Register68kProcPtr;  { register PROCEDURE ADSPCompletion(thePBPtr: DSPPBPtr); }
	ADSPConnectionEventUPP = UniversalProcPtr;
	ADSPCompletionUPP = UniversalProcPtr;

	DSPParamBlock = PACKED RECORD
		qLink:					^QElem;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			ADSPCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;								{ adsp driver refNum }
		csCode:					INTEGER;								{ adsp driver control code }
		qStatus:				LONGINT;								{ adsp internal use }
		ccbRefNum:				INTEGER;
		CASE INTEGER OF
		0: (
			ccbPtr:						TPCCB;								{ pointer to connection control block }
			userRoutine:				ADSPConnectionEventUPP;				{ client routine to call on event }
			sendQSize:					UInt16;								{ size of send queue (0..64K bytes) }
			sendQueue:					Ptr;								{ client passed send queue buffer }
			recvQSize:					UInt16;								{ size of receive queue (0..64K bytes) }
			recvQueue:					Ptr;								{ client passed receive queue buffer }
			attnPtr:					Ptr;								{ client passed receive attention buffer }
			localSocket:				UInt8;								{ local socket number }
			filler1:					UInt8;								{ filler for proper byte alignment }
		   );
		1: (
			localCID:					UInt16;								{ local connection id }
			remoteCID:					UInt16;								{ remote connection id }
			remoteAddress:				AddrBlock;							{ address of remote end }
			filterAddress:				AddrBlock;							{ address filter }
			sendSeq:					UInt32;								{ local send sequence number }
			sendWindow:					UInt16;								{ send window size }
			recvSeq:					UInt32;								{ receive sequence number }
			attnSendSeq:				UInt32;								{ attention send sequence number }
			attnRecvSeq:				UInt32;								{ attention receive sequence number }
			ocMode:						UInt8;								{ open connection mode }
			ocInterval:					UInt8;								{ open connection request retry interval }
			ocMaximum:					UInt8;								{ open connection request retry maximum }
			filler2:					UInt8;								{ filler for proper byte alignment }
		   );
		2: (
			abort:						UInt8;								{ abort connection immediately if non-zero }
			filler3:					UInt8;								{ filler for proper byte alignment }
		   );
		3: (
			reqCount:					UInt16;								{ requested number of bytes }
			actCount:					UInt16;								{ actual number of bytes }
			dataPtr:					Ptr;								{ pointer to data buffer }
			eom:						UInt8;								{ indicates logical end of message }
			flush:						UInt8;								{ send data now }
		   );
		4: (
			attnCode:					UInt16;								{ client attention code }
			attnSize:					UInt16;								{ size of attention data }
			attnData:					Ptr;								{ pointer to attention data }
			attnInterval:				UInt8;								{ retransmit timer in 10-tick intervals }
			filler4:					UInt8;								{ filler for proper byte alignment }
		   );
		5: (
			statusCCB:					TPCCB;								{ pointer to ccb }
			sendQPending:				UInt16;								{ pending bytes in send queue }
			sendQFree:					UInt16;								{ available buffer space in send queue }
			recvQPending:				UInt16;								{ pending bytes in receive queue }
			recvQFree:					UInt16;								{ available buffer space in receive queue }
		   );
		6: (
			sendBlocking:				UInt16;								{ quantum for data packets }
			sendTimer:					UInt8;								{ send timer in 10-tick intervals }
			rtmtTimer:					UInt8;								{ retransmit timer in 10-tick intervals }
			badSeqMax:					UInt8;								{ threshold for sending retransmit advice }
			useCheckSum:				UInt8;								{ use ddp packet checksum }
		   );
		7: (
			newcid:						UInt16;								{ new connection id returned }
		   );
	END;

CONST
	uppADSPConnectionEventProcInfo = $0000B802; { Register PROCEDURE (4 bytes in A1); }
	uppADSPCompletionProcInfo = $00009802; { Register PROCEDURE (4 bytes in A0); }

FUNCTION NewADSPConnectionEventProc(userRoutine: ADSPConnectionEventProcPtr): ADSPConnectionEventUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewADSPCompletionProc(userRoutine: ADSPCompletionProcPtr): ADSPCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallADSPConnectionEventProc(sourceCCB: TPCCB; userRoutine: ADSPConnectionEventUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallADSPCompletionProc(thePBPtr: DSPPBPtr; userRoutine: ADSPCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ADSPIncludes}

{$ENDC} {__ADSP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
