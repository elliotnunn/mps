{
     File:       AEDataModel.p
 
     Contains:   AppleEvent Data Model Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AEDataModel;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEDATAMODEL__}
{$SETC __AEDATAMODEL__ := 1}

{$I+}
{$SETC AEDataModelIncludes := UsingIncludes}
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

{ Apple event descriptor types }

CONST
	typeBoolean					= 'bool';
	typeChar					= 'TEXT';

	{	 Preferred numeric Apple event descriptor types 	}
	typeSInt16					= 'shor';
	typeSInt32					= 'long';
	typeUInt32					= 'magn';
	typeSInt64					= 'comp';
	typeIEEE32BitFloatingPoint	= 'sing';
	typeIEEE64BitFloatingPoint	= 'doub';
	type128BitFloatingPoint		= 'ldbl';
	typeDecimalStruct			= 'decm';

	{	 Non-preferred Apple event descriptor types 	}
	typeSMInt					= 'shor';
	typeShortInteger			= 'shor';
	typeInteger					= 'long';
	typeLongInteger				= 'long';
	typeMagnitude				= 'magn';
	typeComp					= 'comp';
	typeSMFloat					= 'sing';
	typeShortFloat				= 'sing';
	typeFloat					= 'doub';
	typeLongFloat				= 'doub';
	typeExtended				= 'exte';

	{	 More Apple event descriptor types 	}
	typeAEList					= 'list';
	typeAERecord				= 'reco';
	typeAppleEvent				= 'aevt';
	typeEventRecord				= 'evrc';
	typeTrue					= 'true';
	typeFalse					= 'fals';
	typeAlias					= 'alis';
	typeEnumerated				= 'enum';
	typeType					= 'type';
	typeAppParameters			= 'appa';
	typeProperty				= 'prop';
	typeFSS						= 'fss ';
	typeFSRef					= 'fsrf';
	typeKeyword					= 'keyw';
	typeSectionH				= 'sect';
	typeWildCard				= '****';
	typeApplSignature			= 'sign';
	typeQDRectangle				= 'qdrt';
	typeFixed					= 'fixd';
	typeProcessSerialNumber		= 'psn ';
	typeApplicationURL			= 'aprl';
	typeNull					= 'null';						{  null or nonexistent data  }

{$IFC CALL_NOT_IN_CARBON }
	{	 Deprecated addressing modes under Carbon 	}
	typeSessionID				= 'ssid';
	typeTargetID				= 'targ';
	typeDispatcherID			= 'dspt';

{$ENDC}  {CALL_NOT_IN_CARBON}

	{	 Keywords for Apple event attributes 	}
	keyTransactionIDAttr		= 'tran';
	keyReturnIDAttr				= 'rtid';
	keyEventClassAttr			= 'evcl';
	keyEventIDAttr				= 'evid';
	keyAddressAttr				= 'addr';
	keyOptionalKeywordAttr		= 'optk';
	keyTimeoutAttr				= 'timo';
	keyInteractLevelAttr		= 'inte';						{  this attribute is read only - will be set in AESend  }
	keyEventSourceAttr			= 'esrc';						{  this attribute is read only - returned as typeShortInteger  }
	keyMissedKeywordAttr		= 'miss';						{  this attribute is read only  }
	keyOriginalAddressAttr		= 'from';						{  new in 1.0.1  }
	keyAcceptTimeoutAttr		= 'actm';						{  new for Mac OS X  }


	{	  Constants used for specifying the factoring of AEDescLists. 	}
	kAEDescListFactorNone		= 0;
	kAEDescListFactorType		= 4;
	kAEDescListFactorTypeAndSize = 8;

	{	 Constants used creating an AppleEvent 	}
																{  Constant for the returnID param of AECreateAppleEvent  }
	kAutoGenerateReturnID		= -1;							{  AECreateAppleEvent will generate a session-unique ID  }
																{  Constant for transaction ID’s  }
	kAnyTransactionID			= 0;							{  no transaction is in use  }

	{	 Apple event manager data types 	}

TYPE
	DescType							= ResType;
	AEKeyword							= FourCharCode;
{$IFC OPAQUE_TOOLBOX_STRUCTS }
	AEDataStorage    = ^LONGINT; { an opaque 32-bit type }
	AEDataStoragePtr = ^AEDataStorage;  { when a VAR xx:AEDataStorage parameter can be nil, it is changed to xx: AEDataStoragePtr }
{$ELSEC}
	AEDataStorage						= Handle;
{$ENDC}  {OPAQUE_TOOLBOX_STRUCTS}

	AEDescPtr = ^AEDesc;
	AEDesc = RECORD
		descriptorType:			DescType;
		dataHandle:				AEDataStorage;
	END;

	AEKeyDescPtr = ^AEKeyDesc;
	AEKeyDesc = RECORD
		descKey:				AEKeyword;
		descContent:			AEDesc;
	END;

	{	 a list of AEDesc's is a special kind of AEDesc 	}
	AEDescList							= AEDesc;
	AEDescListPtr 						= ^AEDescList;
	{	 AERecord is a list of keyworded AEDesc's 	}
	AERecord							= AEDescList;
	AERecordPtr 						= ^AERecord;
	{	 an AEDesc which contains address data 	}
	AEAddressDesc						= AEDesc;
	AEAddressDescPtr 					= ^AEAddressDesc;
	{	 an AERecord that contains an AppleEvent, and related data types 	}
	AppleEvent							= AERecord;
	AppleEventPtr 						= ^AppleEvent;
	AEReturnID							= SInt16;
	AETransactionID						= SInt32;
	AEEventClass						= FourCharCode;
	AEEventID							= FourCharCode;
	AEArrayType							= SInt8;

CONST
	kAEDataArray				= 0;
	kAEPackedArray				= 1;
	kAEDescArray				= 3;
	kAEKeyDescArray				= 4;


	kAEHandleArray				= 2;


TYPE
	AEArrayDataPtr = ^AEArrayData;
	AEArrayData = RECORD
		CASE INTEGER OF
		0: (
			kAEDataArray:		ARRAY [0..0] OF INTEGER;
			);
		1: (
			kAEPackedArray:		SInt8;
			);
		2: (
			kAEHandleArray:		ARRAY [0..0] OF Handle;
			);
		3: (
			kAEDescArray:		ARRAY [0..0] OF AEDesc;
			);
		4: (
			kAEKeyDescArray:	ARRAY [0..0] OF AEKeyDesc;
			);
	END;

	AEArrayDataPointer					= ^AEArrayData;
	AEArrayDataPointerPtr 				= ^AEArrayDataPointer;
	{	*************************************************************************
	  These constants are used by AEMach and AEInteraction APIs.  They are not
	  strictly part of the data format, but are declared here due to layering.
	*************************************************************************	}
	AESendPriority 				= SInt16;
CONST
	kAENormalPriority			= $00000000;					{  post message at the end of the event queue  }
	kAEHighPriority				= $00000001;					{  post message at the front of the event queue (same as nAttnMsg)  }



TYPE
	AESendMode 					= SInt32;
CONST
	kAENoReply					= $00000001;					{  sender doesn't want a reply to event  }
	kAEQueueReply				= $00000002;					{  sender wants a reply but won't wait  }
	kAEWaitReply				= $00000003;					{  sender wants a reply and will wait  }
	kAEDontReconnect			= $00000080;					{  don't reconnect if there is a sessClosedErr from PPCToolbox  }
	kAEWantReceipt				= $00000200;					{  (nReturnReceipt) sender wants a receipt of message  }
	kAENeverInteract			= $00000010;					{  server should not interact with user  }
	kAECanInteract				= $00000020;					{  server may try to interact with user  }
	kAEAlwaysInteract			= $00000030;					{  server should always interact with user where appropriate  }
	kAECanSwitchLayer			= $00000040;					{  interaction may switch layer  }
	kAEDontRecord				= $00001000;					{  don't record this event - available only in vers 1.0.1 and greater  }
	kAEDontExecute				= $00002000;					{  don't send the event for recording - available only in vers 1.0.1 and greater  }
	kAEProcessNonReplyEvents	= $00008000;					{  allow processing of non-reply events while awaiting synchronous AppleEvent reply  }


	{	 Constants for timeout durations 	}
	kAEDefaultTimeout			= -1;							{  timeout value determined by AEM  }
	kNoTimeOut					= -2;							{  wait until reply comes back, however long it takes  }


	{	*************************************************************************
	  These calls are used to set up and modify the coercion dispatch table.
	*************************************************************************	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	AECoerceDescProcPtr = FUNCTION({CONST}VAR fromDesc: AEDesc; toType: DescType; handlerRefcon: LONGINT; VAR toDesc: AEDesc): OSErr;
{$ELSEC}
	AECoerceDescProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	AECoercePtrProcPtr = FUNCTION(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; toType: DescType; handlerRefcon: LONGINT; VAR result: AEDesc): OSErr;
{$ELSEC}
	AECoercePtrProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	AECoerceDescUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AECoerceDescUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	AECoercePtrUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AECoercePtrUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppAECoerceDescProcInfo = $00003FE0;
	uppAECoercePtrProcInfo = $0003FFE0;
	{
	 *  NewAECoerceDescUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewAECoerceDescUPP(userRoutine: AECoerceDescProcPtr): AECoerceDescUPP; { old name was NewAECoerceDescProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewAECoercePtrUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewAECoercePtrUPP(userRoutine: AECoercePtrProcPtr): AECoercePtrUPP; { old name was NewAECoercePtrProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeAECoerceDescUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAECoerceDescUPP(userUPP: AECoerceDescUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeAECoercePtrUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAECoercePtrUPP(userUPP: AECoercePtrUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeAECoerceDescUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeAECoerceDescUPP({CONST}VAR fromDesc: AEDesc; toType: DescType; handlerRefcon: LONGINT; VAR toDesc: AEDesc; userRoutine: AECoerceDescUPP): OSErr; { old name was CallAECoerceDescProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeAECoercePtrUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeAECoercePtrUPP(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; toType: DescType; handlerRefcon: LONGINT; VAR result: AEDesc; userRoutine: AECoercePtrUPP): OSErr; { old name was CallAECoercePtrProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{ a AECoercionHandlerUPP is by default a AECoerceDescUPP.  If you are registering a 
    Ptr based coercion handler you will have to add a cast to AECoerceDescUPP from 
    your AECoercePtrUPP type.  A future release of the interfaces will fix this by
    introducing seperate Desc and Ptr coercion handler installation/remove/query routines. }

TYPE
	AECoercionHandlerUPP				= AECoerceDescUPP;
	{
	 *  AEInstallCoercionHandler()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AEInstallCoercionHandler(fromType: DescType; toType: DescType; handler: AECoercionHandlerUPP; handlerRefcon: LONGINT; fromTypeIsDesc: BOOLEAN; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A22, $A816;
	{$ENDC}

{
 *  AERemoveCoercionHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AERemoveCoercionHandler(fromType: DescType; toType: DescType; handler: AECoercionHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0723, $A816;
	{$ENDC}


{
 *  AEGetCoercionHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetCoercionHandler(fromType: DescType; toType: DescType; VAR handler: AECoercionHandlerUPP; VAR handlerRefcon: LONGINT; VAR fromTypeIsDesc: BOOLEAN; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B24, $A816;
	{$ENDC}

{*************************************************************************
  The following calls provide for a coercion interface.
*************************************************************************}
{
 *  AECoercePtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AECoercePtr(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; toType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A02, $A816;
	{$ENDC}

{
 *  AECoerceDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AECoerceDesc({CONST}VAR theAEDesc: AEDesc; toType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0603, $A816;
	{$ENDC}


{*************************************************************************
 The following calls apply to any AEDesc. Every 'result' descriptor is
 created for you, so you will be responsible for memory management
 (including disposing) of the descriptors so created.  
*************************************************************************}
{ because AEDescs are opaque under Carbon, this AEInitializeDesc provides a
   'clean' way of initializating them to be empty. }
{
 *  AEInitializeDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AEInitializeDesc(VAR desc: AEDesc); C;


{
 *  AECreateDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AECreateDesc(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0825, $A816;
	{$ENDC}

{
 *  AEDisposeDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEDisposeDesc(VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0204, $A816;
	{$ENDC}

{
 *  AEDuplicateDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEDuplicateDesc({CONST}VAR theAEDesc: AEDesc; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0405, $A816;
	{$ENDC}


{*************************************************************************
  The following calls apply to AEDescList. Since AEDescList is a subtype of
  AEDesc, the calls in the previous section can also be used for AEDescList.
  All list and array indices are 1-based. If the data was greater than
  maximumSize in the routines below, then actualSize will be greater than
  maximumSize, but only maximumSize bytes will actually be retrieved.
*************************************************************************}
{
 *  AECreateList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AECreateList(factoringPtr: UNIV Ptr; factoredSize: Size; isRecord: BOOLEAN; VAR resultList: AEDescList): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0706, $A816;
	{$ENDC}

{
 *  AECountItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AECountItems({CONST}VAR theAEDescList: AEDescList; VAR theCount: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0407, $A816;
	{$ENDC}

{
 *  AEPutPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEPutPtr(VAR theAEDescList: AEDescList; index: LONGINT; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A08, $A816;
	{$ENDC}

{
 *  AEPutDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEPutDesc(VAR theAEDescList: AEDescList; index: LONGINT; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0609, $A816;
	{$ENDC}

{
 *  AEGetNthPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetNthPtr({CONST}VAR theAEDescList: AEDescList; index: LONGINT; desiredType: DescType; VAR theAEKeyword: AEKeyword; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $100A, $A816;
	{$ENDC}

{
 *  AEGetNthDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetNthDesc({CONST}VAR theAEDescList: AEDescList; index: LONGINT; desiredType: DescType; VAR theAEKeyword: AEKeyword; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A0B, $A816;
	{$ENDC}

{
 *  AESizeOfNthItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AESizeOfNthItem({CONST}VAR theAEDescList: AEDescList; index: LONGINT; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $082A, $A816;
	{$ENDC}

{
 *  AEGetArray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetArray({CONST}VAR theAEDescList: AEDescList; arrayType: AEArrayType; arrayPtr: AEArrayDataPointer; maximumSize: Size; VAR itemType: DescType; VAR itemSize: Size; VAR itemCount: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0D0C, $A816;
	{$ENDC}

{
 *  AEPutArray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEPutArray(VAR theAEDescList: AEDescList; arrayType: AEArrayType; {CONST}VAR arrayPtr: AEArrayData; itemType: DescType; itemSize: Size; itemCount: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B0D, $A816;
	{$ENDC}

{
 *  AEDeleteItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEDeleteItem(VAR theAEDescList: AEDescList; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040E, $A816;
	{$ENDC}


{*************************************************************************
 The following calls apply to AERecord. Since AERecord is a subtype of
 AEDescList, the calls in the previous sections can also be used for
 AERecord an AERecord can be created by using AECreateList with isRecord
 set to true. 
*************************************************************************}
{************************************************************************
 AERecords can have an abitrary descriptorType.  This allows you to
 check if desc is truly an AERecord
***********************************************************************}
{
 *  AECheckIsRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AECheckIsRecord({CONST}VAR theDesc: AEDesc): BOOLEAN; C;

{
  Note: none of the “key” calls were available in the PowerPC 7.x IntefaceLib.
  In C, a #define is used to map “key” calls to “param” calls.  In pascal
  this mapping is done in externally linked glue code.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  AEPutKeyPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AEPutKeyPtr(VAR theAERecord: AERecord; theAEKeyword: AEKeyword; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A0F, $A816;
	{$ENDC}

{
 *  AEPutKeyDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AEPutKeyDesc(VAR theAERecord: AERecord; theAEKeyword: AEKeyword; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0610, $A816;
	{$ENDC}

{
 *  AEGetKeyPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AEGetKeyPtr({CONST}VAR theAERecord: AERecord; theAEKeyword: AEKeyword; desiredType: DescType; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E11, $A816;
	{$ENDC}

{
 *  AEGetKeyDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AEGetKeyDesc({CONST}VAR theAERecord: AERecord; theAEKeyword: AEKeyword; desiredType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0812, $A816;
	{$ENDC}

{
 *  AESizeOfKeyDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AESizeOfKeyDesc({CONST}VAR theAERecord: AERecord; theAEKeyword: AEKeyword; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0829, $A816;
	{$ENDC}

{
 *  AEDeleteKeyDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AEDeleteKeyDesc(VAR theAERecord: AERecord; theAEKeyword: AEKeyword): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $A816;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{*************************************************************************
  The following calls create and manipulate the AppleEvent data type.
*************************************************************************}
{
 *  AECreateAppleEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AECreateAppleEvent(theAEEventClass: AEEventClass; theAEEventID: AEEventID; {CONST}VAR target: AEAddressDesc; returnID: AEReturnID; transactionID: AETransactionID; VAR result: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B14, $A816;
	{$ENDC}


{*************************************************************************
  The following calls are used to pack and unpack parameters from records
  of type AppleEvent. Since AppleEvent is a subtype of AERecord, the calls
  in the previous sections can also be used for variables of type
  AppleEvent. The next six calls are in fact identical to the six calls
  for AERecord.
*************************************************************************}
{
 *  AEPutParamPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEPutParamPtr(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A0F, $A816;
	{$ENDC}

{
 *  AEPutParamDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEPutParamDesc(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0610, $A816;
	{$ENDC}

{
 *  AEGetParamPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetParamPtr({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E11, $A816;
	{$ENDC}

{
 *  AEGetParamDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetParamDesc({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0812, $A816;
	{$ENDC}

{
 *  AESizeOfParam()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AESizeOfParam({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0829, $A816;
	{$ENDC}

{
 *  AEDeleteParam()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEDeleteParam(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $A816;
	{$ENDC}



{*************************************************************************
 The following calls also apply to type AppleEvent. Message attributes are
 far more restricted, and can only be accessed through the following 5
 calls. The various list and record routines cannot be used to access the
 attributes of an event. 
*************************************************************************}
{
 *  AEGetAttributePtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetAttributePtr({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E15, $A816;
	{$ENDC}

{
 *  AEGetAttributeDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetAttributeDesc({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR result: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0826, $A816;
	{$ENDC}

{
 *  AESizeOfAttribute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AESizeOfAttribute({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0828, $A816;
	{$ENDC}

{
 *  AEPutAttributePtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEPutAttributePtr(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A16, $A816;
	{$ENDC}

{
 *  AEPutAttributeDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEPutAttributeDesc(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0627, $A816;
	{$ENDC}


{*************************************************************************
 AppleEvent Serialization Support

    AESizeOfFlattenedDesc, AEFlattenDesc, AEUnflattenDesc
    
    These calls will work for all AppleEvent data types and between different
    versions of the OS (including between Mac OS 9 and X)
    
    Basic types, AEDesc, AEList and AERecord are OK, but AppleEvent records
    themselves may not be reliably flattened for storage.
*************************************************************************}
{
   AEFlattenDesc
   Returns the amount of buffer space needed to flatten the
   AEDesc. Call this before AEFlattenDesc to make sure your
   buffer has enough room for the operation.
}

{
 *  AESizeOfFlattenedDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AESizeOfFlattenedDesc({CONST}VAR theAEDesc: AEDesc): Size; C;

{
   AEFlattenDesc
   Fills a buffer with a flattened representation of the
   AEDesc and returns the amount of buffer used in actualSize.
   If bufferSize was too small it returns errAEBufferTooSmall
   (-1741) and does not fill in any of the buffer. The resulting
   buffer is only useful with an AEUnflattenDesc call.
   
   Note: if you pass a NULL buffer pointer it returns noErr but
   fills in the actualSize field anyway.
}

{
 *  AEFlattenDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEFlattenDesc({CONST}VAR theAEDesc: AEDesc; buffer: Ptr; bufferSize: Size; VAR actualSize: Size): OSStatus; C;

{
   AEUnflattenDesc
   Allocates an AEDesc (given a Null Desc) given a flattened
   data buffer. It assumes it was given a good buffer filled
   in by AEFlattenDesc. It returns paramErr if it discovers
   something fishy about the buffer.
}

{
 *  AEUnflattenDesc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEUnflattenDesc(buffer: Ptr; VAR result: AEDesc): OSStatus; C;

{*************************************************************************
 The following calls are necessary to deal with opaque data in AEDescs, because the
 traditional way of dealing with a basic AEDesc has been to dereference the dataHandle
 directly.  This is not supported under Carbon.
*************************************************************************}
{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{
        AEGetDescData no longer supports automatic coercion. If you'd like to
        coerce the descriptor use AECoerceDesc.
    }
{
 *  AEGetDescData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetDescData({CONST}VAR theAEDesc: AEDesc; dataPtr: UNIV Ptr; maximumSize: Size): OSErr;

{
 *  AEGetDescDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetDescDataSize({CONST}VAR theAEDesc: AEDesc): Size;

{
 *  AEReplaceDescData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEReplaceDescData(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; VAR theAEDesc: AEDesc): OSErr;

{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}


{*************************************************************************
  A AEEventHandler is installed to process an AppleEvent 
*************************************************************************}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	AEEventHandlerProcPtr = FUNCTION({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; handlerRefcon: LONGINT): OSErr;
{$ELSEC}
	AEEventHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	AEEventHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AEEventHandlerUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppAEEventHandlerProcInfo = $00000FE0;
	{
	 *  NewAEEventHandlerUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewAEEventHandlerUPP(userRoutine: AEEventHandlerProcPtr): AEEventHandlerUPP; { old name was NewAEEventHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeAEEventHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAEEventHandlerUPP(userUPP: AEEventHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeAEEventHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeAEEventHandlerUPP({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; handlerRefcon: LONGINT; userRoutine: AEEventHandlerUPP): OSErr; { old name was CallAEEventHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEDataModelIncludes}

{$ENDC} {__AEDATAMODEL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
