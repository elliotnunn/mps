{
     File:       QTSMovie.p
 
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
 UNIT QTSMovie;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QTSMOVIE__}
{$SETC __QTSMOVIE__ := 1}

{$I+}
{$SETC QTSMovieIncludes := UsingIncludes}
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


CONST
	kQTSStreamMediaType			= 'strm';


TYPE
	QTSSampleDescriptionPtr = ^QTSSampleDescription;
	QTSSampleDescription = RECORD
		descSize:				LONGINT;
		dataFormat:				LONGINT;
		resvd1:					LONGINT;								{  set to 0 }
		resvd2:					INTEGER;								{  set to 0 }
		dataRefIndex:			INTEGER;
		version:				UInt32;
		resvd3:					UInt32;									{  set to 0 }
		flags:					SInt32;
																		{  qt atoms follow: }
																		{       long size, long type, some data }
																		{       repeat as necessary }
	END;

	QTSSampleDescriptionHandle			= ^QTSSampleDescriptionPtr;

CONST
	kQTSSampleDescriptionVersion1 = 1;

	kQTSDefaultMediaTimeScale	= 600;

	{  sample description flags }
	kQTSSampleDescPassSampleDataAsHandleFlag = $00000001;


	{	============================================================================
	        Stream Media Handler
	============================================================================	}
	{	-----------------------------------------
	    Info Selectors
	-----------------------------------------	}
	{	 all indexes start at 1 	}

	kQTSMediaPresentationInfo	= 'pres';						{  QTSMediaPresentationParams*  }
	kQTSMediaNotificationInfo	= 'noti';						{  QTSMediaNotificationParams*  }
	kQTSMediaTotalDataRateInfo	= 'dtrt';						{  UInt32*, bits/sec  }
	kQTSMediaLostPercentInfo	= 'lspc';						{  Fixed*  }
	kQTSMediaNumStreamsInfo		= 'nstr';						{  UInt32*  }
	kQTSMediaIndSampleDescriptionInfo = 'isdc';					{  QTSMediaIndSampleDescriptionParams*  }



TYPE
	QTSMediaPresentationParamsPtr = ^QTSMediaPresentationParams;
	QTSMediaPresentationParams = RECORD
		presentationID:			QTSPresentation;
	END;

	QTSMediaNotificationParamsPtr = ^QTSMediaNotificationParams;
	QTSMediaNotificationParams = RECORD
		notificationProc:		QTSNotificationUPP;
		notificationRefCon:		Ptr;
		flags:					SInt32;
	END;

	QTSMediaIndSampleDescriptionParamsPtr = ^QTSMediaIndSampleDescriptionParams;
	QTSMediaIndSampleDescriptionParams = RECORD
		index:					SInt32;
		returnedMediaType:		OSType;
		returnedSampleDescription: SampleDescriptionHandle;
	END;

	{	-----------------------------------------
	    QTS Media Handler Selectors
	-----------------------------------------	}

CONST
	kQTSMediaSetInfoSelect		= $0100;
	kQTSMediaGetInfoSelect		= $0101;
	kQTSMediaSetIndStreamInfoSelect = $0102;
	kQTSMediaGetIndStreamInfoSelect = $0103;

	{	-----------------------------------------
	    QTS Media Handler functions
	-----------------------------------------	}
	{
	 *  QTSMediaSetInfo()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.0 and later
	 	}
FUNCTION QTSMediaSetInfo(mh: MediaHandler; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0100, $7000, $A82A;
	{$ENDC}

{
 *  QTSMediaGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSMediaGetInfo(mh: MediaHandler; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0101, $7000, $A82A;
	{$ENDC}

{
 *  QTSMediaSetIndStreamInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSMediaSetIndStreamInfo(mh: MediaHandler; inIndex: SInt32; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0102, $7000, $A82A;
	{$ENDC}

{
 *  QTSMediaGetIndStreamInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSMediaGetIndStreamInfo(mh: MediaHandler; inIndex: SInt32; inSelector: OSType; ioParams: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}


{============================================================================
        Hint Media Handler
============================================================================}

CONST
	kQTSHintMediaType			= 'hint';

	kQTSHintTrackReference		= 'hint';




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QTSMovieIncludes}

{$ENDC} {__QTSMOVIE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
