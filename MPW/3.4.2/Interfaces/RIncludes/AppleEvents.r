/*****************************************************************

 Created: Monday, September 16, 1991 at 2:22 PM
 AppleEvents.r
 Resource Interface to the Macintosh Libraries

 Copyright Apple Computer, Inc. 1989-1992
 All rights reserved
 
 Modified for AppleEvents manager version 1.0.1 July 30th, 1992

*****************************************************************/

#ifndef __APPLEEVENTS_R__
#define __APPLEEVENTS_R__

/*--------------------------------------------------------------
		Apple event descriptor types
--------------------------------------------------------------*/

#define typeBoolean 'bool'
#define typeChar 'TEXT'
#define typeSMInt 'shor'
#define typeInteger 'long'
#define typeSMFloat 'sing'
#define typeFloat 'doub'
#define typeLongInteger 'long'
#define typeShortInteger 'shor'
#define typeLongFloat 'doub'
#define typeShortFloat 'sing'
#define typeExtended 'exte'
#define typeComp 'comp'
#define typeMagnitude 'magn'
#define typeAEList 'list'
#define typeAERecord 'reco'
#define typeAppleEvent 'aevt'
#define typeTrue 'true'
#define typeFalse 'fals'
#define typeAlias 'alis'
#define typeEnumerated 'enum'
#define typeType 'type'
#define typeAppParameters 'appa'
#define typeProperty 'prop'
#define typeFSS 'fss '
#define typeKeyword 'keyw'
#define typeSectionH 'sect'
#define typeWildCard '****'
#define typeApplSignature 'sign'
#define typeSessionID 'ssid'
#define typeTargetID 'targ'
#define typeProcessSerialNumber 'psn '
#define typeNull 'null'													/* null or nonexistent data */

/*--------------------------------------------------------------
		Keywords for Apple event parameters
--------------------------------------------------------------*/

#define keyDirectObject '----'
#define keyErrorNumber 'errn'
#define keyErrorString 'errs'
#define keyProcessSerialNumber 'psn '

/*--------------------------------------------------------------
		Keywords for Apple event attributes
--------------------------------------------------------------*/

#define keyTransactionIDAttr 'tran'
#define keyReturnIDAttr 'rtid'
#define keyEventClassAttr 'evcl'
#define keyEventIDAttr 'evid'
#define keyAddressAttr 'addr'
#define keyOptionalKeywordAttr 'optk'
#define keyTimeoutAttr 'timo'
#define keyInteractLevelAttr 'inte'										/* this attribute is read only - will be set in AESend */
#define keyEventSourceAttr 'esrc'										/* this attribute is read only */
#define keyMissedKeywordAttr 'miss'										/* this attribute is read only */

/*--------------------------------------------------------------
		Keywords for special handlers
--------------------------------------------------------------*/

#define keyPreDispatch 'phac'											/* preHandler accessor call */
#define keySelectProc 'selh'											/* more selector call */

/*--------------------------------------------------------------
		Keyword for recording
--------------------------------------------------------------*/

#define keyAERecorderCount 'recr'										/* available in vers 1.0.1 and greater */

/*--------------------------------------------------------------
		Keyword for version information
--------------------------------------------------------------*/

#define keyAEVersion 'vers'												/* available in vers 1.0.1 and greater */

/*--------------------------------------------------------------
		Event Class
--------------------------------------------------------------*/

#define kCoreEventClass 'aevt'

/*--------------------------------------------------------------
		Event ID's
--------------------------------------------------------------*/

#define kAEOpenApplication 'oapp'
#define kAEOpenDocuments 'odoc'
#define kAEPrintDocuments 'pdoc'
#define kAEQuitApplication 'quit'
#define kAEAnswer 'ansr'
#define kAEApplicationDied 'obit'

/*--------------------------------------------------------------
		Constants for use in AESend mode
--------------------------------------------------------------*/

#define kAENoReply 0x00000001											/* sender doesn't want a reply to event */
#define kAEQueueReply 0x00000002										/* sender wants a reply but won't wait */
#define kAEWaitReply 0x00000003											/* sender wants a reply and will wait */
#define kAENeverInteract 0x00000010										/* server should not interact with user */
#define kAECanInteract 0x00000020										/* server may try to interact with user */
#define kAEAlwaysInteract 0x00000030									/* server should always interact with user where appropriate */
#define kAECanSwitchLayer 0x00000040									/* interaction may switch layer */
#define kAEDontReconnect 0x00000080										/* don't reconnect if there is a sessClosedErr from PPCToolbox */
#define kAEWantReceipt nReturnReceipt									/* sender wants a receipt of message */
#define kAEDontRecord 0x00001000										/* don't record this event - available in vers 1.0.1 and greater */
#define kAEDontExecute 0x00002000										/* don't send the event for recording - available in vers 1.0.1 and greater */

/*--------------------------------------------------------------
		Constants for the send priority in AESend
--------------------------------------------------------------*/

#define kAENormalPriority 0x00000000									/* post message at the end of the event queue */
#define kAEHighPriority nAttnMsg										/* post message at the front of the event queue */

/*--------------------------------------------------------------
		Constants for recording
--------------------------------------------------------------*/

#define kAEStartRecording 'reca'										/* available in vers 1.0.1 and greater */
#define kAEStopRecording 'recc'											/* available in vers 1.0.1 and greater */
#define kAENotifyStartRecording 'rec1'									/* available in vers 1.0.1 and greater */
#define kAENotifyStopRecording 'rec0'									/* available in vers 1.0.1 and greater */
#define kAENotifyRecording 'recr'										/* available in vers 1.0.1 and greater */

#endif

////////////////////////////////////////////////////////////////////////////////
