{
     File:       Collections.p
 
     Contains:   Collection Manager Interfaces
 
     Version:    Technology: Carbon
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
 UNIT Collections;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COLLECTIONS__}
{$SETC __COLLECTIONS__ := 1}

{$I+}
{$SETC CollectionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{***********}
{ Constants }
{***********}
{ Convenience constants for functions which optionally return values }

CONST
	kCollectionDontWantTag		= 0;
	kCollectionDontWantId		= 0;
	kCollectionDontWantSize		= 0;
	kCollectionDontWantAttributes = 0;
	kCollectionDontWantIndex	= 0;
	kCollectionDontWantData		= 0;


	{	 attributes bits 	}
	kCollectionNoAttributes		= $00000000;					{  no attributes bits set  }
	kCollectionAllAttributes	= $FFFFFFFF;					{  all attributes bits set  }
	kCollectionUserAttributes	= $0000FFFF;					{  user attributes bits  }
	kCollectionDefaultAttributes = $40000000;					{  default attributes - unlocked, persistent  }


	{	 
	    Attribute bits 0 through 15 (entire low word) are reserved for use by the application.
	    Attribute bits 16 through 31 (entire high word) are reserved for use by the Collection Manager.
	    Only bits 31 (kCollectionLockBit) and 30 (kCollectionPersistenceBit) currently have meaning.
		}
	kCollectionUser0Bit			= 0;
	kCollectionUser1Bit			= 1;
	kCollectionUser2Bit			= 2;
	kCollectionUser3Bit			= 3;
	kCollectionUser4Bit			= 4;
	kCollectionUser5Bit			= 5;
	kCollectionUser6Bit			= 6;
	kCollectionUser7Bit			= 7;
	kCollectionUser8Bit			= 8;
	kCollectionUser9Bit			= 9;
	kCollectionUser10Bit		= 10;
	kCollectionUser11Bit		= 11;
	kCollectionUser12Bit		= 12;
	kCollectionUser13Bit		= 13;
	kCollectionUser14Bit		= 14;
	kCollectionUser15Bit		= 15;
	kCollectionReserved0Bit		= 16;
	kCollectionReserved1Bit		= 17;
	kCollectionReserved2Bit		= 18;
	kCollectionReserved3Bit		= 19;
	kCollectionReserved4Bit		= 20;
	kCollectionReserved5Bit		= 21;
	kCollectionReserved6Bit		= 22;
	kCollectionReserved7Bit		= 23;
	kCollectionReserved8Bit		= 24;
	kCollectionReserved9Bit		= 25;
	kCollectionReserved10Bit	= 26;
	kCollectionReserved11Bit	= 27;
	kCollectionReserved12Bit	= 28;
	kCollectionReserved13Bit	= 29;
	kCollectionPersistenceBit	= 30;
	kCollectionLockBit			= 31;


	{	 attribute masks 	}
	kCollectionUser0Mask		= $00000001;
	kCollectionUser1Mask		= $00000002;
	kCollectionUser2Mask		= $00000004;
	kCollectionUser3Mask		= $00000008;
	kCollectionUser4Mask		= $00000010;
	kCollectionUser5Mask		= $00000020;
	kCollectionUser6Mask		= $00000040;
	kCollectionUser7Mask		= $00000080;
	kCollectionUser8Mask		= $00000100;
	kCollectionUser9Mask		= $00000200;
	kCollectionUser10Mask		= $00000400;
	kCollectionUser11Mask		= $00000800;
	kCollectionUser12Mask		= $00001000;
	kCollectionUser13Mask		= $00002000;
	kCollectionUser14Mask		= $00004000;
	kCollectionUser15Mask		= $00008000;
	kCollectionReserved0Mask	= $00010000;
	kCollectionReserved1Mask	= $00020000;
	kCollectionReserved2Mask	= $00040000;
	kCollectionReserved3Mask	= $00080000;
	kCollectionReserved4Mask	= $00100000;
	kCollectionReserved5Mask	= $00200000;
	kCollectionReserved6Mask	= $00400000;
	kCollectionReserved7Mask	= $00800000;
	kCollectionReserved8Mask	= $01000000;
	kCollectionReserved9Mask	= $02000000;
	kCollectionReserved10Mask	= $04000000;
	kCollectionReserved11Mask	= $08000000;
	kCollectionReserved12Mask	= $10000000;
	kCollectionReserved13Mask	= $20000000;
	kCollectionPersistenceMask	= $40000000;
	kCollectionLockMask			= $80000000;


	{	*********	}
	{	 Types   	}
	{	*********	}
	{	 abstract data type for a collection 	}

TYPE
	Collection    = ^LONGINT; { an opaque 32-bit type }
	CollectionPtr = ^Collection;  { when a VAR xx:Collection parameter can be nil, it is changed to xx: CollectionPtr }
	{	 collection member 4 byte tag 	}
	CollectionTag						= FourCharCode;
{$IFC TYPED_FUNCTION_POINTERS}
	CollectionFlattenProcPtr = FUNCTION(size: SInt32; data: UNIV Ptr; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	CollectionFlattenProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CollectionExceptionProcPtr = FUNCTION(c: Collection; status: OSErr): OSErr;
{$ELSEC}
	CollectionExceptionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	CollectionFlattenUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CollectionFlattenUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CollectionExceptionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CollectionExceptionUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppCollectionFlattenProcInfo = $00000FE0;
	uppCollectionExceptionProcInfo = $000002E0;
	{
	 *  NewCollectionFlattenUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewCollectionFlattenUPP(userRoutine: CollectionFlattenProcPtr): CollectionFlattenUPP; { old name was NewCollectionFlattenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCollectionExceptionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewCollectionExceptionUPP(userRoutine: CollectionExceptionProcPtr): CollectionExceptionUPP; { old name was NewCollectionExceptionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeCollectionFlattenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCollectionFlattenUPP(userUPP: CollectionFlattenUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCollectionExceptionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCollectionExceptionUPP(userUPP: CollectionExceptionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeCollectionFlattenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeCollectionFlattenUPP(size: SInt32; data: UNIV Ptr; refCon: UNIV Ptr; userRoutine: CollectionFlattenUPP): OSErr; { old name was CallCollectionFlattenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCollectionExceptionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeCollectionExceptionUPP(c: Collection; status: OSErr; userRoutine: CollectionExceptionUPP): OSErr; { old name was CallCollectionExceptionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{*******************************************}
{************ Public interfaces ************}
{*******************************************}
{
 *  NewCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewCollection: Collection;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $ABF6;
	{$ENDC}


{
 *  DisposeCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCollection(c: Collection);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $ABF6;
	{$ENDC}


{
 *  CloneCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CloneCollection(c: Collection): Collection;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $ABF6;
	{$ENDC}


{
 *  CountCollectionOwners()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountCollectionOwners(c: Collection): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $ABF6;
	{$ENDC}


{
 *  RetainCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RetainCollection(c: Collection): OSStatus;


{
 *  ReleaseCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReleaseCollection(c: Collection): OSStatus;


{
 *  GetCollectionRetainCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCollectionRetainCount(c: Collection): ItemCount;


{
 *  CopyCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyCollection(srcCollection: Collection; dstCollection: Collection): Collection;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $ABF6;
	{$ENDC}


{
 *  GetCollectionDefaultAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCollectionDefaultAttributes(c: Collection): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $ABF6;
	{$ENDC}


{
 *  SetCollectionDefaultAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetCollectionDefaultAttributes(c: Collection; whichAttributes: SInt32; newAttributes: SInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $ABF6;
	{$ENDC}


{
 *  CountCollectionItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountCollectionItems(c: Collection): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $ABF6;
	{$ENDC}


{
 *  AddCollectionItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddCollectionItem(c: Collection; tag: CollectionTag; id: SInt32; itemSize: SInt32; itemData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $ABF6;
	{$ENDC}


{
 *  GetCollectionItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCollectionItem(c: Collection; tag: CollectionTag; id: SInt32; VAR itemSize: SInt32; itemData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $ABF6;
	{$ENDC}


{
 *  RemoveCollectionItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveCollectionItem(c: Collection; tag: CollectionTag; id: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $ABF6;
	{$ENDC}


{
 *  SetCollectionItemInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetCollectionItemInfo(c: Collection; tag: CollectionTag; id: SInt32; whichAttributes: SInt32; newAttributes: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $ABF6;
	{$ENDC}


{
 *  GetCollectionItemInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCollectionItemInfo(c: Collection; tag: CollectionTag; id: SInt32; VAR index: SInt32; VAR itemSize: SInt32; VAR attributes: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $ABF6;
	{$ENDC}


{
 *  ReplaceIndexedCollectionItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReplaceIndexedCollectionItem(c: Collection; index: SInt32; itemSize: SInt32; itemData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $ABF6;
	{$ENDC}


{
 *  GetIndexedCollectionItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIndexedCollectionItem(c: Collection; index: SInt32; VAR itemSize: SInt32; itemData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $ABF6;
	{$ENDC}


{
 *  RemoveIndexedCollectionItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveIndexedCollectionItem(c: Collection; index: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $ABF6;
	{$ENDC}


{
 *  SetIndexedCollectionItemInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetIndexedCollectionItemInfo(c: Collection; index: SInt32; whichAttributes: SInt32; newAttributes: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $ABF6;
	{$ENDC}


{
 *  GetIndexedCollectionItemInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIndexedCollectionItemInfo(c: Collection; index: SInt32; VAR tag: CollectionTag; VAR id: SInt32; VAR itemSize: SInt32; VAR attributes: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $ABF6;
	{$ENDC}


{
 *  CollectionTagExists()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CollectionTagExists(c: Collection; tag: CollectionTag): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $ABF6;
	{$ENDC}


{
 *  CountCollectionTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountCollectionTags(c: Collection): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $ABF6;
	{$ENDC}


{
 *  GetIndexedCollectionTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIndexedCollectionTag(c: Collection; tagIndex: SInt32; VAR tag: CollectionTag): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $ABF6;
	{$ENDC}


{
 *  CountTaggedCollectionItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountTaggedCollectionItems(c: Collection; tag: CollectionTag): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $ABF6;
	{$ENDC}


{
 *  GetTaggedCollectionItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetTaggedCollectionItem(c: Collection; tag: CollectionTag; whichItem: SInt32; VAR itemSize: SInt32; itemData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $ABF6;
	{$ENDC}


{
 *  GetTaggedCollectionItemInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetTaggedCollectionItemInfo(c: Collection; tag: CollectionTag; whichItem: SInt32; VAR id: SInt32; VAR index: SInt32; VAR itemSize: SInt32; VAR attributes: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7017, $ABF6;
	{$ENDC}


{
 *  PurgeCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PurgeCollection(c: Collection; whichAttributes: SInt32; matchingAttributes: SInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $ABF6;
	{$ENDC}


{
 *  PurgeCollectionTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PurgeCollectionTag(c: Collection; tag: CollectionTag);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $ABF6;
	{$ENDC}


{
 *  EmptyCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EmptyCollection(c: Collection);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $ABF6;
	{$ENDC}

{
 *  FlattenCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FlattenCollection(c: Collection; flattenProc: CollectionFlattenUPP; refCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701B, $ABF6;
	{$ENDC}


{
 *  FlattenPartialCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FlattenPartialCollection(c: Collection; flattenProc: CollectionFlattenUPP; refCon: UNIV Ptr; whichAttributes: SInt32; matchingAttributes: SInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $ABF6;
	{$ENDC}


{
 *  UnflattenCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UnflattenCollection(c: Collection; flattenProc: CollectionFlattenUPP; refCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $ABF6;
	{$ENDC}


{
 *  GetCollectionExceptionProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCollectionExceptionProc(c: Collection): CollectionExceptionUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $ABF6;
	{$ENDC}


{
 *  SetCollectionExceptionProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetCollectionExceptionProc(c: Collection; exceptionProc: CollectionExceptionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $ABF6;
	{$ENDC}


{
 *  GetNewCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNewCollection(collectionID: SInt16): Collection;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $ABF6;
	{$ENDC}


{********************************************************************}
{************* Utility routines for handle-based access *************}
{********************************************************************}
{
 *  AddCollectionItemHdl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddCollectionItemHdl(aCollection: Collection; tag: CollectionTag; id: SInt32; itemData: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $ABF6;
	{$ENDC}


{
 *  GetCollectionItemHdl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCollectionItemHdl(aCollection: Collection; tag: CollectionTag; id: SInt32; itemData: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $ABF6;
	{$ENDC}


{
 *  ReplaceIndexedCollectionItemHdl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReplaceIndexedCollectionItemHdl(aCollection: Collection; index: SInt32; itemData: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $ABF6;
	{$ENDC}


{
 *  GetIndexedCollectionItemHdl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIndexedCollectionItemHdl(aCollection: Collection; index: SInt32; itemData: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $ABF6;
	{$ENDC}


{
 *  FlattenCollectionToHdl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FlattenCollectionToHdl(aCollection: Collection; flattened: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $ABF6;
	{$ENDC}


{
 *  UnflattenCollectionFromHdl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UnflattenCollectionFromHdl(aCollection: Collection; flattened: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7026, $ABF6;
	{$ENDC}


{$IFC OLDROUTINENAMES }

CONST
	dontWantTag					= 0;
	dontWantId					= 0;
	dontWantSize				= 0;
	dontWantAttributes			= 0;
	dontWantIndex				= 0;
	dontWantData				= 0;

	noCollectionAttributes		= $00000000;
	allCollectionAttributes		= $FFFFFFFF;
	userCollectionAttributes	= $0000FFFF;
	defaultCollectionAttributes	= $40000000;

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

	collectionUser0Mask			= $00000001;
	collectionUser1Mask			= $00000002;
	collectionUser2Mask			= $00000004;
	collectionUser3Mask			= $00000008;
	collectionUser4Mask			= $00000010;
	collectionUser5Mask			= $00000020;
	collectionUser6Mask			= $00000040;
	collectionUser7Mask			= $00000080;
	collectionUser8Mask			= $00000100;
	collectionUser9Mask			= $00000200;
	collectionUser10Mask		= $00000400;
	collectionUser11Mask		= $00000800;
	collectionUser12Mask		= $00001000;
	collectionUser13Mask		= $00002000;
	collectionUser14Mask		= $00004000;
	collectionUser15Mask		= $00008000;
	collectionReserved0Mask		= $00010000;
	collectionReserved1Mask		= $00020000;
	collectionReserved2Mask		= $00040000;
	collectionReserved3Mask		= $00080000;
	collectionReserved4Mask		= $00100000;
	collectionReserved5Mask		= $00200000;
	collectionReserved6Mask		= $00400000;
	collectionReserved7Mask		= $00800000;
	collectionReserved8Mask		= $01000000;
	collectionReserved9Mask		= $02000000;
	collectionReserved10Mask	= $04000000;
	collectionReserved11Mask	= $08000000;
	collectionReserved12Mask	= $10000000;
	collectionReserved13Mask	= $20000000;
	collectionPersistenceMask	= $40000000;
	collectionLockMask			= $80000000;

{$ENDC}  {OLDROUTINENAMES}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CollectionsIncludes}

{$ENDC} {__COLLECTIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
