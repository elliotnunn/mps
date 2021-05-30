{
     File:       URLAccess.p
 
     Contains:   URL Access Interfaces.
 
     Version:    Technology: URLAccess 2.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT URLAccess;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __URLACCESS__}
{$SETC __URLACCESS__ := 1}

{$I+}
{$SETC URLAccessIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Data structures and types }

TYPE
	URLReference    = ^LONGINT; { an opaque 32-bit type }
	URLReferencePtr = ^URLReference;  { when a VAR xx:URLReference parameter can be nil, it is changed to xx: URLReferencePtr }
	URLOpenFlags 				= UInt32;
CONST
	kURLReplaceExistingFlag		= $01;
	kURLBinHexFileFlag			= $02;							{  Binhex before uploading if necessary }
	kURLExpandFileFlag			= $04;							{  Use StuffIt engine to expand file if necessary }
	kURLDisplayProgressFlag		= $08;
	kURLDisplayAuthFlag			= $10;							{  Display auth dialog if guest connection fails }
	kURLUploadFlag				= $20;							{  Do an upload instead of a download }
	kURLIsDirectoryHintFlag		= $40;							{  Hint: the URL is a directory }
	kURLDoNotTryAnonymousFlag	= $80;							{  Don't try to connect anonymously before getting logon info }
	kURLDirectoryListingFlag	= $0100;						{  Download the directory listing, not the whole directory }
	kURLExpandAndVerifyFlag		= $0200;						{  Expand file and then verify using signature resource }
	kURLNoAutoRedirectFlag		= $0400;						{  Do not automatically redirect to new URL }
	kURLDebinhexOnlyFlag		= $0800;						{  Do not use Stuffit Expander - just internal debinhex engine }
	kURLDoNotDeleteOnErrorFlag	= $1000;						{  Do not delete the downloaded file if an error or abort occurs. }
																{  This flag applies to downloading only and should be used if }
																{  interested in later resuming the download. }
	kURLResumeDownloadFlag		= $2000;						{  The passed in file is partially downloaded, attempt to resume }
																{  it.  Currently works for HTTP only.  If no FSSpec passed in, }
																{  this flag will be ignored. Overriden by kURLReplaceExistingFlag.  }
	kURLReservedFlag			= $80000000;					{  reserved for Apple internal use }


TYPE
	URLState 					= UInt32;
CONST
	kURLNullState				= 0;
	kURLInitiatingState			= 1;
	kURLLookingUpHostState		= 2;
	kURLConnectingState			= 3;
	kURLResourceFoundState		= 4;
	kURLDownloadingState		= 5;
	kURLDataAvailableState		= $15;
	kURLTransactionCompleteState = 6;
	kURLErrorOccurredState		= 7;
	kURLAbortingState			= 8;
	kURLCompletedState			= 9;
	kURLUploadingState			= 10;


TYPE
	URLEvent 					= UInt32;
CONST
	kURLInitiatedEvent			= 1;
	kURLResourceFoundEvent		= 4;
	kURLDownloadingEvent		= 5;
	kURLAbortInitiatedEvent		= 8;
	kURLCompletedEvent			= 9;
	kURLErrorOccurredEvent		= 7;
	kURLDataAvailableEvent		= $15;
	kURLTransactionCompleteEvent = 6;
	kURLUploadingEvent			= 10;
	kURLSystemEvent				= 29;
	kURLPercentEvent			= 30;
	kURLPeriodicEvent			= 31;
	kURLPropertyChangedEvent	= 32;


TYPE
	URLEventMask						= UInt32;

CONST
	kURLInitiatedEventMask		= $01;
	kURLResourceFoundEventMask	= $08;
	kURLDownloadingMask			= $10;
	kURLUploadingMask			= $0200;
	kURLAbortInitiatedMask		= $80;
	kURLCompletedEventMask		= $0100;
	kURLErrorOccurredEventMask	= $40;
	kURLDataAvailableEventMask	= $00100000;
	kURLTransactionCompleteEventMask = $20;
	kURLSystemEventMask			= $10000000;
	kURLPercentEventMask		= $20000000;
	kURLPeriodicEventMask		= $40000000;
	kURLPropertyChangedEventMask = $80000000;
	kURLAllBufferEventsMask		= $00100020;
	kURLAllNonBufferEventsMask	= $E00003D1;
	kURLAllEventsMask			= $FFFFFFFF;



TYPE
	URLCallbackInfoPtr = ^URLCallbackInfo;
	URLCallbackInfo = RECORD
		version:				UInt32;
		urlRef:					URLReference;
		property:				ConstCStringPtr;
		currentSize:			UInt32;
		systemEvent:			EventRecordPtr;
	END;


	{  authentication type flags }

CONST
	kUserNameAndPasswordFlag	= $00000001;

{$IFC NOT UNDEFINED MWERKS}
	kURLURL						= "URLString";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLResourceSize			= "URLResourceSize";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLLastModifiedTime		= "URLLastModifiedTime";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLMIMEType				= "URLMIMEType";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLFileType				= "URLFileType";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLFileCreator				= "URLFileCreator";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLCharacterSet			= "URLCharacterSet";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLResourceName			= "URLResourceName";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLHost					= "URLHost";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLAuthType				= "URLAuthType";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLUserName				= "URLUserName";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLPassword				= "URLPassword";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLStatusString			= "URLStatusString";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLIsSecure				= "URLIsSecure";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLCertificate				= "URLCertificate";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLTotalItems				= "URLTotalItems";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLConnectTimeout			= "URLConnectTimeout";
{$ENDC}
	{  http and https properties }
{$IFC NOT UNDEFINED MWERKS}
	kURLHTTPRequestMethod		= "URLHTTPRequestMethod";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLHTTPRequestHeader		= "URLHTTPRequestHeader";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLHTTPRequestBody			= "URLHTTPRequestBody";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLHTTPRespHeader			= "URLHTTPRespHeader";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLHTTPUserAgent			= "URLHTTPUserAgent";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLHTTPRedirectedURL		= "URLHTTPRedirectedURL";
{$ENDC}
{$IFC NOT UNDEFINED MWERKS}
	kURLSSLCipherSuite			= "URLSSLCipherSuite";
{$ENDC}




	{
	 *  URLGetURLAccessVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION URLGetURLAccessVersion(VAR returnVers: UInt32): OSStatus;


{$IFC TARGET_RT_MAC_CFM }
{
        URLAccessAvailable() is a macro/inline available only in C/C++.  
        To get the same functionality from pascal or assembly, you need
        to test if URLGetURLAccessVersion function is not NULL.  For instance:
        
            gURLAccessAvailable = FALSE;
            IF @URLAccessAvailable <> kUnresolvedCFragSymbolAddress THEN
                gURLAccessAvailable = TRUE;
            END
    
    }
{$ELSEC}
  {$IFC TARGET_RT_MAC_MACHO }
{ URL Access is always available on OS X }
  {$ENDC}
{$ENDC}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	URLNotifyProcPtr = FUNCTION(userContext: UNIV Ptr; event: URLEvent; VAR callbackInfo: URLCallbackInfo): OSStatus;
{$ELSEC}
	URLNotifyProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	URLSystemEventProcPtr = FUNCTION(userContext: UNIV Ptr; VAR event: EventRecord): OSStatus;
{$ELSEC}
	URLSystemEventProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	URLNotifyUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	URLNotifyUPP = URLNotifyProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	URLSystemEventUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	URLSystemEventUPP = URLSystemEventProcPtr;
{$ENDC}	

CONST
	uppURLNotifyProcInfo = $00000FF0;
	uppURLSystemEventProcInfo = $000003F0;
	{
	 *  NewURLNotifyUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewURLNotifyUPP(userRoutine: URLNotifyProcPtr): URLNotifyUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewURLSystemEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewURLSystemEventUPP(userRoutine: URLSystemEventProcPtr): URLSystemEventUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeURLNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeURLNotifyUPP(userUPP: URLNotifyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeURLSystemEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeURLSystemEventUPP(userUPP: URLSystemEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeURLNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeURLNotifyUPP(userContext: UNIV Ptr; event: URLEvent; VAR callbackInfo: URLCallbackInfo; userRoutine: URLNotifyUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeURLSystemEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeURLSystemEventUPP(userContext: UNIV Ptr; VAR event: EventRecord; userRoutine: URLSystemEventUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  URLSimpleDownload()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLSimpleDownload(url: ConstCStringPtr; destination: FSSpecPtr; destinationHandle: Handle; openFlags: URLOpenFlags; eventProc: URLSystemEventUPP; userContext: UNIV Ptr): OSStatus;

{
 *  URLDownload()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLDownload(urlRef: URLReference; destination: FSSpecPtr; destinationHandle: Handle; openFlags: URLOpenFlags; eventProc: URLSystemEventUPP; userContext: UNIV Ptr): OSStatus;

{
 *  URLSimpleUpload()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLSimpleUpload(url: ConstCStringPtr; {CONST}VAR source: FSSpec; openFlags: URLOpenFlags; eventProc: URLSystemEventUPP; userContext: UNIV Ptr): OSStatus;

{
 *  URLUpload()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLUpload(urlRef: URLReference; {CONST}VAR source: FSSpec; openFlags: URLOpenFlags; eventProc: URLSystemEventUPP; userContext: UNIV Ptr): OSStatus;

{
 *  URLNewReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLNewReference(url: ConstCStringPtr; VAR urlRef: URLReference): OSStatus;

{
 *  URLDisposeReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLDisposeReference(urlRef: URLReference): OSStatus;

{
 *  URLOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLOpen(urlRef: URLReference; fileSpec: FSSpecPtr; openFlags: URLOpenFlags; notifyProc: URLNotifyUPP; eventRegister: URLEventMask; userContext: UNIV Ptr): OSStatus;

{
 *  URLAbort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLAbort(urlRef: URLReference): OSStatus;

{
 *  URLGetDataAvailable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLGetDataAvailable(urlRef: URLReference; VAR dataSize: Size): OSStatus;

{
 *  URLGetBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLGetBuffer(urlRef: URLReference; VAR buffer: UNIV Ptr; VAR bufferSize: Size): OSStatus;

{
 *  URLReleaseBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLReleaseBuffer(urlRef: URLReference; buffer: UNIV Ptr): OSStatus;

{
 *  URLGetProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLGetProperty(urlRef: URLReference; property: ConstCStringPtr; propertyBuffer: UNIV Ptr; bufferSize: Size): OSStatus;

{
 *  URLGetPropertySize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLGetPropertySize(urlRef: URLReference; property: ConstCStringPtr; VAR propertySize: Size): OSStatus;

{
 *  URLSetProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLSetProperty(urlRef: URLReference; property: ConstCStringPtr; propertyBuffer: UNIV Ptr; bufferSize: Size): OSStatus;

{
 *  URLGetCurrentState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLGetCurrentState(urlRef: URLReference; VAR state: URLState): OSStatus;

{
 *  URLGetError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLGetError(urlRef: URLReference; VAR urlError: OSStatus): OSStatus;

{
 *  URLIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLIdle: OSStatus;

{
 *  URLGetFileInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in URLAccessLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION URLGetFileInfo(fName: StringPtr; VAR fType: OSType; VAR fCreator: OSType): OSStatus;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := URLAccessIncludes}

{$ENDC} {__URLACCESS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
