{
 	File:		Collections.p
 
 	Contains:	Collection Manager Interfaces.
 
 	Version:	Technology:	Quickdraw GX 1.0
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
 UNIT Collections;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COLLECTIONS__}
{$SETC __COLLECTIONS__ := 1}

{$I+}
{$SETC CollectionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	gestaltCollectionMgrVersion	= 'cltn';

{ Collection Manager Error Result Codes... }
	collectionItemLockedErr		= -5750;
	collectionItemNotFoundErr	= -5751;
	collectionIndexRangeErr		= -5752;
	collectionVersionErr		= -5753;

{ Convenience constants for functions which optionally return values... }
	dontWantTag					= 0;
	dontWantId					= 0;
	dontWantSize				= 0;
	dontWantAttributes			= 0;
	dontWantIndex				= 0;
	dontWantData				= 0;

{ attributes bits }
	noCollectionAttributes		= $00000000;					{ no attributes bits set }
	allCollectionAttributes		= $FFFFFFFF;					{ all attributes bits set }
	userCollectionAttributes	= $0000FFFF;					{ user attributes bits }
	defaultCollectionAttributes	= $40000000;					{ default attributes - unlocked, persistent }

{ 
	Attribute bits 0 through 15 (entire low word) are reserved for use by the application.
	Attribute bits 16 through 31 (entire high word) are reserved for use by the Collection Manager.
	Only bits 31 (collectionLockBit) and 30 (collectionPersistenceBit) currently have meaning.
}
	collectionUser0Bit			= 0;
	collectionUser1Bit			= 1;
	collectionUser2Bit			= 2;
	collectionUser3Bit			= 3;
	collectionUser4Bit			= 4;
	collectionUser5Bit			= 5;
	collectionUser6Bit			= 6;
	collectionUser7Bit			= 7;
	collectionUser8Bit			= 8;
	collectionUser9Bit			= 9;
	collectionUser10Bit			= 10;
	collectionUser11Bit			= 11;
	collectionUser12Bit			= 12;
	collectionUser13Bit			= 13;
	collectionUser14Bit			= 14;
	collectionUser15Bit			= 15;
	collectionReserved0Bit		= 16;
	collectionReserved1Bit		= 17;
	collectionReserved2Bit		= 18;
	collectionReserved3Bit		= 19;
	collectionReserved4Bit		= 20;
	collectionReserved5Bit		= 21;
	collectionReserved6Bit		= 22;
	collectionReserved7Bit		= 23;
	collectionReserved8Bit		= 24;
	collectionReserved9Bit		= 25;
	collectionReserved10Bit		= 26;
	collectionReserved11Bit		= 27;
	collectionReserved12Bit		= 28;
	collectionReserved13Bit		= 29;
	collectionPersistenceBit	= 30;
	collectionLockBit			= 31;

{ attribute masks }
	collectionUser0Mask			= 1 * (2**(collectionUser0Bit));
	collectionUser1Mask			= 1 * (2**(collectionUser1Bit));
	collectionUser2Mask			= 1 * (2**(collectionUser2Bit));
	collectionUser3Mask			= 1 * (2**(collectionUser3Bit));
	collectionUser4Mask			= 1 * (2**(collectionUser4Bit));
	collectionUser5Mask			= 1 * (2**(collectionUser5Bit));
	collectionUser6Mask			= 1 * (2**(collectionUser6Bit));
	collectionUser7Mask			= 1 * (2**(collectionUser7Bit));
	collectionUser8Mask			= 1 * (2**(collectionUser8Bit));
	collectionUser9Mask			= 1 * (2**(collectionUser9Bit));
	collectionUser10Mask		= 1 * (2**(collectionUser10Bit));
	collectionUser11Mask		= 1 * (2**(collectionUser11Bit));
	collectionUser12Mask		= 1 * (2**(collectionUser12Bit));
	collectionUser13Mask		= 1 * (2**(collectionUser13Bit));
	collectionUser14Mask		= 1 * (2**(collectionUser14Bit));
	collectionUser15Mask		= 1 * (2**(collectionUser15Bit));
	collectionReserved0Mask		= 1 * (2**(collectionReserved0Bit));
	collectionReserved1Mask		= 1 * (2**(collectionReserved1Bit));
	collectionReserved2Mask		= 1 * (2**(collectionReserved2Bit));
	collectionReserved3Mask		= 1 * (2**(collectionReserved3Bit));
	collectionReserved4Mask		= 1 * (2**(collectionReserved4Bit));
	collectionReserved5Mask		= 1 * (2**(collectionReserved5Bit));
	collectionReserved6Mask		= 1 * (2**(collectionReserved6Bit));
	collectionReserved7Mask		= 1 * (2**(collectionReserved7Bit));
	collectionReserved8Mask		= 1 * (2**(collectionReserved8Bit));
	collectionReserved9Mask		= 1 * (2**(collectionReserved9Bit));
	collectionReserved10Mask	= 1 * (2**(collectionReserved10Bit));
	collectionReserved11Mask	= 1 * (2**(collectionReserved11Bit));
	collectionReserved12Mask	= 1 * (2**(collectionReserved12Bit));
	collectionReserved13Mask	= 1 * (2**(collectionReserved13Bit));
	collectionPersistenceMask	= 1 * (2**(collectionPersistenceBit));
	collectionLockMask			= 1 * (2**(collectionLockBit));

{*********}
{ Types   }
{*********}
{ abstract data type for a collection }
	
TYPE
	Collection = Ptr;

	CollectionTag = FourCharCode;

	CollectionFlattenProcPtr = ProcPtr;  { FUNCTION CollectionFlatten(size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr): OSErr; }
	CollectionExceptionProcPtr = ProcPtr;  { FUNCTION CollectionException(c: Collection; status: OSErr): OSErr; }
	CollectionFlattenUPP = UniversalProcPtr;
	CollectionExceptionUPP = UniversalProcPtr;

CONST
	uppCollectionFlattenProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppCollectionExceptionProcInfo = $000002E0; { FUNCTION (4 byte param, 2 byte param): 2 byte result; }

FUNCTION NewCollectionFlattenProc(userRoutine: CollectionFlattenProcPtr): CollectionFlattenUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewCollectionExceptionProc(userRoutine: CollectionExceptionProcPtr): CollectionExceptionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallCollectionFlattenProc(size: LONGINT; data: UNIV Ptr; refCon: UNIV Ptr; userRoutine: CollectionFlattenUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallCollectionExceptionProc(c: Collection; status: OSErr; userRoutine: CollectionExceptionUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewCollection: Collection;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $ABF6;
	{$ENDC}
PROCEDURE DisposeCollection(c: Collection);
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $ABF6;
	{$ENDC}
FUNCTION CloneCollection(c: Collection): Collection;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $ABF6;
	{$ENDC}
FUNCTION CountCollectionOwners(c: Collection): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $ABF6;
	{$ENDC}
FUNCTION CopyCollection(srcCollection: Collection; dstCollection: Collection): Collection;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $ABF6;
	{$ENDC}
FUNCTION GetCollectionDefaultAttributes(c: Collection): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $ABF6;
	{$ENDC}
PROCEDURE SetCollectionDefaultAttributes(c: Collection; whichAttributes: LONGINT; newAttributes: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $ABF6;
	{$ENDC}
FUNCTION CountCollectionItems(c: Collection): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $ABF6;
	{$ENDC}
FUNCTION AddCollectionItem(c: Collection; tag: CollectionTag; id: LONGINT; itemSize: LONGINT; itemData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $ABF6;
	{$ENDC}
FUNCTION GetCollectionItem(c: Collection; tag: CollectionTag; id: LONGINT; VAR itemSize: LONGINT; itemData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $ABF6;
	{$ENDC}
FUNCTION RemoveCollectionItem(c: Collection; tag: CollectionTag; id: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $ABF6;
	{$ENDC}
FUNCTION SetCollectionItemInfo(c: Collection; tag: CollectionTag; id: LONGINT; whichAttributes: LONGINT; newAttributes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $ABF6;
	{$ENDC}
FUNCTION GetCollectionItemInfo(c: Collection; tag: CollectionTag; id: LONGINT; VAR index: LONGINT; VAR itemSize: LONGINT; VAR attributes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $ABF6;
	{$ENDC}
FUNCTION ReplaceIndexedCollectionItem(c: Collection; index: LONGINT; itemSize: LONGINT; itemData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $ABF6;
	{$ENDC}
FUNCTION GetIndexedCollectionItem(c: Collection; index: LONGINT; VAR itemSize: LONGINT; itemData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $ABF6;
	{$ENDC}
FUNCTION RemoveIndexedCollectionItem(c: Collection; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $ABF6;
	{$ENDC}
FUNCTION SetIndexedCollectionItemInfo(c: Collection; index: LONGINT; whichAttributes: LONGINT; newAttributes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $ABF6;
	{$ENDC}
FUNCTION GetIndexedCollectionItemInfo(c: Collection; index: LONGINT; VAR tag: CollectionTag; VAR id: LONGINT; VAR itemSize: LONGINT; VAR attributes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7011, $ABF6;
	{$ENDC}
FUNCTION CollectionTagExists(c: Collection; tag: CollectionTag): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7012, $ABF6;
	{$ENDC}
FUNCTION CountCollectionTags(c: Collection): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7013, $ABF6;
	{$ENDC}
FUNCTION GetIndexedCollectionTag(c: Collection; tagIndex: LONGINT; VAR tag: CollectionTag): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $ABF6;
	{$ENDC}
FUNCTION CountTaggedCollectionItems(c: Collection; tag: CollectionTag): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7015, $ABF6;
	{$ENDC}
FUNCTION GetTaggedCollectionItem(c: Collection; tag: CollectionTag; whichItem: LONGINT; VAR itemSize: LONGINT; itemData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7016, $ABF6;
	{$ENDC}
FUNCTION GetTaggedCollectionItemInfo(c: Collection; tag: CollectionTag; whichItem: LONGINT; VAR id: LONGINT; VAR index: LONGINT; VAR itemSize: LONGINT; VAR attributes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7017, $ABF6;
	{$ENDC}
PROCEDURE PurgeCollection(c: Collection; whichAttributes: LONGINT; matchingAttributes: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $7018, $ABF6;
	{$ENDC}
PROCEDURE PurgeCollectionTag(c: Collection; tag: CollectionTag);
	{$IFC NOT GENERATINGCFM}
	INLINE $7019, $ABF6;
	{$ENDC}
PROCEDURE EmptyCollection(c: Collection);
	{$IFC NOT GENERATINGCFM}
	INLINE $701A, $ABF6;
	{$ENDC}
FUNCTION FlattenCollection(c: Collection; flattenProc: CollectionFlattenUPP; refCon: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701B, $ABF6;
	{$ENDC}
FUNCTION FlattenPartialCollection(c: Collection; flattenProc: CollectionFlattenUPP; refCon: UNIV Ptr; whichAttributes: LONGINT; matchingAttributes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701C, $ABF6;
	{$ENDC}
FUNCTION UnflattenCollection(c: Collection; flattenProc: CollectionFlattenUPP; refCon: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701D, $ABF6;
	{$ENDC}
FUNCTION GetCollectionExceptionProc(c: Collection): CollectionExceptionUPP;
	{$IFC NOT GENERATINGCFM}
	INLINE $701E, $ABF6;
	{$ENDC}
PROCEDURE SetCollectionExceptionProc(c: Collection; exceptionProc: CollectionExceptionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $701F, $ABF6;
	{$ENDC}
{***************************************************************************************}
{ Utility Routines for handle-based access...														  }
{***************************************************************************************}
FUNCTION GetNewCollection(collectionID: INTEGER): Collection;
	{$IFC NOT GENERATINGCFM}
	INLINE $7020, $ABF6;
	{$ENDC}
FUNCTION AddCollectionItemHdl(aCollection: Collection; tag: CollectionTag; id: LONGINT; itemData: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7021, $ABF6;
	{$ENDC}
FUNCTION GetCollectionItemHdl(aCollection: Collection; tag: CollectionTag; id: LONGINT; itemData: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7022, $ABF6;
	{$ENDC}
FUNCTION ReplaceIndexedCollectionItemHdl(aCollection: Collection; index: LONGINT; itemData: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7023, $ABF6;
	{$ENDC}
FUNCTION GetIndexedCollectionItemHdl(aCollection: Collection; index: LONGINT; itemData: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7024, $ABF6;
	{$ENDC}
FUNCTION FlattenCollectionToHdl(aCollection: Collection; flattened: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7025, $ABF6;
	{$ENDC}
FUNCTION UnflattenCollectionFromHdl(aCollection: Collection; flattened: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7026, $ABF6;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CollectionsIncludes}

{$ENDC} {__COLLECTIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
