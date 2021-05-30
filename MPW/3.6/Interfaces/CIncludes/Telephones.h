/*
     File:       Telephones.h
 
     Contains:   Telephone Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __TELEPHONES__
#define __TELEPHONES__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __CTBUTILITIES__
#include <CTBUtilities.h>
#endif

#ifndef __COMPONENTS__
#include <Components.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

#if CALL_NOT_IN_CARBON
enum {
  curTELVersion                 = 3,    /* current Telephone Manager version */
                                        /*    the chooseXXX symbols are defined in CTBUtilities.(pah) */
  telChooseDisaster             = chooseDisaster,
  telChooseFailed               = chooseFailed,
  telChooseAborted              = chooseAborted,
  telChooseOKMinor              = chooseOKMinor,
  telChooseOKMajor              = chooseOKMajor,
  telChooseCancel               = chooseCancel,
  telChooseOKTermChanged        = 4
};

#ifndef classTEL
enum {
                                        /* telephone tool file type */
  classTEL                      = FOUR_CHAR_CODE('vbnd')
};

#endif  /* !defined(classTEL) */

/* PHYSICAL TERMINAL CONSTANTS */
/* INDEPENDENT HANDSET CONSTANTS */
enum {
  telIndHSOnHook                = 0,    /* independent handset on hook */
  telIndHSOffHook               = 1     /* independent handset off hook */
};

enum {
  telIndHSDisconnected          = 0,    /* handset disconnected from the line */
  telIndHSConnected             = 1     /* handset connected to the line */
};


/* HOOK STATE CONSTANTS */
enum {
  telHandset                    = 1,    /* handset hookswitch */
  telSpeakerphone               = 2     /* speakerphone 'on' switch */
};

enum {
  telDeviceOffHook              = 1,    /* device off hook */
  telDeviceOnHook               = 0     /* device on hook */
};


/* VOLUME CONTROL CONSTANTS */
enum {
  telHandsetSpeakerVol          = 1,    /* volume of the handset speaker */
  telHandsetMicVol              = 2,    /* sensitivity of the handset mic */
  telSpeakerphoneVol            = 3,    /* speakerphone volume */
  telSpeakerphoneMicVol         = 4,    /* sensitivity of the spkrphone mic */
  telRingerVol                  = 5,    /* volume of the ringer */
  telBuiltinSPVol               = 6,    /* volume of the built-in speakerphone */
  telBuiltinSPMicVol            = 7     /* sensitivity of the built-in speakerphone mic */
};

enum {
  telVolSame                    = 0,    /* leaves the volume at previous level */
  telVolMin                     = 1,    /* turns volume down to minimum level, but not off */
  telVolMax                     = 100   /* highest level allowed by the Telephone Manager */
};

enum {
  telVolStateSame               = 0,    /* leaves device in same state */
  telVolStateOff                = 1,    /* turns the device off, but doesn't change the volume setting. Use for mute functions. */
  telVolStateOn                 = 2     /* turns the device on.  Volume setting is the same as previously set. */
};

/* DISPLAY CONSTANTS */
enum {
  telNormalDisplayMode          = 1,    /* normal display mode */
  telInspectMode                = 2,    /* inspect display mode */
  telMiscMode                   = 3,    /* miscellaneous display mode */
  telRetrieveMode               = 4,    /* message retrieval mode */
  telDirectoryQueryMode         = 5,    /* electronic directory mode */
  telEntireDisplay              = 0     /* entire Display */
};


/* KEY PRESS CONSTANTS */
enum {
  telHangupKey                  = 1,    /* drop, or release, key pressed */
  telHoldKey                    = 2,    /* hold key pressed */
  telConferenceKey              = 3,    /* conference key pressed */
  telTransferKey                = 4,    /* transfer key pressed */
  telForwardKey                 = 5,    /* call forward key pressed */
  telCallbackKey                = 6,    /* call back key pressed */
  telDNDKey                     = 7,    /* do not disturb key pressed */
  telCallPickupKey              = 8,    /* call Pickup key pressed */
  telCallParkKey                = 9,    /* call Park key pressed */
  telCallDeflectKey             = 10,   /* call Deflect key pressed */
  telVoiceMailAccessKey         = 11,   /* voice Mail Access key pressed */
  telCallRejectKey              = 12,   /* call Reject key pressed */
  telOtherKey                   = 16    /* other key pressed */
};


enum {
  telKeyPadPress                = 1,    /* key pressed on 12 digit keypad*/
  telFeatureKeyPress            = 2     /* feature Key Pressed */
};

enum {
  telTerminalEnabled            = 0,
  telTerminalDisabled           = 1
};

enum {
  telUnknown                    = 0,    /* unknown error */
  telTerminalHWDisconnected     = 1,    /* terminal hardware is disconnected */
  telDeviceDriverClosed         = 2     /* device driver is closed */
};


/* ALERT PATTERN */
enum {
  telPattern0                   = 0,
  telPattern1                   = 1,
  telPattern2                   = 2,
  telPattern3                   = 3,
  telPattern4                   = 4,
  telPattern5                   = 5,
  telPattern6                   = 6,
  telPattern7                   = 7,
  telPatternOff                 = 8,
  telPatternUndefined           = 15
};


/* DN TYPES */
enum {
  telAllDNs                     = 0,    /* counts all types of DNs */
  telInternalDNs                = 1,    /* connected to PBX or other non-public switch */
  telInternalDNsOnly            = 2,    /* connected to PBX or other non-public switch */
                                        /* and able to place internal calls only */
  telExternalDNs                = 3,    /* connected to public network */
  telDNTypeUnknown              = 4     /* DN type unknown */
};


/* DN USAGE */
enum {
  telDNNotUsed                  = 0,    /* DN is not used - onhook */
  telDNPOTSCall                 = 1,    /* DN used for POTs call */
  telDNFaxCall                  = 2,    /* DN used for fax call */
  telDNDataCall                 = 3,    /* DN used for data call */
  telDNAlerting                 = 4,    /* Incoming call at DN */
  telDNUnknownState             = 5     /* DN is in unknown state */
};


/* CALL FORWARDING TYPES */
enum {
  telForwardImmediate           = 1,    /* immediately forward calls */
  telForwardBusy                = 2,    /* forward on Busy */
  telForwardNoAnswer            = 3,    /* forward on No answer */
  telForwardBusyNA              = 4,    /* forwarding for busy and no answer*/
  telForwardTypeUnknown         = 5     /* type of forwarding is unknown */
};


/* CALL FORWARDING MESSAGES */
enum {
  telForwardCleared             = 0,    /* forwarding has been cleared */
  telForwardEst                 = 1,    /* forwarding has been established*/
  telForwardFailed              = 2     /* attempt to setup forwarding has failed*/
};


/* DO NOT DISTURB TYPES */
enum {
  telDNDIntExt                  = 0,    /* do not disturb for all internal and external calls*/
  telDNDExternal                = 1,    /* do not disturb for external calls only */
  telDNDInternal                = 2,    /* do not disturb for internal calls only */
  telDNDNonIntercom             = 3     /* do not disturb for all calls except intercom */
};


/* DO NOT DISTURB MESSAGES */
enum {
  telDNDCleared                 = 0,    /* do not disturb has been cleared */
  telDNDEst                     = 1,    /* do not disturb has been established */
  telDNDFailed                  = 2     /* attempt to setup do not disturb has failed */
};


/* VOICE MAIL MESSAGES */
enum {
  telAllVoiceMessagesRead       = 0,    /* all messages have been read, none are  waiting */
                                        /* to be read */
  telNewVoiceMessage            = 1     /* a new message has arrived or messages are waiting for this DN */
};


/* DNSELECT MESSAGE */
enum {
  telDNDeselected               = 0,    /* DN has been deselected */
  telDNSelected                 = 1     /* DN has been selected */
};


/* CALL ORIGINATORS */
enum {
  telInternalCall               = 0,    /* return nth internal CA */
  telExternalCall               = 1,    /* return nth external CA */
  telUnknownCallOrigin          = 2,    /* unknown call type */
  telAllCallOrigins             = 2     /* return nth CA internal or external */
};


/* CALL TYPES */
enum {
  telVoiceMailAccessOut         = (-7),
  telPageOut                    = (-6),
  telIntercomOut                = (-5),
  telCallbackOut                = (-4),
  telPickup                     = (-3),
  telParkRetrieve               = (-2),
  telNormalOut                  = (-1),
  telUnknownCallType            = 0,
  telNormalIn                   = 1,
  telForwardedImmediate         = 2,
  telForwardedBusy              = 3,
  telForwardedNoAnswer          = 4,
  telTransfer                   = 5,
  telDeflected                  = 6,
  telIntercepted                = 7,
  telDeflectRecall              = 8,
  telParkRecall                 = 9,
  telTransferredRecall          = 10,
  telIntercomIn                 = 11,
  telCallbackIn                 = 12
};


/* DIAL TYPES */
enum {
  telDNDialable                 = 0,    /* this DN could be dialed via TELSetupCall */
  telDNNorthAmerican            = 1,    /* rmtDN is standard North America 10 digit number */
  telDNInternational            = 2,    /* rmtDN is an international number */
  telDNAlmostDialable           = 3,    /* rmtDN is almost dialable, missing prefix such as 9 or 1 */
  telDNUnknown                  = 15    /* unknown whether DN is dialable */
};


/* CALL PROGRESS MESSAGES */
enum {
  telCAPDialTone                = 1,    /* dial tone */
  telCAPRinging                 = 2,    /* destination CA is alerting */
  telCAPDialing                 = 3,    /* dialing the other end */
  telCAPReorder                 = 4,    /* reorder */
  telCAPBusy                    = 5,    /* busy */
  telCAPRouted                  = 6,    /* call routed; rmtDN will hold the routing directory number routeDN and routePartyName have been updated */
  telCAPRoutedOff               = 7,    /* call routed off-network; no further progress will be available */
  telCAPTimeout                 = 8,    /* call timed out */
  telCAPUpdate                  = 9,    /* name and rmtDN information has been updated */
  telCAPPrompt                  = 10,   /* the network is prompting for more information */
  telCAPWaiting                 = 11,   /* call is proceeding, but there is no response yet from the destination */
  telCAPCPC                     = 12,   /* telephone tool detected CPC signal */
  telCAPNoDialTone              = 13,   /* dial tone not detected */
  telCAPUnknown                 = 15,   /* call progress state unknown */
  telCAPDialDisabled            = 16,   /* Blacklisting: Dial Disabled */
  telCAPBlacklistedNumber       = 17,   /* Blacklisting: Blacklisted Number */
  telCAPForbiddenNumber         = 18,   /* Blacklisting: Forbidden Number */
  telCAPModemGuardTime          = 19,   /* Modem Guard Timein force, unable to dial */
  telCAPLCDetected              = 20,   /* trying to dial a number while the handset is offhook */
  telCAPLostLC                  = 21    /* trying manual dial or answer while handset not off hook or also lost line current during dialing. */
};


/* OUTGOING CALL MESSAGES */
enum {
  telPhysical                   = 0,    /* user lifted handset and initiated call */
  telProgrammatic               = 1     /* programmatic initiation of outgoing call */
};


/* DISCONNECT MESSAGES */
enum {
  telLocalDisconnect            = 0,    /* local party, this user, responsible for disconnect */
  telRemoteDisconnect           = 1     /* remote party responsible for disconnect */
};


/* DISCONNECT TYPES */
enum {
  telCADNormal                  = 1,    /* normal disconnect */
  telCADBusy                    = 2,    /* remote user busy */
  telCADNoResponse              = 3,    /* remote not responding */
  telCADRejected                = 4,    /* call rejected */
  telCADNumberChanged           = 5,    /* number changed */
  telCADInvalidDest             = 6,    /* invalid destination address */
  telCADFacilityRejected        = 7,    /* requested facility rejected */
  telCADUnobtainableDest        = 9,    /* destination not obtainable */
  telCADCongested               = 10,   /* network congestion */
  telCADIncompatibleDest        = 11,   /* incompatible destination */
  telCADTimeout                 = 12,   /* call timed out */
  telCADUnknown                 = 15    /* reason unknown */
};


/* CONFERENCE MESSAGES */
enum {
  telConferencePrepFailed       = 0,    /* conference could not be prepared */
  telConferencePending          = 1,    /* conference prepared successfully */
  telConferenceEstFailed        = 2,    /* conference could not be established */
  telConferenceEst              = 3     /* conference established */
};


/* TRANSFER MESSAGES */
enum {
  telTransferPrepFailed         = 0,    /* transfer could not be prepared */
  telTransferPending            = 1,    /* transfer prepared successfully */
  telTransferEst                = 2,    /* consult or blind xfer successful */
  telTransferFailed             = 3,    /* consult or blind xfer failed */
  telTransferred                = 4     /* message to originator of CA specifying that call was transferred to rmtDN */
};


/* HOLD MESSAGES */
enum {
  telHoldCleared                = 0,
  telHoldEst                    = 1,
  telHoldFailed                 = 2
};


/* RECEIVE DIGIT MESSAGES */
enum {
  telDigitAudible               = 0,
  telDigitNotAudible            = 1
};


/* CALL PARK MESSAGES */
enum {
  telCallParkEst                = 1,    /* call has been successfully parked */
  telCallParkRetrieveEst        = 2,    /* parked Call has been successfully retrieved */
  telCallParkFailed             = 3,    /* attempt to setup call park has failed */
  telCallParkRetrieveFailed     = 4,    /* attempt to retrieve parked call failed */
  telCallParkRecall             = 5     /* call park has been recalled */
};


/* CALL BACK MESSAGES */
enum {
  telCallbackCleared            = 0,    /* call back has been cleared */
  telCallbackEst                = 1,    /* call back has been established */
  telCallbackNowAvail           = 2,    /* call can be called back with TELCallBackNow if CA is zero, else call IS calling back on CA */
  telCallbackFailed             = 3,    /* attempt to setup callback has failed */
  telCallbackDesired            = 4,    /* a user has called this terminal, received no answer and desires this terminal to call it back */
  telCallbackDesiredCleared     = 5,    /* call back for no answer no longer desired */
  telCalledback                 = 6     /* callback has occurred successfully */
};


/* CALL REJECT MESSAGES */
enum {
  telCallRejectFailed           = 0,    /* attempt to reject call has failed */
  telCallRejectEst              = 1,    /* call successfully rejected */
  telCallRejected               = 2     /* message to originator that call was rejected */
};


/* CALL DEFLECT MESSAGES */
enum {
  telCallDeflectFailed          = 0,    /* attempt to deflect call has failed */
  telCallDeflectEst             = 1,    /* call successfully deflected */
  telCallDeflectRecall          = 2,    /* deflected call has been recalled */
  telCallDeflected              = 3,    /* message to originator that call was deflected to rmtDN */
  telAutoDeflectImmediate       = 4,    /* a call was automatically deflected from this terminal as a result of immediate call forwarding */
  telAutoDeflectBusy            = 5,    /* a call was automatically deflected from this terminal as a result of call forwarding on busy */
  telAutoDeflectNoAnswer        = 6     /* a call was automatically deflected from this terminal as a result of call forwarding on no answer */
};


/* CONFERENCE SPLIT MESSAGES */
enum {
  telConferenceSplitFailed      = 0,    /* CA could not be split */
  telConferenceSplitEst         = 1     /* CA split successfully */
};


/* CONFERENCE DROP MESSAGES */
enum {
  telConferenceDropFailed       = 0,    /* CA could not be dropped */
  telConferenceDropped          = 1     /* CA dropped successfully */
};


/* CALL PICKUP MESSAGES */
enum {
  telCallPickupEst              = 0,    /* call pickup was successful */
  telCallPickupFailed           = 1,    /* call pickup failed */
  telCallPickedUp               = 2     /* message to originator that call was picked up at a different DN */
};


/* PAGING MESSAGES */
enum {
  telPageEst                    = 0,    /* paging was successful */
  telPageComplete               = 1,    /* paging activity completed */
  telPageFailed                 = 2     /* paging failed */
};


/* INTERCOM MESSAGES */
enum {
  telIntercomEst                = 0,    /* intercom was successful */
  telIntercomComplete           = 1,    /* intercom activity completed */
  telIntercomFailed             = 2     /* intercom failed */
};


/* MODEM TONE MESSAGES */
enum {
  telModemToneDetected          = 0,    /* modem tone was detected */
  telModemToneCleared           = 1     /* modem tone went away */
};


/* FAX TONE MESSAGES */
enum {
  telFaxToneDetected            = 0,    /* fax tone was detected */
  telFaxToneCleared             = 1     /* fax tone went away */
};


/* IN USE MESSAGES */
enum {
  telInUsePrivate               = 0,    /* MADN is in use and can't be accessed */
  telInUseCanAccess             = 1,    /* MADN is in use, and others can access it and join in */
  telInUseCanMakePrivate        = 2,    /* MADN is in use, but available for any one person to access */
  telInUseCleared               = 3     /* MADN is no longer in use */
};


/* CALL APPEARANCE STATES */
enum {
  telCAIdleState                = 0,    /* a call doesn't exist at this time */
  telCAInUseState               = 1,    /* the call is active but at another terminal */
  telCAOfferState               = 2,    /* a call is being offered to the terminal */
  telCAQueuedState              = 3,    /* a call is being queued at this terminal */
  telCAAlertingState            = 4,    /* a call is alerting at the terminal */
  telCADialToneState            = 5,    /* initiated outgoing call has dialtone */
  telCADialingState             = 6,    /* initiated outgoing call is dialing */
  telCAWaitingState             = 7,    /* initiated outgoing call is waiting for response from destination */
  telCARingingState             = 8,    /* the outgoing call is ringing. */
  telCABusyState                = 9,    /* destination is busy or can't be reached */
  telCAHeldState                = 10,   /* call has been put on hold by this terminal */
  telCAConferencedState         = 11,   /* this CA is part of a conference now */
  telCAActiveState              = 12,   /* the call is active and parties are free to exchange data*/
  telCAReorderState             = 13,   /* CA is in a reorder state */
  telCAConferencedHeldState     = 14,   /* CA is a conference call in a held state */
  telCAUnknownState             = 15    /* the call state is unknown */
};


/* TERMINAL MESSAGE EVENTMASKS */
enum {
  telTermHookMsg                = 0x00000001, /* the hookswitch state has changed */
  telTermKeyMsg                 = 0x00000002, /* a phone pad key has been depressed */
  telTermVolMsg                 = 0x00000004, /* volume setting has changed */
  telTermDisplayMsg             = 0x00000008, /* display has changed */
  telTermEnableMsg              = 0x00000010, /* terminal has become enabled */
  telTermOpenMsg                = 0x00000020, /* terminal has been opened */
  telTermCloseMsg               = 0x00000040, /* terminal is shutting down */
  telTermResetMsg               = 0x00000080, /* terminal has been reset */
  telTermErrorMsg               = 0x00000100, /* hard equipment error */
  telTermIndHSStateChgMsg       = 0x00000200, /* change in handset state from inacive to active or vice versa */
  telTermIndHSConnectMsg        = 0x00000400, /* independent handset connection has been changed */
  telTermKeyImmMsg              = 0x00000800, /* immidiate arrival of phone pad key */
  telTermVolStateMsg            = 0x00001000, /* volume state has changed */
  telTermOtherMsg               = (long)0x80000000, /* vendor defined error */
  telAllTermMsgs                = 0x00001FFF /* mask to all non tool specific terminal events */
};


/* DN MESSAGE EVENTMASK CONSTANTS */
enum {
  telDNForwardMsg               = 0x00000001, /* forward feature activity */
  telDNDNDMsg                   = 0x00000002, /* do not disturb feature activity */
  telDNVoiceMailMsg             = 0x00000004, /* message has arrived for this DN */
  telDNSelectedMsg              = 0x00000008, /* DN has been selected or deselected */
  telDNOtherMsg                 = (long)0x80000000, /* a custom message for use by tools */
  telAllDNMsgs                  = 0x0000000F /* mask to all non tool specific dn events */
};


/* CA MESSAGE EVENTMASK CONSTANTS */
enum {
  telCAAlertingMsg              = 0x00000001, /* CA is alerting  */
  telCAOfferMsg                 = 0x00000002, /* CA is being offered a call */
  telCAProgressMsg              = 0x00000004, /* call progress info for this CA */
  telCAOutgoingMsg              = 0x00000008, /* CA is initiating an outgoing call */
  telCADisconnectMsg            = 0x00000010, /* CA disconnected (dropped or rmt disc */
  telCAActiveMsg                = 0x00000020, /* CA is active and voice/data is free to flow end to end */
  telCAConferenceMsg            = 0x00000040, /* conference activity on CA */
  telCATransferMsg              = 0x00000080, /* transfer feature activity */
  telCAHoldMsg                  = 0x00000100, /* hold feature activity */
  telCADigitsMsg                = 0x00000200, /* remote signaling digits arrived */
  telCACallParkMsg              = 0x00000400, /* CA call park feature activity */
  telCACallbackMsg              = 0x00000800, /* CA call back feature activity  */
  telCARejectMsg                = 0x00001000, /* CA is rejected */
  telCADeflectMsg               = 0x00002000, /* CA is deflected */
  telCAForwardMsg               = 0x00004000, /* CA is forwarded to this DN  */
  telCAConferenceSplitMsg       = 0x00008000, /* conference split activity  */
  telCAConferenceDropMsg        = 0x00010000, /* conference drop activity  */
  telCAQueuedMsg                = 0x00020000, /* CA has been queued  */
  telCAInUseMsg                 = 0x00040000, /* CA is in use  */
  telCACallPickupMsg            = 0x00080000, /* CA pickup activity */
  telCAPagingMsg                = 0x00100000, /* CA paging activity */
  telCAIntercomMsg              = 0x00200000, /* CA intercom activity */
  telCAModemToneMsg             = 0x00400000, /* modem tones detected */
  telCAFaxToneMsg               = 0x00800000, /* fax tones detected */
  telCAIdleMsg                  = 0x01000000, /* CA is in idle state */
  telCASuccessiveAlertMsg       = 0x02000000, /* phone is alerting, one per ring */
  telCAUserUserInfoMsg          = 0x04000000, /* user to user information has arrrived for this CA */
  telCAHandOffMsg               = 0x08000000, /* CA is ready for hand-off */
  telCAVoiceDetectedMsg         = 0x10000000, /* voice Detect related event */
  telCASilenceDetectedMsg       = 0x20000000, /* silence Detect related event */
  telCADigitsImmMsg             = 0x40000000, /* immidiate arrival of remote signaling digits */
  telCAOtherMsg                 = (long)0x80000000, /* tool specific CA message */
  telAllCAMsgs                  = 0x7FFFFFFF /* mask to all non tool specific CA events */
};

typedef OSErr                           TELErr;
typedef UInt32 TELFlags;
enum {
  telNoMenus                    = 1L << 16, /* tells tool not to display any custom menus */
  telQuiet                      = 1L << 17, /* tells tool not to display any dialog boxes or alerts */
  telConfigChanged              = 1L << 18 /* notifies application that the config has changed */
};


typedef UInt32 TELFeatureFlags;
enum {
  pcmAvail                      = 1L << 0, /* true if PCM voice data accessible */
  hasHandset                    = 1L << 1, /* true if a phone handset is attached  */
  hasSpeakerphone               = 1L << 2, /* true if a 2 way speakerphone is attached */
  canOnHookDial                 = 1L << 3, /* can on-hook dial */
  hasRinger                     = 1L << 4, /* terminal has its own ringer */
  canSetDisplay                 = 1L << 5, /* application can write to the display */
  hasKeypad                     = 1L << 6, /* attached phone has standard 12 key pad */
  hasVideo                      = 1L << 7, /* terminal has a videophone */
  hasOther                      = 1L << 8, /* reserved for future use */
  crossDNConference             = 1L << 9, /* can perform cross-DN conferences */
  hasSubaddress                 = 1L << 10, /* attached network supports subaddressing */
  hasUserUserInfo               = 1L << 11, /* network supports user-to-user info */
  hasHandsetSoundStreams        = 1L << 12, /* sound streams are supported on the handset */
  hasIndHandset                 = 1L << 13, /* handset can be accessed independently of the phone line */
  hasBuiltinSpeakerphone        = 1L << 14 /* speaker and microphone of the Mac can be used */
};


struct TELTermRecord {
  short               tRef;
  TELFeatureFlags     featureFlags;
  short               handsetSpeakerVol;
  short               handsetMicVol;
  short               speakerphoneVol;
  short               speakerphoneMicVol;
  short               ringerVol;
  short               otherVol;
  short               ringerTypes;
  short               hasDisplay;
  short               displayRows;
  short               numDNs;
  short               maxAllocCA;
  short               curAllocCA;
  short               builtinSpeakerVol;
  short               builtinSpeakerMicVol;
  long                reserved;
};
typedef struct TELTermRecord            TELTermRecord;
typedef TELTermRecord *                 TELTermPtr;
struct TELRecord {
  short               procID;

  TELFlags            flags;
  short               reserved;

  long                refCon;
  long                userData;

  UniversalProcPtr    defproc;

  Ptr                 config;
  Ptr                 oldConfig;

  TELTermPtr          pTELTerm;

  long                telPrivate;
  long                reserved1;
  long                reserved2;

  long                pTELTermSize;
  short               version;

};
typedef struct TELRecord                TELRecord;
typedef TELRecord *                     TELPtr;
typedef TELPtr *                        TELHandle;

typedef UInt32 TELDNFeatureFlags;
enum {
  dndSub                        = 1L << 0, /* do not disturb subscribed */
  dndAvail                      = 1L << 1, /* do not disturb available */
  dndActive                     = 1L << 2, /* do not disturb active */
  voiceMailAccessSub            = 1L << 3, /* message waiting subscribed */
  voiceMailAccessAvail          = 1L << 4, /* message waiting available */
  voiceMailAccessActive         = 1L << 5, /* message waiting active */
  pagingSub                     = 1L << 6, /* paging is subscribed */
  pagingAvail                   = 1L << 7, /* paging is available */
  pagingActive                  = 1L << 8, /* paging is active */
  intercomSub                   = 1L << 9, /* intercom is subscribed */
  intercomAvail                 = 1L << 10, /* intercom is available */
  intercomActive                = 1L << 11, /* intercom is active */
  dnSelectSub                   = 1L << 12, /* DN select is subscribed */
  dnSelectAvail                 = 1L << 13, /* DN select is available */
  dnSelectActive                = 1L << 14, /* DN is selected */
  callPickupSub                 = 1L << 15, /* call pickup is subscribed */
  callPickupAvail               = 1L << 16, /* call pickup is available */
  dnInUse                       = 1L << 17, /* a CA is allocated for this DN */
  logicalDN                     = 1L << 18, /* this DN is not on this terminal */
  dnAccessible                  = 1L << 19, /* commands can be sent to this DN */
  canInitiate                   = 1L << 20, /* an outgoing CA can be initiated */
  voiceMessageWaiting           = 1L << 21, /* voice mail waiting for this dn */
  hasDNSoundStreams             = 1L << 22, /* sound streams are supported on this DN */
  autoAnswerAvail               = 1L << 23, /* AutoAnswer is set for this DN */
  autoAnswerActive              = 1L << 24, /* AutoAnswer is currently applied to CA on this DN */
  tollSaverAvail                = 1L << 25, /* tollSaver is set for this DN */
  tollSaverActive               = 1L << 26 /* tollSaver is currently applied to CA on this DN */
};


typedef UInt32 TELDNForwardFlags;
enum {
  immediateForwardSub           = 1L << 0, /* immediate call forward subscribed */
  immediateForwardAvail         = 1L << 1, /* immediate call forward available */
  immediateForwardActive        = 1L << 2, /* immediate call forward active */
  busyForwardSub                = 1L << 3, /* forward on busy subscribed */
  busyForwardAvail              = 1L << 4, /* forward on busy available */
  busyForwardActive             = 1L << 5, /* forward on busy active */
  noAnswerForwardSub            = 1L << 6, /* no answer call forward subscribed */
  noAnswerForwardAvail          = 1L << 7, /* no answer call forward available */
  noAnswerForwardActive         = 1L << 8, /* no answer call forward active */
  busyNAForwardSub              = 1L << 9, /* busy & no answer call forward subscribed */
  busyNAForwardAvail            = 1L << 10, /* busy & no answer call forward available */
  busyNAForwardActive           = 1L << 11 /* busy & no answer call forward active */
};


struct TELDNRecord {

  short               dnRef;
  StringPtr           dn;
  StringPtr           dnPartyName;
  StringPtr           dnSubaddress;
  TELHandle           hTEL;
  short               maxAllocCA;
  short               curAllocCA;
  short               dnType;
  TELDNFeatureFlags   featureFlags;
  short               numPageIDs;
  short               numIntercomIDs;
  short               numPickupIDs;
  TELDNForwardFlags   forwardFlags;
  StringPtr           iForwardDN;
  StringPtr           iForwardSubaddress;
  StringPtr           iForwardPartyName;
  StringPtr           bForwardDN;
  StringPtr           bForwardSubaddress;
  StringPtr           bForwardPartyName;
  StringPtr           naForwardDN;
  StringPtr           naForwardSubaddress;
  StringPtr           naForwardPartyName;
  short               naForwardRings;
  long                telDNPrivate;
  long                refCon;
  long                userData;
  long                reserved;
};
typedef struct TELDNRecord              TELDNRecord;
typedef TELDNRecord *                   TELDNPtr;
typedef TELDNPtr *                      TELDNHandle;
typedef UInt32 TELCAFeatureFlags;
enum {
  holdSub                       = 1L << 0, /* hold subscribed  */
  holdAvail                     = 1L << 1, /* hold available  */
  holdActive                    = 1L << 2, /* hold active  */
  conferenceSub                 = 1L << 3, /* conference subscribed */
  conferenceAvail               = 1L << 4, /* conference available */
  conferenceActive              = 1L << 5, /* conference active  */
  conferenceDropSub             = 1L << 6, /* conference drop subscribed  */
  conferenceDropAvail           = 1L << 7, /* a call to TELDrop will drop this CA only from a conference */
  conferenceSplitSub            = 1L << 8, /* conference split subscribed  */
  conferenceSplitAvail          = 1L << 9, /* conference split available for this CA */
  numToConferenceRequired       = 1L << 10, /* the number of CAs to be conferenced is required in TELConfPrep */
  transferSub                   = 1L << 11, /* transfer subscribed  */
  transferAvail                 = 1L << 12, /* transfer available  */
  transferActive                = 1L << 13, /* transfer active */
  caRelated                     = 1L << 14 /* this CA is the specified in some other CA's relatedCA field*/
};

typedef UInt32 TELCAOtherFeatures;
enum {
  callbackSub                   = 1L << 0, /* call back subscribed */
  callbackAvail                 = 1L << 1, /* call back available */
  callbackActive                = 1L << 2, /* call back active  */
  callbackClearSub              = 1L << 3, /* call back clearing subscribed */
  callbackNowSub                = 1L << 4, /* call back now subscribed */
  callbackNowAvail              = 1L << 5, /* call back now available  */
  callbackBusy                  = 1L << 6, /* call back on busy */
  callbackNoAnswer              = 1L << 7, /* call back on no answer */
  callbackReturnsRef            = 1L << 8, /* call back returns a reference */
  parkSub                       = 1L << 9, /* call park subscribed */
  parkAvail                     = 1L << 10, /* call park available */
  parkActive                    = 1L << 11, /* call park active */
  parkRetrieveSub               = 1L << 12, /* call park retrieve subscribed */
  parkRetrieveWithID            = 1L << 13, /* retrieve parked calls with IDs */
  parkWithReturnedID            = 1L << 14, /* park call to a specific remote ID */
  parkWithGivenID               = 1L << 18, /* for switch that requires ID for parking */
  rejectable                    = 1L << 15, /* CA is rejectable  */
  deflectable                   = 1L << 16, /* CA is deflectable  */
  acceptable                    = 1L << 17, /* CA is acceptable */
  voiceDetected                 = 1L << 19, /* voice has been detected on this CA incase of an incoming call*/
  callAnswdTSRings              = 1L << 20 /* incoimng call was answered on TollSaver rings */
};

typedef struct TELCARecord              TELCARecord;
typedef TELCARecord *                   TELCAPtr;
typedef TELCAPtr *                      TELCAHandle;
struct TELCARecord {
  short               caRef;
  TELDNHandle         hTELDN;
  TELHandle           hTEL;
  short               caState;
  TELCAHandle         relatedCA;
  long                connectTime;            /* can be used by application to keep track of connect time */
  short               intExt;
  short               callType;
  short               dialType;
  short               bearerType;
  short               rate;
  StringPtr           rmtDN;
  StringPtr           rmtPartyName;
  StringPtr           rmtSubaddress;
  StringPtr           routeDN;
  StringPtr           routePartyName;
  StringPtr           routeSubaddress;
  short               priority;
  short               conferenceLimit;
  TELCAFeatureFlags   featureFlags;
  TELCAOtherFeatures  otherFeatures;
  long                telCAPrivate;
  long                refCon;
  long                userData;
  long                reserved;
};

/* Constants for HandleType in structure above */
enum {
  telHandleType                 = 0,    /* feature requires a terminal handle */
  telDNHandleType               = 1,    /* feature requires a DN handle */
  telCAHandleType               = 2     /* feature requires a CA handle */
};

struct FeatureList {
  short               featureID;
  StringPtr           featureName;
  short               handleType;
  struct FeatureList * nextFeature;
};
typedef struct FeatureList              FeatureList;
typedef FeatureList *                   FeatureListPtr;
/* CA MESSAGE STRUCTURES FOR MSGINFO */
struct CAGenericMsgRec {
  StringPtr           rmtDN;
  StringPtr           rmtName;
  StringPtr           rmtSubaddress;
  short               dialType;
};
typedef struct CAGenericMsgRec          CAGenericMsgRec;
struct CAUserUserInfoMsgRec {
  StringPtr           userUserInfo;
};
typedef struct CAUserUserInfoMsgRec     CAUserUserInfoMsgRec;
struct CAConfMsgRec {
  TELCAHandle         relatedCA;
};
typedef struct CAConfMsgRec             CAConfMsgRec;
struct CATransfMsgRec {
  StringPtr           rmtDN;
  StringPtr           rmtName;
  StringPtr           rmtSubaddress;
  short               dialType;
  TELCAHandle         prepCA;
};
typedef struct CATransfMsgRec           CATransfMsgRec;
typedef CALLBACK_API( void , TelephoneTermMsgProcPtr )(TELHandle hTEL, long msg, short mtype, short value, long globals);
typedef CALLBACK_API( void , TelephoneDNMsgProcPtr )(TELDNHandle hTELDN, long Msg, short mtype, short value, ConstStr255Param rmtDN, ConstStr255Param rmtName, ConstStr255Param rmtSubaddress, long globals);
typedef CALLBACK_API( void , TelephoneCAMsgProcPtr )(TELCAHandle hTELCA, long Msg, short mtype, short value, Ptr Msginfo, long globals);
typedef CALLBACK_API( void , TelephoneChooseIdleProcPtr )(void);
typedef STACK_UPP_TYPE(TelephoneTermMsgProcPtr)                 TelephoneTermMsgUPP;
typedef STACK_UPP_TYPE(TelephoneDNMsgProcPtr)                   TelephoneDNMsgUPP;
typedef STACK_UPP_TYPE(TelephoneCAMsgProcPtr)                   TelephoneCAMsgUPP;
typedef STACK_UPP_TYPE(TelephoneChooseIdleProcPtr)              TelephoneChooseIdleUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewTelephoneTermMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( TelephoneTermMsgUPP )
NewTelephoneTermMsgUPP(TelephoneTermMsgProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppTelephoneTermMsgProcInfo = 0x0000EBC0 };  /* pascal no_return_value Func(4_bytes, 4_bytes, 2_bytes, 2_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline TelephoneTermMsgUPP NewTelephoneTermMsgUPP(TelephoneTermMsgProcPtr userRoutine) { return (TelephoneTermMsgUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppTelephoneTermMsgProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewTelephoneTermMsgUPP(userRoutine) (TelephoneTermMsgUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppTelephoneTermMsgProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewTelephoneDNMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( TelephoneDNMsgUPP )
NewTelephoneDNMsgUPP(TelephoneDNMsgProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppTelephoneDNMsgProcInfo = 0x003FEBC0 };  /* pascal no_return_value Func(4_bytes, 4_bytes, 2_bytes, 2_bytes, 4_bytes, 4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline TelephoneDNMsgUPP NewTelephoneDNMsgUPP(TelephoneDNMsgProcPtr userRoutine) { return (TelephoneDNMsgUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppTelephoneDNMsgProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewTelephoneDNMsgUPP(userRoutine) (TelephoneDNMsgUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppTelephoneDNMsgProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewTelephoneCAMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( TelephoneCAMsgUPP )
NewTelephoneCAMsgUPP(TelephoneCAMsgProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppTelephoneCAMsgProcInfo = 0x0003EBC0 };  /* pascal no_return_value Func(4_bytes, 4_bytes, 2_bytes, 2_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline TelephoneCAMsgUPP NewTelephoneCAMsgUPP(TelephoneCAMsgProcPtr userRoutine) { return (TelephoneCAMsgUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppTelephoneCAMsgProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewTelephoneCAMsgUPP(userRoutine) (TelephoneCAMsgUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppTelephoneCAMsgProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewTelephoneChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( TelephoneChooseIdleUPP )
NewTelephoneChooseIdleUPP(TelephoneChooseIdleProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppTelephoneChooseIdleProcInfo = 0x00000000 };  /* pascal no_return_value Func() */
  #ifdef __cplusplus
    inline TelephoneChooseIdleUPP NewTelephoneChooseIdleUPP(TelephoneChooseIdleProcPtr userRoutine) { return (TelephoneChooseIdleUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppTelephoneChooseIdleProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewTelephoneChooseIdleUPP(userRoutine) (TelephoneChooseIdleUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppTelephoneChooseIdleProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeTelephoneTermMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeTelephoneTermMsgUPP(TelephoneTermMsgUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeTelephoneTermMsgUPP(TelephoneTermMsgUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeTelephoneTermMsgUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeTelephoneDNMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeTelephoneDNMsgUPP(TelephoneDNMsgUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeTelephoneDNMsgUPP(TelephoneDNMsgUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeTelephoneDNMsgUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeTelephoneCAMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeTelephoneCAMsgUPP(TelephoneCAMsgUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeTelephoneCAMsgUPP(TelephoneCAMsgUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeTelephoneCAMsgUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeTelephoneChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeTelephoneChooseIdleUPP(TelephoneChooseIdleUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeTelephoneChooseIdleUPP(TelephoneChooseIdleUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeTelephoneChooseIdleUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeTelephoneTermMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeTelephoneTermMsgUPP(
  TELHandle            hTEL,
  long                 msg,
  short                mtype,
  short                value,
  long                 globals,
  TelephoneTermMsgUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeTelephoneTermMsgUPP(TELHandle hTEL, long msg, short mtype, short value, long globals, TelephoneTermMsgUPP userUPP) { CALL_FIVE_PARAMETER_UPP(userUPP, uppTelephoneTermMsgProcInfo, hTEL, msg, mtype, value, globals); }
  #else
    #define InvokeTelephoneTermMsgUPP(hTEL, msg, mtype, value, globals, userUPP) CALL_FIVE_PARAMETER_UPP((userUPP), uppTelephoneTermMsgProcInfo, (hTEL), (msg), (mtype), (value), (globals))
  #endif
#endif

/*
 *  InvokeTelephoneDNMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeTelephoneDNMsgUPP(
  TELDNHandle        hTELDN,
  long               Msg,
  short              mtype,
  short              value,
  ConstStr255Param   rmtDN,
  ConstStr255Param   rmtName,
  ConstStr255Param   rmtSubaddress,
  long               globals,
  TelephoneDNMsgUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeTelephoneDNMsgUPP(TELDNHandle hTELDN, long Msg, short mtype, short value, ConstStr255Param rmtDN, ConstStr255Param rmtName, ConstStr255Param rmtSubaddress, long globals, TelephoneDNMsgUPP userUPP) { CALL_EIGHT_PARAMETER_UPP(userUPP, uppTelephoneDNMsgProcInfo, hTELDN, Msg, mtype, value, rmtDN, rmtName, rmtSubaddress, globals); }
  #else
    #define InvokeTelephoneDNMsgUPP(hTELDN, Msg, mtype, value, rmtDN, rmtName, rmtSubaddress, globals, userUPP) CALL_EIGHT_PARAMETER_UPP((userUPP), uppTelephoneDNMsgProcInfo, (hTELDN), (Msg), (mtype), (value), (rmtDN), (rmtName), (rmtSubaddress), (globals))
  #endif
#endif

/*
 *  InvokeTelephoneCAMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeTelephoneCAMsgUPP(
  TELCAHandle        hTELCA,
  long               Msg,
  short              mtype,
  short              value,
  Ptr                Msginfo,
  long               globals,
  TelephoneCAMsgUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeTelephoneCAMsgUPP(TELCAHandle hTELCA, long Msg, short mtype, short value, Ptr Msginfo, long globals, TelephoneCAMsgUPP userUPP) { CALL_SIX_PARAMETER_UPP(userUPP, uppTelephoneCAMsgProcInfo, hTELCA, Msg, mtype, value, Msginfo, globals); }
  #else
    #define InvokeTelephoneCAMsgUPP(hTELCA, Msg, mtype, value, Msginfo, globals, userUPP) CALL_SIX_PARAMETER_UPP((userUPP), uppTelephoneCAMsgProcInfo, (hTELCA), (Msg), (mtype), (value), (Msginfo), (globals))
  #endif
#endif

/*
 *  InvokeTelephoneChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeTelephoneChooseIdleUPP(TelephoneChooseIdleUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeTelephoneChooseIdleUPP(TelephoneChooseIdleUPP userUPP) { CALL_ZERO_PARAMETER_UPP(userUPP, uppTelephoneChooseIdleProcInfo); }
  #else
    #define InvokeTelephoneChooseIdleUPP(userUPP) CALL_ZERO_PARAMETER_UPP((userUPP), uppTelephoneChooseIdleProcInfo)
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewTelephoneTermMsgProc(userRoutine)                NewTelephoneTermMsgUPP(userRoutine)
    #define NewTelephoneDNMsgProc(userRoutine)                  NewTelephoneDNMsgUPP(userRoutine)
    #define NewTelephoneCAMsgProc(userRoutine)                  NewTelephoneCAMsgUPP(userRoutine)
    #define NewTelephoneChooseIdleProc(userRoutine)             NewTelephoneChooseIdleUPP(userRoutine)
    #define CallTelephoneTermMsgProc(userRoutine, hTEL, msg, mtype, value, globals) InvokeTelephoneTermMsgUPP(hTEL, msg, mtype, value, globals, userRoutine)
    #define CallTelephoneDNMsgProc(userRoutine, hTELDN, Msg, mtype, value, rmtDN, rmtName, rmtSubaddress, globals) InvokeTelephoneDNMsgUPP(hTELDN, Msg, mtype, value, rmtDN, rmtName, rmtSubaddress, globals, userRoutine)
    #define CallTelephoneCAMsgProc(userRoutine, hTELCA, Msg, mtype, value, Msginfo, globals) InvokeTelephoneCAMsgUPP(hTELCA, Msg, mtype, value, Msginfo, globals, userRoutine)
    #define CallTelephoneChooseIdleProc(userRoutine)            InvokeTelephoneChooseIdleUPP(userRoutine)
#endif /* CALL_NOT_IN_CARBON */

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  InitTEL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
InitTEL(void);


/*
 *  TELGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetInfo(TELHandle hTEL);


/*
 *  TELOpenTerm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELOpenTerm(TELHandle hTEL);


/*
 *  TELResetTerm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELResetTerm(TELHandle hTEL);


/*
 *  TELCloseTerm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCloseTerm(TELHandle hTEL);


/*
 *  TELTermMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELTermMsgHand(
  TELHandle             hTEL,
  long                  eventMask,
  TelephoneTermMsgUPP   msgProc,
  long                  globals);


/*
 *  TELClrTermMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELClrTermMsgHand(
  TELHandle             hTEL,
  TelephoneTermMsgUPP   msgProc);


/*
 *  TELTermEventsSupp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELTermEventsSupp(
  TELHandle   hTEL,
  long *      eventMask);


/*
 *  TELGetProcID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
TELGetProcID(Str255 name);


/*
 *  TELNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELHandle )
TELNew(
  short      procID,
  TELFlags   flags,
  long       refCon,
  long       userData);


/*
 *  TELNewWithResult()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELHandle )
TELNewWithResult(
  short      procID,
  TELFlags   flags,
  long       refCon,
  long       userData,
  TELErr *   error);


/*
 *  TELDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDefault(
  Ptr *     theConfig,
  short     procID,
  Boolean   allocate);


/*
 *  TELValidate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
TELValidate(TELHandle hTEL);


/*
 *  TELGetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Ptr )
TELGetConfig(TELHandle hTEL);


/*
 *  TELSetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
TELSetConfig(
  TELHandle   hTEL,
  Ptr         thePtr);


/*
 *  TELChoose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELChoose(
  TELHandle *              hTEL,
  Point                    where,
  TelephoneChooseIdleUPP   idleProc);


/*
 *  TELSetupPreflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
TELSetupPreflight(
  short   procID,
  long *  magicCookie);


/*
 *  TELSetupSetup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELSetupSetup(
  short       procID,
  Ptr         theConfig,
  short       count,
  DialogRef   theDialog,
  long *      magicCookie);


/*
 *  TELSetupFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
TELSetupFilter(
  short          procID,
  Ptr            theConfig,
  short          count,
  DialogRef      theDialog,
  EventRecord *  theEvent,
  short *        theItem,
  long *         magicCookie);


/*
 *  TELSetupItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELSetupItem(
  short       procID,
  Ptr         theConfig,
  short       count,
  DialogRef   theDialog,
  short *     theItem,
  long *      magicCookie);


/*
 *  TELSetupCleanup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELSetupCleanup(
  short       procID,
  Ptr         theConfig,
  short       count,
  DialogRef   theDialog,
  long *      magicCookie);


/*
 *  TELSetupXCleanup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELSetupXCleanup(
  short       procID,
  Ptr         theConfig,
  short       count,
  DialogRef   theDialog,
  Boolean     OKed,
  long *      magicCookie);


/*
 *  TELSetupPostflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELSetupPostflight(short procID);


/*
 *  TELDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDispose(TELHandle hTEL);


/*
 *  TELCountDNs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
TELCountDNs(
  TELHandle   hTEL,
  short       dnType,
  Boolean     physical);


/*
 *  TELDNLookupByIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNLookupByIndex(
  TELHandle      hTEL,
  short          dnType,
  Boolean        physical,
  short          index,
  TELDNHandle *  hTELDN);


/*
 *  TELDNLookupByName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNLookupByName(
  TELHandle          hTEL,
  ConstStr255Param   DN,
  TELDNHandle *      hTELDN);


/*
 *  TELDNSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNSelect(
  TELDNHandle   hTELDN,
  Boolean       select);


/*
 *  TELDNDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNDispose(TELDNHandle hTELDN);


/*
 *  TELGetDNInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetDNInfo(TELDNHandle hTELDN);


/*
 *  TELGetDNFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetDNFlags(
  TELDNHandle   hTELDN,
  long *        dnFeatureFlags,
  long *        dnForwardFlags);


/*
 *  TELDNMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNMsgHand(
  TELDNHandle         hTELDN,
  Boolean             allDNs,
  long                eventMask,
  TelephoneDNMsgUPP   msgProc,
  long                globals);


/*
 *  TELClrDNMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELClrDNMsgHand(
  TELDNHandle         hTELDN,
  TelephoneDNMsgUPP   msgProc);


/*
 *  TELDNEventsSupp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNEventsSupp(
  TELDNHandle   hTELDN,
  long *        eventMask);


/*
 *  TELCountCAs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
TELCountCAs(
  TELDNHandle   hTELDN,
  short         internalExternal);


/*
 *  TELCALookup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCALookup(
  TELDNHandle    hTELDN,
  short          internalExternal,
  short          index,
  TELCAHandle *  hTELCA);


/*
 *  TELCADispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCADispose(TELCAHandle hTELCA);


/*
 *  TELGetCAState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetCAState(
  TELCAHandle   hTELCA,
  short *       state);


/*
 *  TELGetCAFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetCAFlags(
  TELCAHandle   hTELCA,
  long *        caFeatureFlags,
  long *        caOtherFeatures);


/*
 *  TELGetCAInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetCAInfo(TELCAHandle hTELCA);


/*
 *  TELCAMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCAMsgHand(
  TELDNHandle         hTELDN,
  long                eventMask,
  TelephoneCAMsgUPP   msgProc,
  long                globals);


/*
 *  TELClrCAMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELClrCAMsgHand(
  TELDNHandle         hTELDN,
  TelephoneCAMsgUPP   msgProc);


/*
 *  TELCAEventsSupp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCAEventsSupp(
  TELDNHandle   hTELDN,
  long *        eventMask);


/*
 *  TELSetupCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELSetupCall(
  TELDNHandle        hTELDN,
  TELCAHandle *      hTELCA,
  ConstStr255Param   destDN,
  ConstStr255Param   destName,
  ConstStr255Param   destSubaddress,
  ConstStr255Param   userUserInfo,
  short              bearerType,
  short              rate);


/*
 *  TELConnect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELConnect(TELCAHandle hTELCA);


/*
 *  TELDialDigits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDialDigits(
  TELCAHandle        hTELCA,
  ConstStr255Param   digits);


/*
 *  TELAcceptCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELAcceptCall(TELCAHandle hTELCA);


/*
 *  TELRejectCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELRejectCall(
  TELCAHandle   hTELCA,
  short         reason);


/*
 *  TELDeflectCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDeflectCall(
  TELCAHandle        hTELCA,
  ConstStr255Param   rmtDN,
  ConstStr255Param   rmtName,
  ConstStr255Param   rmtSubaddress);


/*
 *  TELAnswerCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELAnswerCall(TELCAHandle hTELCA);


/*
 *  TELDrop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDrop(
  TELCAHandle        hTELCA,
  ConstStr255Param   userUserInfo);


/*
 *  TELHold()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELHold(TELCAHandle hTELCA);


/*
 *  TELRetrieve()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELRetrieve(TELCAHandle hTELCA);


/*
 *  TELConferencePrep()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELConferencePrep(
  TELCAHandle   hTELCA1,
  TELCAHandle   hTELCA2,
  short         numToConference);


/*
 *  TELConferenceEstablish()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELConferenceEstablish(
  TELCAHandle   hTELCA1,
  TELCAHandle   hTELCA2);


/*
 *  TELConferenceSplit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELConferenceSplit(TELCAHandle hTELCA);


/*
 *  TELTransferPrep()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELTransferPrep(
  TELCAHandle   hTELCA1,
  TELCAHandle   hTELCA2);


/*
 *  TELTransferEstablish()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELTransferEstablish(
  TELCAHandle   hTELCA1,
  TELCAHandle   hTELCA2);


/*
 *  TELTransferBlind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELTransferBlind(
  TELCAHandle        hTELCA,
  ConstStr255Param   rmtDN,
  ConstStr255Param   rmtName,
  ConstStr255Param   rmtSubaddress);


/*
 *  TELForwardSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELForwardSet(
  TELDNHandle        hTELDN,
  ConstStr255Param   forwardDN,
  ConstStr255Param   forwardName,
  ConstStr255Param   forwardSubaddress,
  short              forwardType,
  short              numrings);


/*
 *  TELForwardClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELForwardClear(
  TELDNHandle   hTELDN,
  short         forwardType);


/*
 *  TELCallbackSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCallbackSet(
  TELCAHandle   hTELCA,
  short *       callbackRef);


/*
 *  TELCallbackClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCallbackClear(
  TELHandle   hTEL,
  short       callbackRef);


/*
 *  TELCallbackNow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCallbackNow(
  TELCAHandle   hTELCA,
  short         callbackRef);


/*
 *  TELDNDSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNDSet(
  TELDNHandle   hTELDN,
  short         dndType);


/*
 *  TELDNDClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNDClear(
  TELDNHandle   hTELDN,
  short         dndType);


/*
 *  TELCallPickup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCallPickup(
  TELCAHandle        hTELCA,
  ConstStr255Param   pickupDN,
  short              pickupGroupID);


/*
 *  TELParkCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELParkCall(
  TELCAHandle        hTELCA,
  StringPtr *        parkRetrieveID,
  ConstStr255Param   parkID);


/*
 *  TELRetrieveParkedCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELRetrieveParkedCall(
  TELCAHandle        hTELCA,
  ConstStr255Param   parkRetrieveID);


/*
 *  TELVoiceMailAccess()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELVoiceMailAccess(TELCAHandle hTELCA);


/*
 *  TELPaging()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELPaging(
  TELCAHandle   hTELCA,
  short         pageID);


/*
 *  TELIntercom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELIntercom(
  TELCAHandle   hTELCA,
  short         intercomID);


/*
 *  TELOtherFeatureList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELOtherFeatureList(
  TELHandle         hTEL,
  FeatureListPtr *  fList);


/*
 *  TELOtherFeatureImplement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELOtherFeatureImplement(
  TELHandle   hTEL,
  Handle      theHandle,
  short       featureID);


/*
 *  TELToolFunctions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELToolFunctions(
  TELHandle   hTEL,
  short       msgcode,
  Boolean *   supportsIt);


/*
 *  TELOtherFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELOtherFunction(
  TELHandle   hTEL,
  Ptr         paramblock,
  long        size);


/*
 *  TELGetHooksw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetHooksw(
  TELHandle   hTEL,
  short       hookType,
  Boolean *   offHook);


/*
 *  TELSetHooksw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELSetHooksw(
  TELHandle   hTEL,
  short       hookType,
  Boolean     offHook);


/*
 *  TELGetVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetVolume(
  TELHandle   hTEL,
  short       volType,
  short *     level,
  short *     volState);


/*
 *  TELSetVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELSetVolume(
  TELHandle   hTEL,
  short       volType,
  short *     level,
  short       volState);


/*
 *  TELAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELAlert(
  TELHandle   hTEL,
  short *     level,
  short       alertPattern);


/*
 *  TELGetDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetDisplay(
  TELHandle    hTEL,
  short        index,
  short *      displayMode,
  StringPtr *  text);


/*
 *  TELSetDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELSetDisplay(
  TELHandle          hTEL,
  short              index,
  short              displayMode,
  ConstStr255Param   text);


/*
 *  TELIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELIdle(TELHandle hTEL);


/*
 *  TELActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELActivate(
  TELHandle   hTEL,
  Boolean     activate);


/*
 *  TELResume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELResume(
  TELHandle   hTEL,
  Boolean     resume);


/*
 *  TELMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
TELMenu(
  TELHandle   hTEL,
  short       menuID,
  short       item);


/*
 *  TELEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELEvent(
  TELHandle            hTEL,
  const EventRecord *  theEvent);


/*
 *  TELGetToolName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TELGetToolName(
  short    procID,
  Str255   name);


/*
 *  TELGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
TELGetVersion(TELHandle hTEL);


/*
 *  TELGetTELVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
TELGetTELVersion(void);


/*
 *  TELIntlToEnglish()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELIntlToEnglish(
  TELHandle   hTEL,
  Ptr         inputPtr,
  Ptr *       outputPtr,
  short       language);


/*
 *  TELEnglishToIntl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELEnglishToIntl(
  TELHandle   hTEL,
  Ptr         inputPtr,
  Ptr *       outputPtr,
  short       language);


/*
 *  TELGetDNSoundInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetDNSoundInput(
  TELDNHandle   hTELDN,
  Str255        deviceName);


/*
 *  TELDisposeDNSoundInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDisposeDNSoundInput(
  TELDNHandle        hTELDN,
  ConstStr255Param   deviceName);


/*
 *  TELGetDNSoundOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetDNSoundOutput(
  TELDNHandle   hTELDN,
  Component *   SndOut);


/*
 *  TELDisposeDNSoundOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDisposeDNSoundOutput(
  TELDNHandle   hTELDN,
  Component     SndOut);


/*
 *  TELGetHSSoundInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetHSSoundInput(
  TELHandle   termHand,
  Str255      deviceName);


/*
 *  TELDisposeHSSoundInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDisposeHSSoundInput(
  TELHandle          termHand,
  ConstStr255Param   deviceName);


/*
 *  TELGetHSSoundOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetHSSoundOutput(
  TELHandle    termHand,
  Component *  SndOut);


/*
 *  TELDisposeHSSoundOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDisposeHSSoundOutput(
  TELHandle   termHand,
  Component   SndOut);


/*
 *  TELDNSetAutoAnswer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNSetAutoAnswer(
  TELDNHandle   hTELDN,
  Boolean       AutoAnswerOn);


/*
 *  TELDNTollSaverControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNTollSaverControl(
  TELDNHandle   hTELDN,
  Boolean       QuickAnswer);


/*
 *  TELSetIndHSConnect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELSetIndHSConnect(
  TELHandle   termHand,
  Boolean     Connect);


/*
 *  TELGetIndHSConnect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetIndHSConnect(
  TELHandle   termHand,
  Boolean *   Connect);


/*
 *  TELCAVoiceDetect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCAVoiceDetect(
  TELCAHandle   hTELCA,
  Boolean       VoiceDetectOn);


/*
 *  TELCASilenceDetect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELCASilenceDetect(
  TELCAHandle   hTELCA,
  Boolean       DetectOn,
  long          Period);


/*
 *  TELGetTelNewErr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetTelNewErr(void);


/*
 *  TELDNSetDTMF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNSetDTMF(
  TELDNHandle   hTELDN,
  Boolean       dtmfOn);


/*
 *  TELDNGetDTMF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELDNGetDTMF(
  TELDNHandle   hTELDN,
  Boolean *     dtmfOn);


/*
 *  TELHSSetDTMF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELHSSetDTMF(
  TELHandle   termHand,
  Boolean     dtmfOn);


/*
 *  TELHSGetDTMF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELHSGetDTMF(
  TELHandle   termHand,
  Boolean *   dtmfOn);


/*
 *  TELGetDNStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetDNStatus(
  TELDNHandle   hTELDN,
  long *        inUse);


/*
 *  TELGetDNProgressDet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELGetDNProgressDet(
  TELDNHandle   hTELDN,
  long          selector,
  Boolean *     prgDetOn);


/*
 *  TELSetDNProgressDet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TELErr )
TELSetDNProgressDet(
  TELDNHandle   hTELDN,
  long          selector,
  Boolean       prgDetOn);



#endif  /* CALL_NOT_IN_CARBON */


#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __TELEPHONES__ */

