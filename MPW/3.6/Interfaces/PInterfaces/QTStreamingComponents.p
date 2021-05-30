{
     File:       QTStreamingComponents.p
 
     Contains:   QuickTime Interfaces.
 
     Version:    Technology: 
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QTStreamingComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QTSTREAMINGCOMPONENTS__}
{$SETC __QTSTREAMINGCOMPONENTS__ := 1}

{$I+}
{$SETC QTStreamingComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMESTREAMING__}
{$I QuickTimeStreaming.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{============================================================================
        Stream Sourcer
============================================================================}

CONST
	kQTSSourcerType				= 'srcr';


TYPE
	QTSSourcer							= ComponentInstance;

CONST
	kQTSSGChannelSourcerType	= 'sgch';
	kQTSMovieTrackSourcerType	= 'trak';
	kQTSPushDataSourcerType		= 'push';

	{	 flags for sourcer data 	}
	kQTSSourcerDataFlag_SyncSample = $00000001;


	kQTSSourcerInitParamsVersion1 = 1;


TYPE
	QTSSourcerInitParamsPtr = ^QTSSourcerInitParams;
	QTSSourcerInitParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		dataType:				OSType;
		data:					Ptr;
		dataLength:				UInt32;
	END;

	{
	 *  QTSNewSourcer()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION QTSNewSourcer(params: UNIV Ptr; {CONST}VAR inInitParams: QTSSourcerInitParams; inFlags: SInt32; VAR outSourcer: ComponentInstance): OSErr; C;

{ info selectors for sourcers - get and set }

CONST
	kQTSInfo_Track				= 'trak';						{  QTSTrackParams*  }
	kQTSInfo_Loop				= 'loop';						{  QTSLoopParams*  }
	kQTSInfo_SourcerTiming		= 'stim';						{  QTSSourcerTimingParams*  }
	kQTSInfo_TargetFrameRate	= 'tfps';						{  Fixed * in frames per second  }
	kQTSInfo_PushData			= 'push';						{  QTSPushDataParams*  }
	kQTSInfo_SourcerCallbackProc = 'scbp';						{  QTSSourcerCallbackProcParams*  }
	kQTSInfo_TargetDataRate		= 'tdrt';						{  UInt32 * in bytes per second  }
	kQTSInfo_AudioAutoGainOnOff	= 'agc ';						{  Boolean*  - error if unavailable }
	kQTSInfo_AudioGain			= 'gain';						{  Fixed* kFixed1 is unity gain  }
	kQTSInfo_CroppedInputRect	= 'crpr';						{  Rect* - defined relative to kQTSInfo_FullInputRect below  }
	kQTSInfo_SpatialSettings	= 'sptl';						{  pointer to SCSpatialSettings struct }
	kQTSInfo_TemporalSettings	= 'tprl';						{  pointer to SCTemporalSettings struct }
	kQTSInfo_DataRateSettings	= 'drat';						{  pointer to SCDataRateSettings struct }
	kQTSInfo_CodecFlags			= 'cflg';						{  pointer to CodecFlags }
	kQTSInfo_CodecSettings		= 'cdec';						{  pointer to Handle }
	kQTSInfo_ForceKeyValue		= 'ksim';						{  pointer to long }
	kQTSInfo_SoundSampleRate	= 'ssrt';						{  pointer to UnsignedFixed }
	kQTSInfo_SoundSampleSize	= 'ssss';						{  pointer to short }
	kQTSInfo_SoundChannelCount	= 'sscc';						{  pointer to short }
	kQTSInfo_SoundCompression	= 'ssct';						{  pointer to OSType }
	kQTSInfo_CompressionList	= 'ctyl';						{  pointer to OSType Handle }
	kQTSInfo_VideoHue			= 'hue ';						{  UInt16*  }
	kQTSInfo_VideoSaturation	= 'satr';						{  UInt16*  }
	kQTSInfo_VideoContrast		= 'trst';						{  UInt16*  }
	kQTSInfo_VideoBrightness	= 'brit';						{  UInt16*  }
	kQTSInfo_VideoSharpness		= 'shrp';						{  UInt16*  }
	kQTSInfo_TimeScale			= 'scal';						{  UInt32*  }

	{	 info selectors for sourcers - get only	}
	kQTSInfo_SGChannel			= 'sgch';						{  SGChannel*  }
	kQTSInfo_InputDeviceName	= 'innm';						{  Handle*  }
	kQTSInfo_InputSourceName	= 'srnm';						{  Handle*  }
	kQTSInfo_FullInputRect		= 'fulr';						{  Rect*  }

	{	 loop flags 	}
	kQTSLoopFlag_Loop			= $00000001;

	kQTSLoopParamsVersion1		= 1;


TYPE
	QTSLoopParamsPtr = ^QTSLoopParams;
	QTSLoopParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		loopFlags:				SInt32;
		flagsMask:				SInt32;
		numLoops:				SInt32;
	END;


CONST
	kQTSTrackParamsVersion1		= 1;


TYPE
	QTSTrackParamsPtr = ^QTSTrackParams;
	QTSTrackParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		track:					Track;
		trackStartOffset:		TimeValue64;							{  to start other than at the beginning otherwise set to 0 }
		duration:				TimeValue64;							{  to limit the duration otherwise set to 0 }
		loopParams:				QTSLoopParamsPtr;						{  set to NULL if not using; default is no looping  }
	END;


CONST
	kQTSSourcerTimingParamsVersion1 = 1;


TYPE
	QTSSourcerTimingParamsPtr = ^QTSSourcerTimingParams;
	QTSSourcerTimingParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		timeScale:				TimeScale;
		presentationStartTime:	TimeValue64;
		presentationEndTime:	TimeValue64;
		presentationCurrentTime: TimeValue64;
		localStartTime:			TimeValue64;
		localEndTime:			TimeValue64;
		localCurrentTime:		TimeValue64;
	END;


CONST
	kQTSPushDataParamsVersion1	= 1;

	kQTSPushDataFlag_SampleTimeIsValid = $00000001;
	kQTSPushDataFlag_DurationIsValid = $00000002;


TYPE
	QTSPushDataParamsPtr = ^QTSPushDataParams;
	QTSPushDataParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		sampleDescription:		SampleDescriptionHandle;				{  caller owns the handle  }
		sampleDescSeed:			UInt32;
		sampleTime:				TimeValue64;							{  also set flag if you set this  }
		duration:				TimeValue64;							{  also set flag if you set this  }
		dataLength:				UInt32;
		dataPtr:				Ptr;									{  this does not have to be a real macintosh Ptr  }
	END;


CONST
	kQTSSourcerCallbackProcParamsVersion1 = 1;



TYPE
	QTSSourcerCallbackProcParamsPtr = ^QTSSourcerCallbackProcParams;
	QTSSourcerCallbackProcParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		proc:					QTSNotificationUPP;
		refCon:					Ptr;
	END;

	{  track sourcer callback selectors }

CONST
	kQTSSourcerCallback_Done	= 'done';						{  QTSSourcerDoneParams*  }


	{  push data sourcer callback selectors }
	kQTSPushDataSourcerCallback_HasCharacteristic = $050D;		{  QTSPushDataHasCharacteristicParams*  }
	kQTSPushDataSourcerCallback_SetInfo = $0507;				{  QTSPushDataInfoParams*  }
	kQTSPushDataSourcerCallback_GetInfo = $0508;				{  QTSPushDataInfoParams*  }


TYPE
	QTSPushDataHasCharacteristicParamsPtr = ^QTSPushDataHasCharacteristicParams;
	QTSPushDataHasCharacteristicParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		characteristic:			OSType;
		returnedHasIt:			BOOLEAN;
		reserved:				PACKED ARRAY [0..2] OF CHAR;
	END;

	QTSPushDataInfoParamsPtr = ^QTSPushDataInfoParams;
	QTSPushDataInfoParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		selector:				OSType;
		ioParams:				Ptr;
	END;


CONST
	kQTSSourcerDoneParamsVersion1 = 1;


TYPE
	QTSSourcerDoneParamsPtr = ^QTSSourcerDoneParams;
	QTSSourcerDoneParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		sourcer:				ComponentInstance;
	END;



	{	-----------------------------------------
	    Stream Sourcer Selectors
	-----------------------------------------	}

CONST
	kQTSSourcerInitializeSelect	= $0500;
	kQTSSourcerSetEnableSelect	= $0503;
	kQTSSourcerGetEnableSelect	= $0504;
	kQTSSourcerSetInfoSelect	= $0507;
	kQTSSourcerGetInfoSelect	= $0508;
	kQTSSourcerSetTimeScaleSelect = $050E;
	kQTSSourcerGetTimeScaleSelect = $050F;
	kQTSSourcerIdleSelect		= $0516;

	{	-----------------------------------------
	    Stream Sourcer Prototypes
	-----------------------------------------	}
	{
	 *  QTSSourcerInitialize()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
	 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X after version 10.0
	 *    Mac OS X:         in after version 10.0
	 	}
FUNCTION QTSSourcerInitialize(inSourcer: QTSSourcer; {CONST}VAR inInitParams: QTSSourcerInitParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0500, $7000, $A82A;
	{$ENDC}

{
 *  QTSSourcerIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSSourcerIdle(inSourcer: QTSSourcer; {CONST}VAR inTime: TimeValue64; inFlags: SInt32; VAR outFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0516, $7000, $A82A;
	{$ENDC}

{
 *  QTSSourcerSetEnable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSSourcerSetEnable(inSourcer: QTSSourcer; inEnableMode: BOOLEAN; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0503, $7000, $A82A;
	{$ENDC}

{
 *  QTSSourcerGetEnable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSSourcerGetEnable(inSourcer: QTSSourcer; VAR outEnableMode: BOOLEAN; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0504, $7000, $A82A;
	{$ENDC}

{
 *  QTSSourcerSetTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSSourcerSetTimeScale(inSourcer: QTSSourcer; inTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050E, $7000, $A82A;
	{$ENDC}

{
 *  QTSSourcerGetTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSSourcerGetTimeScale(inSourcer: QTSSourcer; VAR outTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050F, $7000, $A82A;
	{$ENDC}

{
 *  QTSSourcerSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSSourcerSetInfo(inSourcer: QTSSourcer; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0507, $7000, $A82A;
	{$ENDC}

{
 *  QTSSourcerGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSSourcerGetInfo(inSourcer: QTSSourcer; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0508, $7000, $A82A;
	{$ENDC}


{============================================================================
        Stream Handler
============================================================================}

{
    Server edits are only valid for the current chunk
}

TYPE
	SHServerEditParametersPtr = ^SHServerEditParameters;
	SHServerEditParameters = RECORD
		version:				UInt32;
		editRate:				Fixed;
		dataStartTime_mediaAxis: TimeValue64;
		dataEndTime_mediaAxis:	TimeValue64;
	END;


CONST
	kSHNoChunkDispatchFlags		= 0;
	kSHChunkFlagSyncSample		= $04;
	kSHChunkFlagDataLoss		= $10;


TYPE
	SHChunkRecordPtr = ^SHChunkRecord;
	SHChunkRecord = RECORD
		version:				UInt32;
		reserved1:				LONGINT;
		flags:					SInt32;
		dataSize:				UInt32;
		dataPtr:				Ptr;
		reserved2:				LONGINT;
		reserved3:				LONGINT;
		presentationTime:		TimeValue64;
		reserved4:				LONGINT;
		reserved5:				LONGINT;
		serverEditParameters:	SHServerEditParametersPtr;
		reserved6:				LONGINT;
		reserved7:				LONGINT;
	END;


	{	============================================================================
	        RTP Components
	============================================================================	}
	RTPSSRC								= UInt32;

CONST
	kRTPInvalidSSRC				= 0;


	{	 RTP standard content encodings for audio 	}
	kRTPPayload_PCMU			= 0;							{  8kHz PCM mu-law mono  }
	kRTPPayload_1016			= 1;							{  8kHz CELP (Fed Std 1016) mono  }
	kRTPPayload_G721			= 2;							{  8kHz G.721 ADPCM mono  }
	kRTPPayload_GSM				= 3;							{  8kHz GSM mono  }
	kRTPPayload_G723			= 4;							{  8kHz G.723 ADPCM mono  }
	kRTPPayload_DVI_8			= 5;							{  8kHz Intel DVI ADPCM mono  }
	kRTPPayload_DVI_16			= 6;							{  16kHz Intel DVI ADPCM mono  }
	kRTPPayload_LPC				= 7;							{  8kHz LPC  }
	kRTPPayload_PCMA			= 8;							{  8kHz PCM a-law mono  }
	kRTPPayload_L16_44_2		= 10;							{  44.1kHz 16-bit linear stereo  }
	kRTPPayload_L16_44_1		= 11;							{  44.1kHz 16-bit linear mono  }
	kRTPPayload_PureVoice		= 12;							{  8kHz PureVoice mono (QCELP)  }
	kRTPPayload_MPEGAUDIO		= 14;							{  MPEG I and II audio  }
	kRTPPayload_DVI_11			= 16;							{  11kHz Intel DVI ADPCM mono  }
	kRTPPayload_DVI_22			= 17;							{  22kHz Intel DVI ADPCM mono  }

	{	 RTP standard content encodings for video 	}
	kRTPPayload_CELLB			= 25;							{  Sun CellB  }
	kRTPPayload_JPEG			= 26;							{  JPEG  }
	kRTPPayload_CUSEEME			= 27;							{  Cornell CU-SeeMe  }
	kRTPPayload_NV				= 28;							{  Xerox PARC nv  }
	kRTPPayload_PICWIN			= 29;							{  BBN Picture Window  }
	kRTPPayload_CPV				= 30;							{  Bolter CPV  }
	kRTPPayload_H261			= 31;							{  CCITT H.261  }
	kRTPPayload_MPEGVIDEO		= 32;							{  MPEG I and II video  }
	kRTPPayload_H263			= 34;							{  CCITT H.263  }

	{	 Other RTP standard content encodings 	}
	kRTPPayload_MPEG2T			= 33;							{  MPEG 2 Transport  }

	{	 Dynamic encodings 	}
	kRTPPayload_FirstDynamic	= 96;
	kRTPPayload_LastDynamic		= 127;
	kRTPPayload_Unknown			= $FF;



	{	
	-----------------------------------------
	    RTP Info selectors
	-----------------------------------------
		}
	{	 ----- these are get and set ----- 	}
	kRTPInfo_SSRC				= 'ssrc';						{  UInt32*  }
	kRTPInfo_NextSeqNum			= 'rnsn';						{  UInt16*  }

	{	-----------------------------------------
	    RTP Statistics
	-----------------------------------------	}
	kRTPTotalReceivedPktsStat	= 'trcp';
	kRTPTotalLostPktsStat		= 'tlsp';
	kRTPTotalProcessedPktsStat	= 'tprp';
	kRTPTotalDroppedPktsStat	= 'tdrp';
	kRTPBadHeaderDroppedPktsStat = 'bhdp';
	kRTPOurHeaderDroppedPktsStat = 'ohdp';
	kRTPNotReceivingSenderDroppedPktsStat = 'nsdp';
	kRTPNotProcessingDroppedPktsStat = 'npdp';
	kRTPBadSeqDroppedPktsStat	= 'bsdp';
	kRTPArriveTooLatePktsStat	= 'artl';
	kRTPWaitForSeqDroppedPktsStat = 'wsdp';
	kRTPBadStateDroppedPktsStat	= 'stdp';
	kRTPBadPayloadDroppedPktsStat = 'bpdp';
	kRTPNoTimeScaleDroppedPktsStat = 'ntdp';
	kRTPDupSeqNumDroppedPktsStat = 'dsdp';
	kRTPLostPktsPercentStat		= 'lspp';
	kRTPDroppedPktsPercentStat	= 'dppp';
	kRTPTotalUnprocessedPktsPercentStat = 'tupp';
	kRTPRTCPDataRateStat		= 'rrcd';
	kRTPPayloadIDStat			= 'rpid';
	kRTPPayloadNameStat			= 'rpnm';
	kRTPNumPktsInQueueStat		= 'rnpq';
	kRTPTotalPktsInQueueStat	= 'rtpq';
	kRTPTotalOutOfOrderPktsStat	= 'rtoo';
	kRTPRetransmissionStat		= 'rrtx';


	{	-----------------------------------------
	    Payload Info
	-----------------------------------------	}
	kRTPPayloadSpeedTag			= 'sped';						{  0-255, 255 is fastest }
	kRTPPayloadLossRecoveryTag	= 'loss';						{  0-255, 0 can't handle any loss, 128 can handle 50% packet loss }


TYPE
	RTPPayloadCharacteristicPtr = ^RTPPayloadCharacteristic;
	RTPPayloadCharacteristic = RECORD
		tag:					OSType;
		value:					LONGINT;
	END;

	{	
	    pass RTPPayloadSortRequest to QTSFindMediaPacketizer or QTSFindMediaPacketizerForTrack.
	    define the characteristics to sort by. tag is key to sort on. value is positive for ascending
	    sort (low value first), negative for descending sort (high value first).
		}
	RTPPayloadSortRequestPtr = ^RTPPayloadSortRequest;
	RTPPayloadSortRequest = RECORD
		characteristicCount:	LONGINT;
		characteristic:			ARRAY [0..0] OF RTPPayloadCharacteristic; {  tag is key to sort on, value is + for ascending, - for descending }
	END;

	{	 flags for RTPPayloadInfo 	}

CONST
	kRTPPayloadTypeStaticFlag	= $00000001;
	kRTPPayloadTypeDynamicFlag	= $00000002;


TYPE
	RTPPayloadInfoPtr = ^RTPPayloadInfo;
	RTPPayloadInfo = RECORD
		payloadFlags:			LONGINT;
		payloadID:				SInt8;
		unused:					PACKED ARRAY [0..2] OF CHAR;
		payloadName:			SInt8;
	END;

	RTPPayloadInfoHandle				= ^RTPPayloadInfoPtr;
	{	============================================================================
	        RTP Reassembler
	============================================================================	}
	RTPReassembler						= ComponentInstance;

CONST
	kRTPReassemblerType			= 'rtpr';

	kRTPBaseReassemblerType		= 'gnrc';
	kRTP261ReassemblerType		= 'h261';
	kRTP263ReassemblerType		= 'h263';
	kRTP263PlusReassemblerType	= '263+';
	kRTPAudioReassemblerType	= 'soun';
	kRTPQTReassemblerType		= 'qtim';
	kRTPPureVoiceReassemblerType = 'Qclp';
	kRTPMp3ReassemblerType		= 'mp3 ';
	kRTPJPEGReassemblerType		= 'jpeg';
	kRTPQDesign2ReassemblerType	= 'QDM2';
	kRTPSorensonReassemblerType	= 'SVQ1';


TYPE
	RTPRssmInitParamsPtr = ^RTPRssmInitParams;
	RTPRssmInitParams = RECORD
		ssrc:					RTPSSRC;
		payloadType:			SInt8;
		pad:					PACKED ARRAY [0..2] OF UInt8;
		timeBase:				TimeBase;
		timeScale:				TimeScale;
	END;

	RTPRssmPacketPtr = ^RTPRssmPacket;
	RTPRssmPacket = RECORD
		next:					RTPRssmPacketPtr;
		prev:					RTPRssmPacketPtr;
		streamBuffer:			QTSStreamBufferPtr;
		paramsFilledIn:			BOOLEAN;
		pad:					SInt8;
		sequenceNum:			UInt16;
		transportHeaderLength:	UInt32;									{  filled in by base }
		payloadHeaderLength:	UInt32;									{  derived adjusts this  }
		dataLength:				UInt32;
		serverEditParams:		SHServerEditParameters;
		timeStamp:				TimeValue64;							{  lower 32 bits is original rtp timestamp }
		chunkFlags:				SInt32;									{  these are or'd together }
		flags:					SInt32;
	END;

	{  flags for RTPRssmPacket struct }

CONST
	kRTPRssmPacketHasMarkerBitSet = $00000001;
	kRTPRssmPacketHasServerEditFlag = $00010000;

	{  flags for RTPRssmSendStreamBufferRange }
	kRTPRssmCanRefStreamBuffer	= $00000001;

	{  flags for RTPRssmSendPacketList }
	kRTPRssmLostSomePackets		= $00000001;

	{  flags for RTPRssmSetFlags }
	kRTPRssmEveryPacketAChunkFlag = $00000001;
	kRTPRssmQueueAndUseMarkerBitFlag = $00000002;
	kRTPRssmTrackLostPacketsFlag = $00010000;
	kRTPRssmNoReorderingRequiredFlag = $00020000;



TYPE
	RTPSendStreamBufferRangeParamsPtr = ^RTPSendStreamBufferRangeParams;
	RTPSendStreamBufferRangeParams = RECORD
		streamBuffer:			QTSStreamBufferPtr;
		presentationTime:		TimeValue64;
		chunkStartPosition:		UInt32;
		numDataBytes:			UInt32;
		chunkFlags:				SInt32;
		flags:					SInt32;
		serverEditParams:		SHServerEditParametersPtr;				{  NULL if no edit }
	END;

	{  characteristics }

CONST
	kRTPCharacteristic_RequiresOrderedPackets = 'rrop';
	kRTPCharacteristic_TimeStampsNotMonoIncreasing = 'tsmi';


	kRTPReassemblerInfoResType	= 'rsmi';


TYPE
	RTPReassemblerInfoPtr = ^RTPReassemblerInfo;
	RTPReassemblerInfo = RECORD
		characteristicCount:	LONGINT;
		characteristic:			ARRAY [0..0] OF RTPPayloadCharacteristic;
																		{  after the last characteristic, the payload name (defined by the MediaPacketizerPayloadInfo }
																		{  structure) is present.  }
	END;

	RTPReassemblerInfoHandle			= ^RTPReassemblerInfoPtr;
	{	 RTPReassemblerInfoElement structs are padded to 32 bits 	}

CONST
	kRTPReassemblerInfoPadUpToBytes = 4;


	{
	 *  QTSFindReassemblerForPayloadID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.0 and later
	 	}
FUNCTION QTSFindReassemblerForPayloadID(inPayloadID: ByteParameter; VAR inSortInfo: RTPPayloadSortRequest; VAR outReassemblerList: QTAtomContainer): OSErr; C;

{
 *  QTSFindReassemblerForPayloadName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSFindReassemblerForPayloadName(inPayloadName: ConstCStringPtr; VAR inSortInfo: RTPPayloadSortRequest; VAR outReassemblerList: QTAtomContainer): OSErr; C;

{-----------------------------------------
    RTP Reassembler Selectors
-----------------------------------------}

CONST
	kRTPRssmSetCapabilitiesSelect = $0100;
	kRTPRssmGetCapabilitiesSelect = $0101;
	kRTPRssmSetPayloadHeaderLengthSelect = $0102;
	kRTPRssmGetPayloadHeaderLengthSelect = $0103;
	kRTPRssmSetTimeScaleSelect	= $0104;
	kRTPRssmGetTimeScaleSelect	= $0105;
	kRTPRssmNewStreamHandlerSelect = $0106;
	kRTPRssmSetStreamHandlerSelect = $0107;
	kRTPRssmGetStreamHandlerSelect = $0108;
	kRTPRssmSendStreamHandlerChangedSelect = $0109;
	kRTPRssmSetSampleDescriptionSelect = $010A;
	kRTPRssmGetChunkAndIncrRefCountSelect = $010D;
	kRTPRssmSendChunkAndDecrRefCountSelect = $010E;
	kRTPRssmSendLostChunkSelect	= $010F;
	kRTPRssmSendStreamBufferRangeSelect = $0110;
	kRTPRssmClearCachedPackets	= $0111;
	kRTPRssmFillPacketListParamsSelect = $0113;
	kRTPRssmReleasePacketListSelect = $0114;
	kRTPRssmIncrChunkRefCountSelect = $0115;
	kRTPRssmDecrChunkRefCountSelect = $0116;
	kRTPRssmInitializeSelect	= $0500;
	kRTPRssmHandleNewPacketSelect = $0501;
	kRTPRssmComputeChunkSizeSelect = $0502;
	kRTPRssmAdjustPacketParamsSelect = $0503;
	kRTPRssmCopyDataToChunkSelect = $0504;
	kRTPRssmSendPacketListSelect = $0505;
	kRTPRssmGetTimeScaleFromPacketSelect = $0506;
	kRTPRssmSetInfoSelect		= $0509;
	kRTPRssmGetInfoSelect		= $050A;
	kRTPRssmHasCharacteristicSelect = $050B;
	kRTPRssmResetSelect			= $050C;

	{	-----------------------------------------
	    RTP Reassembler functions - base to derived
	-----------------------------------------	}

	{
	 *  RTPRssmInitialize()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.0 and later
	 	}
FUNCTION RTPRssmInitialize(rtpr: RTPReassembler; VAR inInitParams: RTPRssmInitParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0500, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmHandleNewPacket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmHandleNewPacket(rtpr: RTPReassembler; VAR inStreamBuffer: QTSStreamBuffer; inNumWraparounds: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0501, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmComputeChunkSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmComputeChunkSize(rtpr: RTPReassembler; VAR inPacketListHead: RTPRssmPacket; inFlags: SInt32; VAR outChunkDataSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0502, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmAdjustPacketParams()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmAdjustPacketParams(rtpr: RTPReassembler; VAR inPacket: RTPRssmPacket; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0503, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmCopyDataToChunk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmCopyDataToChunk(rtpr: RTPReassembler; VAR inPacketListHead: RTPRssmPacket; inMaxChunkDataSize: UInt32; VAR inChunk: SHChunkRecord; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0504, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmSendPacketList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSendPacketList(rtpr: RTPReassembler; VAR inPacketListHead: RTPRssmPacket; {CONST}VAR inLastChunkPresentationTime: TimeValue64; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0505, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmGetTimeScaleFromPacket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmGetTimeScaleFromPacket(rtpr: RTPReassembler; VAR inStreamBuffer: QTSStreamBuffer; VAR outTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0506, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSetInfo(rtpr: RTPReassembler; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0509, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmGetInfo(rtpr: RTPReassembler; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050A, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmHasCharacteristic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmHasCharacteristic(rtpr: RTPReassembler; inCharacteristic: OSType; VAR outHasIt: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050B, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmReset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmReset(rtpr: RTPReassembler; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050C, $7000, $A82A;
	{$ENDC}

{-----------------------------------------
    RTP Reassembler functions - derived to base
-----------------------------------------}
{  ----- setup }
{
 *  RTPRssmSetCapabilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSetCapabilities(rtpr: RTPReassembler; inFlags: SInt32; inFlagsMask: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0100, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmGetCapabilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmGetCapabilities(rtpr: RTPReassembler; VAR outFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmSetPayloadHeaderLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSetPayloadHeaderLength(rtpr: RTPReassembler; inPayloadHeaderLength: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmGetPayloadHeaderLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmGetPayloadHeaderLength(rtpr: RTPReassembler; VAR outPayloadHeaderLength: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmSetTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSetTimeScale(rtpr: RTPReassembler; inSHTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmGetTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmGetTimeScale(rtpr: RTPReassembler; VAR outSHTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmNewStreamHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmNewStreamHandler(rtpr: RTPReassembler; inSHType: OSType; inSampleDescription: SampleDescriptionHandle; inSHTimeScale: TimeScale; VAR outHandler: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0106, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmSetStreamHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSetStreamHandler(rtpr: RTPReassembler; inStreamHandler: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0107, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmGetStreamHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmGetStreamHandler(rtpr: RTPReassembler; VAR outStreamHandler: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0108, $7000, $A82A;
	{$ENDC}


{
 *  RTPRssmSendStreamHandlerChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSendStreamHandlerChanged(rtpr: RTPReassembler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0109, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmSetSampleDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSetSampleDescription(rtpr: RTPReassembler; inSampleDescription: SampleDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010A, $7000, $A82A;
	{$ENDC}

{  ----- manually sending chunks }
{
 *  RTPRssmGetChunkAndIncrRefCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmGetChunkAndIncrRefCount(rtpr: RTPReassembler; inChunkDataSize: UInt32; {CONST}VAR inChunkPresentationTime: TimeValue64; VAR outChunk: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010D, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmSendChunkAndDecrRefCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSendChunkAndDecrRefCount(rtpr: RTPReassembler; VAR inChunk: SHChunkRecord; {CONST}VAR inServerEdit: SHServerEditParameters): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $010E, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmSendLostChunk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSendLostChunk(rtpr: RTPReassembler; {CONST}VAR inChunkPresentationTime: TimeValue64): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010F, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmSendStreamBufferRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmSendStreamBufferRange(rtpr: RTPReassembler; VAR inParams: RTPSendStreamBufferRangeParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0110, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmClearCachedPackets()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmClearCachedPackets(rtpr: RTPReassembler; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0111, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmFillPacketListParams()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmFillPacketListParams(rtpr: RTPReassembler; VAR inPacketListHead: RTPRssmPacket; inNumWraparounds: SInt32; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0113, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmReleasePacketList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmReleasePacketList(rtpr: RTPReassembler; VAR inPacketListHead: RTPRssmPacket): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0114, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmIncrChunkRefCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmIncrChunkRefCount(rtpr: RTPReassembler; VAR inChunk: SHChunkRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0115, $7000, $A82A;
	{$ENDC}

{
 *  RTPRssmDecrChunkRefCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPRssmDecrChunkRefCount(rtpr: RTPReassembler; VAR inChunk: SHChunkRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0116, $7000, $A82A;
	{$ENDC}

{============================================================================
        RTP Media Packetizer
============================================================================}

CONST
	kRTPMediaPacketizerType		= 'rtpm';


TYPE
	RTPMediaPacketizer					= ComponentInstance;

CONST
	kRTPBaseMediaPacketizerType	= 'gnrc';
	kRTP261MediaPacketizerType	= 'h261';
	kRTP263PlusMediaPacketizerType = '263+';
	kRTPAudioMediaPacketizerType = 'soun';
	kRTPQTMediaPacketizerType	= 'qtim';
	kRTPPureVoiceMediaPacketizerType = 'Qclp';
	kRTPMp3MediaPacketizerType	= 'mp3 ';
	kRTPJPEGMediaPacketizerType	= 'jpeg';
	kRTPQDesign2MediaPacketizerType = 'QDM2';
	kRTPSorensonMediaPacketizerType = 'SVQ1';


TYPE
	RTPMPSampleRef						= UInt32;
{$IFC TYPED_FUNCTION_POINTERS}
	RTPMPDataReleaseProcPtr = PROCEDURE(VAR inData: UInt8; inRefCon: UNIV Ptr);
{$ELSEC}
	RTPMPDataReleaseProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	RTPMPDataReleaseUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	RTPMPDataReleaseUPP = UniversalProcPtr;
{$ENDC}	

CONST
	kMediaPacketizerCanPackEditRate = $01;
	kMediaPacketizerCanPackLayer = $02;
	kMediaPacketizerCanPackVolume = $04;
	kMediaPacketizerCanPackBalance = $08;
	kMediaPacketizerCanPackGraphicsMode = $10;
	kMediaPacketizerCanPackEmptyEdit = $20;



TYPE
	MediaPacketizerRequirementsPtr = ^MediaPacketizerRequirements;
	MediaPacketizerRequirements = RECORD
		mediaType:				OSType;									{  media type supported (0 for all) }
		dataFormat:				OSType;									{  data format (e.g., compression) supported (0 for all) }
		capabilityFlags:		UInt32;									{  ability to handle non-standard track characteristics }
		canPackMatrixType:		SInt8;									{  can pack any matrix type up to this (identityMatrixType for identity only) }
		pad:					PACKED ARRAY [0..2] OF UInt8;
	END;

	MediaPacketizerInfoPtr = ^MediaPacketizerInfo;
	MediaPacketizerInfo = RECORD
		mediaType:				OSType;									{  media type supported (0 for all) }
		dataFormat:				OSType;									{  data format (e.g., compression) supported (0 for all) }
		vendor:					OSType;									{  manufacturer of this packetizer (e.g., 'appl' for Apple) }
		capabilityFlags:		UInt32;									{  ability to handle non-standard track characteristics }
		canPackMatrixType:		SInt8;									{  can pack any matrix type up to this (identityMatrixType for identity only) }
		pad:					PACKED ARRAY [0..2] OF UInt8;
		characteristicCount:	LONGINT;
		characteristic:			ARRAY [0..0] OF RTPPayloadCharacteristic;
																		{  after the last characteristic, the payload name (defined by the RTPPayloadInfo }
																		{  structure) is present.  }
	END;

	MediaPacketizerInfoHandle			= ^MediaPacketizerInfoPtr;
	{	 MediaPacketizerInfo structs are padded to 32 bits 	}

CONST
	kMediaPacketizerInfoPadUpToBytes = 4;

	{
	 *  QTSFindMediaPacketizer()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.0 and later
	 	}
FUNCTION QTSFindMediaPacketizer(inPacketizerinfo: MediaPacketizerRequirementsPtr; inSampleDescription: SampleDescriptionHandle; inSortInfo: RTPPayloadSortRequestPtr; VAR outPacketizerList: QTAtomContainer): OSErr; C;

{
 *  QTSFindMediaPacketizerForTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSFindMediaPacketizerForTrack(inTrack: Track; inSampleDescriptionIndex: LONGINT; inSortInfo: RTPPayloadSortRequestPtr; VAR outPacketizerList: QTAtomContainer): OSErr; C;

{
 *  QTSFindMediaPacketizerForPayloadID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSFindMediaPacketizerForPayloadID(payloadID: LONGINT; inSortInfo: RTPPayloadSortRequestPtr; VAR outPacketizerList: QTAtomContainer): OSErr; C;

{
 *  QTSFindMediaPacketizerForPayloadName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSFindMediaPacketizerForPayloadName(payloadName: ConstCStringPtr; inSortInfo: RTPPayloadSortRequestPtr; VAR outPacketizerList: QTAtomContainer): OSErr; C;

{  flags for RTPMPInitialize }

CONST
	kRTPMPRealtimeModeFlag		= $00000001;

	{  flags for RTPMPSampleDataParams }
	kRTPMPSyncSampleFlag		= $00000001;
	kRTPMPRespectDurationFlag	= $00000002;


TYPE
	RTPMPSampleDataParamsPtr = ^RTPMPSampleDataParams;
	RTPMPSampleDataParams = RECORD
		version:				UInt32;
		timeStamp:				UInt32;
		duration:				UInt32;									{  0 = unknown duration }
		playOffset:				UInt32;
		playRate:				Fixed;
		flags:					SInt32;
		sampleDescSeed:			UInt32;
		sampleDescription:		Handle;
		sampleRef:				RTPMPSampleRef;
		dataLength:				UInt32;
		data:					Ptr;
		releaseProc:			RTPMPDataReleaseUPP;
		refCon:					Ptr;
	END;

	{  out flags for idle, RTPMPSetSampleData, and RTPMPFlush }

CONST
	kRTPMPStillProcessingData	= $00000001;					{  not done with data you've got }


TYPE
	RTPMPPayloadTypeParamsPtr = ^RTPMPPayloadTypeParams;
	RTPMPPayloadTypeParams = RECORD
		flags:					UInt32;
		payloadNumber:			UInt32;
		nameLength:				INTEGER;								{  in: size of payloadName buffer (counting null terminator) -- this will be reset to needed length and paramErr returned if too small  }
		payloadName:			CStringPtr;								{  caller must provide buffer  }
	END;

	{	-----------------------------------------
	    RTP Media Packetizer Info selectors
	-----------------------------------------	}
	{	 info selectors - get only 	}

CONST
	kRTPMPPayloadTypeInfo		= 'rtpp';						{  RTPMPPayloadTypeParams*  }
	kRTPMPRTPTimeScaleInfo		= 'rtpt';						{  TimeScale*  }
	kRTPMPRequiredSampleDescriptionInfo = 'sdsc';				{  SampleDescriptionHandle*  }
	kRTPMPMinPayloadSize		= 'mins';						{  UInt32* in bytes, does not include rtp header; default is 0  }
	kRTPMPMinPacketDuration		= 'mind';						{  UInt3* in milliseconds; default is no min required  }
	kRTPMPSuggestedRepeatPktCountInfo = 'srpc';					{  UInt32*  }
	kRTPMPSuggestedRepeatPktSpacingInfo = 'srps';				{  UInt32* in milliseconds  }
	kRTPMPMaxPartialSampleSizeInfo = 'mpss';					{  UInt32* in bytes  }
	kRTPMPPreferredBufferDelayInfo = 'prbd';					{  UInt32* in milliseconds  }
	kRTPMPPayloadNameInfo		= 'name';						{  StringPtr  }

	{	-----------------------------------------
	    RTP Media Packetizer Characteristics
	-----------------------------------------	}
	{	 also supports relevant ones in Movies.h and QTSToolbox.h 	}
	kRTPMPNoSampleDataRequiredCharacteristic = 'nsdr';
	kRTPMPHasUserSettingsDialogCharacteristic = 'sdlg';
	kRTPMPPrefersReliableTransportCharacteristic = 'rely';
	kRTPMPRequiresOutOfBandDimensionsCharacteristic = 'robd';
	kRTPMPReadsPartialSamplesCharacteristic = 'rpsp';

	{	-----------------------------------------
	    RTP Media Packetizer selectors
	-----------------------------------------	}
	kRTPMPInitializeSelect		= $0500;
	kRTPMPPreflightMediaSelect	= $0501;
	kRTPMPIdleSelect			= $0502;
	kRTPMPSetSampleDataSelect	= $0503;
	kRTPMPFlushSelect			= $0504;
	kRTPMPResetSelect			= $0505;
	kRTPMPSetInfoSelect			= $0506;
	kRTPMPGetInfoSelect			= $0507;
	kRTPMPSetTimeScaleSelect	= $0508;
	kRTPMPGetTimeScaleSelect	= $0509;
	kRTPMPSetTimeBaseSelect		= $050A;
	kRTPMPGetTimeBaseSelect		= $050B;
	kRTPMPHasCharacteristicSelect = $050C;
	kRTPMPSetPacketBuilderSelect = $050E;
	kRTPMPGetPacketBuilderSelect = $050F;
	kRTPMPSetMediaTypeSelect	= $0510;
	kRTPMPGetMediaTypeSelect	= $0511;
	kRTPMPSetMaxPacketSizeSelect = $0512;
	kRTPMPGetMaxPacketSizeSelect = $0513;
	kRTPMPSetMaxPacketDurationSelect = $0514;
	kRTPMPGetMaxPacketDurationSelect = $0515;					{  for export component and apps who want to }
																{  access dialogs for Media-specific settings }
																{  (such as Pure Voice interleave factor) }
	kRTPMPDoUserDialogSelect	= $0516;
	kRTPMPSetSettingsFromAtomContainerAtAtomSelect = $0517;
	kRTPMPGetSettingsIntoAtomContainerAtAtomSelect = $0518;
	kRTPMPGetSettingsAsTextSelect = $0519;
	kRTPMPGetSettingsSelect		= $051A;
	kRTPMPSetSettingsSelect		= $051B;

	{	-----------------------------------------
	    RTP Media Packetizer functions
	-----------------------------------------	}

	{
	 *  RTPMPInitialize()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.0 and later
	 	}
FUNCTION RTPMPInitialize(rtpm: RTPMediaPacketizer; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0500, $7000, $A82A;
	{$ENDC}

{ return noErr if you can handle this media }
{
 *  RTPMPPreflightMedia()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPPreflightMedia(rtpm: RTPMediaPacketizer; inMediaType: OSType; inSampleDescription: SampleDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0501, $7000, $A82A;
	{$ENDC}

{
   do work here if you need to - give up time periodically
   if you're doing time consuming operations
}
{
 *  RTPMPIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPIdle(rtpm: RTPMediaPacketizer; inFlags: SInt32; VAR outFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0502, $7000, $A82A;
	{$ENDC}

{
   caller owns the RTPMPSampleDataParams struct
   media Packetizer must copy any fields of the struct it wants to keep
   media Packetizer must call release proc when done with the data
   you can do the processing work here if it does not take up too
   much cpu time - otherwise do it in idle
}
{
 *  RTPMPSetSampleData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPSetSampleData(rtpm: RTPMediaPacketizer; {CONST}VAR inSampleData: RTPMPSampleDataParams; VAR outFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0503, $7000, $A82A;
	{$ENDC}

{
   send everything you have buffered - you will get idles while
   you set the kRTPMPStillProcessingData flag here and in idle
}
{
 *  RTPMPFlush()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPFlush(rtpm: RTPMediaPacketizer; inFlags: SInt32; VAR outFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0504, $7000, $A82A;
	{$ENDC}

{
   dispose of anything buffered and get rid of state
   do not send the buffered data (because presumably
   there is no connection for you to send on)
   state should be the same as if you were just initialized
}
{
 *  RTPMPReset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPReset(rtpm: RTPMediaPacketizer; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0505, $7000, $A82A;
	{$ENDC}

{-----------------------------------------
    RTP Media Packetizer get / set functions
-----------------------------------------}
{
 *  RTPMPSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPSetInfo(rtpm: RTPMediaPacketizer; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0506, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPGetInfo(rtpm: RTPMediaPacketizer; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0507, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPSetTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPSetTimeScale(rtpm: RTPMediaPacketizer; inTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0508, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPGetTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPGetTimeScale(rtpm: RTPMediaPacketizer; VAR outTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0509, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPSetTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPSetTimeBase(rtpm: RTPMediaPacketizer; inTimeBase: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050A, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPGetTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPGetTimeBase(rtpm: RTPMediaPacketizer; VAR outTimeBase: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050B, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPHasCharacteristic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPHasCharacteristic(rtpm: RTPMediaPacketizer; inSelector: OSType; VAR outHasIt: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050C, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPSetPacketBuilder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPSetPacketBuilder(rtpm: RTPMediaPacketizer; inPacketBuilder: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050E, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPGetPacketBuilder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPGetPacketBuilder(rtpm: RTPMediaPacketizer; VAR outPacketBuilder: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050F, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPSetMediaType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPSetMediaType(rtpm: RTPMediaPacketizer; inMediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0510, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPGetMediaType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPGetMediaType(rtpm: RTPMediaPacketizer; VAR outMediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0511, $7000, $A82A;
	{$ENDC}

{  size is in bytes }
{
 *  RTPMPSetMaxPacketSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPSetMaxPacketSize(rtpm: RTPMediaPacketizer; inMaxPacketSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0512, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPGetMaxPacketSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPGetMaxPacketSize(rtpm: RTPMediaPacketizer; VAR outMaxPacketSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0513, $7000, $A82A;
	{$ENDC}

{  duration is in milliseconds }
{
 *  RTPMPSetMaxPacketDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPSetMaxPacketDuration(rtpm: RTPMediaPacketizer; inMaxPacketDuration: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0514, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPGetMaxPacketDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPGetMaxPacketDuration(rtpm: RTPMediaPacketizer; VAR outMaxPacketDuration: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0515, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPDoUserDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPDoUserDialog(rtpm: RTPMediaPacketizer; inFilterUPP: ModalFilterUPP; VAR canceled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0516, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPSetSettingsFromAtomContainerAtAtom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPSetSettingsFromAtomContainerAtAtom(rtpm: RTPMediaPacketizer; inContainer: QTAtomContainer; inParentAtom: QTAtom): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0517, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPGetSettingsIntoAtomContainerAtAtom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPGetSettingsIntoAtomContainerAtAtom(rtpm: RTPMediaPacketizer; inOutContainer: QTAtomContainer; inParentAtom: QTAtom): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0518, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPGetSettingsAsText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPMPGetSettingsAsText(rtpm: RTPMediaPacketizer; VAR text: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0519, $7000, $A82A;
	{$ENDC}


{
 *  RTPMPGetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION RTPMPGetSettings(rtpm: RTPMediaPacketizer; VAR outSettings: QTAtomContainer; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $051A, $7000, $A82A;
	{$ENDC}

{
 *  RTPMPSetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION RTPMPSetSettings(rtpm: RTPMediaPacketizer; inSettings: QTAtomSpecPtr; inFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $051B, $7000, $A82A;
	{$ENDC}

{============================================================================
        RTP Packet Builder
============================================================================}

CONST
	kRTPPacketBuilderType		= 'rtpb';


TYPE
	RTPPacketBuilder					= ComponentInstance;
	RTPPacketGroupRef    = ^LONGINT; { an opaque 32-bit type }
	RTPPacketGroupRefPtr = ^RTPPacketGroupRef;  { when a VAR xx:RTPPacketGroupRef parameter can be nil, it is changed to xx: RTPPacketGroupRefPtr }
	RTPPacketRef    = ^LONGINT; { an opaque 32-bit type }
	RTPPacketRefPtr = ^RTPPacketRef;  { when a VAR xx:RTPPacketRef parameter can be nil, it is changed to xx: RTPPacketRefPtr }
	RTPPacketRepeatedDataRef    = ^LONGINT; { an opaque 32-bit type }
	RTPPacketRepeatedDataRefPtr = ^RTPPacketRepeatedDataRef;  { when a VAR xx:RTPPacketRepeatedDataRef parameter can be nil, it is changed to xx: RTPPacketRepeatedDataRefPtr }
	{  flags for RTPPBBegin/EndPacket, RTPPBBegin/EndPacketGroup }

CONST
	kRTPPBSetMarkerFlag			= $00000001;
	kRTPPBRepeatPacketFlag		= $00000002;
	kRTPPBSyncSampleFlag		= $00010000;
	kRTPPBBFrameFlag			= $00020000;
	kRTPPBDontSendFlag			= $10000000;					{  when set in EndPacketGroup, will not add group }

	kRTPPBUnknownPacketMediaDataLength = 0;

	{  flags for RTPPBGetSampleData }
	kRTPPBEndOfDataFlag			= $00000001;



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	RTPPBCallbackProcPtr = PROCEDURE(inSelector: OSType; ioParams: UNIV Ptr; inRefCon: UNIV Ptr);
{$ELSEC}
	RTPPBCallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	RTPPBCallbackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	RTPPBCallbackUPP = UniversalProcPtr;
{$ENDC}	
	{	-----------------------------------------
	    RTP Packet Builder selectors
	-----------------------------------------	}

CONST
	kRTPPBBeginPacketGroupSelect = $0500;
	kRTPPBEndPacketGroupSelect	= $0501;
	kRTPPBBeginPacketSelect		= $0502;
	kRTPPBEndPacketSelect		= $0503;
	kRTPPBAddPacketLiteralDataSelect = $0504;
	kRTPPBAddPacketSampleDataSelect = $0505;
	kRTPPBAddPacketRepeatedDataSelect = $0506;
	kRTPPBReleaseRepeatedDataSelect = $0507;
	kRTPPBSetPacketSequenceNumberSelect = $0508;
	kRTPPBGetPacketSequenceNumberSelect = $0509;
	kRTPPBSetCallbackSelect		= $050A;
	kRTPPBGetCallbackSelect		= $050B;
	kRTPPBSetInfoSelect			= $050C;
	kRTPPBGetInfoSelect			= $050D;
	kRTPPBSetPacketTimeStampOffsetSelect = $050E;
	kRTPPBGetPacketTimeStampOffsetSelect = $050F;
	kRTPPBAddPacketSampleData64Select = $0510;
	kRTPPBGetSampleDataSelect	= $0511;
	kRTPPBAddRepeatPacketSelect	= $0512;

	{	-----------------------------------------
	    RTP Packet Builder functions
	-----------------------------------------	}
	{
	 *  RTPPBBeginPacketGroup()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.0 and later
	 	}
FUNCTION RTPPBBeginPacketGroup(rtpb: RTPPacketBuilder; inFlags: SInt32; inTimeStamp: UInt32; VAR outPacketGroup: RTPPacketGroupRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0500, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBEndPacketGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBEndPacketGroup(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0501, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBBeginPacket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBBeginPacket(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacketMediaDataLength: UInt32; VAR outPacket: RTPPacketRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0502, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBEndPacket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBEndPacket(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; inTransmissionTimeOffset: UInt32; inDuration: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0503, $7000, $A82A;
	{$ENDC}

{
   non-NULL RTPPacketRepeatedDataRef means this data will be repeated later
   pb must return a repeated data ref
}
{
 *  RTPPBAddPacketLiteralData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBAddPacketLiteralData(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; VAR inData: UInt8; inDataLength: UInt32; VAR outDataRef: RTPPacketRepeatedDataRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0504, $7000, $A82A;
	{$ENDC}

{
   non-NULL RTPPacketRepeatedDataRef means this data will be repeated later
   pb must return a repeated data ref
}
{
 *  RTPPBAddPacketSampleData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBAddPacketSampleData(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; VAR inSampleDataParams: RTPMPSampleDataParams; inSampleOffset: UInt32; inSampleDataLength: UInt32; VAR outDataRef: RTPPacketRepeatedDataRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $0505, $7000, $A82A;
	{$ENDC}

{
   non-NULL RTPPacketRepeatedDataRef means this data will be repeated later
   pb must return a repeated data ref
}
{
 *  RTPPBAddPacketSampleData64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION RTPPBAddPacketSampleData64(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; VAR inSampleDataParams: RTPMPSampleDataParams; {CONST}VAR inSampleOffset: UInt64; inSampleDataLength: UInt32; VAR outDataRef: RTPPacketRepeatedDataRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $0510, $7000, $A82A;
	{$ENDC}

{
   call to add the repeated data using the ref you got from
   RTPPBAddPacketLiteralData or RTPPBAddPacketSampleData
}
{
 *  RTPPBAddPacketRepeatedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBAddPacketRepeatedData(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; inDataRef: RTPPacketRepeatedDataRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0506, $7000, $A82A;
	{$ENDC}

{  call when done with repeated data }
{
 *  RTPPBReleaseRepeatedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBReleaseRepeatedData(rtpb: RTPPacketBuilder; inDataRef: RTPPacketRepeatedDataRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0507, $7000, $A82A;
	{$ENDC}

{
   seq number is just relative seq number
   don't call if you don't care when seq # is used
}
{
 *  RTPPBSetPacketSequenceNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBSetPacketSequenceNumber(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; inSequenceNumber: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0508, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBGetPacketSequenceNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBGetPacketSequenceNumber(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; VAR outSequenceNumber: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0509, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBSetPacketTimeStampOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION RTPPBSetPacketTimeStampOffset(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; inTimeStampOffset: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $050E, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBGetPacketTimeStampOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION RTPPBGetPacketTimeStampOffset(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; VAR outTimeStampOffset: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $050F, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBAddRepeatPacket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION RTPPBAddRepeatPacket(rtpb: RTPPacketBuilder; inFlags: SInt32; inPacketGroup: RTPPacketGroupRef; inPacket: RTPPacketRef; inTransmissionOffset: TimeValue; inSequenceNumber: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0512, $7000, $A82A;
	{$ENDC}

{
   used for communicating with the caller of the media packetizers if needed
   NOT used for communicating with the media packetizers themselves
}
{
 *  RTPPBSetCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBSetCallback(rtpb: RTPPacketBuilder; inCallback: RTPPBCallbackUPP; inRefCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050A, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBGetCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBGetCallback(rtpb: RTPPacketBuilder; VAR outCallback: RTPPBCallbackUPP; VAR outRefCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050B, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBSetInfo(rtpb: RTPPacketBuilder; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050C, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION RTPPBGetInfo(rtpb: RTPPacketBuilder; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050D, $7000, $A82A;
	{$ENDC}

{
 *  RTPPBGetSampleData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION RTPPBGetSampleData(rtpb: RTPPacketBuilder; VAR inParams: RTPMPSampleDataParams; {CONST}VAR inStartOffset: UInt64; VAR outDataBuffer: UInt8; inBytesToRead: UInt32; VAR outBytesRead: UInt32; VAR outFlags: SInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0511, $7000, $A82A;
	{$ENDC}


{ UPP call backs }

CONST
	uppRTPMPDataReleaseProcInfo = $000003C0;
	uppRTPPBCallbackProcInfo = $00000FC0;
	{
	 *  NewRTPMPDataReleaseUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewRTPMPDataReleaseUPP(userRoutine: RTPMPDataReleaseProcPtr): RTPMPDataReleaseUPP; { old name was NewRTPMPDataReleaseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewRTPPBCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewRTPPBCallbackUPP(userRoutine: RTPPBCallbackProcPtr): RTPPBCallbackUPP; { old name was NewRTPPBCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeRTPMPDataReleaseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeRTPMPDataReleaseUPP(userUPP: RTPMPDataReleaseUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeRTPPBCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeRTPPBCallbackUPP(userUPP: RTPPBCallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeRTPMPDataReleaseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeRTPMPDataReleaseUPP(VAR inData: UInt8; inRefCon: UNIV Ptr; userRoutine: RTPMPDataReleaseUPP); { old name was CallRTPMPDataReleaseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeRTPPBCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeRTPPBCallbackUPP(inSelector: OSType; ioParams: UNIV Ptr; inRefCon: UNIV Ptr; userRoutine: RTPPBCallbackUPP); { old name was CallRTPPBCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QTStreamingComponentsIncludes}

{$ENDC} {__QTSTREAMINGCOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
