{
     File:       QTML.p
 
     Contains:   QuickTime Cross-platform specific interfaces
 
     Version:    Technology: QuickTime 5.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QTML;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QTML__}
{$SETC __QTML__ := 1}

{$I+}
{$SETC QTMLIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MACMEMORY__}
{$I MacMemory.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }
{
 *  QTMLYieldCPU()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLYieldCPU;

{
 *  QTMLYieldCPUTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLYieldCPUTime(milliSeconds: LONGINT; flags: UInt32);

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	QTMLMutex    = ^LONGINT; { an opaque 32-bit type }
	QTMLMutexPtr = ^QTMLMutex;  { when a VAR xx:QTMLMutex parameter can be nil, it is changed to xx: QTMLMutexPtr }
{$IFC NOT (TARGET_OS_MAC AND TARGET_API_MAC_OS8) }
	QTMLSyncVar    = ^LONGINT; { an opaque 32-bit type }
	QTMLSyncVarPtr = ^QTMLSyncVar;  { when a VAR xx:QTMLSyncVar parameter can be nil, it is changed to xx: QTMLSyncVarPtr }

CONST
	kInitializeQTMLNoSoundFlag	= $00000001;					{  flag for requesting no sound when calling InitializeQTML }
	kInitializeQTMLUseGDIFlag	= $00000002;					{  flag for requesting GDI when calling InitializeQTML }
	kInitializeQTMLDisableDirectSound = $00000004;				{  disables QTML's use of DirectSound }
	kInitializeQTMLUseExclusiveFullScreenModeFlag = $00000008;	{  later than QTML 3.0: qtml starts up in exclusive full screen mode }
	kInitializeQTMLDisableDDClippers = $00000010;				{  flag for requesting QTML not to use DirectDraw clipper objects; QTML 5.0 and later }

	kQTMLHandlePortEvents		= $00000001;					{  flag for requesting requesting QTML to handle events }
	kQTMLNoIdleEvents			= $00000002;					{  flag for requesting requesting QTML not to send Idle Events }

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  InitializeQTML()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION InitializeQTML(flag: LONGINT): OSErr;

{
 *  TerminateQTML()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE TerminateQTML;


{
 *  CreatePortAssociation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION CreatePortAssociation(theWnd: UNIV Ptr; storage: Ptr; flags: LONGINT): GrafPtr;

{
 *  DestroyPortAssociation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DestroyPortAssociation(cgp: CGrafPtr);


{
 *  QTMLGrabMutex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLGrabMutex(mu: QTMLMutex);

{
 *  QTMLTryGrabMutex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION QTMLTryGrabMutex(mu: QTMLMutex): BOOLEAN;

{
 *  QTMLReturnMutex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLReturnMutex(mu: QTMLMutex);

{
 *  QTMLCreateMutex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMLCreateMutex: QTMLMutex;

{
 *  QTMLDestroyMutex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLDestroyMutex(mu: QTMLMutex);


{
 *  QTMLCreateSyncVar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMLCreateSyncVar: QTMLSyncVarPtr;

{
 *  QTMLDestroySyncVar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLDestroySyncVar(p: QTMLSyncVarPtr);

{
 *  QTMLTestAndSetSyncVar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMLTestAndSetSyncVar(sync: QTMLSyncVarPtr): LONGINT;

{
 *  QTMLWaitAndSetSyncVar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLWaitAndSetSyncVar(sync: QTMLSyncVarPtr);

{
 *  QTMLResetSyncVar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLResetSyncVar(sync: QTMLSyncVarPtr);


{
 *  InitializeQHdr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE InitializeQHdr(VAR qhdr: QHdr);

{
 *  TerminateQHdr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE TerminateQHdr(VAR qhdr: QHdr);


{
 *  QTMLAcquireWindowList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLAcquireWindowList;

{
 *  QTMLReleaseWindowList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLReleaseWindowList;

{
   These routines are here to support "interrupt level" code
      These are dangerous routines, only use if you know what you are doing.
}

{
 *  QTMLRegisterInterruptSafeThread()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMLRegisterInterruptSafeThread(threadID: UInt32; threadInfo: UNIV Ptr): LONGINT;

{
 *  QTMLUnregisterInterruptSafeThread()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMLUnregisterInterruptSafeThread(threadID: UInt32): LONGINT;


{
 *  NativeEventToMacEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NativeEventToMacEvent(nativeEvent: UNIV Ptr; VAR macEvent: EventRecord): LONGINT;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC TARGET_OS_WIN32 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  WinEventToMacEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION WinEventToMacEvent(winMsg: UNIV Ptr; VAR macEvent: EventRecord): LONGINT;

{
 *  IsTaskBarVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION IsTaskBarVisible: BOOLEAN;

{
 *  ShowHideTaskBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ShowHideTaskBar(showIt: BOOLEAN);

{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kDDSurfaceLocked			= $00000001;
	kDDSurfaceStatic			= $00000002;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  QTGetDDObject()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION QTGetDDObject(VAR lpDDObject: UNIV Ptr): OSErr;

{
 *  QTSetDDObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTSetDDObject(lpNewDDObject: UNIV Ptr): OSErr;

{
 *  QTSetDDPrimarySurface()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTSetDDPrimarySurface(lpNewDDSurface: UNIV Ptr; flags: UInt32): OSErr;


{
 *  QTMLGetVolumeRootPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMLGetVolumeRootPath(fullPath: CStringPtr; volumeRootPath: CStringPtr; volumeRootLen: UInt32): OSErr;


{
 *  QTMLSetWindowWndProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE QTMLSetWindowWndProc(theWindow: WindowRef; windowProc: UNIV Ptr);

{
 *  QTMLGetWindowWndProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMLGetWindowWndProc(theWindow: WindowRef): Ptr;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}
{$IFC CALL_NOT_IN_CARBON }
{
 *  QTMLGetCanonicalPathName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMLGetCanonicalPathName(inName: CStringPtr; outName: CStringPtr; outLen: UInt32): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kFullNativePath				= 0;
	kFileNameOnly				= $01;
	kDirectoryPathOnly			= $02;
	kUFSFullPathName			= $04;
	kTryVDIMask					= $08;							{     Used in NativePathNameToFSSpec to specify to search VDI mountpoints }
	kFullPathSpecifiedMask		= $10;							{     the passed in name is a fully qualified full path }

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  FSSpecToNativePathName()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION FSSpecToNativePathName({CONST}VAR inFile: FSSpec; outName: CStringPtr; outLen: UInt32; flags: LONGINT): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kErrorIfFileNotFound		= $80000000;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NativePathNameToFSSpec()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION NativePathNameToFSSpec(inName: CStringPtr; VAR outFile: FSSpec; flags: LONGINT): OSErr;

{
 *  QTGetAliasInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION QTGetAliasInfo(alias: AliasHandle; index: AliasInfoType; outBuf: CStringPtr; bufLen: LONGINT; VAR outLen: LONGINT; flags: UInt32): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QTMLIncludes}

{$ENDC} {__QTML__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
