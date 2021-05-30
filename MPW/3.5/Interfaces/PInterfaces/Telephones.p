{
     File:       Telephones.p
 
     Contains:   Telephone Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Telephones;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TELEPHONES__}
{$SETC __TELEPHONES__ := 1}

{$I+}
{$SETC TelephonesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __CTBUTILITIES__}
{$I CTBUtilities.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }

CONST
	curTELVersion				= 3;							{  current Telephone Manager version  }
																{     the chooseXXX symbols are defined in CTBUtilities.(pah)  }
	telChooseDisaster			= -2;
	telChooseFailed				= -1;
	telChooseAborted			= 0;
	telChooseOKMinor			= 1;
	telChooseOKMajor			= 2;
	telChooseCancel				= 3;
	telChooseOKTermChanged		= 4;

{$IFC UNDEFINED classTEL }
																{  telephone tool file type  }
	classTEL					= 'vbnd';

{$ENDC}
	{	 PHYSICAL TERMINAL CONSTANTS 	}
	{	 INDEPENDENT HANDSET CONSTANTS 	}
	telIndHSOnHook				= 0;							{  independent handset on hook  }
	telIndHSOffHook				= 1;							{  independent handset off hook  }

	telIndHSDisconnected		= 0;							{  handset disconnected from the line  }
	telIndHSConnected			= 1;							{  handset connected to the line  }


	{	 HOOK STATE CONSTANTS 	}
	telHandset					= 1;							{  handset hookswitch  }
	telSpeakerphone				= 2;							{  speakerphone 'on' switch  }

	telDeviceOffHook			= 1;							{  device off hook  }
	telDeviceOnHook				= 0;							{  device on hook  }


	{	 VOLUME CONTROL CONSTANTS 	}
	telHandsetSpeakerVol		= 1;							{  volume of the handset speaker  }
	telHandsetMicVol			= 2;							{  sensitivity of the handset mic  }
	telSpeakerphoneVol			= 3;							{  speakerphone volume  }
	telSpeakerphoneMicVol		= 4;							{  sensitivity of the spkrphone mic  }
	telRingerVol				= 5;							{  volume of the ringer  }
	telBuiltinSPVol				= 6;							{  volume of the built-in speakerphone  }
	telBuiltinSPMicVol			= 7;							{  sensitivity of the built-in speakerphone mic  }

	telVolSame					= 0;							{  leaves the volume at previous level  }
	telVolMin					= 1;							{  turns volume down to minimum level, but not off  }
	telVolMax					= 100;							{  highest level allowed by the Telephone Manager  }

	telVolStateSame				= 0;							{  leaves device in same state  }
	telVolStateOff				= 1;							{  turns the device off, but doesn't change the volume setting. Use for mute functions.  }
	telVolStateOn				= 2;							{  turns the device on.  Volume setting is the same as previously set.  }

	{	 DISPLAY CONSTANTS 	}
	telNormalDisplayMode		= 1;							{  normal display mode  }
	telInspectMode				= 2;							{  inspect display mode  }
	telMiscMode					= 3;							{  miscellaneous display mode  }
	telRetrieveMode				= 4;							{  message retrieval mode  }
	telDirectoryQueryMode		= 5;							{  electronic directory mode  }
	telEntireDisplay			= 0;							{  entire Display  }


	{	 KEY PRESS CONSTANTS 	}
	telHangupKey				= 1;							{  drop, or release, key pressed  }
	telHoldKey					= 2;							{  hold key pressed  }
	telConferenceKey			= 3;							{  conference key pressed  }
	telTransferKey				= 4;							{  transfer key pressed  }
	telForwardKey				= 5;							{  call forward key pressed  }
	telCallbackKey				= 6;							{  call back key pressed  }
	telDNDKey					= 7;							{  do not disturb key pressed  }
	telCallPickupKey			= 8;							{  call Pickup key pressed  }
	telCallParkKey				= 9;							{  call Park key pressed  }
	telCallDeflectKey			= 10;							{  call Deflect key pressed  }
	telVoiceMailAccessKey		= 11;							{  voice Mail Access key pressed  }
	telCallRejectKey			= 12;							{  call Reject key pressed  }
	telOtherKey					= 16;							{  other key pressed  }


	telKeyPadPress				= 1;							{  key pressed on 12 digit keypad }
	telFeatureKeyPress			= 2;							{  feature Key Pressed  }

	telTerminalEnabled			= 0;
	telTerminalDisabled			= 1;

	telUnknown					= 0;							{  unknown error  }
	telTerminalHWDisconnected	= 1;							{  terminal hardware is disconnected  }
	telDeviceDriverClosed		= 2;							{  device driver is closed  }


	{	 ALERT PATTERN 	}
	telPattern0					= 0;
	telPattern1					= 1;
	telPattern2					= 2;
	telPattern3					= 3;
	telPattern4					= 4;
	telPattern5					= 5;
	telPattern6					= 6;
	telPattern7					= 7;
	telPatternOff				= 8;
	telPatternUndefined			= 15;


	{	 DN TYPES 	}
	telAllDNs					= 0;							{  counts all types of DNs  }
	telInternalDNs				= 1;							{  connected to PBX or other non-public switch  }
	telInternalDNsOnly			= 2;							{  connected to PBX or other non-public switch  }
																{  and able to place internal calls only  }
	telExternalDNs				= 3;							{  connected to public network  }
	telDNTypeUnknown			= 4;							{  DN type unknown  }


	{	 DN USAGE 	}
	telDNNotUsed				= 0;							{  DN is not used - onhook  }
	telDNPOTSCall				= 1;							{  DN used for POTs call  }
	telDNFaxCall				= 2;							{  DN used for fax call  }
	telDNDataCall				= 3;							{  DN used for data call  }
	telDNAlerting				= 4;							{  Incoming call at DN  }
	telDNUnknownState			= 5;							{  DN is in unknown state  }


	{	 CALL FORWARDING TYPES 	}
	telForwardImmediate			= 1;							{  immediately forward calls  }
	telForwardBusy				= 2;							{  forward on Busy  }
	telForwardNoAnswer			= 3;							{  forward on No answer  }
	telForwardBusyNA			= 4;							{  forwarding for busy and no answer }
	telForwardTypeUnknown		= 5;							{  type of forwarding is unknown  }


	{	 CALL FORWARDING MESSAGES 	}
	telForwardCleared			= 0;							{  forwarding has been cleared  }
	telForwardEst				= 1;							{  forwarding has been established }
	telForwardFailed			= 2;							{  attempt to setup forwarding has failed }


	{	 DO NOT DISTURB TYPES 	}
	telDNDIntExt				= 0;							{  do not disturb for all internal and external calls }
	telDNDExternal				= 1;							{  do not disturb for external calls only  }
	telDNDInternal				= 2;							{  do not disturb for internal calls only  }
	telDNDNonIntercom			= 3;							{  do not disturb for all calls except intercom  }


	{	 DO NOT DISTURB MESSAGES 	}
	telDNDCleared				= 0;							{  do not disturb has been cleared  }
	telDNDEst					= 1;							{  do not disturb has been established  }
	telDNDFailed				= 2;							{  attempt to setup do not disturb has failed  }


	{	 VOICE MAIL MESSAGES 	}
	telAllVoiceMessagesRead		= 0;							{  all messages have been read, none are  waiting  }
																{  to be read  }
	telNewVoiceMessage			= 1;							{  a new message has arrived or messages are waiting for this DN  }


	{	 DNSELECT MESSAGE 	}
	telDNDeselected				= 0;							{  DN has been deselected  }
	telDNSelected				= 1;							{  DN has been selected  }


	{	 CALL ORIGINATORS 	}
	telInternalCall				= 0;							{  return nth internal CA  }
	telExternalCall				= 1;							{  return nth external CA  }
	telUnknownCallOrigin		= 2;							{  unknown call type  }
	telAllCallOrigins			= 2;							{  return nth CA internal or external  }


	{	 CALL TYPES 	}
	telVoiceMailAccessOut		= -7;
	telPageOut					= -6;
	telIntercomOut				= -5;
	telCallbackOut				= -4;
	telPickup					= -3;
	telParkRetrieve				= -2;
	telNormalOut				= -1;
	telUnknownCallType			= 0;
	telNormalIn					= 1;
	telForwardedImmediate		= 2;
	telForwardedBusy			= 3;
	telForwardedNoAnswer		= 4;
	telTransfer					= 5;
	telDeflected				= 6;
	telIntercepted				= 7;
	telDeflectRecall			= 8;
	telParkRecall				= 9;
	telTransferredRecall		= 10;
	telIntercomIn				= 11;
	telCallbackIn				= 12;


	{	 DIAL TYPES 	}
	telDNDialable				= 0;							{  this DN could be dialed via TELSetupCall  }
	telDNNorthAmerican			= 1;							{  rmtDN is standard North America 10 digit number  }
	telDNInternational			= 2;							{  rmtDN is an international number  }
	telDNAlmostDialable			= 3;							{  rmtDN is almost dialable, missing prefix such as 9 or 1  }
	telDNUnknown				= 15;							{  unknown whether DN is dialable  }


	{	 CALL PROGRESS MESSAGES 	}
	telCAPDialTone				= 1;							{  dial tone  }
	telCAPRinging				= 2;							{  destination CA is alerting  }
	telCAPDialing				= 3;							{  dialing the other end  }
	telCAPReorder				= 4;							{  reorder  }
	telCAPBusy					= 5;							{  busy  }
	telCAPRouted				= 6;							{  call routed; rmtDN will hold the routing directory number routeDN and routePartyName have been updated  }
	telCAPRoutedOff				= 7;							{  call routed off-network; no further progress will be available  }
	telCAPTimeout				= 8;							{  call timed out  }
	telCAPUpdate				= 9;							{  name and rmtDN information has been updated  }
	telCAPPrompt				= 10;							{  the network is prompting for more information  }
	telCAPWaiting				= 11;							{  call is proceeding, but there is no response yet from the destination  }
	telCAPCPC					= 12;							{  telephone tool detected CPC signal  }
	telCAPNoDialTone			= 13;							{  dial tone not detected  }
	telCAPUnknown				= 15;							{  call progress state unknown  }
	telCAPDialDisabled			= 16;							{  Blacklisting: Dial Disabled  }
	telCAPBlacklistedNumber		= 17;							{  Blacklisting: Blacklisted Number  }
	telCAPForbiddenNumber		= 18;							{  Blacklisting: Forbidden Number  }
	telCAPModemGuardTime		= 19;							{  Modem Guard Timein force, unable to dial  }
	telCAPLCDetected			= 20;							{  trying to dial a number while the handset is offhook  }
	telCAPLostLC				= 21;							{  trying manual dial or answer while handset not off hook or also lost line current during dialing.  }


	{	 OUTGOING CALL MESSAGES 	}
	telPhysical					= 0;							{  user lifted handset and initiated call  }
	telProgrammatic				= 1;							{  programmatic initiation of outgoing call  }


	{	 DISCONNECT MESSAGES 	}
	telLocalDisconnect			= 0;							{  local party, this user, responsible for disconnect  }
	telRemoteDisconnect			= 1;							{  remote party responsible for disconnect  }


	{	 DISCONNECT TYPES 	}
	telCADNormal				= 1;							{  normal disconnect  }
	telCADBusy					= 2;							{  remote user busy  }
	telCADNoResponse			= 3;							{  remote not responding  }
	telCADRejected				= 4;							{  call rejected  }
	telCADNumberChanged			= 5;							{  number changed  }
	telCADInvalidDest			= 6;							{  invalid destination address  }
	telCADFacilityRejected		= 7;							{  requested facility rejected  }
	telCADUnobtainableDest		= 9;							{  destination not obtainable  }
	telCADCongested				= 10;							{  network congestion  }
	telCADIncompatibleDest		= 11;							{  incompatible destination  }
	telCADTimeout				= 12;							{  call timed out  }
	telCADUnknown				= 15;							{  reason unknown  }


	{	 CONFERENCE MESSAGES 	}
	telConferencePrepFailed		= 0;							{  conference could not be prepared  }
	telConferencePending		= 1;							{  conference prepared successfully  }
	telConferenceEstFailed		= 2;							{  conference could not be established  }
	telConferenceEst			= 3;							{  conference established  }


	{	 TRANSFER MESSAGES 	}
	telTransferPrepFailed		= 0;							{  transfer could not be prepared  }
	telTransferPending			= 1;							{  transfer prepared successfully  }
	telTransferEst				= 2;							{  consult or blind xfer successful  }
	telTransferFailed			= 3;							{  consult or blind xfer failed  }
	telTransferred				= 4;							{  message to originator of CA specifying that call was transferred to rmtDN  }


	{	 HOLD MESSAGES 	}
	telHoldCleared				= 0;
	telHoldEst					= 1;
	telHoldFailed				= 2;


	{	 RECEIVE DIGIT MESSAGES 	}
	telDigitAudible				= 0;
	telDigitNotAudible			= 1;


	{	 CALL PARK MESSAGES 	}
	telCallParkEst				= 1;							{  call has been successfully parked  }
	telCallParkRetrieveEst		= 2;							{  parked Call has been successfully retrieved  }
	telCallParkFailed			= 3;							{  attempt to setup call park has failed  }
	telCallParkRetrieveFailed	= 4;							{  attempt to retrieve parked call failed  }
	telCallParkRecall			= 5;							{  call park has been recalled  }


	{	 CALL BACK MESSAGES 	}
	telCallbackCleared			= 0;							{  call back has been cleared  }
	telCallbackEst				= 1;							{  call back has been established  }
	telCallbackNowAvail			= 2;							{  call can be called back with TELCallBackNow if CA is zero, else call IS calling back on CA  }
	telCallbackFailed			= 3;							{  attempt to setup callback has failed  }
	telCallbackDesired			= 4;							{  a user has called this terminal, received no answer and desires this terminal to call it back  }
	telCallbackDesiredCleared	= 5;							{  call back for no answer no longer desired  }
	telCalledback				= 6;							{  callback has occurred successfully  }


	{	 CALL REJECT MESSAGES 	}
	telCallRejectFailed			= 0;							{  attempt to reject call has failed  }
	telCallRejectEst			= 1;							{  call successfully rejected  }
	telCallRejected				= 2;							{  message to originator that call was rejected  }


	{	 CALL DEFLECT MESSAGES 	}
	telCallDeflectFailed		= 0;							{  attempt to deflect call has failed  }
	telCallDeflectEst			= 1;							{  call successfully deflected  }
	telCallDeflectRecall		= 2;							{  deflected call has been recalled  }
	telCallDeflected			= 3;							{  message to originator that call was deflected to rmtDN  }
	telAutoDeflectImmediate		= 4;							{  a call was automatically deflected from this terminal as a result of immediate call forwarding  }
	telAutoDeflectBusy			= 5;							{  a call was automatically deflected from this terminal as a result of call forwarding on busy  }
	telAutoDeflectNoAnswer		= 6;							{  a call was automatically deflected from this terminal as a result of call forwarding on no answer  }


	{	 CONFERENCE SPLIT MESSAGES 	}
	telConferenceSplitFailed	= 0;							{  CA could not be split  }
	telConferenceSplitEst		= 1;							{  CA split successfully  }


	{	 CONFERENCE DROP MESSAGES 	}
	telConferenceDropFailed		= 0;							{  CA could not be dropped  }
	telConferenceDropped		= 1;							{  CA dropped successfully  }


	{	 CALL PICKUP MESSAGES 	}
	telCallPickupEst			= 0;							{  call pickup was successful  }
	telCallPickupFailed			= 1;							{  call pickup failed  }
	telCallPickedUp				= 2;							{  message to originator that call was picked up at a different DN  }


	{	 PAGING MESSAGES 	}
	telPageEst					= 0;							{  paging was successful  }
	telPageComplete				= 1;							{  paging activity completed  }
	telPageFailed				= 2;							{  paging failed  }


	{	 INTERCOM MESSAGES 	}
	telIntercomEst				= 0;							{  intercom was successful  }
	telIntercomComplete			= 1;							{  intercom activity completed  }
	telIntercomFailed			= 2;							{  intercom failed  }


	{	 MODEM TONE MESSAGES 	}
	telModemToneDetected		= 0;							{  modem tone was detected  }
	telModemToneCleared			= 1;							{  modem tone went away  }


	{	 FAX TONE MESSAGES 	}
	telFaxToneDetected			= 0;							{  fax tone was detected  }
	telFaxToneCleared			= 1;							{  fax tone went away  }


	{	 IN USE MESSAGES 	}
	telInUsePrivate				= 0;							{  MADN is in use and can't be accessed  }
	telInUseCanAccess			= 1;							{  MADN is in use, and others can access it and join in  }
	telInUseCanMakePrivate		= 2;							{  MADN is in use, but available for any one person to access  }
	telInUseCleared				= 3;							{  MADN is no longer in use  }


	{	 CALL APPEARANCE STATES 	}
	telCAIdleState				= 0;							{  a call doesn't exist at this time  }
	telCAInUseState				= 1;							{  the call is active but at another terminal  }
	telCAOfferState				= 2;							{  a call is being offered to the terminal  }
	telCAQueuedState			= 3;							{  a call is being queued at this terminal  }
	telCAAlertingState			= 4;							{  a call is alerting at the terminal  }
	telCADialToneState			= 5;							{  initiated outgoing call has dialtone  }
	telCADialingState			= 6;							{  initiated outgoing call is dialing  }
	telCAWaitingState			= 7;							{  initiated outgoing call is waiting for response from destination  }
	telCARingingState			= 8;							{  the outgoing call is ringing.  }
	telCABusyState				= 9;							{  destination is busy or can't be reached  }
	telCAHeldState				= 10;							{  call has been put on hold by this terminal  }
	telCAConferencedState		= 11;							{  this CA is part of a conference now  }
	telCAActiveState			= 12;							{  the call is active and parties are free to exchange data }
	telCAReorderState			= 13;							{  CA is in a reorder state  }
	telCAConferencedHeldState	= 14;							{  CA is a conference call in a held state  }
	telCAUnknownState			= 15;							{  the call state is unknown  }


	{	 TERMINAL MESSAGE EVENTMASKS 	}
	telTermHookMsg				= $00000001;					{  the hookswitch state has changed  }
	telTermKeyMsg				= $00000002;					{  a phone pad key has been depressed  }
	telTermVolMsg				= $00000004;					{  volume setting has changed  }
	telTermDisplayMsg			= $00000008;					{  display has changed  }
	telTermEnableMsg			= $00000010;					{  terminal has become enabled  }
	telTermOpenMsg				= $00000020;					{  terminal has been opened  }
	telTermCloseMsg				= $00000040;					{  terminal is shutting down  }
	telTermResetMsg				= $00000080;					{  terminal has been reset  }
	telTermErrorMsg				= $00000100;					{  hard equipment error  }
	telTermIndHSStateChgMsg		= $00000200;					{  change in handset state from inacive to active or vice versa  }
	telTermIndHSConnectMsg		= $00000400;					{  independent handset connection has been changed  }
	telTermKeyImmMsg			= $00000800;					{  immidiate arrival of phone pad key  }
	telTermVolStateMsg			= $00001000;					{  volume state has changed  }
	telTermOtherMsg				= $80000000;					{  vendor defined error  }
	telAllTermMsgs				= $00001FFF;					{  mask to all non tool specific terminal events  }


	{	 DN MESSAGE EVENTMASK CONSTANTS 	}
	telDNForwardMsg				= $00000001;					{  forward feature activity  }
	telDNDNDMsg					= $00000002;					{  do not disturb feature activity  }
	telDNVoiceMailMsg			= $00000004;					{  message has arrived for this DN  }
	telDNSelectedMsg			= $00000008;					{  DN has been selected or deselected  }
	telDNOtherMsg				= $80000000;					{  a custom message for use by tools  }
	telAllDNMsgs				= $0000000F;					{  mask to all non tool specific dn events  }


	{	 CA MESSAGE EVENTMASK CONSTANTS 	}
	telCAAlertingMsg			= $00000001;					{  CA is alerting   }
	telCAOfferMsg				= $00000002;					{  CA is being offered a call  }
	telCAProgressMsg			= $00000004;					{  call progress info for this CA  }
	telCAOutgoingMsg			= $00000008;					{  CA is initiating an outgoing call  }
	telCADisconnectMsg			= $00000010;					{  CA disconnected (dropped or rmt disc  }
	telCAActiveMsg				= $00000020;					{  CA is active and voice/data is free to flow end to end  }
	telCAConferenceMsg			= $00000040;					{  conference activity on CA  }
	telCATransferMsg			= $00000080;					{  transfer feature activity  }
	telCAHoldMsg				= $00000100;					{  hold feature activity  }
	telCADigitsMsg				= $00000200;					{  remote signaling digits arrived  }
	telCACallParkMsg			= $00000400;					{  CA call park feature activity  }
	telCACallbackMsg			= $00000800;					{  CA call back feature activity   }
	telCARejectMsg				= $00001000;					{  CA is rejected  }
	telCADeflectMsg				= $00002000;					{  CA is deflected  }
	telCAForwardMsg				= $00004000;					{  CA is forwarded to this DN   }
	telCAConferenceSplitMsg		= $00008000;					{  conference split activity   }
	telCAConferenceDropMsg		= $00010000;					{  conference drop activity   }
	telCAQueuedMsg				= $00020000;					{  CA has been queued   }
	telCAInUseMsg				= $00040000;					{  CA is in use   }
	telCACallPickupMsg			= $00080000;					{  CA pickup activity  }
	telCAPagingMsg				= $00100000;					{  CA paging activity  }
	telCAIntercomMsg			= $00200000;					{  CA intercom activity  }
	telCAModemToneMsg			= $00400000;					{  modem tones detected  }
	telCAFaxToneMsg				= $00800000;					{  fax tones detected  }
	telCAIdleMsg				= $01000000;					{  CA is in idle state  }
	telCASuccessiveAlertMsg		= $02000000;					{  phone is alerting, one per ring  }
	telCAUserUserInfoMsg		= $04000000;					{  user to user information has arrrived for this CA  }
	telCAHandOffMsg				= $08000000;					{  CA is ready for hand-off  }
	telCAVoiceDetectedMsg		= $10000000;					{  voice Detect related event  }
	telCASilenceDetectedMsg		= $20000000;					{  silence Detect related event  }
	telCADigitsImmMsg			= $40000000;					{  immidiate arrival of remote signaling digits  }
	telCAOtherMsg				= $80000000;					{  tool specific CA message  }
	telAllCAMsgs				= $7FFFFFFF;					{  mask to all non tool specific CA events  }


TYPE
	TELErr								= OSErr;
	TELFlags 					= UInt32;
CONST
	telNoMenus					= $00010000;					{  tells tool not to display any custom menus  }
	telQuiet					= $00020000;					{  tells tool not to display any dialog boxes or alerts  }
	telConfigChanged			= $00040000;					{  notifies application that the config has changed  }



TYPE
	TELFeatureFlags 			= UInt32;
CONST
	pcmAvail					= $00000001;					{  true if PCM voice data accessible  }
	hasHandset					= $00000002;					{  true if a phone handset is attached   }
	hasSpeakerphone				= $00000004;					{  true if a 2 way speakerphone is attached  }
	canOnHookDial				= $00000008;					{  can on-hook dial  }
	hasRinger					= $00000010;					{  terminal has its own ringer  }
	canSetDisplay				= $00000020;					{  application can write to the display  }
	hasKeypad					= $00000040;					{  attached phone has standard 12 key pad  }
	hasVideo					= $00000080;					{  terminal has a videophone  }
	hasOther					= $00000100;					{  reserved for future use  }
	crossDNConference			= $00000200;					{  can perform cross-DN conferences  }
	hasSubaddress				= $00000400;					{  attached network supports subaddressing  }
	hasUserUserInfo				= $00000800;					{  network supports user-to-user info  }
	hasHandsetSoundStreams		= $00001000;					{  sound streams are supported on the handset  }
	hasIndHandset				= $00002000;					{  handset can be accessed independently of the phone line  }
	hasBuiltinSpeakerphone		= $00004000;					{  speaker and microphone of the Mac can be used  }



TYPE
	TELTermRecordPtr = ^TELTermRecord;
	TELTermRecord = RECORD
		tRef:					INTEGER;
		featureFlags:			TELFeatureFlags;
		handsetSpeakerVol:		INTEGER;
		handsetMicVol:			INTEGER;
		speakerphoneVol:		INTEGER;
		speakerphoneMicVol:		INTEGER;
		ringerVol:				INTEGER;
		otherVol:				INTEGER;
		ringerTypes:			INTEGER;
		hasDisplay:				INTEGER;
		displayRows:			INTEGER;
		numDNs:					INTEGER;
		maxAllocCA:				INTEGER;
		curAllocCA:				INTEGER;
		builtinSpeakerVol:		INTEGER;
		builtinSpeakerMicVol:	INTEGER;
		reserved:				LONGINT;
	END;

	TELTermPtr							= ^TELTermRecord;
	TELRecordPtr = ^TELRecord;
	TELRecord = RECORD
		procID:					INTEGER;
		flags:					TELFlags;
		reserved:				INTEGER;
		refCon:					LONGINT;
		userData:				LONGINT;
		defproc:				UniversalProcPtr;
		config:					Ptr;
		oldConfig:				Ptr;
		pTELTerm:				TELTermPtr;
		telPrivate:				LONGINT;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
		pTELTermSize:			LONGINT;
		version:				INTEGER;
	END;

	TELPtr								= ^TELRecord;
	TELHandle							= ^TELPtr;

	TELDNFeatureFlags 			= UInt32;
CONST
	dndSub						= $00000001;					{  do not disturb subscribed  }
	dndAvail					= $00000002;					{  do not disturb available  }
	dndActive					= $00000004;					{  do not disturb active  }
	voiceMailAccessSub			= $00000008;					{  message waiting subscribed  }
	voiceMailAccessAvail		= $00000010;					{  message waiting available  }
	voiceMailAccessActive		= $00000020;					{  message waiting active  }
	pagingSub					= $00000040;					{  paging is subscribed  }
	pagingAvail					= $00000080;					{  paging is available  }
	pagingActive				= $00000100;					{  paging is active  }
	intercomSub					= $00000200;					{  intercom is subscribed  }
	intercomAvail				= $00000400;					{  intercom is available  }
	intercomActive				= $00000800;					{  intercom is active  }
	dnSelectSub					= $00001000;					{  DN select is subscribed  }
	dnSelectAvail				= $00002000;					{  DN select is available  }
	dnSelectActive				= $00004000;					{  DN is selected  }
	callPickupSub				= $00008000;					{  call pickup is subscribed  }
	callPickupAvail				= $00010000;					{  call pickup is available  }
	dnInUse						= $00020000;					{  a CA is allocated for this DN  }
	logicalDN					= $00040000;					{  this DN is not on this terminal  }
	dnAccessible				= $00080000;					{  commands can be sent to this DN  }
	canInitiate					= $00100000;					{  an outgoing CA can be initiated  }
	voiceMessageWaiting			= $00200000;					{  voice mail waiting for this dn  }
	hasDNSoundStreams			= $00400000;					{  sound streams are supported on this DN  }
	autoAnswerAvail				= $00800000;					{  AutoAnswer is set for this DN  }
	autoAnswerActive			= $01000000;					{  AutoAnswer is currently applied to CA on this DN  }
	tollSaverAvail				= $02000000;					{  tollSaver is set for this DN  }
	tollSaverActive				= $04000000;					{  tollSaver is currently applied to CA on this DN  }



TYPE
	TELDNForwardFlags 			= UInt32;
CONST
	immediateForwardSub			= $00000001;					{  immediate call forward subscribed  }
	immediateForwardAvail		= $00000002;					{  immediate call forward available  }
	immediateForwardActive		= $00000004;					{  immediate call forward active  }
	busyForwardSub				= $00000008;					{  forward on busy subscribed  }
	busyForwardAvail			= $00000010;					{  forward on busy available  }
	busyForwardActive			= $00000020;					{  forward on busy active  }
	noAnswerForwardSub			= $00000040;					{  no answer call forward subscribed  }
	noAnswerForwardAvail		= $00000080;					{  no answer call forward available  }
	noAnswerForwardActive		= $00000100;					{  no answer call forward active  }
	busyNAForwardSub			= $00000200;					{  busy & no answer call forward subscribed  }
	busyNAForwardAvail			= $00000400;					{  busy & no answer call forward available  }
	busyNAForwardActive			= $00000800;					{  busy & no answer call forward active  }



TYPE
	TELDNRecordPtr = ^TELDNRecord;
	TELDNRecord = RECORD
		dnRef:					INTEGER;
		dn:						StringPtr;
		dnPartyName:			StringPtr;
		dnSubaddress:			StringPtr;
		hTEL:					TELHandle;
		maxAllocCA:				INTEGER;
		curAllocCA:				INTEGER;
		dnType:					INTEGER;
		featureFlags:			TELDNFeatureFlags;
		numPageIDs:				INTEGER;
		numIntercomIDs:			INTEGER;
		numPickupIDs:			INTEGER;
		forwardFlags:			TELDNForwardFlags;
		iForwardDN:				StringPtr;
		iForwardSubaddress:		StringPtr;
		iForwardPartyName:		StringPtr;
		bForwardDN:				StringPtr;
		bForwardSubaddress:		StringPtr;
		bForwardPartyName:		StringPtr;
		naForwardDN:			StringPtr;
		naForwardSubaddress:	StringPtr;
		naForwardPartyName:		StringPtr;
		naForwardRings:			INTEGER;
		telDNPrivate:			LONGINT;
		refCon:					LONGINT;
		userData:				LONGINT;
		reserved:				LONGINT;
	END;

	TELDNPtr							= ^TELDNRecord;
	TELDNHandle							= ^TELDNPtr;
	TELCAFeatureFlags 			= UInt32;
CONST
	holdSub						= $00000001;					{  hold subscribed   }
	holdAvail					= $00000002;					{  hold available   }
	holdActive					= $00000004;					{  hold active   }
	conferenceSub				= $00000008;					{  conference subscribed  }
	conferenceAvail				= $00000010;					{  conference available  }
	conferenceActive			= $00000020;					{  conference active   }
	conferenceDropSub			= $00000040;					{  conference drop subscribed   }
	conferenceDropAvail			= $00000080;					{  a call to TELDrop will drop this CA only from a conference  }
	conferenceSplitSub			= $00000100;					{  conference split subscribed   }
	conferenceSplitAvail		= $00000200;					{  conference split available for this CA  }
	numToConferenceRequired		= $00000400;					{  the number of CAs to be conferenced is required in TELConfPrep  }
	transferSub					= $00000800;					{  transfer subscribed   }
	transferAvail				= $00001000;					{  transfer available   }
	transferActive				= $00002000;					{  transfer active  }
	caRelated					= $00004000;					{  this CA is the specified in some other CA's relatedCA field }


TYPE
	TELCAOtherFeatures 			= UInt32;
CONST
	callbackSub					= $00000001;					{  call back subscribed  }
	callbackAvail				= $00000002;					{  call back available  }
	callbackActive				= $00000004;					{  call back active   }
	callbackClearSub			= $00000008;					{  call back clearing subscribed  }
	callbackNowSub				= $00000010;					{  call back now subscribed  }
	callbackNowAvail			= $00000020;					{  call back now available   }
	callbackBusy				= $00000040;					{  call back on busy  }
	callbackNoAnswer			= $00000080;					{  call back on no answer  }
	callbackReturnsRef			= $00000100;					{  call back returns a reference  }
	parkSub						= $00000200;					{  call park subscribed  }
	parkAvail					= $00000400;					{  call park available  }
	parkActive					= $00000800;					{  call park active  }
	parkRetrieveSub				= $00001000;					{  call park retrieve subscribed  }
	parkRetrieveWithID			= $00002000;					{  retrieve parked calls with IDs  }
	parkWithReturnedID			= $00004000;					{  park call to a specific remote ID  }
	parkWithGivenID				= $00040000;					{  for switch that requires ID for parking  }
	rejectable					= $00008000;					{  CA is rejectable   }
	deflectable					= $00010000;					{  CA is deflectable   }
	acceptable					= $00020000;					{  CA is acceptable  }
	voiceDetected				= $00080000;					{  voice has been detected on this CA incase of an incoming call }
	callAnswdTSRings			= $00100000;					{  incoimng call was answered on TollSaver rings  }


TYPE
	TELCARecordPtr = ^TELCARecord;
	TELCAPtr							= ^TELCARecord;
	TELCAHandle							= ^TELCAPtr;
	TELCARecord = RECORD
		caRef:					INTEGER;
		hTELDN:					TELDNHandle;
		hTEL:					TELHandle;
		caState:				INTEGER;
		relatedCA:				TELCAHandle;
		connectTime:			LONGINT;								{  can be used by application to keep track of connect time  }
		intExt:					INTEGER;
		callType:				INTEGER;
		dialType:				INTEGER;
		bearerType:				INTEGER;
		rate:					INTEGER;
		rmtDN:					StringPtr;
		rmtPartyName:			StringPtr;
		rmtSubaddress:			StringPtr;
		routeDN:				StringPtr;
		routePartyName:			StringPtr;
		routeSubaddress:		StringPtr;
		priority:				INTEGER;
		conferenceLimit:		INTEGER;
		featureFlags:			TELCAFeatureFlags;
		otherFeatures:			TELCAOtherFeatures;
		telCAPrivate:			LONGINT;
		refCon:					LONGINT;
		userData:				LONGINT;
		reserved:				LONGINT;
	END;

	{	 Constants for HandleType in structure above 	}

CONST
	telHandleType				= 0;							{  feature requires a terminal handle  }
	telDNHandleType				= 1;							{  feature requires a DN handle  }
	telCAHandleType				= 2;							{  feature requires a CA handle  }


TYPE
	FeatureListPtr = ^FeatureList;
	FeatureList = RECORD
		featureID:				INTEGER;
		featureName:			StringPtr;
		handleType:				INTEGER;
		nextFeature:			FeatureListPtr;
	END;

	{	 CA MESSAGE STRUCTURES FOR MSGINFO 	}
	CAGenericMsgRecPtr = ^CAGenericMsgRec;
	CAGenericMsgRec = RECORD
		rmtDN:					StringPtr;
		rmtName:				StringPtr;
		rmtSubaddress:			StringPtr;
		dialType:				INTEGER;
	END;

	CAUserUserInfoMsgRecPtr = ^CAUserUserInfoMsgRec;
	CAUserUserInfoMsgRec = RECORD
		userUserInfo:			StringPtr;
	END;

	CAConfMsgRecPtr = ^CAConfMsgRec;
	CAConfMsgRec = RECORD
		relatedCA:				TELCAHandle;
	END;

	CATransfMsgRecPtr = ^CATransfMsgRec;
	CATransfMsgRec = RECORD
		rmtDN:					StringPtr;
		rmtName:				StringPtr;
		rmtSubaddress:			StringPtr;
		dialType:				INTEGER;
		prepCA:					TELCAHandle;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	TelephoneTermMsgProcPtr = PROCEDURE(hTEL: TELHandle; msg: LONGINT; mtype: INTEGER; value: INTEGER; globals: LONGINT);
{$ELSEC}
	TelephoneTermMsgProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TelephoneDNMsgProcPtr = PROCEDURE(hTELDN: TELDNHandle; Msg: LONGINT; mtype: INTEGER; value: INTEGER; rmtDN: Str255; rmtName: Str255; rmtSubaddress: Str255; globals: LONGINT);
{$ELSEC}
	TelephoneDNMsgProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TelephoneCAMsgProcPtr = PROCEDURE(hTELCA: TELCAHandle; Msg: LONGINT; mtype: INTEGER; value: INTEGER; Msginfo: Ptr; globals: LONGINT);
{$ELSEC}
	TelephoneCAMsgProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TelephoneChooseIdleProcPtr = PROCEDURE;
{$ELSEC}
	TelephoneChooseIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TelephoneTermMsgUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TelephoneTermMsgUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TelephoneDNMsgUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TelephoneDNMsgUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TelephoneCAMsgUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TelephoneCAMsgUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TelephoneChooseIdleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TelephoneChooseIdleUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppTelephoneTermMsgProcInfo = $0000EBC0;
	uppTelephoneDNMsgProcInfo = $003FEBC0;
	uppTelephoneCAMsgProcInfo = $0003EBC0;
	uppTelephoneChooseIdleProcInfo = $00000000;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewTelephoneTermMsgUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewTelephoneTermMsgUPP(userRoutine: TelephoneTermMsgProcPtr): TelephoneTermMsgUPP; { old name was NewTelephoneTermMsgProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTelephoneDNMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTelephoneDNMsgUPP(userRoutine: TelephoneDNMsgProcPtr): TelephoneDNMsgUPP; { old name was NewTelephoneDNMsgProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTelephoneCAMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTelephoneCAMsgUPP(userRoutine: TelephoneCAMsgProcPtr): TelephoneCAMsgUPP; { old name was NewTelephoneCAMsgProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTelephoneChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTelephoneChooseIdleUPP(userRoutine: TelephoneChooseIdleProcPtr): TelephoneChooseIdleUPP; { old name was NewTelephoneChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeTelephoneTermMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTelephoneTermMsgUPP(userUPP: TelephoneTermMsgUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTelephoneDNMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTelephoneDNMsgUPP(userUPP: TelephoneDNMsgUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTelephoneCAMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTelephoneCAMsgUPP(userUPP: TelephoneCAMsgUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTelephoneChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTelephoneChooseIdleUPP(userUPP: TelephoneChooseIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeTelephoneTermMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeTelephoneTermMsgUPP(hTEL: TELHandle; msg: LONGINT; mtype: INTEGER; value: INTEGER; globals: LONGINT; userRoutine: TelephoneTermMsgUPP); { old name was CallTelephoneTermMsgProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTelephoneDNMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeTelephoneDNMsgUPP(hTELDN: TELDNHandle; Msg: LONGINT; mtype: INTEGER; value: INTEGER; rmtDN: Str255; rmtName: Str255; rmtSubaddress: Str255; globals: LONGINT; userRoutine: TelephoneDNMsgUPP); { old name was CallTelephoneDNMsgProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTelephoneCAMsgUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeTelephoneCAMsgUPP(hTELCA: TELCAHandle; Msg: LONGINT; mtype: INTEGER; value: INTEGER; Msginfo: Ptr; globals: LONGINT; userRoutine: TelephoneCAMsgUPP); { old name was CallTelephoneCAMsgProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTelephoneChooseIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeTelephoneChooseIdleUPP(userRoutine: TelephoneChooseIdleUPP); { old name was CallTelephoneChooseIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InitTEL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitTEL: TELErr;

{
 *  TELGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetInfo(hTEL: TELHandle): TELErr;

{
 *  TELOpenTerm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELOpenTerm(hTEL: TELHandle): TELErr;

{
 *  TELResetTerm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELResetTerm(hTEL: TELHandle): TELErr;

{
 *  TELCloseTerm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCloseTerm(hTEL: TELHandle): TELErr;

{
 *  TELTermMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELTermMsgHand(hTEL: TELHandle; eventMask: LONGINT; msgProc: TelephoneTermMsgUPP; globals: LONGINT): TELErr;

{
 *  TELClrTermMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELClrTermMsgHand(hTEL: TELHandle; msgProc: TelephoneTermMsgUPP): TELErr;

{
 *  TELTermEventsSupp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELTermEventsSupp(hTEL: TELHandle; VAR eventMask: LONGINT): TELErr;

{
 *  TELGetProcID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetProcID(VAR name: Str255): INTEGER;

{
 *  TELNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELNew(procID: INTEGER; flags: TELFlags; refCon: LONGINT; userData: LONGINT): TELHandle;

{
 *  TELNewWithResult()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELNewWithResult(procID: INTEGER; flags: TELFlags; refCon: LONGINT; userData: LONGINT; VAR error: TELErr): TELHandle;

{
 *  TELDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDefault(VAR theConfig: Ptr; procID: INTEGER; allocate: BOOLEAN): TELErr;

{
 *  TELValidate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELValidate(hTEL: TELHandle): BOOLEAN;

{
 *  TELGetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetConfig(hTEL: TELHandle): Ptr;

{
 *  TELSetConfig()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELSetConfig(hTEL: TELHandle; thePtr: Ptr): INTEGER;

{
 *  TELChoose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELChoose(VAR hTEL: TELHandle; where: Point; idleProc: TelephoneChooseIdleUPP): TELErr;

{
 *  TELSetupPreflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELSetupPreflight(procID: INTEGER; VAR magicCookie: LONGINT): Handle;

{
 *  TELSetupSetup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELSetupSetup(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogRef; VAR magicCookie: LONGINT);

{
 *  TELSetupFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELSetupFilter(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogRef; VAR theEvent: EventRecord; VAR theItem: INTEGER; VAR magicCookie: LONGINT): BOOLEAN;

{
 *  TELSetupItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELSetupItem(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogRef; VAR theItem: INTEGER; VAR magicCookie: LONGINT);

{
 *  TELSetupCleanup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELSetupCleanup(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogRef; VAR magicCookie: LONGINT);

{
 *  TELSetupXCleanup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELSetupXCleanup(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogRef; OKed: BOOLEAN; VAR magicCookie: LONGINT);

{
 *  TELSetupPostflight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELSetupPostflight(procID: INTEGER);

{
 *  TELDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDispose(hTEL: TELHandle): TELErr;

{
 *  TELCountDNs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCountDNs(hTEL: TELHandle; dnType: INTEGER; physical: BOOLEAN): INTEGER;

{
 *  TELDNLookupByIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNLookupByIndex(hTEL: TELHandle; dnType: INTEGER; physical: BOOLEAN; index: INTEGER; VAR hTELDN: TELDNHandle): TELErr;

{
 *  TELDNLookupByName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNLookupByName(hTEL: TELHandle; DN: Str255; VAR hTELDN: TELDNHandle): TELErr;

{
 *  TELDNSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNSelect(hTELDN: TELDNHandle; select: BOOLEAN): TELErr;

{
 *  TELDNDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNDispose(hTELDN: TELDNHandle): TELErr;

{
 *  TELGetDNInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetDNInfo(hTELDN: TELDNHandle): TELErr;

{
 *  TELGetDNFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetDNFlags(hTELDN: TELDNHandle; VAR dnFeatureFlags: LONGINT; VAR dnForwardFlags: LONGINT): TELErr;

{
 *  TELDNMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNMsgHand(hTELDN: TELDNHandle; allDNs: BOOLEAN; eventMask: LONGINT; msgProc: TelephoneDNMsgUPP; globals: LONGINT): TELErr;

{
 *  TELClrDNMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELClrDNMsgHand(hTELDN: TELDNHandle; msgProc: TelephoneDNMsgUPP): TELErr;

{
 *  TELDNEventsSupp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNEventsSupp(hTELDN: TELDNHandle; VAR eventMask: LONGINT): TELErr;

{
 *  TELCountCAs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCountCAs(hTELDN: TELDNHandle; internalExternal: INTEGER): INTEGER;

{
 *  TELCALookup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCALookup(hTELDN: TELDNHandle; internalExternal: INTEGER; index: INTEGER; VAR hTELCA: TELCAHandle): TELErr;

{
 *  TELCADispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCADispose(hTELCA: TELCAHandle): TELErr;

{
 *  TELGetCAState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetCAState(hTELCA: TELCAHandle; VAR state: INTEGER): TELErr;

{
 *  TELGetCAFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetCAFlags(hTELCA: TELCAHandle; VAR caFeatureFlags: LONGINT; VAR caOtherFeatures: LONGINT): TELErr;

{
 *  TELGetCAInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetCAInfo(hTELCA: TELCAHandle): TELErr;

{
 *  TELCAMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCAMsgHand(hTELDN: TELDNHandle; eventMask: LONGINT; msgProc: TelephoneCAMsgUPP; globals: LONGINT): TELErr;

{
 *  TELClrCAMsgHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELClrCAMsgHand(hTELDN: TELDNHandle; msgProc: TelephoneCAMsgUPP): TELErr;

{
 *  TELCAEventsSupp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCAEventsSupp(hTELDN: TELDNHandle; VAR eventMask: LONGINT): TELErr;

{
 *  TELSetupCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELSetupCall(hTELDN: TELDNHandle; VAR hTELCA: TELCAHandle; destDN: Str255; destName: Str255; destSubaddress: Str255; userUserInfo: Str255; bearerType: INTEGER; rate: INTEGER): TELErr;

{
 *  TELConnect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELConnect(hTELCA: TELCAHandle): TELErr;

{
 *  TELDialDigits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDialDigits(hTELCA: TELCAHandle; digits: Str255): TELErr;

{
 *  TELAcceptCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELAcceptCall(hTELCA: TELCAHandle): TELErr;

{
 *  TELRejectCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELRejectCall(hTELCA: TELCAHandle; reason: INTEGER): TELErr;

{
 *  TELDeflectCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDeflectCall(hTELCA: TELCAHandle; rmtDN: Str255; rmtName: Str255; rmtSubaddress: Str255): TELErr;

{
 *  TELAnswerCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELAnswerCall(hTELCA: TELCAHandle): TELErr;

{
 *  TELDrop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDrop(hTELCA: TELCAHandle; userUserInfo: Str255): TELErr;

{
 *  TELHold()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELHold(hTELCA: TELCAHandle): TELErr;

{
 *  TELRetrieve()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELRetrieve(hTELCA: TELCAHandle): TELErr;

{
 *  TELConferencePrep()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELConferencePrep(hTELCA1: TELCAHandle; hTELCA2: TELCAHandle; numToConference: INTEGER): TELErr;

{
 *  TELConferenceEstablish()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELConferenceEstablish(hTELCA1: TELCAHandle; hTELCA2: TELCAHandle): TELErr;

{
 *  TELConferenceSplit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELConferenceSplit(hTELCA: TELCAHandle): TELErr;

{
 *  TELTransferPrep()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELTransferPrep(hTELCA1: TELCAHandle; hTELCA2: TELCAHandle): TELErr;

{
 *  TELTransferEstablish()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELTransferEstablish(hTELCA1: TELCAHandle; hTELCA2: TELCAHandle): TELErr;

{
 *  TELTransferBlind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELTransferBlind(hTELCA: TELCAHandle; rmtDN: Str255; rmtName: Str255; rmtSubaddress: Str255): TELErr;

{
 *  TELForwardSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELForwardSet(hTELDN: TELDNHandle; forwardDN: Str255; forwardName: Str255; forwardSubaddress: Str255; forwardType: INTEGER; numrings: INTEGER): TELErr;

{
 *  TELForwardClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELForwardClear(hTELDN: TELDNHandle; forwardType: INTEGER): TELErr;

{
 *  TELCallbackSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCallbackSet(hTELCA: TELCAHandle; VAR callbackRef: INTEGER): TELErr;

{
 *  TELCallbackClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCallbackClear(hTEL: TELHandle; callbackRef: INTEGER): TELErr;

{
 *  TELCallbackNow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCallbackNow(hTELCA: TELCAHandle; callbackRef: INTEGER): TELErr;

{
 *  TELDNDSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNDSet(hTELDN: TELDNHandle; dndType: INTEGER): TELErr;

{
 *  TELDNDClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNDClear(hTELDN: TELDNHandle; dndType: INTEGER): TELErr;

{
 *  TELCallPickup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCallPickup(hTELCA: TELCAHandle; pickupDN: Str255; pickupGroupID: INTEGER): TELErr;

{
 *  TELParkCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELParkCall(hTELCA: TELCAHandle; VAR parkRetrieveID: StringPtr; parkID: Str255): TELErr;

{
 *  TELRetrieveParkedCall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELRetrieveParkedCall(hTELCA: TELCAHandle; parkRetrieveID: Str255): TELErr;

{
 *  TELVoiceMailAccess()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELVoiceMailAccess(hTELCA: TELCAHandle): TELErr;

{
 *  TELPaging()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELPaging(hTELCA: TELCAHandle; pageID: INTEGER): TELErr;

{
 *  TELIntercom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELIntercom(hTELCA: TELCAHandle; intercomID: INTEGER): TELErr;

{
 *  TELOtherFeatureList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELOtherFeatureList(hTEL: TELHandle; VAR fList: FeatureListPtr): TELErr;

{
 *  TELOtherFeatureImplement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELOtherFeatureImplement(hTEL: TELHandle; theHandle: Handle; featureID: INTEGER): TELErr;

{
 *  TELToolFunctions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELToolFunctions(hTEL: TELHandle; msgcode: INTEGER; VAR supportsIt: BOOLEAN): TELErr;

{
 *  TELOtherFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELOtherFunction(hTEL: TELHandle; paramblock: Ptr; size: LONGINT): TELErr;

{
 *  TELGetHooksw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetHooksw(hTEL: TELHandle; hookType: INTEGER; VAR offHook: BOOLEAN): TELErr;

{
 *  TELSetHooksw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELSetHooksw(hTEL: TELHandle; hookType: INTEGER; offHook: BOOLEAN): TELErr;

{
 *  TELGetVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetVolume(hTEL: TELHandle; volType: INTEGER; VAR level: INTEGER; VAR volState: INTEGER): TELErr;

{
 *  TELSetVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELSetVolume(hTEL: TELHandle; volType: INTEGER; VAR level: INTEGER; volState: INTEGER): TELErr;

{
 *  TELAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELAlert(hTEL: TELHandle; VAR level: INTEGER; alertPattern: INTEGER): TELErr;

{
 *  TELGetDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetDisplay(hTEL: TELHandle; index: INTEGER; VAR displayMode: INTEGER; VAR text: StringPtr): TELErr;

{
 *  TELSetDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELSetDisplay(hTEL: TELHandle; index: INTEGER; displayMode: INTEGER; text: Str255): TELErr;

{
 *  TELIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELIdle(hTEL: TELHandle);

{
 *  TELActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELActivate(hTEL: TELHandle; activate: BOOLEAN);

{
 *  TELResume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELResume(hTEL: TELHandle; resume: BOOLEAN);

{
 *  TELMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELMenu(hTEL: TELHandle; menuID: INTEGER; item: INTEGER): BOOLEAN;

{
 *  TELEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELEvent(hTEL: TELHandle; {CONST}VAR theEvent: EventRecord);

{
 *  TELGetToolName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TELGetToolName(procID: INTEGER; VAR name: Str255);

{
 *  TELGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetVersion(hTEL: TELHandle): Handle;

{
 *  TELGetTELVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetTELVersion: INTEGER;

{
 *  TELIntlToEnglish()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELIntlToEnglish(hTEL: TELHandle; inputPtr: Ptr; VAR outputPtr: Ptr; language: INTEGER): TELErr;

{
 *  TELEnglishToIntl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELEnglishToIntl(hTEL: TELHandle; inputPtr: Ptr; VAR outputPtr: Ptr; language: INTEGER): TELErr;

{
 *  TELGetDNSoundInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetDNSoundInput(hTELDN: TELDNHandle; VAR deviceName: Str255): TELErr;

{
 *  TELDisposeDNSoundInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDisposeDNSoundInput(hTELDN: TELDNHandle; deviceName: Str255): TELErr;

{
 *  TELGetDNSoundOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetDNSoundOutput(hTELDN: TELDNHandle; VAR SndOut: Component): TELErr;

{
 *  TELDisposeDNSoundOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDisposeDNSoundOutput(hTELDN: TELDNHandle; SndOut: Component): TELErr;

{
 *  TELGetHSSoundInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetHSSoundInput(termHand: TELHandle; VAR deviceName: Str255): TELErr;

{
 *  TELDisposeHSSoundInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDisposeHSSoundInput(termHand: TELHandle; deviceName: Str255): TELErr;

{
 *  TELGetHSSoundOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetHSSoundOutput(termHand: TELHandle; VAR SndOut: Component): TELErr;

{
 *  TELDisposeHSSoundOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDisposeHSSoundOutput(termHand: TELHandle; SndOut: Component): TELErr;

{
 *  TELDNSetAutoAnswer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNSetAutoAnswer(hTELDN: TELDNHandle; AutoAnswerOn: BOOLEAN): TELErr;

{
 *  TELDNTollSaverControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNTollSaverControl(hTELDN: TELDNHandle; QuickAnswer: BOOLEAN): TELErr;

{
 *  TELSetIndHSConnect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELSetIndHSConnect(termHand: TELHandle; Connect: BOOLEAN): TELErr;

{
 *  TELGetIndHSConnect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetIndHSConnect(termHand: TELHandle; VAR Connect: BOOLEAN): TELErr;

{
 *  TELCAVoiceDetect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCAVoiceDetect(hTELCA: TELCAHandle; VoiceDetectOn: BOOLEAN): TELErr;

{
 *  TELCASilenceDetect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELCASilenceDetect(hTELCA: TELCAHandle; DetectOn: BOOLEAN; Period: LONGINT): TELErr;

{
 *  TELGetTelNewErr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetTelNewErr: TELErr;

{
 *  TELDNSetDTMF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNSetDTMF(hTELDN: TELDNHandle; dtmfOn: BOOLEAN): TELErr;

{
 *  TELDNGetDTMF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELDNGetDTMF(hTELDN: TELDNHandle; VAR dtmfOn: BOOLEAN): TELErr;

{
 *  TELHSSetDTMF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELHSSetDTMF(termHand: TELHandle; dtmfOn: BOOLEAN): TELErr;

{
 *  TELHSGetDTMF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELHSGetDTMF(termHand: TELHandle; VAR dtmfOn: BOOLEAN): TELErr;

{
 *  TELGetDNStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetDNStatus(hTELDN: TELDNHandle; VAR inUse: LONGINT): TELErr;

{
 *  TELGetDNProgressDet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELGetDNProgressDet(hTELDN: TELDNHandle; selector: LONGINT; VAR prgDetOn: BOOLEAN): TELErr;

{
 *  TELSetDNProgressDet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION TELSetDNProgressDet(hTELDN: TELDNHandle; selector: LONGINT; prgDetOn: BOOLEAN): TELErr;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TelephonesIncludes}

{$ENDC} {__TELEPHONES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
