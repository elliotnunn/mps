{
     File:       LaunchServices.p
 
     Contains:   Public interfaces for LaunchServices.framework
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT LaunchServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __LAUNCHSERVICES__}
{$SETC __LAUNCHSERVICES__ := 1}

{$I+}
{$SETC LaunchServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}



{ ======================================================================================================== }
{ LaunchServices Structures and Enums                                                                      }
{ ======================================================================================================== }


CONST
	kLSUnknownErr				= -10810;
	kLSNotAnApplicationErr		= -10811;
	kLSNotInitializedErr		= -10812;
	kLSDataUnavailableErr		= -10813;						{  e.g. no kind string }
	kLSApplicationNotFoundErr	= -10814;						{  e.g. no application claims the file }
	kLSUnknownTypeErr			= -10815;
	kLSDataTooOldErr			= -10816;
	kLSDataErr					= -10817;
	kLSLaunchInProgressErr		= -10818;						{  e.g. opening an alreay opening application }
	kLSNotRegisteredErr			= -10819;
	kLSAppDoesNotClaimTypeErr	= -10820;
	kLSAppDoesNotSupportSchemeWarning = -10821;					{  not an error, just a warning }
	kLSServerCommunicationErr	= -10822;						{  cannot set recent items }


TYPE
	LSInitializeFlags					= OptionBits;

CONST
	kLSInitializeDefaults		= $00000001;


TYPE
	LSRequestedInfo						= OptionBits;

CONST
	kLSRequestExtension			= $00000001;					{  safe to use from threads }
	kLSRequestTypeCreator		= $00000002;					{  safe to use from threads }
	kLSRequestBasicFlagsOnly	= $00000004;					{  all but type of application - safe to use from threads }
	kLSRequestAppTypeFlags		= $00000008;					{  NOT SAFE to use from threads }
	kLSRequestAllFlags			= $00000010;					{  NOT SAFE to use from threads }
	kLSRequestIconAndKind		= $00000020;					{  NOT SAFE to use from threads }
	kLSRequestAllInfo			= $FFFFFFFF;					{  NOT SAFE to use from threads }


TYPE
	LSItemInfoFlags						= OptionBits;

CONST
	kLSItemInfoIsPlainFile		= $00000001;					{  none of the following applies }
	kLSItemInfoIsPackage		= $00000002;					{  app, doc, or bundle package }
	kLSItemInfoIsApplication	= $00000004;					{  single-file or packaged }
	kLSItemInfoIsContainer		= $00000008;					{  folder or volume }
	kLSItemInfoIsAliasFile		= $00000010;					{  'real' alias }
	kLSItemInfoIsSymlink		= $00000020;					{  UNIX symbolic link only }
	kLSItemInfoIsInvisible		= $00000040;					{  does not include '.' files or '.hidden' entries }
	kLSItemInfoIsNativeApp		= $00000080;					{  Carbon or Cocoa native app }
	kLSItemInfoIsClassicApp		= $00000100;					{  CFM Classic app }
	kLSItemInfoAppPrefersNative	= $00000200;					{  Carbon app that prefers to be launched natively }
	kLSItemInfoAppPrefersClassic = $00000400;					{  Carbon app that prefers to be launched in Classic }
	kLSItemInfoAppIsScriptable	= $00000800;					{  App can be scripted }
	kLSItemInfoIsVolume			= $00001000;					{  item is a volume }


TYPE
	LSRolesMask							= OptionBits;

CONST
	kLSRolesNone				= $00000001;
	kLSRolesViewer				= $00000002;
	kLSRolesEditor				= $00000004;
	kLSRolesAll					= $FFFFFFFF;


TYPE
	LSKindID							= UInt32;

CONST
	kLSUnknownKindID			= 0;

	kLSUnknownType				= 0;
	kLSUnknownCreator			= 0;


TYPE
	LSItemInfoRecordPtr = ^LSItemInfoRecord;
	LSItemInfoRecord = RECORD
		flags:					LSItemInfoFlags;
		filetype:				OSType;
		creator:				OSType;
		extension:				CFStringRef;
		iconFileName:			CFStringRef;
		kindID:					LSKindID;
	END;

	LSAcceptanceFlags					= OptionBits;

CONST
	kLSAcceptDefault			= $00000001;
	kLSAcceptAllowLoginUI		= $00000002;


TYPE
	LSLaunchFlags						= OptionBits;

CONST
	kLSLaunchDefaults			= $00000001;					{  default = open, async, use Info.plist, start Classic }
	kLSLaunchAndPrint			= $00000002;					{  print items instead of open them }
	kLSLaunchReserved2			= $00000004;
	kLSLaunchReserved3			= $00000008;
	kLSLaunchReserved4			= $00000010;
	kLSLaunchReserved5			= $00000020;
	kLSLaunchReserved6			= $00000040;
	kLSLaunchInhibitBGOnly		= $00000080;					{  causes launch to fail if target is background-only. }
	kLSLaunchDontAddToRecents	= $00000100;					{  do not add app or documents to recents menus. }
	kLSLaunchDontSwitch			= $00000200;					{  don't bring new app to the foreground. }
	kLSLaunchNoParams			= $00000800;					{  Use Info.plist to determine launch parameters }
	kLSLaunchAsync				= $00010000;					{  launch async; obtain results from kCPSNotifyLaunch. }
	kLSLaunchStartClassic		= $00020000;					{  start up Classic environment if required for app. }
	kLSLaunchInClassic			= $00040000;					{  force app to launch in Classic environment. }
	kLSLaunchNewInstance		= $00080000;					{  Instantiate app even if it is already running. }
	kLSLaunchAndHide			= $00100000;					{  Send child a "hide" request as soon as it checks in. }
	kLSLaunchAndHideOthers		= $00200000;					{  Hide all other apps when child checks in. }


TYPE
	LSLaunchFSRefSpecPtr = ^LSLaunchFSRefSpec;
	LSLaunchFSRefSpec = RECORD
		appRef:					FSRefPtr;								{  app to use, can be NULL }
		numDocs:				UInt32;									{  items to open/print, can be NULL }
		itemRefs:				FSRefPtr;								{  array of FSRefs }
		passThruParams:			AEDescPtr;								{  passed untouched to application as optional parameter }
		launchFlags:			LSLaunchFlags;
		asyncRefCon:			Ptr;									{  used if you register for app birth/death notification }
	END;

	LSLaunchURLSpecPtr = ^LSLaunchURLSpec;
	LSLaunchURLSpec = RECORD
		appURL:					CFURLRef;								{  app to use, can be NULL }
		itemURLs:				CFArrayRef;								{  items to open/print, can be NULL }
		passThruParams:			AEDescPtr;								{  passed untouched to application as optional parameter }
		launchFlags:			LSLaunchFlags;
		asyncRefCon:			Ptr;									{  used if you register for app birth/death notification }
	END;



	{	 ======================================================================================================== 	}
	{	 LaunchServices Public Entry Points                                                                       	}
	{	 ======================================================================================================== 	}

	{
	 *  LSInit()
	 *  
	 *  Summary:
	 *    Initialize LaunchServices for use.
	 *  
	 *  Discussion:
	 *    LSInit is optional but should be called by top level applications
	 *    to explicitly incur any startup costs at a known time. Frameworks
	 *    and libraries need never call LSInit.
	 *  
	 *  Parameters:
	 *    
	 *    inFlags:
	 *      Use kLSInitializeDefaults.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available in CarbonLib 1.x
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION LSInit(inFlags: LSInitializeFlags): OSStatus;


{
 *  LSTerm()
 *  
 *  Summary:
 *    Terminate LaunchServices use.
 *  
 *  Discussion:
 *    LSTerm is optional but should be called by top level applications
 *    to explicitly terminate LaunchServices activity at a known time.
 *    Frameworks and libraries need never call LSTerm.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSTerm: OSStatus;


{
 *  LSCopyItemInfoForRef()
 *  
 *  Summary:
 *    Return information about an item.
 *  
 *  Discussion:
 *    Returns as much or as little information as requested about
 *    inItemRef. Some information is available in a thread-safe manner,
 *    some is not. All CFStrings must be released after use.
 *  
 *  Parameters:
 *    
 *    inItemRef:
 *      The FSRef of the item about which information is requested.
 *    
 *    inWhichInfo:
 *      Flags indicating which information to return
 *    
 *    outItemInfo:
 *      Information is returned in this structure. Must not be NULL
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSCopyItemInfoForRef({CONST}VAR inItemRef: FSRef; inWhichInfo: LSRequestedInfo; VAR outItemInfo: LSItemInfoRecord): OSStatus;


{
 *  LSCopyItemInfoForURL()
 *  
 *  Summary:
 *    Return information about an item.
 *  
 *  Discussion:
 *    Returns as much or as little information as requested about
 *    inURL. Some information is available in a thread-safe manner,
 *    some is not. All CFStrings must be released after use.
 *  
 *  Parameters:
 *    
 *    inURL:
 *      The CFURLRef of the item about which information is requested.
 *    
 *    inWhichInfo:
 *      Flags indicating which information to return
 *    
 *    outItemInfo:
 *      Information is returned in this structure. Must not be NULL
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSCopyItemInfoForURL(inURL: CFURLRef; inWhichInfo: LSRequestedInfo; VAR outItemInfo: LSItemInfoRecord): OSStatus;


{
 *  LSCopyKindStringForRef()
 *  
 *  Summary:
 *    Get the kind string for an item.
 *  
 *  Discussion:
 *    Returns the kind string as used in the Finder and elsewhere for
 *    inFSRef. The CFStringRef must be released after use.
 *  
 *  Parameters:
 *    
 *    inFSRef:
 *      The item for which the kind string is requested.
 *    
 *    outKindString:
 *      A non-NULL CFStringRef* into which the kind string will be
 *      copied. This CFStringRef must be released after use.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSCopyKindStringForRef({CONST}VAR inFSRef: FSRef; VAR outKindString: CFStringRef): OSStatus;


{
 *  LSCopyKindStringForURL()
 *  
 *  Summary:
 *    Get the kind string for an item.
 *  
 *  Discussion:
 *    Returns the kind string as used in the Finder and elsewhere for
 *    inURL. The CFStringRef must be released after use.
 *  
 *  Parameters:
 *    
 *    inURL:
 *      The item for which the kind string is requested.
 *    
 *    outKindString:
 *      A non-NULL CFStringRef* into which the kind string will be
 *      copied. This CFStringRef must be released after use.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSCopyKindStringForURL(inURL: CFURLRef; VAR outKindString: CFStringRef): OSStatus;


{
 *  LSGetApplicationForItem()
 *  
 *  Summary:
 *    Return the application used to open an item.
 *  
 *  Discussion:
 *    Consults the binding tables to return the application that would
 *    be used to open inItemRef if it were double-clicked in the
 *    Finder. This application will be the user-specified override if
 *    appropriate or the default otherwise. If no application is known
 *    to LaunchServices suitable for opening this item,
 *    kLSApplicationNotFoundErr will be returned.
 *  
 *  Parameters:
 *    
 *    inItemRef:
 *      The FSRef of the item for which the application is requested.
 *    
 *    inRoleMask:
 *      Whether to return the editor or viewer for inItemRef. If you
 *      don't care which, use kLSRolesAll.
 *    
 *    outAppRef:
 *      Filled in with the FSRef of the application if not NULL.
 *    
 *    outAppURL:
 *      Filled in with the CFURLRef of the application if not NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSGetApplicationForItem({CONST}VAR inItemRef: FSRef; inRoleMask: LSRolesMask; outAppRef: FSRefPtr; outAppURL: CFURLRefPtr): OSStatus;


{
 *  LSGetApplicationForInfo()
 *  
 *  Summary:
 *    Return the application used to open items with particular data.
 *  
 *  Discussion:
 *    Consults the binding tables to return the application that would
 *    be used to open items with type, creator, and/or extension as
 *    provided if they were double-clicked in the Finder. This
 *    application will be the default for items like this if one has
 *    been set. If no application is known to LaunchServices suitable
 *    for opening such items, kLSApplicationNotFoundErr will be
 *    returned. Not all three input parameters can be NULL at the same
 *    time nor can both output parameters be NULL at the same time.
 *  
 *  Parameters:
 *    
 *    inType:
 *      The file type to consider. Can be kLSUnknownType.
 *    
 *    inCreator:
 *      The file creator to consider. Can be kLSUnknownCreator.
 *    
 *    inExtension:
 *      The file name extension to consider. Can be NULL.
 *    
 *    inRoleMask:
 *      Whether to return the editor or viewer for inItemRef. If you
 *      don't care which, use kLSRolesAll.
 *    
 *    outAppRef:
 *      Filled in with the FSRef of the application if not NULL.
 *    
 *    outAppURL:
 *      Filled in with the CFURLRef of the application if not NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSGetApplicationForInfo(inType: OSType; inCreator: OSType; inExtension: CFStringRef; inRoleMask: LSRolesMask; outAppRef: FSRefPtr; outAppURL: CFURLRefPtr): OSStatus;


{
 *  LSGetApplicationForURL()
 *  
 *  Summary:
 *    Return the application used to open an item.
 *  
 *  Discussion:
 *    Consults the binding tables to return the application that would
 *    be used to open inURL if it were double-clicked in the Finder.
 *    This application will be the user-specified override if
 *    appropriate or the default otherwise. If no application is known
 *    to LaunchServices suitable for opening this item,
 *    kLSApplicationNotFoundErr will be returned.
 *  
 *  Parameters:
 *    
 *    inURL:
 *      The CFURLRef of the item for which the application is requested.
 *    
 *    inRoleMask:
 *      Whether to return the editor or viewer for inItemRef. If you
 *      don't care which, use kLSRolesAll.
 *    
 *    outAppRef:
 *      Filled in with the FSRef of the application if not NULL.
 *    
 *    outAppURL:
 *      Filled in with the CFURLRef of the application if not NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSGetApplicationForURL(inURL: CFURLRef; inRoleMask: LSRolesMask; VAR outAppRef: FSRef; VAR outAppURL: CFURLRef): OSStatus;


{
 *  LSFindApplicationForInfo()
 *  
 *  Summary:
 *    Locate a specific application.
 *  
 *  Discussion:
 *    Returns the application with the corresponding input information.
 *    The registry of applications is consulted first in order of
 *    bundleID, then creator, then name. All comparisons are case
 *    insensitive and 'ties' are decided first by version, then by
 *    native vs. Classic.
 *  
 *  Parameters:
 *    
 *    inCreator:
 *      The file creator to consider. Can be kLSUnknownCreator.
 *    
 *    inBundleID:
 *      The bundle ID to consider. Can be NULL.
 *    
 *    inName:
 *      The name to consider. Can be NULL. Must include any extensions
 *      that are part of the file system name, e.g. '.app'.
 *    
 *    outAppRef:
 *      Filled in with the FSRef of the application if not NULL.
 *    
 *    outAppURL:
 *      Filled in with the CFURLRef of the application if not NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSFindApplicationForInfo(inCreator: OSType; inBundleID: CFStringRef; inName: CFStringRef; outAppRef: FSRefPtr; outAppURL: CFURLRefPtr): OSStatus;


{
 *  LSCanRefAcceptItem()
 *  
 *  Summary:
 *    Determine whether an item can accept another item.
 *  
 *  Discussion:
 *    Returns in outAcceptsItem whether inTargetRef can accept
 *    inItemFSRef as in a drag and drop operation. If inRoleMask is
 *    other than kLSRolesAll then make sure inTargetRef claims to
 *    fulfill the requested role.
 *  
 *  Parameters:
 *    
 *    inItemFSRef:
 *      FSRef of the item about which acceptance is requested.
 *    
 *    inTargetRef:
 *      FSRef of the potential target.
 *    
 *    inRoleMask:
 *      The role(s) the target must claim in order to consider
 *      acceptance.
 *    
 *    inFlags:
 *      Use kLSAcceptDefault.
 *    
 *    outAcceptsItem:
 *      Filled in with result. Must not be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSCanRefAcceptItem({CONST}VAR inItemFSRef: FSRef; {CONST}VAR inTargetRef: FSRef; inRoleMask: LSRolesMask; inFlags: LSAcceptanceFlags; VAR outAcceptsItem: BOOLEAN): OSStatus;


{
 *  LSCanURLAcceptURL()
 *  
 *  Summary:
 *    Determine whether an item can accept another item.
 *  
 *  Discussion:
 *    Returns in outAcceptsItem whether inTargetURL can accept
 *    inItemURL as in a drag and drop operation. If inRoleMask is other
 *    than kLSRolesAll then make sure inTargetRef claims to fulfill the
 *    requested role.
 *  
 *  Parameters:
 *    
 *    inItemURL:
 *      CFURLRef of the item about which acceptance is requested.
 *    
 *    inTargetURL:
 *      CFURLRef of the potential target.
 *    
 *    inRoleMask:
 *      The role(s) the target must claim in order to consider
 *      acceptance.
 *    
 *    inFlags:
 *      Use kLSAcceptDefault.
 *    
 *    outAcceptsItem:
 *      Filled in with result. Must not be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSCanURLAcceptURL(inItemURL: CFURLRef; inTargetURL: CFURLRef; inRoleMask: LSRolesMask; inFlags: LSAcceptanceFlags; VAR outAcceptsItem: BOOLEAN): OSStatus;


{
 *  LSOpenFSRef()
 *  
 *  Summary:
 *    Open an application, document, or folder.
 *  
 *  Discussion:
 *    Opens applications, documents, and folders. Applications are
 *    opened via an 'oapp' or 'rapp' event. Documents are opened in
 *    their user-overridden or default applications as appropriate.
 *    Folders are opened in the Finder. Use the more specific
 *    LSOpenFromRefSpec for more control over launching.
 *  
 *  Parameters:
 *    
 *    inRef:
 *      The FSRef of the item to launch.
 *    
 *    outLaunchedRef:
 *      The FSRef of the item actually launched. For inRefs that are
 *      documents, outLaunchedRef will be the application used to
 *      launch the document. Can be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSOpenFSRef({CONST}VAR inRef: FSRef; outLaunchedRef: FSRefPtr): OSStatus;


{
 *  LSOpenCFURLRef()
 *  
 *  Summary:
 *    Open an application, document, or folder.
 *  
 *  Discussion:
 *    Opens applications, documents, and folders. Applications are
 *    opened via an 'oapp' or 'rapp' event. Documents are opened in
 *    their user-overridden or default applications as appropriate.
 *    Folders are opened in the Finder. Use the more specific
 *    LSOpenFromURLSpec for more control over launching.
 *  
 *  Parameters:
 *    
 *    inURL:
 *      The CFURLRef of the item to launch.
 *    
 *    outLaunchedURL:
 *      The CFURLRef of the item actually launched. For inURLs that are
 *      documents, outLaunchedURL will be the application used to
 *      launch the document. Can be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSOpenCFURLRef(inURL: CFURLRef; outLaunchedURL: CFURLRefPtr): OSStatus;


{
 *  LSOpenFromRefSpec()
 *  
 *  Summary:
 *    Opens an application or one or more documents or folders.
 *  
 *  Discussion:
 *    Opens applications, documents, and folders.
 *  
 *  Parameters:
 *    
 *    inLaunchSpec:
 *      The specification of what to launch and how to launch it.
 *    
 *    outLaunchedRef:
 *      The FSRef of the item actually launched. For inRefs that are
 *      documents, outLaunchedRef will be the application used to
 *      launch the document. Can be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSOpenFromRefSpec({CONST}VAR inLaunchSpec: LSLaunchFSRefSpec; outLaunchedRef: FSRefPtr): OSStatus;


{
 *  LSOpenFromURLSpec()
 *  
 *  Summary:
 *    Opens an application or one or more documents or folders.
 *  
 *  Discussion:
 *    Opens applications, documents, and folders.
 *  
 *  Parameters:
 *    
 *    inLaunchSpec:
 *      The specification of what to launch and how to launch it.
 *    
 *    outLaunchedURL:
 *      The CFURLRef of the item actually launched. For inURLs that are
 *      documents, outLaunchedURL will be the application used to
 *      launch the document. Can be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSOpenFromURLSpec({CONST}VAR inLaunchSpec: LSLaunchURLSpec; outLaunchedURL: CFURLRefPtr): OSStatus;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := LaunchServicesIncludes}

{$ENDC} {__LAUNCHSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
