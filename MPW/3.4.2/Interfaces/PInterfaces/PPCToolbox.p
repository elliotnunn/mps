{
 	File:		PPCToolbox.p
 
 	Contains:	Program-Program Communications Toolbox Interfaces.
 
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
 UNIT PPCToolbox;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PPCTOOLBOX__}
{$SETC __PPCTOOLBOX__ := 1}

{$I+}
{$SETC PPCToolboxIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	OSUtils.p													}
{		MixedMode.p												}
{		Memory.p												}

{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	PPCServiceType = CHAR;


CONST
	ppcServiceRealTime			= 1;

	
TYPE
	PPCLocationKind = INTEGER;


CONST
	ppcNoLocation				= 0;							{ There is no PPCLocName }
	ppcNBPLocation				= 1;							{ Use AppleTalk NBP      }
	ppcNBPTypeLocation			= 2;							{ Used for specifying a location name type during PPCOpen only }

	
TYPE
	PPCPortKinds = INTEGER;


CONST
	ppcByCreatorAndType			= 1;							{ Port type is specified as colloquial Mac creator and type }
	ppcByString					= 2;							{ Port type is in pascal string format }

{ Values returned for request field in PPCInform call }
	
TYPE
	PPCSessionOrigin = CHAR;


CONST
{ Values returned for requestType field in PPCInform call }
	ppcLocalOrigin				= 1;							{ session originated from this machine }
	ppcRemoteOrigin				= 2;							{ session originated from remote machine }

	
TYPE
	PPCPortRefNum = INTEGER;

	PPCSessRefNum = LONGINT;

	PPCPortRec = RECORD
		nameScript:				ScriptCode;								{ script of name }
		name:					Str32;									{ name of port as seen in browser }
		portKindSelector:		PPCPortKinds;							{ which variant }
		CASE INTEGER OF
		0: (
			portTypeStr:				Str32;								{ pascal type string }
		   );
		1: (
			portCreator:				OSType;
			portType:					OSType;
		   );
	END;

	PPCPortPtr = ^PPCPortRec;

	LocationNameRec = RECORD
		locationKindSelector:	PPCLocationKind;						{ which variant }
		CASE INTEGER OF
		0: (
			nbpEntity:					EntityName;							{ NBP name entity }
		   );
		1: (
			nbpType:					Str32;								{ just the NBP type string, for PPCOpen }
		   );
	END;

	LocationNamePtr = ^LocationNameRec;

	PortInfoRec = RECORD
		filler1:				SInt8; (* unsigned char *)
		authRequired:			BOOLEAN;
		name:					PPCPortRec;
	END;

	PortInfoPtr = ^PortInfoRec;

	PortInfoArrayPtr = ^PortInfoRec;

	PPCParamBlockPtr = ^PPCParamBlockRec;

	PPCCompProcPtr = ProcPtr;  { PROCEDURE PPCComp(pb: PPCParamBlockPtr); }
	PPCCompUPP = UniversalProcPtr;

	PPCOpenPBRec = PACKED RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		portRefNum:				PPCPortRefNum;							{ 38 <--   Port Reference }
		filler1:				LONGINT;
		serviceType:			PPCServiceType;							{ 44 -->    Bit field describing the requested port service }
		resFlag:				UInt8;									{ Must be set to 0 }
		portName:				PPCPortPtr;								{ 46 -->   PortName for PPC }
		locationName:			LocationNamePtr;						{ 50 -->   If NBP Registration is required }
		networkVisible:			BOOLEAN;								{ 54 -->   make this network visible on network }
		nbpRegistered:			BOOLEAN;								{ 55 <--   The given location name was registered on the network }
	END;

	PPCOpenPBPtr = ^PPCOpenPBRec;

	PPCInformPBRec = PACKED RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		portRefNum:				PPCPortRefNum;							{ 38 -->   Port Identifier }
		sessRefNum:				PPCSessRefNum;							{ 40 <--   Session Reference }
		serviceType:			PPCServiceType;							{ 44 <--   Status Flags for type of session, local, remote }
		autoAccept:				BOOLEAN;								{ 45 -->   if true session will be accepted automatically }
		portName:				PPCPortPtr;								{ 46 -->   Buffer for Source PPCPortRec }
		locationName:			LocationNamePtr;						{ 50 -->   Buffer for Source LocationNameRec }
		userName:				StringPtr;								{ 54 -->   Buffer for Soure user's name trying to link. }
		userData:				LONGINT;								{ 58 <--   value included in PPCStart's userData }
		requestType:			PPCSessionOrigin;						{ 62 <--   Local or Network }
	END;

	PPCInformPBPtr = ^PPCInformPBRec;

	PPCStartPBRec = PACKED RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		portRefNum:				PPCPortRefNum;							{ 38 -->   Port Identifier }
		sessRefNum:				PPCSessRefNum;							{ 40 <--   Session Reference }
		serviceType:			PPCServiceType;							{ 44 <--   Actual service method (realTime) }
		resFlag:				UInt8;									{ 45 -->   Must be set to 0  }
		portName:				PPCPortPtr;								{ 46 -->   Destination portName }
		locationName:			LocationNamePtr;						{ 50 -->   NBP or NAS style service location name }
		rejectInfo:				LONGINT;								{ 54 <--   reason for rejecting the session request }
		userData:				LONGINT;								{ 58 -->   Copied to destination PPCInform parameter block }
		userRefNum:				LONGINT;								{ 62 -->   userRefNum (obtained during login process)  }
	END;

	PPCStartPBPtr = ^PPCStartPBRec;

	PPCAcceptPBRec = RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{ 40 -->   Session Reference }
	END;

	PPCAcceptPBPtr = ^PPCAcceptPBRec;

	PPCRejectPBRec = RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{ 40 -->   Session Reference }
		filler2:				INTEGER;
		filler3:				LONGINT;
		filler4:				LONGINT;
		rejectInfo:				LONGINT;								{ 54 -->   reason for rejecting the session request  }
	END;

	PPCRejectPBPtr = ^PPCRejectPBRec;

	PPCWritePBRec = RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{ 40 -->   Session Reference }
		bufferLength:			Size;									{ 44 -->   Length of the message buffer }
		actualLength:			Size;									{ 48 <--   Actual Length Written }
		bufferPtr:				Ptr;									{ 52 -->   Pointer to message buffer }
		more:					BOOLEAN;								{ 56 -->   if more data in this block will be written }
		filler2:				SInt8; (* unsigned char *)
		userData:				LONGINT;								{ 58 -->   Message block userData Uninterpreted by PPC }
		blockCreator:			OSType;									{ 62 -->   Message block creator Uninterpreted by PPC }
		blockType:				OSType;									{ 66 -->   Message block type Uninterpreted by PPC }
	END;

	PPCWritePBPtr = ^PPCWritePBRec;

	PPCReadPBRec = RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{ 40 -->   Session Reference }
		bufferLength:			Size;									{ 44 -->   Length of the message buffer }
		actualLength:			Size;									{ 48 <--   Actual length read }
		bufferPtr:				Ptr;									{ 52 -->   Pointer to message buffer }
		more:					BOOLEAN;								{ 56 <--   if true more data in this block to be read }
		filler2:				SInt8; (* unsigned char *)
		userData:				LONGINT;								{ 58 <--   Message block userData Uninterpreted by PPC }
		blockCreator:			OSType;									{ 62 <--   Message block creator Uninterpreted by PPC }
		blockType:				OSType;									{ 66 <--   Message block type Uninterpreted by PPC }
	END;

	PPCReadPBPtr = ^PPCReadPBRec;

	PPCEndPBRec = RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{ 40 -->   Session Reference }
	END;

	PPCEndPBPtr = ^PPCEndPBRec;

	PPCClosePBRec = RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		portRefNum:				PPCPortRefNum;							{ 38 -->   Port Identifier }
	END;

	PPCClosePBPtr = ^PPCClosePBRec;

	IPCListPortsPBRec = RECORD
		qLink:					Ptr;
		csCode:					INTEGER;
		intUse:					INTEGER;
		intUsePtr:				Ptr;
		ioCompletion:			PPCCompUPP;
		ioResult:				OSErr;
		Reserved:				ARRAY [0..4] OF LONGINT;
		filler1:				INTEGER;
		startIndex:				INTEGER;								{ 40 -->   Start Index }
		requestCount:			INTEGER;								{ 42 -->   Number of entries to be returned }
		actualCount:			INTEGER;								{ 44 <--   Actual Number of entries to be returned }
		portName:				PPCPortPtr;								{ 46 -->   PortName Match }
		locationName:			LocationNamePtr;						{ 50 -->   NBP or NAS type name to locate the Port Location }
		bufferPtr:				PortInfoArrayPtr;						{ 54 -->   Pointer to a buffer requestCount*sizeof(PortInfo) bytes big }
	END;

	IPCListPortsPBPtr = ^IPCListPortsPBRec;

	PPCParamBlockRec = RECORD
		CASE INTEGER OF
		0: (
			openParam:					PPCOpenPBRec;
		   );
		1: (
			informParam:				PPCInformPBRec;
		   );
		2: (
			startParam:					PPCStartPBRec;
		   );
		3: (
			acceptParam:				PPCAcceptPBRec;
		   );
		4: (
			rejectParam:				PPCRejectPBRec;
		   );
		5: (
			writeParam:					PPCWritePBRec;
		   );
		6: (
			readParam:					PPCReadPBRec;
		   );
		7: (
			endParam:					PPCEndPBRec;
		   );
		8: (
			closeParam:					PPCClosePBRec;
		   );
		9: (
			listPortsParam:				IPCListPortsPBRec;
		   );
	END;


FUNCTION PPCInit: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCOpenSync(pb: PPCOpenPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7001, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCOpenAsync(pb: PPCOpenPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7001, $A4DD, $3E80;
	{$ENDC}
FUNCTION PPCInformSync(pb: PPCInformPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7003, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCInformAsync(pb: PPCInformPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7003, $A4DD, $3E80;
	{$ENDC}
FUNCTION PPCStartSync(pb: PPCStartPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7002, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCStartAsync(pb: PPCStartPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7002, $A4DD, $3E80;
	{$ENDC}
FUNCTION PPCAcceptSync(pb: PPCAcceptPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7004, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCAcceptAsync(pb: PPCAcceptPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7004, $A4DD, $3E80;
	{$ENDC}
FUNCTION PPCRejectSync(pb: PPCRejectPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7005, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCRejectAsync(pb: PPCRejectPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7005, $A4DD, $3E80;
	{$ENDC}
FUNCTION PPCWriteSync(pb: PPCWritePBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7006, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCWriteAsync(pb: PPCWritePBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7006, $A4DD, $3E80;
	{$ENDC}
FUNCTION PPCReadSync(pb: PPCReadPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7007, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCReadAsync(pb: PPCReadPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7007, $A4DD, $3E80;
	{$ENDC}
FUNCTION PPCEndSync(pb: PPCEndPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7008, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCEndAsync(pb: PPCEndPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7008, $A4DD, $3E80;
	{$ENDC}
FUNCTION PPCCloseSync(pb: PPCClosePBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7009, $A0DD, $3E80;
	{$ENDC}
FUNCTION PPCCloseAsync(pb: PPCClosePBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7009, $A4DD, $3E80;
	{$ENDC}
FUNCTION IPCListPortsSync(pb: IPCListPortsPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $700A, $A0DD, $3E80;
	{$ENDC}
FUNCTION IPCListPortsAsync(pb: IPCListPortsPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $700A, $A4DD, $3E80;
	{$ENDC}
FUNCTION DeleteUserIdentity(userRef: LONGINT): OSErr;
FUNCTION GetDefaultUser(VAR userRef: LONGINT; VAR userName: Str32): OSErr;
FUNCTION StartSecureSession(pb: PPCStartPBPtr; VAR userName: Str32; useDefault: BOOLEAN; allowGuest: BOOLEAN; VAR guestSelected: BOOLEAN; prompt: ConstStr255Param): OSErr;
TYPE
	PPCFilterProcPtr = ProcPtr;  { FUNCTION PPCFilter(name: LocationNamePtr; port: PortInfoPtr): BOOLEAN; }
	PPCFilterUPP = UniversalProcPtr;

CONST
	uppPPCCompProcInfo = $000000C0; { PROCEDURE (4 byte param); }
	uppPPCFilterProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }

FUNCTION NewPPCCompProc(userRoutine: PPCCompProcPtr): PPCCompUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPPCFilterProc(userRoutine: PPCFilterProcPtr): PPCFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallPPCCompProc(pb: PPCParamBlockPtr; userRoutine: PPCCompUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallPPCFilterProc(name: LocationNamePtr; port: PortInfoPtr; userRoutine: PPCFilterUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION PPCBrowser(prompt: ConstStr255Param; applListLabel: ConstStr255Param; defaultSpecified: BOOLEAN; VAR theLocation: LocationNameRec; VAR thePortInfo: PortInfoRec; portFilter: PPCFilterUPP; theLocNBPType: ConstStr32Param): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0D00, $A82B;
	{$ENDC}
{$IFC OLDROUTINENAMES }
{
  The ParamBlock calls with the "Sync" or "Async" suffix are being phased out.
}
FUNCTION PPCOpen(pb: PPCOpenPBPtr; async: BOOLEAN): OSErr;
FUNCTION PPCInform(pb: PPCInformPBPtr; async: BOOLEAN): OSErr;
FUNCTION PPCStart(pb: PPCStartPBPtr; async: BOOLEAN): OSErr;
FUNCTION PPCAccept(pb: PPCAcceptPBPtr; async: BOOLEAN): OSErr;
FUNCTION PPCReject(pb: PPCRejectPBPtr; async: BOOLEAN): OSErr;
FUNCTION PPCWrite(pb: PPCWritePBPtr; async: BOOLEAN): OSErr;
FUNCTION PPCRead(pb: PPCReadPBPtr; async: BOOLEAN): OSErr;
FUNCTION PPCEnd(pb: PPCEndPBPtr; async: BOOLEAN): OSErr;
FUNCTION PPCClose(pb: PPCClosePBPtr; async: BOOLEAN): OSErr;
FUNCTION IPCListPorts(pb: IPCListPortsPBPtr; async: BOOLEAN): OSErr;
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PPCToolboxIncludes}

{$ENDC} {__PPCTOOLBOX__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
