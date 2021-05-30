
{
 TelephoneTools.p
 Pascal Interface to the Telephone Manager

  Copyright Apple Computer, Inc. 1990-1993
  All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT TelephoneTools;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingTelephoneTools}
{$SETC UsingTelephoneTools := 1}

{$I+}
{$SETC TelephoneToolsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}

{$IFC UNDEFINED UsingDialogs}
{$I $$Shell(PInterfaces)Dialogs.p}
{$ENDC}

{$SETC UsingIncludes := TelephoneToolsIncludes}


CONST
	vdefType	= 'vdef';		{ main telephone definition procedure }
	vvalType	= 'vval';		{ validation definition procedure }
	vsetType	= 'vset';		{ telephone setup definition procedure }
	vlocType	= 'vloc';		{ telephone configuration localization defProc }
	vscrType	= 'vscr';		{ telephone scripting defProc interfaces }

	vbndType	= 'vbnd';		{ bundle type for telephone	}

	telValidateMsg			= 0;
	telDefaultMsg			= 1;
	
	telMgetMsg				= 0;
	telMsetMsg				= 1;
	
	telSpreflightMsg		= 0;
	telSsetupMsg			= 1;
	telSitemMsg				= 2;
	telSfilterMsg			= 3;
	telScleanupMsg			= 4;
	
	telL2EnglishMsg			= 0;
	telL2IntlMsg			= 1;
	
	
	telNewMsg				= 0;
	telDisposeMsg			= 1;
	telSuspendMsg			= 2;
	telResumeMsg			= 3;
	telMenuMsg				= 4;
	telEventMsg				= 5;
	telActivateMsg			= 6;
	telDeactivateMsg		= 7;
	
	telIdleMsg				= 50;
	telOpenTermMsg			= 51;	
	telResetTermMsg			= 52;		
	telCloseTermMsg			= 53;	
	telTermMsgHandMsg		= 54;
	telClrTermMsgHandMsg	= 55;
	telTermEventsSuppMsg	= 56;
	telGetInfoMsg			= 57;		
	
	
	telCountDNsMsg 			= 60;		
	telDNLookupByIndexMsg 	= 61;	
	telDNLookupByNameMsg	= 62;
	telCallbackCleaMsgr 	= 63;
	telOtherFeatListMsg		= 64;
	telOtherFeatImplMsg		= 65;
	telToolFunctionsMsg		= 66;
	telOtherFunctionMsg		= 67;
	
	telGetHookswMsg			= 70;
	telSetHookswMsg			= 71;
	telGetVolumeMsg			= 72;
	telSetVolumeMsg			= 73;
	telAlertMsg				= 74;
	telGetDisplayMsg		= 75;
	telSetDisplayMsg		= 76;
	
	telDNSelectMsg			= 100;
	telDNDisposeMsg			= 101;
	telGetDNInfoMsg 		= 102;
	telGetDNFlagsMsg		= 103;
	telDNMsgHandMsg 		= 104;
	telClrDNMsgHandMsg		= 105;
	telDNEventsSuppMsg		= 106;
	
	telCountCAsMsg 			= 110;
	telCALookupMsg 			= 111;
	telCAMsgHandMsg 		= 112;
	telClrCAMsgHandMsg		= 113;
	telCAEventsSuppMsg		= 114;
	telSetupCallMsg 		= 115;
	
	telForwardSetMsg 		= 120;
	telForwardClearMsg 		= 121;
	telDNDSetMsg 			= 122;
	telDNDClearMsg 			= 123;
	
	telCADisposeMsg			= 200;
	telGetCAStateMsg		= 201;
	telGetCAFlagsMsg		= 202;
	telGetCAInfoMsg 		= 203;
	telConnectMsg 			= 204;
	telDialDigitsMsg 		= 205;
	telAcceptCallMsg 		= 206;
	telRejectCallMsg 		= 207;
	telDeflectCallMsg 		= 208;
	telAnswerCallMsg		= 209;
	telDropMsg				= 210;
	telHoldMsg 				= 211;
	telRetrieveMsg 			= 212;
	telConfSplitMsg			= 213;
	telTransfBlindMsg		= 214;
	telCallbackSetMsg 		= 215;
	telCallbackNowMsg		= 216;
	telCallPickupMsg 		= 217;
	telParkCallMsg 			= 218;
	telRetrieveParkedCallMsg = 219;
	telVoiceMailAccessMsg	= 220;
	telPagingMsg			= 221;
	telIntercomMsg			= 222;
	
	telConfPrepMsg 			= 230;
	telConfEstMsg 			= 231;
	telTransfPrepMsg 		= 232;
	telTransfEstMsg 		= 233;
	
	telGetDNSoundInputMsg		= 240;
	telDisposeDNSoundInputMsg 	= 241;
	telGetDNSoundOutputMsg		= 242;
	telDisposeDNSoundOutputMsg 	= 243;
	telGetHSSoundInputMsg		= 244;
	telDisposeHSSoundInputMsg 	= 245;
	telGetHSSoundOutputMsg		= 246;
	telDisposeHSSoundOutputMsg 	= 247;
	telDNSetDTMFMsg				= 248;
	telDNGetDTMFMsg				= 249;
	telHSSetDTMFMsg				= 250;
	telHSGetDTMFMsg				= 251;
	telGetDNStatusMsg			= 252;
	telGetDNProgressDetMsg		= 253;
	telSetDNProgressDetMsg		= 254;
	
	telDNSetAutoAnswerMsg		= 260;
	telDNTollSaverControlMsg 	= 261;
	telSetIndHSConnectMsg		= 262;
	telGetIndHSConnectMsg		= 263;
	
	telCAVoiceDetectMsg			= 270;
	telCASilenceDetectMsg		= 271;

TYPE

TELSetupPtr 		= ^TELSetupStruct;
TELSetupStruct 	= RECORD
	theDialog 	: 	DialogPtr;
	count		:	INTEGER;
	theConfig	:	Ptr;
	procID		:	INTEGER;		{ procID of the tool	}
END;

TELForwardPB		= RECORD
	forwardDN			: StringPtr;
	forwardPartyName	: StringPtr;
	forwardSubaddress	: StringPtr;
	forwardType			: INTEGER;
	numRings			: INTEGER;
END;


TELTermMsgPB		= RECORD
	toolID			: INTEGER;
	tRef			: INTEGER;
	msg				: LONGINT;
	mtype			: INTEGER;
	value			: INTEGER;
END;

TELDNMsgPB		= RECORD
	toolID			: INTEGER;
	tRef			: INTEGER;
	dnRef			: INTEGER;
	msg				: LONGINT;
	mtype			: INTEGER;
	value			: INTEGER;
	rmtDN			: StringPtr;
	rmtName			: StringPtr;
	rmtSubaddress	: StringPtr;
END;


TELCAGenericMsgPB	= RECORD
	toolID			: INTEGER;
	tRef			: INTEGER;
	dnRef			: INTEGER;
	caRef			: INTEGER;
	msg				: LONGINT;
	mtype			: INTEGER;
	value			: INTEGER;
	rmtDN			: StringPtr;
	rmtName			: StringPtr;
	rmtSubaddress	: StringPtr;
	dialType		: INTEGER;
END;

TELCADisconMsgPB 	= RECORD
	toolID			: INTEGER;
	tRef			: INTEGER;
	dnRef			: INTEGER;
	caRef			: INTEGER;
	msg				: LONGINT;
	mtype			: INTEGER;
	value			: INTEGER;
END;
	
TELCAConfMsgPB		= RECORD
	toolID			: INTEGER;
	tRef			: INTEGER;
	dnRef			: INTEGER;
	caRef			: INTEGER;
	msg				: LONGINT;
	mtype			: INTEGER;
	value			: INTEGER;
END;

TELCATransfMsgPB	= RECORD
	toolID			: INTEGER;
	tRef			: INTEGER;
	dnRef			: INTEGER;
	caRef			: INTEGER;
	msg				: LONGINT;
	mtype			: INTEGER;
	value			: INTEGER;
	rmtDN			: StringPtr;
	rmtName			: StringPtr;
	rmtSubaddress	: StringPtr;
	dialType		: INTEGER;
END;

TELCAInOutMsgPB	= RECORD
	toolID			: INTEGER;
	tRef			: INTEGER;
	dnRef			: INTEGER;
	caRef			: INTEGER;
	msg				: LONGINT;
	mtype			: INTEGER;
	value			: INTEGER;
	rmtDN			: StringPtr;
	rmtName			: StringPtr;
	rmtSubaddress	: StringPtr;
	caState			: INTEGER;
	intExt			: INTEGER;
	callType		: INTEGER;
	dialType		: INTEGER;
	bearerType		: INTEGER;
	rate			: INTEGER;
	routeDN			: StringPtr;
	routeName		: StringPtr;
	routeSubaddress : StringPtr;
	featureFlags	: LONGINT;
	OtherFeatures	: LONGINT;
	telCAPrivate	: LONGINT;
END;



{$ENDC} {UsingTelephoneTools}

{$IFC NOT UsingIncludes}
	END.
{$ENDC}



	
