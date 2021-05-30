{
 	File:		Telephones.p
 
 	Contains:	Interface to the Telephone Manager
 
 	Version:	
 
 	DRI:		Samir Dharia
 
 	Copyright:	© 1984-1994 by Apple Computer, Inc.
 				All rights reserved.
 
 	Warning:	*** APPLE INTERNAL USE ONLY ***
 				This file may contain unreleased API's
 
 	BuildInfo:	Built by:			Sue Kuo
 				With Interfacer:	1.1d11  
 				From:				Telephones.i
 					Revision:		17
 					Dated:			12/13/94
 					Last change by:	ngk
 					Last comment:	<Really SRD> Add telUnknown and telTerminalHWDisconnected
 
 	Bugs:		Report bugs to Radar component “System Interfaces”, “Latest”
 				List the version information (from above) in the Problem Description.
 
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


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{	Memory.p													}
{		MixedMode.p												}
{	Quickdraw.p													}
{		QuickdrawText.p											}
{	Events.p													}
{		OSUtils.p												}
{	Controls.p													}
{		Collections.p											}
{		Appearance.p											}
{			Files.p												}
{		Menus.p													}
{			TextObjects.p										}
{				Unicode.p										}
{	AppleEvents.p												}
{		Errors.p												}
{		EPPC.p													}
{			AppleTalk.p											}
{			PPCToolbox.p										}
{			Processes.p											}
{		Notification.p											}
{			Kernel.p											}
{				MachineExceptions.p								}
{				Timing.p										}
{	Drag.p														}
{		TextEdit.p												}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}

{$IFC UNDEFINED __CTBUTILITIES__}
{$I CTBUtilities.p}
{$ENDC}
{	StandardFile.p												}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{$IFC UNDEFINED classTEL }

CONST
{ telephone tool file type }
	classTEL					= 'vbnd';

{$ENDC}

CONST
{	curTELVersion = 4,						not supported. Use TELGetTELVersion to get the
											current version of the Telephone Manager }
	telChooseDisaster			= chooseDisaster;
	telChooseFailed				= chooseFailed;
	telChooseAborted			= chooseAborted;
	telChooseOKMinor			= chooseOKMinor;
	telChooseOKMajor			= chooseOKMajor;
	telChooseCancel				= chooseCancel;
{	the chooseXXX symbols are defined in CTBUtilities.(pah) }
	telChooseOKTermChanged		= 4;

{ PHYSICAL TERMINAL CONSTANTS 

* INDEPENDENT HANDSET CONSTANTS }
	telIndHSOnHook				= 0;							{ independent handset on hook }
	telIndHSOffHook				= 1;							{ independent handset off hook }
	telIndHSDisconnected		= 0;							{ handset disconnected from the line }
	telIndHSConnected			= 1;							{ handset connected to the line }
{ HOOK STATE CONSTANTS }
	telHandset					= 1;							{ handset hookswitch }
	telSpeakerphone				= 2;							{ speakerphone 'on' switch }
	telDeviceOffHook			= 1;							{ device off hook }
	telDeviceOnHook				= 0;							{ device on hook }
{ VOLUME CONTROL CONSTANTS }
	telHandsetSpeakerVol		= 1;							{ volume of the handset speaker }
	telHandsetMicVol			= 2;							{ sensitivity of the handset mic }
	telSpeakerphoneVol			= 3;							{ speakerphone volume }
	telSpeakerphoneMicVol		= 4;							{ sensitivity of the spkrphone mic }
	telRingerVol				= 5;							{ volume of the ringer }
	telBuiltinSPVol				= 6;							{ volume of the built-in speakerphone }
	telBuiltinSPMicVol			= 7;							{ sensitivity of the built-in speakerphone mic }
	telVolSame					= 0;							{ leaves the volume at previous level }
	telVolMin					= 1;							{ turns volume down to minimum level, but not off }
	telVolMax					= 100;							{ highest level allowed by the Telephone Manager }
	telVolStateSame				= 0;							{ leaves device in same state }
	telVolStateOff				= 1;							{ turns the device off , 
								 * but doesn't change the volume setting. 
								 * Use for mute functions. }
	telVolStateOn				= 2;							{ turns the device on.  Volume setting is 
								 * the same as previously set.}
{ DISPLAY CONSTANTS }
	telNormalDisplayMode		= 1;							{ normal display mode }
	telInspectMode				= 2;							{ inspect display mode }
	telMiscMode					= 3;							{ miscellaneous display mode }
	telRetrieveMode				= 4;							{ message retrieval mode }
	telDirectoryQueryMode		= 5;							{ electronic directory mode }
	telEntireDisplay			= 0;							{ entire Display }
{ KEY PRESS CONSTANTS }
	telHangupKey				= 1;							{ drop, or release, key pressed }
	telHoldKey					= 2;							{ hold key pressed }
	telConferenceKey			= 3;							{ conference key pressed }
	telTransferKey				= 4;							{ transfer key pressed }
	telForwardKey				= 5;							{ call forward key pressed }
	telCallbackKey				= 6;							{ call back key pressed }
	telDNDKey					= 7;							{ do not disturb key pressed }
	telCallPickupKey			= 8;							{ call Pickup key pressed }
	telCallParkKey				= 9;							{ call Park key pressed }
	telCallDeflectKey			= 10;							{ call Deflect key pressed }
	telVoiceMailAccessKey		= 11;							{ voice Mail Access key pressed }
	telCallRejectKey			= 12;							{ call Reject key pressed }
	telOtherKey					= 16;							{ other key pressed }
	telKeyPadPress				= 1;							{ key pressed on 12 digit keypad}
	telFeatureKeyPress			= 2;							{ feature Key Pressed }
	telTerminalEnabled			= 0;
	telTerminalDisabled			= 1;
	telUnknown					= 0;							{ unknown error }
	telTerminalHWDisconnected	= 1;							{ terminal hardware is disconnected }
	telDeviceDriverClosed		= 2;							{ device driver is closed }
{ ALERT PATTERN }
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
{ DN TYPES }
	telAllDNs					= 0;							{ counts all types of DNs }
	telInternalDNs				= 1;							{ connected to PBX or other non-public switch }
	telInternalDNsOnly			= 2;							{ connected to PBX or other non-public switch 
								 * and able to place internal calls only }
	telExternalDNs				= 3;							{ connected to public network }
	telDNTypeUnknown			= 4;							{ DN type unknown }
{ DN USAGE }
	telDNNotUsed				= 0;							{ DN is not used - onhook }
	telDNPOTSCall				= 1;							{ DN used for POTs call }
	telDNFaxCall				= 2;							{ DN used for fax call }
	telDNDataCall				= 3;							{ DN used for data call }
	telDNAlerting				= 4;							{ Incoming call at DN }
	telDNUnknownState			= 5;							{ DN is in unknown state }
{ CALL FORWARDING TYPES }
	telForwardImmediate			= 1;							{ immediately forward calls }
	telForwardBusy				= 2;							{ forward on Busy }
	telForwardNoAnswer			= 3;							{ forward on No answer }
	telForwardBusyNA			= 4;							{ forwarding for busy and no answer}
	telForwardTypeUnknown		= 5;							{ type of forwarding is unknown }
{ CALL FORWARDING MESSAGES }
	telForwardCleared			= 0;							{ forwarding has been cleared }
	telForwardEst				= 1;							{ forwarding has been established}
	telForwardFailed			= 2;							{ attempt to setup forwarding has failed}
{ DO NOT DISTURB TYPES }
	telDNDIntExt				= 0;							{ do not disturb for all internal and external calls}
	telDNDExternal				= 1;							{ do not disturb for external calls only }
	telDNDInternal				= 2;							{ do not disturb for internal calls only }
	telDNDNonIntercom			= 3;							{ do not disturb for all calls except intercom }
{ DO NOT DISTURB MESSAGES }
	telDNDCleared				= 0;							{ do not disturb has been cleared }
	telDNDEst					= 1;							{ do not disturb has been established }
	telDNDFailed				= 2;							{ attempt to setup do not disturb has failed }
{ VOICE MAIL MESSAGES }
	telAllVoiceMessagesRead		= 0;							{ all messages have been read, none are  waiting 
								 * to be read }
	telNewVoiceMessage			= 1;							{ a new message has arrived or messages are waiting 
								 * for this DN }
{ DNSELECT MESSAGE }
	telDNDeselected				= 0;							{ DN has been deselected }
	telDNSelected				= 1;							{ DN has been selected }
{ CALL ORIGINATORS }
	telInternalCall				= 0;							{ return nth internal CA }
	telExternalCall				= 1;							{ return nth external CA }
	telUnknownCallOrigin		= 2;							{ unknown call type }
	telAllCallOrigins			= 2;							{ return nth CA internal or external }
{ CALL TYPES }
	telVoiceMailAccessOut		= 0+(-7);
	telPageOut					= 0+(-6);
	telIntercomOut				= 0+(-5);
	telCallbackOut				= 0+(-4);
	telPickup					= 0+(-3);
	telParkRetrieve				= 0+(-2);
	telNormalOut				= 0+(-1);
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
{ DIAL TYPES }
	telDNDialable				= 0;							{ this DN could be dialed via TELSetupCall }
	telDNNorthAmerican			= 1;							{ rmtDN is standard North America 10 digit number }
	telDNInternational			= 2;							{ rmtDN is an international number }
	telDNAlmostDialable			= 3;							{ rmtDN is almost dialable, }
{ missing prefix such as 9 or 1 }
	telDNUnknown				= 15;							{ unknown whether DN is dialable }
{ CALL PROGRESS MESSAGES }
	telCAPDialTone				= 1;							{ dial tone }
	telCAPRinging				= 2;							{ destination CA is alerting }
	telCAPDialing				= 3;							{ dialing the other end }
	telCAPReorder				= 4;							{ reorder }
	telCAPBusy					= 5;							{ busy }
	telCAPRouted				= 6;							{ call routed; rmtDN will hold the routing directory }
{ number routeDN and routePartyName have been updated }
	telCAPRoutedOff				= 7;							{ call routed off-network; no further progress will }
{ be available }
	telCAPTimeout				= 8;							{ call timed out }
	telCAPUpdate				= 9;							{ name and rmtDN information has been updated }
	telCAPPrompt				= 10;							{ the network is prompting for more information }
	telCAPWaiting				= 11;							{ call is proceeding, but there is no response yet }
{ from the destination }
	telCAPCPC					= 12;							{ telephone tool detected CPC signal }
	telCAPNoDialTone			= 13;							{ dial tone not detected }
	telCAPUnknown				= 15;							{ call progress state unknown }
	telCAPDialDisabled			= 16;							{ Blacklisting: Dial Disabled }
	telCAPBlacklistedNumber		= 17;							{ Blacklisting: Blacklisted Number }
	telCAPForbiddenNumber		= 18;							{ Blacklisting: Forbidden Number }
	telCAPModemGuardTime		= 19;							{ Modem Guard Timein force, unable to dial }
	telCAPLCDetected			= 20;							{ trying to dial a number while the handset is offhook }
	telCAPLostLC				= 21;							{ trying manual dial or answer while handset not off hook 
                        	  	   * or also lost line current during dialing. }
{ OUTGOING CALL MESSAGES }
	telPhysical					= 0;							{ user lifted handset and initiated call }
	telProgrammatic				= 1;							{ programmatic initiation of outgoing call }
{ DISCONNECT MESSAGES }
	telLocalDisconnect			= 0;							{ local party, this user, responsible for disconnect }
	telRemoteDisconnect			= 1;							{ remote party responsible for disconnect }
{ DISCONNECT TYPES }
	telCADNormal				= 1;							{ normal disconnect }
	telCADBusy					= 2;							{ remote user busy }
	telCADNoResponse			= 3;							{ remote not responding }
	telCADRejected				= 4;							{ call rejected }
	telCADNumberChanged			= 5;							{ number changed }
	telCADInvalidDest			= 6;							{ invalid destination address }
	telCADFacilityRejected		= 7;							{ requested facility rejected }
	telCADUnobtainableDest		= 9;							{ destination not obtainable }
	telCADCongested				= 10;							{ network congestion }
	telCADIncompatibleDest		= 11;							{ incompatible destination }
	telCADTimeout				= 12;							{ call timed out }
	telCADUnknown				= 15;							{ reason unknown }
{ CONFERENCE MESSAGES }
	telConferencePrepFailed		= 0;							{ conference could not be prepared }
	telConferencePending		= 1;							{ conference prepared successfully }
	telConferenceEstFailed		= 2;							{ conference could not be established }
	telConferenceEst			= 3;							{ conference established }
{ TRANSFER MESSAGES }
	telTransferPrepFailed		= 0;							{ transfer could not be prepared }
	telTransferPending			= 1;							{ transfer prepared successfully }
	telTransferEst				= 2;							{ consult or blind xfer successful }
	telTransferFailed			= 3;							{ consult or blind xfer failed }
	telTransferred				= 4;							{ message to originator of CA specifying 
									 * that call was transferred to rmtDN }
{ HOLD MESSAGES }
	telHoldCleared				= 0;
	telHoldEst					= 1;
	telHoldFailed				= 2;
{ RECEIVE DIGIT MESSAGES }
	telDigitAudible				= 0;
	telDigitNotAudible			= 1;
{ CALL PARK MESSAGES }
	telCallParkEst				= 1;							{ call has been successfully parked }
	telCallParkRetrieveEst		= 2;							{ parked Call has been successfully retrieved }
	telCallParkFailed			= 3;							{ attempt to setup call park has failed }
	telCallParkRetrieveFailed	= 4;							{ attempt to retrieve parked call failed }
	telCallParkRecall			= 5;							{ call park has been recalled }
{ CALL BACK MESSAGES }
	telCallbackCleared			= 0;							{ call back has been cleared }
	telCallbackEst				= 1;							{ call back has been established }
	telCallbackNowAvail			= 2;							{ call can be called back with TELCallBackNow }
{ if CA is zero, else call IS calling back on CA }
	telCallbackFailed			= 3;							{ attempt to setup callback has failed }
	telCallbackDesired			= 4;							{ a user has called this terminal, received no 
									 * answer and desires this terminal to call it 
									 * back }
	telCallbackDesiredCleared	= 5;							{ call back for no answer no longer desired }
	telCalledback				= 6;							{ callback has occurred successfully }
{ CALL REJECT MESSAGES }
	telCallRejectFailed			= 0;							{ attempt to reject call has failed }
	telCallRejectEst			= 1;							{ call successfully rejected }
	telCallRejected				= 2;							{ message to originator that call was rejected }
{ CALL DEFLECT MESSAGES }
	telCallDeflectFailed		= 0;							{ attempt to deflect call has failed }
	telCallDeflectEst			= 1;							{ call successfully deflected }
	telCallDeflectRecall		= 2;							{ deflected call has been recalled }
	telCallDeflected			= 3;							{ message to originator that call was deflected 
									 * to rmtDN }
	telAutoDeflectImmediate		= 4;							{ a call was automatically deflected from this 
									 * terminal as a result of immediate call 
									 * forwarding }
	telAutoDeflectBusy			= 5;							{ a call was automatically deflected from this 
									 * terminal as a result of call forwarding on busy }
	telAutoDeflectNoAnswer		= 6;							{ a call was automatically deflected from this 
									 * terminal as a result of call forwarding on 
									 * no answer }
{ CONFERENCE SPLIT MESSAGES }
	telConferenceSplitFailed	= 0;							{ CA could not be split }
	telConferenceSplitEst		= 1;							{ CA split successfully }
{ CONFERENCE DROP MESSAGES }
	telConferenceDropFailed		= 0;							{ CA could not be dropped }
	telConferenceDropped		= 1;							{ CA dropped successfully }
{ CALL PICKUP MESSAGES }
	telCallPickupEst			= 0;							{ call pickup was successful }
	telCallPickupFailed			= 1;							{ call pickup failed }
	telCallPickedUp				= 2;							{ message to originator that call was picked 
									 * up at a different DN }
{ PAGING MESSAGES }
	telPageEst					= 0;							{ paging was successful }
	telPageComplete				= 1;							{ paging activity completed }
	telPageFailed				= 2;							{ paging failed }
{ INTERCOM MESSAGES }
	telIntercomEst				= 0;							{ intercom was successful }
	telIntercomComplete			= 1;							{ intercom activity completed }
	telIntercomFailed			= 2;							{ intercom failed }
{ MODEM TONE MESSAGES }
	telModemToneDetected		= 0;							{ modem tone was detected }
	telModemToneCleared			= 1;							{ modem tone went away }
{ FAX TONE MESSAGES }
	telFaxToneDetected			= 0;							{ fax tone was detected }
	telFaxToneCleared			= 1;							{ fax tone went away }
{ IN USE MESSAGES }
	telInUsePrivate				= 0;							{ MADN is in use and can't be accessed }
	telInUseCanAccess			= 1;							{ MADN is in use, and others can access it 
									 * and join in }
	telInUseCanMakePrivate		= 2;							{ MADN is in use, but available for any one
									 * person to access }
	telInUseCleared				= 3;							{ MADN is no longer in use }
{ CALL APPEARANCE STATES }
	telCAIdleState				= 0;							{ a call doesn't exist at this time }
	telCAInUseState				= 1;							{ the call is active but at another terminal }
	telCAOfferState				= 2;							{ a call is being offered to the terminal }
	telCAQueuedState			= 3;							{ a call is being queued at this terminal }
	telCAAlertingState			= 4;							{ a call is alerting at the terminal }
	telCADialToneState			= 5;							{ initiated outgoing call has dialtone }
	telCADialingState			= 6;							{ initiated outgoing call is dialing }
	telCAWaitingState			= 7;							{ initiated outgoing call is waiting for
									 * response from destination }
	telCARingingState			= 8;							{ the outgoing call is ringing. }
	telCABusyState				= 9;							{ destination is busy or can't be reached }
	telCAHeldState				= 10;							{ call has been put on hold by this terminal }
	telCAConferencedState		= 11;							{ this CA is part of a conference now }
	telCAActiveState			= 12;							{ the call is active and parties are free 
									 * to exchange data }
	telCAReorderState			= 13;							{ CA is in a reorder state }
	telCAConferencedHeldState	= 14;							{ CA is a conference call in a held state }
	telCAUnknownState			= 15;							{ the call state is unknown }
{ TERMINAL MESSAGE EVENTMASKS }
	telTermHookMsg				= $00000001;					{ the hookswitch state has changed }
	telTermKeyMsg				= $00000002;					{ a phone pad key has been depressed }
	telTermVolMsg				= $00000004;					{ volume setting has changed }
	telTermDisplayMsg			= $00000008;					{ display has changed }
	telTermEnableMsg			= $00000010;					{ terminal has become enabled }
	telTermOpenMsg				= $00000020;					{ terminal has been opened }
	telTermCloseMsg				= $00000040;					{ terminal is shutting down }
	telTermResetMsg				= $00000080;					{ terminal has been reset }
	telTermErrorMsg				= $00000100;					{ hard equipment error }
	telTermIndHSStateChgMsg		= $00000200;					{ change in handset state from inacive to }
{ active or vice versa }
	telTermIndHSConnectMsg		= $00000400;					{ independent handset connection has been changed }
	telTermKeyImmMsg			= $00000800;					{ immidiate arrival of phone pad key }
	telTermVolStateMsg			= $00001000;					{ volume state has changed }
	telTermOtherMsg				= $80000000;					{ vendor defined error }
	telAllTermMsgs				= $00001fff;					{ mask to all non tool specific terminal events }
{ DN MESSAGE EVENTMASK CONSTANTS }
	telDNForwardMsg				= $00000001;					{ forward feature activity }
	telDNDNDMsg					= $00000002;					{ do not disturb feature activity }
	telDNVoiceMailMsg			= $00000004;					{ message has arrived for this DN }
	telDNSelectedMsg			= $00000008;					{ DN has been selected or deselected }
	telDNOtherMsg				= $80000000;					{ a custom message for use by tools }
	telAllDNMsgs				= $0000000f;					{ mask to all non tool specific dn events }
{ CA MESSAGE EVENTMASK CONSTANTS }
	telCAAlertingMsg			= $00000001;					{ CA is alerting  }
	telCAOfferMsg				= $00000002;					{ CA is being offered a call }
	telCAProgressMsg			= $00000004;					{ call progress info for this CA }
	telCAOutgoingMsg			= $00000008;					{ CA is initiating an outgoing call }
	telCADisconnectMsg			= $00000010;					{ CA disconnected (dropped or rmt disc }
	telCAActiveMsg				= $00000020;					{ CA is active and voice/data is free 
											 * to flow end to end }
	telCAConferenceMsg			= $00000040;					{ conference activity on CA }
	telCATransferMsg			= $00000080;					{ transfer feature activity }
	telCAHoldMsg				= $00000100;					{ hold feature activity }
	telCADigitsMsg				= $00000200;					{ remote signaling digits arrived }
	telCACallParkMsg			= $00000400;					{ CA call park feature activity }
	telCACallbackMsg			= $00000800;					{ CA call back feature activity  }
	telCARejectMsg				= $00001000;					{ CA is rejected }
	telCADeflectMsg				= $00002000;					{ CA is deflected }
	telCAForwardMsg				= $00004000;					{ CA is forwarded to this DN  }
	telCAConferenceSplitMsg		= $00008000;					{ conference split activity  }
	telCAConferenceDropMsg		= $00010000;					{ conference drop activity  }
	telCAQueuedMsg				= $00020000;					{ CA has been queued  }
	telCAInUseMsg				= $00040000;					{ CA is in use  }
	telCACallPickupMsg			= $00080000;					{ CA pickup activity }
	telCAPagingMsg				= $00100000;					{ CA paging activity }
	telCAIntercomMsg			= $00200000;					{ CA intercom activity }
	telCAModemToneMsg			= $00400000;					{ modem tones detected }
	telCAFaxToneMsg				= $00800000;					{ fax tones detected }
	telCAIdleMsg				= $01000000;					{ CA is in idle state }
	telCASuccessiveAlertMsg		= $02000000;					{ phone is alerting, one per ring }
	telCAUserUserInfoMsg		= $04000000;					{ user to user information has arrrived 
											 * for this CA }
	telCAHandOffMsg				= $08000000;					{ CA is ready for hand-off }
	telCAVoiceDetectedMsg		= $10000000;					{ voice Detect related event }
	telCASilenceDetectedMsg		= $20000000;					{ silence Detect related event }
	telCADigitsImmMsg			= $40000000;					{ immidiate arrival of remote signaling digits }
	telCAOtherMsg				= $80000000;					{ tool specific CA message }
	telAllCAMsgs				= $7fffffff;					{ mask to all non tool specific CA events }

	
TYPE
	TELErr = OSErr;

	TELFlags = LONGINT;


CONST
	telNoMenus					= 1 * (2**(16));				{ tells tool not to display any custom menus }
	telQuiet					= 1 * (2**(17));				{ tells tool not to display any dialog boxes or alerts }
	telConfigChanged			= 1 * (2**(18));				{ notifies application that the config has changed }

	
TYPE
	TELFeatureFlags = LONGINT;


CONST
	pcmAvail					= 1 * (2**(0));					{ true if PCM voice data accessible }
	hasHandset					= 1 * (2**(1));					{ true if a phone handset is attached  }
	hasSpeakerphone				= 1 * (2**(2));					{ true if a 2 way speakerphone is attached }
	canOnHookDial				= 1 * (2**(3));					{ can on-hook dial }
	hasRinger					= 1 * (2**(4));					{ terminal has its own ringer }
	canSetDisplay				= 1 * (2**(5));					{ application can write to the display }
	hasKeypad					= 1 * (2**(6));					{ attached phone has standard 12 key pad }
	hasVideo					= 1 * (2**(7));					{ terminal has a videophone }
	hasOther					= 1 * (2**(8));					{ reserved for future use }
	crossDNConference			= 1 * (2**(9));					{ can perform cross-DN conferences }
	hasSubaddress				= 1 * (2**(10));				{ attached network supports subaddressing }
	hasUserUserInfo				= 1 * (2**(11));				{ network supports user-to-user info }
	hasHandsetSoundStreams		= 1 * (2**(12));				{ sound streams are supported on the handset }
	hasIndHandset				= 1 * (2**(13));				{ handset can be accessed independently of the phone line }
	hasBuiltinSpeakerphone		= 1 * (2**(14));				{ speaker and microphone of the Mac can be used }


TYPE
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

	TELTermPtr = ^TELTermRecord;

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

	TELPtr = ^TELRecord;
	TELHandle = ^TELPtr;

	TELDNFeatureFlags = LONGINT;


CONST
	dndSub						= 1 * (2**(0));					{ do not disturb subscribed }
	dndAvail					= 1 * (2**(1));					{ do not disturb available }
	dndActive					= 1 * (2**(2));					{ do not disturb active }
	voiceMailAccessSub			= 1 * (2**(3));					{ message waiting subscribed }
	voiceMailAccessAvail		= 1 * (2**(4));					{ message waiting available }
	voiceMailAccessActive		= 1 * (2**(5));					{ message waiting active }
	pagingSub					= 1 * (2**(6));					{ paging is subscribed }
	pagingAvail					= 1 * (2**(7));					{ paging is available }
	pagingActive				= 1 * (2**(8));					{ paging is active }
	intercomSub					= 1 * (2**(9));					{ intercom is subscribed }
	intercomAvail				= 1 * (2**(10));				{ intercom is available }
	intercomActive				= 1 * (2**(11));				{ intercom is active }
	dnSelectSub					= 1 * (2**(12));				{ DN select is subscribed }
	dnSelectAvail				= 1 * (2**(13));				{ DN select is available }
	dnSelectActive				= 1 * (2**(14));				{ DN is selected }
	callPickupSub				= 1 * (2**(15));				{ call pickup is subscribed }
	callPickupAvail				= 1 * (2**(16));				{ call pickup is available }
	dnInUse						= 1 * (2**(17));				{ a CA is allocated for this DN }
	logicalDN					= 1 * (2**(18));				{ this DN is not on this terminal }
	dnAccessible				= 1 * (2**(19));				{ commands can be sent to this DN }
	canInitiate					= 1 * (2**(20));				{ an outgoing CA can be initiated }
	voiceMessageWaiting			= 1 * (2**(21));				{ voice mail waiting for this dn }
	hasDNSoundStreams			= 1 * (2**(22));				{ sound streams are supported on this DN }
	autoAnswerAvail				= 1 * (2**(23));				{ AutoAnswer is set for this DN }
	autoAnswerActive			= 1 * (2**(24));				{ AutoAnswer is currently applied to CA on this DN }
	tollSaverAvail				= 1 * (2**(25));				{ tollSaver is set for this DN }
	tollSaverActive				= 1 * (2**(26));				{ tollSaver is currently applied to CA on this DN }

	
TYPE
	TELDNForwardFlags = LONGINT;


CONST
	immediateForwardSub			= 1 * (2**(0));					{ immediate call forward subscribed }
	immediateForwardAvail		= 1 * (2**(1));					{ immediate call forward available }
	immediateForwardActive		= 1 * (2**(2));					{ immediate call forward active }
	busyForwardSub				= 1 * (2**(3));					{ forward on busy subscribed }
	busyForwardAvail			= 1 * (2**(4));					{ forward on busy available }
	busyForwardActive			= 1 * (2**(5));					{ forward on busy active }
	noAnswerForwardSub			= 1 * (2**(6));					{ no answer call forward subscribed }
	noAnswerForwardAvail		= 1 * (2**(7));					{ no answer call forward available }
	noAnswerForwardActive		= 1 * (2**(8));					{ no answer call forward active }
	busyNAForwardSub			= 1 * (2**(9));					{ busy & no answer call forward subscribed }
	busyNAForwardAvail			= 1 * (2**(10));				{ busy & no answer call forward available }
	busyNAForwardActive			= 1 * (2**(11));				{ busy & no answer call forward active }


TYPE
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

	TELDNPtr = ^TELDNRecord;
	TELDNHandle = ^TELDNPtr;

	TELCAFeatureFlags = LONGINT;


CONST
	holdSub						= 1 * (2**(0));					{ hold subscribed  }
	holdAvail					= 1 * (2**(1));					{ hold available  }
	holdActive					= 1 * (2**(2));					{ hold active  }
	conferenceSub				= 1 * (2**(3));					{ conference subscribed }
	conferenceAvail				= 1 * (2**(4));					{ conference available }
	conferenceActive			= 1 * (2**(5));					{ conference active  }
	conferenceDropSub			= 1 * (2**(6));					{ conference drop subscribed  }
	conferenceDropAvail			= 1 * (2**(7));					{ a call to TELDrop will drop this 
										 * CA only from a conference }
	conferenceSplitSub			= 1 * (2**(8));					{ conference split subscribed  }
	conferenceSplitAvail		= 1 * (2**(9));					{ conference split available for this CA }
	numToConferenceRequired		= 1 * (2**(10));				{ the number of CAs to be conferenced is 
										 * required in TELConfPrep  }
	transferSub					= 1 * (2**(11));				{ transfer subscribed  }
	transferAvail				= 1 * (2**(12));				{ transfer available  }
	transferActive				= 1 * (2**(13));				{ transfer active }
	caRelated					= 1 * (2**(14));				{ this CA is the specified in some 
										 * other CA's relatedCA field  }

	
TYPE
	TELCAOtherFeatures = LONGINT;


CONST
	callbackSub					= 1 * (2**(0));					{ call back subscribed }
	callbackAvail				= 1 * (2**(1));					{ call back available }
	callbackActive				= 1 * (2**(2));					{ call back active  }
	callbackClearSub			= 1 * (2**(3));					{ call back clearing subscribed }
	callbackNowSub				= 1 * (2**(4));					{ call back now subscribed }
	callbackNowAvail			= 1 * (2**(5));					{ call back now available  }
	callbackBusy				= 1 * (2**(6));					{ call back on busy }
	callbackNoAnswer			= 1 * (2**(7));					{ call back on no answer }
	callbackReturnsRef			= 1 * (2**(8));					{ call back returns a reference }
	parkSub						= 1 * (2**(9));					{ call park subscribed }
	parkAvail					= 1 * (2**(10));				{ call park available }
	parkActive					= 1 * (2**(11));				{ call park active }
	parkRetrieveSub				= 1 * (2**(12));				{ call park retrieve subscribed }
	parkRetrieveWithID			= 1 * (2**(13));				{ retrieve parked calls with IDs }
	parkWithReturnedID			= 1 * (2**(14));				{ RESERVED }
	parkWithGivenID				= 1 * (2**(18));				{ for switch that requires ID for parking }
	rejectable					= 1 * (2**(15));				{ CA is rejectable  }
	deflectable					= 1 * (2**(16));				{ CA is deflectable  }
	acceptable					= 1 * (2**(17));				{ CA is acceptable }
	voiceDetected				= 1 * (2**(19));				{ voice has been detected on this CA incase of 
												an incoming call }
	callAnswdTSRings			= 1 * (2**(20));				{ incoimng call was answered on TollSaver rings }
	progressHasDuration			= 1 * (2**(21));				{ If set then telCAProgress messages sent to the CA message handler
	                                       carry the duration in milliseconds in the mType parameter.  If the
										   mType is zero that duration is unknown. }

	
TYPE
	TELCAPtr = ^TELCARecord;
	TELCAHandle = ^TELCAPtr;

	TELCARecord = RECORD
		caRef:					INTEGER;
		hTELDN:					TELDNHandle;
		hTEL:					TELHandle;
		caState:				INTEGER;
		relatedCA:				TELCAHandle;
		connectTime:			LONGINT;								{ can be used by application to keep track of connect time }
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

{ Constants for HandleType in structure above }

CONST
	telHandleType				= 0;							{ feature requires a terminal handle }
	telDNHandleType				= 1;							{ feature requires a DN handle }
	telCAHandleType				= 2;							{ feature requires a CA handle }


TYPE
	FeatureList = RECORD
		featureID:				INTEGER;
		featureName:			StringPtr;
		handleType:				INTEGER;
		nextFeature:			^FeatureList;
	END;

	FeatureListPtr = ^FeatureList;

{ CA MESSAGE STRUCTURES FOR MSGINFO }
	CAGenericMsgRec = RECORD
		rmtDN:					StringPtr;
		rmtName:				StringPtr;
		rmtSubaddress:			StringPtr;
		dialType:				INTEGER;
	END;

	CAUserUserInfoMsgRec = RECORD
		userUserInfo:			StringPtr;
	END;

	CAConfMsgRec = RECORD
		relatedCA:				TELCAHandle;
	END;

	CATransfMsgRec = RECORD
		rmtDN:					StringPtr;
		rmtName:				StringPtr;
		rmtSubaddress:			StringPtr;
		dialType:				INTEGER;
		prepCA:					TELCAHandle;
	END;

	TelephoneTermMsgProcPtr = ProcPtr;  { PROCEDURE TelephoneTermMsg(hTEL: TELHandle; msg: LONGINT; mtype: INTEGER; value: INTEGER; globals: LONGINT); }
	TelephoneDNMsgProcPtr = ProcPtr;  { PROCEDURE TelephoneDNMsg(hTELDN: TELDNHandle; Msg: LONGINT; mtype: INTEGER; value: INTEGER; rmtDN: ConstStr255Param; rmtName: ConstStr255Param; rmtSubaddress: ConstStr255Param; globals: LONGINT); }
	TelephoneCAMsgProcPtr = ProcPtr;  { PROCEDURE TelephoneCAMsg(hTELCA: TELCAHandle; Msg: LONGINT; mtype: INTEGER; value: INTEGER; Msginfo: Ptr; globals: LONGINT); }
	TelephoneChooseIdleProcPtr = ProcPtr;  { PROCEDURE TelephoneChooseIdle; }
	TelephoneTermMsgUPP = UniversalProcPtr;
	TelephoneDNMsgUPP = UniversalProcPtr;
	TelephoneCAMsgUPP = UniversalProcPtr;
	TelephoneChooseIdleUPP = UniversalProcPtr;

CONST
	uppTelephoneTermMsgProcInfo = $0000EBC0; { PROCEDURE (4 byte param, 4 byte param, 2 byte param, 2 byte param, 4 byte param); }
	uppTelephoneDNMsgProcInfo = $003FEBC0; { PROCEDURE (4 byte param, 4 byte param, 2 byte param, 2 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param); }
	uppTelephoneCAMsgProcInfo = $0003EBC0; { PROCEDURE (4 byte param, 4 byte param, 2 byte param, 2 byte param, 4 byte param, 4 byte param); }
	uppTelephoneChooseIdleProcInfo = $00000000; { PROCEDURE ; }

FUNCTION NewTelephoneTermMsgProc(userRoutine: TelephoneTermMsgProcPtr): TelephoneTermMsgUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTelephoneDNMsgProc(userRoutine: TelephoneDNMsgProcPtr): TelephoneDNMsgUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTelephoneCAMsgProc(userRoutine: TelephoneCAMsgProcPtr): TelephoneCAMsgUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTelephoneChooseIdleProc(userRoutine: TelephoneChooseIdleProcPtr): TelephoneChooseIdleUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallTelephoneTermMsgProc(hTEL: TELHandle; msg: LONGINT; mtype: INTEGER; value: INTEGER; globals: LONGINT; userRoutine: TelephoneTermMsgUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTelephoneDNMsgProc(hTELDN: TELDNHandle; Msg: LONGINT; mtype: INTEGER; value: INTEGER; rmtDN: ConstStr255Param; rmtName: ConstStr255Param; rmtSubaddress: ConstStr255Param; globals: LONGINT; userRoutine: TelephoneDNMsgUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTelephoneCAMsgProc(hTELCA: TELCAHandle; Msg: LONGINT; mtype: INTEGER; value: INTEGER; Msginfo: Ptr; globals: LONGINT; userRoutine: TelephoneCAMsgUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTelephoneChooseIdleProc(userRoutine: TelephoneChooseIdleUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InitTEL: TELErr;
FUNCTION TELGetInfo(hTEL: TELHandle): TELErr;
FUNCTION TELOpenTerm(hTEL: TELHandle): TELErr;
FUNCTION TELResetTerm(hTEL: TELHandle): TELErr;
FUNCTION TELCloseTerm(hTEL: TELHandle): TELErr;
FUNCTION TELTermMsgHand(hTEL: TELHandle; eventMask: LONGINT; msgProc: TelephoneTermMsgUPP; globals: LONGINT): TELErr;
FUNCTION TELClrTermMsgHand(hTEL: TELHandle; msgProc: TelephoneTermMsgUPP): TELErr;
FUNCTION TELTermEventsSupp(hTEL: TELHandle; VAR eventMask: LONGINT): TELErr;
FUNCTION TELGetProcID(VAR name: Str255): INTEGER;
FUNCTION TELNew(procID: INTEGER; flags: TELFlags; refCon: LONGINT; userData: LONGINT): TELHandle;
FUNCTION TELNewWithResult(procID: INTEGER; flags: TELFlags; refCon: LONGINT; userData: LONGINT; VAR error: TELErr): TELHandle;
FUNCTION TELDefault(VAR theConfig: Ptr; procID: INTEGER; allocate: BOOLEAN): TELErr;
FUNCTION TELValidate(hTEL: TELHandle): BOOLEAN;
FUNCTION TELGetConfig(hTEL: TELHandle): Ptr;
FUNCTION TELSetConfig(hTEL: TELHandle; thePtr: Ptr): INTEGER;
FUNCTION TELChoose(VAR hTEL: TELHandle; where: Point; idleProc: TelephoneChooseIdleUPP): TELErr;
FUNCTION TELSetupPreflight(procID: INTEGER; VAR magicCookie: LONGINT): Handle;
PROCEDURE TELSetupSetup(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogPtr; VAR magicCookie: LONGINT);
FUNCTION TELSetupFilter(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogPtr; VAR theEvent: EventRecord; VAR theItem: INTEGER; VAR magicCookie: LONGINT): BOOLEAN;
PROCEDURE TELSetupItem(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogPtr; VAR theItem: INTEGER; VAR magicCookie: LONGINT);
PROCEDURE TELSetupCleanup(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogPtr; VAR magicCookie: LONGINT);
PROCEDURE TELSetupXCleanup(procID: INTEGER; theConfig: Ptr; count: INTEGER; theDialog: DialogPtr; OKed: BOOLEAN; VAR magicCookie: LONGINT);
PROCEDURE TELSetupPostflight(procID: INTEGER);
FUNCTION TELDispose(hTEL: TELHandle): TELErr;
FUNCTION TELCountDNs(hTEL: TELHandle; dnType: INTEGER; physical: BOOLEAN): INTEGER;
FUNCTION TELDNLookupByIndex(hTEL: TELHandle; dnType: INTEGER; physical: BOOLEAN; index: INTEGER; VAR hTELDN: TELDNHandle): TELErr;
FUNCTION TELDNLookupByName(hTEL: TELHandle; DN: ConstStr255Param; VAR hTELDN: TELDNHandle): TELErr;
FUNCTION TELDNSelect(hTELDN: TELDNHandle; select: BOOLEAN): TELErr;
FUNCTION TELDNDispose(hTELDN: TELDNHandle): TELErr;
FUNCTION TELGetDNInfo(hTELDN: TELDNHandle): TELErr;
FUNCTION TELGetDNFlags(hTELDN: TELDNHandle; VAR dnFeatureFlags: LONGINT; VAR dnForwardFlags: LONGINT): TELErr;
FUNCTION TELDNMsgHand(hTELDN: TELDNHandle; allDNs: BOOLEAN; eventMask: LONGINT; msgProc: TelephoneDNMsgUPP; globals: LONGINT): TELErr;
FUNCTION TELClrDNMsgHand(hTELDN: TELDNHandle; msgProc: TelephoneDNMsgUPP): TELErr;
FUNCTION TELDNEventsSupp(hTELDN: TELDNHandle; VAR eventMask: LONGINT): TELErr;
FUNCTION TELCountCAs(hTELDN: TELDNHandle; internalExternal: INTEGER): INTEGER;
FUNCTION TELCALookup(hTELDN: TELDNHandle; internalExternal: INTEGER; index: INTEGER; VAR hTELCA: TELCAHandle): TELErr;
FUNCTION TELCADispose(hTELCA: TELCAHandle): TELErr;
FUNCTION TELGetCAState(hTELCA: TELCAHandle; VAR state: INTEGER): TELErr;
FUNCTION TELGetCAFlags(hTELCA: TELCAHandle; VAR caFeatureFlags: LONGINT; VAR caOtherFeatures: LONGINT): TELErr;
FUNCTION TELGetCAInfo(hTELCA: TELCAHandle): TELErr;
FUNCTION TELCAMsgHand(hTELDN: TELDNHandle; eventMask: LONGINT; msgProc: TelephoneCAMsgUPP; globals: LONGINT): TELErr;
FUNCTION TELClrCAMsgHand(hTELDN: TELDNHandle; msgProc: TelephoneCAMsgUPP): TELErr;
FUNCTION TELCAEventsSupp(hTELDN: TELDNHandle; VAR eventMask: LONGINT): TELErr;
FUNCTION TELSetupCall(hTELDN: TELDNHandle; VAR hTELCA: TELCAHandle; destDN: ConstStr255Param; destName: ConstStr255Param; destSubaddress: ConstStr255Param; userUserInfo: ConstStr255Param; bearerType: INTEGER; rate: INTEGER): TELErr;
FUNCTION TELConnect(hTELCA: TELCAHandle): TELErr;
FUNCTION TELDialDigits(hTELCA: TELCAHandle; digits: ConstStr255Param): TELErr;
FUNCTION TELAcceptCall(hTELCA: TELCAHandle): TELErr;
FUNCTION TELRejectCall(hTELCA: TELCAHandle; reason: INTEGER): TELErr;
FUNCTION TELDeflectCall(hTELCA: TELCAHandle; rmtDN: ConstStr255Param; rmtName: ConstStr255Param; rmtSubaddress: ConstStr255Param): TELErr;
FUNCTION TELAnswerCall(hTELCA: TELCAHandle): TELErr;
FUNCTION TELDrop(hTELCA: TELCAHandle; userUserInfo: ConstStr255Param): TELErr;
FUNCTION TELHold(hTELCA: TELCAHandle): TELErr;
FUNCTION TELRetrieve(hTELCA: TELCAHandle): TELErr;
FUNCTION TELConferencePrep(hTELCA1: TELCAHandle; hTELCA2: TELCAHandle; numToConference: INTEGER): TELErr;
FUNCTION TELConferenceEstablish(hTELCA1: TELCAHandle; hTELCA2: TELCAHandle): TELErr;
FUNCTION TELConferenceSplit(hTELCA: TELCAHandle): TELErr;
FUNCTION TELTransferPrep(hTELCA1: TELCAHandle; hTELCA2: TELCAHandle): TELErr;
FUNCTION TELTransferEstablish(hTELCA1: TELCAHandle; hTELCA2: TELCAHandle): TELErr;
FUNCTION TELTransferBlind(hTELCA: TELCAHandle; rmtDN: ConstStr255Param; rmtName: ConstStr255Param; rmtSubaddress: ConstStr255Param): TELErr;
FUNCTION TELForwardSet(hTELDN: TELDNHandle; forwardDN: ConstStr255Param; forwardName: ConstStr255Param; forwardSubaddress: ConstStr255Param; forwardType: INTEGER; numrings: INTEGER): TELErr;
FUNCTION TELForwardClear(hTELDN: TELDNHandle; forwardType: INTEGER): TELErr;
FUNCTION TELCallbackSet(hTELCA: TELCAHandle; VAR callbackRef: INTEGER): TELErr;
FUNCTION TELCallbackClear(hTEL: TELHandle; callbackRef: INTEGER): TELErr;
FUNCTION TELCallbackNow(hTELCA: TELCAHandle; callbackRef: INTEGER): TELErr;
FUNCTION TELDNDSet(hTELDN: TELDNHandle; dndType: INTEGER): TELErr;
FUNCTION TELDNDClear(hTELDN: TELDNHandle; dndType: INTEGER): TELErr;
FUNCTION TELCallPickup(hTELCA: TELCAHandle; pickupDN: ConstStr255Param; pickupGroupID: INTEGER): TELErr;
FUNCTION TELParkCall(hTELCA: TELCAHandle; VAR parkRetrieveID: StringPtr; parkID: ConstStr255Param): TELErr;
FUNCTION TELRetrieveParkedCall(hTELCA: TELCAHandle; parkRetrieveID: ConstStr255Param): TELErr;
FUNCTION TELVoiceMailAccess(hTELCA: TELCAHandle): TELErr;
FUNCTION TELPaging(hTELCA: TELCAHandle; pageID: INTEGER): TELErr;
FUNCTION TELIntercom(hTELCA: TELCAHandle; intercomID: INTEGER): TELErr;
FUNCTION TELOtherFeatureList(hTEL: TELHandle; VAR fList: FeatureListPtr): TELErr;
FUNCTION TELOtherFeatureImplement(hTEL: TELHandle; theHandle: Handle; featureID: INTEGER): TELErr;
FUNCTION TELToolFunctions(hTEL: TELHandle; msgcode: INTEGER; VAR supportsIt: BOOLEAN): TELErr;
FUNCTION TELOtherFunction(hTEL: TELHandle; paramblock: Ptr; size: LONGINT): TELErr;
FUNCTION TELGetHooksw(hTEL: TELHandle; hookType: INTEGER; VAR offHook: BOOLEAN): TELErr;
FUNCTION TELSetHooksw(hTEL: TELHandle; hookType: INTEGER; offHook: BOOLEAN): TELErr;
FUNCTION TELGetVolume(hTEL: TELHandle; volType: INTEGER; VAR level: INTEGER; VAR volState: INTEGER): TELErr;
FUNCTION TELSetVolume(hTEL: TELHandle; volType: INTEGER; VAR level: INTEGER; volState: INTEGER): TELErr;
FUNCTION TELAlert(hTEL: TELHandle; VAR level: INTEGER; alertPattern: INTEGER): TELErr;
FUNCTION TELGetDisplay(hTEL: TELHandle; index: INTEGER; VAR displayMode: INTEGER; VAR text: StringPtr): TELErr;
FUNCTION TELSetDisplay(hTEL: TELHandle; index: INTEGER; displayMode: INTEGER; text: ConstStr255Param): TELErr;
PROCEDURE TELIdle(hTEL: TELHandle);
PROCEDURE TELActivate(hTEL: TELHandle; activate: BOOLEAN);
PROCEDURE TELResume(hTEL: TELHandle; resume: BOOLEAN);
FUNCTION TELMenu(hTEL: TELHandle; menuID: INTEGER; item: INTEGER): BOOLEAN;
PROCEDURE TELEvent(hTEL: TELHandle; {CONST}VAR theEvent: EventRecord);
PROCEDURE TELGetToolName(procID: INTEGER; VAR name: Str255);
FUNCTION TELGetVersion(hTEL: TELHandle): Handle;
FUNCTION TELGetTELVersion: INTEGER;
FUNCTION TELIntlToEnglish(hTEL: TELHandle; inputPtr: Ptr; VAR outputPtr: Ptr; language: INTEGER): TELErr;
FUNCTION TELEnglishToIntl(hTEL: TELHandle; inputPtr: Ptr; VAR outputPtr: Ptr; language: INTEGER): TELErr;
FUNCTION TELGetDNSoundInput(hTELDN: TELDNHandle; VAR deviceName: Str255): TELErr;
FUNCTION TELDisposeDNSoundInput(hTELDN: TELDNHandle; deviceName: ConstStr255Param): TELErr;
FUNCTION TELGetDNSoundOutput(hTELDN: TELDNHandle; VAR SndOut: Component): TELErr;
FUNCTION TELDisposeDNSoundOutput(hTELDN: TELDNHandle; SndOut: Component): TELErr;
FUNCTION TELGetHSSoundInput(termHand: TELHandle; VAR deviceName: Str255): TELErr;
FUNCTION TELDisposeHSSoundInput(termHand: TELHandle; deviceName: ConstStr255Param): TELErr;
FUNCTION TELGetHSSoundOutput(termHand: TELHandle; VAR SndOut: Component): TELErr;
FUNCTION TELDisposeHSSoundOutput(termHand: TELHandle; SndOut: Component): TELErr;
FUNCTION TELDNSetAutoAnswer(hTELDN: TELDNHandle; AutoAnswerOn: BOOLEAN): TELErr;
FUNCTION TELDNTollSaverControl(hTELDN: TELDNHandle; QuickAnswer: BOOLEAN): TELErr;
FUNCTION TELSetIndHSConnect(termHand: TELHandle; Connect: BOOLEAN): TELErr;
FUNCTION TELGetIndHSConnect(termHand: TELHandle; VAR Connect: BOOLEAN): TELErr;
FUNCTION TELCAVoiceDetect(hTELCA: TELCAHandle; VoiceDetectOn: BOOLEAN): TELErr;
FUNCTION TELCASilenceDetect(hTELCA: TELCAHandle; DetectOn: BOOLEAN; Period: LONGINT): TELErr;
FUNCTION TELGetTelNewErr: TELErr;
FUNCTION TELDNSetDTMF(hTELDN: TELDNHandle; dtmfOn: BOOLEAN): TELErr;
FUNCTION TELDNGetDTMF(hTELDN: TELDNHandle; VAR dtmfOn: BOOLEAN): TELErr;
FUNCTION TELHSSetDTMF(termHand: TELHandle; dtmfOn: BOOLEAN): TELErr;
FUNCTION TELHSGetDTMF(termHand: TELHandle; VAR dtmfOn: BOOLEAN): TELErr;
FUNCTION TELGetDNStatus(hTELDN: TELDNHandle; VAR inUse: LONGINT): TELErr;
FUNCTION TELGetDNProgressDet(hTELDN: TELDNHandle; selector: LONGINT; VAR prgDetOn: BOOLEAN): TELErr;
FUNCTION TELSetDNProgressDet(hTELDN: TELDNHandle; selector: LONGINT; prgDetOn: BOOLEAN): TELErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TelephonesIncludes}

{$ENDC} {__TELEPHONES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
