{
     File:       NetSprocket.p
 
     Contains:   Games Sprockets: NetSprocket interfaces
 
     Version:    Technology: NetSprocket 1.7
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
 UNIT NetSprocket;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NETSPROCKET__}
{$SETC __NETSPROCKET__ := 1}

{$I+}
{$SETC NetSprocketIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}
{$IFC UNDEFINED __OPENTRANSPORTPROVIDERS__}
{$I OpenTransportProviders.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{$IFC TARGET_OS_MAC }

CONST
	kNSpMaxPlayerNameLen		= 31;
	kNSpMaxGroupNameLen			= 31;
	kNSpMaxPasswordLen			= 31;
	kNSpMaxGameNameLen			= 31;
	kNSpMaxDefinitionStringLen	= 255;


	{	 NetSprocket basic types 	}

TYPE
	NSpGameReference    = ^LONGINT; { an opaque 32-bit type }
	NSpGameReferencePtr = ^NSpGameReference;  { when a VAR xx:NSpGameReference parameter can be nil, it is changed to xx: NSpGameReferencePtr }
	NSpProtocolReference    = ^LONGINT; { an opaque 32-bit type }
	NSpProtocolReferencePtr = ^NSpProtocolReference;  { when a VAR xx:NSpProtocolReference parameter can be nil, it is changed to xx: NSpProtocolReferencePtr }
	NSpProtocolListReference    = ^LONGINT; { an opaque 32-bit type }
	NSpProtocolListReferencePtr = ^NSpProtocolListReference;  { when a VAR xx:NSpProtocolListReference parameter can be nil, it is changed to xx: NSpProtocolListReferencePtr }
	NSpAddressReference    = ^LONGINT; { an opaque 32-bit type }
	NSpAddressReferencePtr = ^NSpAddressReference;  { when a VAR xx:NSpAddressReference parameter can be nil, it is changed to xx: NSpAddressReferencePtr }
	NSpEventCode						= SInt32;
	NSpGameID							= SInt32;
	NSpPlayerID							= SInt32;
	NSpGroupID							= NSpPlayerID;
	NSpPlayerType						= UInt32;
	NSpFlags							= SInt32;
	NSpPlayerName						= Str31;
	{	 Individual player info 	}
	NSpPlayerInfoPtr = ^NSpPlayerInfo;
	NSpPlayerInfo = RECORD
		id:						NSpPlayerID;
		playerType:				NSpPlayerType;							{  "type" in C }
		name:					Str31;
		groupCount:				UInt32;
		groups:					ARRAY [0..0] OF NSpGroupID;
	END;

	{	 list of all players 	}
	NSpPlayerEnumerationPtr = ^NSpPlayerEnumeration;
	NSpPlayerEnumeration = RECORD
		count:					UInt32;
		playerInfo:				ARRAY [0..0] OF NSpPlayerInfoPtr;
	END;

	{	 Individual group info 	}
	NSpGroupInfoPtr = ^NSpGroupInfo;
	NSpGroupInfo = RECORD
		id:						NSpGroupID;
		playerCount:			UInt32;
		players:				ARRAY [0..0] OF NSpPlayerID;
	END;

	{	 List of all groups 	}
	NSpGroupEnumerationPtr = ^NSpGroupEnumeration;
	NSpGroupEnumeration = RECORD
		count:					UInt32;
		groups:					ARRAY [0..0] OF NSpGroupInfoPtr;
	END;

	{	 Topology types 	}
	NSpTopology							= UInt32;

CONST
	kNSpClientServer			= $00000001;

	{	 Game information 	}

TYPE
	NSpGameInfoPtr = ^NSpGameInfo;
	NSpGameInfo = RECORD
		maxPlayers:				UInt32;
		currentPlayers:			UInt32;
		currentGroups:			UInt32;
		topology:				NSpTopology;
		reserved:				UInt32;
		name:					Str31;
		password:				Str31;
	END;

	{	 Structure used for sending and receiving network messages 	}
	NSpMessageHeaderPtr = ^NSpMessageHeader;
	NSpMessageHeader = RECORD
		version:				UInt32;									{  Used by NetSprocket.  Don't touch this  }
		what:					SInt32;									{  The kind of message (e.g. player joined)  }
		from:					NSpPlayerID;							{  ID of the sender  }
		toID:					NSpPlayerID;							{  (player or group) id of the intended recipient (was "to)  }
		id:						UInt32;									{  Unique ID for this message & (from) player  }
		when:					UInt32;									{  Timestamp for the message  }
		messageLen:				UInt32;									{  Bytes of data in the entire message (including the header)  }
	END;

	{	 NetSprocket-defined message structures 	}
	NSpErrorMessagePtr = ^NSpErrorMessage;
	NSpErrorMessage = RECORD
		header:					NSpMessageHeader;
		error:					OSStatus;
	END;

	NSpJoinRequestMessagePtr = ^NSpJoinRequestMessage;
	NSpJoinRequestMessage = RECORD
		header:					NSpMessageHeader;
		name:					Str31;
		password:				Str31;
		theType:				UInt32;
		customDataLen:			UInt32;
		customData:				SInt8;
	END;

	NSpJoinApprovedMessagePtr = ^NSpJoinApprovedMessage;
	NSpJoinApprovedMessage = RECORD
		header:					NSpMessageHeader;
	END;

	NSpJoinDeniedMessagePtr = ^NSpJoinDeniedMessage;
	NSpJoinDeniedMessage = RECORD
		header:					NSpMessageHeader;
		reason:					Str255;
	END;

	NSpPlayerJoinedMessagePtr = ^NSpPlayerJoinedMessage;
	NSpPlayerJoinedMessage = RECORD
		header:					NSpMessageHeader;
		playerCount:			UInt32;
		playerInfo:				NSpPlayerInfo;
	END;

	NSpPlayerLeftMessagePtr = ^NSpPlayerLeftMessage;
	NSpPlayerLeftMessage = RECORD
		header:					NSpMessageHeader;
		playerCount:			UInt32;
		playerID:				NSpPlayerID;
		playerName:				NSpPlayerName;
	END;

	NSpHostChangedMessagePtr = ^NSpHostChangedMessage;
	NSpHostChangedMessage = RECORD
		header:					NSpMessageHeader;
		newHost:				NSpPlayerID;
	END;

	NSpGameTerminatedMessagePtr = ^NSpGameTerminatedMessage;
	NSpGameTerminatedMessage = RECORD
		header:					NSpMessageHeader;
	END;

	NSpCreateGroupMessagePtr = ^NSpCreateGroupMessage;
	NSpCreateGroupMessage = RECORD
		header:					NSpMessageHeader;
		groupID:				NSpGroupID;
		requestingPlayer:		NSpPlayerID;
	END;

	NSpDeleteGroupMessagePtr = ^NSpDeleteGroupMessage;
	NSpDeleteGroupMessage = RECORD
		header:					NSpMessageHeader;
		groupID:				NSpGroupID;
		requestingPlayer:		NSpPlayerID;
	END;

	NSpAddPlayerToGroupMessagePtr = ^NSpAddPlayerToGroupMessage;
	NSpAddPlayerToGroupMessage = RECORD
		header:					NSpMessageHeader;
		group:					NSpGroupID;
		player:					NSpPlayerID;
	END;

	NSpRemovePlayerFromGroupMessagePtr = ^NSpRemovePlayerFromGroupMessage;
	NSpRemovePlayerFromGroupMessage = RECORD
		header:					NSpMessageHeader;
		group:					NSpGroupID;
		player:					NSpPlayerID;
	END;

	NSpPlayerTypeChangedMessagePtr = ^NSpPlayerTypeChangedMessage;
	NSpPlayerTypeChangedMessage = RECORD
		header:					NSpMessageHeader;
		player:					NSpPlayerID;
		newType:				NSpPlayerType;
	END;

	{	 Different kinds of messages.  These can NOT be bitwise ORed together 	}

CONST
	kNSpSendFlag_Junk			= $00100000;					{  will be sent (try once) when there is nothing else pending  }
	kNSpSendFlag_Normal			= $00200000;					{  will be sent immediately (try once)  }
	kNSpSendFlag_Registered		= $00400000;					{  will be sent immediately (guaranteed, in order)  }


	{	 Options for message delivery.  These can be bitwise ORed together with each other,
	        as well as with ONE of the above 	}
	kNSpSendFlag_FailIfPipeFull	= $00000001;
	kNSpSendFlag_SelfSend		= $00000002;
	kNSpSendFlag_Blocking		= $00000004;


	{	 Options for Hosting Joining, and Deleting games 	}
	kNSpGameFlag_DontAdvertise	= $00000001;
	kNSpGameFlag_ForceTerminateGame = $00000002;

	{	 Message "what" types 	}
	{	 Apple reserves all negative "what" values (anything with high bit set) 	}
	kNSpSystemMessagePrefix		= $80000000;
	kNSpError					= $FFFFFFFF;
	kNSpJoinRequest				= $80000001;
	kNSpJoinApproved			= $80000002;
	kNSpJoinDenied				= $80000003;
	kNSpPlayerJoined			= $80000004;
	kNSpPlayerLeft				= $80000005;
	kNSpHostChanged				= $80000006;
	kNSpGameTerminated			= $80000007;
	kNSpGroupCreated			= $80000008;
	kNSpGroupDeleted			= $80000009;
	kNSpPlayerAddedToGroup		= $8000000A;
	kNSpPlayerRemovedFromGroup	= $8000000B;
	kNSpPlayerTypeChanged		= $8000000C;


	{	 Special TPlayerIDs  for sending messages 	}
	kNSpAllPlayers				= $00000000;
	kNSpHostOnly				= $FFFFFFFF;



	{	***********************  Initialization  ***********************	}
	{
	 *  NSpInitialize()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION NSpInitialize(inStandardMessageSize: UInt32; inBufferSize: UInt32; inQElements: UInt32; inGameID: NSpGameID; inTimeout: UInt32): OSStatus; C;




{*************************  Protocols  *************************}
{ Programmatic protocol routines }
{
 *  NSpProtocol_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocol_New(inDefinitionString: ConstCStringPtr; VAR outReference: NSpProtocolReference): OSStatus; C;

{
 *  NSpProtocol_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpProtocol_Dispose(inProtocolRef: NSpProtocolReference); C;

{
 *  NSpProtocol_ExtractDefinitionString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocol_ExtractDefinitionString(inProtocolRef: NSpProtocolReference; outDefinitionString: CStringPtr): OSStatus; C;


{ Protocol list routines }
{
 *  NSpProtocolList_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocolList_New(inProtocolRef: NSpProtocolReference; VAR outList: NSpProtocolListReference): OSStatus; C;

{
 *  NSpProtocolList_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpProtocolList_Dispose(inProtocolList: NSpProtocolListReference); C;

{
 *  NSpProtocolList_Append()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocolList_Append(inProtocolList: NSpProtocolListReference; inProtocolRef: NSpProtocolReference): OSStatus; C;

{
 *  NSpProtocolList_Remove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocolList_Remove(inProtocolList: NSpProtocolListReference; inProtocolRef: NSpProtocolReference): OSStatus; C;

{
 *  NSpProtocolList_RemoveIndexed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocolList_RemoveIndexed(inProtocolList: NSpProtocolListReference; inIndex: UInt32): OSStatus; C;

{
 *  NSpProtocolList_GetCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocolList_GetCount(inProtocolList: NSpProtocolListReference): UInt32; C;

{
 *  NSpProtocolList_GetIndexedRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocolList_GetIndexedRef(inProtocolList: NSpProtocolListReference; inIndex: UInt32): NSpProtocolReference; C;


{ Helpers }
{
 *  NSpProtocol_CreateAppleTalk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocol_CreateAppleTalk(inNBPName: Str31; inNBPType: Str31; inMaxRTT: UInt32; inMinThruput: UInt32): NSpProtocolReference; C;

{
 *  NSpProtocol_CreateIP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpProtocol_CreateIP(inPort: InetPort; inMaxRTT: UInt32; inMinThruput: UInt32): NSpProtocolReference; C;


{**********************  Human Interface  ***********************}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NSpEventProcPtr = FUNCTION(VAR inEvent: EventRecord): BOOLEAN;
{$ELSEC}
	NSpEventProcPtr = ProcPtr;
{$ENDC}

	{
	 *  NSpDoModalJoinDialog()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION NSpDoModalJoinDialog(inGameType: Str31; inEntityListLabel: Str255; VAR ioName: Str31; VAR ioPassword: Str31; inEventProcPtr: NSpEventProcPtr): NSpAddressReference; C;

{
 *  NSpDoModalHostDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpDoModalHostDialog(ioProtocolList: NSpProtocolListReference; VAR ioGameName: Str31; VAR ioPlayerName: Str31; VAR ioPassword: Str31; inEventProcPtr: NSpEventProcPtr): BOOLEAN; C;


{********************  Hosting and Joining  *********************}
{
 *  NSpGame_Host()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGame_Host(VAR outGame: NSpGameReference; inProtocolList: NSpProtocolListReference; inMaxPlayers: UInt32; inGameName: Str31; inPassword: Str31; inPlayerName: Str31; inPlayerType: NSpPlayerType; inTopology: NSpTopology; inFlags: NSpFlags): OSStatus; C;

{
 *  NSpGame_Join()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGame_Join(VAR outGame: NSpGameReference; inAddress: NSpAddressReference; inName: Str31; inPassword: Str31; inType: NSpPlayerType; inCustomData: UNIV Ptr; inCustomDataLen: UInt32; inFlags: NSpFlags): OSStatus; C;

{
 *  NSpGame_EnableAdvertising()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGame_EnableAdvertising(inGame: NSpGameReference; inProtocol: NSpProtocolReference; inEnable: BOOLEAN): OSStatus; C;

{
 *  NSpGame_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGame_Dispose(inGame: NSpGameReference; inFlags: NSpFlags): OSStatus; C;

{
 *  NSpGame_GetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0.3 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGame_GetInfo(inGame: NSpGameReference; VAR ioInfo: NSpGameInfo): OSStatus; C;

{*************************  Messaging  *************************}
{
 *  NSpMessage_Send()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpMessage_Send(inGame: NSpGameReference; VAR inMessage: NSpMessageHeader; inFlags: NSpFlags): OSStatus; C;

{
 *  NSpMessage_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpMessage_Get(inGame: NSpGameReference): NSpMessageHeaderPtr; C;

{
 *  NSpMessage_Release()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpMessage_Release(inGame: NSpGameReference; VAR inMessage: NSpMessageHeader); C;

{ Helpers }
{
 *  NSpMessage_SendTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpMessage_SendTo(inGame: NSpGameReference; inTo: NSpPlayerID; inWhat: SInt32; inData: UNIV Ptr; inDataLen: UInt32; inFlags: NSpFlags): OSStatus; C;


{********************  Player Information  *********************}
{
 *  NSpPlayer_ChangeType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpPlayer_ChangeType(inGame: NSpGameReference; inPlayerID: NSpPlayerID; inNewType: NSpPlayerType): OSStatus; C;

{
 *  NSpPlayer_Remove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpPlayer_Remove(inGame: NSpGameReference; inPlayerID: NSpPlayerID): OSStatus; C;

{
 *  NSpPlayer_GetAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpPlayer_GetAddress(inGame: NSpGameReference; inPlayerID: NSpPlayerID; VAR outAddress: UNIV Ptr): OSStatus; C;

{
 *  NSpPlayer_GetMyID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpPlayer_GetMyID(inGame: NSpGameReference): NSpPlayerID; C;

{
 *  NSpPlayer_GetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpPlayer_GetInfo(inGame: NSpGameReference; inPlayerID: NSpPlayerID; VAR outInfo: NSpPlayerInfoPtr): OSStatus; C;

{
 *  NSpPlayer_ReleaseInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpPlayer_ReleaseInfo(inGame: NSpGameReference; inInfo: NSpPlayerInfoPtr); C;

{
 *  NSpPlayer_GetEnumeration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpPlayer_GetEnumeration(inGame: NSpGameReference; VAR outPlayers: NSpPlayerEnumerationPtr): OSStatus; C;

{
 *  NSpPlayer_ReleaseEnumeration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpPlayer_ReleaseEnumeration(inGame: NSpGameReference; inPlayers: NSpPlayerEnumerationPtr); C;

{
 *  NSpPlayer_GetRoundTripTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpPlayer_GetRoundTripTime(inGame: NSpGameReference; inPlayer: NSpPlayerID): UInt32; C;

{
 *  NSpPlayer_GetThruput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpPlayer_GetThruput(inGame: NSpGameReference; inPlayer: NSpPlayerID): UInt32; C;


{********************  Group Management  *********************}
{
 *  NSpGroup_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGroup_New(inGame: NSpGameReference; VAR outGroupID: NSpGroupID): OSStatus; C;

{
 *  NSpGroup_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGroup_Dispose(inGame: NSpGameReference; inGroupID: NSpGroupID): OSStatus; C;

{
 *  NSpGroup_AddPlayer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGroup_AddPlayer(inGame: NSpGameReference; inGroupID: NSpGroupID; inPlayerID: NSpPlayerID): OSStatus; C;

{
 *  NSpGroup_RemovePlayer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGroup_RemovePlayer(inGame: NSpGameReference; inGroupID: NSpGroupID; inPlayerID: NSpPlayerID): OSStatus; C;

{
 *  NSpGroup_GetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGroup_GetInfo(inGame: NSpGameReference; inGroupID: NSpGroupID; VAR outInfo: NSpGroupInfoPtr): OSStatus; C;

{
 *  NSpGroup_ReleaseInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpGroup_ReleaseInfo(inGame: NSpGameReference; inInfo: NSpGroupInfoPtr); C;

{
 *  NSpGroup_GetEnumeration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGroup_GetEnumeration(inGame: NSpGameReference; VAR outGroups: NSpGroupEnumerationPtr): OSStatus; C;

{
 *  NSpGroup_ReleaseEnumeration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpGroup_ReleaseEnumeration(inGame: NSpGameReference; inGroups: NSpGroupEnumerationPtr); C;


{*************************  Utilities  **************************}
{
 *  NSpGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0.3 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGetVersion: NumVersion; C;

{
 *  NSpSetConnectTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpSetConnectTimeout(inSeconds: UInt32); C;

{
 *  NSpClearMessageHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpClearMessageHeader(VAR inMessage: NSpMessageHeader); C;

{
 *  NSpGetCurrentTimeStamp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpGetCurrentTimeStamp(inGame: NSpGameReference): UInt32; C;

{
 *  NSpConvertOTAddrToAddressReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpConvertOTAddrToAddressReference(VAR inAddress: OTAddress): NSpAddressReference; C;

{
 *  NSpConvertAddressReferenceToOTAddr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION NSpConvertAddressReferenceToOTAddr(inAddress: NSpAddressReference): OTAddressPtr; C;

{
 *  NSpReleaseAddressReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
PROCEDURE NSpReleaseAddressReference(inAddress: NSpAddressReference); C;


{*********************** Advanced/Async routines ***************}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NSpCallbackProcPtr = PROCEDURE(inGame: NSpGameReference; inContext: UNIV Ptr; inCode: NSpEventCode; inStatus: OSStatus; inCookie: UNIV Ptr);
{$ELSEC}
	NSpCallbackProcPtr = ProcPtr;
{$ENDC}

	{
	 *  NSpInstallCallbackHandler()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION NSpInstallCallbackHandler(inHandler: NSpCallbackProcPtr; inContext: UNIV Ptr): OSStatus; C;



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NSpJoinRequestHandlerProcPtr = FUNCTION(inGame: NSpGameReference; VAR inMessage: NSpJoinRequestMessage; inContext: UNIV Ptr; VAR outReason: Str255): BOOLEAN;
{$ELSEC}
	NSpJoinRequestHandlerProcPtr = ProcPtr;
{$ENDC}

	{
	 *  NSpInstallJoinRequestHandler()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION NSpInstallJoinRequestHandler(inHandler: NSpJoinRequestHandlerProcPtr; inContext: UNIV Ptr): OSStatus; C;



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NSpMessageHandlerProcPtr = FUNCTION(inGame: NSpGameReference; VAR inMessage: NSpMessageHeader; inContext: UNIV Ptr): BOOLEAN;
{$ELSEC}
	NSpMessageHandlerProcPtr = ProcPtr;
{$ENDC}

	{
	 *  NSpInstallAsyncMessageHandler()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in NetSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but NetSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION NSpInstallAsyncMessageHandler(inHandler: NSpMessageHandlerProcPtr; inContext: UNIV Ptr): OSStatus; C;



{$ENDC}  {TARGET_OS_MAC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NetSprocketIncludes}

{$ENDC} {__NETSPROCKET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
