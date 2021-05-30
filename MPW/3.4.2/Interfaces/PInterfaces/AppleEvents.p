{
 	File:		AppleEvents.p
 
 	Contains:	AppleEvent Package Interfaces.
 
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
 UNIT AppleEvents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLEEVENTS__}
{$SETC __APPLEEVENTS__ := 1}

{$I+}
{$SETC AppleEventsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{	MixedMode.p													}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{	Quickdraw.p													}
{		QuickdrawText.p											}

{$IFC UNDEFINED __EPPC__}
{$I EPPC.p}
{$ENDC}
{	AppleTalk.p													}
{	Files.p														}
{		Finder.p												}
{	PPCToolbox.p												}
{	Processes.p													}

{$IFC UNDEFINED __NOTIFICATION__}
{$I Notification.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ Apple event descriptor types }
	typeBoolean					= 'bool';
	typeChar					= 'TEXT';
	typeSMInt					= 'shor';
	typeInteger					= 'long';
	typeSMFloat					= 'sing';
	typeFloat					= 'doub';
	typeLongInteger				= 'long';
	typeShortInteger			= 'shor';
	typeLongFloat				= 'doub';
	typeShortFloat				= 'sing';
	typeExtended				= 'exte';
	typeComp					= 'comp';
	typeMagnitude				= 'magn';
	typeAEList					= 'list';
	typeAERecord				= 'reco';
	typeAppleEvent				= 'aevt';
	typeTrue					= 'true';
	typeFalse					= 'fals';
	typeAlias					= 'alis';
	typeEnumerated				= 'enum';
	typeType					= 'type';
	typeAppParameters			= 'appa';
	typeProperty				= 'prop';
	typeFSS						= 'fss ';
	typeKeyword					= 'keyw';
	typeSectionH				= 'sect';
	typeWildCard				= '****';
	typeApplSignature			= 'sign';
	typeQDRectangle				= 'qdrt';
	typeFixed					= 'fixd';
	typeSessionID				= 'ssid';
	typeTargetID				= 'targ';
	typeProcessSerialNumber		= 'psn ';
	typeNull					= 'null';						{ null or nonexistent data }
{ Keywords for Apple event parameters }
	keyDirectObject				= '----';
	keyErrorNumber				= 'errn';
	keyErrorString				= 'errs';
	keyProcessSerialNumber		= 'psn ';
{ Keywords for Apple event attributes }
	keyTransactionIDAttr		= 'tran';
	keyReturnIDAttr				= 'rtid';
	keyEventClassAttr			= 'evcl';
	keyEventIDAttr				= 'evid';
	keyAddressAttr				= 'addr';
	keyOptionalKeywordAttr		= 'optk';
	keyTimeoutAttr				= 'timo';
	keyInteractLevelAttr		= 'inte';						{ this attribute is read only - will be set in AESend }
	keyEventSourceAttr			= 'esrc';						{ this attribute is read only }
	keyMissedKeywordAttr		= 'miss';						{ this attribute is read only }
	keyOriginalAddressAttr		= 'from';						{ new in 1.0.1 }
{ Keywords for special handlers }
	keyPreDispatch				= 'phac';						{ preHandler accessor call }
	keySelectProc				= 'selh';						{ more selector call }
{ Keyword for recording }
	keyAERecorderCount			= 'recr';						{ available only in vers 1.0.1 and greater }
{ Keyword for version information }
	keyAEVersion				= 'vers';						{ available only in vers 1.0.1 and greater }
{ Event Class }
	kCoreEventClass				= 'aevt';
{ Event ID’s }
	kAEOpenApplication			= 'oapp';
	kAEOpenDocuments			= 'odoc';
	kAEPrintDocuments			= 'pdoc';
	kAEQuitApplication			= 'quit';
	kAEAnswer					= 'ansr';
	kAEApplicationDied			= 'obit';

{ Constants for use in AESend mode }
	kAENoReply					= $00000001;					{ sender doesn't want a reply to event }
	kAEQueueReply				= $00000002;					{ sender wants a reply but won't wait }
	kAEWaitReply				= $00000003;					{ sender wants a reply and will wait }
	kAENeverInteract			= $00000010;					{ server should not interact with user }
	kAECanInteract				= $00000020;					{ server may try to interact with user }
	kAEAlwaysInteract			= $00000030;					{ server should always interact with user where appropriate }
	kAECanSwitchLayer			= $00000040;					{ interaction may switch layer }
	kAEDontReconnect			= $00000080;					{ don't reconnect if there is a sessClosedErr from PPCToolbox }
	kAEWantReceipt				= nReturnReceipt;				{ sender wants a receipt of message }
	kAEDontRecord				= $00001000;					{ don't record this event - available only in vers 1.0.1 and greater }
	kAEDontExecute				= $00002000;					{ don't send the event for recording - available only in vers 1.0.1 and greater }
{ Constants for the send priority in AESend }
	kAENormalPriority			= $00000000;					{ post message at the end of the event queue }
	kAEHighPriority				= nAttnMsg;						{ post message at the front of the event queue }

{ Constants for recording }
	kAEStartRecording			= 'reca';						{ available only in vers 1.0.1 and greater }
	kAEStopRecording			= 'recc';						{ available only in vers 1.0.1 and greater }
	kAENotifyStartRecording		= 'rec1';						{ available only in vers 1.0.1 and greater }
	kAENotifyStopRecording		= 'rec0';						{ available only in vers 1.0.1 and greater }
	kAENotifyRecording			= 'recr';

{ Constant for the returnID param of AECreateAppleEvent }
	kAutoGenerateReturnID		= -1;							{ AECreateAppleEvent will generate a session-unique ID }
{ Constant for transaction ID’s }
	kAnyTransactionID			= 0;							{ no transaction is in use }
{ Constants for timeout durations }
	kAEDefaultTimeout			= -1;							{ timeout value determined by AEM }
	kNoTimeOut					= -2;							{ wait until reply comes back, however long it takes }

{ Constants for AEResumeTheCurrentEvent }
	kAENoDispatch				= 0;							{ dispatch parameter to AEResumeTheCurrentEvent takes a pointer to a dispatch }
	kAEUseStandardDispatch		= $FFFFFFFF;					{ table, or one of these two constants }
{ Constants for Refcon in AEResumeTheCurrentEvent with kAEUseStandardDispatch }
	kAEDoNotIgnoreHandler		= $00000000;
	kAEIgnoreAppPhacHandler		= $00000001;					{ available only in vers 1.0.1 and greater }
	kAEIgnoreAppEventHandler	= $00000002;					{ available only in vers 1.0.1 and greater }
	kAEIgnoreSysPhacHandler		= $00000004;					{ available only in vers 1.0.1 and greater }
	kAEIgnoreSysEventHandler	= $00000008;					{ available only in vers 1.0.1 and greater }
	kAEIngoreBuiltInEventHandler = $00000010;					{ available only in vers 1.0.1 and greater }
	kAEDontDisposeOnResume		= $80000000;					{ available only in vers 1.0.1 and greater }

{ Apple event manager data types }
	
TYPE
	AEEventClass = FourCharCode;

	AEEventID = FourCharCode;

	AEKeyword = FourCharCode;

	DescType = ResType;

	AEDesc = RECORD
		descriptorType:			DescType;
		dataHandle:				Handle;
	END;

	AEKeyDesc = RECORD
		descKey:				AEKeyword;
		descContent:			AEDesc;
	END;

{ an AEDesc which contains address data }
	AEAddressDesc = AEDesc;

{ a list of AEDesc's is a special kind of AEDesc }
	AEDescList = AEDesc;

{ AERecord is a list of keyworded AEDesc's }
	AERecord = AEDescList;

{ an AERecord that contains an AppleEvent }
	AppleEvent = AERecord;

	AESendMode = LONGINT;

{ priority param of AESend }
	AESendPriority = INTEGER;


CONST
	kAEInteractWithSelf			= 0;
	kAEInteractWithLocal		= 1;
	kAEInteractWithAll			= 2;

	
TYPE
	AEInteractAllowed = SInt8;


CONST
	kAEUnknownSource			= 0;
	kAEDirectCall				= 1;
	kAESameProcess				= 2;
	kAELocalProcess				= 3;
	kAERemoteProcess			= 4;

	
TYPE
	AEEventSource = SInt8;


CONST
	kAEDataArray				= 0;
	kAEPackedArray				= 1;
	kAEHandleArray				= 2;
	kAEDescArray				= 3;
	kAEKeyDescArray				= 4;

	
TYPE
	AEArrayType = SInt8;

	AEArrayData = RECORD
		CASE INTEGER OF
		0: (
			kAEDataArray:				ARRAY [0..0] OF INTEGER;
		   );
		1: (
			kAEPackedArray:				PACKED ARRAY [0..0] OF CHAR;
		   );
		2: (
			kAEHandleArray:				ARRAY [0..0] OF Handle;
		   );
		3: (
			kAEDescArray:				ARRAY [0..0] OF AEDesc;
		   );
		4: (
			kAEKeyDescArray:			ARRAY [0..0] OF AEKeyDesc;
		   );
	END;

	AEArrayDataPointer = ^AEArrayData;

	AEIdleProcPtr = ProcPtr;  { FUNCTION AEIdle(VAR theEvent: EventRecord; VAR sleepTime: LONGINT; VAR mouseRgn: RgnHandle): BOOLEAN; }
	AEFilterProcPtr = ProcPtr;  { FUNCTION AEFilter(VAR theEvent: EventRecord; returnID: LONGINT; transactionID: LONGINT; (CONST)VAR sender: AEAddressDesc): BOOLEAN; }
	AEEventHandlerProcPtr = ProcPtr;  { FUNCTION AEEventHandler((CONST)VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; handlerRefcon: LONGINT): OSErr; }
	AECoerceDescProcPtr = ProcPtr;  { FUNCTION AECoerceDesc((CONST)VAR fromDesc: AEDesc; toType: DescType; handlerRefcon: LONGINT; VAR toDesc: AEDesc): OSErr; }
	AECoercePtrProcPtr = ProcPtr;  { FUNCTION AECoercePtr(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; toType: DescType; handlerRefcon: LONGINT; VAR result: AEDesc): OSErr; }
	AEIdleUPP = UniversalProcPtr;
	AEFilterUPP = UniversalProcPtr;
	AEEventHandlerUPP = UniversalProcPtr;
	AECoerceDescUPP = UniversalProcPtr;
	AECoercePtrUPP = UniversalProcPtr;

CONST
	uppAEIdleProcInfo = $00000FD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppAEFilterProcInfo = $00003FD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 1 byte result; }
	uppAEEventHandlerProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppAECoerceDescProcInfo = $00003FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppAECoercePtrProcInfo = $0003FFE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewAEIdleProc(userRoutine: AEIdleProcPtr): AEIdleUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewAEFilterProc(userRoutine: AEFilterProcPtr): AEFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewAEEventHandlerProc(userRoutine: AEEventHandlerProcPtr): AEEventHandlerUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewAECoerceDescProc(userRoutine: AECoerceDescProcPtr): AECoerceDescUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewAECoercePtrProc(userRoutine: AECoercePtrProcPtr): AECoercePtrUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallAEIdleProc(VAR theEvent: EventRecord; VAR sleepTime: LONGINT; VAR mouseRgn: RgnHandle; userRoutine: AEIdleUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallAEFilterProc(VAR theEvent: EventRecord; returnID: LONGINT; transactionID: LONGINT; {CONST}VAR sender: AEAddressDesc; userRoutine: AEFilterUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallAEEventHandlerProc({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; handlerRefcon: LONGINT; userRoutine: AEEventHandlerUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallAECoerceDescProc({CONST}VAR fromDesc: AEDesc; toType: DescType; handlerRefcon: LONGINT; VAR toDesc: AEDesc; userRoutine: AECoerceDescUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallAECoercePtrProc(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; toType: DescType; handlerRefcon: LONGINT; VAR result: AEDesc; userRoutine: AECoercePtrUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	AECoercionHandlerUPP = UniversalProcPtr;

{*************************************************************************
 The following calls apply to any AEDesc. Every 'result' descriptor is
 created for you, so you will be responsible for memory management
 (including disposing) of the descriptors so created. Note: purgeable
 descriptor data is not supported - the AEM does not call LoadResource.  
*************************************************************************}

FUNCTION AECreateDesc(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; VAR result: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0825, $A816;
	{$ENDC}
FUNCTION AECoercePtr(typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size; toType: DescType; VAR result: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A02, $A816;
	{$ENDC}
FUNCTION AECoerceDesc({CONST}VAR theAEDesc: AEDesc; toType: DescType; VAR result: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0603, $A816;
	{$ENDC}
FUNCTION AEDisposeDesc(VAR theAEDesc: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0204, $A816;
	{$ENDC}
FUNCTION AEDuplicateDesc({CONST}VAR theAEDesc: AEDesc; VAR result: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0405, $A816;
	{$ENDC}
{*************************************************************************
  The following calls apply to AEDescList. Since AEDescList is a subtype of
  AEDesc, the calls in the previous section can also be used for AEDescList.
  All list and array indices are 1-based. If the data was greater than
  maximumSize in the routines below, then actualSize will be greater than
  maximumSize, but only maximumSize bytes will actually be retrieved.
*************************************************************************}
FUNCTION AECreateList(factoringPtr: UNIV Ptr; factoredSize: Size; isRecord: BOOLEAN; VAR resultList: AEDescList): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0706, $A816;
	{$ENDC}
FUNCTION AECountItems({CONST}VAR theAEDescList: AEDescList; VAR theCount: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0407, $A816;
	{$ENDC}
FUNCTION AEPutPtr(VAR theAEDescList: AEDescList; index: LONGINT; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A08, $A816;
	{$ENDC}
FUNCTION AEPutDesc(VAR theAEDescList: AEDescList; index: LONGINT; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0609, $A816;
	{$ENDC}
FUNCTION AEGetNthPtr({CONST}VAR theAEDescList: AEDescList; index: LONGINT; desiredType: DescType; VAR theAEKeyword: AEKeyword; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $100A, $A816;
	{$ENDC}
FUNCTION AEGetNthDesc({CONST}VAR theAEDescList: AEDescList; index: LONGINT; desiredType: DescType; VAR theAEKeyword: AEKeyword; VAR result: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A0B, $A816;
	{$ENDC}
FUNCTION AESizeOfNthItem({CONST}VAR theAEDescList: AEDescList; index: LONGINT; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $082A, $A816;
	{$ENDC}
FUNCTION AEGetArray({CONST}VAR theAEDescList: AEDescList; arrayType: ByteParameter; arrayPtr: AEArrayDataPointer; maximumSize: Size; VAR itemType: DescType; VAR itemSize: Size; VAR itemCount: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0D0C, $A816;
	{$ENDC}
FUNCTION AEPutArray(VAR theAEDescList: AEDescList; arrayType: ByteParameter; {CONST}VAR arrayPtr: AEArrayData; itemType: DescType; itemSize: Size; itemCount: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0B0D, $A816;
	{$ENDC}
FUNCTION AEDeleteItem(VAR theAEDescList: AEDescList; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040E, $A816;
	{$ENDC}
{*************************************************************************
 The following calls apply to AERecord. Since AERecord is a subtype of
 AEDescList, the calls in the previous sections can also be used for
 AERecord an AERecord can be created by using AECreateList with isRecord
 set to true. 
*************************************************************************}
{
  Note: none of the “key” calls are currently available in the PowerPC IntefaceLib.
  In C, a #define is used to map “key” calls to “param” calls.  In pascal
  this mapping is done in externally linked glue code. 
  See AppleEvents.h for more details.
}
FUNCTION AEPutKeyPtr(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A0F, $A816;
	{$ENDC}
FUNCTION AEPutKeyDesc(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0610, $A816;
	{$ENDC}
FUNCTION AEGetKeyPtr({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0E11, $A816;
	{$ENDC}
FUNCTION AEGetKeyDesc({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR result: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0812, $A816;
	{$ENDC}
FUNCTION AESizeOfKeyDesc({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0829, $A816;
	{$ENDC}
FUNCTION AEDeleteKeyDesc(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0413, $A816;
	{$ENDC}
{*************************************************************************
  The following calls are used to pack and unpack parameters from records
  of type AppleEvent. Since AppleEvent is a subtype of AERecord, the calls
  in the previous sections can also be used for variables of type
  AppleEvent. The next six calls are in fact identical to the six calls
  for AERecord.
*************************************************************************}
FUNCTION AEPutParamPtr(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A0F, $A816;
	{$ENDC}
FUNCTION AEPutParamDesc(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0610, $A816;
	{$ENDC}
FUNCTION AEGetParamPtr({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0E11, $A816;
	{$ENDC}
FUNCTION AEGetParamDesc({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR result: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0812, $A816;
	{$ENDC}
FUNCTION AESizeOfParam({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0829, $A816;
	{$ENDC}
FUNCTION AEDeleteParam(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0413, $A816;
	{$ENDC}
{*************************************************************************
 The following calls also apply to type AppleEvent. Message attributes are
 far more restricted, and can only be accessed through the following 5
 calls. The various list and record routines cannot be used to access the
 attributes of an event. 
*************************************************************************}
FUNCTION AEGetAttributePtr({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR typeCode: DescType; dataPtr: UNIV Ptr; maximumSize: Size; VAR actualSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0E15, $A816;
	{$ENDC}
FUNCTION AEGetAttributeDesc({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; desiredType: DescType; VAR result: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0826, $A816;
	{$ENDC}
FUNCTION AESizeOfAttribute({CONST}VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0828, $A816;
	{$ENDC}
FUNCTION AEPutAttributePtr(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; typeCode: DescType; dataPtr: UNIV Ptr; dataSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A16, $A816;
	{$ENDC}
FUNCTION AEPutAttributeDesc(VAR theAppleEvent: AppleEvent; theAEKeyword: AEKeyword; {CONST}VAR theAEDesc: AEDesc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0627, $A816;
	{$ENDC}
{*************************************************************************
  The next couple of calls are basic routines used to create, send,
  and process AppleEvents. 
*************************************************************************}
FUNCTION AECreateAppleEvent(theAEEventClass: AEEventClass; theAEEventID: AEEventID; {CONST}VAR target: AEAddressDesc; returnID: INTEGER; transactionID: LONGINT; VAR result: AppleEvent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0B14, $A816;
	{$ENDC}
FUNCTION AESend({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; sendMode: AESendMode; sendPriority: AESendPriority; timeOutInTicks: LONGINT; idleProc: AEIdleUPP; filterProc: AEFilterUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0D17, $A816;
	{$ENDC}
FUNCTION AEProcessAppleEvent({CONST}VAR theEventRecord: EventRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $021B, $A816;
	{$ENDC}
{ 
 Note: during event processing, an event handler may realize that it is likely
 to exceed the client's timeout limit. Passing the reply to this
 routine causes a wait event to be generated that asks the client
 for more time. 
}
FUNCTION AEResetTimer({CONST}VAR reply: AppleEvent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0219, $A816;
	{$ENDC}
{*************************************************************************
 The following four calls are available for applications which need more
 sophisticated control over when and how events are processed. Applications
 which implement multi-session servers or which implement their own
 internal event queueing will probably be the major clients of these
 routines. They can be called from within a handler to prevent the AEM from
 disposing of the AppleEvent when the handler returns. They can be used to
 asynchronously process the event (as MacApp does).
*************************************************************************}
FUNCTION AESuspendTheCurrentEvent({CONST}VAR theAppleEvent: AppleEvent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $022B, $A816;
	{$ENDC}
{ 
 Note: The following routine tells the AppleEvent manager that processing
 is either about to resume or has been completed on a previously suspended
 event. The procPtr passed in as the dispatcher parameter will be called to
 attempt to redispatch the event. Several constants for the dispatcher
 parameter allow special behavior. They are:
  	- kAEUseStandardDispatch means redispatch as if the event was just
	  received, using the standard AppleEvent dispatch mechanism.
  	- kAENoDispatch means ignore the parameter.
   	  Use this in the case where the event has been handled and no
	  redispatch is needed.
  	- non nil means call the routine which the dispatcher points to.
}
FUNCTION AEResumeTheCurrentEvent({CONST}VAR theAppleEvent: AppleEvent; {CONST}VAR reply: AppleEvent; dispatcher: AEEventHandlerUPP; handlerRefcon: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0818, $A816;
	{$ENDC}
FUNCTION AEGetTheCurrentEvent(VAR theAppleEvent: AppleEvent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $021A, $A816;
	{$ENDC}
FUNCTION AESetTheCurrentEvent({CONST}VAR theAppleEvent: AppleEvent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $022C, $A816;
	{$ENDC}
{*************************************************************************
  The following three calls are used to allow applications to behave
  courteously when a user interaction such as a dialog box is needed. 
*************************************************************************}
FUNCTION AEGetInteractionAllowed(VAR level: AEInteractAllowed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $021D, $A816;
	{$ENDC}
FUNCTION AESetInteractionAllowed(level: ByteParameter): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $011E, $A816;
	{$ENDC}
FUNCTION AEInteractWithUser(timeOutInTicks: LONGINT; nmReqPtr: NMRecPtr; idleProc: AEIdleUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $061C, $A816;
	{$ENDC}
{*************************************************************************
  These calls are used to set up and modify the event dispatch table.
*************************************************************************}
FUNCTION AEInstallEventHandler(theAEEventClass: AEEventClass; theAEEventID: AEEventID; handler: AEEventHandlerUPP; handlerRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $091F, $A816;
	{$ENDC}
FUNCTION AERemoveEventHandler(theAEEventClass: AEEventClass; theAEEventID: AEEventID; handler: AEEventHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0720, $A816;
	{$ENDC}
FUNCTION AEGetEventHandler(theAEEventClass: AEEventClass; theAEEventID: AEEventID; VAR handler: AEEventHandlerUPP; VAR handlerRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0921, $A816;
	{$ENDC}
{*************************************************************************
  These calls are used to set up and modify the coercion dispatch table.
*************************************************************************}
FUNCTION AEInstallCoercionHandler(fromType: DescType; toType: DescType; handler: AECoercionHandlerUPP; handlerRefcon: LONGINT; fromTypeIsDesc: BOOLEAN; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A22, $A816;
	{$ENDC}
FUNCTION AERemoveCoercionHandler(fromType: DescType; toType: DescType; handler: AECoercionHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0723, $A816;
	{$ENDC}
FUNCTION AEGetCoercionHandler(fromType: DescType; toType: DescType; VAR handler: AECoercionHandlerUPP; VAR handlerRefcon: LONGINT; VAR fromTypeIsDesc: BOOLEAN; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0B24, $A816;
	{$ENDC}
{*************************************************************************
  These calls are used to set up and modify special hooks into the
  AppleEvent manager.
*************************************************************************}
FUNCTION AEInstallSpecialHandler(functionClass: AEKeyword; handler: UniversalProcPtr; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0500, $A816;
	{$ENDC}
FUNCTION AERemoveSpecialHandler(functionClass: AEKeyword; handler: UniversalProcPtr; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0501, $A816;
	{$ENDC}
FUNCTION AEGetSpecialHandler(functionClass: AEKeyword; VAR handler: UniversalProcPtr; isSysHandler: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $052D, $A816;
	{$ENDC}
{*************************************************************************
  This call was added in version 1.0.1. If called with the keyword
  keyAERecorderCount ('recr'), the number of recorders that are
  currently active is returned in 'result'.
*************************************************************************}
{ available only in vers 1.0.1 and greater }
FUNCTION AEManagerInfo(keyWord: AEKeyword; VAR result: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0441, $A816;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleEventsIncludes}

{$ENDC} {__APPLEEVENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
