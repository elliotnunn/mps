{
 	File:		OCEAuthDir.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OCEAuthDir;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCEAUTHDIR__}
{$SETC __OCEAUTHDIR__ := 1}

{$I+}
{$SETC OCEAuthDirIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	OSUtils.p													}
{		Memory.p												}

{$IFC UNDEFINED __NOTIFICATION__}
{$I Notification.p}
{$ENDC}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}

{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$IFC UNDEFINED __OCE__}
{$I OCE.p}
{$ENDC}
{	Aliases.p													}
{	Script.p													}
{		IntlResources.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kRC4KeySizeInBytes			= 8;							{ size of an RC4 key }
	kRefNumUnknown				= 0;

	kEnumDistinguishedNameBit	= 0;
	kEnumAliasBit				= 1;
	kEnumPseudonymBit			= 2;
	kEnumDNodeBit				= 3;
	kEnumInvisibleBit			= 4;

{ Values of DirEnumChoices }
	kEnumDistinguishedNameMask	= 1 * (2**(kEnumDistinguishedNameBit));
	kEnumAliasMask				= 1 * (2**(kEnumAliasBit));
	kEnumPseudonymMask			= 1 * (2**(kEnumPseudonymBit));
	kEnumDNodeMask				= 1 * (2**(kEnumDNodeBit));
	kEnumInvisibleMask			= 1 * (2**(kEnumInvisibleBit));
	kEnumAllMask				= 0+(kEnumDistinguishedNameMask + kEnumAliasMask + kEnumPseudonymMask + kEnumDNodeMask + kEnumInvisibleMask);

	
TYPE
	DirEnumChoices = LONGINT;

{ Values of DirSortOption }

CONST
	kSortByName					= 0;
	kSortByType					= 1;

{ Values of DirSortDirection }
	kSortForwards				= 0;
	kSortBackwards				= 1;

{ Values of DirMatchWith }
	kMatchAll					= 0;
	kExactMatch					= 1;
	kBeginsWith					= 2;
	kEndingWith					= 3;
	kContaining					= 4;

	
TYPE
	DirMatchWith = SInt8;


CONST
	kCurrentOCESortVersion		= 1;

{  Access controls are implemented on three levels:
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
 }
{ access privileges bit numbers }
	kSeeBit						= 0;
	kAddBit						= 1;
	kDeleteBit					= 2;
	kChangeBit					= 3;
	kRenameBit					= 4;
	kChangePrivsBit				= 5;
	kSeeFoldersBit				= 6;

{ Values of AccessMask }
	kSeeMask					= 0+(1 * (2**(kSeeBit)));
	kAddMask					= 0+(1 * (2**(kAddBit)));
	kDeleteMask					= 0+(1 * (2**(kDeleteBit)));
	kChangeMask					= 0+(1 * (2**(kChangeBit)));
	kRenameMask					= 0+(1 * (2**(kRenameBit)));
	kChangePrivsMask			= 0+(1 * (2**(kChangePrivsBit)));
	kSeeFoldersMask				= 0+(1 * (2**(kSeeFoldersBit)));

	kAllPrivs					= 0+(kSeeMask + kAddMask + kDeleteMask + kChangeMask + kRenameMask + kChangePrivsMask + kSeeFoldersMask);
	kNoPrivs					= 0;

{

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
}
	kSupportsDNodeNumberBit		= 0;
	kSupportsRecordCreationIDBit = 1;
	kSupportsAttributeCreationIDBit = 2;
	kSupportsMatchAllBit		= 3;
	kSupportsBeginsWithBit		= 4;
	kSupportsExactMatchBit		= 5;
	kSupportsEndsWithBit		= 6;
	kSupportsContainsBit		= 7;
	kSupportsOrderedEnumerationBit = 8;
	kCanSupportNameOrderBit		= 9;
	kCanSupportTypeOrderBit		= 10;
	kSupportSortBackwardsBit	= 11;
	kSupportIndexRatioBit		= 12;
	kSupportsEnumerationContinueBit = 13;
	kSupportsLookupContinueBit	= 14;
	kSupportsEnumerateAttributeTypeContinueBit = 15;
	kSupportsEnumeratePseudonymContinueBit = 16;
	kSupportsAliasesBit			= 17;
	kSupportsPseudonymsBit		= 18;
	kSupportsPartialPathNamesBit = 19;
	kSupportsAuthenticationBit	= 20;
	kSupportsProxiesBit			= 21;
	kSupportsFindRecordBit		= 22;

{ values of DirGestalt }
	kSupportsDNodeNumberMask	= 1 * (2**(kSupportsDNodeNumberBit));
	kSupportsRecordCreationIDMask = 1 * (2**(kSupportsRecordCreationIDBit));
	kSupportsAttributeCreationIDMask = 1 * (2**(kSupportsAttributeCreationIDBit));
	kSupportsMatchAllMask		= 1 * (2**(kSupportsMatchAllBit));
	kSupportsBeginsWithMask		= 1 * (2**(kSupportsBeginsWithBit));
	kSupportsExactMatchMask		= 1 * (2**(kSupportsExactMatchBit));
	kSupportsEndsWithMask		= 1 * (2**(kSupportsEndsWithBit));
	kSupportsContainsMask		= 1 * (2**(kSupportsContainsBit));
	kSupportsOrderedEnumerationMask = 1 * (2**(kSupportsOrderedEnumerationBit));
	kCanSupportNameOrderMask	= 1 * (2**(kCanSupportNameOrderBit));
	kCanSupportTypeOrderMask	= 1 * (2**(kCanSupportTypeOrderBit));
	kSupportSortBackwardsMask	= 1 * (2**(kSupportSortBackwardsBit));
	kSupportIndexRatioMask		= 1 * (2**(kSupportIndexRatioBit));
	kSupportsEnumerationContinueMask = 1 * (2**(kSupportsEnumerationContinueBit));
	kSupportsLookupContinueMask	= 1 * (2**(kSupportsLookupContinueBit));
	kSupportsEnumerateAttributeTypeContinueMask = 1 * (2**(kSupportsEnumerateAttributeTypeContinueBit));
	kSupportsEnumeratePseudonymContinueMask = 1 * (2**(kSupportsEnumeratePseudonymContinueBit));
	kSupportsAliasesMask		= 1 * (2**(kSupportsAliasesBit));
	kSupportsPseudonymsMask		= 1 * (2**(kSupportsPseudonymsBit));
	kSupportsPartialPathNamesMask = 1 * (2**(kSupportsPartialPathNamesBit));
	kSupportsAuthenticationMask	= 1 * (2**(kSupportsAuthenticationBit));
	kSupportsProxiesMask		= 1 * (2**(kSupportsProxiesBit));
	kSupportsFindRecordMask		= 1 * (2**(kSupportsFindRecordBit));

{ Values of AuthLocalIdentityOp }
	kAuthLockLocalIdentityOp	= 1;
	kAuthUnlockLocalIdentityOp	= 2;
	kAuthLocalIdentityNameChangeOp = 3;

{ Values of AuthLocalIdentityLockAction }
	kAuthLockPending			= 1;
	kAuthLockWillBeDone			= 2;

{ Values of AuthNotifications }
	kNotifyLockBit				= 0;
	kNotifyUnlockBit			= 1;
	kNotifyNameChangeBit		= 2;

	kNotifyLockMask				= 1 * (2**(kNotifyLockBit));
	kNotifyUnlockMask			= 1 * (2**(kNotifyUnlockBit));
	kNotifyNameChangeMask		= 1 * (2**(kNotifyNameChangeBit));

	kPersonalDirectoryFileCreator = 'kl03';
	kPersonalDirectoryFileType	= 'pabt';
	kBusinessCardFileType		= 'bust';
	kDirectoryFileType			= 'dirt';
	kDNodeFileType				= 'dnod';
	kDirsRootFileType			= 'drtt';
	kRecordFileType				= 'rcrd';

	
TYPE
	DirSortOption = INTEGER;

	DirSortDirection = INTEGER;

	AccessMask = LONGINT;

	DirGestalt = LONGINT;

	AuthLocalIdentityOp = LONGINT;

	AuthLocalIdentityLockAction = LONGINT;

	AuthNotifications = LONGINT;

	DNodeID = RECORD
		dNodeNumber:			DNodeNum;								{ dNodenumber  }
		reserved1:				LONGINT;
		name:					RStringPtr;
		reserved2:				LONGINT;
	END;

	DirEnumSpec = RECORD
		enumFlag:				DirEnumChoices;
		indexRatio:				INTEGER;								{ Approx Record Position between 1 and 100 If supported, 0 If not supported }
		CASE INTEGER OF
		0: (
			recordIdentifier:			LocalRecordID;
		   );
		1: (
			dNodeIdentifier:			DNodeID;
		   );
	END;

	DirMetaInfo = RECORD
		info:					ARRAY [0..3] OF LONGINT;
	END;

	SLRV = RECORD
		script:					ScriptCode;								{   Script code in which entries are sorted }
		language:				INTEGER;								{   Language code in which entries are sorted }
		regionCode:				INTEGER;								{   Region code in which entries are sorted }
		version:				INTEGER;								{  version of oce sorting software }
	END;

{ Catalog types and operations }
{ unique identifier for an identity }
	AuthIdentity = LONGINT;

{ Umbrella LocalIdentity }
	LocalIdentity = AuthIdentity;

{ A DES key is 8 bytes of data }
	DESKey = RECORD
		a:						LONGINT;
		b:						LONGINT;
	END;

	RC4Key = ARRAY [0..kRC4KeySizeInBytes-1] OF SignedByte;

	AuthKeyType = LONGINT;

{ key type followed by its data }
	AuthKey = RECORD
		keyType:				AuthKeyType;
		CASE INTEGER OF
		0: (
			des:						DESKey;
		   );
		1: (
			rc4:						RC4Key;
		   );
	END;

	AuthKeyPtr = ^AuthKey;

	AuthParamBlockPtr = ^AuthParamBlock;

	AuthIOCompletionProcPtr = ProcPtr;  { PROCEDURE AuthIOCompletion(paramBlock: AuthParamBlockPtr); }
	AuthIOCompletionUPP = UniversalProcPtr;

{
This header is common to all the parameter blocks.  Clients should not directly
touch any of these fields except ioCompletion.  ioCompletion is the
completion routine pointer for async calls; it is ignored for sync calls.
ioResult is the result code from the call.
}
{****************************************************************************


		Authentication Manager operations 

****************************************************************************}
{
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
}
	AuthResolveCreationIDPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{  --> OCE name(Record) of the user }
		bufferLength:			LONGINT;								{  --> Buffer Size to hold duplicate Info }
		buffer:					Ptr;									{  --> Buffer  to hold duplicate Info }
		totalMatches:			LONGINT;								{ <--  Total Number of matching names found }
		actualMatches:			LONGINT;								{ <--  Number of matches returned in the buffer }
	END;

{
kAuthBindSpecificIdentity:
userRecord will contain the user information whose identity has to be
verified. userKey will contain the userKey. An Identity is returned which
binds the key and the userRecord. The identity returned can be used in the 'identity'
field in the header portion (AuthParamHeader) for authenticating the Catalog and
Authentication manager calls.
}
	AuthBindSpecificIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{ <--  binding identity }
		userRecord:				RecordIDPtr;							{  --> OCE name(Record) of the user }
		userKey:				AuthKeyPtr;								{  --> OCE Key for the user }
	END;

{
kAuthUnbindSpecificIdentity:
This call will unbind the userRecord and key which were bind earlier.
}
	AuthUnbindSpecificIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{  --> identity to be deleted }
	END;

{
kAuthGetSpecificIdentityInfo:
This call will return the userRecord for the given identity. Note: key is not
returned because this would compromise security.
}
	AuthGetSpecificIdentityInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{  --> identity of initiator }
		userRecord:				RecordIDPtr;							{ <--  OCE name(Record) of the user }
	END;

{
kAuthAddKey:
userRecord will contain the user information whose identity has to be
created. userKey will point to the key to be created. password points to
an RString containing the password used to generate the key.
}
	AuthAddKeyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{  --> OCE name(Record) of the user }
		userKey:				AuthKeyPtr;								{ <--  OCE Key for the user }
		password:				RStringPtr;								{  --> Pointer to password string }
	END;

{
kAuthChangeKey:
userRecord will contain the user information whose identity has to be
created. userKey will point to the key to be created. password points to
an RString containing the password used to generate the key.
}
	AuthChangeKeyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{  --> OCE name(Record) of the user }
		userKey:				AuthKeyPtr;								{ <--  New OCE Key for the user }
		password:				RStringPtr;								{  -->Pointer to the new password string }
	END;

{
AuthDeleteKey:
userRecord will contain the user information whose Key has to be deleted.
}
	AuthDeleteKeyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{  --> OCE name(Record) of the user }
	END;

{ AuthPasswordToKey: Converts an RString into a key. }
	AuthPasswordToKeyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userRecord:				RecordIDPtr;							{  --> OCE name(Record) of the user }
		key:					AuthKeyPtr;								{ <--  }
		password:				RStringPtr;								{  -->Pointer to the new password string }
	END;

{
kAuthGetCredentials:
userRecord will contain the user information whose identity has to be
kMailDeletedMask. keyType (e.g. asDESKey) will indicate what type of key has to
be deleted.
}
	AuthGetCredentialsPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{  --> identity of initiator }
		recipient:				RecordIDPtr;							{  --> OCE name of recipient }
		sessionKey:				AuthKeyPtr;								{ <--  session key }
		expiry:					UTCTime;								{ <--> desired/actual expiry }
		credentialsLength:		LONGINT;								{ <--> max/actual credentials size }
		credentials:			Ptr;									{ <--  buffer where credentials are returned }
	END;

{
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
}
	AuthDecryptCredentialsPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{  --> user's Identity }
		initiatorRecord:		RecordIDPtr;							{ <--  OCE name of the initiator }
		sessionKey:				AuthKeyPtr;								{ <--  session key }
		expiry:					UTCTime;								{ <--  credentials expiry time }
		credentialsLength:		LONGINT;								{  --> actual credentials size }
		credentials:			Ptr;									{  --> credentials to be decrypted }
		issueTime:				UTCTime;								{ <--  credentials expiry time }
		hasIntermediary:		BOOLEAN;								{ <--  if true, An intermediary Record was found in credentials }
		filler1:				BOOLEAN;
		intermediary:			RecordIDPtr;							{ <--  recordID of the intermediary }
	END;

	AuthMakeChallengePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		key:					AuthKeyPtr;								{  --> UnEncrypted SessionKey }
		challenge:				Ptr;									{ <--  Encrypted Challenge }
		challengeBufferLength:	LONGINT;								{  ->length of challenge buffer }
		challengeLength:		LONGINT;								{  <-length of Encrypted Challenge }
	END;

	AuthMakeReplyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		key:					AuthKeyPtr;								{  --> UnEncrypted SessionKey }
		challenge:				Ptr;									{  --> Encrypted Challenge }
		reply:					Ptr;									{ <--  Encrypted Reply }
		replyBufferLength:		LONGINT;								{  -->length of challenge buffer }
		challengeLength:		LONGINT;								{  --> length of Encrypted Challenge }
		replyLength:			LONGINT;								{ <--  length of Encrypted Reply }
	END;

	AuthVerifyReplyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		key:					AuthKeyPtr;								{  --> UnEncrypted SessionKey }
		challenge:				Ptr;									{  --> Encrypted Challenge }
		reply:					Ptr;									{  --> Encrypted Reply }
		challengeLength:		LONGINT;								{  --> length of Encrypted Challenge }
		replyLength:			LONGINT;								{  --> length of Encrypted Reply }
	END;

{
kAuthGetUTCTime:
RLI will contain a valid RLI for a cluster server.
UTC(GMT) time from one of the cluster server will be returned.
An 'offSet' from UTC(GMT) to Mac Local Time will also be returned.
If RLI is nil Map DA is used to determine UTC(GMT).
Mac Local Time = theUTCTime + theUTCOffset.
}
	AuthGetUTCTimePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{  --> packed RLI of the Node, whose server's UTC is requested }
		theUTCTime:				UTCTime;								{ <--  current UTC(GMT) Time utc seconds since 1/1/1904 }
		theUTCOffset:			UTCOffset;								{ <--  offset from UTC(GMT) seconds EAST of Greenwich }
	END;

{
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
}
	AuthMakeProxyPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{  --> identity of principal }
		recipient:				RecordIDPtr;							{  --> OCE name of recipient }
		firstValid:				UTCTime;								{  --> time at which proxy becomes valid }
		expiry:					UTCTime;								{  --> time at which proxy expires }
		authDataLength:			LONGINT;								{  --> size of authorization data }
		authData:				Ptr;									{  --> pointer to authorization data }
		proxyLength:			LONGINT;								{ <--> max/actual proxy size }
		proxy:					Ptr;									{ <--> buffer where proxy is returned }
		intermediary:			RecordIDPtr;							{  --> RecordID of intermediary }
	END;

{
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
}
	AuthTradeProxyForCredentialsPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		userIdentity:			AuthIdentity;							{  --> identity of intermediary }
		recipient:				RecordIDPtr;							{  --> OCE name of recipient }
		sessionKey:				AuthKeyPtr;								{ <--  session key }
		expiry:					UTCTime;								{ <--> desired/actual expiry }
		credentialsLength:		LONGINT;								{ <--> max/actual credentials size }
		credentials:			Ptr;									{ <--> buffer where credentials are returned }
		proxyLength:			LONGINT;								{  --> actual proxy size }
		proxy:					Ptr;									{  --> buffer containing proxy }
		principal:				RecordIDPtr;							{  --> RecordID of principal }
	END;

{ API for Local Identity Interface }
{
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
}
	AuthGetLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		theLocalIdentity:		LocalIdentity;							{ <--  LocalIdentity }
	END;

{
kAuthUnlockLocalIdentity:
The LocalIdentity can be created using this call.
The userName and password correspond to the LocalIdentity setup.
If the password matches, then collabIdentity will be returned.
Typically SDPPromptForLocalIdentity call will make this call.
All applications which are registered through kAuthAddToLocalIdentityQueue
will be notified.
}
	AuthUnlockLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		theLocalIdentity:		LocalIdentity;							{ <--  LocalIdentity }
		userName:				RStringPtr;								{  --> userName }
		password:				RStringPtr;								{  -->user password }
	END;

{
kAuthLockLocalIdentity:
With this call existing LocalIdentity can be locked. If the ASDeleteLocalIdetity
call fails with 'kOCEOperationDenied' error, name will contain the application which
denied the operation. This name will be supplied by the application
when it registered through kAuthAddToLocalIdentityQueue call
}
	AuthLockLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		theLocalIdentity:		LocalIdentity;							{  --> LocalIdentity }
		name:					StringPtr;								{ <--  name of the app which denied delete }
	END;

	NotificationProcPtr = ProcPtr;  { FUNCTION Notification(clientData: LONGINT; callValue: AuthLocalIdentityOp; actionValue: AuthLocalIdentityLockAction; identity: LocalIdentity): BOOLEAN; }
	NotificationUPP = UniversalProcPtr;

	NotificationProc = NotificationUPP;

{
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
}
	AuthAddToLocalIdentityQueuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		notifyProc:				NotificationUPP;						{  --> notification procedure }
		notifyFlags:			AuthNotifications;						{  --> notifyFlags }
		appName:				StringPtr;								{  --> name of application to be returned in Delete/Stop }
	END;

{
kAuthRemoveFromLocalIdentityQueue:}
	AuthRemoveFromLocalIdentityQueuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		notifyProc:				NotificationUPP;						{  --> notification procedure }
	END;

{
kAuthSetupLocalIdentity:
The LocalIdentity can be Setup using this call.
The userName and password correspond to the LocalIdentity setup.
If a LocalIdentity Setup already exists 'kOCELocalIdentitySetupExists' error
will be returned.
}
	AuthSetupLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aReserved:				LONGINT;								{  --  }
		userName:				RStringPtr;								{  --> userName }
		password:				RStringPtr;								{  -->user password }
	END;

{
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

}
	AuthChangeLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aReserved:				LONGINT;								{  --  }
		userName:				RStringPtr;								{  --> userName }
		password:				RStringPtr;								{  --> current password }
		newPassword:			RStringPtr;								{  --> new password }
	END;

{
kAuthRemoveLocalIdentity:
An existing LocalIdentity  Setup can be removed using this call.
The userName and password correspond to the LocalIdentity setup.
If a LocalIdentity Setup does not exists 'kOCEOCESetupRequired' error
will be returned.
If the 'password' does not correspond to the existing setup, 'kOCELocalAuthenticationFail'
OSErr will be returned. If successful, LocalIdentity will be removed from the OCE Setup.
This is a very distructive operation, user must be warned enough before actually making
this call.
}
	AuthRemoveLocalIdentityPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aReserved:				LONGINT;								{  --  }
		userName:				RStringPtr;								{  --> userName }
		password:				RStringPtr;								{  --> current password }
	END;

{
kOCESetupAddDirectoryInfo:
Using this call identity for a catalog can be setup under LocalIdentity umbrella.
ASCreateLocalIdentity should have been done succesfully before making this call.
directoryRecordCID -> is the record creationID obtained when DirAddOCEDirectory or
DirAddDSAMDirectory call was made.
rid-> is the recordID in which the identity for the catalog will be established.
password-> the password associated with the rid in the catalog world.
}
	OCESetupAddDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryRecordCID:		CreationID;								{  --> CreationID for the catalog }
		recordID:				RecordIDPtr;							{  --> recordID for the identity }
		password:				RStringPtr;								{  --> password in the catalog world }
	END;

{
kOCESetupChangeDirectoryInfo:
Using this call an existing identity for a catalog under LocalIdentity umbrella
can be changed.
ASCreateLocalIdentity should have been done succesfully before making this call.
directoryRecordCID -> is the record creationID obtained when DirAddOCEDirectory or
DirAddDSAMDirectory call was made.
rid-> is the recordID in which the identity for the catalog will be established.
password-> the password associated with the rid in the catalog world.
newPassword -> the new password for the catalog
}
	OCESetupChangeDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryRecordCID:		CreationID;								{  --> CreationID for the catalog }
		recordID:				RecordIDPtr;							{  --> recordID for the identity }
		password:				RStringPtr;								{  --> password in the catalog world }
		newPassword:			RStringPtr;								{  --> new password in the catalog }
	END;

{
kOCESetupRemoveDirectoryInfo:
Using this call an existing identity for a catalog under LocalIdentity umbrella
can be changed.
ASCreateLocalIdentity should have been done succesfully before making this call.
directoryRecordCID -> is the record creationID obtained when DirAddOCEDirectory or
}
	OCESetupRemoveDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryRecordCID:		CreationID;								{  --> CreationID for the catalog }
	END;

{
kOCESetupGetDirectoryInfo:
Using this call info on an existing identity for a particular catalog under LocalIdentity umbrella
can be obtained.
For the specified catalog 'directoryName' and 'discriminator', rid and nativeName will
returned. Caller must provide appropriate buffer to get back rid and nativeName.
'password' will be returned  for  non-ADAP Catalogs.
}
	OCESetupGetDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			AuthIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{  --> catalog name }
		discriminator:			DirDiscriminator;						{  --> discriminator for the catalog }
		recordID:				RecordIDPtr;							{ <--  rid for the catalog identity }
		nativeName:				RStringPtr;								{ <--  user name in the catalog world }
		password:				RStringPtr;								{ <--  password in the catalog world }
	END;

{****************************************************************************


 		Catalog Manager operations


****************************************************************************}
	DirParamBlockPtr = ^DirParamBlock;

	DirIOCompletionProcPtr = ProcPtr;  { PROCEDURE DirIOCompletion(paramBlock: DirParamBlockPtr); }
	DirIOCompletionUPP = UniversalProcPtr;

{ AddRecord }
	DirAddRecordPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> CreationID returned here }
		allowDuplicate:			BOOLEAN;								{  --> }
		filler1:				BOOLEAN;
	END;

{ DeleteRecord }
	DirDeleteRecordPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> }
	END;

{ aRecord must contain valid PackedRLI and a CreationID. }
{********************************************************************************}
{
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
}
	DirEnumerateGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRLI:					PackedRLIPtr;							{  --> an RLI specifying the cluster to be enumerated }
		startingPoint:			^DirEnumSpec;							{  --> }
		sortBy:					DirSortOption;							{  --> }
		sortDirection:			DirSortDirection;						{  --> }
		dReserved:				LONGINT;								{  --  }
		nameMatchString:		RStringPtr;								{  --> name from which enumeration should start }
		typesList:				^RStringPtr;							{  --> list of entity types to be enumerated }
		typeCount:				LONGINT;								{  --> number of types in the list }
		enumFlags:				DirEnumChoices;							{  --> indicates what to enumerate }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the record specified in starting point }
		padByte:				SInt8; (* Byte *)
		matchNameHow:			DirMatchWith;							{  --> Matching Criteria for nameMatchString }
		matchTypeHow:			DirMatchWith;							{  --> Matching Criteria for typeList }
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
		responseSLRV:			SLRV;									{  <--  response SLRV }
	END;

{ The EnumerateRecords call-back function is defined as follows: }
	ForEachDirEnumSpecProcPtr = ProcPtr;  { FUNCTION ForEachDirEnumSpec(clientData: LONGINT; (CONST)VAR enumSpec: DirEnumSpec): BOOLEAN; }
	ForEachDirEnumSpecUPP = UniversalProcPtr;

	ForEachDirEnumSpec = ForEachDirEnumSpecUPP;

{
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
}
	DirEnumerateParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRLI:					PackedRLIPtr;							{  --> an RLI specifying the cluster to be enumerated }
		bReserved:				LONGINT;								{  --  }
		cReserved:				LONGINT;								{  --  }
		eachEnumSpec:			ForEachDirEnumSpec;						{  --> }
		eReserved:				LONGINT;								{  --  }
		fReserved:				LONGINT;								{  --  }
		gReserved:				LONGINT;								{  --  }
		hReserved:				LONGINT;								{  --  }
		iReserved:				LONGINT;								{  --  }
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
		l1Reserved:				INTEGER;								{  -- }
		l2Reserved:				INTEGER;								{  --  }
		l3Reserved:				INTEGER;								{  -- }
		l4Reserved:				INTEGER;								{  --  }
	END;

{
 * FindRecordGet operates similarly to DirEnumerate except it returns a list
 * of records instead of records local to a cluster.
}
	DirFindRecordGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		startingPoint:			RecordIDPtr;
		reservedA:				ARRAY [0..1] OF LONGINT;
		nameMatchString:		RStringPtr;
		typesList:				^RStringPtr;
		typeCount:				LONGINT;
		reservedB:				LONGINT;
		reservedC:				INTEGER;
		matchNameHow:			DirMatchWith;
		matchTypeHow:			DirMatchWith;
		getBuffer:				Ptr;
		getBufferSize:			LONGINT;
		directoryName:			DirectoryNamePtr;
		discriminator:			DirDiscriminator;
	END;

{ The FindRecordParse call-back function is defined as follows: }
	ForEachRecordProcPtr = ProcPtr;  { FUNCTION ForEachRecord(clientData: LONGINT; (CONST)VAR enumSpec: DirEnumSpec; pRLI: PackedRLIPtr): BOOLEAN; }
	ForEachRecordUPP = UniversalProcPtr;

	ForEachRecord = ForEachRecordUPP;

{
 * This PB same as DirFindRecordGet except it includes the callback function
}
	DirFindRecordParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		startingPoint:			RecordIDPtr;
		reservedA:				ARRAY [0..1] OF LONGINT;
		nameMatchString:		RStringPtr;
		typesList:				^RStringPtr;
		typeCount:				LONGINT;
		reservedB:				LONGINT;
		reservedC:				INTEGER;
		matchNameHow:			DirMatchWith;
		matchTypeHow:			DirMatchWith;
		getBuffer:				Ptr;
		getBufferSize:			LONGINT;
		directoryName:			DirectoryNamePtr;
		discriminator:			DirDiscriminator;
		forEachRecordFunc:		ForEachRecord;
	END;

{
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
}
	DirLookupGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecordList:			^RecordIDPtr;							{  --> an array of RecordID pointers }
		attrTypeList:			^AttributeTypePtr;						{  --> an array of attribute types }
		cReserved:				LONGINT;								{  --  }
		dReserved:				LONGINT;								{  --  }
		eReserved:				LONGINT;								{  --  }
		fReserved:				LONGINT;								{  --  }
		recordIDCount:			LONGINT;								{  --> }
		attrTypeCount:			LONGINT;								{  --> }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the value specified by the starting indices }
		padByte:				SInt8; (* Byte *)
		i1Reserved:				INTEGER;								{  --  }
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
		startingRecordIndex:	LONGINT;								{  --> start from this record }
		startingAttrTypeIndex:	LONGINT;								{  --> start from this attribute type }
		startingAttribute:		Attribute;								{  --> start from this attribute value }
		pReserved:				LONGINT;								{  --  }
	END;

{ The Lookup call-back functions are defined as follows: }
	ForEachLookupRecordIDProcPtr = ProcPtr;  { FUNCTION ForEachLookupRecordID(clientData: LONGINT; (CONST)VAR recordID: RecordID): BOOLEAN; }
	ForEachLookupRecordIDUPP = UniversalProcPtr;

	ForEachLookupRecordID = ForEachLookupRecordIDUPP;

	ForEachAttrTypeLookupProcPtr = ProcPtr;  { FUNCTION ForEachAttrTypeLookup(clientData: LONGINT; (CONST)VAR attrType: AttributeType; myAttrAccMask: AccessMask): BOOLEAN; }
	ForEachAttrTypeLookupUPP = UniversalProcPtr;

	ForEachAttrTypeLookup = ForEachAttrTypeLookupUPP;

	ForEachAttrValueProcPtr = ProcPtr;  { FUNCTION ForEachAttrValue(clientData: LONGINT; (CONST)VAR attribute: Attribute): BOOLEAN; }
	ForEachAttrValueUPP = UniversalProcPtr;

	ForEachAttrValue = ForEachAttrValueUPP;

{
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
}
	DirLookupParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecordList:			^RecordIDPtr;							{  --> must be same from the corresponding Get call }
		attrTypeList:			^AttributeTypePtr;						{  --> must be same from the corresponding Get call }
		cReserved:				LONGINT;								{  --  }
		eachRecordID:			ForEachLookupRecordID;					{  --> }
		eachAttrType:			ForEachAttrTypeLookup;					{  --> }
		eachAttrValue:			ForEachAttrValue;						{  --> }
		recordIDCount:			LONGINT;								{  --> must be same from the corresponding Get call }
		attrTypeCount:			LONGINT;								{  --> must be same from the corresponding Get call }
		iReserved:				LONGINT;								{  --  }
		getBuffer:				Ptr;									{  --> must be same from the corresponding Get call}
		getBufferSize:			LONGINT;								{  --> must be same from the corresponding Get call}
		lastRecordIndex:		LONGINT;								{ <--  last RecordID processed when parse completed }
		lastAttributeIndex:		LONGINT;								{ <--  last Attribute Type processed when parse completed }
		lastAttribute:			Attribute;								{ <--  last attribute value (with this CreationID) processed when parse completed }
		attrSize:				LONGINT;								{ <--  length of the attribute we did not return }
	END;

{ AddAttributeValue }
	DirAddAttributeValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> }
		attr:					AttributePtr;							{  --> AttributeCreationID returned here }
	END;

{
aRecord must contain valid PackedRLI and a CreationID.

Instead of passing type, length, and value in three separate
fields, we take a pointer to an Attribute structure that contains
all three, and has room for the AttributeCreationNumber.
The AttributeCreationID will be returned in the attr itself.

The AttributeTag tells the catalog service that the attribute is an RString,
binary, or a RecordID.
}
{
DeleteAttributeType:
This call is provided so that an existing AttributeType can be deleted.
If any attribute values exist for this type, they will all be deleted
(if the user has access rights to delete the values) and then the attribute type
will be deleted. Otherwise dsAccessDenied error will be returned.
}
	DirDeleteAttributeTypePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> }
		attrType:				AttributeTypePtr;						{  --> }
	END;

{
	DeleteAttributeValue
}
	DirDeleteAttributeValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  -> }
		attr:					AttributePtr;							{  -> }
	END;

{
	ChangeAttributeValue:
	currentAttr ==> the attribute to be changed. For ADAS and PAB CreationID is
	                sufficient
	newAttr     ==> new value for the attribute. For ADAS and PAB 
					CreationID field will be set when
	                the call succeesfully completes
	
	aRecord     ==> must contain valid PackedRecordLocationInfo and a CreationID.


	
}
	DirChangeAttributeValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  -> }
		currentAttr:			AttributePtr;							{  -> }
		newAttr:				AttributePtr;							{  -> }
	END;

{ VerifyAttributeValue }
	DirVerifyAttributeValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> }
		attr:					AttributePtr;							{  --> }
	END;

{
aRecord must contain valid PackedRLI and a CreationID.

The attribute type and value are passed in the attribute structure.  If the
attribute CreationID is non-zero, the server will verify that an attribute with
the specified value and creation number exists in aRecord.  If the attribute
CreationID is zero, the server will verify the attribute by type and value
alone, and return the attribute CreationID in the Attribute struct if the
attribute exists.
}
{
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
}
	DirEnumerateAttributeTypesGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> }
		startingAttrType:		AttributeTypePtr;						{  --> starting point }
		cReserved:				LONGINT;								{  --  }
		dReserved:				LONGINT;								{  --  }
		eReserved:				LONGINT;								{  --  }
		fReserved:				LONGINT;								{  --  }
		gReserved:				LONGINT;								{  --  }
		hReserved:				LONGINT;								{  --  }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the attrType specified by starting point }
		padByte:				SInt8; (* Byte *)
		i1Reserved:				INTEGER;								{  --  }
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
	END;

{ The call-back function is defined as follows: }
	ForEachAttrTypeProcPtr = ProcPtr;  { FUNCTION ForEachAttrType(clientData: LONGINT; (CONST)VAR attrType: AttributeType): BOOLEAN; }
	ForEachAttrTypeUPP = UniversalProcPtr;

	ForEachAttrType = ForEachAttrTypeUPP;

{
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
}
	DirEnumerateAttributeTypesParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> Same as DirEnumerateAttributeTypesGetPB }
		bReserved:				LONGINT;								{  --  }
		cReserved:				LONGINT;								{  --  }
		dReserved:				LONGINT;								{  --  }
		eachAttrType:			ForEachAttrType;						{  --> }
		fReserved:				LONGINT;								{  --  }
		gReserved:				LONGINT;								{  --  }
		hReserved:				LONGINT;								{  --  }
		iReserved:				LONGINT;								{  --  }
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
	END;

{
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
}
	DirAbortPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pb:						^DirParamBlock;							{  --> pb for the call which must be aborted }
	END;

{
AddPseudonym:
An alternate name and type can be added to a given record. If allowDuplicate
is set the name and type will be added even if the same name and type already
exists.
}
	DirAddPseudonymPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> RecordID to which pseudonym is to be added }
		pseudonymName:			RStringPtr;								{  --> new name to be added as pseudonym }
		pseudonymType:			RStringPtr;								{  --> new name to be added as pseudonym }
		allowDuplicate:			BOOLEAN;								{  --> }
		filler1:				BOOLEAN;
	END;

{
DeletePseudonym:
An alternate name and type for a given record can be deleted.
}
	DirDeletePseudonymPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> RecordID to which pseudonym to be added }
		pseudonymName:			RStringPtr;								{  --> pseudonymName to be deleted }
		pseudonymType:			RStringPtr;								{  --> pseudonymType to be deleted }
	END;

{
	AddAlias:
	This call can be used to create an alias  record. The alias
	can be created either in the same or different cluster. ADAS will not support
	this call for this release. A new catalog capability flag 'kSupportsAlias' will indicate
	if the catalog supports this call. PAB's will support this call. For the PAB implementation,
	this call will create a record with the name and type specified an aRecord.
	This call works exactly like AddRecord.
	If 'allowDuplicate' is false and another record with same name and type already exists
	'daNoDupAllowed' error will be returned.
}
	DirAddAliasPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  -> }
		allowDuplicate:			BOOLEAN;								{  -> }
		filler1:				BOOLEAN;
	END;

{
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
}
	DirFindValuePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRLI:					PackedRLIPtr;							{  --> an RLI specifying the cluster to be enumerated }
		aRecord:				LocalRecordIDPtr;						{  --> if not nil, look only in this record }
		attrType:				AttributeTypePtr;						{  --> if not nil, look only in this attribute type }
		startingRecord:			LocalRecordIDPtr;						{  --> record in which to start searching }
		startingAttribute:		AttributePtr;							{  --> attribute in which to start searching }
		recordFound:			LocalRecordIDPtr;						{ <--  record in which data was found }
		attributeFound:			Attribute;								{ <--  attribute in which data was found }
		matchSize:				LONGINT;								{  --> length of matching bytes }
		matchingData:			Ptr;									{  --> data bytes to be matched in search }
		sortDirection:			DirSortDirection;						{  --> sort direction (forwards or backwards) }
	END;

{
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
}
	DirEnumeratePseudonymGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> }
		startingName:			RStringPtr;								{  --> }
		startingType:			RStringPtr;								{  --> }
		dReserved:				LONGINT;								{  --  }
		eReserved:				LONGINT;								{  --  }
		fReserved:				LONGINT;								{  --  }
		gReserved:				LONGINT;								{  --  }
		hReserved:				LONGINT;								{  --  }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the Pseudonym specified by starting point will be included }
		padByte:				SInt8; (* Byte *)
		i1Reserved:				INTEGER;								{  --  }
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
	END;

{ The call-back function is defined as follows: }
	ForEachRecordIDProcPtr = ProcPtr;  { FUNCTION ForEachRecordID(clientData: LONGINT; (CONST)VAR recordID: RecordID): BOOLEAN; }
	ForEachRecordIDUPP = UniversalProcPtr;

	ForEachRecordID = ForEachRecordIDUPP;

{
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
}
	DirEnumeratePseudonymParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> same as DirEnumerateAliasesGetPB }
		bReserved:				LONGINT;								{  --  }
		cReserved:				LONGINT;								{  --  }
		eachRecordID:			ForEachRecordID;						{  --> }
		eReserved:				LONGINT;								{  --  }
		fReserved:				LONGINT;								{  --  }
		gReserved:				LONGINT;								{  --  }
		hReserved:				LONGINT;								{  --  }
		iReserved:				LONGINT;								{  --  }
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
	END;

{ GetNameAndType }
	DirGetNameAndTypePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> }
	END;

{
aRecord must contain valid RLI and a CreationID.  It
must also contain pointers to maximum-length RStrings (name and type fields)
in which will be returned the record's distinguished name and type.
}
{
SetNameAndType:
This call can be used to change a name and type for a record. The record
to be renamed is specified using 'aRecord'.
'newName' and 'newType' indicate the name and type to be set.
'allowDuplicate' if true indicates that name is to be set even if another
name and type exactly matches the newName and newType specified.

'newName' and 'newType' are required since the catalogs not supporting
CreationID require name and type fields in the recordID to identify a given
record.
}
	DirSetNameAndTypePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> }
		allowDuplicate:			BOOLEAN;								{  --> }
		padByte:				SInt8; (* Byte *)
		newName:				RStringPtr;								{  --> new name for the record }
		newType:				RStringPtr;								{  --> new type for the record }
	END;

{
DirGetMetaRecordInfo: This call can be made to obtain
the MetaRecordInfo for a given record. Information returned
is 16 bytes of OPAQUE information about the record.
}
	DirGetRecordMetaInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  --> }
		metaInfo:				DirMetaInfo;							{ <--  }
	END;

{
DirGetDNodeMetaInfo: This call can be made to obtain
the DNodeMetaInfo for a given Packed RLI. Information returned
is 16 bytes of OPAQUE information about the DNode.
}
	DirGetDNodeMetaInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{  --> }
		metaInfo:				DirMetaInfo;							{ <--  }
	END;

{
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
}
	DirEnumerateDirectoriesGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryKind:			OCEDirectoryKind;						{  --> enumerate catalogs bearing this signature }
		startingDirectoryName:	DirectoryNamePtr;						{  --> staring catalog name }
		startingDirDiscriminator: DirDiscriminator;						{  --> staring catalog discriminator }
		eReserved:				LONGINT;								{  --  }
		fReserved:				LONGINT;								{  --  }
		gReserved:				LONGINT;								{  --  }
		hReserved:				LONGINT;								{  --  }
		includeStartingPoint:	BOOLEAN;								{  --> if true return the catalog specified by starting point }
		padByte:				SInt8; (* Byte *)
		i1Reserved:				INTEGER;								{  --  }
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
	END;

	ForEachDirectoryProcPtr = ProcPtr;  { FUNCTION ForEachDirectory(clientData: LONGINT; (CONST)VAR dirName: DirectoryName; (CONST)VAR discriminator: DirDiscriminator; features: DirGestalt): BOOLEAN; }
	ForEachDirectoryUPP = UniversalProcPtr;

	ForEachDirectory = ForEachDirectoryUPP;

{
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
}
	DirEnumerateDirectoriesParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aReserved:				LONGINT;								{  --  }
		bReserved:				LONGINT;								{  --  }
		cReserved:				LONGINT;								{  --  }
		dReserved:				LONGINT;								{  --  }
		eachDirectory:			ForEachDirectory;						{  --> }
		fReserved:				LONGINT;								{  --  }
		gReserved:				LONGINT;								{  --  }
		hReserved:				LONGINT;								{  --  }
		iReserved:				LONGINT;								{  --  }
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
	END;

{
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
}
{
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
}
	DirNetSearchADAPDirectoriesGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
		cReserved:				LONGINT;								{  --  }
	END;

	ForEachADAPDirectoryProcPtr = ProcPtr;  { FUNCTION ForEachADAPDirectory(clientData: LONGINT; (CONST)VAR dirName: DirectoryName; (CONST)VAR discriminator: DirDiscriminator; features: DirGestalt; serverHint: AddrBlock): BOOLEAN; }
	ForEachADAPDirectoryUPP = UniversalProcPtr;

	ForEachADAPDirectory = ForEachADAPDirectoryUPP;

{
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
}
	DirNetSearchADAPDirectoriesParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		getBuffer:				Ptr;									{  --> }
		getBufferSize:			LONGINT;								{  --> }
		eachADAPDirectory:		ForEachADAPDirectory;					{  --> }
	END;

{
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
}
	DirFindADAPDirectoryByNetSearchPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{  --> catalog name }
		discriminator:			DirDiscriminator;						{  --> discriminate between dup catalog names }
		addToOCESetup:			BOOLEAN;								{  --> add this catalog to OCE Setup List }
		padByte:				SInt8; (* Byte *)
		directoryRecordCID:		CreationID;								{ <--  creationID for the catalog record }
	END;

{
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
}
	DirAddADAPDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{  --> catalog name }
		discriminator:			DirDiscriminator;						{  --> discriminate between dup catalog names }
		addToOCESetup:			BOOLEAN;								{  --> add this catalog to OCE Setup }
		padByte:				SInt8; (* Byte *)
		directoryRecordCID:		CreationID;								{ <--  creationID for the catalog record }
	END;

{
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
}
	DirGetDirectoryInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{  --> catalog name }
		discriminator:			DirDiscriminator;						{ <--> descriminate between dup catalog names }
		features:				DirGestalt;								{ <--  capability bit flags }
	END;

{
 * Note on Access Controls:
 * Access control is based on a list model.
 * You can get access controls list which gives dsObject and accMask for each dsObject.
 * GetAccessControl can be limited to currently supplied identity by setting forCurrentUserOnly.
 * There are special DSObjects are defined in ADASTypes.h for each of the category
 * supported in ADAS Catalogs. (kOwner, kFriends, kAuthenticatedToCluster, 
 * kAuthenticatedToDirectory, kGuest) and DUGetActlDSSpec call can be used
 * to obtain appropraiate DSSpec before making set calls to ADAS catalogs.
 *
 }
{
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

}
	DirGetDNodeAccessControlGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{  -> RLI of the cluster whose access control list is sought  }
		bReserved:				LONGINT;								{  -- unused }
		cReserved:				LONGINT;								{  -- unused }
		dReserved:				LONGINT;								{  -- unused }
		eResreved:				LONGINT;								{ --> }
		forCurrentUserOnly:		BOOLEAN;								{ -->  }
		filler1:				BOOLEAN;
		startingPoint:			^DSSpec;								{ --> starting Point }
		includeStartingPoint:	BOOLEAN;								{  -> if true return the DsObject 
																specified in starting point }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{	-> }
		getBufferSize:			LONGINT;								{  -> }
	END;

{ The Access Control call-back function is defined as follows: }
	ForEachDNodeAccessControlProcPtr = ProcPtr;  { FUNCTION ForEachDNodeAccessControl(clientData: LONGINT; (CONST)VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; defaultRecordAccMask: AccessMask; defaultAttributeAccMask: AccessMask): BOOLEAN; }
	ForEachDNodeAccessControlUPP = UniversalProcPtr;

	ForEachDNodeAccessControl = ForEachDNodeAccessControlUPP;

{
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


}
	DirGetDNodeAccessControlParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{  -> RLI of the cluster  }
		bReserved:				LONGINT;								{  -- unused }
		cReserved:				LONGINT;								{  -- unused }
		dReserved:				LONGINT;								{  -- unused }
		eachObject:				ForEachDNodeAccessControl;				{ --> }
		forCurrentUserOnly:		BOOLEAN;								{ -->  }
		filler1:				BOOLEAN;
		startingPoint:			^DSSpec;								{ --> starting Point }
		includeStartingPoint:	BOOLEAN;								{  -> if true return the record 
														specified in starting point }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{	-> }
		getBufferSize:			LONGINT;								{  -> }
	END;

{
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

}
	DirGetRecordAccessControlGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  -> RecordID to which access control list is sought list is sought  }
		bReserved:				LONGINT;								{  -- unused }
		cReserved:				LONGINT;								{  -- unused }
		dReserved:				LONGINT;								{  -- unused }
		eResreved:				LONGINT;								{ --> }
		forCurrentUserOnly:		BOOLEAN;								{ -->  }
		filler1:				BOOLEAN;
		startingPoint:			^DSSpec;								{ --> starting Point }
		includeStartingPoint:	BOOLEAN;								{  -> if true return the DsObject 
																specified in starting point }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{	-> }
		getBufferSize:			LONGINT;								{  -> }
	END;

{ The Access Control call-back function is defined as follows: }
	ForEachRecordAccessControlProcPtr = ProcPtr;  { FUNCTION ForEachRecordAccessControl(clientData: LONGINT; (CONST)VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; activeRecordAccMask: AccessMask; defaultAttributeAccMask: AccessMask): BOOLEAN; }
	ForEachRecordAccessControlUPP = UniversalProcPtr;

	ForEachRecordAccessControl = ForEachRecordAccessControlUPP;

{
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


}
	DirGetRecordAccessControlParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  -> RecordID to which access control list is sought list is sought  }
		bReserved:				LONGINT;								{  -- unused }
		cReserved:				LONGINT;								{  -- unused }
		dReserved:				LONGINT;								{  -- unused }
		eachObject:				ForEachRecordAccessControl;				{ --> }
		forCurrentUserOnly:		BOOLEAN;								{ -->  }
		filler1:				BOOLEAN;
		startingPoint:			^DSSpec;								{ --> starting Point }
		includeStartingPoint:	BOOLEAN;								{  -> if true return the record 
														specified in starting point }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{	-> }
		getBufferSize:			LONGINT;								{  -> }
	END;

{
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

}
	DirGetAttributeAccessControlGetPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  -> RecordID to which access control list is sought list is sought  }
		aType:					AttributeTypePtr;						{  -> Attribute Type to which access controls are sought          }
		cReserved:				LONGINT;								{  -- unused }
		dReserved:				LONGINT;								{  -- unused }
		eResreved:				LONGINT;								{ --> }
		forCurrentUserOnly:		BOOLEAN;								{ -->  }
		filler1:				BOOLEAN;
		startingPoint:			^DSSpec;								{ --> starting Point }
		includeStartingPoint:	BOOLEAN;								{  -> if true return the DsObject 
																specified in starting point }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{	-> }
		getBufferSize:			LONGINT;								{  -> }
	END;

{ The Access Control call-back function is defined as follows: }
	ForEachAttributeAccessControlProcPtr = ProcPtr;  { FUNCTION ForEachAttributeAccessControl(clientData: LONGINT; (CONST)VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; activeRecordAccMask: AccessMask; activeAttributeAccMask: AccessMask): BOOLEAN; }
	ForEachAttributeAccessControlUPP = UniversalProcPtr;

	ForEachAttributeAccessControl = ForEachAttributeAccessControlUPP;

{
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


}
	DirGetAttributeAccessControlParsePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		aRecord:				RecordIDPtr;							{  -> RecordID to which access control list is sought list is sought  }
		aType:					AttributeTypePtr;						{  -> Attribute Type to which access controls are sought          }
		cReserved:				LONGINT;								{  -- unused }
		dReserved:				LONGINT;								{  -- unused }
		eachObject:				ForEachAttributeAccessControl;			{ --> }
		forCurrentUserOnly:		BOOLEAN;								{ -->  }
		filler1:				BOOLEAN;
		startingPoint:			^DSSpec;								{ --> starting Point }
		includeStartingPoint:	BOOLEAN;								{  -> if true return the record 
														specified in starting point }
		filler2:				BOOLEAN;
		getBuffer:				Ptr;									{	-> }
		getBufferSize:			LONGINT;								{  -> }
	END;

{
MapPathNameToDNodeNumber:
This call maps a given PathName within a catalog to its DNodeNumber.
}
	DirMapPathNameToDNodeNumberPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{  --> catalog name }
		discriminator:			DirDiscriminator;						{  --> discriminator }
		dNodeNumber:			DNodeNum;								{ <--  dNodenumber to the path }
		path:					PackedPathNamePtr;						{  --> Path Name to be mapped }
	END;

{
PathName in the path field will be mapped to the cooresponding dNodeNumber and
returned in the DNodeNumber field. directoryName and descriminator Fields are
ignored. DSRefNum is used to identify the catalog.
}
{
MapDNodeNumberToPathName:
This call will map a given DNodeNumber with in a catalog to the
corresponding PathName.
}
	DirMapDNodeNumberToPathNamePB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{  --> catalog name }
		discriminator:			DirDiscriminator;						{  --> discriminator }
		dNodeNumber:			DNodeNum;								{  --> dNodenumber to be mapped }
		path:					PackedPathNamePtr;						{ <--  Packed Path Name returned }
		lengthOfPathName:		INTEGER;								{  --> length of packed pathName structure}
	END;

{
dNodeNumber in the DNodeNumber field will be mapped to the cooresponding
pathName and returned in the PackedPathName field.
lengthOfPathName is to be set the length of pathName structure.
If length of PackedPathName is larger then the lengthOfPathName, kOCEMoreData
OSErr will be returned.
}
{
GetLocalNetworkSpec:
This call will return the Local NetworkSpec. Client should supply
an RString big enough to hold the NetworkSpec.
}
	DirGetLocalNetworkSpecPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryName:			DirectoryNamePtr;						{  --> catalog name }
		discriminator:			DirDiscriminator;						{  --> discriminator }
		networkSpec:			NetworkSpecPtr;							{ <--  NetworkSpec }
	END;

{
PathName in the path field must be set to nil. internetName should be large
enough to hold the internetName. InterNetname returned indicates path finder's
local internet (configured by administrator).
}
{
GetDNodeInfo:
This call will return the information (internetName and descriptor)
for the given RLI of a DNode.
}
	DirGetDNodeInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{  --> packed RLI whose info is requested }
		descriptor:				DirNodeKind;							{ <--  dNode descriptor }
		networkSpec:			NetworkSpecPtr;							{ <--  cluster's networkSpec if kIsCluster }
	END;

{
If DnodeNumber is set to a non zero value, path should be set to nil.
if DnodeNumber is set to zero, pathName should point to a packed path name.
internetName should be large enough to hold
the internetName. (If the internetName is same as the one got by
GetLocalInternetName call, it indicates cluster is reachable  without
forwarders, --> Tell me if I am wrong)
}
{
DirCreatePersonalDirectory:
A new  personal catalog can be created by specifying an FSSpec for
the file. If a file already exists dupFNErr will be returned. This call is
supported 'synchronous' mode only.
}
	DirCreatePersonalDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		fsSpec:					FSSpecPtr;								{  --> FSSpec for the Personal Catalog }
		fdType:					OSType;									{  --> file type for the Personal Catalog }
		fdCreator:				OSType;									{  --> file creator for the Personal Catalog }
	END;

{
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
}
	DirOpenPersonalDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		fsSpec:					FSSpecPtr;								{  --> Open an existing Personal Catalog }
		accessRequested:		CHAR;									{  --> Open: permissions Requested(byte)}
		accessGranted:			CHAR;									{  <-- Open: permissions (byte) (Granted)}
		features:				DirGestalt;								{ <--  features for Personal Catalog }
	END;

{
DirClosePersonalDirectory: This call lets a client close AddressBook opened by DirOpenPersonalDirectory.
The Personal Catalog specified by the 'dsRefNum' will be closed.
This call is supported 'synchronous' mode only.
}
	DirClosePersonalDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
	END;

{
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
}
	DirMakePersonalDirectoryRLIPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		fromFSSpec:				FSSpecPtr;								{  --> FSSpec for creating relative alia }
		pRLIBufferSize:			INTEGER;								{  --> Length of 'pRLI' buffer }
		pRLISize:				INTEGER;								{ <--  Length of actual 'pRLI' }
		pRLI:					PackedRLIPtr;							{ <--  pRLI for the specified AddressBook }
	END;

{****************************************************************************
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

****************************************************************************}
{
DirAddDSAM: This call can be used to inorm the availability of a CSAM file
after discovering the CSAM file.
	dsamName -> is generic CSAM name e.g. Untitled X.500 directory
	dsamSignature -> could be generic CSAM kind e.g. 'X500'.
	fsSpec -> is the FileSpec for the file containing CSAM resources.
If the call is successfull 'DSAMRecordCID' will be returned. If the
call returns 'daDSAMRecordCIDExists', record was already there and
'dsamRecordCID' will be returned.
This call can be done only in synchronous mode.
}
	DirAddDSAMPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		dsamRecordCID:			CreationID;								{ <--  CreationID for the CSAM record }
		dsamName:				RStringPtr;								{  --> CSAM name }
		dsamKind:				OCEDirectoryKind;						{  --> CSAM kind }
		fsSpec:					FSSpecPtr;								{  --> FSSpec for the file containing CSAM }
	END;

{
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
}
	DSAMDirProcPtr = ProcPtr;  { FUNCTION DSAMDir(dsamData: Ptr; paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr; }
	DSAMDirUPP = UniversalProcPtr;

	DSAMDirProc = DSAMDirUPP;

	DSAMDirParseProcPtr = ProcPtr;  { FUNCTION DSAMDirParse(dsamData: Ptr; paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr; }
	DSAMDirParseUPP = UniversalProcPtr;

	DSAMDirParseProc = DSAMDirParseUPP;

	DSAMAuthProcPtr = ProcPtr;  { FUNCTION DSAMAuth(dsamData: Ptr; pb: AuthParamBlockPtr; async: BOOLEAN): OSErr; }
	DSAMAuthUPP = UniversalProcPtr;

	DSAMAuthProc = DSAMAuthUPP;

	DirInstantiateDSAMPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		dsamName:				RStringPtr;								{  --> dsamName name }
		dsamKind:				OCEDirectoryKind;						{  --> DSAMKind }
		dsamData:				Ptr;									{  --> dsamData  }
		dsamDirProc:			DSAMDirUPP;								{  --> of type DSAMDirProc: for catalog service calls }
		dsamDirParseProc:		DSAMDirParseUPP;						{  --> of type DSAMDirParseProc: for catalog service parse calls }
		dsamAuthProc:			DSAMAuthUPP;							{  --> of type DSAMAuthProc: for authetication service calls }
	END;

{
DirRemoveDSAM: This call can be used to remove  a CSAM file from the OCE Setup.
	dsamRecordCID -> is the creationID of the CSAM record.
This call can be made only in synchronous mode.
}
	DirRemoveDSAMPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		dsamRecordCID:			CreationID;								{ <--  CreationID for the CSAM record }
	END;

{
DirAddDSAMDirectory: This call can be used to inorm the availability of a CSAM catalog.
	dsamRecordCID ->  recordID for the CSAM serving this catalog
	directoryName ->  name of the catalog
	discriminator -> discriminator for the catalog
	directoryRecordCID -> If the call is successful, creationID for the record will
							be returned.
}
	DirAddDSAMDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		dsamRecordCID:			CreationID;								{  --> CreationID for the CSAM record }
		directoryName:			DirectoryNamePtr;						{  --> catalog name }
		discriminator:			DirDiscriminator;						{  --> catalog discriminator }
		features:				DirGestalt;								{  --> capabilty flags for the catalog }
		directoryRecordCID:		CreationID;								{ <--  creationID for the catalog record }
	END;

{
DirRemoveDirectory: This call can be used to inform the toolbox that
catalog specified by 'directoryRecordCID'
}
	DirRemoveDirectoryPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		directoryRecordCID:		CreationID;								{  --> creationID for the catalog record }
	END;

{
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
 * typedef struct EachDirectoryData (
 *  PackedRLI						pRLI;	       //  packed RLI for the catalog
 *  OSType							entnType; 	   //  Entn Type
 *  long							hasMailSlot;   //  If this catalog has mail slot this will be 1 otherwise zero
 *	ProtoRString					RealName;      //  Packed RString for Real Name (padded to even boundary) 
 *	ProtoRString					comment;       //  Packed RString holding any comment for Display (padded to even boundary)
 *	long                			length;        //  data length
 *	char                			data[length];  //  data padded to even boundary
 * );
 *
 *
 *
 * typedef struct myData (
 *      EachDirectoryData	data[numberOfEntries];    // data packed in the above format
 *	);
 *
 }
	DirGetExtendedDirectoriesInfoPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		buffer:					Ptr;									{  --> Pointer to a buufer where data will be returned }
		bufferSize:				LONGINT;								{  --> Length of the buffer, Length of actual data will be returned here }
		totalEntries:			LONGINT;								{ <--  Total Number of Catalogs found }
		actualEntries:			LONGINT;								{ <--  Total Number of Catalogs entries returned }
	END;

{
DirGetDirectoryIconPB: With this call a client can find out about
the icons supported by the Catalog.
Both ADAP and Personal Catalog will not support this call for now.
A CSAM can support a call so that DE Extension can use this
call to find appropriate Icons.

Returns kOCEBufferTooSmall if icon is too small, but will update iconSize.
}
	DirGetDirectoryIconPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		pRLI:					PackedRLIPtr;							{  --> packed RLI for the catalog }
		iconType:				OSType;									{  --> Type of Icon requested }
		iconBuffer:				Ptr;									{  --> Buffer to hold Icon Data }
		bufferSize:				LONGINT;								{  <-> size of buffer to hold icon data }
	END;

{
DirGetOCESetupRefNum: This call will return 'dsRefnum' for the OCE Setup Personal Catalog
and oceSetupRecordCID for the oceSetup Record.
Clients interested in manipulating OCE Setup Personal Catalog directly should
make this call to get 'dsRefNum'.
'dsRefNum' will be returned in the standard field in the DirParamHeader.
}
	DirGetOCESetupRefNumPB = RECORD
		qLink:					Ptr;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		ioCompletion:			DirIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		reserved:				ARRAY [0..1] OF LONGINT;
		serverHint:				AddrBlock;
		dsRefNum:				INTEGER;
		callID:					LONGINT;
		identity:				AuthIdentity;
		gReserved1:				LONGINT;
		gReserved2:				LONGINT;
		gReserved3:				LONGINT;
		clientData:				LONGINT;
		oceSetupRecordCID:		CreationID;								{ --> creationID for the catalog record }
	END;

{***************************************************************************}
{ Catalog and Authentication control blocks and operation definitions }
	AuthParamBlock = RECORD
		CASE INTEGER OF
		0: (
			qLink:						Ptr;
			reserved1:					LONGINT;
			reserved2:					LONGINT;
			ioCompletion:				AuthIOCompletionUPP;
			ioResult:					OSErr;
			saveA5:						LONGINT;
			reqCode:					INTEGER;
			reserved:					ARRAY [0..1] OF LONGINT;
			serverHint:					AddrBlock;
			dsRefNum:					INTEGER;
			callID:						LONGINT;
			identity:					AuthIdentity;
			gReserved1:					LONGINT;
			gReserved2:					LONGINT;
			gReserved3:					LONGINT;
			clientData:					LONGINT;
		   );
		1: (
			bindIdentityPB:				AuthBindSpecificIdentityPB;
		   );
		2: (
			unbindIdentityPB:			AuthUnbindSpecificIdentityPB;
		   );
		3: (
			resolveCreationIDPB:		AuthResolveCreationIDPB;
		   );
		4: (
			getIdentityInfoPB:			AuthGetSpecificIdentityInfoPB;
		   );
		5: (
			addKeyPB:					AuthAddKeyPB;
		   );
		6: (
			changeKeyPB:				AuthChangeKeyPB;
		   );
		7: (
			deleteKeyPB:				AuthDeleteKeyPB;
		   );
		8: (
			passwordToKeyPB:			AuthPasswordToKeyPB;
		   );
		9: (
			getCredentialsPB:			AuthGetCredentialsPB;
		   );
		10: (
			decryptCredentialsPB:		AuthDecryptCredentialsPB;
		   );
		11: (
			makeChallengePB:			AuthMakeChallengePB;
		   );
		12: (
			makeReplyPB:				AuthMakeReplyPB;
		   );
		13: (
			verifyReplyPB:				AuthVerifyReplyPB;
		   );
		14: (
			getUTCTimePB:				AuthGetUTCTimePB;
		   );
		15: (
			makeProxyPB:				AuthMakeProxyPB;
		   );
		16: (
			tradeProxyForCredentialsPB:	AuthTradeProxyForCredentialsPB;
		   );
		17: (
			getLocalIdentityPB:			AuthGetLocalIdentityPB;
		   );
		18: (
			unLockLocalIdentityPB:		AuthUnlockLocalIdentityPB;
		   );
		19: (
			lockLocalIdentityPB:		AuthLockLocalIdentityPB;
		   );
		20: (
			localIdentityQInstallPB:	AuthAddToLocalIdentityQueuePB;
		   );
		21: (
			localIdentityQRemovePB:		AuthRemoveFromLocalIdentityQueuePB;
		   );
		22: (
			setupLocalIdentityPB:		AuthSetupLocalIdentityPB;
		   );
		23: (
			changeLocalIdentityPB:		AuthChangeLocalIdentityPB;
		   );
		24: (
			removeLocalIdentityPB:		AuthRemoveLocalIdentityPB;
		   );
		25: (
			setupDirectoryIdentityPB:	OCESetupAddDirectoryInfoPB;
		   );
		26: (
			changeDirectoryIdentityPB:	OCESetupChangeDirectoryInfoPB;
		   );
		27: (
			removeDirectoryIdentityPB:	OCESetupRemoveDirectoryInfoPB;
		   );
		28: (
			getDirectoryIdentityInfoPB:	OCESetupGetDirectoryInfoPB;
		   );
	END;

	DirParamBlock = RECORD
		CASE INTEGER OF
		0: (
			qLink:						Ptr;
			reserved1:					LONGINT;
			reserved2:					LONGINT;
			ioCompletion:				DirIOCompletionUPP;
			ioResult:					OSErr;
			saveA5:						LONGINT;
			reqCode:					INTEGER;
			reserved:					ARRAY [0..1] OF LONGINT;
			serverHint:					AddrBlock;
			dsRefNum:					INTEGER;
			callID:						LONGINT;
			identity:					AuthIdentity;
			gReserved1:					LONGINT;
			gReserved2:					LONGINT;
			gReserved3:					LONGINT;
			clientData:					LONGINT;
		   );
		1: (
			addRecordPB:				DirAddRecordPB;
		   );
		2: (
			deleteRecordPB:				DirDeleteRecordPB;
		   );
		3: (
			enumerateGetPB:				DirEnumerateGetPB;
		   );
		4: (
			enumerateParsePB:			DirEnumerateParsePB;
		   );
		5: (
			findRecordGetPB:			DirFindRecordGetPB;
		   );
		6: (
			findRecordParsePB:			DirFindRecordParsePB;
		   );
		7: (
			lookupGetPB:				DirLookupGetPB;
		   );
		8: (
			lookupParsePB:				DirLookupParsePB;
		   );
		9: (
			addAttributeValuePB:		DirAddAttributeValuePB;
		   );
		10: (
			deleteAttributeTypePB:		DirDeleteAttributeTypePB;
		   );
		11: (
			deleteAttributeValuePB:		DirDeleteAttributeValuePB;
		   );
		12: (
			changeAttributeValuePB:		DirChangeAttributeValuePB;
		   );
		13: (
			verifyAttributeValuePB:		DirVerifyAttributeValuePB;
		   );
		14: (
			findValuePB:				DirFindValuePB;
		   );
		15: (
			enumeratePseudonymGetPB:	DirEnumeratePseudonymGetPB;
		   );
		16: (
			enumeratePseudonymParsePB:	DirEnumeratePseudonymParsePB;
		   );
		17: (
			addPseudonymPB:				DirAddPseudonymPB;
		   );
		18: (
			deletePseudonymPB:			DirDeletePseudonymPB;
		   );
		19: (
			addAliasPB:					DirAddAliasPB;
		   );
		20: (
			enumerateAttributeTypesGetPB: DirEnumerateAttributeTypesGetPB;
		   );
		21: (
			enumerateAttributeTypesParsePB: DirEnumerateAttributeTypesParsePB;
		   );
		22: (
			getNameAndTypePB:			DirGetNameAndTypePB;
		   );
		23: (
			setNameAndTypePB:			DirSetNameAndTypePB;
		   );
		24: (
			getRecordMetaInfoPB:		DirGetRecordMetaInfoPB;
		   );
		25: (
			getDNodeMetaInfoPB:			DirGetDNodeMetaInfoPB;
		   );
		26: (
			getDirectoryInfoPB:			DirGetDirectoryInfoPB;
		   );
		27: (
			getDNodeAccessControlGetPB:	DirGetDNodeAccessControlGetPB;
		   );
		28: (
			getDNodeAccessControlParsePB: DirGetDNodeAccessControlParsePB;
		   );
		29: (
			getRecordAccessControlGetPB: DirGetRecordAccessControlGetPB;
		   );
		30: (
			getRecordAccessControlParsePB: DirGetRecordAccessControlParsePB;
		   );
		31: (
			getAttributeAccessControlGetPB: DirGetAttributeAccessControlGetPB;
		   );
		32: (
			getAttributeAccessControlParsePB: DirGetAttributeAccessControlParsePB;
		   );
		33: (
			enumerateDirectoriesGetPB:	DirEnumerateDirectoriesGetPB;
		   );
		34: (
			enumerateDirectoriesParsePB: DirEnumerateDirectoriesParsePB;
		   );
		35: (
			addADAPDirectoryPB:			DirAddADAPDirectoryPB;
		   );
		36: (
			removeDirectoryPB:			DirRemoveDirectoryPB;
		   );
		37: (
			netSearchADAPDirectoriesGetPB: DirNetSearchADAPDirectoriesGetPB;
		   );
		38: (
			netSearchADAPDirectoriesParsePB: DirNetSearchADAPDirectoriesParsePB;
		   );
		39: (
			findADAPDirectoryByNetSearchPB: DirFindADAPDirectoryByNetSearchPB;
		   );
		40: (
			mapDNodeNumberToPathNamePB:	DirMapDNodeNumberToPathNamePB;
		   );
		41: (
			mapPathNameToDNodeNumberPB:	DirMapPathNameToDNodeNumberPB;
		   );
		42: (
			getLocalNetworkSpecPB:		DirGetLocalNetworkSpecPB;
		   );
		43: (
			getDNodeInfoPB:				DirGetDNodeInfoPB;
		   );
		44: (
			createPersonalDirectoryPB:	DirCreatePersonalDirectoryPB;
		   );
		45: (
			openPersonalDirectoryPB:	DirOpenPersonalDirectoryPB;
		   );
		46: (
			closePersonalDirectoryPB:	DirClosePersonalDirectoryPB;
		   );
		47: (
			makePersonalDirectoryRLIPB:	DirMakePersonalDirectoryRLIPB;
		   );
		48: (
			addDSAMPB:					DirAddDSAMPB;
		   );
		49: (
			instantiateDSAMPB:			DirInstantiateDSAMPB;
		   );
		50: (
			removeDSAMPB:				DirRemoveDSAMPB;
		   );
		51: (
			addDSAMDirectoryPB:			DirAddDSAMDirectoryPB;
		   );
		52: (
			getExtendedDirectoriesInfoPB: DirGetExtendedDirectoriesInfoPB;
		   );
		53: (
			getDirectoryIconPB:			DirGetDirectoryIconPB;
		   );
		54: (
			dirGetOCESetupRefNumPB:		DirGetOCESetupRefNumPB;
		   );
		55: (
			abortPB:					DirAbortPB;
		   );
	END;

CONST
	uppAuthIOCompletionProcInfo = $000000C0; { PROCEDURE (4 byte param); }
	uppNotificationProcInfo = $00003FD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppDirIOCompletionProcInfo = $000000C0; { PROCEDURE (4 byte param); }
	uppForEachDirEnumSpecProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }
	uppForEachRecordProcInfo = $00000FD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppForEachLookupRecordIDProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }
	uppForEachAttrTypeLookupProcInfo = $00000FD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppForEachAttrValueProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }
	uppForEachAttrTypeProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }
	uppForEachRecordIDProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }
	uppForEachDirectoryProcInfo = $00003FD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppForEachADAPDirectoryProcInfo = $0000FFD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppForEachDNodeAccessControlProcInfo = $0000FFD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppForEachRecordAccessControlProcInfo = $0000FFD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppForEachAttributeAccessControlProcInfo = $0000FFD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppDSAMDirProcInfo = $000007E0; { FUNCTION (4 byte param, 4 byte param, 1 byte param): 2 byte result; }
	uppDSAMDirParseProcInfo = $000007E0; { FUNCTION (4 byte param, 4 byte param, 1 byte param): 2 byte result; }
	uppDSAMAuthProcInfo = $000007E0; { FUNCTION (4 byte param, 4 byte param, 1 byte param): 2 byte result; }

PROCEDURE CallAuthIOCompletionProc(paramBlock: AuthParamBlockPtr; userRoutine: AuthIOCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallNotificationProc(clientData: LONGINT; callValue: AuthLocalIdentityOp; actionValue: AuthLocalIdentityLockAction; identity: LocalIdentity; userRoutine: NotificationUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallDirIOCompletionProc(paramBlock: DirParamBlockPtr; userRoutine: DirIOCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachDirEnumSpecProc(clientData: LONGINT; {CONST}VAR enumSpec: DirEnumSpec; userRoutine: ForEachDirEnumSpecUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachRecordProc(clientData: LONGINT; {CONST}VAR enumSpec: DirEnumSpec; pRLI: PackedRLIPtr; userRoutine: ForEachRecordUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachLookupRecordIDProc(clientData: LONGINT; {CONST}VAR recordID: RecordID; userRoutine: ForEachLookupRecordIDUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachAttrTypeLookupProc(clientData: LONGINT; {CONST}VAR attrType: AttributeType; myAttrAccMask: AccessMask; userRoutine: ForEachAttrTypeLookupUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachAttrValueProc(clientData: LONGINT; {CONST}VAR attribute: Attribute; userRoutine: ForEachAttrValueUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachAttrTypeProc(clientData: LONGINT; {CONST}VAR attrType: AttributeType; userRoutine: ForEachAttrTypeUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachRecordIDProc(clientData: LONGINT; {CONST}VAR recordID: RecordID; userRoutine: ForEachRecordIDUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachDirectoryProc(clientData: LONGINT; {CONST}VAR dirName: DirectoryName; {CONST}VAR discriminator: DirDiscriminator; features: DirGestalt; userRoutine: ForEachDirectoryUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachADAPDirectoryProc(clientData: LONGINT; {CONST}VAR dirName: DirectoryName; {CONST}VAR discriminator: DirDiscriminator; features: DirGestalt; serverHint: AddrBlock; userRoutine: ForEachADAPDirectoryUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachDNodeAccessControlProc(clientData: LONGINT; {CONST}VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; defaultRecordAccMask: AccessMask; defaultAttributeAccMask: AccessMask; userRoutine: ForEachDNodeAccessControlUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachRecordAccessControlProc(clientData: LONGINT; {CONST}VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; activeRecordAccMask: AccessMask; defaultAttributeAccMask: AccessMask; userRoutine: ForEachRecordAccessControlUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallForEachAttributeAccessControlProc(clientData: LONGINT; {CONST}VAR dsObj: DSSpec; activeDnodeAccMask: AccessMask; activeRecordAccMask: AccessMask; activeAttributeAccMask: AccessMask; userRoutine: ForEachAttributeAccessControlUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallDSAMDirProc(dsamData: Ptr; paramBlock: DirParamBlockPtr; async: BOOLEAN; userRoutine: DSAMDirUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallDSAMDirParseProc(dsamData: Ptr; paramBlock: DirParamBlockPtr; async: BOOLEAN; userRoutine: DSAMDirParseUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallDSAMAuthProc(dsamData: Ptr; pb: AuthParamBlockPtr; async: BOOLEAN; userRoutine: DSAMAuthUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewAuthIOCompletionProc(userRoutine: AuthIOCompletionProcPtr): AuthIOCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewNotificationProc(userRoutine: NotificationProcPtr): NotificationUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDirIOCompletionProc(userRoutine: DirIOCompletionProcPtr): DirIOCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachDirEnumSpecProc(userRoutine: ForEachDirEnumSpecProcPtr): ForEachDirEnumSpecUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachRecordProc(userRoutine: ForEachRecordProcPtr): ForEachRecordUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachLookupRecordIDProc(userRoutine: ForEachLookupRecordIDProcPtr): ForEachLookupRecordIDUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachAttrTypeLookupProc(userRoutine: ForEachAttrTypeLookupProcPtr): ForEachAttrTypeLookupUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachAttrValueProc(userRoutine: ForEachAttrValueProcPtr): ForEachAttrValueUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachAttrTypeProc(userRoutine: ForEachAttrTypeProcPtr): ForEachAttrTypeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachRecordIDProc(userRoutine: ForEachRecordIDProcPtr): ForEachRecordIDUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachDirectoryProc(userRoutine: ForEachDirectoryProcPtr): ForEachDirectoryUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachADAPDirectoryProc(userRoutine: ForEachADAPDirectoryProcPtr): ForEachADAPDirectoryUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachDNodeAccessControlProc(userRoutine: ForEachDNodeAccessControlProcPtr): ForEachDNodeAccessControlUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachRecordAccessControlProc(userRoutine: ForEachRecordAccessControlProcPtr): ForEachRecordAccessControlUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewForEachAttributeAccessControlProc(userRoutine: ForEachAttributeAccessControlProcPtr): ForEachAttributeAccessControlUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDSAMDirProc(userRoutine: DSAMDirProcPtr): DSAMDirUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDSAMDirParseProc(userRoutine: DSAMDirParseProcPtr): DSAMDirParseUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDSAMAuthProc(userRoutine: DSAMAuthProcPtr): DSAMAuthUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION AuthBindSpecificIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $200, $AA5E;
	{$ENDC}
FUNCTION AuthUnbindSpecificIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $201, $AA5E;
	{$ENDC}
FUNCTION AuthResolveCreationID(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $202, $AA5E;
	{$ENDC}
FUNCTION AuthGetSpecificIdentityInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $203, $AA5E;
	{$ENDC}
FUNCTION AuthAddKey(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $207, $AA5E;
	{$ENDC}
FUNCTION AuthChangeKey(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $208, $AA5E;
	{$ENDC}
FUNCTION AuthDeleteKey(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $209, $AA5E;
	{$ENDC}
FUNCTION AuthPasswordToKey(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $20A, $AA5E;
	{$ENDC}
FUNCTION AuthGetCredentials(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $20B, $AA5E;
	{$ENDC}
FUNCTION AuthDecryptCredentials(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $20C, $AA5E;
	{$ENDC}
FUNCTION AuthMakeChallenge(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $20F, $AA5E;
	{$ENDC}
FUNCTION AuthMakeReply(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $210, $AA5E;
	{$ENDC}
FUNCTION AuthVerifyReply(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $211, $AA5E;
	{$ENDC}
FUNCTION AuthGetUTCTime(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $21A, $AA5E;
	{$ENDC}
FUNCTION AuthMakeProxy(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $212, $AA5E;
	{$ENDC}
FUNCTION AuthTradeProxyForCredentials(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $213, $AA5E;
	{$ENDC}
{ Local Identity API }
FUNCTION AuthGetLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $204, $AA5E;
	{$ENDC}
FUNCTION AuthUnlockLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $214, $AA5E;
	{$ENDC}
FUNCTION AuthLockLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $215, $AA5E;
	{$ENDC}
FUNCTION AuthAddToLocalIdentityQueue(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $205, $AA5E;
	{$ENDC}
FUNCTION AuthRemoveFromLocalIdentityQueue(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $206, $AA5E;
	{$ENDC}
FUNCTION AuthSetupLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $216, $AA5E;
	{$ENDC}
FUNCTION AuthChangeLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $217, $AA5E;
	{$ENDC}
FUNCTION AuthRemoveLocalIdentity(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $218, $AA5E;
	{$ENDC}
FUNCTION DirAddRecord(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $109, $AA5E;
	{$ENDC}
FUNCTION DirDeleteRecord(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $10A, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $111, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $101, $AA5E;
	{$ENDC}
FUNCTION DirFindRecordGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $140, $AA5E;
	{$ENDC}
FUNCTION DirFindRecordParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $141, $AA5E;
	{$ENDC}
FUNCTION DirLookupGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $117, $AA5E;
	{$ENDC}
FUNCTION DirLookupParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $102, $AA5E;
	{$ENDC}
FUNCTION DirAddAttributeValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $10B, $AA5E;
	{$ENDC}
FUNCTION DirDeleteAttributeValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $10C, $AA5E;
	{$ENDC}
FUNCTION DirDeleteAttributeType(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $130, $AA5E;
	{$ENDC}
FUNCTION DirChangeAttributeValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $10D, $AA5E;
	{$ENDC}
FUNCTION DirVerifyAttributeValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $10E, $AA5E;
	{$ENDC}
FUNCTION DirFindValue(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $126, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateAttributeTypesGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $112, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateAttributeTypesParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $103, $AA5E;
	{$ENDC}
FUNCTION DirAddPseudonym(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $10F, $AA5E;
	{$ENDC}
FUNCTION DirDeletePseudonym(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $110, $AA5E;
	{$ENDC}
FUNCTION DirAddAlias(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $11C, $AA5E;
	{$ENDC}
FUNCTION DirEnumeratePseudonymGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $113, $AA5E;
	{$ENDC}
FUNCTION DirEnumeratePseudonymParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $104, $AA5E;
	{$ENDC}
FUNCTION DirGetNameAndType(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $114, $AA5E;
	{$ENDC}
FUNCTION DirSetNameAndType(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $115, $AA5E;
	{$ENDC}
FUNCTION DirGetRecordMetaInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $116, $AA5E;
	{$ENDC}
FUNCTION DirGetDNodeMetaInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $118, $AA5E;
	{$ENDC}
FUNCTION DirGetDirectoryInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $119, $AA5E;
	{$ENDC}
FUNCTION DirGetDNodeAccessControlGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $12A, $AA5E;
	{$ENDC}
FUNCTION DirGetDNodeAccessControlParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $12F, $AA5E;
	{$ENDC}
FUNCTION DirGetRecordAccessControlGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $12C, $AA5E;
	{$ENDC}
FUNCTION DirGetRecordAccessControlParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $134, $AA5E;
	{$ENDC}
FUNCTION DirGetAttributeAccessControlGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $12E, $AA5E;
	{$ENDC}
FUNCTION DirGetAttributeAccessControlParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $138, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateDirectoriesGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $11A, $AA5E;
	{$ENDC}
FUNCTION DirEnumerateDirectoriesParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $106, $AA5E;
	{$ENDC}
FUNCTION DirMapPathNameToDNodeNumber(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $122, $AA5E;
	{$ENDC}
FUNCTION DirMapDNodeNumberToPathName(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $123, $AA5E;
	{$ENDC}
FUNCTION DirGetLocalNetworkSpec(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $124, $AA5E;
	{$ENDC}
FUNCTION DirGetDNodeInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $125, $AA5E;
	{$ENDC}
{  Trap Dispatchers for Personal Catalog and CSAM Extensions }
FUNCTION DirCreatePersonalDirectory(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3F3C, $11F, $AA5E;
	{$ENDC}
FUNCTION DirOpenPersonalDirectory(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3F3C, $11E, $AA5E;
	{$ENDC}
FUNCTION DirClosePersonalDirectory(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3F3C, $131, $AA5E;
	{$ENDC}
FUNCTION DirMakePersonalDirectoryRLI(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3F3C, $132, $AA5E;
	{$ENDC}
FUNCTION DirAddDSAM(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3F3C, $11D, $AA5E;
	{$ENDC}
FUNCTION DirInstantiateDSAM(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3F3C, $127, $AA5E;
	{$ENDC}
FUNCTION DirRemoveDSAM(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3F3C, $120, $AA5E;
	{$ENDC}
FUNCTION DirAddDSAMDirectory(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $133, $AA5E;
	{$ENDC}
FUNCTION DirGetExtendedDirectoriesInfo(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $136, $AA5E;
	{$ENDC}
FUNCTION DirGetDirectoryIcon(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $121, $AA5E;
	{$ENDC}
FUNCTION DirAddADAPDirectory(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $137, $AA5E;
	{$ENDC}
FUNCTION DirRemoveDirectory(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $135, $AA5E;
	{$ENDC}
FUNCTION DirNetSearchADAPDirectoriesGet(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $108, $AA5E;
	{$ENDC}
FUNCTION DirNetSearchADAPDirectoriesParse(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $105, $AA5E;
	{$ENDC}
FUNCTION DirFindADAPDirectoryByNetSearch(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $107, $AA5E;
	{$ENDC}
FUNCTION DirGetOCESetupRefNum(paramBlock: DirParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $128, $AA5E;
	{$ENDC}
FUNCTION DirAbort(paramBlock: DirParamBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3F3C, $11B, $AA5E;
	{$ENDC}
FUNCTION OCESetupAddDirectoryInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $219, $AA5E;
	{$ENDC}
FUNCTION OCESetupChangeDirectoryInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $21B, $AA5E;
	{$ENDC}
FUNCTION OCESetupRemoveDirectoryInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $20D, $AA5E;
	{$ENDC}
FUNCTION OCESetupGetDirectoryInfo(paramBlock: AuthParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $20E, $AA5E;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEAuthDirIncludes}

{$ENDC} {__OCEAUTHDIR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
