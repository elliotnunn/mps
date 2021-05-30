{
   Created: Monday, September 16, 1991 at 2:41 PM
   AppleEvents.p
   Pascal Interface to the Macintosh Libraries

   Copyright Apple Computer, Inc. 1989-1992
   All rights reserved
 
   Modified for AppleEvents manager version 1.0.1 July 31st, 1992
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AppleEvents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingAppleEvents}
{$SETC UsingAppleEvents := 1}

{$I+}
{$SETC AppleEventsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingMemory}
{$I $$Shell(PInterfaces)Memory.p}
{$ENDC}
{$IFC UNDEFINED UsingOSUtils}
{$I $$Shell(PInterfaces)OSUtils.p}
{$ENDC}
{$IFC UNDEFINED UsingEvents}
{$I $$Shell(PInterfaces)Events.p}
{$ENDC}
{$IFC UNDEFINED UsingEPPC}
{$I $$Shell(PInterfaces)EPPC.p}
{$ENDC}
{$IFC UNDEFINED UsingNotification}
{$I $$Shell(PInterfaces)Notification.p}
{$ENDC}
{$SETC UsingIncludes := AppleEventsIncludes}

(*--------------------------------------------------------------
		Apple event descriptor types
--------------------------------------------------------------*)

CONST

typeBoolean = 'bool';
typeChar = 'TEXT';
typeSMInt = 'shor';
typeInteger = 'long';
typeSMFloat = 'sing';
typeFloat = 'doub';
typeLongInteger = 'long';
typeShortInteger = 'shor';
typeLongFloat = 'doub';
typeShortFloat = 'sing';
typeExtended = 'exte';
typeComp = 'comp';
typeMagnitude = 'magn';
typeAEList = 'list';
typeAERecord = 'reco';
typeAppleEvent = 'aevt';
typeTrue = 'true';
typeFalse = 'fals';
typeAlias = 'alis';
typeEnumerated = 'enum';
typeType = 'type';
typeAppParameters = 'appa';
typeProperty = 'prop';
typeFSS = 'fss ';
typeKeyword = 'keyw';
typeSectionH = 'sect';
typeWildCard = '****';
typeApplSignature = 'sign';
typeSessionID = 'ssid';
typeTargetID = 'targ';
typeProcessSerialNumber = 'psn ';
typeNull = 'null';											{ null/nonexistent data }


(*--------------------------------------------------------------
		Keywords for Apple event parameters
--------------------------------------------------------------*)

keyDirectObject = '----';
keyErrorNumber = 'errn';
keyErrorString = 'errs';
keyProcessSerialNumber = 'psn ';

(*--------------------------------------------------------------
		Keywords for Apple event attributes
--------------------------------------------------------------*)

keyTransactionIDAttr = 'tran';
keyReturnIDAttr = 'rtid';
keyEventClassAttr = 'evcl';
keyEventIDAttr = 'evid';
keyAddressAttr = 'addr';
keyOptionalKeywordAttr = 'optk';
keyTimeoutAttr = 'timo';
keyInteractLevelAttr = 'inte';								{ this attribute is read only - will be set in AESend }
keyEventSourceAttr = 'esrc';								{ this attribute is read only }
keyMissedKeywordAttr = 'miss';								{ this attribute is read only }
keyOriginalAddressAttr = 'from';							{ new in 1.0.1 }

(*--------------------------------------------------------------
		Keywords for special handlers
--------------------------------------------------------------*)

keyPreDispatch = 'phac';									{ preHandler accessor Call }
keySelectProc = 'selh';										{ more selector call }

(*--------------------------------------------------------------
		Keyword for recording
--------------------------------------------------------------*)

keyAERecorderCount = 'recr';								{ available only in vers 1.0.1 and greater }

(*--------------------------------------------------------------
		Keyword for version information
--------------------------------------------------------------*)

keyAEVersion = 'vers';										{ available only in vers 1.0.1 and greater }

(*--------------------------------------------------------------
		Event Class
--------------------------------------------------------------*)

kCoreEventClass = 'aevt';

(*--------------------------------------------------------------
		Event ID's
--------------------------------------------------------------*)

kAEOpenApplication = 'oapp';
kAEOpenDocuments = 'odoc';
kAEPrintDocuments = 'pdoc';
kAEQuitApplication = 'quit';
kAEAnswer = 'ansr';
kAEApplicationDied = 'obit';

(*--------------------------------------------------------------
		Constants for use in AESend mode
--------------------------------------------------------------*)

kAENoReply = $00000001;										{ sender doesn't want a reply to the event }
kAEQueueReply = $00000002;									{ sender wants a reply but won't wait }
kAEWaitReply = $00000003;									{ sender wants a reply and will be waiting }
kAENeverInteract = $00000010;								{ server should not interact with user }
kAECanInteract = $00000020;									{ server may try to interact with user }
kAEAlwaysInteract = $00000030;								{ server should always interact with user where appropriate }
kAECanSwitchLayer = $00000040;								{ interaction may switch layer }
kAEDontReconnect = $00000080;								{ don't reconnect if there is a sessClosedErr from PPCToolbox }
kAEWantReceipt = nReturnReceipt;							{ send wants a receipt of message }
kAEDontRecord = $00001000;									{ don't record this event - available only in vers 1.0.1 and greater }
kAEDontExecute = $00002000;									{ don't send the event for recording - available only in vers 1.0.1 and greater }

(*--------------------------------------------------------------
		Constants for the send priority in AESend
--------------------------------------------------------------*)

kAENormalPriority = $00000000;								{ post message at the end of the event queue }
kAEHighPriority = nAttnMsg;									{ post message at the front of the event queue }

(*--------------------------------------------------------------
		Constants for recording
--------------------------------------------------------------*)

kAEStartRecording = 'reca';									{ available only in vers 1.0.1 and greater }
kAEStopRecording = 'recc';									{ available only in vers 1.0.1 and greater }
kAENotifyStartRecording = 'rec1';							{ available only in vers 1.0.1 and greater }
kAENotifyStopRecording = 'rec0';							{ available only in vers 1.0.1 and greater }
kAENotifyRecording = 'recr';								{ available only in vers 1.0.1 and greater }

(*--------------------------------------------------------------
		Constant for the returnID param of AECreateAppleEvent
--------------------------------------------------------------*)

kAutoGenerateReturnID = -1;									{ AECreateAppleEvent will generate a session-unique ID }

(*--------------------------------------------------------------
		Constant for transaction ID's
--------------------------------------------------------------*)

kAnyTransactionID = 0;										{ no transaction is in use }

(*--------------------------------------------------------------
		Constants for timeout durations
--------------------------------------------------------------*)

kAEDefaultTimeout = -1;										{ timeout value determined by AEM }
kNoTimeOut = -2;											{ wait until reply comes back, however long it takes }

(*--------------------------------------------------------------
		Constants for AEResumeTheCurrentEvent
--------------------------------------------------------------*)

kAENoDispatch = 0;
kAEUseStandardDispatch = -1;


(*--------------------------------------------------------------
		Apple event manager error messages
--------------------------------------------------------------*)

errAECoercionFail 			= -1700;						{ bad parameter data or unable to coerce the data supplied }
errAEDescNotFound 			= -1701;
errAECorruptData 			= -1702;
errAEWrongDataType 			= -1703;
errAENotAEDesc 				= -1704;
errAEBadListItem 			= -1705;						{ specified list item does not exist }
errAENewerVersion 			= -1706;						{ need newer version of AppleEvent Manager }
errAENotAppleEvent 			= -1707;						{ the event is not in AppleEvent format }
errAEEventNotHandled 		= -1708;						{ the AppleEvent was not handled by any handler }
errAEReplyNotValid 			= -1709;						{ AEResetTimer was passed an invalid reply parameter }
errAEUnknownSendMode 		= -1710;						{ mode wasn't NoReply, WaitReply, or QueueReply - or Interaction level is unknown }
errAEWaitCanceled 			= -1711;						{ in AESend, user cancelled out of wait loop for reply or receipt }
errAETimeout 				= -1712;						{ the AppleEvent timed out }
errAENoUserInteraction 		= -1713;						{ no user interaction is allowed }
errAENotASpecialFunction 	= -1714;						{ there is no special function with this keyword }
errAEParamMissed 			= -1715;						{ a required parameter was not accessed }
errAEUnknownAddressType 	= -1716;						{ the target address type is not known }
errAEHandlerNotFound 		= -1717;						{ no handler in the dispatch tables fits the parameters to AEGetEventHandler or AEGetCoercionHandler }
errAEReplyNotArrived 		= -1718;						{ the contents of the reply you are accessing have not yet arrived }
errAEIllegalIndex 			= -1719;						{ index is out of range in a put operation }
errAEUnknownObjectType		= -1731;						{ available only in version 1.0.1 or greater }
errAERecordingIsAlreadyOn	= -1732;						{ available only in version 1.0.1 or greater }


(*--------------------------------------------------------------
		Apple event manager data types
--------------------------------------------------------------*)

TYPE

AEEventClass = PACKED ARRAY [1..4] OF CHAR;
AEEventID = PACKED ARRAY [1..4] OF CHAR;
AEKeyword = PACKED ARRAY [1..4] OF CHAR;

DescType = ResType;

AEDesc = RECORD
 		   descriptorType: DescType;
 		   dataHandle: Handle;
 		 END;

AEKeyDesc = RECORD
 			  descKey: AEKeyword;
 			  descContent: AEDesc;
 			END;

AEAddressDesc = AEDesc;										{ an AEDesc which contains addressing data }
AEDescList = AEDesc;										{ a list of AEDesc is a special kind of AEDesc }
AERecord = AEDescList;										{ AERecord is a list of keyworded AEDesc }
AppleEvent = AERecord;										{ an AERecord that contains an AppleEvent }
AESendMode = LONGINT;										{ type of parameter to AESend }
AESendPriority = INTEGER;									{ type of priority param of AESend }

AEInteractAllowed = (kAEInteractWithSelf,kAEInteractWithLocal,
					 kAEInteractWithAll);

AEEventSource = (kAEUnknownSource,kAEDirectCall,kAESameProcess,		{ return param to AEGetTheCurrentEvent and kAEEventSource attribute }
				 kAELocalProcess,kAERemoteProcess);

AEArrayType = (kAEDataArray,kAEPackedArray,kAEHandleArray,kAEDescArray,
			   kAEKeyDescArray);

AEArrayData = RECORD
 				CASE AEArrayType OF
  				  kAEDataArray:
				  	(AEDataArray: ARRAY[0..0] OF Integer);
  				  kAEPackedArray:
				  	(AEPackedArray: PACKED ARRAY[0..0] OF Char);
  				  kAEHandleArray:
				  	(AEHandleArray: ARRAY[0..0] OF Handle);
  				  kAEDescArray:
				  	(AEDescArray: ARRAY[0..0] OF AEDesc);
  				  kAEKeyDescArray:
				  	(AEKeyDescArray: ARRAY[0..0] OF AEKeyDesc);
 				END;
 
AEArrayDataPointer = ^AEArrayData;

EventHandlerProcPtr = ProcPtr;
IdleProcPtr = ProcPtr;
EventFilterProcPtr = ProcPtr;


(**************************************************************************
 The following calls apply to any AEDesc. Every 'result' descriptor is
 created for you, so you will be responsible for memory management
 (including disposing) of the descriptors so created. Note: purgeable
 descriptor data is not supported - the AEM does not call LoadResource.  
**************************************************************************)

FUNCTION AECreateDesc(typeCode: DescType; dataPtr: Ptr; dataSize: Size;
			 		  VAR result: AEDesc): OSErr;
	INLINE $303C, $0825, $A816;
	
FUNCTION AECoercePtr(typeCode: DescType; dataPtr: Ptr; dataSize: Size;
                     toType: DescType; VAR result: AEDesc): OSErr;
	INLINE $303C, $0A02, $A816;
	
FUNCTION AECoerceDesc(theAEDesc: AEDesc; toType: DescType;
					  VAR result: AEDesc): OSErr;
	INLINE $303C, $0603, $A816;
	
FUNCTION AEDisposeDesc(VAR theAEDesc: AEDesc): OSErr;
	INLINE $303C, $0204, $A816;
	
FUNCTION AEDuplicateDesc(theAEDesc: AEDesc; VAR result: AEDesc): OSErr;
	INLINE $303C, $0405, $A816;

(**************************************************************************
  The following calls apply to AEDescList. Since AEDescList is a subtype of
  AEDesc, the calls in the previous section can also be used for AEDescList.
  All list and array indices are 1-based. If the data was greater than
  maximumSize in the routines below, then actualSize will be greater than
  maximumSize, but only maximumSize bytes will actually be retrieved.
**************************************************************************)

FUNCTION AECreateList(factoringPtr: Ptr; factoredSize: Size;
					  isRecord: BOOLEAN; VAR resultList: AEDescList): OSErr;
	INLINE $303C, $0706, $A816;

FUNCTION AECountItems(theAEDescList: AEDescList; VAR theCount: LONGINT): OSErr;
	INLINE $303C, $0407, $A816;

FUNCTION AEPutPtr(theAEDescList: AEDescList; index: LONGINT;
				  typeCode: DescType; dataPtr: Ptr; dataSize: Size): OSErr;
	INLINE $303C, $0A08, $A816;

FUNCTION AEPutDesc(theAEDescList: AEDescList; index: LONGINT;
                   theAEDesc: AEDesc): OSErr;
	INLINE $303C, $0609, $A816;
	
FUNCTION AEGetNthPtr(theAEDescList: AEDescList; index: LONGINT;
					 desiredType: DescType; VAR theAEKeyword: AEKeyword;
                     VAR typeCode: DescType; dataPtr: Ptr; maximumSize: Size;
                     VAR actualSize: Size): OSErr;
	INLINE $303C, $100A, $A816;

FUNCTION AEGetNthDesc(theAEDescList: AEDescList; index: LONGINT;
                      desiredType: DescType; VAR theAEKeyword: AEKeyword;
                      VAR result: AEDesc): OSErr;
	INLINE $303C, $0A0B, $A816;

FUNCTION AESizeOfNthItem(theAEDescList: AEDescList; index: LONGINT;
                         VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	INLINE $303C, $082A, $A816;
	
FUNCTION AEGetArray(theAEDescList: AEDescList; arrayType: AEArrayType;
                    arrayPtr: AEArrayDataPointer; maximumSize: Size;
                    VAR itemType: DescType; VAR itemSize: Size;
                    VAR itemCount: LONGINT): OSErr;
	INLINE $303C, $0D0C, $A816;

FUNCTION AEPutArray(theAEDescList: AEDescList; arrayType: AEArrayType;
                    arrayPtr: AEArrayDataPointer; itemType: DescType;
                    itemSize: Size; itemCount: LONGINT): OSErr;
	INLINE $303C, $0B0D, $A816;

FUNCTION AEDeleteItem(theAEDescList: AEDescList; index: LONGINT): OSErr;
	INLINE $303C, $040E, $A816;


(**************************************************************************
 The following calls apply to AERecord. Since AERecord is a subtype of
 AEDescList, the calls in the previous sections can also be used for
 AERecord an AERecord can be created by using AECreateList with isRecord
 set to true. 
**************************************************************************)

FUNCTION AEPutKeyPtr(theAERecord: AERecord; theAEKeyword: AEKeyword;
                     typeCode: DescType; dataPtr: Ptr; dataSize: Size): OSErr;
	INLINE $303C, $0A0F, $A816;

FUNCTION AEPutKeyDesc(theAERecord: AERecord; theAEKeyword: AEKeyword;
                      theAEDesc: AEDesc): OSErr;
	INLINE $303C, $0610, $A816;

FUNCTION AEGetKeyPtr(theAERecord: AERecord; theAEKeyword: AEKeyword;
                     desiredType: DescType; VAR typeCode: DescType;
                     dataPtr: Ptr; maximumSize: Size;
                     VAR actualSize: Size): OSErr;
	INLINE $303C, $0E11, $A816;

FUNCTION AEGetKeyDesc(theAERecord: AERecord; theAEKeyword: AEKeyword;
                      desiredType: DescType; VAR result: AEDesc): OSErr;
	INLINE $303C, $0812, $A816;

FUNCTION AESizeOfKeyDesc(theAERecord: AERecord; theAEKeyword: AEKeyword;
                         VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	INLINE $303C, $0829, $A816;

FUNCTION AEDeleteKeyDesc(theAERecord: AERecord; theAEKeyword: AEKeyword): OSErr;
	INLINE $303C, $0413, $A816;


(**************************************************************************
  The following calls are used to pack and unpack parameters from records
  of type AppleEvent. Since AppleEvent is a subtype of AERecord, the calls
  in the previous sections can also be used for variables of type
  AppleEvent. The next six calls are in fact identical to the six calls
  for AERecord.
**************************************************************************)

FUNCTION AEPutParamPtr(theAppleEvent: AppleEvent; theAEKeyword: AEKeyword;
                       typeCode: DescType; dataPtr: Ptr;
					   dataSize: Size): OSErr;
	INLINE $303C,$0A0F,$A816;

FUNCTION AEPutParamDesc(theAppleEvent: AppleEvent; theAEKeyword: AEKeyword;
                        theAEDesc: AEDesc): OSErr;
	INLINE $303C,$0610,$A816;
	
FUNCTION AEGetParamPtr(theAppleEvent: AppleEvent; theAEKeyword: AEKeyword;
                       desiredType: DescType; VAR typeCode: DescType;
                       dataPtr: Ptr; maximumSize: Size;
                       VAR actualSize: Size): OSErr;
	INLINE $303C,$0E11,$A816;
	
FUNCTION AEGetParamDesc(theAppleEvent: AppleEvent; theAEKeyword: AEKeyword;
                        desiredType: DescType; VAR result: AEDesc): OSErr;
	INLINE $303C,$0812,$A816;
	
FUNCTION AESizeOfParam(theAppleEvent: AppleEvent; theAEKeyword: AEKeyword;
                       VAR typeCode: DescType; VAR dataSize: Size): OSErr;
	INLINE $303C,$0829,$A816;
	
FUNCTION AEDeleteParam(theAppleEvent: AppleEvent;
					   theAEKeyword: AEKeyword): OSErr;
	INLINE $303C,$0413,$A816;

(**************************************************************************
 The following calls also apply to type AppleEvent. Message attributes are
 far more restricted, and can only be accessed through the following 5
 calls. The various list and record routines cannot be used to access the
 attributes of an event. 
**************************************************************************)

FUNCTION AEGetAttributePtr(theAppleEvent: AppleEvent;
						   theAEKeyword: AEKeyword; desiredType: DescType;
                           VAR typeCode: DescType; dataPtr: Ptr;
                           maximumSize: Size; VAR actualSize: Size): OSErr;
	INLINE $303C,$0E15,$A816;
	
FUNCTION AEGetAttributeDesc(theAppleEvent: AppleEvent;
							theAEKeyword: AEKeyword; desiredType: DescType;
                            VAR result: AEDesc): OSErr;
	INLINE $303C,$0826,$A816;
	
FUNCTION AESizeOfAttribute(theAppleEvent: AppleEvent;
						   theAEKeyword: AEKeyword; VAR typeCode: DescType;
                           VAR dataSize: Size): OSErr;
	INLINE $303C,$0828,$A816;
	
FUNCTION AEPutAttributePtr(theAppleEvent: AppleEvent;
                           theAEKeyword: AEKeyword; typeCode: DescType;
                           dataPtr: Ptr; dataSize: Size): OSErr;
	INLINE $303C,$0A16,$A816;
	
FUNCTION AEPutAttributeDesc(theAppleEvent: AppleEvent;
                            theAEKeyword: AEKeyword; theAEDesc: AEDesc): OSErr;
	INLINE $303C,$0627,$A816;

(**************************************************************************
  The next couple of calls are basic routines used to create, send,
  and process AppleEvents. 
**************************************************************************)

FUNCTION AECreateAppleEvent(theAEEventClass: AEEventClass;
                            theAEEventID: AEEventID; target: AEAddressDesc;
                            returnID: INTEGER; transactionID: LONGINT;
                            VAR result: AppleEvent): OSErr;
	INLINE $303C,$0B14,$A816;

FUNCTION AESend(theAppleEvent: AppleEvent; VAR reply: AppleEvent;
                sendMode: AESendMode; sendPriority: AESendPriority;
                timeOutInTicks: LONGINT; idleProc: IdleProcPtr;
                filterProc: EventFilterProcPtr): OSErr;
	INLINE $303C,$0D17,$A816;
 
FUNCTION AEProcessAppleEvent(theEventRecord: EventRecord): OSErr;
	INLINE $303C,$021B,$A816;

(* 
 Note: during event processing, an event handler may realize that it is
 likely to exceed the client's timeout limit. Passing the reply to this
 routine causes a wait event to be generated that asks the client
 for more time. 
*)

FUNCTION AEResetTimer(reply: AppleEvent): OSErr;
	INLINE $303C,$0219,$A816;

(**************************************************************************
 The following four calls are available for applications which need more
 sophisticated control over when and how events are processed. Applications
 which implement multi-session servers or which implement their own
 internal event queueing will probably be the major clients of these
 routines. They can be called from within a handler to prevent the AEM from
 disposing of the AppleEvent when the handler returns. They can be used to
 asynchronously process the event (as MacApp does).
**************************************************************************)

FUNCTION AESuspendTheCurrentEvent(theAppleEvent: AppleEvent): OSErr;
	INLINE $303C,$022B,$A816;

(* 
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
*)

FUNCTION AEResumeTheCurrentEvent(theAppleEvent: AppleEvent;
                                 reply: AppleEvent;
                                 dispatcher: EventHandlerProcPtr;
                                 handlerRefcon: LONGINT): OSErr;
	INLINE $303C,$0818,$A816;

FUNCTION AEGetTheCurrentEvent(VAR theAppleEvent: AppleEvent): OSErr;
	INLINE $303C,$021A,$A816;

FUNCTION AESetTheCurrentEvent(theAppleEvent: AppleEvent): OSErr;
	INLINE $303C,$022C,$A816;

(**************************************************************************
  The following three calls are used to allow applications to behave
  courteously when a user interaction such as a dialog box is needed. 
**************************************************************************)

FUNCTION AEGetInteractionAllowed(VAR level: AEInteractAllowed): OSErr;
	INLINE $303C,$021D,$A816;
 
FUNCTION AESetInteractionAllowed(level: AEInteractAllowed): OSErr;
	INLINE $303C,$011E,$A816;
 
FUNCTION AEInteractWithUser(timeOutInTicks: LONGINT; nmReqPtr: NMRecPtr;
                            idleProc: IdleProcPtr): OSErr;
	INLINE $303C,$061C,$A816;

(**************************************************************************
  These calls are used to set up and modify the event dispatch table.
**************************************************************************)
 
FUNCTION AEInstallEventHandler(theAEEventClass: AEEventClass;
                               theAEEventID: AEEventID;
                               handler: EventHandlerProcPtr;
                               handlerRefcon: LONGINT;
                               isSysHandler: BOOLEAN): OSErr;
	INLINE $303C,$091F,$A816;

FUNCTION AERemoveEventHandler(theAEEventClass: AEEventClass;
                              theAEEventID: AEEventID;
                              handler: EventHandlerProcPtr;
                              isSysHandler: BOOLEAN): OSErr;
	INLINE $303C,$0720,$A816;

FUNCTION AEGetEventHandler(theAEEventClass: AEEventClass;
                           theAEEventID: AEEventID;
                           VAR handler: EventHandlerProcPtr;
                           VAR handlerRefcon: LONGINT;
                           isSysHandler: BOOLEAN): OSErr;
	INLINE $303C,$0921,$A816;

(**************************************************************************
  These calls are used to set up and modify the coercion dispatch table.
**************************************************************************)

FUNCTION AEInstallCoercionHandler(fromType: DescType; toType: DescType;
                                  handler: ProcPtr; handlerRefcon: LONGINT;
                                  fromTypeIsDesc: BOOLEAN;
                                  isSysHandler: BOOLEAN): OSErr;
	INLINE $303C, $0A22, $A816;

FUNCTION AERemoveCoercionHandler(fromType: DescType; toType: DescType;
                                 handler: ProcPtr;
								 isSysHandler: BOOLEAN): OSErr;
	INLINE $303C, $0723, $A816;

FUNCTION AEGetCoercionHandler(fromType: DescType; toType: DescType;
                              VAR handler: ProcPtr;
                              VAR handlerRefcon: LONGINT;
                              VAR fromTypeIsDesc: BOOLEAN;
                              isSysHandler: BOOLEAN): OSErr;
	INLINE $303C, $0B24, $A816;

(**************************************************************************
  These calls are used to set up and modify special hooks into the
  AppleEvent manager.
**************************************************************************)

FUNCTION AEInstallSpecialHandler(functionClass: AEKeyword; handler: ProcPtr;
                                 isSysHandler: BOOLEAN): OSErr;
	INLINE $303C, $0500, $A816;

FUNCTION AERemoveSpecialHandler(functionClass: AEKeyword; handler: ProcPtr;
                                isSysHandler: BOOLEAN): OSErr;
	INLINE $303C, $0501, $A816;

FUNCTION AEGetSpecialHandler(functionClass: AEKeyword; VAR handler: ProcPtr;
                             isSysHandler: BOOLEAN): OSErr;
	INLINE $303C, $052D, $A816;


(**************************************************************************
  This call was added in version 1.0.1. If called with the keyword
  keyAERecorderCount ('recr'), the number of recorders that are
  currently active is returned in 'result'.
**************************************************************************)

{ available only in AEM vers 1.0.1 and greater }
{ when passed the keyAERecorderCount is returns the number of recorders active }
FUNCTION AEManagerInfo(keyWord: AEKeyWord; VAR result: LongInt): OSErr;
	INLINE $303C, $0441, $A816;
	
	
	
{$ENDC} { UsingAppleEvents }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}