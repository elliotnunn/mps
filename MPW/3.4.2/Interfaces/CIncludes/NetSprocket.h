/*
 *	File:			NetSprocket.h
 *
 *	Version:		Apple Game Sprockets, NetSprocket 1.0.2
 *
 *	Dependencies:	Universal Interfaces 2.1.2 on ETO #20
 *					Open Transport interfaces 1.1
 *
 *	Contents:		Public interfaces for NetSprocket.
 *
 *	Bugs:			If you find a problem with this file or NetSprocketLib,
 *					please send e-mail describing the problem in enough detail
 *					to be reproduced, and include the version number above, the
 *					version of MacOS and hardware configuration information to
 *					sprockets@adr.apple.com.
 *
 *	Copyright (c) 1996 Apple Computer, Inc.  All rights reserved.
 */

#ifndef __NETSPROCKET__
#define __NETSPROCKET__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

#ifndef __OPENTPTINTERNET__
#include <OpenTptInternet.h>
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=power
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#define kNSpMaxPlayerNameLen		31
#define kNSpMaxGroupNameLen			31
#define kNSpMaxPasswordLen			31
#define kNSpMaxGameNameLen			31
#define kNSpMaxDefinitionStringLen	255


/* NetSprocket basic types */
typedef	struct NSpGamePrivate		*NSpGameReference;
typedef	struct NSpProtocolPrivate	*NSpProtocolReference;
typedef	struct NSpListPrivate		*NSpProtocolListReference;
typedef struct NSPAddressPrivate	*NSpAddressReference;
typedef SInt32						NSpEventCode;
typedef	SInt32						NSpGameID;
typedef	SInt32						NSpPlayerID;
typedef NSpPlayerID					NSpGroupID;
typedef UInt32						NSpPlayerType;
typedef SInt32						NSpFlags;

/* Individual player info */
typedef struct NSpPlayerInfo
{
	NSpPlayerID		id;
	NSpPlayerType	type;
	Str31			name;
	UInt32			groupCount;
	NSpGroupID		groups[kVariableLengthArray];
} NSpPlayerInfo, *NSpPlayerInfoPtr;

	
/* list of all players */
typedef struct NSpPlayerEnumeration
{
	UInt32				count;
	NSpPlayerInfoPtr	playerInfo[kVariableLengthArray];
} NSpPlayerEnumeration, *NSpPlayerEnumerationPtr;


/* Individual group info */
typedef struct NSpGroupInfo
{
	NSpGroupID	id;
	UInt32		playerCount;
	NSpPlayerID	players[kVariableLengthArray];
} NSpGroupInfo, *NSpGroupInfoPtr;


/* List of all groups */
typedef struct NSpGroupEnumeration
{
	UInt32			count;
	NSpGroupInfoPtr	groups[kVariableLengthArray];
} NSpGroupEnumeration, *NSpGroupEnumerationPtr;

/* Topology types */
typedef UInt32 NSpTopology;
enum
{
	kNSpClientServer = 	0x00000001
};

/* Game information */
typedef struct NSpGameInfo
{
	UInt32		maxPlayers;
	UInt32		currentPlayers;
	UInt32		currentGroups;
	NSpTopology	topology;
	UInt32		reserved;
	Str31		name;
	Str31		password;
} NSpGameInfo;
	
	
/* Structure used for sending and receiving network messages */
typedef struct NSpMessageHeader
{
	UInt32		version;	/* Used by NetSprocket.  Don't touch this */
	SInt32		what;		/* The kind of message (e.g. player joined) */
	NSpPlayerID	from;		/* ID of the sender */
	NSpPlayerID	to;			/* (player or group) id of the intended recipient */
	UInt32		id;			/* Unique ID for this message & (from) player */
	UInt32		when;		/* Timestamp for the message */
	UInt32		messageLen;	/* Bytes of data in the entire message (including the header) */
} NSpMessageHeader;


/* NetSprocket-defined message structures */

typedef struct NSpErrorMessage
{
	NSpMessageHeader	header;
	OSStatus			error;
} NSpErrorMessage;


typedef struct NSpJoinRequestMessage
{
	NSpMessageHeader	header;
	Str31				name;
	Str31				password;
	UInt32				type;
	UInt32				customDataLen;
	UInt8				customData[kVariableLengthArray];
} NSpJoinRequestMessage;


typedef struct NSpJoinApprovedMessage
{
	NSpMessageHeader	header;
} NSpJoinApprovedMessage;


typedef struct NSpJoinDeniedMessage
{
	NSpMessageHeader	header;
	Str255				reason;
} NSpJoinDeniedMessage;


typedef struct NSpPlayerJoinedMessage
{
	NSpMessageHeader	header;
	UInt32				playerCount;
	NSpPlayerInfo			playerInfo;	
} NSpPlayerJoinedMessage;


typedef struct NSpPlayerLeftMessage
{
	NSpMessageHeader	header;
	UInt32				playerCount;
	NSpPlayerID			playerID;	
} NSpPlayerLeftMessage;

typedef struct NSpHostChangedMessage
{
	NSpMessageHeader	header;
	NSpPlayerID			newHost;
} NSpHostChangedMessage;


typedef struct NSpGameTerminatedMessage
{
	NSpMessageHeader	header;
} NSpGameTerminatedMessage;


/* Different kinds of messages.  These can NOT be bitwise ORed together */
enum
{
	kNSpSendFlag_Junk = 		0x00100000,		/* will be sent (try once) when there is nothing else pending */
	kNSpSendFlag_Normal = 		0x00200000,		/* will be sent immediately (try once) */
	kNSpSendFlag_Registered = 	0x00400000		/* will be sent immediately (guaranteed, in order) */
};


/* Options for message delivery.  These can be bitwise ORed together with each other,
		as well as with ONE of the above */
enum 
{
	kNSpSendFlag_FailIfPipeFull = 	0x00000001,
	kNSpSendFlag_SelfSend = 		0x00000002,
	kNSpSendFlag_Blocking = 		0x00000004
};


/* Options for Hosting Joining, and Deleting games */
enum
{
	kNSpGameFlag_DontAdvertise			=	0x00000001,
	kNSpGameFlag_ForceTerminateGame 	= 	0x00000002
};

/* Message "what" types */
/* Apple reserves all negative "what" values (anything with bit 32 set) */ 
enum 
{
	kNSpSystemMessagePrefix = 0x80000000,
	kNSpError =		 		kNSpSystemMessagePrefix | 0x7FFFFFFF,
	kNSpJoinRequest = 		kNSpSystemMessagePrefix | 0x00000001,
	kNSpJoinApproved = 		kNSpSystemMessagePrefix | 0x00000002,
	kNSpJoinDenied = 		kNSpSystemMessagePrefix | 0x00000003,
	kNSpPlayerJoined = 		kNSpSystemMessagePrefix | 0x00000004,
	kNSpPlayerLeft = 		kNSpSystemMessagePrefix | 0x00000005,
	kNSpHostChanged = 		kNSpSystemMessagePrefix | 0x00000006,
	kNSpGameTerminated= 	kNSpSystemMessagePrefix | 0x00000007
};


/* Special TPlayerIDs  for sending messages */
enum
{
	kNSpAllPlayers = 	0x00000000,
	kNSpHostOnly =		0xFFFFFFFF
};
	
#ifdef __cplusplus
extern "C" {
#endif

/************************  Initialization  ************************/

OSStatus NSpInitialize(
	UInt32 						inStandardMessageSize, 
	UInt32 						inBufferSize, 
	UInt32 						inQElements, 
	NSpGameID 					inGameID, 
	UInt32 						inTimeout);


/**************************  Protocols  **************************/

/* Programmatic protocol routines */
OSStatus NSpProtocol_New(
	const char* 				inDefinitionString, 
	NSpProtocolReference*		outReference);

void NSpProtocol_Dispose(
	NSpProtocolReference 		inProtocolRef);

OSStatus NSpProtocol_ExtractDefinitionString(
	NSpProtocolReference 		inProtocolRef, 
	char*						outDefinitionString);


/* Protocol list routines */
OSStatus NSpProtocolList_New(
	NSpProtocolReference 		inProtocolRef,
	NSpProtocolListReference*	outList);

void NSpProtocolList_Dispose(
	NSpProtocolListReference 	inProtocolList);

OSStatus NSpProtocolList_Append(
	NSpProtocolListReference 	inProtocolList,
	NSpProtocolReference 		inProtocolRef);

OSStatus NSpProtocolList_Remove(
	NSpProtocolListReference 	inProtocolList, 
	NSpProtocolReference 		inProtocolRef);

OSStatus NSpProtocolList_RemoveIndexed(
	NSpProtocolListReference 	inProtocolList,
	UInt32 						inIndex);

UInt32 NSpProtocolList_GetCount(
	NSpProtocolListReference 	inProtocolList);

NSpProtocolReference NSpProtocolList_GetIndexedRef(
	NSpProtocolListReference 	inProtocolList,
	UInt32 						inIndex);


/* Helpers */
NSpProtocolReference NSpProtocol_CreateAppleTalk(
	ConstStr31Param 			inNBPName,
	ConstStr31Param 			inNBPType, 
	UInt32 						inMaxRTT,
	UInt32 						inMinThruput);

NSpProtocolReference NSpProtocol_CreateIP(
	InetPort 					inPort,
	UInt32 						inMaxRTT,
	UInt32 						inMinThruput);


/***********************  Human Interface  ************************/
typedef pascal Boolean (*NSpEventProcPtr) (EventRecord* inEvent);


NSpAddressReference NSpDoModalJoinDialog(
	ConstStr31Param 			inGameType, 
	ConstStr255Param 			inEntityListLabel,
	Str31 						ioName, 
	Str31 						ioPassword, 
	NSpEventProcPtr 			inEventProcPtr);

Boolean NSpDoModalHostDialog(
	NSpProtocolListReference 	ioProtocolList, 
	Str31 						ioGameName, 
	Str31 						ioPlayerName,
	Str31 						ioPassword, 
	NSpEventProcPtr 			inEventProcPtr);


/*********************  Hosting and Joining  **********************/

OSStatus NSpGame_Host(
	NSpGameReference*			outGame, 
	NSpProtocolListReference 	inProtocolList, 
	UInt32 						inMaxPlayers, 
	ConstStr31Param 			inGameName, 
	ConstStr31Param 			inPassword,
	ConstStr31Param 			inPlayerName, 
	NSpPlayerType 				inPlayerType, 
	NSpTopology 				inTopology,
	NSpFlags 					inFlags);
 
OSStatus NSpGame_Join(
	NSpGameReference*			outGame, 
	NSpAddressReference 		inAddress, 
	ConstStr31Param 			inName,
	ConstStr31Param 			inPassword,
	NSpPlayerType 				inType, 
	void*						inCustomData,
	UInt32 						inCustomDataLen,  
	NSpFlags 					inFlags);

OSStatus NSpGame_EnableAdvertising(
	NSpGameReference 			inGame, 
	NSpProtocolReference 		inProtocol, 
	Boolean 					inEnable);

OSStatus NSpGame_Dispose(
	NSpGameReference 			inGame, 
	NSpFlags 					inFlags);

OSStatus NSpGame_GetInfo(
	NSpGameReference 			inGame,
	NSpGameInfo  				*ioInfo);

/**************************  Messaging  **************************/

OSStatus NSpMessage_Send(
	NSpGameReference 			inGame, 
	NSpMessageHeader*			inMessage, 
	NSpFlags 					inFlags);

NSpMessageHeader *NSpMessage_Get(
	NSpGameReference 			inGame);

void NSpMessage_Release(
	NSpGameReference 			inGame, 
	NSpMessageHeader*			inMessage);

/* Helpers */
OSStatus NSpMessage_SendTo(
	NSpGameReference 			inGame,
	NSpPlayerID					inTo,
	SInt32						inWhat, 
	void*						inData,
	UInt32						inDataLen, 
	NSpFlags 					inFlags);
	

/*********************  Player Information  **********************/

NSpPlayerID NSpPlayer_GetMyID(
	NSpGameReference 			inGame);

OSStatus NSpPlayer_GetInfo(
	NSpGameReference 			inGame, 
	NSpPlayerID 				inPlayerID, 
	NSpPlayerInfoPtr*			outInfo);

void NSpPlayer_ReleaseInfo(
	NSpGameReference 			inGame, 
	NSpPlayerInfoPtr 			inInfo);

OSStatus NSpPlayer_GetEnumeration(
	NSpGameReference 			inGame, 
	NSpPlayerEnumerationPtr*	outPlayers);

void NSpPlayer_ReleaseEnumeration(
	NSpGameReference 			inGame, 
	NSpPlayerEnumerationPtr 	inPlayers);

UInt32 NSpPlayer_GetRoundTripTime(
	NSpGameReference 			inGame, 
	NSpPlayerID 				inPlayer); 

UInt32 NSpPlayer_GetThruput(
	NSpGameReference 			inGame, 
	NSpPlayerID 				inPlayer); 


/*********************  Group Management  **********************/

OSStatus NSpGroup_New(
	NSpGameReference 			inGame, 
	NSpGroupID*					outGroupID);

OSStatus NSpGroup_Dispose(
	NSpGameReference 			inGame, 
	NSpGroupID 					inGroupID);

OSStatus NSpGroup_AddPlayer(
	NSpGameReference 			inGame, 
	NSpGroupID 					inGroupID, 
	NSpPlayerID 				inPlayerID);

OSStatus NSpGroup_RemovePlayer(
	NSpGameReference 			inGame, 
	NSpGroupID 					inGroupID,
	NSpPlayerID 				inPlayerID);

OSStatus NSpGroup_GetInfo(
	NSpGameReference 			inGame, 
	NSpGroupID 					inGroupID, 
	NSpGroupInfoPtr*			outInfo);

void NSpGroup_ReleaseInfo(
	NSpGameReference 			inGame, 
	NSpGroupInfoPtr 			inInfo);

OSStatus NSpGroup_GetEnumeration(
	NSpGameReference 			inGame, 
	NSpGroupEnumerationPtr*		outGroups);

void NSpGroup_ReleaseEnumeration(
	NSpGameReference 			inGame, 
	NSpGroupEnumerationPtr 		inGroups);


/**************************  Utilities  ***************************/

NumVersion NSpGetVersion(void);

void NSpClearMessageHeader(
	NSpMessageHeader*			inMessage);

UInt32 NSpGetCurrentTimeStamp(
	NSpGameReference 			inGame);

NSpAddressReference	NSpConvertOTAddrToAddressReference(
	OTAddress*					inAddress);

OTAddress *NSpConvertAddressReferenceToOTAddr(
	NSpAddressReference 		inAddress);

void NSpReleaseAddressReference(
	NSpAddressReference 		inAddress);


/************************ Advanced/Async routines ****************/

typedef pascal void (*NSpCallbackProcPtr)(
	NSpGameReference 			inGame, 
	void* 						inContext, 
	NSpEventCode 				inCode, 
	OSStatus 					inStatus, 
	void* 						inCookie);

OSStatus NSpInstallCallbackHandler(
	NSpCallbackProcPtr 			inHandler, 
	void*						inContext);


typedef pascal Boolean (*NSpJoinRequestHandlerProcPtr)(
	NSpGameReference 			inGame, 
	NSpJoinRequestMessage*		inMessage, 
	void* 						inContext,
	Str255						outReason);

OSStatus NSpInstallJoinRequestHandler(
	NSpJoinRequestHandlerProcPtr inHandler, 
	void*						inContext);


typedef pascal Boolean (*NSpMessageHandlerProcPtr)(
	NSpGameReference 			inGame, 
	NSpMessageHeader*			inMessage, 
	void* 						inContext);

OSStatus NSpInstallAsyncMessageHandler(
	NSpMessageHandlerProcPtr 	inHandler, 
	void*						inContext);




#ifdef __cplusplus
}
#endif

#ifdef __CFM68K__
#pragma import reset
#endif

/* NetSprocket Error Codes */
enum
{
	kNSpInitializationFailedErr 		= -30360,
	kNSpAlreadyInitializedErr 			= -30361,
	kNSpTopologyNotSupportedErr 		= -30362,
	kNSpPipeFullErr		 				= -30364,
	kNSpHostFailedErr 					= -30365,
	kNSpProtocolNotAvailableErr 		= -30366,
	kNSpInvalidGameRefErr 				= -30367,
	kNSpInvalidParameterErr 			= -30369,
	kNSpOTNotPresentErr 				= -30370,
	kNSpOTVersionTooOldErr				= -30371,
	kNSpMemAllocationErr 				= -30373,
	kNSpAlreadyAdvertisingErr 			= -30374,
	kNSpNotAdvertisingErr 				= -30376,
	kNSpInvalidAddressErr 				= -30377,
	kNSpFreeQExhaustedErr				= -30378,
	kNSpRemovePlayerFailedErr			= -30379,
	kNSpAddressInUseErr					= -30380,
	kNSpFeatureNotImplementedErr		= -30381,
	kNSpNameRequiredErr 				= -30382,
	kNSpInvalidPlayerIDErr 				= -30383,
	kNSpInvalidGroupIDErr 				= -30384,
	kNSpNoPlayersErr 					= -30385,
	kNSpNoGroupsErr 					= -30386,
	kNSpNoHostVolunteersErr 			= -30387,
	kNSpCreateGroupFailedErr 			= -30388,
	kNSpAddPlayerFailedErr 				= -30389,
	kNSpInvalidDefinitionErr			= -30390,
	kNSpInvalidProtocolRefErr			= -30391,
	kNSpInvalidProtocolListErr			= -30392,
	kNSpTimeoutErr						= -30393,
	kNSpGameTerminatedErr				= -30394,
	kNSpConnectFailedErr				= -30395,
	kNSpSendFailedErr					= -30396,
	kNSpJoinFailedErr					= -30399
};



#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif /* __NETSPROCKET__ */
