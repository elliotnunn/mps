/*
 	File:		OCEAuthDir.h
 
 	Contains:	Apple Open Collaboration Environment Authentication Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __OCEAUTHDIR__
#define __OCEAUTHDIR__


#ifndef __EVENTS__
#include <Events.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <Quickdraw.h>										*/
/*		#include <MixedMode.h>									*/
/*		#include <QuickdrawText.h>								*/
/*	#include <OSUtils.h>										*/
/*		#include <Memory.h>										*/

#ifndef __NOTIFICATION__
#include <Notification.h>
#endif

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/

#ifndef __APPLETALK__
#include <AppleTalk.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __OCE__
#include <OCE.h>
#endif
/*	#include <Aliases.h>										*/
/*	#include <Script.h>											*/
/*		#include <IntlResources.h>								*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	kRC4KeySizeInBytes			= 8,							/* size of an RC4 key */
	kRefNumUnknown				= 0
};

enum {
	kEnumDistinguishedNameBit,
	kEnumAliasBit,
	kEnumPseudonymBit,
	kEnumDNodeBit,
	kEnumInvisibleBit
};

/* Values of DirEnumChoices */
enum {
	kEnumDistinguishedNameMask	= 1L << kEnumDistinguishedNameBit,
	kEnumAliasMask				= 1L << kEnumAliasBit,
	kEnumPseudonymMask			= 1L << kEnumPseudonymBit,
	kEnumDNodeMask				= 1L << kEnumDNodeBit,
	kEnumInvisibleMask			= 1L << kEnumInvisibleBit,
	kEnumAllMask				= (kEnumDistinguishedNameMask | kEnumAliasMask | kEnumPseudonymMask | kEnumDNodeMask | kEnumInvisibleMask)
};

typedef unsigned long DirEnumChoices;

/* Values of DirSortOption */

enum {
	kSortByName					= 0,
	kSortByType					= 1
};

/* Values of DirSortDirection */
enum {
	kSortForwards				= 0,
	kSortBackwards				= 1
};

/* Values of DirMatchWith */
enum {
	kMatchAll,
	kExactMatch,
	kBeginsWith,
	kEndingWith,
	kContaining
};

typedef unsigned char DirMatchWith;


enum {
	kCurrentOCESortVersion		= 1
};

/*  Access controls are implemented on three levels:
 *  	DNode, Record, and Attribute Type levels
 *  Some access control bits apply to the container itself, and some apply to its contents.
 *
 *  The Catalog Toolbox supports six functions.  These calls are:
 *  DSGetDNodeAccessControl : to get Access Controls at the DNode level
 *	DSGetRecordAccessControl  : to get Access Controls at the record level
 *  DSGetAttributeAccessControl : to get Access Privileges at the attribute type level
 * 
 *  The GetXXXAccessControl calls will return access control masks for various categories
 *  of users.  Please refer to the access control document for a description of the
 *  categories of users.  In general these are:
 *  	ThisRecordOwner 		- means the identity of the record itself
 *  	Friends 				 - means any one of the assigned friends for the record
 *  	AuthenticatedInDNode     - means any valid user that is an authenticated entity
 *  		in the DNode in which this record is located
 *  	AuthenticatedInDirectory - means any valid authenticated catalog user
 *  	Guest 					 - means an unauthenticated user.
 *  Bit masks for various permitted access controls are defined below.
 *
 *  GetXXXAccessControl calls will return access control masks for various categories of
 *  users for this record. In addition they also return the level of access controls
 *  that the user (who is making the GetXXXAccessControl call) has for the DNode,
 *  record, or attribute type.
 *
 *  For records, the access control granted will be minimum of the DNode access
 *  control and record access control masks.  For example, to add an attribute type to a
 *  record, a user must have access control kCreateAttributeTypes at the record and
 *  DNode levels.  Similarly, at the attribute type level, access controls will be the
 *  minimum of the DNode, record, and attribute type access controls.
 *
 *  
 */
/* access privileges bit numbers */
enum {
	kSeeBit						= 0,
	kAddBit						= 1,
	kDeleteBit					= 2,
	kChangeBit					= 3,
	kRenameBit					= 4,
	kChangePrivsBit				= 5,
	kSeeFoldersBit				= 6
};

/* Values of AccessMask */
enum {
	kSeeMask					= (1L << kSeeBit),
	kAddMask					= (1L << kAddBit),
	kDeleteMask					= (1L << kDeleteBit),
	kChangeMask					= (1L << kChangeBit),
	kRenameMask					= (1L << kRenameBit),
	kChangePrivsMask			= (1L << kChangePrivsBit),
	kSeeFoldersMask				= (1L << kSeeFoldersBit)
};

enum {
	kAllPrivs					= (kSeeMask + kAddMask + kDeleteMask + kChangeMask + kRenameMask + kChangePrivsMask + kSeeFoldersMask),
	kNoPrivs					= 0
};

/*

kSupportsDNodeNumberBit:
If this bit is set, a DNode can be referenced using DNodeNumbers. 
RecordLocationInfo can be specified using DNodeNumber and PathName component can be nil. 
If this bit is not set, a DNode can be referenced only by PathName to the DNode. In the 
later case DNodeNumber component inside record location info must be set to zero.

kSupportsRecordCreationIDBit:
If this bit is set, a record can be referenced by specifying CreationID 
in most catalog manager calls. If this bit is not set recordName and recordType are 
required in the recordID specification for all catalog manager calls.

kSupportsAttributeCreationIDBit:
If this bit is set, an attribute value can be obtained by specifying it's 
CreationID in Lookup call staring point and also can be used in operations 
like DeleteAttributeValue and ChangeAttributeValue an Attribute can be 
specified by AttributeType and CreationID.

*************************************************************************
Implicit assumption with creationID's and dNodeNumbers are, when supported
they are persistent and will preserved across boots and life of the system.
*************************************************************************

Following three bits are for determining the sort order in enumeration.
kSupportsMatchAllBit:
If this bit is set, enumeration of all the records is supported

kSupportsBeginsWithBit:
If this bit is set, enumeration of records matching prefix (e.g. Begin with abc)
is supported

kSupportsExactMatchBit:
If this bit is set, existence of a record matching exact matchNameString and recordType
is supported.

kSupportsEndsWithBit:
If this bit is set, enumeration of records matching suffix (e.g. end with abc)
is supported.

kSupportsContainsBit:
If this bit is set, enumeration of records containing a matchNameString (e.g. containing abc)
is supported


Implicit assumption in all these is, a record type can be specified either as one of the above or
a type list(more then one) to match exact type.
The Following four bits will indicate sort ordering in enumeration.

kSupportsOrderedEnumerationBit:
If this bit is set, Enumerated records or in some order possibly in name order.

kCanSupportNameOrderBit:
If this is set, catalog will support sortbyName option in Enumerate.

kCanSupportTypeOrderBit:
If this bit is set, catalog will support sortbyType option in enumearte.

kSupportSortBackwardsBit:
If this bit is set, catalog supports backward sorting.

kSupportIndexRatioBit:
If this bit is set, it indicates that enumeration will return approximate position
of a record (percentile) among all records.

kSupportsEnumerationContinueBit:
If this bit is set, catalog supports enumeration continue.

kSupportsLookupContinueBit:
If this bit is set, catalog supports lookup continue.

kSupportsEnumerateAttributeTypeContinueBit:
If this bit is set, catalog supports EnumerateAttributeType continue.

kSupportsEnumeratePseudonymContinueBit:
If this bit is set, catalog supports EnumeratePseudonym continue.

kSupportsAliasesBit:
If this bit is set, catalog supports create/delte/enumerate 
of Alias Records.

kSupportPseudonymBit: 
If this bit is set, catalog supports create/delte/enumerate of 
pseudonyms for a record.

kSupportsPartialPathNameBit:
If this bit is set, catalog nodes can be specified using DNodeNumber of a 
intermediate DNode and a partial name starting from that DNode to the intended 
DNode.

kSupportsAuthenticationBit:
If this bit is set, catalog supports authentication manager calls.

kSupportsProxiesBit:
If this bit is set, catalog supports proxy related calls in authentication manager. 

kSupportsFindRecordBit:
If this bit is set, catalog supports find record call.

Bits and corresponding masks are as defined below.
*/
enum {
	kSupportsDNodeNumberBit		= 0,
	kSupportsRecordCreationIDBit = 1,
	kSupportsAttributeCreationIDBit = 2,
	kSupportsMatchAllBit		= 3,
	kSupportsBeginsWithBit		= 4,
	kSupportsExactMatchBit		= 5,
	kSupportsEndsWithBit		= 6,
	kSupportsContainsBit		= 7,
	kSupportsOrderedEnumerationBit = 8,
	kCanSupportNameOrderBit		= 9,
	kCanSupportTypeOrderBit		= 10,
	kSupportSortBackwardsBit	= 11,
	kSupportIndexRatioBit		= 12,
	kSupportsEnumerationContinueBit = 13,
	kSupportsLookupContinueBit	= 14,
	kSupportsEnumerateAttributeTypeContinueBit = 15,
	kSupportsEnumeratePseudonymContinueBit = 16,
	kSupportsAliasesBit			= 17,
	kSupportsPseudonymsBit		= 18,
	kSupportsPartialPathNamesBit = 19,
	kSupportsAuthenticationBit	= 20,
	kSupportsProxiesBit			= 21,
	kSupportsFindRecordBit		= 22
};

/* values of DirGestalt */
enum {
	kSupportsDNodeNumberMask	= 1L << kSupportsDNodeNumberBit,
	kSupportsRecordCreationIDMask = 1L << kSupportsRecordCreationIDBit,
	kSupportsAttributeCreationIDMask = 1L << kSupportsAttributeCreationIDBit,
	kSupportsMatchAllMask		= 1L << kSupportsMatchAllBit,
	kSupportsBeginsWithMask		= 1L << kSupportsBeginsWithBit,
	kSupportsExactMatchMask		= 1L << kSupportsExactMatchBit,
	kSupportsEndsWithMask		= 1L << kSupportsEndsWithBit,
	kSupportsContainsMask		= 1L << kSupportsContainsBit,
	kSupportsOrderedEnumerationMask = 1L << kSupportsOrderedEnumerationBit,
	kCanSupportNameOrderMask	= 1L << kCanSupportNameOrderBit,
	kCanSupportTypeOrderMask	= 1L << kCanSupportTypeOrderBit,
	kSupportSortBackwardsMask	= 1L << kSupportSortBackwardsBit,
	kSupportIndexRatioMask		= 1L << kSupportIndexRatioBit,
	kSupportsEnumerationContinueMask = 1L << kSupportsEnumerationContinueBit,
	kSupportsLookupContinueMask	= 1L << kSupportsLookupContinueBit,
	kSupportsEnumerateAttributeTypeContinueMask = 1L << kSupportsEnumerateAttributeTypeContinueBit,
	kSupportsEnumeratePseudonymContinueMask = 1L << kSupportsEnumeratePseudonymContinueBit,
	kSupportsAliasesMask		= 1L << kSupportsAliasesBit,
	kSupportsPseudonymsMask		= 1L << kSupportsPseudonymsBit,
	kSupportsPartialPathNamesMask = 1L << kSupportsPartialPathNamesBit,
	kSupportsAuthenticationMask	= 1L << kSupportsAuthenticationBit,
	kSupportsProxiesMask		= 1L << kSupportsProxiesBit,
	kSupportsFindRecordMask		= 1L << kSupportsFindRecordBit
};

/* Values of AuthLocalIdentityOp */
enum {
	kAuthLockLocalIdentityOp	= 1,
	kAuthUnlockLocalIdentityOp	= 2,
	kAuthLocalIdentityNameChangeOp = 3
};

/* Values of AuthLocalIdentityLockAction */
enum {
	kAuthLockPending			= 1,
	kAuthLockWillBeDone			= 2
};

/* Values of AuthNotifications */
enum {
	kNotifyLockBit,
	kNotifyUnlockBit,
	kNotifyNameChangeBit
};

enum {
	kNotifyLockMask				= 1L << kNotifyLockBit,
	kNotifyUnlockMask			= 1L << kNotifyUnlockBit,
	kNotifyNameChangeMask		= 1L << kNotifyNameChangeBit
};

enum {
	kPersonalDirectoryFileCreator = 'kl03',
	kPersonalDirectoryFileType	= 'pabt',
	kBusinessCardFileType		= 'bust',
	kDirectoryFileType			= 'dirt',
	kDNodeFileType				= 'dnod',
	kDirsRootFileType			= 'drtt',
	kRecordFileType				= 'rcrd'
};

typedef unsigned short DirSortOption;

typedef unsigned short DirSortDirection;

typedef unsigned long AccessMask;

typedef unsigned long DirGestalt;

typedef unsigned long AuthLocalIdentityOp;

typedef unsigned long AuthLocalIdentityLockAction;

typedef unsigned long AuthNotifications;

struct DNodeID {
	DNodeNum						dNodeNumber;				/* dNodenumber  */
	long							reserved1;
	RStringPtr						name;
	long							reserved2;
};
typedef struct DNodeID DNodeID;

struct DirEnumSpec {
	DirEnumChoices					enumFlag;
	unsigned short					indexRatio;					/* Approx Record Position between 1 and 100 If supported, 0 If not supported */
	union {
		LocalRecordID					recordIdentifier;
		DNodeID							dNodeIdentifier;
	} u;
};

typedef struct DirEnumSpec DirEnumSpec;

struct DirMetaInfo {
	unsigned long					info[4];
};
typedef struct DirMetaInfo DirMetaInfo;

struct SLRV {
	ScriptCode						script;						/*   Script code in which entries are sorted */
	short							language;					/*   Language code in which entries are sorted */
	short							regionCode;					/*   Region code in which entries are sorted */
	short							version;					/*  version of oce sorting software */
};
typedef struct SLRV SLRV;

/* Catalog types and operations */
/* unique identifier for an identity */
typedef unsigned long AuthIdentity;

/* Umbrella LocalIdentity */
typedef AuthIdentity LocalIdentity;

/* A DES key is 8 bytes of data */
struct DESKey {
	unsigned long					a;
	unsigned long					b;
};
typedef struct DESKey DESKey;

typedef Byte RC4Key[kRC4KeySizeInBytes];

typedef unsigned long AuthKeyType;

/* key type followed by its data */
struct AuthKey {
	AuthKeyType						keyType;
	union {
		DESKey							des;
		RC4Key							rc4;
	} u;
};

typedef struct AuthKey AuthKey;

typedef AuthKey *AuthKeyPtr;

typedef union AuthParamBlock AuthParamBlock;

typedef AuthParamBlock *AuthParamBlockPtr;

typedef pascal void (*AuthIOCompletionProcPtr)(AuthParamBlockPtr paramBlock);

#if GENERATINGCFM
typedef UniversalProcPtr AuthIOCompletionUPP;
#else
typedef AuthIOCompletionProcPtr AuthIOCompletionUPP;
#endif

/*
This header is common to all the parameter blocks.  Clients should not directly
touch any of these fields except ioCompletion.  ioCompletion is the
completion routine pointer for async calls; it is ignored for sync calls.
ioResult is the result code from the call.
*/
#define AuthParamHeader 		\
	Ptr	qLink;						\
	long	reserved1;				\
	long	reserved2;				\
	AuthIOCompletionUPP	ioCompletion;	 \
	OSErr	ioResult;				\
	unsigned long	saveA5;			\
	short	reqCode;					\
	long	reserved[2];				\
	AddrBlock	serverHint;			\
	short	dsRefNum;				\
	unsigned long	callID;			\
	AuthIdentity	identity;			\
	long	gReserved1;				\
	long	gReserved2;				\
	long	gReserved3;				\
	long	clientData;
/*****************************************************************************


		Authentication Manager operations 

*****************************************************************************/
/*
kAuthResolveCreationID:
userRecord will contain the user information whose creationID has to be
returned. A client must make this call when he does not know the creaitionID.
The creationID must be set to nil before making the call. The server will attempt
to match the recordid's in the data base which match the user name and
type in the record.  Depending on number of matchings, following
results will be returned.
Exactly One Match : CreationID in RecordID and also in buffer (if buffer is given)
totalMatches = actualMatches = 1.
> 1 Match:
	Buffer is Large Enough:
	totalMatches = actualMatches
	Buffer will contain all the CIDs, kOCEAmbiguousMatches error.
> 1 Match:
	Buffer is not Large Enough:
	totalMatches > actualMatches
	Buffer will contain all the CIDs (equal to actualMatches), daMoreDataError error.
0 Matches:
 kOCENoSuchRecord error
*/
struct AuthResolveCreationIDPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						userRecord;					/*  --> OCE name(Record) of the user */
	unsigned long					bufferLength;				/*  --> Buffer Size to hold duplicate Info */
	Ptr								buffer;						/*  --> Buffer  to hold duplicate Info */
	unsigned long					totalMatches;				/* <--  Total Number of matching names found */
	unsigned long					actualMatches;				/* <--  Number of matches returned in the buffer */
};
typedef struct AuthResolveCreationIDPB AuthResolveCreationIDPB;

/*
kAuthBindSpecificIdentity:
userRecord will contain the user information whose identity has to be
verified. userKey will contain the userKey. An Identity is returned which
binds the key and the userRecord. The identity returned can be used in the 'identity'
field in the header portion (AuthParamHeader) for authenticating the Catalog and
Authentication manager calls.
*/
struct AuthBindSpecificIdentityPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthIdentity					userIdentity;				/* <--  binding identity */
	RecordIDPtr						userRecord;					/*  --> OCE name(Record) of the user */
	AuthKeyPtr						userKey;					/*  --> OCE Key for the user */
};
typedef struct AuthBindSpecificIdentityPB AuthBindSpecificIdentityPB;

/*
kAuthUnbindSpecificIdentity:
This call will unbind the userRecord and key which were bind earlier.
*/
struct AuthUnbindSpecificIdentityPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthIdentity					userIdentity;				/*  --> identity to be deleted */
};
typedef struct AuthUnbindSpecificIdentityPB AuthUnbindSpecificIdentityPB;

/*
kAuthGetSpecificIdentityInfo:
This call will return the userRecord for the given identity. Note: key is not
returned because this would compromise security.
*/
struct AuthGetSpecificIdentityInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthIdentity					userIdentity;				/*  --> identity of initiator */
	RecordIDPtr						userRecord;					/* <--  OCE name(Record) of the user */
};
typedef struct AuthGetSpecificIdentityInfoPB AuthGetSpecificIdentityInfoPB;

/*
kAuthAddKey:
userRecord will contain the user information whose identity has to be
created. userKey will point to the key to be created. password points to
an RString containing the password used to generate the key.
*/
struct AuthAddKeyPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						userRecord;					/*  --> OCE name(Record) of the user */
	AuthKeyPtr						userKey;					/* <--  OCE Key for the user */
	RStringPtr						password;					/*  --> Pointer to password string */
};
typedef struct AuthAddKeyPB AuthAddKeyPB;

/*
kAuthChangeKey:
userRecord will contain the user information whose identity has to be
created. userKey will point to the key to be created. password points to
an RString containing the password used to generate the key.
*/
struct AuthChangeKeyPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						userRecord;					/*  --> OCE name(Record) of the user */
	AuthKeyPtr						userKey;					/* <--  New OCE Key for the user */
	RStringPtr						password;					/*  -->Pointer to the new password string */
};
typedef struct AuthChangeKeyPB AuthChangeKeyPB;

/*
AuthDeleteKey:
userRecord will contain the user information whose Key has to be deleted.
*/
struct AuthDeleteKeyPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						userRecord;					/*  --> OCE name(Record) of the user */
};
typedef struct AuthDeleteKeyPB AuthDeleteKeyPB;

/* AuthPasswordToKey: Converts an RString into a key. */
struct AuthPasswordToKeyPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						userRecord;					/*  --> OCE name(Record) of the user */
	AuthKeyPtr						key;						/* <--  */
	RStringPtr						password;					/*  -->Pointer to the new password string */
};
typedef struct AuthPasswordToKeyPB AuthPasswordToKeyPB;

/*
kAuthGetCredentials:
userRecord will contain the user information whose identity has to be
kMailDeletedMask. keyType (e.g. asDESKey) will indicate what type of key has to
be deleted.
*/
struct AuthGetCredentialsPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthIdentity					userIdentity;				/*  --> identity of initiator */
	RecordIDPtr						recipient;					/*  --> OCE name of recipient */
	AuthKeyPtr						sessionKey;					/* <--  session key */
	UTCTime							expiry;						/* <--> desired/actual expiry */
	unsigned long					credentialsLength;			/* <--> max/actual credentials size */
	Ptr								credentials;				/* <--  buffer where credentials are returned */
};
typedef struct AuthGetCredentialsPB AuthGetCredentialsPB;

/*
AuthDecryptCredentialsPB:
Changes:
userKey is changed userIdentity.
userRecord is changed to initiatorRecord. User must supply buffer
to hold initiatorRecord.
agentList has changed to agent. There wil be no call back.
User must supply buffer to hold agent Record.
An additional boolean parameter 'hasAgent' is included.
Toolbox will set this if an 'Agent' record is found in the
credentials. If RecordIDPtr is 'nil', no agent record will
be copied. However user can examine 'hasAgent', If true user
can reissue this call with apprpriate buffer for getting a recordID.
agent has changed to intermediary.  User must supply buffer to hold 
intermediary Record.  The toolbox will set 'hasIntermediary' if an
'intermediary' record is found in the credentials. 
*/
struct AuthDecryptCredentialsPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthIdentity					userIdentity;				/*  --> user's Identity */
	RecordIDPtr						initiatorRecord;			/* <--  OCE name of the initiator */
	AuthKeyPtr						sessionKey;					/* <--  session key */
	UTCTime							expiry;						/* <--  credentials expiry time */
	unsigned long					credentialsLength;			/*  --> actual credentials size */
	Ptr								credentials;				/*  --> credentials to be decrypted */
	UTCTime							issueTime;					/* <--  credentials expiry time */
	Boolean							hasIntermediary;			/* <--  if true, An intermediary Record was found in credentials */
	Boolean							filler1;
	RecordIDPtr						intermediary;				/* <--  recordID of the intermediary */
};
typedef struct AuthDecryptCredentialsPB AuthDecryptCredentialsPB;

struct AuthMakeChallengePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthKeyPtr						key;						/*  --> UnEncrypted SessionKey */
	Ptr								challenge;					/* <--  Encrypted Challenge */
	unsigned long					challengeBufferLength;		/*  ->length of challenge buffer */
	unsigned long					challengeLength;			/*  <-length of Encrypted Challenge */
};
typedef struct AuthMakeChallengePB AuthMakeChallengePB;

struct AuthMakeReplyPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthKeyPtr						key;						/*  --> UnEncrypted SessionKey */
	Ptr								challenge;					/*  --> Encrypted Challenge */
	Ptr								reply;						/* <--  Encrypted Reply */
	unsigned long					replyBufferLength;			/*  -->length of challenge buffer */
	unsigned long					challengeLength;			/*  --> length of Encrypted Challenge */
	unsigned long					replyLength;				/* <--  length of Encrypted Reply */
};
typedef struct AuthMakeReplyPB AuthMakeReplyPB;

struct AuthVerifyReplyPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthKeyPtr						key;						/*  --> UnEncrypted SessionKey */
	Ptr								challenge;					/*  --> Encrypted Challenge */
	Ptr								reply;						/*  --> Encrypted Reply */
	unsigned long					challengeLength;			/*  --> length of Encrypted Challenge */
	unsigned long					replyLength;				/*  --> length of Encrypted Reply */
};
typedef struct AuthVerifyReplyPB AuthVerifyReplyPB;

/*
kAuthGetUTCTime:
RLI will contain a valid RLI for a cluster server.
UTC(GMT) time from one of the cluster server will be returned.
An 'offSet' from UTC(GMT) to Mac Local Time will also be returned.
If RLI is nil Map DA is used to determine UTC(GMT).
Mac Local Time = theUTCTime + theUTCOffset.
*/
struct AuthGetUTCTimePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	PackedRLIPtr					pRLI;						/*  --> packed RLI of the Node, whose server's UTC is requested */
	UTCTime							theUTCTime;					/* <--  current UTC(GMT) Time utc seconds since 1/1/1904 */
	UTCOffset						theUTCOffset;				/* <--  offset from UTC(GMT) seconds EAST of Greenwich */
};
typedef struct AuthGetUTCTimePB AuthGetUTCTimePB;

/*
kAuthMakeProxy:
A user represented bu the 'userIdentity' can make a proxy using this call.
'recipient' is the RecordID of the recipient whom user is requesting proxy.
'intermediary' is the RecordID of the intermediary holding proxy for the user.
'firstValid' is time at which proxy becomes valid.
'expiry' is the time at which proxy must expire.
'proxyLength' will have the length of the buffer pointed by 'proxy' as input.
When the call completes, it will hold the actual length of proxy. If the
call completes 'kOCEMoreData' error, client can reissue the call with the
buffer size as 'proxyLength' returned.
expiry is a suggestion, and may be adjusted to be earlier by the ADAP/OCE server.
The 'proxy' obtained like this might be used by the 'intermediary' to obtain credentials
for the server using TradeProxyForCredentials call.
authDataLength and authData are intended for possible future work, but are
ignored for now.
*/
struct AuthMakeProxyPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthIdentity					userIdentity;				/*  --> identity of principal */
	RecordIDPtr						recipient;					/*  --> OCE name of recipient */
	UTCTime							firstValid;					/*  --> time at which proxy becomes valid */
	UTCTime							expiry;						/*  --> time at which proxy expires */
	unsigned long					authDataLength;				/*  --> size of authorization data */
	Ptr								authData;					/*  --> pointer to authorization data */
	unsigned long					proxyLength;				/* <--> max/actual proxy size */
	Ptr								proxy;						/* <--> buffer where proxy is returned */
	RecordIDPtr						intermediary;				/*  --> RecordID of intermediary */
};
typedef struct AuthMakeProxyPB AuthMakeProxyPB;

/*
kAuthTradeProxyForCredentials:
Using this call, intermediary holding a 'proxy' for a recipient may obtain credentials
for that recipient. 'userIdentity' is the identity for the 'intermediary'.
'recipient' is the RecordID for whom credetials are requested.
'principal' is the RecordID of the user who created the proxy.
'proxyLength' is the length of data pointed by 'proxy.
If the call is succesfull, credentials will be returned in the
buffer pointed by 'credentials'. 'expiry' is the desired expiry time at input.
When call succeds this will have expiry time of credentials.
This is very similar to GetCredentials except that we (of course) need the proxy,
but we also need the name of the principal who created the proxy.
*/
struct AuthTradeProxyForCredentialsPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	AuthIdentity					userIdentity;				/*  --> identity of intermediary */
	RecordIDPtr						recipient;					/*  --> OCE name of recipient */
	AuthKeyPtr						sessionKey;					/* <--  session key */
	UTCTime							expiry;						/* <--> desired/actual expiry */
	unsigned long					credentialsLength;			/* <--> max/actual credentials size */
	Ptr								credentials;				/* <--> buffer where credentials are returned */
	unsigned long					proxyLength;				/*  --> actual proxy size */
	Ptr								proxy;						/*  --> buffer containing proxy */
	RecordIDPtr						principal;					/*  --> RecordID of principal */
};
typedef struct AuthTradeProxyForCredentialsPB AuthTradeProxyForCredentialsPB;

/* API for Local Identity Interface */
/*
AuthGetLocalIdentityPB:
A Collaborative application intended to work under the umbrella of LocalIdentity
for the OCE toolbox will have to make this call to obtain LocalIdentity.
If LocalIdentity has not been setup, then application will get
'kOCEOCESetupRequired.'. In this case application should put the dialog
recommended by the OCE Setup document and guide the user through OCE Setup.
If the OCESetup contains local identity, but user has not unlocked, it will get
kOCELocalAuthenticationFail. In this case application should use SDPPromptForLocalIdentity
to prompt user for the password.
If a backGround application or stand alone code requires LocalIdentity, if it gets the
OSErr from LocalIdentity and can not call SDPPromptForLocalIdentity, it should it self
register with the toolbox using kAuthAddToLocalIdentityQueue call. It will be notified
when a LocalIdentity gets created by a foreground application.
*/
struct AuthGetLocalIdentityPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	LocalIdentity					theLocalIdentity;			/* <--  LocalIdentity */
};
typedef struct AuthGetLocalIdentityPB AuthGetLocalIdentityPB;

/*
kAuthUnlockLocalIdentity:
The LocalIdentity can be created using this call.
The userName and password correspond to the LocalIdentity setup.
If the password matches, then collabIdentity will be returned.
Typically SDPPromptForLocalIdentity call will make this call.
All applications which are registered through kAuthAddToLocalIdentityQueue
will be notified.
*/
struct AuthUnlockLocalIdentityPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	LocalIdentity					theLocalIdentity;			/* <--  LocalIdentity */
	RStringPtr						userName;					/*  --> userName */
	RStringPtr						password;					/*  -->user password */
};
typedef struct AuthUnlockLocalIdentityPB AuthUnlockLocalIdentityPB;

/*
kAuthLockLocalIdentity:
With this call existing LocalIdentity can be locked. If the ASDeleteLocalIdetity
call fails with 'kOCEOperationDenied' error, name will contain the application which
denied the operation. This name will be supplied by the application
when it registered through kAuthAddToLocalIdentityQueue call
*/
struct AuthLockLocalIdentityPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	LocalIdentity					theLocalIdentity;			/*  --> LocalIdentity */
	StringPtr						name;						/* <--  name of the app which denied delete */
};
typedef struct AuthLockLocalIdentityPB AuthLockLocalIdentityPB;

typedef pascal Boolean (*NotificationProcPtr)(long clientData, AuthLocalIdentityOp callValue, AuthLocalIdentityLockAction actionValue, LocalIdentity identity);

#if GENERATINGCFM
typedef UniversalProcPtr NotificationUPP;
#else
typedef NotificationProcPtr NotificationUPP;
#endif

typedef NotificationUPP NotificationProc;

/*
kAuthAddToLocalIdentityQueue:
An application requiring notification of locking/unlocking of the
LocalIdentity can install itself using this call. The function provided
in 'notifyProc' will be called whenever the requested event happens.
When an AuthLockLocalIdentity call is made to the toolbox, the notificationProc
will be called with 'kAuthLockPending'. The application may refuse the lock by returning
a 'true' value. If all the registered entries return 'false' value, locking will be done
successfully. Otherwise 'kOCEOperationDenied' error is returned to the caller. The appName
(registered with the notificationProc) of the application which denied locking is also
returned to the caller making the AuthLockIdentity call.
*/
struct AuthAddToLocalIdentityQueuePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	NotificationUPP					notifyProc;					/*  --> notification procedure */
	AuthNotifications				notifyFlags;				/*  --> notifyFlags */
	StringPtr						appName;					/*  --> name of application to be returned in Delete/Stop */
};
typedef struct AuthAddToLocalIdentityQueuePB AuthAddToLocalIdentityQueuePB;

/*
kAuthRemoveFromLocalIdentityQueue:*/
struct AuthRemoveFromLocalIdentityQueuePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	NotificationUPP					notifyProc;					/*  --> notification procedure */
};
typedef struct AuthRemoveFromLocalIdentityQueuePB AuthRemoveFromLocalIdentityQueuePB;

/*
kAuthSetupLocalIdentity:
The LocalIdentity can be Setup using this call.
The userName and password correspond to the LocalIdentity setup.
If a LocalIdentity Setup already exists 'kOCELocalIdentitySetupExists' error
will be returned.
*/
struct AuthSetupLocalIdentityPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	long							aReserved;					/*  --  */
	RStringPtr						userName;					/*  --> userName */
	RStringPtr						password;					/*  -->user password */
};
typedef struct AuthSetupLocalIdentityPB AuthSetupLocalIdentityPB;

/*
kAuthChangeLocalIdentity:
An existing LocalIdentity  Setup can be changed using this call.
The userName and password correspond to the LocalIdentity setup.
If a LocalIdentity Setup does not exists 'kOCEOCESetupRequired' error
will be returned. The user can use  kAuthSetupLocalIdentity call to setit up.
If the 'password' does not correspond to the existing setup, 'kOCELocalAuthenticationFail'
OSErr will be returned. If successful, LocalID will have new name as 'userName' and
password as 'newPassword' and if any applications has installed into 
LocalIdentityQueue with kNotifyNameChangeMask set, it will be notified with 
kAuthLocalIdentityNameChangeOp action value. 

*/
struct AuthChangeLocalIdentityPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	long							aReserved;					/*  --  */
	RStringPtr						userName;					/*  --> userName */
	RStringPtr						password;					/*  --> current password */
	RStringPtr						newPassword;				/*  --> new password */
};
typedef struct AuthChangeLocalIdentityPB AuthChangeLocalIdentityPB;

/*
kAuthRemoveLocalIdentity:
An existing LocalIdentity  Setup can be removed using this call.
The userName and password correspond to the LocalIdentity setup.
If a LocalIdentity Setup does not exists 'kOCEOCESetupRequired' error
will be returned.
If the 'password' does not correspond to the existing setup, 'kOCELocalAuthenticationFail'
OSErr will be returned. If successful, LocalIdentity will be removed from the OCE Setup.
This is a very distructive operation, user must be warned enough before actually making
this call.
*/
struct AuthRemoveLocalIdentityPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	long							aReserved;					/*  --  */
	RStringPtr						userName;					/*  --> userName */
	RStringPtr						password;					/*  --> current password */
};
typedef struct AuthRemoveLocalIdentityPB AuthRemoveLocalIdentityPB;

/*
kOCESetupAddDirectoryInfo:
Using this call identity for a catalog can be setup under LocalIdentity umbrella.
ASCreateLocalIdentity should have been done succesfully before making this call.
directoryRecordCID -> is the record creationID obtained when DirAddOCEDirectory or
DirAddDSAMDirectory call was made.
rid-> is the recordID in which the identity for the catalog will be established.
password-> the password associated with the rid in the catalog world.
*/
struct OCESetupAddDirectoryInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	CreationID						directoryRecordCID;			/*  --> CreationID for the catalog */
	RecordIDPtr						recordID;					/*  --> recordID for the identity */
	RStringPtr						password;					/*  --> password in the catalog world */
};
typedef struct OCESetupAddDirectoryInfoPB OCESetupAddDirectoryInfoPB;

/*
kOCESetupChangeDirectoryInfo:
Using this call an existing identity for a catalog under LocalIdentity umbrella
can be changed.
ASCreateLocalIdentity should have been done succesfully before making this call.
directoryRecordCID -> is the record creationID obtained when DirAddOCEDirectory or
DirAddDSAMDirectory call was made.
rid-> is the recordID in which the identity for the catalog will be established.
password-> the password associated with the rid in the catalog world.
newPassword -> the new password for the catalog
*/
struct OCESetupChangeDirectoryInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	CreationID						directoryRecordCID;			/*  --> CreationID for the catalog */
	RecordIDPtr						recordID;					/*  --> recordID for the identity */
	RStringPtr						password;					/*  --> password in the catalog world */
	RStringPtr						newPassword;				/*  --> new password in the catalog */
};
typedef struct OCESetupChangeDirectoryInfoPB OCESetupChangeDirectoryInfoPB;

/*
kOCESetupRemoveDirectoryInfo:
Using this call an existing identity for a catalog under LocalIdentity umbrella
can be changed.
ASCreateLocalIdentity should have been done succesfully before making this call.
directoryRecordCID -> is the record creationID obtained when DirAddOCEDirectory or
*/
struct OCESetupRemoveDirectoryInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	CreationID						directoryRecordCID;			/*  --> CreationID for the catalog */
};
typedef struct OCESetupRemoveDirectoryInfoPB OCESetupRemoveDirectoryInfoPB;

/*
kOCESetupGetDirectoryInfo:
Using this call info on an existing identity for a particular catalog under LocalIdentity umbrella
can be obtained.
For the specified catalog 'directoryName' and 'discriminator', rid and nativeName will
returned. Caller must provide appropriate buffer to get back rid and nativeName.
'password' will be returned  for  non-ADAP Catalogs.
*/
struct OCESetupGetDirectoryInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	AuthIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	DirectoryNamePtr				directoryName;				/*  --> catalog name */
	DirDiscriminator				discriminator;				/*  --> discriminator for the catalog */
	RecordIDPtr						recordID;					/* <--  rid for the catalog identity */
	RStringPtr						nativeName;					/* <--  user name in the catalog world */
	RStringPtr						password;					/* <--  password in the catalog world */
};
typedef struct OCESetupGetDirectoryInfoPB OCESetupGetDirectoryInfoPB;

/*****************************************************************************


 		Catalog Manager operations


*****************************************************************************/
typedef union DirParamBlock DirParamBlock;

typedef DirParamBlock *DirParamBlockPtr;

typedef pascal void (*DirIOCompletionProcPtr)(DirParamBlockPtr paramBlock);

#if GENERATINGCFM
typedef UniversalProcPtr DirIOCompletionUPP;
#else
typedef DirIOCompletionProcPtr DirIOCompletionUPP;
#endif

#define DirParamHeader 			\
	Ptr	qLink;						\
	long	reserved1;				\
	long	reserved2;				\
	DirIOCompletionUPP	ioCompletion;	 \
	OSErr	ioResult;				\
	unsigned long	saveA5;			\
	short	reqCode;					\
	long	reserved[2];				\
	AddrBlock	serverHint;			\
	short	dsRefNum;				\
	unsigned long	callID;			\
	AuthIdentity	identity;			\
	long	gReserved1;				\
	long	gReserved2;				\
	long	gReserved3;				\
	long	clientData;
/* AddRecord */
struct DirAddRecordPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> CreationID returned here */
	Boolean							allowDuplicate;				/*  --> */
	Boolean							filler1;
};
typedef struct DirAddRecordPB DirAddRecordPB;

/* DeleteRecord */
struct DirDeleteRecordPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> */
};
typedef struct DirDeleteRecordPB DirDeleteRecordPB;

/* aRecord must contain valid PackedRLI and a CreationID. */
/**********************************************************************************/
/*
DirEnumerate:
This call can be used to enumerate both DNodes and records under a specified
DNode. A DNode is specified by the PackedRLIPtr 'aRLI'.

startingPoint indicates where to start the enumeration.  Initially,
it should be set to a value of nil.  After some records are enumerated,
the client can issue the call again with the same aRLI and recordName and
typeList. The last received DirEnumSpec in the startingPoint field.  The server
will continue the enumeration from that record on. if user wants to get back the
value specified in the startingRecord also, the Boolean 'includeStartingPoint'
must be set to 'true'. If this is set to 'false', records specified after the
startingPoint record will be returned.

sortBy indicates to the server to return the records that match in name-first
or type-first order.  sortDirection indicates to the server to search in forward
or backward sort order for RecordIDs Specified.

RecordIDS and Enumeration Criteria:

PackedRLIPtr parameter 'aRLI' will be accepted for DNode
specification.

One RStringPtr 'nameMatchString' is provided. User is allowed to
specify a wild card in the name. WildCard specification is specified in 
matchNameHow parameter and possible values are defined in DirMatchWith Enum.

'typeCount' parameter indicate how many types are in the 'typeList'.

'typeList' parmeter is a pointer to an RString array of size 'typeCount'.

If 'typeCount' is exactly equal to one, a wild card can be specified
for the entity type; otherwise types have to be completely specified.
WildCard specification is specified in  matchNameHow parameter
 and possible values are defined in DirMatchWith Enum.


A nil value for 'startingPoint' is allowed when sortDirection specified
is 'kSortBackwards'. This was not allowed previously.

'enumFlags' parameter is a bit field. The following bits can be set:
	kEnumDistinguishedNameMask to get back records in the cluster data base.
	kEnumAliasMask to get back record aliases
	kEnumPseudonymMask to get back record pseudonyms
	kEnumDNodeMask to get back any children dNodes for the DNode specified in the
	'aRLI' parameter.
	kEnumForeignDNodeMask to get back any children dNodes which have ForeignDnodes in the
	dNode specified in the 'aRLI' parameter.

	kEnumAll is combination of all five values and can be used to enumerate
	everything under a specified DNode.



The results returned for each element will consist of a DirEnumSpec.
The DirEnumSpec contains 'enumFlag' which indicates the type of entity and a
union which will have either DNodeID or LocalRecordID depending on the value of 'enumFlag'.
The 'enumFlag'  will indicate whether the returned element is a
record(kEnumDistinguishedNameMask bit) or a alias(kEnumAliasMask bit) or a
Pseudonym(kEnumPseudonymMask) or a child DNode(kEnumDNodeMask bit).  If the 'enumFlag' value
is kEnumDnodeMask, it indicates the value returned in the union is a DNodeID (i.e. 'dNodeNumber'
is the 'dNodeNumber' of the child dnode(if the catalog supports dNodeNumbers, otherwise
this will be set to zero). The name will be the child dnode name. For other values of the
'enumFlag', the value in the union will be LocalRecordID. In addition to kEnumDnodeMask it is
possible that kEnumForeignDNodeMask is also set. This is an advisory bit and application must make
it's own decision before displaying these records. If catalog supports kSupportIndexRatioMask, it
may also return the relative position of the record (percentile of total records) in the 
indexRatio field in EnumSpec.


responseSLRV will contain the script, language, region and version of the oce sorting software.
The results will be collected in the 'getBuffer' supplied by the user.
If buffer can not hold all the data returned 'kOCEMoreData' error will be returned.

If user receives 'noErr' or 'kOCEMoreData', buffer will contain valid results. A user
can extract the results in the 'getBuffer' by making DirEnumerateParse' call.
*/
struct DirEnumerateGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	PackedRLIPtr					aRLI;						/*  --> an RLI specifying the cluster to be enumerated */
	DirEnumSpec						*startingPoint;				/*  --> */
	DirSortOption					sortBy;						/*  --> */
	DirSortDirection				sortDirection;				/*  --> */
	long							dReserved;					/*  --  */
	RStringPtr						nameMatchString;			/*  --> name from which enumeration should start */
	RStringPtr						*typesList;					/*  --> list of entity types to be enumerated */
	unsigned long					typeCount;					/*  --> number of types in the list */
	DirEnumChoices					enumFlags;					/*  --> indicates what to enumerate */
	Boolean							includeStartingPoint;		/*  --> if true return the record specified in starting point */
	Byte							padByte;
	DirMatchWith					matchNameHow;				/*  --> Matching Criteria for nameMatchString */
	DirMatchWith					matchTypeHow;				/*  --> Matching Criteria for typeList */
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
	SLRV							responseSLRV;				/*  <--  response SLRV */
};
typedef struct DirEnumerateGetPB DirEnumerateGetPB;

/* The EnumerateRecords call-back function is defined as follows: */
typedef pascal Boolean (*ForEachDirEnumSpecProcPtr)(long clientData, const DirEnumSpec *enumSpec);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachDirEnumSpecUPP;
#else
typedef ForEachDirEnumSpecProcPtr ForEachDirEnumSpecUPP;
#endif

typedef ForEachDirEnumSpecUPP ForEachDirEnumSpec;

/*
EnumerateParse:
After an EnumerateGet call has completed, call EnumerateParse
to parse through the buffer that was filled in EnumerateGet.

'eachEnumSpec' will be called each time to return to the client a
DirEnumSpec that matches the pattern for enumeration. 'enumFlag' indicates the type
of information returned in the DirEnumSpec
The clientData parameter that you pass in the parameter block will be passed
to 'forEachEnumDSSpecFunc'.  You are free to put anything in clientData - it is intended
to allow you some way to match the call-back to the original call (for
example, you make more then one aysynchronous EnumerateGet calls and you want to
associate returned results in some way).

The client should return FALSE from 'eachEnumSpec' to continue
processing of the EnumerateParse request.  Returning TRUE will
terminate the EnumerateParse request.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the EnumerateParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of EnumerateParse:
if EnumerateParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
*/
struct DirEnumerateParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	PackedRLIPtr					aRLI;						/*  --> an RLI specifying the cluster to be enumerated */
	long							bReserved;					/*  --  */
	long							cReserved;					/*  --  */
	ForEachDirEnumSpec				eachEnumSpec;				/*  --> */
	long							eReserved;					/*  --  */
	long							fReserved;					/*  --  */
	long							gReserved;					/*  --  */
	long							hReserved;					/*  --  */
	long							iReserved;					/*  --  */
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
	short							l1Reserved;					/*  -- */
	short							l2Reserved;					/*  --  */
	short							l3Reserved;					/*  -- */
	short							l4Reserved;					/*  --  */
};
typedef struct DirEnumerateParsePB DirEnumerateParsePB;

/*
 * FindRecordGet operates similarly to DirEnumerate except it returns a list
 * of records instead of records local to a cluster.
*/
struct DirFindRecordGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						startingPoint;
	long							reservedA[2];
	RStringPtr						nameMatchString;
	RStringPtr						*typesList;
	unsigned long					typeCount;
	long							reservedB;
	short							reservedC;
	DirMatchWith					matchNameHow;
	DirMatchWith					matchTypeHow;
	Ptr								getBuffer;
	unsigned long					getBufferSize;
	DirectoryNamePtr				directoryName;
	DirDiscriminator				discriminator;
};
typedef struct DirFindRecordGetPB DirFindRecordGetPB;

/* The FindRecordParse call-back function is defined as follows: */
typedef pascal Boolean (*ForEachRecordProcPtr)(long clientData, const DirEnumSpec *enumSpec, PackedRLIPtr pRLI);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachRecordUPP;
#else
typedef ForEachRecordProcPtr ForEachRecordUPP;
#endif

typedef ForEachRecordUPP ForEachRecord;

/*
 * This PB same as DirFindRecordGet except it includes the callback function
*/
struct DirFindRecordParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						startingPoint;
	long							reservedA[2];
	RStringPtr						nameMatchString;
	RStringPtr						*typesList;
	unsigned long					typeCount;
	long							reservedB;
	short							reservedC;
	DirMatchWith					matchNameHow;
	DirMatchWith					matchTypeHow;
	Ptr								getBuffer;
	unsigned long					getBufferSize;
	DirectoryNamePtr				directoryName;
	DirDiscriminator				discriminator;
	ForEachRecord					forEachRecordFunc;
};
typedef struct DirFindRecordParsePB DirFindRecordParsePB;

/*
LookupGet:

aRecordList is an array of pointers to RecordIDs, each of which must
contain valid PackedRLI and a CreationID.  recordIDCount is
the size of this array.

attrTypeList is an array of pointers to AttributeTypes.  attrTypeCount is
the size of this array.

staringRecordIndex is the record from which to continue the lookup.
If you want to start from first record in the list, this must be 1 (not zero).
This value must always be <= recordIDCount.

startingAttributeIndex is the AttributeType from which we want to continue the lookup.
If you want to start from first attribute in the list, this must be 1 (not zero).
This value must always be <= attrTypeCount.

startingAttribute is the value of the attribute value from which we want to
continue lookup. In case of catalogs supporting creationIDs, startingAttribute
may contain only a CID. Other catalogs may require the entire value.
If a non-null cid is given and if an attribute value with that cid is not found, this
call will terminate with kOCENoSuchAttribute error. A client should not make a LookupParse call
after getting this error.

'includeStartingPoint' boolean can be set to 'true' to receive the value specified in the
startingPoint in the results returned. If this is set to 'false', the value
specified in the startingAttribute will not be returned.

When LookupGet call fails with kOCEMoreData, the client will be able to find out where the call ended
with a subsequent LookupParse call. When the LookupParse call completes with kOCEMoreData,
lastRecordIndex, lastAttributeIndex and lastValueCID will point to the corresponding
recordID, attributeType and the CreationID of the last value returned successfully. These parameters
are exactly the same ones for the startingRecordIndex, startingAttributeIndex, and startingAttrValueCID
so they can be used in a subsequent LookupGet call to continue the lookup.

In an extreme case, It is possible that we had an attribute value that is too large to fit
in the client's buffer. In such cases, if it was the only thing that we tried to fit
into the buffer, the client will not able to proceed further because he will not know the
attributeCID of the attribute to continue with.  Also he does not know how big a buffer
would be needed for the next call to get this 'mondo' attribute value successfully.

to support this, LookupParse call will do the following:

If LookupGet has failed with kOCEMoreData error, LookupParse will check to make sure that
ForEachAttributeValueFunc has been called at least once. If so, the client has the option
to continue from that attribute CreationID (for PAB/ADAP) in the next LookupGet call.
However, if it was not even called once, then the attribute value may be too big to fit in the
user's buffer. In this case, lastAttrValueCID (lastAttribute) and attrSize are returned in the
parse buffer and the call will fail with kOCEMoreAttrValue. However, it is possible that
ForEachAttributeValue was not called because the user does not have read access to some of
the attributeTypes in the list, and the buffer was full before even reading the creationID of
any of the attribute values.  A kOCEMoreData error is returned.

The Toolbox will check for duplicate RecordIDs in the aRecordList. If found, it will return
'daDuplicateRecordIDErr'.

The Toolbox will check for duplicate AttributeTypes in the attrTypeList. If found it will
return 'daDuplicateAttrTypeErr'.
*/
struct DirLookupGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						*aRecordList;				/*  --> an array of RecordID pointers */
	AttributeTypePtr				*attrTypeList;				/*  --> an array of attribute types */
	long							cReserved;					/*  --  */
	long							dReserved;					/*  --  */
	long							eReserved;					/*  --  */
	long							fReserved;					/*  --  */
	unsigned long					recordIDCount;				/*  --> */
	unsigned long					attrTypeCount;				/*  --> */
	Boolean							includeStartingPoint;		/*  --> if true return the value specified by the starting indices */
	Byte							padByte;
	short							i1Reserved;					/*  --  */
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
	unsigned long					startingRecordIndex;		/*  --> start from this record */
	unsigned long					startingAttrTypeIndex;		/*  --> start from this attribute type */
	Attribute						startingAttribute;			/*  --> start from this attribute value */
	long							pReserved;					/*  --  */
};
typedef struct DirLookupGetPB DirLookupGetPB;

/* The Lookup call-back functions are defined as follows: */
typedef pascal Boolean (*ForEachLookupRecordIDProcPtr)(long clientData, const RecordID *recordID);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachLookupRecordIDUPP;
#else
typedef ForEachLookupRecordIDProcPtr ForEachLookupRecordIDUPP;
#endif

typedef ForEachLookupRecordIDUPP ForEachLookupRecordID;

typedef pascal Boolean (*ForEachAttrTypeLookupProcPtr)(long clientData, const AttributeType *attrType, AccessMask myAttrAccMask);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachAttrTypeLookupUPP;
#else
typedef ForEachAttrTypeLookupProcPtr ForEachAttrTypeLookupUPP;
#endif

typedef ForEachAttrTypeLookupUPP ForEachAttrTypeLookup;

typedef pascal Boolean (*ForEachAttrValueProcPtr)(long clientData, const Attribute *attribute);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachAttrValueUPP;
#else
typedef ForEachAttrValueProcPtr ForEachAttrValueUPP;
#endif

typedef ForEachAttrValueUPP ForEachAttrValue;

/*
LookupParse:

After a LookupGet call has completed, call LookupParse
to parse through the buffer that was filled in LookupGet.  The
toolbox will parse through the buffer and call the appropriate call-back routines
for each item in the getBuffer.

'eachRecordID' will be called each time to return to the client one of the
RecordIDs from aRecordList.  The clientData parameter that you
pass in the parameter block will be passed to eachRecordID.
You are free to put anything in clientData - it is intended to allow
you some way to match the call-back to the original call (in case, for
example, you make simultaneous asynchronous LookupGet calls).  If you don't
want to get a call-back for each RecordID (for example, if you're looking up
attributes for only one RecordID), pass nil for eachRecordID.

After forEachLocalRecordIDFunc is called, eachAttrType may be called to pass an
attribute type (one from attrTypeList) that exists in the record specified
in the last eachRecordID call.  If you don't want to get a call-back for
each AttributeType (for example, if you're looking up only one attribute type,
or you prefer to read the type from the Attribute struct during the eachAttrValue
call-back routine), pass nil for eachAttrType. However access controls may
prohibit you from reading some attribute types; in that case eachAttrValue
may not be called even though the value exists. Hence the client should
supply this call-back function to see the access controls for each attribute type.

This will be followed by one or more calls to eachAttrValue, to pass the
type, tag, and attribute value.  NOTE THIS CHANGE:  you are no longer expected to
pass a pointer to a buffer in which to put the value.  Now you get a pointer to
the value, and you can process it within the call-back routine.
After one or more values are returned, eachAttrType may be called again to pass
another attribute type that exists in the last-specified RecordID.

The client should return FALSE from eachRecordID, eachAttrType, and
eachAttrValue to continue processing of the LookupParse request.  Returning TRUE
from any call-back will terminate the LookupParse request.

If LookupGet has failed with kOCEMoreData error, LookupParse will check to make sure that
ForEachAttributeValueFunc has been called at least once. If so, the client has the option
to continue from that attribute CreationID (for PAB/ADAP) in the next LookupGet call.
However, if it was not even called once, then the attribute value may be too big to fit in the
user's buffer. In this case, lastAttrValueCID (lastAttribute) and attrSize are returned in the
parse buffer and the call will fail with kOCEMoreAttrValue. However, it is possible that
ForEachAttributeValue was not called because the user does not have read access to some of
the attributeTypes in the list, and the buffer was full before even reading the creationID of
any of the attribute values.  A kOCEMoreData error is returned.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the LookupParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of LookupParse:
if LookupParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
*/
struct DirLookupParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						*aRecordList;				/*  --> must be same from the corresponding Get call */
	AttributeTypePtr				*attrTypeList;				/*  --> must be same from the corresponding Get call */
	long							cReserved;					/*  --  */
	ForEachLookupRecordID			eachRecordID;				/*  --> */
	ForEachAttrTypeLookup			eachAttrType;				/*  --> */
	ForEachAttrValue				eachAttrValue;				/*  --> */
	unsigned long					recordIDCount;				/*  --> must be same from the corresponding Get call */
	unsigned long					attrTypeCount;				/*  --> must be same from the corresponding Get call */
	long							iReserved;					/*  --  */
	Ptr								getBuffer;					/*  --> must be same from the corresponding Get call*/
	unsigned long					getBufferSize;				/*  --> must be same from the corresponding Get call*/
	unsigned long					lastRecordIndex;			/* <--  last RecordID processed when parse completed */
	unsigned long					lastAttributeIndex;			/* <--  last Attribute Type processed when parse completed */
	Attribute						lastAttribute;				/* <--  last attribute value (with this CreationID) processed when parse completed */
	unsigned long					attrSize;					/* <--  length of the attribute we did not return */
};
typedef struct DirLookupParsePB DirLookupParsePB;

/* AddAttributeValue */
struct DirAddAttributeValuePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> */
	AttributePtr					attr;						/*  --> AttributeCreationID returned here */
};
typedef struct DirAddAttributeValuePB DirAddAttributeValuePB;

/*
aRecord must contain valid PackedRLI and a CreationID.

Instead of passing type, length, and value in three separate
fields, we take a pointer to an Attribute structure that contains
all three, and has room for the AttributeCreationNumber.
The AttributeCreationID will be returned in the attr itself.

The AttributeTag tells the catalog service that the attribute is an RString,
binary, or a RecordID.
*/
/*
DeleteAttributeType:
This call is provided so that an existing AttributeType can be deleted.
If any attribute values exist for this type, they will all be deleted
(if the user has access rights to delete the values) and then the attribute type
will be deleted. Otherwise dsAccessDenied error will be returned.
*/
struct DirDeleteAttributeTypePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> */
	AttributeTypePtr				attrType;					/*  --> */
};
typedef struct DirDeleteAttributeTypePB DirDeleteAttributeTypePB;

/*
	DeleteAttributeValue
*/
struct DirDeleteAttributeValuePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  -> */
	AttributePtr					attr;						/*  -> */
};
typedef struct DirDeleteAttributeValuePB DirDeleteAttributeValuePB;

/*
	ChangeAttributeValue:
	currentAttr ==> the attribute to be changed. For ADAS and PAB CreationID is
	                sufficient
	newAttr     ==> new value for the attribute. For ADAS and PAB 
					CreationID field will be set when
	                the call succeesfully completes
	
	aRecord     ==> must contain valid PackedRecordLocationInfo and a CreationID.


	
*/
struct DirChangeAttributeValuePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  -> */
	AttributePtr					currentAttr;				/*  -> */
	AttributePtr					newAttr;					/*  -> */
};
typedef struct DirChangeAttributeValuePB DirChangeAttributeValuePB;

/* VerifyAttributeValue */
struct DirVerifyAttributeValuePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> */
	AttributePtr					attr;						/*  --> */
};
typedef struct DirVerifyAttributeValuePB DirVerifyAttributeValuePB;

/*
aRecord must contain valid PackedRLI and a CreationID.

The attribute type and value are passed in the attribute structure.  If the
attribute CreationID is non-zero, the server will verify that an attribute with
the specified value and creation number exists in aRecord.  If the attribute
CreationID is zero, the server will verify the attribute by type and value
alone, and return the attribute CreationID in the Attribute struct if the
attribute exists.
*/
/*
EnumerateAttributeTypesGet:
The following two calls can be used to enumerate the attribute types present in
a specified RecordID.  The first, EnumerateAttributeTypesGet, processes the request
and reads the response into getBuffer, as much as will fit.  A kOCEMoreData error will
be returned if the buffer was not large enough.  After this call completes, the
client can call EnumerateAttributeTypesParse (see below).

The user will able to continue from a startingPoint by setting a startingAttrType.
Typically, this should be the last value returned in EnumerateAttributeTypesParse call
when 'kOCEMoreData' is returned.

If 'includeStartingPoint' is true when a 'startingAttrType' is specified, the starting value
will be included in the results, if it exists. If this is set to false, this value will not
be included. AttributeTypes following this type will be returned.
*/
struct DirEnumerateAttributeTypesGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> */
	AttributeTypePtr				startingAttrType;			/*  --> starting point */
	long							cReserved;					/*  --  */
	long							dReserved;					/*  --  */
	long							eReserved;					/*  --  */
	long							fReserved;					/*  --  */
	long							gReserved;					/*  --  */
	long							hReserved;					/*  --  */
	Boolean							includeStartingPoint;		/*  --> if true return the attrType specified by starting point */
	Byte							padByte;
	short							i1Reserved;					/*  --  */
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
};
typedef struct DirEnumerateAttributeTypesGetPB DirEnumerateAttributeTypesGetPB;

/* The call-back function is defined as follows: */
typedef pascal Boolean (*ForEachAttrTypeProcPtr)(long clientData, const AttributeType *attrType);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachAttrTypeUPP;
#else
typedef ForEachAttrTypeProcPtr ForEachAttrTypeUPP;
#endif

typedef ForEachAttrTypeUPP ForEachAttrType;

/*
EnumerateAttributeTypesParse:
After an EnumerateAttributeTypesGet call has completed, call EnumerateAttributeTypesParse
to parse through the buffer that was filled in EnumerateAttributeTypesGet.  The
toolbox will parse through the buffer and call the call-back routine for
each attribute type in the getBuffer.

The client should return false from eachAttrType to continue
processing of the EnumerateAttributeTypesParse request.  Returning true will
terminate the EnumerateAttributeTypesParse request.  The clientData parameter that
you pass in the parameter block will be passed to eachAttrType.
You are free to put anything in clientData - it is intended to allow
you some way to match the call-back to the original call (in case, for
example, you make simultaneous asynchronous calls).

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the EnumerateAttributeTypesParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of EnumerateAttributeTypesParse.
If EnumerateAttributeTypesParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
*/
struct DirEnumerateAttributeTypesParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> Same as DirEnumerateAttributeTypesGetPB */
	long							bReserved;					/*  --  */
	long							cReserved;					/*  --  */
	long							dReserved;					/*  --  */
	ForEachAttrType					eachAttrType;				/*  --> */
	long							fReserved;					/*  --  */
	long							gReserved;					/*  --  */
	long							hReserved;					/*  --  */
	long							iReserved;					/*  --  */
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
};
typedef struct DirEnumerateAttributeTypesParsePB DirEnumerateAttributeTypesParsePB;

/*
DirAbort:
With this call a user will able to abort an outstanding catalog service call.
A user must pass a pointer to the parameter block for the outstanding call.
In the current version of the product, the toolbox will process this call
for NetSearchADAPDirectoriesGet or FindADAPDirectoryByNetSearch calls and if possible
it will abort. For other calls for ADAP and PAB this will return 'daAbortFailErr'.
For CSAM catalogs, this call will be passed to the corresponding CSAM driver.
The CSAM driver may process this call or may return 'daAbortFailErr'. This call can
be called only in synchronous mode. Since the abort call makes references to fields in
the pb associated with the original call, this pb must not be disposed or or altered if
the original call completes before the abort call has completed.
*/
struct DirAbortPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	DirParamBlock					*pb;						/*  --> pb for the call which must be aborted */
};
typedef struct DirAbortPB DirAbortPB;

/*
AddPseudonym:
An alternate name and type can be added to a given record. If allowDuplicate
is set the name and type will be added even if the same name and type already
exists.
*/
struct DirAddPseudonymPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> RecordID to which pseudonym is to be added */
	RStringPtr						pseudonymName;				/*  --> new name to be added as pseudonym */
	RStringPtr						pseudonymType;				/*  --> new name to be added as pseudonym */
	Boolean							allowDuplicate;				/*  --> */
	Boolean							filler1;
};
typedef struct DirAddPseudonymPB DirAddPseudonymPB;

/*
DeletePseudonym:
An alternate name and type for a given record can be deleted.
*/
struct DirDeletePseudonymPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> RecordID to which pseudonym to be added */
	RStringPtr						pseudonymName;				/*  --> pseudonymName to be deleted */
	RStringPtr						pseudonymType;				/*  --> pseudonymType to be deleted */
};
typedef struct DirDeletePseudonymPB DirDeletePseudonymPB;

/*
	AddAlias:
	This call can be used to create an alias  record. The alias
	can be created either in the same or different cluster. ADAS will not support
	this call for this release. A new catalog capability flag 'kSupportsAlias' will indicate
	if the catalog supports this call. PAB's will support this call. For the PAB implementation,
	this call will create a record with the name and type specified an aRecord.
	This call works exactly like AddRecord.
	If 'allowDuplicate' is false and another record with same name and type already exists
	'daNoDupAllowed' error will be returned.
*/
struct DirAddAliasPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  -> */
	Boolean							allowDuplicate;				/*  -> */
	Boolean							filler1;
};
typedef struct DirAddAliasPB DirAddAliasPB;

/*
DirFindValue:
This call can be used to find the occurrence of a value. The value
to be matched is passed in the buffer 'matchingData' field. The current
ADAP/PAB implementation will match a maximum of 32 bytes of data.
For attribute values in the PAB/ADAP implementation, only the first 32 bytes will
be used for comparing the occurrence of data. Search can be restricted to
a particular record and/or attribute type by specifying 'aRecord' or 'aType'.
After finding one occurrence, 'startingRecord' and 'startingAttribute'
can be specified to find the next occurrence of the same value.
'sortDirection' can be specified with starting values to search forward or backward.
When a matching value is found, the 'recordFound' indicates the reccordID in which the
data occurrence was found, 'attributeFound' indicates the attribute with in which the
matching data was found. ADAP/PAB implementation returns only the type and creationID of
attributes. Catalogs which don't support creationIDs may return the
complete value; hence this call may need a buffer to hold the data. For ADAP/PAB implementations
the user has to make a DirLookup call to get the actual data. 'recordFound' and
'attributeFound' can be used to initialize 'startingRecord' and 'startingAttribute' to
find the next occurrence of the value.
*/
struct DirFindValuePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	PackedRLIPtr					aRLI;						/*  --> an RLI specifying the cluster to be enumerated */
	LocalRecordIDPtr				aRecord;					/*  --> if not nil, look only in this record */
	AttributeTypePtr				attrType;					/*  --> if not nil, look only in this attribute type */
	LocalRecordIDPtr				startingRecord;				/*  --> record in which to start searching */
	AttributePtr					startingAttribute;			/*  --> attribute in which to start searching */
	LocalRecordIDPtr				recordFound;				/* <--  record in which data was found */
	Attribute						attributeFound;				/* <--  attribute in which data was found */
	unsigned long					matchSize;					/*  --> length of matching bytes */
	Ptr								matchingData;				/*  --> data bytes to be matched in search */
	DirSortDirection				sortDirection;				/*  --> sort direction (forwards or backwards) */
};
typedef struct DirFindValuePB DirFindValuePB;

/*
EnumeratePseudonymGet:
This call can be used to enumerate the existing pseudonyms for
a given record specified in 'aRecord'. A starting point can be specified
by 'startingName' and 'startingType'. If the 'includeStartingPoint' boolean
is true and a starting point is specified, the name specified by startingName
and startingType also is returned in the results, if it exists. If this is set to false,
the pseudonym in startingName and Type is not included.
Pseudonyms returned in the 'getBuffer' can be extracted by making an
EnumeratePseudonymParse call. The results will consist of a RecordID with the
name and type of the pseudonym. If the buffer could not hold all the results, then
'kOCEMoreData' error will be returned. The user will be able to continue the call by
using the last result returned as starting point for the next call.
*/
struct DirEnumeratePseudonymGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> */
	RStringPtr						startingName;				/*  --> */
	RStringPtr						startingType;				/*  --> */
	long							dReserved;					/*  --  */
	long							eReserved;					/*  --  */
	long							fReserved;					/*  --  */
	long							gReserved;					/*  --  */
	long							hReserved;					/*  --  */
	Boolean							includeStartingPoint;		/*  --> if true return the Pseudonym specified by starting point will be included */
	Byte							padByte;
	short							i1Reserved;					/*  --  */
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
};
typedef struct DirEnumeratePseudonymGetPB DirEnumeratePseudonymGetPB;

/* The call-back function is defined as follows: */
typedef pascal Boolean (*ForEachRecordIDProcPtr)(long clientData, const RecordID *recordID);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachRecordIDUPP;
#else
typedef ForEachRecordIDProcPtr ForEachRecordIDUPP;
#endif

typedef ForEachRecordIDUPP ForEachRecordID;

/*
EnumeratePseudonymParse:
The pseudonyms returned in the 'getBuffer' from the EnumeratePseudonymGet call
can be extracted by using the EnumeratePseudonymParse call. 'eachRecordID'
will be called for each pseudonym.

Returning true from any call-back will terminate the EnumeratePseudonymParse call.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the EnumeratePseudonymParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of EnumeratePseudonymParse:
if EnumeratePseudonymParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
*/
struct DirEnumeratePseudonymParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> same as DirEnumerateAliasesGetPB */
	long							bReserved;					/*  --  */
	long							cReserved;					/*  --  */
	ForEachRecordID					eachRecordID;				/*  --> */
	long							eReserved;					/*  --  */
	long							fReserved;					/*  --  */
	long							gReserved;					/*  --  */
	long							hReserved;					/*  --  */
	long							iReserved;					/*  --  */
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
};
typedef struct DirEnumeratePseudonymParsePB DirEnumeratePseudonymParsePB;

/* GetNameAndType */
struct DirGetNameAndTypePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> */
};
typedef struct DirGetNameAndTypePB DirGetNameAndTypePB;

/*
aRecord must contain valid RLI and a CreationID.  It
must also contain pointers to maximum-length RStrings (name and type fields)
in which will be returned the record's distinguished name and type.
*/
/*
SetNameAndType:
This call can be used to change a name and type for a record. The record
to be renamed is specified using 'aRecord'.
'newName' and 'newType' indicate the name and type to be set.
'allowDuplicate' if true indicates that name is to be set even if another
name and type exactly matches the newName and newType specified.

'newName' and 'newType' are required since the catalogs not supporting
CreationID require name and type fields in the recordID to identify a given
record.
*/
struct DirSetNameAndTypePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> */
	Boolean							allowDuplicate;				/*  --> */
	Byte							padByte;
	RStringPtr						newName;					/*  --> new name for the record */
	RStringPtr						newType;					/*  --> new type for the record */
};
typedef struct DirSetNameAndTypePB DirSetNameAndTypePB;

/*
DirGetMetaRecordInfo: This call can be made to obtain
the MetaRecordInfo for a given record. Information returned
is 16 bytes of OPAQUE information about the record.
*/
struct DirGetRecordMetaInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  --> */
	DirMetaInfo						metaInfo;					/* <--  */
};
typedef struct DirGetRecordMetaInfoPB DirGetRecordMetaInfoPB;

/*
DirGetDNodeMetaInfo: This call can be made to obtain
the DNodeMetaInfo for a given Packed RLI. Information returned
is 16 bytes of OPAQUE information about the DNode.
*/
struct DirGetDNodeMetaInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	PackedRLIPtr					pRLI;						/*  --> */
	DirMetaInfo						metaInfo;					/* <--  */
};
typedef struct DirGetDNodeMetaInfoPB DirGetDNodeMetaInfoPB;

/*
EnumerateDirectoriesGet:
A user can enumerate all the catalogs installed. This includes installed
ADAP and CSAM catalogs. The user can specify a signature as input to restrict
the results. kDirADAPKind will return only ADAP catalogs, kDirDSAMKind
will return all CSAM catalogs. kDirAllKinds will get both ADAP & CSAM catalogs.
A specific signature (e.g. X.500) may be used to get catalogs with an X.500 signature.
The information for each catalog returned will have directoryName, discriminator and features.

If the user receives 'noErr' or 'kOCEMoreData', the buffer will contain valid results. A user
can extract the results in the 'getBuffer' by making an DirEnumerateDirectories call.

If 'kOCEMoreData' is received, the user can continue enumeration by using the last catalog and
discriminator as startingDirectoryName and staringDirDiscriminator in the next call.

If 'includeStartingPoint' is true and a starting point is specified,
the staring point will be returned in the result. If false, it is not included.
*/
struct DirEnumerateDirectoriesGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	OCEDirectoryKind				directoryKind;				/*  --> enumerate catalogs bearing this signature */
	DirectoryNamePtr				startingDirectoryName;		/*  --> staring catalog name */
	DirDiscriminator				startingDirDiscriminator;	/*  --> staring catalog discriminator */
	long							eReserved;					/*  --  */
	long							fReserved;					/*  --  */
	long							gReserved;					/*  --  */
	long							hReserved;					/*  --  */
	Boolean							includeStartingPoint;		/*  --> if true return the catalog specified by starting point */
	Byte							padByte;
	short							i1Reserved;					/*  --  */
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
};
typedef struct DirEnumerateDirectoriesGetPB DirEnumerateDirectoriesGetPB;

typedef pascal Boolean (*ForEachDirectoryProcPtr)(long clientData, const DirectoryName *dirName, const DirDiscriminator *discriminator, DirGestalt features);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachDirectoryUPP;
#else
typedef ForEachDirectoryProcPtr ForEachDirectoryUPP;
#endif

typedef ForEachDirectoryUPP ForEachDirectory;

/*
EnumerateDirectoriesParse:
The catalog info returned in 'getBuffer' from the EnumerateDirectoriesGet call
can be extracted using the EnumerateDirectoriesParse call. 'eachDirectory' will
be called for each catalog.

Returning true from any call-back will terminate the EnumerateDirectoriesParse call.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the EnumerateDirectoriesParse call.  That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of EnumerateDirectoriesParse:
if EnumerateDirectoriesParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.

eachDirectory will be called each time to return to the client a
DirectoryName, DirDiscriminator, and features for that catalog.
*/
struct DirEnumerateDirectoriesParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	long							aReserved;					/*  --  */
	long							bReserved;					/*  --  */
	long							cReserved;					/*  --  */
	long							dReserved;					/*  --  */
	ForEachDirectory				eachDirectory;				/*  --> */
	long							fReserved;					/*  --  */
	long							gReserved;					/*  --  */
	long							hReserved;					/*  --  */
	long							iReserved;					/*  --  */
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
};
typedef struct DirEnumerateDirectoriesParsePB DirEnumerateDirectoriesParsePB;

/*
The Following five call are specific to ADAP Catalogs. Toolbox
remembers a list of catalogs across boots. If any catalog service
call is intended for a ADAP catalog, then it must be in the list.
In order for managing this list, A client (Probably DE will use these
calls.
DirAddADAPDirectoryPB: Add a new ADAP catalog to the list.
DirRemoveADAPDirectory: Remove a ADAP catalog from the list.
DirNetSearchADAPDirectoriesGet:   search an internet for adas catalogs.
DirNetSearchADAPDirectoriesParse: extract the results obtained NetSearchADAPDirectoriesGet.
DirFindADAPDirectoryByNetSearch: Find a specified catalog through net search.
*/
/*
NetSearchADAPDirectoriesGet:
This call can be used to make a network wide search for finding ADAP catalogs.
This call will be supported only by 'ADAP' and involve highly expensive
network operations, so the user is advised to use utmost discretion before
making this call. The results will be collected in the 'getbuffer' and can be
extracted using NetSearchADAPDirectoriesParse call. The directoryName,
the directoryDiscriminator, features and serverHint (AppleTalk address for
a PathFinder serving that catalog) are collected for each catalog found
on the network. If buffer is too small to hold all the catalogs found on
the network, a 'kOCEMoreData' error will be returned.
*/
struct DirNetSearchADAPDirectoriesGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
	long							cReserved;					/*  --  */
};
typedef struct DirNetSearchADAPDirectoriesGetPB DirNetSearchADAPDirectoriesGetPB;

typedef pascal Boolean (*ForEachADAPDirectoryProcPtr)(long clientData, const DirectoryName *dirName, const DirDiscriminator *discriminator, DirGestalt features, AddrBlock serverHint);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachADAPDirectoryUPP;
#else
typedef ForEachADAPDirectoryProcPtr ForEachADAPDirectoryUPP;
#endif

typedef ForEachADAPDirectoryUPP ForEachADAPDirectory;

/*
DirNetSearchADAPDirectoriesParse:
This call can be used to extract the results obtained in the 'getBuffer'.
The directoryName, directoryDiscriminator, features and
serverHint (AppleTalk address for a PathFinder serving that catalog) are
returned in each call-back. These values may be used to make an
AddADAPDirectory call.

Returning TRUE from any call-back will terminate the NetSearchADAPDirectoriesParse request.

For synchronous calls, the call-back routine actually runs as part of the same thread
of execution as the thread that made the DirNetSearchADAPDirectoriesParse call. That means that the
same low-memory globals, A5, stack, etc. are in effect during the call-back
that were in effect when the call was made.  Because of this, the call-back
routine has the same restrictions as the caller of DirNetSearchADAPDirectoriesParse:
if DirNetSearchADAPDirectoriesParse was not called from interrupt level, then the call-
back routine can allocate memory. For asynchronous calls, call-back routine is
like a ioCompletion except that A5 will be preserved for the application.
*/
struct DirNetSearchADAPDirectoriesParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	Ptr								getBuffer;					/*  --> */
	unsigned long					getBufferSize;				/*  --> */
	ForEachADAPDirectory			eachADAPDirectory;			/*  --> */
};
typedef struct DirNetSearchADAPDirectoriesParsePB DirNetSearchADAPDirectoriesParsePB;

/*
DirFindADAPDirectoryByNetSearch:
This call can be used to make a network wide search to find an ADAP catalog.
This call will be supported only by 'ADAP' and involves highly expensive
network operations, so the user is advised to use utmost discretion before
making this call. The catalog is specified using directoryName and discriminator.
If 'addToOCESetup' is true, the catalog will be automatically added to the setup
list and will be visible through the EnumerateDirectories call and also
also a creationID to the directoryRecord will be returned.
If this parameter is set to 'false', the catalog will be added to temporary list
and will be available for making other catalog service calls. The catalogs
which are not in the preference catalog list will not be visible through the
EnumerateDirectories call.
*/
struct DirFindADAPDirectoryByNetSearchPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	DirectoryNamePtr				directoryName;				/*  --> catalog name */
	DirDiscriminator				discriminator;				/*  --> discriminate between dup catalog names */
	Boolean							addToOCESetup;				/*  --> add this catalog to OCE Setup List */
	Byte							padByte;
	CreationID						directoryRecordCID;			/* <--  creationID for the catalog record */
};
typedef struct DirFindADAPDirectoryByNetSearchPB DirFindADAPDirectoryByNetSearchPB;

/*
DirAddADAPDirectory:
The catalog specified by 'directoryName' and 'discriminator' will be
added to the list of catalogs maintained by the Toolbox. Once added,
the catalog is available across boots, until the catalog is removed
explicitly through a DirRemoveADAPDirectory call.
If 'serverHint' is not nil, the address provided will be used
to contact a PathFinder for the catalog specified.
If 'serverHint' is nil or does not point to a valid PathFinder server
for that catalog, this call will fail.
If 'addToOCESetup' is true, the catalog will be automatically added to the setup
catalog list and will be visible through EnumerateDirectories calls and
also a creationID to the directoryRecord will be returned.
If this parameter is set to 'false', catalog will be added to temprary list
and will be available for making other catalog service calls. The catalogs
which are not in the setup  list will not be visible through
EnumerateDirectories call.
*/
struct DirAddADAPDirectoryPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	DirectoryNamePtr				directoryName;				/*  --> catalog name */
	DirDiscriminator				discriminator;				/*  --> discriminate between dup catalog names */
	Boolean							addToOCESetup;				/*  --> add this catalog to OCE Setup */
	Byte							padByte;
	CreationID						directoryRecordCID;			/* <--  creationID for the catalog record */
};
typedef struct DirAddADAPDirectoryPB DirAddADAPDirectoryPB;

/*
GetDirectoryInfo:
DirGetDirectoryInfo will do:

If a 'dsRefNum' is non-Zero, the catalog information for
	the corresponding  PAB will be  returned.
 If 'dsRefNum' is zero and 'serverHint' is non-zero, If the
 'serverHint' points to a valid ADAP Catalog Server(Path Finder),
 the catalog information (i.e. directoryName, discriminator, features)
 for that catalog will be returned.
	If a  valid catalog name and discriminator are provided
	features (Set of capability flags) for that catalog will be returned.
*/
struct DirGetDirectoryInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	DirectoryNamePtr				directoryName;				/*  --> catalog name */
	DirDiscriminator				discriminator;				/* <--> descriminate between dup catalog names */
	DirGestalt						features;					/* <--  capability bit flags */
};
typedef struct DirGetDirectoryInfoPB DirGetDirectoryInfoPB;

/*
 * Note on Access Controls:
 * Access control is based on a list model.
 * You can get access controls list which gives dsObject and accMask for each dsObject.
 * GetAccessControl can be limited to currently supplied identity by setting forCurrentUserOnly.
 * There are special DSObjects are defined in ADASTypes.h for each of the category
 * supported in ADAS Catalogs. (kOwner, kFriends, kAuthenticatedToCluster, 
 * kAuthenticatedToDirectory, kGuest) and DUGetActlDSSpec call can be used
 * to obtain appropraiate DSSpec before making set calls to ADAS catalogs.
 *
 */
/*
	GetDNodeAccessControlGet:
	This call can be done to get back access control list for a DNode.
	pRLI -> RLI of the DNode whose access control list is sought
	curUserAccMask -> If this is 'true', Access controls for the user specified by
	                  the identity parameter will be returned other wise entire list
					  will be returned.
	startingDsObj  -> If this is not nil, list should be started after this object.
	startingPointInclusive -> If staringDsObj is specified, include that in the returned
	                          results.
							  
	The results will be collected in the 'getBuffer' supplied by the user.
	If buffer can not hold all the data returned 'daMoreData' error will be returned.
	 
	If user receives 'noErr' or 'daMoreData', buffer will contain valid results. A user
	can extract the results in the 'getBuffer' by making 'DsGetDNodeAccessControlParse' call.
	
	Results returned for each DSObject will contain DSSpecPtr and three sets of access mask. 

*/
struct DirGetDNodeAccessControlGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	PackedRLIPtr					pRLI;						/*  -> RLI of the cluster whose access control list is sought  */
	long							bReserved;					/*  -- unused */
	long							cReserved;					/*  -- unused */
	long							dReserved;					/*  -- unused */
	long							eResreved;					/* --> */
	Boolean							forCurrentUserOnly;			/* -->  */
	Boolean							filler1;
	DSSpec							*startingPoint;				/* --> starting Point */
	Boolean							includeStartingPoint;		/*  -> if true return the DsObject 
																specified in starting point */
	Boolean							filler2;
	Ptr								getBuffer;					/*	-> */
	unsigned long					getBufferSize;				/*  -> */
};
typedef struct DirGetDNodeAccessControlGetPB DirGetDNodeAccessControlGetPB;

/* The Access Control call-back function is defined as follows: */
typedef pascal Boolean (*ForEachDNodeAccessControlProcPtr)(long clientData, const DSSpec *dsObj, AccessMask activeDnodeAccMask, AccessMask defaultRecordAccMask, AccessMask defaultAttributeAccMask);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachDNodeAccessControlUPP;
#else
typedef ForEachDNodeAccessControlProcPtr ForEachDNodeAccessControlUPP;
#endif

typedef ForEachDNodeAccessControlUPP ForEachDNodeAccessControl;

/*
	GetDNodeAccessControlParse:
	After an GetDNodeAccessControlGet call has completed, 
	call GetDNodeAccessControlParse to parse through the buffer that
	that was filled in GetDNodeAccessControlGet.
	
	'eachObject' will be called each time to return to the client a
	DsObject and a set of three accMasks (three long words) for that object.
	Acceesmasks returned apply to the dsObject in the callback :
	1. Currently Active Access mask for the specified DNode.
	2. Default Access mask for any Record in the DNode
	3. Default Access mask for any Attribute in the DNode
	The clientData parameter that you pass in the parameter block will be passed
	to 'eachObject'.  You are free to put anything in clientData - it is intended
	to allow you some way to match the call-back to the original call (for
	example, you make more then one aysynchronous GetDNodeAccessControlGet calls and you want to
	associate returned results in some way).
	
	The client should return FALSE from 'eachObject' to continue
	processing of the GetDNodeAccessControlParse request.  Returning TRUE will
	terminate the GetDNodeAccessControlParse request.

	For synchronous calls, the call-back routine actually runs as part of the same thread 
	of execution as the thread that made the GetDNodeAccessControlParse call.  That means that the
	same low-memory globals, A5, stack, etc. are in effect during the call-back
	that were in effect when the call was made.  Because of this, the call-back
	routine has the same restrictions as the caller of GetDNodeAccessControlParse:
	if GetDNodeAccessControlParse was not called from interrupt level, then the call-
	back routine can allocate memory. For asynchronous calls, call-back routine is
	like a ioCompletion except that A5 will be preserved for the application.


*/
struct DirGetDNodeAccessControlParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	PackedRLIPtr					pRLI;						/*  -> RLI of the cluster  */
	long							bReserved;					/*  -- unused */
	long							cReserved;					/*  -- unused */
	long							dReserved;					/*  -- unused */
	ForEachDNodeAccessControl		eachObject;					/* --> */
	Boolean							forCurrentUserOnly;			/* -->  */
	Boolean							filler1;
	DSSpec							*startingPoint;				/* --> starting Point */
	Boolean							includeStartingPoint;		/*  -> if true return the record 
														specified in starting point */
	Boolean							filler2;
	Ptr								getBuffer;					/*	-> */
	unsigned long					getBufferSize;				/*  -> */
};
typedef struct DirGetDNodeAccessControlParsePB DirGetDNodeAccessControlParsePB;

/*
	GetRecordAccessControlGet:
	This call can be done to get back access control list for a RecordID.
	aRecord -> RecordID to which access control list is sought
	curUserAccMask -> If this is 'true', Access controls for the user specified by
	                  the identity parameter will be returned other wise entire list
					  will be returned.
	startingDsObj  -> If this is not nil, list should be started after this object.
	startingPointInclusive -> If staringDsObj is specified, include that in the returned
	                          results.
							  
	The results will be collected in the 'getBuffer' supplied by the user.
	If buffer can not hold all the data returned 'daMoreData' error will be returned.
	 
	If user receives 'noErr' or 'daMoreData', buffer will contain valid results. A user
	can extract the results in the 'getBuffer' by making 'DsGetDNodeAccessControlParse' call.
	
	Results returned for each DSObject will contain DSSpecPtr and accMask. 

*/
struct DirGetRecordAccessControlGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  -> RecordID to which access control list is sought list is sought  */
	long							bReserved;					/*  -- unused */
	long							cReserved;					/*  -- unused */
	long							dReserved;					/*  -- unused */
	long							eResreved;					/* --> */
	Boolean							forCurrentUserOnly;			/* -->  */
	Boolean							filler1;
	DSSpec							*startingPoint;				/* --> starting Point */
	Boolean							includeStartingPoint;		/*  -> if true return the DsObject 
																specified in starting point */
	Boolean							filler2;
	Ptr								getBuffer;					/*	-> */
	unsigned long					getBufferSize;				/*  -> */
};
typedef struct DirGetRecordAccessControlGetPB DirGetRecordAccessControlGetPB;

/* The Access Control call-back function is defined as follows: */
typedef pascal Boolean (*ForEachRecordAccessControlProcPtr)(long clientData, const DSSpec *dsObj, AccessMask activeDnodeAccMask, AccessMask activeRecordAccMask, AccessMask defaultAttributeAccMask);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachRecordAccessControlUPP;
#else
typedef ForEachRecordAccessControlProcPtr ForEachRecordAccessControlUPP;
#endif

typedef ForEachRecordAccessControlUPP ForEachRecordAccessControl;

/*
	GetRecordAccessControlParse:
	After an GetRecordAccessControlGet call has completed, 
	call GetRecordAccessControlParse to parse through the buffer that
	that was filled in GetRecordAccessControlGet.
	
	'eachObject' will be called each time to return to the client a
	DsObject and a set of three accMasks (three long words) for that object.
	Acceesmasks returned apply to the dsObject in the callback :
	1. Active Access mask for the DNode Containing the Record.
	2. Active Access mask for the Record specified.
	3. Defualt Access mask for Attributes in the record.
	The clientData parameter that you pass in the parameter block will be passed
	to 'eachObject'.  You are free to put anything in clientData - it is intended
	to allow you some way to match the call-back to the original call (for
	example, you make more then one aysynchronous GetRecordAccessControlGet calls and you want to
	associate returned results in some way).
	
	The client should return FALSE from 'eachObject' to continue
	processing of the GetRecordAccessControlParse request.  Returning TRUE will
	terminate the GetRecordAccessControlParse request.

	For synchronous calls, the call-back routine actually runs as part of the same thread 
	of execution as the thread that made the GetRecordAccessControlParse call.  That means that the
	same low-memory globals, A5, stack, etc. are in effect during the call-back
	that were in effect when the call was made.  Because of this, the call-back
	routine has the same restrictions as the caller of GetRecordAccessControlParse:
	if GetRecordAccessControlParse was not called from interrupt level, then the call-
	back routine can allocate memory. For asynchronous calls, call-back routine is
	like a ioCompletion except that A5 will be preserved for the application.


*/
struct DirGetRecordAccessControlParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  -> RecordID to which access control list is sought list is sought  */
	long							bReserved;					/*  -- unused */
	long							cReserved;					/*  -- unused */
	long							dReserved;					/*  -- unused */
	ForEachRecordAccessControl		eachObject;					/* --> */
	Boolean							forCurrentUserOnly;			/* -->  */
	Boolean							filler1;
	DSSpec							*startingPoint;				/* --> starting Point */
	Boolean							includeStartingPoint;		/*  -> if true return the record 
														specified in starting point */
	Boolean							filler2;
	Ptr								getBuffer;					/*	-> */
	unsigned long					getBufferSize;				/*  -> */
};
typedef struct DirGetRecordAccessControlParsePB DirGetRecordAccessControlParsePB;

/*
	GetAttributeAccessControlGet:
	This call can be done to get back access control list for a attributeType with in a RecordID.
	aRecord -> RecordID to which access control list is sought
	aType	-> Attribute Type to which access controls are sought
	curUserAccMask -> If this is 'true', Access controls for the user specified by
	                  the identity parameter will be returned other wise entire list
					  will be returned.
	startingDsObj  -> If this is not nil, list should be started after this object.
	startingPointInclusive -> If staringDsObj is specified, include that in the returned
	                          results.
							  
	The results will be collected in the 'getBuffer' supplied by the user.
	If buffer can not hold all the data returned 'daMoreData' error will be returned.
	 
	If user receives 'noErr' or 'daMoreData', buffer will contain valid results. A user
	can extract the results in the 'getBuffer' by making 'DsGetDNodeAccessControlParse' call.
	
	Results returned for each DSObject will contain DSSpecPtr and accMask. 

*/
struct DirGetAttributeAccessControlGetPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  -> RecordID to which access control list is sought list is sought  */
	AttributeTypePtr				aType;						/*  -> Attribute Type to which access controls are sought          */
	long							cReserved;					/*  -- unused */
	long							dReserved;					/*  -- unused */
	long							eResreved;					/* --> */
	Boolean							forCurrentUserOnly;			/* -->  */
	Boolean							filler1;
	DSSpec							*startingPoint;				/* --> starting Point */
	Boolean							includeStartingPoint;		/*  -> if true return the DsObject 
																specified in starting point */
	Boolean							filler2;
	Ptr								getBuffer;					/*	-> */
	unsigned long					getBufferSize;				/*  -> */
};
typedef struct DirGetAttributeAccessControlGetPB DirGetAttributeAccessControlGetPB;

/* The Access Control call-back function is defined as follows: */
typedef pascal Boolean (*ForEachAttributeAccessControlProcPtr)(long clientData, const DSSpec *dsObj, AccessMask activeDnodeAccMask, AccessMask activeRecordAccMask, AccessMask activeAttributeAccMask);

#if GENERATINGCFM
typedef UniversalProcPtr ForEachAttributeAccessControlUPP;
#else
typedef ForEachAttributeAccessControlProcPtr ForEachAttributeAccessControlUPP;
#endif

typedef ForEachAttributeAccessControlUPP ForEachAttributeAccessControl;

/*
	GetAttributeAccessControlParse:
	After an GetAttributeAccessControlGet call has completed, 
	call GetAttributeAccessControlParse to parse through the buffer that
	that was filled in GetAttributeAccessControlGet.
	
	'eachObject' will be called each time to return to the client a
	DsObject and a set of three accMasks (three long words) for that object.
	Acceesmasks returned apply to the dsObject in the callback :
	1. Active Access mask for the DNode Containing the Attribute.
	2. Active Access mask for the Record in the Containing the Attribute.
	3. Active Access mask for the specified Attribute.
	The clientData parameter that you pass in the parameter block will be passed
	to 'eachObject'.  You are free to put anything in clientData - it is intended
	to allow you some way to match the call-back to the original call (for
	example, you make more then one aysynchronous GetAttributeAccessControlGet calls and you want to
	associate returned results in some way).
	
	The client should return FALSE from 'eachObject' to continue
	processing of the GetAttributeAccessControlParse request.  Returning TRUE will
	terminate the GetAttributeAccessControlParse request.

	For synchronous calls, the call-back routine actually runs as part of the same thread 
	of execution as the thread that made the GetAttributeAccessControlParse call.  That means that the
	same low-memory globals, A5, stack, etc. are in effect during the call-back
	that were in effect when the call was made.  Because of this, the call-back
	routine has the same restrictions as the caller of GetAttributeAccessControlParse:
	if GetAttributeAccessControlParse was not called from interrupt level, then the call-
	back routine can allocate memory. For asynchronous calls, call-back routine is
	like a ioCompletion except that A5 will be preserved for the application.


*/
struct DirGetAttributeAccessControlParsePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RecordIDPtr						aRecord;					/*  -> RecordID to which access control list is sought list is sought  */
	AttributeTypePtr				aType;						/*  -> Attribute Type to which access controls are sought          */
	long							cReserved;					/*  -- unused */
	long							dReserved;					/*  -- unused */
	ForEachAttributeAccessControl	eachObject;					/* --> */
	Boolean							forCurrentUserOnly;			/* -->  */
	Boolean							filler1;
	DSSpec							*startingPoint;				/* --> starting Point */
	Boolean							includeStartingPoint;		/*  -> if true return the record 
														specified in starting point */
	Boolean							filler2;
	Ptr								getBuffer;					/*	-> */
	unsigned long					getBufferSize;				/*  -> */
};
typedef struct DirGetAttributeAccessControlParsePB DirGetAttributeAccessControlParsePB;

/*
MapPathNameToDNodeNumber:
This call maps a given PathName within a catalog to its DNodeNumber.
*/
struct DirMapPathNameToDNodeNumberPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	DirectoryNamePtr				directoryName;				/*  --> catalog name */
	DirDiscriminator				discriminator;				/*  --> discriminator */
	DNodeNum						dNodeNumber;				/* <--  dNodenumber to the path */
	PackedPathNamePtr				path;						/*  --> Path Name to be mapped */
};
typedef struct DirMapPathNameToDNodeNumberPB DirMapPathNameToDNodeNumberPB;

/*
PathName in the path field will be mapped to the cooresponding dNodeNumber and
returned in the DNodeNumber field. directoryName and descriminator Fields are
ignored. DSRefNum is used to identify the catalog.
*/
/*
MapDNodeNumberToPathName:
This call will map a given DNodeNumber with in a catalog to the
corresponding PathName.
*/
struct DirMapDNodeNumberToPathNamePB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	DirectoryNamePtr				directoryName;				/*  --> catalog name */
	DirDiscriminator				discriminator;				/*  --> discriminator */
	DNodeNum						dNodeNumber;				/*  --> dNodenumber to be mapped */
	PackedPathNamePtr				path;						/* <--  Packed Path Name returned */
	unsigned short					lengthOfPathName;			/*  --> length of packed pathName structure*/
};
typedef struct DirMapDNodeNumberToPathNamePB DirMapDNodeNumberToPathNamePB;

/*
dNodeNumber in the DNodeNumber field will be mapped to the cooresponding
pathName and returned in the PackedPathName field.
lengthOfPathName is to be set the length of pathName structure.
If length of PackedPathName is larger then the lengthOfPathName, kOCEMoreData
OSErr will be returned.
*/
/*
GetLocalNetworkSpec:
This call will return the Local NetworkSpec. Client should supply
an RString big enough to hold the NetworkSpec.
*/
struct DirGetLocalNetworkSpecPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	DirectoryNamePtr				directoryName;				/*  --> catalog name */
	DirDiscriminator				discriminator;				/*  --> discriminator */
	NetworkSpecPtr					networkSpec;				/* <--  NetworkSpec */
};
typedef struct DirGetLocalNetworkSpecPB DirGetLocalNetworkSpecPB;

/*
PathName in the path field must be set to nil. internetName should be large
enough to hold the internetName. InterNetname returned indicates path finder's
local internet (configured by administrator).
*/
/*
GetDNodeInfo:
This call will return the information (internetName and descriptor)
for the given RLI of a DNode.
*/
struct DirGetDNodeInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	PackedRLIPtr					pRLI;						/*  --> packed RLI whose info is requested */
	DirNodeKind						descriptor;					/* <--  dNode descriptor */
	NetworkSpecPtr					networkSpec;				/* <--  cluster's networkSpec if kIsCluster */
};
typedef struct DirGetDNodeInfoPB DirGetDNodeInfoPB;

/*
If DnodeNumber is set to a non zero value, path should be set to nil.
if DnodeNumber is set to zero, pathName should point to a packed path name.
internetName should be large enough to hold
the internetName. (If the internetName is same as the one got by
GetLocalInternetName call, it indicates cluster is reachable  without
forwarders, --> Tell me if I am wrong)
*/
/*
DirCreatePersonalDirectory:
A new  personal catalog can be created by specifying an FSSpec for
the file. If a file already exists dupFNErr will be returned. This call is
supported 'synchronous' mode only.
*/
struct DirCreatePersonalDirectoryPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	FSSpecPtr						fsSpec;						/*  --> FSSpec for the Personal Catalog */
	OSType							fdType;						/*  --> file type for the Personal Catalog */
	OSType							fdCreator;					/*  --> file creator for the Personal Catalog */
};
typedef struct DirCreatePersonalDirectoryPB DirCreatePersonalDirectoryPB;

/*
DirOpenPersonalDirectory:
An existing personal catalog can be opened using this call.
User can specify the personal catalog by FSSpec for the AddressBook file.
'accessRequested' field specifies open permissions. 'fsRdPerm'  & 'fsRdWrPerm'
are the only accepted open modes for the address book.
When the call completes successfully, a dsRefNum will be returned. The 'dsRefNum'
field is in the DSParamBlockHeader. In addittion 'accessGranted' indicates
actual permission with personal catalog is opened and 'features' indicate the capabilty flags
associated with the personal catalog.
This call is supported 'synchronous' mode only.
*/
struct DirOpenPersonalDirectoryPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	FSSpecPtr						fsSpec;						/*  --> Open an existing Personal Catalog */
	char							accessRequested;			/*  --> Open: permissions Requested(byte)*/
	char							accessGranted;				/*  <-- Open: permissions (byte) (Granted)*/
	DirGestalt						features;					/* <--  features for Personal Catalog */
};
typedef struct DirOpenPersonalDirectoryPB DirOpenPersonalDirectoryPB;

/*
DirClosePersonalDirectory: This call lets a client close AddressBook opened by DirOpenPersonalDirectory.
The Personal Catalog specified by the 'dsRefNum' will be closed.
This call is supported 'synchronous' mode only.
*/
struct DirClosePersonalDirectoryPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
};
typedef struct DirClosePersonalDirectoryPB DirClosePersonalDirectoryPB;

/*
DirMakePersonalDirectoryRLI: With this call a client can make an RLI
for a Personal Catalog opened by DirOpenPersonalDirectory Call.
A packed RLI is created for the Personal Catalog specified by the 'dsRefNum'.
If a client has a need to make the AddressBook reference to persistent
acrross boots it should make use of this call. In the current implementaion
PackedRLI has an embeeded System7.0 'alias'. If in later time
If client has a need to make reference to the AddressBook, it must use
ADAPLibrary call 'DUExtractAlias' and resole the 'alias' to 'FSSpec' and
make DirOpenPersonalDirectory call to get a 'dsRefNum'.
  'fromFSSpec'			FSPecPtr from which relative alias to be created. If nil,
						absolute alias is created.
 'pRLIBufferSize' indicates the size of buffer pointed by 'pRLI'
 'pRLISize'	indicates the actual length of 'pRLI'. If the call
						fails with 'kOCEMoreData' error a client can reissue
					this call with a larger buffer of this length.
  'pRLI' is pointer to the buffer in which 'PackedRLI' is
  returned.
This call is supported in 'synchronous' mode only.
*/
struct DirMakePersonalDirectoryRLIPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	FSSpecPtr						fromFSSpec;					/*  --> FSSpec for creating relative alia */
	unsigned short					pRLIBufferSize;				/*  --> Length of 'pRLI' buffer */
	unsigned short					pRLISize;					/* <--  Length of actual 'pRLI' */
	PackedRLIPtr					pRLI;						/* <--  pRLI for the specified AddressBook */
};
typedef struct DirMakePersonalDirectoryRLIPB DirMakePersonalDirectoryRLIPB;

/*****************************************************************************
The calls described below apply only for CSAM Drivers:

The following three calls provide capability to Install/Remove a CSAM at RunTime.
	DirAddDSAM
	DirRemoveDSAM
	DirInstantiateDSAM

The following two calls provide capability to Install/Remove a CSAM Catalog at RunTime.
	DirAddDSAMDirectory
	DirRemoveDirectory

DirGetDirectoryIcon call is used by clients to get any special icon associated
with a CSAM catalog.

*****************************************************************************/
/*
DirAddDSAM: This call can be used to inorm the availability of a CSAM file
after discovering the CSAM file.
	dsamName -> is generic CSAM name e.g. Untitled X.500 directory
	dsamSignature -> could be generic CSAM kind e.g. 'X500'.
	fsSpec -> is the FileSpec for the file containing CSAM resources.
If the call is successfull 'DSAMRecordCID' will be returned. If the
call returns 'daDSAMRecordCIDExists', record was already there and
'dsamRecordCID' will be returned.
This call can be done only in synchronous mode.
*/
struct DirAddDSAMPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	CreationID						dsamRecordCID;				/* <--  CreationID for the CSAM record */
	RStringPtr						dsamName;					/*  --> CSAM name */
	OCEDirectoryKind				dsamKind;					/*  --> CSAM kind */
	FSSpecPtr						fsSpec;						/*  --> FSSpec for the file containing CSAM */
};
typedef struct DirAddDSAMPB DirAddDSAMPB;

/*
DirInstantiateDSAM: This call should be used by the CSAM driver in response
Driver Open call to indicate the toolbox about the availability of the CSAM.
	dsamName -> is generic CSAM name e.g. Untitled X.500 directory
	dsamKind -> could be generic CSAM kind e.g. 'X500'.
	dsamData -> pointer to private DSAMData. This will be paased back to the CSAM
	when the CSAM functions (DSAMDirProc,DSAMDirParseProc, DSAMAuthProc) are called.
	CSAM should already be setup using DirAddDSAM call.
	DSAMDirProc -> This procedure will be called when  any catalog service
	call intended for the CSAM (other then parse calls)
	DSAMDirParseProc -> This procedure will be called when any of the parse calls
	are called.
	DSAMAuthProc -> This procedure will be called when any of the Authentication Calls
	are made to the CSAM. If the CSAM does not support authentication, this can be nil.
This call can be done only in synchronous mode.
*/
typedef pascal OSErr (*DSAMDirProcPtr)(Ptr dsamData, DirParamBlockPtr paramBlock, Boolean async);

#if GENERATINGCFM
typedef UniversalProcPtr DSAMDirUPP;
#else
typedef DSAMDirProcPtr DSAMDirUPP;
#endif

typedef DSAMDirUPP DSAMDirProc;

typedef pascal OSErr (*DSAMDirParseProcPtr)(Ptr dsamData, DirParamBlockPtr paramBlock, Boolean async);

#if GENERATINGCFM
typedef UniversalProcPtr DSAMDirParseUPP;
#else
typedef DSAMDirParseProcPtr DSAMDirParseUPP;
#endif

typedef DSAMDirParseUPP DSAMDirParseProc;

typedef pascal OSErr (*DSAMAuthProcPtr)(Ptr dsamData, AuthParamBlockPtr pb, Boolean async);

#if GENERATINGCFM
typedef UniversalProcPtr DSAMAuthUPP;
#else
typedef DSAMAuthProcPtr DSAMAuthUPP;
#endif

typedef DSAMAuthUPP DSAMAuthProc;

struct DirInstantiateDSAMPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	RStringPtr						dsamName;					/*  --> dsamName name */
	OCEDirectoryKind				dsamKind;					/*  --> DSAMKind */
	Ptr								dsamData;					/*  --> dsamData  */
	DSAMDirUPP						dsamDirProc;				/*  --> of type DSAMDirProc: for catalog service calls */
	DSAMDirParseUPP					dsamDirParseProc;			/*  --> of type DSAMDirParseProc: for catalog service parse calls */
	DSAMAuthUPP						dsamAuthProc;				/*  --> of type DSAMAuthProc: for authetication service calls */
};
typedef struct DirInstantiateDSAMPB DirInstantiateDSAMPB;

/*
DirRemoveDSAM: This call can be used to remove  a CSAM file from the OCE Setup.
	dsamRecordCID -> is the creationID of the CSAM record.
This call can be made only in synchronous mode.
*/
struct DirRemoveDSAMPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	CreationID						dsamRecordCID;				/* <--  CreationID for the CSAM record */
};
typedef struct DirRemoveDSAMPB DirRemoveDSAMPB;

/*
DirAddDSAMDirectory: This call can be used to inorm the availability of a CSAM catalog.
	dsamRecordCID ->  recordID for the CSAM serving this catalog
	directoryName ->  name of the catalog
	discriminator -> discriminator for the catalog
	directoryRecordCID -> If the call is successful, creationID for the record will
							be returned.
*/
struct DirAddDSAMDirectoryPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	CreationID						dsamRecordCID;				/*  --> CreationID for the CSAM record */
	DirectoryNamePtr				directoryName;				/*  --> catalog name */
	DirDiscriminator				discriminator;				/*  --> catalog discriminator */
	DirGestalt						features;					/*  --> capabilty flags for the catalog */
	CreationID						directoryRecordCID;			/* <--  creationID for the catalog record */
};
typedef struct DirAddDSAMDirectoryPB DirAddDSAMDirectoryPB;

/*
DirRemoveDirectory: This call can be used to inform the toolbox that
catalog specified by 'directoryRecordCID'
*/
struct DirRemoveDirectoryPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	CreationID						directoryRecordCID;			/*  --> creationID for the catalog record */
};
typedef struct DirRemoveDirectoryPB DirRemoveDirectoryPB;

/*
 * DSGetExtendedDirectoriesInfo::  This call can be used to get
 * the information of various foreign catalogs supported.
 * Typically a DE Template  may make this call to create a
 * Address template or a Gateway may make this call to findout
 * catalog name space in which MSAM may would support. 
 * Client will supply a buffer pointed by 'bufferPtr' of size 'bufferLength'. 
 * When the call completes with 'daMoreData' error, client can examine 'totalEntries'
 * returned and reissue the call with increaing buffer.
 * Toolbox will findout the private information of each of the Foreign Catalogs
 * by polling CSAM's, Gateways, and MnMServers. The Information returned
 * for each catalog will be packed in the format: 
 * typedef struct EachDirectoryData {
 *  PackedRLI						pRLI;	       //  packed RLI for the catalog
 *  OSType							entnType; 	   //  Entn Type
 *  long							hasMailSlot;   //  If this catalog has mail slot this will be 1 otherwise zero
 *	ProtoRString					RealName;      //  Packed RString for Real Name (padded to even boundary) 
 *	ProtoRString					comment;       //  Packed RString holding any comment for Display (padded to even boundary)
 *	long                			length;        //  data length
 *	char                			data[length];  //  data padded to even boundary
 * };
 *
 *
 *
 * typedef struct myData {
 *      EachDirectoryData	data[numberOfEntries];    // data packed in the above format
 *	};
 *
 */
struct DirGetExtendedDirectoriesInfoPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	Ptr								buffer;						/*  --> Pointer to a buufer where data will be returned */
	unsigned long					bufferSize;					/*  --> Length of the buffer, Length of actual data will be returned here */
	unsigned long					totalEntries;				/* <--  Total Number of Catalogs found */
	unsigned long					actualEntries;				/* <--  Total Number of Catalogs entries returned */
};
typedef struct DirGetExtendedDirectoriesInfoPB DirGetExtendedDirectoriesInfoPB;

/*
DirGetDirectoryIconPB: With this call a client can find out about
the icons supported by the Catalog.
Both ADAP and Personal Catalog will not support this call for now.
A CSAM can support a call so that DE Extension can use this
call to find appropriate Icons.

Returns kOCEBufferTooSmall if icon is too small, but will update iconSize.
*/
struct DirGetDirectoryIconPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	PackedRLIPtr					pRLI;						/*  --> packed RLI for the catalog */
	OSType							iconType;					/*  --> Type of Icon requested */
	Ptr								iconBuffer;					/*  --> Buffer to hold Icon Data */
	unsigned long					bufferSize;					/*  <-> size of buffer to hold icon data */
};
typedef struct DirGetDirectoryIconPB DirGetDirectoryIconPB;

/*
DirGetOCESetupRefNum: This call will return 'dsRefnum' for the OCE Setup Personal Catalog
and oceSetupRecordCID for the oceSetup Record.
Clients interested in manipulating OCE Setup Personal Catalog directly should
make this call to get 'dsRefNum'.
'dsRefNum' will be returned in the standard field in the DirParamHeader.
*/
struct DirGetOCESetupRefNumPB {
	Ptr								qLink;
	long							reserved1;
	long							reserved2;
	DirIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	unsigned long					saveA5;
	short							reqCode;
	long							reserved[2];
	AddrBlock						serverHint;
	short							dsRefNum;
	unsigned long					callID;
	AuthIdentity					identity;
	long							gReserved1;
	long							gReserved2;
	long							gReserved3;
	long							clientData;
	CreationID						oceSetupRecordCID;			/* --> creationID for the catalog record */
};
typedef struct DirGetOCESetupRefNumPB DirGetOCESetupRefNumPB;

/*****************************************************************************/
/* Catalog and Authentication control blocks and operation definitions */
union AuthParamBlock {
	struct {
		Ptr								qLink;
		long							reserved1;
		long							reserved2;
		AuthIOCompletionUPP				ioCompletion;
		OSErr							ioResult;
		unsigned long					saveA5;
		short							reqCode;
		long							reserved[2];
		AddrBlock						serverHint;
		short							dsRefNum;
		unsigned long					callID;
		AuthIdentity					identity;
		long							gReserved1;
		long							gReserved2;
		long							gReserved3;
		long							clientData;
	}								header;
	AuthBindSpecificIdentityPB		bindIdentityPB;
	AuthUnbindSpecificIdentityPB	unbindIdentityPB;
	AuthResolveCreationIDPB			resolveCreationIDPB;
	AuthGetSpecificIdentityInfoPB	getIdentityInfoPB;
	AuthAddKeyPB					addKeyPB;
	AuthChangeKeyPB					changeKeyPB;
	AuthDeleteKeyPB					deleteKeyPB;
	AuthPasswordToKeyPB				passwordToKeyPB;
	AuthGetCredentialsPB			getCredentialsPB;
	AuthDecryptCredentialsPB		decryptCredentialsPB;
	AuthMakeChallengePB				makeChallengePB;
	AuthMakeReplyPB					makeReplyPB;
	AuthVerifyReplyPB				verifyReplyPB;
	AuthGetUTCTimePB				getUTCTimePB;
	AuthMakeProxyPB					makeProxyPB;
	AuthTradeProxyForCredentialsPB	tradeProxyForCredentialsPB;
	AuthGetLocalIdentityPB			getLocalIdentityPB;
	AuthUnlockLocalIdentityPB		unLockLocalIdentityPB;
	AuthLockLocalIdentityPB			lockLocalIdentityPB;
	AuthAddToLocalIdentityQueuePB	localIdentityQInstallPB;
	AuthRemoveFromLocalIdentityQueuePB localIdentityQRemovePB;
	AuthSetupLocalIdentityPB		setupLocalIdentityPB;
	AuthChangeLocalIdentityPB		changeLocalIdentityPB;
	AuthRemoveLocalIdentityPB		removeLocalIdentityPB;
	OCESetupAddDirectoryInfoPB		setupDirectoryIdentityPB;
	OCESetupChangeDirectoryInfoPB	changeDirectoryIdentityPB;
	OCESetupRemoveDirectoryInfoPB	removeDirectoryIdentityPB;
	OCESetupGetDirectoryInfoPB		getDirectoryIdentityInfoPB;
};
union DirParamBlock {
	struct {
		Ptr								qLink;
		long							reserved1;
		long							reserved2;
		DirIOCompletionUPP				ioCompletion;
		OSErr							ioResult;
		unsigned long					saveA5;
		short							reqCode;
		long							reserved[2];
		AddrBlock						serverHint;
		short							dsRefNum;
		unsigned long					callID;
		AuthIdentity					identity;
		long							gReserved1;
		long							gReserved2;
		long							gReserved3;
		long							clientData;
	}								header;
	DirAddRecordPB					addRecordPB;
	DirDeleteRecordPB				deleteRecordPB;
	DirEnumerateGetPB				enumerateGetPB;
	DirEnumerateParsePB				enumerateParsePB;
	DirFindRecordGetPB				findRecordGetPB;
	DirFindRecordParsePB			findRecordParsePB;
	DirLookupGetPB					lookupGetPB;
	DirLookupParsePB				lookupParsePB;
	DirAddAttributeValuePB			addAttributeValuePB;
	DirDeleteAttributeTypePB		deleteAttributeTypePB;
	DirDeleteAttributeValuePB		deleteAttributeValuePB;
	DirChangeAttributeValuePB		changeAttributeValuePB;
	DirVerifyAttributeValuePB		verifyAttributeValuePB;
	DirFindValuePB					findValuePB;
	DirEnumeratePseudonymGetPB		enumeratePseudonymGetPB;
	DirEnumeratePseudonymParsePB	enumeratePseudonymParsePB;
	DirAddPseudonymPB				addPseudonymPB;
	DirDeletePseudonymPB			deletePseudonymPB;
	DirAddAliasPB					addAliasPB;
	DirEnumerateAttributeTypesGetPB	enumerateAttributeTypesGetPB;
	DirEnumerateAttributeTypesParsePB enumerateAttributeTypesParsePB;
	DirGetNameAndTypePB				getNameAndTypePB;
	DirSetNameAndTypePB				setNameAndTypePB;
	DirGetRecordMetaInfoPB			getRecordMetaInfoPB;
	DirGetDNodeMetaInfoPB			getDNodeMetaInfoPB;
	DirGetDirectoryInfoPB			getDirectoryInfoPB;
	DirGetDNodeAccessControlGetPB	getDNodeAccessControlGetPB;
	DirGetDNodeAccessControlParsePB	getDNodeAccessControlParsePB;
	DirGetRecordAccessControlGetPB	getRecordAccessControlGetPB;
	DirGetRecordAccessControlParsePB getRecordAccessControlParsePB;
	DirGetAttributeAccessControlGetPB getAttributeAccessControlGetPB;
	DirGetAttributeAccessControlParsePB getAttributeAccessControlParsePB;
	DirEnumerateDirectoriesGetPB	enumerateDirectoriesGetPB;
	DirEnumerateDirectoriesParsePB	enumerateDirectoriesParsePB;
	DirAddADAPDirectoryPB			addADAPDirectoryPB;
	DirRemoveDirectoryPB			removeDirectoryPB;
	DirNetSearchADAPDirectoriesGetPB netSearchADAPDirectoriesGetPB;
	DirNetSearchADAPDirectoriesParsePB netSearchADAPDirectoriesParsePB;
	DirFindADAPDirectoryByNetSearchPB findADAPDirectoryByNetSearchPB;
	DirMapDNodeNumberToPathNamePB	mapDNodeNumberToPathNamePB;
	DirMapPathNameToDNodeNumberPB	mapPathNameToDNodeNumberPB;
	DirGetLocalNetworkSpecPB		getLocalNetworkSpecPB;
	DirGetDNodeInfoPB				getDNodeInfoPB;
	DirCreatePersonalDirectoryPB	createPersonalDirectoryPB;
	DirOpenPersonalDirectoryPB		openPersonalDirectoryPB;
	DirClosePersonalDirectoryPB		closePersonalDirectoryPB;
	DirMakePersonalDirectoryRLIPB	makePersonalDirectoryRLIPB;
	DirAddDSAMPB					addDSAMPB;
	DirInstantiateDSAMPB			instantiateDSAMPB;
	DirRemoveDSAMPB					removeDSAMPB;
	DirAddDSAMDirectoryPB			addDSAMDirectoryPB;
	DirGetExtendedDirectoriesInfoPB	getExtendedDirectoriesInfoPB;
	DirGetDirectoryIconPB			getDirectoryIconPB;
	DirGetOCESetupRefNumPB			dirGetOCESetupRefNumPB;
	DirAbortPB						abortPB;
};
enum {
	uppAuthIOCompletionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(AuthParamBlockPtr))),
	uppNotificationProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(AuthLocalIdentityOp)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(AuthLocalIdentityLockAction)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(LocalIdentity))),
	uppDirIOCompletionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DirParamBlockPtr))),
	uppForEachDirEnumSpecProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DirEnumSpec*))),
	uppForEachRecordProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DirEnumSpec*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(PackedRLIPtr))),
	uppForEachLookupRecordIDProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(RecordID*))),
	uppForEachAttrTypeLookupProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(AttributeType*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(AccessMask))),
	uppForEachAttrValueProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Attribute*))),
	uppForEachAttrTypeProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(AttributeType*))),
	uppForEachRecordIDProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(RecordID*))),
	uppForEachDirectoryProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DirectoryName*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(DirDiscriminator*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(DirGestalt))),
	uppForEachADAPDirectoryProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DirectoryName*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(DirDiscriminator*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(DirGestalt)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(AddrBlock))),
	uppForEachDNodeAccessControlProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DSSpec*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(AccessMask)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(AccessMask)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(AccessMask))),
	uppForEachRecordAccessControlProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DSSpec*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(AccessMask)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(AccessMask)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(AccessMask))),
	uppForEachAttributeAccessControlProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DSSpec*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(AccessMask)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(AccessMask)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(AccessMask))),
	uppDSAMDirProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DirParamBlockPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean))),
	uppDSAMDirParseProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DirParamBlockPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean))),
	uppDSAMAuthProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(AuthParamBlockPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean)))
};

#if GENERATINGCFM
#define CallAuthIOCompletionProc(userRoutine, paramBlock)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppAuthIOCompletionProcInfo, (paramBlock))
#define CallNotificationProc(userRoutine, clientData, callValue, actionValue, identity)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppNotificationProcInfo, (clientData), (callValue), (actionValue), (identity))
#define CallDirIOCompletionProc(userRoutine, paramBlock)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDirIOCompletionProcInfo, (paramBlock))
#define CallForEachDirEnumSpecProc(userRoutine, clientData, enumSpec)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachDirEnumSpecProcInfo, (clientData), (enumSpec))
#define CallForEachRecordProc(userRoutine, clientData, enumSpec, pRLI)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachRecordProcInfo, (clientData), (enumSpec), (pRLI))
#define CallForEachLookupRecordIDProc(userRoutine, clientData, recordID)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachLookupRecordIDProcInfo, (clientData), (recordID))
#define CallForEachAttrTypeLookupProc(userRoutine, clientData, attrType, myAttrAccMask)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachAttrTypeLookupProcInfo, (clientData), (attrType), (myAttrAccMask))
#define CallForEachAttrValueProc(userRoutine, clientData, attribute)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachAttrValueProcInfo, (clientData), (attribute))
#define CallForEachAttrTypeProc(userRoutine, clientData, attrType)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachAttrTypeProcInfo, (clientData), (attrType))
#define CallForEachRecordIDProc(userRoutine, clientData, recordID)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachRecordIDProcInfo, (clientData), (recordID))
#define CallForEachDirectoryProc(userRoutine, clientData, dirName, discriminator, features)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachDirectoryProcInfo, (clientData), (dirName), (discriminator), (features))
#define CallForEachADAPDirectoryProc(userRoutine, clientData, dirName, discriminator, features, serverHint)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachADAPDirectoryProcInfo, (clientData), (dirName), (discriminator), (features), (serverHint))
#define CallForEachDNodeAccessControlProc(userRoutine, clientData, dsObj, activeDnodeAccMask, defaultRecordAccMask, defaultAttributeAccMask)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachDNodeAccessControlProcInfo, (clientData), (dsObj), (activeDnodeAccMask), (defaultRecordAccMask), (defaultAttributeAccMask))
#define CallForEachRecordAccessControlProc(userRoutine, clientData, dsObj, activeDnodeAccMask, activeRecordAccMask, defaultAttributeAccMask)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachRecordAccessControlProcInfo, (clientData), (dsObj), (activeDnodeAccMask), (activeRecordAccMask), (defaultAttributeAccMask))
#define CallForEachAttributeAccessControlProc(userRoutine, clientData, dsObj, activeDnodeAccMask, activeRecordAccMask, activeAttributeAccMask)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppForEachAttributeAccessControlProcInfo, (clientData), (dsObj), (activeDnodeAccMask), (activeRecordAccMask), (activeAttributeAccMask))
#define CallDSAMDirProc(userRoutine, dsamData, paramBlock, async)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDSAMDirProcInfo, (dsamData), (paramBlock), (async))
#define CallDSAMDirParseProc(userRoutine, dsamData, paramBlock, async)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDSAMDirParseProcInfo, (dsamData), (paramBlock), (async))
#define CallDSAMAuthProc(userRoutine, dsamData, pb, async)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDSAMAuthProcInfo, (dsamData), (pb), (async))
#else
#define CallAuthIOCompletionProc(userRoutine, paramBlock)		\
		(*(userRoutine))((paramBlock))
#define CallNotificationProc(userRoutine, clientData, callValue, actionValue, identity)		\
		(*(userRoutine))((clientData), (callValue), (actionValue), (identity))
#define CallDirIOCompletionProc(userRoutine, paramBlock)		\
		(*(userRoutine))((paramBlock))
#define CallForEachDirEnumSpecProc(userRoutine, clientData, enumSpec)		\
		(*(userRoutine))((clientData), (enumSpec))
#define CallForEachRecordProc(userRoutine, clientData, enumSpec, pRLI)		\
		(*(userRoutine))((clientData), (enumSpec), (pRLI))
#define CallForEachLookupRecordIDProc(userRoutine, clientData, recordID)		\
		(*(userRoutine))((clientData), (recordID))
#define CallForEachAttrTypeLookupProc(userRoutine, clientData, attrType, myAttrAccMask)		\
		(*(userRoutine))((clientData), (attrType), (myAttrAccMask))
#define CallForEachAttrValueProc(userRoutine, clientData, attribute)		\
		(*(userRoutine))((clientData), (attribute))
#define CallForEachAttrTypeProc(userRoutine, clientData, attrType)		\
		(*(userRoutine))((clientData), (attrType))
#define CallForEachRecordIDProc(userRoutine, clientData, recordID)		\
		(*(userRoutine))((clientData), (recordID))
#define CallForEachDirectoryProc(userRoutine, clientData, dirName, discriminator, features)		\
		(*(userRoutine))((clientData), (dirName), (discriminator), (features))
#define CallForEachADAPDirectoryProc(userRoutine, clientData, dirName, discriminator, features, serverHint)		\
		(*(userRoutine))((clientData), (dirName), (discriminator), (features), (serverHint))
#define CallForEachDNodeAccessControlProc(userRoutine, clientData, dsObj, activeDnodeAccMask, defaultRecordAccMask, defaultAttributeAccMask)		\
		(*(userRoutine))((clientData), (dsObj), (activeDnodeAccMask), (defaultRecordAccMask), (defaultAttributeAccMask))
#define CallForEachRecordAccessControlProc(userRoutine, clientData, dsObj, activeDnodeAccMask, activeRecordAccMask, defaultAttributeAccMask)		\
		(*(userRoutine))((clientData), (dsObj), (activeDnodeAccMask), (activeRecordAccMask), (defaultAttributeAccMask))
#define CallForEachAttributeAccessControlProc(userRoutine, clientData, dsObj, activeDnodeAccMask, activeRecordAccMask, activeAttributeAccMask)		\
		(*(userRoutine))((clientData), (dsObj), (activeDnodeAccMask), (activeRecordAccMask), (activeAttributeAccMask))
#define CallDSAMDirProc(userRoutine, dsamData, paramBlock, async)		\
		(*(userRoutine))((dsamData), (paramBlock), (async))
#define CallDSAMDirParseProc(userRoutine, dsamData, paramBlock, async)		\
		(*(userRoutine))((dsamData), (paramBlock), (async))
#define CallDSAMAuthProc(userRoutine, dsamData, pb, async)		\
		(*(userRoutine))((dsamData), (pb), (async))
#endif

#if GENERATINGCFM
#define NewAuthIOCompletionProc(userRoutine)		\
		(AuthIOCompletionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppAuthIOCompletionProcInfo, GetCurrentArchitecture())
#define NewNotificationProc(userRoutine)		\
		(NotificationUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppNotificationProcInfo, GetCurrentArchitecture())
#define NewDirIOCompletionProc(userRoutine)		\
		(DirIOCompletionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDirIOCompletionProcInfo, GetCurrentArchitecture())
#define NewForEachDirEnumSpecProc(userRoutine)		\
		(ForEachDirEnumSpecUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachDirEnumSpecProcInfo, GetCurrentArchitecture())
#define NewForEachRecordProc(userRoutine)		\
		(ForEachRecordUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachRecordProcInfo, GetCurrentArchitecture())
#define NewForEachLookupRecordIDProc(userRoutine)		\
		(ForEachLookupRecordIDUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachLookupRecordIDProcInfo, GetCurrentArchitecture())
#define NewForEachAttrTypeLookupProc(userRoutine)		\
		(ForEachAttrTypeLookupUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachAttrTypeLookupProcInfo, GetCurrentArchitecture())
#define NewForEachAttrValueProc(userRoutine)		\
		(ForEachAttrValueUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachAttrValueProcInfo, GetCurrentArchitecture())
#define NewForEachAttrTypeProc(userRoutine)		\
		(ForEachAttrTypeUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachAttrTypeProcInfo, GetCurrentArchitecture())
#define NewForEachRecordIDProc(userRoutine)		\
		(ForEachRecordIDUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachRecordIDProcInfo, GetCurrentArchitecture())
#define NewForEachDirectoryProc(userRoutine)		\
		(ForEachDirectoryUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachDirectoryProcInfo, GetCurrentArchitecture())
#define NewForEachADAPDirectoryProc(userRoutine)		\
		(ForEachADAPDirectoryUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachADAPDirectoryProcInfo, GetCurrentArchitecture())
#define NewForEachDNodeAccessControlProc(userRoutine)		\
		(ForEachDNodeAccessControlUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachDNodeAccessControlProcInfo, GetCurrentArchitecture())
#define NewForEachRecordAccessControlProc(userRoutine)		\
		(ForEachRecordAccessControlUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachRecordAccessControlProcInfo, GetCurrentArchitecture())
#define NewForEachAttributeAccessControlProc(userRoutine)		\
		(ForEachAttributeAccessControlUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppForEachAttributeAccessControlProcInfo, GetCurrentArchitecture())
#define NewDSAMDirProc(userRoutine)		\
		(DSAMDirUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDSAMDirProcInfo, GetCurrentArchitecture())
#define NewDSAMDirParseProc(userRoutine)		\
		(DSAMDirParseUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDSAMDirParseProcInfo, GetCurrentArchitecture())
#define NewDSAMAuthProc(userRoutine)		\
		(DSAMAuthUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDSAMAuthProcInfo, GetCurrentArchitecture())
#else
#define NewAuthIOCompletionProc(userRoutine)		\
		((AuthIOCompletionUPP) (userRoutine))
#define NewNotificationProc(userRoutine)		\
		((NotificationUPP) (userRoutine))
#define NewDirIOCompletionProc(userRoutine)		\
		((DirIOCompletionUPP) (userRoutine))
#define NewForEachDirEnumSpecProc(userRoutine)		\
		((ForEachDirEnumSpecUPP) (userRoutine))
#define NewForEachRecordProc(userRoutine)		\
		((ForEachRecordUPP) (userRoutine))
#define NewForEachLookupRecordIDProc(userRoutine)		\
		((ForEachLookupRecordIDUPP) (userRoutine))
#define NewForEachAttrTypeLookupProc(userRoutine)		\
		((ForEachAttrTypeLookupUPP) (userRoutine))
#define NewForEachAttrValueProc(userRoutine)		\
		((ForEachAttrValueUPP) (userRoutine))
#define NewForEachAttrTypeProc(userRoutine)		\
		((ForEachAttrTypeUPP) (userRoutine))
#define NewForEachRecordIDProc(userRoutine)		\
		((ForEachRecordIDUPP) (userRoutine))
#define NewForEachDirectoryProc(userRoutine)		\
		((ForEachDirectoryUPP) (userRoutine))
#define NewForEachADAPDirectoryProc(userRoutine)		\
		((ForEachADAPDirectoryUPP) (userRoutine))
#define NewForEachDNodeAccessControlProc(userRoutine)		\
		((ForEachDNodeAccessControlUPP) (userRoutine))
#define NewForEachRecordAccessControlProc(userRoutine)		\
		((ForEachRecordAccessControlUPP) (userRoutine))
#define NewForEachAttributeAccessControlProc(userRoutine)		\
		((ForEachAttributeAccessControlUPP) (userRoutine))
#define NewDSAMDirProc(userRoutine)		\
		((DSAMDirUPP) (userRoutine))
#define NewDSAMDirParseProc(userRoutine)		\
		((DSAMDirParseUPP) (userRoutine))
#define NewDSAMAuthProc(userRoutine)		\
		((DSAMAuthUPP) (userRoutine))
#endif

/*************************************************************/
/*
These are the selector values used after the trap dispatch to determine just
what call the client made to my toolbox.  These bear no relationship to the
procedure numbers used in the client-to-server protocol.
*/
/* Note:  0x21C, 0x21D are used internally
 */
#define kAuthBindSpecificIdentity 0x200
#define kAuthUnbindSpecificIdentity 0x201
#define kAuthResolveCreationID 0x202
#define kAuthGetSpecificIdentityInfo 0x203
#define kAuthGetLocalIdentity 0x204
#define kAuthAddToLocalIdentityQueue 0x205
#define kAuthRemoveFromLocalIdentityQueue 0x206
#define kAuthAddKey 0x207
#define kAuthChangeKey 0x208
#define kAuthDeleteKey 0x209
#define kAuthPasswordToKey 0x20A
#define kAuthGetCredentials 0x20B
#define kAuthDecryptCredentials 0x20C
#define kOCESetupRemoveDirectoryInfo 0x20D
#define kOCESetupGetDirectoryInfo 0x20E
#define kAuthMakeChallenge 0x20F
#define kAuthMakeReply 0x210
#define kAuthVerifyReply 0x211
#define kAuthMakeProxy 0x212
#define kAuthTradeProxyForCredentials 0x213
#define kAuthUnlockLocalIdentity 0x214
#define kAuthLockLocalIdentity 0x215
#define kAuthSetupLocalIdentity 0x216
#define kAuthChangeLocalIdentity 0x217
#define kAuthRemoveLocalIdentity 0x218
#define kOCESetupAddDirectoryInfo 0x219
#define kAuthGetUTCTime 0x21A
#define kOCESetupChangeDirectoryInfo 0x21B
#define kDirEnumerateParse 0x101
#define kDirLookupParse 0x102
#define kDirEnumerateAttributeTypesParse 0x103
#define kDirEnumeratePseudonymParse 0x104
#define kDirNetSearchADAPDirectoriesParse 0x105
#define kDirEnumerateDirectoriesParse 0x106
#define kDirFindADAPDirectoryByNetSearch 0x107
#define kDirNetSearchADAPDirectoriesGet 0x108
#define kDirAddRecord 0x109
#define kDirDeleteRecord 0x10A
#define kDirAddAttributeValue 0x10B
#define kDirDeleteAttributeValue 0x10C
#define kDirChangeAttributeValue 0x10D
#define kDirVerifyAttributeValue 0x10E
#define kDirAddPseudonym 0x10F
#define kDirDeletePseudonym 0x110
#define kDirEnumerateGet 0x111
#define kDirEnumerateAttributeTypesGet 0x112
#define kDirEnumeratePseudonymGet 0x113
#define kDirGetNameAndType 0x114
#define kDirSetNameAndType 0x115
#define kDirGetRecordMetaInfo 0x116
#define kDirLookupGet 0x117
#define kDirGetDNodeMetaInfo 0x118
#define kDirGetDirectoryInfo 0x119
#define kDirEnumerateDirectoriesGet 0x11A
#define kDirAbort 0x11B
#define kDirAddAlias 0x11C
#define kDirAddDSAM 0x11D
#define kDirOpenPersonalDirectory 0x11E
#define kDirCreatePersonalDirectory 0x11F
#define kDirRemoveDSAM 0x120
#define kDirGetDirectoryIcon 0x121
#define kDirMapPathNameToDNodeNumber 0x122
#define kDirMapDNodeNumberToPathName 0x123
#define kDirGetLocalNetworkSpec 0x124
#define kDirGetDNodeInfo 0x125
#define kDirFindValue 0x126
#define kDirInstantiateDSAM 0x127
#define kDirGetOCESetupRefNum 0x128
#define kDirGetDNodeAccessControlGet 0x12A
#define kDirGetRecordAccessControlGet 0x12C
#define kDirGetAttributeAccessControlGet 0x12E
#define kDirGetDNodeAccessControlParse 0x12F
#define kDirDeleteAttributeType 0x130
#define kDirClosePersonalDirectory 0x131
#define kDirMakePersonalDirectoryRLI 0x132
#define kDirAddDSAMDirectory 0x133
#define kDirGetRecordAccessControlParse 0x134
#define kDirRemoveDirectory 0x135
#define kDirGetExtendedDirectoriesInfo 0x136
#define kDirAddADAPDirectory 0x137
#define kDirGetAttributeAccessControlParse 0x138
#define kDirFindRecordGet 0x140
#define kDirFindRecordParse 0x141
extern pascal OSErr AuthBindSpecificIdentity(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x200, 0xAA5E);
extern pascal OSErr AuthUnbindSpecificIdentity(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x201, 0xAA5E);
extern pascal OSErr AuthResolveCreationID(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x202, 0xAA5E);
extern pascal OSErr AuthGetSpecificIdentityInfo(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x203, 0xAA5E);
extern pascal OSErr AuthAddKey(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x207, 0xAA5E);
extern pascal OSErr AuthChangeKey(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x208, 0xAA5E);
extern pascal OSErr AuthDeleteKey(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x209, 0xAA5E);
extern pascal OSErr AuthPasswordToKey(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x20A, 0xAA5E);
extern pascal OSErr AuthGetCredentials(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x20B, 0xAA5E);
extern pascal OSErr AuthDecryptCredentials(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x20C, 0xAA5E);
extern pascal OSErr AuthMakeChallenge(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x20F, 0xAA5E);
extern pascal OSErr AuthMakeReply(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x210, 0xAA5E);
extern pascal OSErr AuthVerifyReply(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x211, 0xAA5E);
extern pascal OSErr AuthGetUTCTime(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x21A, 0xAA5E);
extern pascal OSErr AuthMakeProxy(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x212, 0xAA5E);
extern pascal OSErr AuthTradeProxyForCredentials(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x213, 0xAA5E);
/* Local Identity API */
extern pascal OSErr AuthGetLocalIdentity(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x204, 0xAA5E);
extern pascal OSErr AuthUnlockLocalIdentity(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x214, 0xAA5E);
extern pascal OSErr AuthLockLocalIdentity(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x215, 0xAA5E);
extern pascal OSErr AuthAddToLocalIdentityQueue(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x205, 0xAA5E);
extern pascal OSErr AuthRemoveFromLocalIdentityQueue(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x206, 0xAA5E);
extern pascal OSErr AuthSetupLocalIdentity(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x216, 0xAA5E);
extern pascal OSErr AuthChangeLocalIdentity(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x217, 0xAA5E);
extern pascal OSErr AuthRemoveLocalIdentity(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x218, 0xAA5E);
extern pascal OSErr DirAddRecord(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x109, 0xAA5E);
extern pascal OSErr DirDeleteRecord(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x10A, 0xAA5E);
extern pascal OSErr DirEnumerateGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x111, 0xAA5E);
extern pascal OSErr DirEnumerateParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x101, 0xAA5E);
extern pascal OSErr DirFindRecordGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x140, 0xAA5E);
extern pascal OSErr DirFindRecordParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x141, 0xAA5E);
extern pascal OSErr DirLookupGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x117, 0xAA5E);
extern pascal OSErr DirLookupParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x102, 0xAA5E);
extern pascal OSErr DirAddAttributeValue(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x10B, 0xAA5E);
extern pascal OSErr DirDeleteAttributeValue(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x10C, 0xAA5E);
extern pascal OSErr DirDeleteAttributeType(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x130, 0xAA5E);
extern pascal OSErr DirChangeAttributeValue(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x10D, 0xAA5E);
extern pascal OSErr DirVerifyAttributeValue(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x10E, 0xAA5E);
extern pascal OSErr DirFindValue(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x126, 0xAA5E);
extern pascal OSErr DirEnumerateAttributeTypesGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x112, 0xAA5E);
extern pascal OSErr DirEnumerateAttributeTypesParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x103, 0xAA5E);
extern pascal OSErr DirAddPseudonym(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x10F, 0xAA5E);
extern pascal OSErr DirDeletePseudonym(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x110, 0xAA5E);
extern pascal OSErr DirAddAlias(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x11C, 0xAA5E);
extern pascal OSErr DirEnumeratePseudonymGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x113, 0xAA5E);
extern pascal OSErr DirEnumeratePseudonymParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x104, 0xAA5E);
extern pascal OSErr DirGetNameAndType(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x114, 0xAA5E);
extern pascal OSErr DirSetNameAndType(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x115, 0xAA5E);
extern pascal OSErr DirGetRecordMetaInfo(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x116, 0xAA5E);
extern pascal OSErr DirGetDNodeMetaInfo(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x118, 0xAA5E);
extern pascal OSErr DirGetDirectoryInfo(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x119, 0xAA5E);
extern pascal OSErr DirGetDNodeAccessControlGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x12A, 0xAA5E);
extern pascal OSErr DirGetDNodeAccessControlParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x12F, 0xAA5E);
extern pascal OSErr DirGetRecordAccessControlGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x12C, 0xAA5E);
extern pascal OSErr DirGetRecordAccessControlParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x134, 0xAA5E);
extern pascal OSErr DirGetAttributeAccessControlGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x12E, 0xAA5E);
extern pascal OSErr DirGetAttributeAccessControlParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x138, 0xAA5E);
extern pascal OSErr DirEnumerateDirectoriesGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x11A, 0xAA5E);
extern pascal OSErr DirEnumerateDirectoriesParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x106, 0xAA5E);
extern pascal OSErr DirMapPathNameToDNodeNumber(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x122, 0xAA5E);
extern pascal OSErr DirMapDNodeNumberToPathName(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x123, 0xAA5E);
extern pascal OSErr DirGetLocalNetworkSpec(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x124, 0xAA5E);
extern pascal OSErr DirGetDNodeInfo(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x125, 0xAA5E);
/*  Trap Dispatchers for Personal Catalog and CSAM Extensions */
extern pascal OSErr DirCreatePersonalDirectory(DirParamBlockPtr paramBlock)
 FIVEWORDINLINE(0x7000, 0x1f00, 0x3F3C, 0x11F, 0xAA5E);
extern pascal OSErr DirOpenPersonalDirectory(DirParamBlockPtr paramBlock)
 FIVEWORDINLINE(0x7000, 0x1f00, 0x3F3C, 0x11E, 0xAA5E);
extern pascal OSErr DirClosePersonalDirectory(DirParamBlockPtr paramBlock)
 FIVEWORDINLINE(0x7000, 0x1f00, 0x3F3C, 0x131, 0xAA5E);
extern pascal OSErr DirMakePersonalDirectoryRLI(DirParamBlockPtr paramBlock)
 FIVEWORDINLINE(0x7000, 0x1f00, 0x3F3C, 0x132, 0xAA5E);
extern pascal OSErr DirAddDSAM(DirParamBlockPtr paramBlock)
 FIVEWORDINLINE(0x7000, 0x1f00, 0x3F3C, 0x11D, 0xAA5E);
extern pascal OSErr DirInstantiateDSAM(DirParamBlockPtr paramBlock)
 FIVEWORDINLINE(0x7000, 0x1f00, 0x3F3C, 0x127, 0xAA5E);
extern pascal OSErr DirRemoveDSAM(DirParamBlockPtr paramBlock)
 FIVEWORDINLINE(0x7000, 0x1f00, 0x3F3C, 0x120, 0xAA5E);
extern pascal OSErr DirAddDSAMDirectory(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x133, 0xAA5E);
extern pascal OSErr DirGetExtendedDirectoriesInfo(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x136, 0xAA5E);
extern pascal OSErr DirGetDirectoryIcon(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x121, 0xAA5E);
extern pascal OSErr DirAddADAPDirectory(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x137, 0xAA5E);
extern pascal OSErr DirRemoveDirectory(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x135, 0xAA5E);
extern pascal OSErr DirNetSearchADAPDirectoriesGet(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x108, 0xAA5E);
extern pascal OSErr DirNetSearchADAPDirectoriesParse(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x105, 0xAA5E);
extern pascal OSErr DirFindADAPDirectoryByNetSearch(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x107, 0xAA5E);
extern pascal OSErr DirGetOCESetupRefNum(DirParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x128, 0xAA5E);
extern pascal OSErr DirAbort(DirParamBlockPtr paramBlock)
 FIVEWORDINLINE(0x7000, 0x1f00, 0x3F3C, 0x11B, 0xAA5E);
extern pascal OSErr OCESetupAddDirectoryInfo(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x219, 0xAA5E);
extern pascal OSErr OCESetupChangeDirectoryInfo(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x21B, 0xAA5E);
extern pascal OSErr OCESetupRemoveDirectoryInfo(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x20D, 0xAA5E);
extern pascal OSErr OCESetupGetDirectoryInfo(AuthParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x20E, 0xAA5E);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __OCEAUTHDIR__ */
