
/************************************************************

 TelephoneTools.h
 C Interface to the Telephone Manager


  Copyright Apple Computer, Inc. 1990-1993
  All rights reserved

************************************************************/


#ifndef __TELEPHONETOOLS_
#define __TELEPHONETOOLS_


#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#ifndef __TYPES__
#include <Types.h>
#endif


#define vdefType	'vdef'		/* main telephone definition procedure	*/
#define vvalType	'vval'		/* validation definition procedure	*/
#define vsetType	'vset'		/* telephone setup definition procedure	*/
#define vlocType	'vloc'		/* telephone configuration localization defProc	*/
#define vscrType	'vscr'		/* telephone scripting defProc interfaces	*/

#define vbndType	'vbnd'		/* bundle type for telephone */


struct TELSetupStruct {
	DialogPtr 	theDialog;
	short		count;
	Ptr 		theConfig;
	short		procID;
};

typedef struct TELSetupStruct TELSetupStruct;
typedef TELSetupStruct *TELSetupPtr;

struct TELForwardPB {
	StringPtr			forwardDN;
	StringPtr			forwardPartyName;
	StringPtr			forwardSubaddress;
	short				forwardType;
	short				numRings;
};

typedef struct TELForwardPB TELForwardPB;


struct TELTermMsgPB{
	short				toolID;
	short				tRef;
	long				msg;
	short				mtype;
	short				value;
};

typedef struct TELTermMsgPB TELTermMsgPB;

struct TELDNMsgPB {
	short				toolID;
	short				tRef;
	short				dnRef;
	long				msg;
	short				mtype;
	short				value;
	StringPtr			rmtDN;
	StringPtr			rmtName;
	StringPtr			rmtSubaddress;
};

typedef struct TELDNMsgPB TELDNMsgPB;

struct TELCAGenericMsgPB {
	short				toolID;
	short				tRef;
	short				dnRef;
	short				caRef;
	long				msg;
	short				mtype;
	short				value;
	StringPtr			rmtDN;
	StringPtr			rmtName;
	StringPtr			rmtSubaddress;
	short				dialType;
};
typedef struct TELCAGenericMsgPB TELCAGenericMsgPB;

struct TELCADisconMsgPB {
	short				toolID;
	short				tRef;
	short				dnRef;
	short				caRef;
	long				msg;
	short				mtype;
	short				value;
};
typedef struct TELCADisconMsgPB TELCADisconMsgPB;

struct TELCAConfMsgPB {
	short				toolID;
	short				tRef;
	short				dnRef;
	short				caRef;
	long				msg;
	short				mtype;
	short				value;
};
typedef struct TELCAConfMsgPB TELCAConfMsgPB;

struct TELCATransfMsgPB {
	short				toolID;
	short				tRef;
	short				dnRef;
	short				caRef;
	long				msg;
	short				mtype;
	short				value;
	StringPtr			rmtDN;
	StringPtr			rmtName;
	StringPtr			rmtSubaddress;
	short				dialType;
};
typedef struct TELCATransfMsgPB TELCATransfMsgPB;


/********************************************************************************/
/*  The following two message blocks are sent when the tool has outgoing call   */
/*  or incoming call information, but no handle has been allocated for the call */
/********************************************************************************/

/* used by tool to send CAOffer and CAAlerting messages to the Manager Master Message Handler */
struct TELCAInOutMsgPB {
	short				toolID;
	short				tRef;
	short				dnRef;
	short				caRef;
	long				msg;
	short				mtype;
	short				value;
	StringPtr			rmtDN;
	StringPtr			rmtName;
	StringPtr			rmtSubaddress;
	short				caState;
	short				intExt;
	short				callType;
	short				dialType;
	short				bearerType;
	short				rate;
	StringPtr			routeDN;
	StringPtr			routeName;
	StringPtr			routeSubaddress;
	long				featureFlags;
	long				otherFeatures;
	long				telCAPrivate;
	
};
typedef struct TELCAInOutMsgPB TELCAInOutMsgPB;


typedef pascal void (*TELTermProcPtr)(Ptr pb);
typedef pascal void (*TELDNProcPtr)(Ptr pb);
typedef pascal void (*TELCAProcPtr)(Ptr pb);


enum {

	telValidateMsg			= 0,
	telDefaultMsg			= 1,

	telMgetMsg				= 0,
	telMsetMsg				= 1,

	telSpreflightMsg		= 0,
	telSsetupMsg			= 1,
	telSitemMsg				= 2,
	telSfilterMsg			= 3,
	telScleanupMsg			= 4,

	telL2EnglishMsg			= 0,
	telL2IntlMsg			= 1,


	telNewMsg				= 0,
	telDisposeMsg			= 1,
	telSuspendMsg			= 2,
	telResumeMsg			= 3,
	telMenuMsg				= 4,
	telEventMsg				= 5,
	telActivateMsg			= 6,
	telDeactivateMsg		= 7,

	telIdleMsg				= 50,
	telOpenTermMsg			= 51,	
	telResetTermMsg			= 52,
	telCloseTermMsg			= 53,
	telTermMsgHandMsg		= 54,
	telClrTermMsgHandMsg	= 55,
	telTermEventsSuppMsg	= 56,
	telGetInfoMsg			= 57,	

	telCountDNsMsg			= 60,	
	telDNLookupByIndexMsg 	= 61,
	telDNLookupByNameMsg	= 62,
	telCallbackClearMsg		= 63,
	telOtherFeatListMsg		= 64,
	telOtherFeatImplMsg		= 65,
	telToolFunctionsMsg		= 66,
	telOtherFunctionMsg		= 67,

	telGetHookswMsg			= 70,
	telSetHookswMsg			= 71,
	telGetVolumeMsg			= 72,
	telSetVolumeMsg			= 73,
	telAlertMsg				= 74,
	telGetDisplayMsg		= 75,
	telSetDisplayMsg		= 76,


	telDNSelectMsg			= 100,
	telDNDisposeMsg			= 101,
	telGetDNInfoMsg			= 102,
	telGetDNFlagsMsg		= 103,
	telDNMsgHandMsg			= 104,
	telClrDNMsgHandMsg		= 105,
	telDNEventsSuppMsg		= 106,

	telCountCAsMsg			= 110,
	telCALookupMsg			= 111,
	telCAMsgHandMsg			= 112,
	telClrCAMsgHandMsg		= 113,
	telCAEventsSuppMsg		= 114,
	telSetupCallMsg			= 115,

	telForwardSetMsg		= 120,
	telForwardClearMsg		= 121,
	telDNDSetMsg 			= 122,
	telDNDClearMsg			= 123,

	telCADisposeMsg			= 200,
	telGetCAStateMsg		= 201,
	telGetCAFlagsMsg		= 202,
	telGetCAInfoMsg			= 203,
	telConnectMsg 			= 204,
	telDialDigitsMsg 		= 205,
	telAcceptCallMsg		= 206,
	telRejectCallMsg		= 207,
	telDeflectCallMsg		= 208,
	telAnswerCallMsg		= 209,
	telDropMsg				= 210,
	telHoldMsg				= 211,
	telRetrieveMsg			= 212,
	telConfSplitMsg			= 213,
	telTransfBlindMsg		= 214,
	telCallbackSetMsg		= 215,
	telCallbackNowMsg		= 216,
	telCallPickupMsg 		= 217,
	telParkCallMsg 			= 218,
	telRetrieveParkedCallMsg= 219,
	telVoiceMailAccessMsg	= 220,
	telPagingMsg			= 221,
	telIntercomMsg			= 222,

	telConfPrepMsg			= 230,
	telConfEstMsg 			= 231,
	telTransfPrepMsg		= 232,
	telTransfEstMsg			= 233,
	
	telGetDNSoundInputMsg		= 240,
	telDisposeDNSoundInputMsg 	= 241,
	telGetDNSoundOutputMsg		= 242,
	telDisposeDNSoundOutputMsg 	= 243,
	telGetHSSoundInputMsg		= 244,
	telDisposeHSSoundInputMsg 	= 245,
	telGetHSSoundOutputMsg		= 246,
	telDisposeHSSoundOutputMsg 	= 247,
	telDNSetDTMFMsg				= 248,
	telDNGetDTMFMsg				= 249,
	telHSSetDTMFMsg				= 250,
	telHSGetDTMFMsg				= 251,
	telGetDNStatusMsg			= 252,
	telGetDNProgressDetMsg		= 253,
	telSetDNProgressDetMsg		= 254,
	
	telDNSetAutoAnswerMsg		= 260,
	telDNTollSaverControlMsg 	= 261,
	telSetIndHSConnectMsg		= 262,
	telGetIndHSConnectMsg		= 263,
	
	telCAVoiceDetectMsg			= 270,
	telCASilenceDetectMsg		= 271
};


#endif


	
