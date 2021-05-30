{
     File:       PPCToolbox.p
 
     Contains:   Program-Program Communications Toolbox Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1989-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	PPCServiceType 				= UInt8;
CONST
	ppcServiceRealTime			= 1;


TYPE
	PPCLocationKind 			= SInt16;
CONST
	ppcNoLocation				= 0;							{  There is no PPCLocName  }
	ppcNBPLocation				= 1;							{  Use AppleTalk NBP       }
	ppcNBPTypeLocation			= 2;							{  Used for specifying a location name type during PPCOpen only  }
	ppcXTIAddrLocation			= 3;							{  Use TCP/IP or DNS host name address  }


TYPE
	PPCPortKinds 				= SInt16;
CONST
	ppcByCreatorAndType			= 1;							{  Port type is specified as colloquial Mac creator and type  }
	ppcByString					= 2;							{  Port type is in pascal string format  }

	{	 Values returned for request field in PPCInform call 	}

TYPE
	PPCSessionOrigin 			= UInt8;
CONST
	ppcLocalOrigin				= 1;							{  session originated from this machine  }
	ppcRemoteOrigin				= 2;							{  session originated from remote machine  }



TYPE
	PPCPortRefNum						= INTEGER;
	PPCSessRefNum						= LONGINT;


	{	  The maximum allowed size of a fAddress in PPCXTIAddress 	}

CONST
	kMaxPPCXTIAddress			= 95;


	{	    
	    The possible types of information found in the fAddressType field of a PPCXTIAddress record
	    Note:   These constants are the same as the AF_INET & AF_DNS constants, defined in OpenTptInternet.x
		}

TYPE
	PPCXTIAddressType 			= SInt16;
CONST
	kINETAddrType				= 2;							{     An IP address in binary form (type InetHost). }
	kDNSAddrType				= 42;							{     A DNS or dotted-decimal name string (no leading length byte, no NULL termination byte) }


	{	    
	    This structure specifies a transport independent network address in a 
	    form that can be used by Open Transport, or as a XTI/TLI/socket network 
	    address in UNIX terminology.
		}

TYPE
	PPCXTIAddressPtr = ^PPCXTIAddress;
	PPCXTIAddress = PACKED RECORD
		fAddressType:			PPCXTIAddressType;						{  A constant specifying what kind of network address this is  }
		fAddress:				PACKED ARRAY [0..95] OF UInt8;			{  The contents of the network address (variable length, NULL terminated).  }
	END;



	{	
	    This structure is the variant type used in a LocationNameRec when an IP connection
	    is being established for a PPC Toolbox session.
	    
	    NOTE: The value of the xtiAddrLen must be the length of the entire PPCXTIAddress structure 
	    in the xtiAddr field, and not just the length of the fAddress field of the PPCXTIAddress structure.
		}
	PPCAddrRecPtr = ^PPCAddrRec;
	PPCAddrRec = RECORD
		xtiAddrLen:				UInt32;									{  size of the xtiAddr field              }
		xtiAddr:				PPCXTIAddress;							{  the transport-independent network address    }
	END;


	LocationNameRecPtr = ^LocationNameRec;
	LocationNameRec = RECORD
		locationKindSelector:	PPCLocationKind;						{  which variant  }
		CASE INTEGER OF
		0: (
			nbpEntity:			EntityName;								{  NBP name entity                    }
			);
		1: (
			nbpType:			Str32;									{  just the NBP type string, for PPCOpen   }
			);
		2: (
			xtiType:			PPCAddrRec;								{  an XTI-type network address record      }
			);
	END;

	LocationNamePtr						= ^LocationNameRec;

	PPCPortRecPtr = ^PPCPortRec;
	PPCPortRec = RECORD
		nameScript:				ScriptCode;								{  script of name  }
		name:					Str32Field;								{  name of port as seen in browser  }
		portKindSelector:		PPCPortKinds;							{  which variant  }
		CASE INTEGER OF
		0: (
			portTypeStr:		Str32;									{  pascal type string  }
			);
		1: (
			portCreator:		OSType;
			portType:			OSType;
		   );
	END;

	PPCPortPtr							= ^PPCPortRec;
	PortInfoRecPtr = ^PortInfoRec;
	PortInfoRec = RECORD
		filler1:				SInt8;
		authRequired:			BOOLEAN;
		name:					PPCPortRec;
	END;

	PortInfoPtr							= ^PortInfoRec;
	PortInfoArrayPtr					= ^PortInfoRec;
	PPCParamBlockRecPtr = ^PPCParamBlockRec;
	PPCParamBlockPtr					= ^PPCParamBlockRec;
{$IFC TYPED_FUNCTION_POINTERS}
	PPCCompProcPtr = PROCEDURE(pb: PPCParamBlockPtr);
{$ELSEC}
	PPCCompProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PPCCompUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PPCCompUPP = UniversalProcPtr;
{$ENDC}	
	PPCOpenPBRecPtr = ^PPCOpenPBRec;
	PPCOpenPBRec = PACKED RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		portRefNum:				PPCPortRefNum;							{  38 <--   Port Reference  }
		filler1:				LONGINT;
		serviceType:			PPCServiceType;							{  44 -->    Bit field describing the requested port service  }
		resFlag:				UInt8;									{  Must be set to 0  }
		portName:				PPCPortPtr;								{  46 -->   PortName for PPC  }
		locationName:			LocationNamePtr;						{  50 -->   If NBP Registration is required  }
		networkVisible:			BOOLEAN;								{  54 -->   make this network visible on network  }
		nbpRegistered:			BOOLEAN;								{  55 <--   The given location name was registered on the network  }
	END;

	PPCOpenPBPtr						= ^PPCOpenPBRec;
	PPCInformPBRecPtr = ^PPCInformPBRec;
	PPCInformPBRec = PACKED RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		portRefNum:				PPCPortRefNum;							{  38 -->   Port Identifier  }
		sessRefNum:				PPCSessRefNum;							{  40 <--   Session Reference  }
		serviceType:			PPCServiceType;							{  44 <--   Status Flags for type of session, local, remote  }
		autoAccept:				BOOLEAN;								{  45 -->   if true session will be accepted automatically  }
		portName:				PPCPortPtr;								{  46 -->   Buffer for Source PPCPortRec  }
		locationName:			LocationNamePtr;						{  50 -->   Buffer for Source LocationNameRec  }
		userName:				StringPtr;								{  54 -->   Buffer for Soure user's name trying to link.  }
		userData:				UInt32;									{  58 <--   value included in PPCStart's userData  }
		requestType:			PPCSessionOrigin;						{  62 <--   Local or Network  }
		filler:					SInt8;
	END;

	PPCInformPBPtr						= ^PPCInformPBRec;
	PPCStartPBRecPtr = ^PPCStartPBRec;
	PPCStartPBRec = PACKED RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		portRefNum:				PPCPortRefNum;							{  38 -->   Port Identifier  }
		sessRefNum:				PPCSessRefNum;							{  40 <--   Session Reference  }
		serviceType:			PPCServiceType;							{  44 <--   Actual service method (realTime)  }
		resFlag:				UInt8;									{  45 -->   Must be set to 0   }
		portName:				PPCPortPtr;								{  46 -->   Destination portName  }
		locationName:			LocationNamePtr;						{  50 -->   NBP or NAS style service location name  }
		rejectInfo:				UInt32;									{  54 <--   reason for rejecting the session request  }
		userData:				UInt32;									{  58 -->   Copied to destination PPCInform parameter block  }
		userRefNum:				UInt32;									{  62 -->   userRefNum (obtained during login process)   }
	END;

	PPCStartPBPtr						= ^PPCStartPBRec;
	PPCAcceptPBRecPtr = ^PPCAcceptPBRec;
	PPCAcceptPBRec = RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{  40 -->   Session Reference  }
	END;

	PPCAcceptPBPtr						= ^PPCAcceptPBRec;
	PPCRejectPBRecPtr = ^PPCRejectPBRec;
	PPCRejectPBRec = RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{  40 -->   Session Reference  }
		filler2:				INTEGER;
		filler3:				LONGINT;
		filler4:				LONGINT;
		rejectInfo:				UInt32;									{  54 -->   reason for rejecting the session request   }
	END;

	PPCRejectPBPtr						= ^PPCRejectPBRec;
	PPCWritePBRecPtr = ^PPCWritePBRec;
	PPCWritePBRec = RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{  40 -->   Session Reference  }
		bufferLength:			Size;									{  44 -->   Length of the message buffer  }
		actualLength:			Size;									{  48 <--   Actual Length Written  }
		bufferPtr:				Ptr;									{  52 -->   Pointer to message buffer  }
		more:					BOOLEAN;								{  56 -->   if more data in this block will be written  }
		filler2:				SInt8;
		userData:				UInt32;									{  58 -->   Message block userData Uninterpreted by PPC  }
		blockCreator:			OSType;									{  62 -->   Message block creator Uninterpreted by PPC  }
		blockType:				OSType;									{  66 -->   Message block type Uninterpreted by PPC  }
	END;

	PPCWritePBPtr						= ^PPCWritePBRec;
	PPCReadPBRecPtr = ^PPCReadPBRec;
	PPCReadPBRec = RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{  40 -->   Session Reference  }
		bufferLength:			Size;									{  44 -->   Length of the message buffer  }
		actualLength:			Size;									{  48 <--   Actual length read  }
		bufferPtr:				Ptr;									{  52 -->   Pointer to message buffer  }
		more:					BOOLEAN;								{  56 <--   if true more data in this block to be read  }
		filler2:				SInt8;
		userData:				UInt32;									{  58 <--   Message block userData Uninterpreted by PPC  }
		blockCreator:			OSType;									{  62 <--   Message block creator Uninterpreted by PPC  }
		blockType:				OSType;									{  66 <--   Message block type Uninterpreted by PPC  }
	END;

	PPCReadPBPtr						= ^PPCReadPBRec;
	PPCEndPBRecPtr = ^PPCEndPBRec;
	PPCEndPBRec = RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		filler1:				INTEGER;
		sessRefNum:				PPCSessRefNum;							{  40 -->   Session Reference  }
	END;

	PPCEndPBPtr							= ^PPCEndPBRec;
	PPCClosePBRecPtr = ^PPCClosePBRec;
	PPCClosePBRec = RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		portRefNum:				PPCPortRefNum;							{  38 -->   Port Identifier  }
	END;

	PPCClosePBPtr						= ^PPCClosePBRec;
	IPCListPortsPBRecPtr = ^IPCListPortsPBRec;
	IPCListPortsPBRec = RECORD
		qLink:					Ptr;									{  PPC's Internal Use  }
		csCode:					UInt16;									{  Requested PPC command  }
		intUse:					UInt16;									{  Internal Use  }
		intUsePtr:				Ptr;									{  Internal Use  }
		ioCompletion:			PPCCompUPP;								{  12 --> Completion Routine  }
		ioResult:				OSErr;									{  16 <--     Command Result Code  }
		Reserved:				ARRAY [0..4] OF UInt32;					{  Reserved for PPC, Don't use  }
		filler1:				INTEGER;
		startIndex:				UInt16;									{  40 -->   Start Index  }
		requestCount:			UInt16;									{  42 -->   Number of entries to be returned  }
		actualCount:			UInt16;									{  44 <--   Actual Number of entries to be returned  }
		portName:				PPCPortPtr;								{  46 -->   PortName Match  }
		locationName:			LocationNamePtr;						{  50 -->   NBP or NAS type name to locate the Port Location  }
		bufferPtr:				PortInfoArrayPtr;						{  54 -->   Pointer to a buffer requestCount*sizeof(PortInfo) bytes big  }
	END;

	IPCListPortsPBPtr					= ^IPCListPortsPBRec;
	PPCParamBlockRec = RECORD
		CASE INTEGER OF
		0: (
			openParam:			PPCOpenPBRec;
			);
		1: (
			informParam:		PPCInformPBRec;
			);
		2: (
			startParam:			PPCStartPBRec;
			);
		3: (
			acceptParam:		PPCAcceptPBRec;
			);
		4: (
			rejectParam:		PPCRejectPBRec;
			);
		5: (
			writeParam:			PPCWritePBRec;
			);
		6: (
			readParam:			PPCReadPBRec;
			);
		7: (
			endParam:			PPCEndPBRec;
			);
		8: (
			closeParam:			PPCClosePBRec;
			);
		9: (
			listPortsParam:		IPCListPortsPBRec;
			);
	END;

	{	  PPC Calling Conventions  	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PPCInit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PPCInit: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A0DD, $3E80;
	{$ENDC}


{
 *  PPCOpenSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCOpenSync(pb: PPCOpenPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7001, $A0DD, $3E80;
	{$ENDC}

{
 *  PPCOpenAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCOpenAsync(pb: PPCOpenPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7001, $A4DD, $3E80;
	{$ENDC}

{
 *  PPCInformSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCInformSync(pb: PPCInformPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7003, $A0DD, $3E80;
	{$ENDC}

{
 *  PPCInformAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCInformAsync(pb: PPCInformPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7003, $A4DD, $3E80;
	{$ENDC}

{
 *  PPCStartSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCStartSync(pb: PPCStartPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7002, $A0DD, $3E80;
	{$ENDC}

{
 *  PPCStartAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCStartAsync(pb: PPCStartPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7002, $A4DD, $3E80;
	{$ENDC}

{
 *  PPCAcceptSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCAcceptSync(pb: PPCAcceptPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7004, $A0DD, $3E80;
	{$ENDC}

{
 *  PPCAcceptAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCAcceptAsync(pb: PPCAcceptPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7004, $A4DD, $3E80;
	{$ENDC}

{
 *  PPCRejectSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCRejectSync(pb: PPCRejectPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7005, $A0DD, $3E80;
	{$ENDC}

{
 *  PPCRejectAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCRejectAsync(pb: PPCRejectPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7005, $A4DD, $3E80;
	{$ENDC}

{
 *  PPCWriteSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCWriteSync(pb: PPCWritePBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7006, $A0DD, $3E80;
	{$ENDC}

{
 *  PPCWriteAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCWriteAsync(pb: PPCWritePBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7006, $A4DD, $3E80;
	{$ENDC}

{
 *  PPCReadSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCReadSync(pb: PPCReadPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7007, $A0DD, $3E80;
	{$ENDC}

{
 *  PPCReadAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCReadAsync(pb: PPCReadPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7007, $A4DD, $3E80;
	{$ENDC}

{
 *  PPCEndSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCEndSync(pb: PPCEndPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7008, $A0DD, $3E80;
	{$ENDC}

{
 *  PPCEndAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCEndAsync(pb: PPCEndPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7008, $A4DD, $3E80;
	{$ENDC}

{
 *  PPCCloseSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCCloseSync(pb: PPCClosePBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7009, $A0DD, $3E80;
	{$ENDC}

{
 *  PPCCloseAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCCloseAsync(pb: PPCClosePBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7009, $A4DD, $3E80;
	{$ENDC}

{
 *  IPCListPortsSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IPCListPortsSync(pb: IPCListPortsPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700A, $A0DD, $3E80;
	{$ENDC}

{
 *  IPCListPortsAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IPCListPortsAsync(pb: IPCListPortsPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700A, $A4DD, $3E80;
	{$ENDC}

{
 *  IPCKillListPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IPCKillListPorts(pb: IPCListPortsPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700B, $A0DD, $3E80;
	{$ENDC}

{
 *  DeleteUserIdentity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DeleteUserIdentity(userRef: UInt32): OSErr;

{
 *  GetDefaultUser()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetDefaultUser(VAR userRef: UInt32; VAR userName: Str32): OSErr;

{
 *  StartSecureSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StartSecureSession(pb: PPCStartPBPtr; VAR userName: Str32; useDefault: BOOLEAN; allowGuest: BOOLEAN; VAR guestSelected: BOOLEAN; prompt: Str255): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PPCFilterProcPtr = FUNCTION(name: LocationNamePtr; port: PortInfoPtr): BOOLEAN;
{$ELSEC}
	PPCFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PPCFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PPCFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppPPCCompProcInfo = $000000C0;
	uppPPCFilterProcInfo = $000003D0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewPPCCompUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewPPCCompUPP(userRoutine: PPCCompProcPtr): PPCCompUPP; { old name was NewPPCCompProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPPCFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPPCFilterUPP(userRoutine: PPCFilterProcPtr): PPCFilterUPP; { old name was NewPPCFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposePPCCompUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePPCCompUPP(userUPP: PPCCompUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePPCFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePPCFilterUPP(userUPP: PPCFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokePPCCompUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokePPCCompUPP(pb: PPCParamBlockPtr; userRoutine: PPCCompUPP); { old name was CallPPCCompProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePPCFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePPCFilterUPP(name: LocationNamePtr; port: PortInfoPtr; userRoutine: PPCFilterUPP): BOOLEAN; { old name was CallPPCFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  PPCBrowser()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCBrowser(prompt: Str255; applListLabel: Str255; defaultSpecified: BOOLEAN; VAR theLocation: LocationNameRec; VAR thePortInfo: PortInfoRec; portFilter: PPCFilterUPP; theLocNBPType: Str32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0D00, $A82B;
	{$ENDC}


{
  The ParamBlock calls without the "Sync" or "Async" suffix are being phased out.
}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  PPCOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCOpen(pb: PPCOpenPBPtr; async: BOOLEAN): OSErr;

{
 *  PPCInform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCInform(pb: PPCInformPBPtr; async: BOOLEAN): OSErr;

{
 *  PPCStart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCStart(pb: PPCStartPBPtr; async: BOOLEAN): OSErr;

{
 *  PPCAccept()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCAccept(pb: PPCAcceptPBPtr; async: BOOLEAN): OSErr;

{
 *  PPCReject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCReject(pb: PPCRejectPBPtr; async: BOOLEAN): OSErr;

{
 *  PPCWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCWrite(pb: PPCWritePBPtr; async: BOOLEAN): OSErr;

{
 *  PPCRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCRead(pb: PPCReadPBPtr; async: BOOLEAN): OSErr;

{
 *  PPCEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCEnd(pb: PPCEndPBPtr; async: BOOLEAN): OSErr;

{
 *  PPCClose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PPCClose(pb: PPCClosePBPtr; async: BOOLEAN): OSErr;

{
 *  IPCListPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IPCListPorts(pb: IPCListPortsPBPtr; async: BOOLEAN): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PPCToolboxIncludes}

{$ENDC} {__PPCTOOLBOX__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
