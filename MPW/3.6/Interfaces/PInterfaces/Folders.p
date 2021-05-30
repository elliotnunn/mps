{
     File:       Folders.p
 
     Contains:   Folder Manager Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Folders;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FOLDERS__}
{$SETC __FOLDERS__ := 1}

{$I+}
{$SETC FoldersIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kOnSystemDisk				= -32768;						{  previously was 0x8000 but that is an unsigned value whereas vRefNum is signed }
	kOnAppropriateDisk			= -32767;						{  Generally, the same as kOnSystemDisk, but it's clearer that this isn't always the 'boot' disk. }
																{  Folder Domains - Carbon only.  The constants above can continue to be used, but the folder/volume returned will }
																{  be from one of the domains below. }
	kSystemDomain				= -32766;						{  Read-only system hierarchy. }
	kLocalDomain				= -32765;						{  All users of a single machine have access to these resources. }
	kNetworkDomain				= -32764;						{  All users configured to use a common network server has access to these resources. }
	kUserDomain					= -32763;						{  Read/write. Resources that are private to the user. }
	kClassicDomain				= -32762;						{  Domain referring to the currently configured Classic System Folder }

	kCreateFolder				= true;
	kDontCreateFolder			= false;

	kSystemFolderType			= 'macs';						{  the system folder  }
	kDesktopFolderType			= 'desk';						{  the desktop folder; objects in this folder show on the desk top.  }
	kSystemDesktopFolderType	= 'sdsk';						{  the desktop folder at the root of the hard drive, never the redirected user desktop folder  }
	kTrashFolderType			= 'trsh';						{  the trash folder; objects in this folder show up in the trash  }
	kSystemTrashFolderType		= 'strs';						{  the trash folder at the root of the drive, never the redirected user trash folder  }
	kWhereToEmptyTrashFolderType = 'empt';						{  the "empty trash" folder; Finder starts empty from here down  }
	kPrintMonitorDocsFolderType	= 'prnt';						{  Print Monitor documents  }
	kStartupFolderType			= 'strt';						{  Finder objects (applications, documents, DAs, aliases, to...) to open at startup go here  }
	kShutdownFolderType			= 'shdf';						{  Finder objects (applications, documents, DAs, aliases, to...) to open at shutdown go here  }
	kAppleMenuFolderType		= 'amnu';						{  Finder objects to put into the Apple menu go here  }
	kControlPanelFolderType		= 'ctrl';						{  Control Panels go here (may contain INITs)  }
	kSystemControlPanelFolderType = 'sctl';						{  System control panels folder - never the redirected one, always "Control Panels" inside the System Folder  }
	kExtensionFolderType		= 'extn';						{  System extensions go here  }
	kFontsFolderType			= 'font';						{  Fonts go here  }
	kPreferencesFolderType		= 'pref';						{  preferences for applications go here  }
	kSystemPreferencesFolderType = 'sprf';						{  System-type Preferences go here - this is always the system's preferences folder, never a logged in user's  }
	kTemporaryFolderType		= 'temp';						{  temporary files go here (deleted periodically, but don't rely on it.)  }

	{
	 *  FindFolder()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION FindFolder(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A823;
	{$ENDC}

{
 *  FindFolderExtended()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FindFolderExtended(vol: INTEGER; foldType: OSType; createFolder: BOOLEAN; flags: UInt32; data: UNIV Ptr; VAR vRefNum: INTEGER; VAR dirID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B2C, $A823;
	{$ENDC}

{
 *  ReleaseFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReleaseFolder(vRefNum: INTEGER; folderType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $A823;
	{$ENDC}


{$IFC NOT TARGET_OS_MAC }
{ Since non-mac targets don't know about VRef's or DirID's, the Ex version returns
   the found folder path.
 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  FindFolderEx()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FindFolderEx(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT; foundFolder: CStringPtr): OSErr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
 *  FSFindFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSFindFolder(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundRef: FSRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7034, $A823;
	{$ENDC}


{
 *  FSFindFolderExtended()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSFindFolderExtended(vol: INTEGER; foldType: OSType; createFolder: BOOLEAN; flags: UInt32; data: UNIV Ptr; VAR foundRef: FSRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7035, $A823;
	{$ENDC}

{****************************************}
{ Extensible Folder Manager declarations }
{****************************************}

{**************************}
{ Folder Manager constants }
{**************************}


CONST
	kExtensionDisabledFolderType = 'extD';
	kControlPanelDisabledFolderType = 'ctrD';
	kSystemExtensionDisabledFolderType = 'macD';
	kStartupItemsDisabledFolderType = 'strD';
	kShutdownItemsDisabledFolderType = 'shdD';
	kApplicationsFolderType		= 'apps';
	kDocumentsFolderType		= 'docs';

																{  new constants  }
	kVolumeRootFolderType		= 'root';						{  root folder of a volume  }
	kChewableItemsFolderType	= 'flnt';						{  items deleted at boot  }
	kApplicationSupportFolderType = 'asup';						{  third-party items and folders  }
	kTextEncodingsFolderType	= 'ƒtex';						{  encoding tables  }
	kStationeryFolderType		= 'odst';						{  stationery  }
	kOpenDocFolderType			= 'odod';						{  OpenDoc root  }
	kOpenDocShellPlugInsFolderType = 'odsp';					{  OpenDoc Shell Plug-Ins in OpenDoc folder  }
	kEditorsFolderType			= 'oded';						{  OpenDoc editors in MacOS Folder  }
	kOpenDocEditorsFolderType	= 'ƒodf';						{  OpenDoc subfolder of Editors folder  }
	kOpenDocLibrariesFolderType	= 'odlb';						{  OpenDoc libraries folder  }
	kGenEditorsFolderType		= 'ƒedi';						{  CKH general editors folder at root level of Sys folder  }
	kHelpFolderType				= 'ƒhlp';						{  CKH help folder currently at root of system folder  }
	kInternetPlugInFolderType	= 'ƒnet';						{  CKH internet plug ins for browsers and stuff  }
	kModemScriptsFolderType		= 'ƒmod';						{  CKH modem scripts, get 'em OUT of the Extensions folder  }
	kPrinterDescriptionFolderType = 'ppdf';						{  CKH new folder at root of System folder for printer descs.  }
	kPrinterDriverFolderType	= 'ƒprd';						{  CKH new folder at root of System folder for printer drivers  }
	kScriptingAdditionsFolderType = 'ƒscr';						{  CKH at root of system folder  }
	kSharedLibrariesFolderType	= 'ƒlib';						{  CKH for general shared libs.  }
	kVoicesFolderType			= 'fvoc';						{  CKH macintalk can live here  }
	kControlStripModulesFolderType = 'sdev';					{  CKH for control strip modules  }
	kAssistantsFolderType		= 'astƒ';						{  SJF for Assistants (MacOS Setup Assistant, etc)  }
	kUtilitiesFolderType		= 'utiƒ';						{  SJF for Utilities folder  }
	kAppleExtrasFolderType		= 'aexƒ';						{  SJF for Apple Extras folder  }
	kContextualMenuItemsFolderType = 'cmnu';					{  SJF for Contextual Menu items  }
	kMacOSReadMesFolderType		= 'morƒ';						{  SJF for MacOS ReadMes folder  }
	kALMModulesFolderType		= 'walk';						{  EAS for Location Manager Module files except type 'thng' (within kExtensionFolderType)  }
	kALMPreferencesFolderType	= 'trip';						{  EAS for Location Manager Preferences (within kPreferencesFolderType; contains kALMLocationsFolderType)  }
	kALMLocationsFolderType		= 'fall';						{  EAS for Location Manager Locations (within kALMPreferencesFolderType)  }
	kColorSyncProfilesFolderType = 'prof';						{  for ColorSync™ Profiles  }
	kThemesFolderType			= 'thme';						{  for Theme data files  }
	kFavoritesFolderType		= 'favs';						{  Favorties folder for Navigation Services  }
	kInternetFolderType			= 'intƒ';						{  Internet folder (root level of startup volume)  }
	kAppearanceFolderType		= 'appr';						{  Appearance folder (root of system folder)  }
	kSoundSetsFolderType		= 'snds';						{  Sound Sets folder (in Appearance folder)  }
	kDesktopPicturesFolderType	= 'dtpƒ';						{  Desktop Pictures folder (in Appearance folder)  }
	kInternetSearchSitesFolderType = 'issf';					{  Internet Search Sites folder  }
	kFindSupportFolderType		= 'fnds';						{  Find support folder  }
	kFindByContentFolderType	= 'fbcf';						{  Find by content folder  }
	kInstallerLogsFolderType	= 'ilgf';						{  Installer Logs folder  }
	kScriptsFolderType			= 'scrƒ';						{  Scripts folder  }
	kFolderActionsFolderType	= 'fasf';						{  Folder Actions Scripts folder  }
	kLauncherItemsFolderType	= 'laun';						{  Launcher Items folder  }
	kRecentApplicationsFolderType = 'rapp';						{  Recent Applications folder  }
	kRecentDocumentsFolderType	= 'rdoc';						{  Recent Documents folder  }
	kRecentServersFolderType	= 'rsvr';						{  Recent Servers folder  }
	kSpeakableItemsFolderType	= 'spki';						{  Speakable Items folder  }
	kKeychainFolderType			= 'kchn';						{  Keychain folder  }
	kQuickTimeExtensionsFolderType = 'qtex';					{  QuickTime Extensions Folder (in Extensions folder)  }
	kDisplayExtensionsFolderType = 'dspl';						{  Display Extensions Folder (in Extensions folder)  }
	kMultiprocessingFolderType	= 'mpxf';						{  Multiprocessing Folder (in Extensions folder)  }
	kPrintingPlugInsFolderType	= 'pplg';						{  Printing Plug-Ins Folder (in Extensions folder)  }


	{	 New Folder Types to accommodate the Mac OS X Folder Manager 	}
	{	 These folder types are not applicable on Mac OS 9.          	}
	kDomainTopLevelFolderType	= 'dtop';						{  The top-level of a Folder domain, e.g. "/System" }
	kDomainLibraryFolderType	= 'dlib';						{  the Library subfolder of a particular domain }
	kColorSyncFolderType		= 'sync';						{  Contains ColorSync-related folders }
	kColorSyncCMMFolderType		= 'ccmm';						{  ColorSync CMMs }
	kColorSyncScriptingFolderType = 'cscr';						{  ColorSync Scripting support }
	kPrintersFolderType			= 'impr';						{  Contains Printing-related folders }
	kSpeechFolderType			= 'spch';						{  Contains Speech-related folders }
	kCarbonLibraryFolderType	= 'carb';						{  Contains Carbon-specific file }
	kDocumentationFolderType	= 'info';						{  Contains Documentation files (not user documents) }
	kDeveloperDocsFolderType	= 'ddoc';						{  Contains Developer Documentation files and folders }
	kDeveloperHelpFolderType	= 'devh';						{  Contains Developer Help related files }
	kISSDownloadsFolderType		= 'issd';						{  Contains Internet Search Sites downloaded from the Internet }
	kUserSpecificTmpFolderType	= 'utmp';						{  Contains temporary items created on behalf of the current user }
	kCachedDataFolderType		= 'cach';						{  Contains various cache files for different clients }
	kFrameworksFolderType		= 'fram';						{  Contains MacOS X Framework folders      }
	kPrivateFrameworksFolderType = 'pfrm';						{  Contains MacOS X Private Framework folders      }
	kClassicDesktopFolderType	= 'sdsk';						{  MacOS 9 compatible desktop folder - same as  }
																{  kSystemDesktopFolderType but with a more appropriate }
																{  name for Mac OS X code. }
	kDeveloperFolderType		= 'devf';						{  Contains MacOS X Developer Resources }
	kSystemSoundsFolderType		= 'ssnd';						{  Contains Mac OS X System Sound Files }
	kComponentsFolderType		= 'cmpd';						{  Contains Mac OS X components }
	kQuickTimeComponentsFolderType = 'wcmp';					{  Contains QuickTime components for Mac OS X }
	kCoreServicesFolderType		= 'csrv';						{  Refers to the "CoreServices" folder on Mac OS X }
	kPictureDocumentsFolderType	= 'pdoc';						{  Refers to the "Pictures" folder in a users home directory }
	kMovieDocumentsFolderType	= 'mdoc';						{  Refers to the "Movies" folder in a users home directory }
	kMusicDocumentsFolderType	= 'µdoc';						{  Refers to the "Music" folder in a users home directory }
	kInternetSitesFolderType	= 'site';						{  Refers to the "Sites" folder in a users home directory }
	kPublicFolderType			= 'pubb';						{  Refers to the "Public" folder in a users home directory }
	kAudioSupportFolderType		= 'adio';						{  Refers to the Audio support folder for Mac OS X }
	kAudioSoundsFolderType		= 'asnd';						{  Refers to the Sounds subfolder of Audio Support }
	kAudioSoundBanksFolderType	= 'bank';						{  Refers to the Banks subfolder of the Sounds Folder }
	kAudioAlertSoundsFolderType	= 'alrt';						{  Refers to the Alert Sounds subfolder of the Sound Folder }
	kAudioPlugInsFolderType		= 'aplg';						{  Refers to the Plug-ins subfolder of the Audio Folder    }
	kAudioComponentsFolderType	= 'acmp';						{  Refers to the Components subfolder of the Audio Plug-ins Folder     }
	kKernelExtensionsFolderType	= 'kext';						{  Refers to the Kernel Extensions Folder on Mac OS X }
	kDirectoryServicesFolderType = 'dsrv';						{  Refers to the Directory Services folder on Mac OS X }
	kDirectoryServicesPlugInsFolderType = 'dplg';				{  Refers to the Directory Services Plug-Ins folder on Mac OS X  }

	kLocalesFolderType			= 'ƒloc';						{  PKE for Locales folder  }
	kFindByContentPluginsFolderType = 'fbcp';					{  Find By Content Plug-ins  }

	kUsersFolderType			= 'usrs';						{  "Users" folder, contains one folder for each user.  }
	kCurrentUserFolderType		= 'cusr';						{  The folder for the currently logged on user.  }
	kCurrentUserRemoteFolderLocation = 'rusf';					{  The remote folder for the currently logged on user  }
	kCurrentUserRemoteFolderType = 'rusr';						{  The remote folder location for the currently logged on user  }
	kSharedUserDataFolderType	= 'sdat';						{  A Shared "Documents" folder, readable & writeable by all users  }
	kVolumeSettingsFolderType	= 'vsfd';						{  Volume specific user information goes here  }

	kAppleshareAutomountServerAliasesFolderType = 'srvƒ';		{  Appleshare puts volumes to automount inside this folder.  }
	kPreMacOS91ApplicationsFolderType = 'åpps';					{  The "Applications" folder, pre Mac OS 9.1  }
	kPreMacOS91InstallerLogsFolderType = 'îlgf';				{  The "Installer Logs" folder, pre Mac OS 9.1  }
	kPreMacOS91AssistantsFolderType = 'åstƒ';					{  The "Assistants" folder, pre Mac OS 9.1  }
	kPreMacOS91UtilitiesFolderType = 'ütiƒ';					{  The "Utilities" folder, pre Mac OS 9.1  }
	kPreMacOS91AppleExtrasFolderType = 'åexƒ';					{  The "Apple Extras" folder, pre Mac OS 9.1  }
	kPreMacOS91MacOSReadMesFolderType = 'µorƒ';					{  The "Mac OS ReadMes" folder, pre Mac OS 9.1  }
	kPreMacOS91InternetFolderType = 'întƒ';						{  The "Internet" folder, pre Mac OS 9.1  }
	kPreMacOS91AutomountedServersFolderType = 'ßrvƒ';			{  The "Servers" folder, pre Mac OS 9.1  }
	kPreMacOS91StationeryFolderType = 'ødst';					{  The "Stationery" folder, pre Mac OS 9.1  }

	{	 FolderDescFlags values 	}
	kCreateFolderAtBoot			= $00000002;
	kCreateFolderAtBootBit		= 1;
	kFolderCreatedInvisible		= $00000004;
	kFolderCreatedInvisibleBit	= 2;
	kFolderCreatedNameLocked	= $00000008;
	kFolderCreatedNameLockedBit	= 3;
	kFolderCreatedAdminPrivs	= $00000010;
	kFolderCreatedAdminPrivsBit	= 4;

	kFolderInUserFolder			= $00000020;
	kFolderInUserFolderBit		= 5;
	kFolderTrackedByAlias		= $00000040;
	kFolderTrackedByAliasBit	= 6;
	kFolderInRemoteUserFolderIfAvailable = $00000080;
	kFolderInRemoteUserFolderIfAvailableBit = 7;
	kFolderNeverMatchedInIdentifyFolder = $00000100;
	kFolderNeverMatchedInIdentifyFolderBit = 8;
	kFolderMustStayOnSameVolume	= $00000200;
	kFolderMustStayOnSameVolumeBit = 9;
	kFolderManagerFolderInMacOS9FolderIfMacOSXIsInstalledMask = $00000400;
	kFolderManagerFolderInMacOS9FolderIfMacOSXIsInstalledBit = 10;
	kFolderInLocalOrRemoteUserFolder = $000000A0;


TYPE
	FolderDescFlags						= UInt32;
	{	 FolderClass values 	}

CONST
	kRelativeFolder				= 'relf';
	kSpecialFolder				= 'spcf';


TYPE
	FolderClass							= OSType;
	{	 special folder locations 	}

CONST
	kBlessedFolder				= 'blsf';
	kRootFolder					= 'rotf';

	kCurrentUserFolderLocation	= 'cusf';						{     the magic 'Current User' folder location }


TYPE
	FolderType							= OSType;
	FolderLocation						= OSType;

	FolderDescPtr = ^FolderDesc;
	FolderDesc = RECORD
		descSize:				Size;
		foldType:				FolderType;
		flags:					FolderDescFlags;
		foldClass:				FolderClass;
		foldLocation:			FolderType;
		badgeSignature:			OSType;
		badgeType:				OSType;
		reserved:				UInt32;
		name:					StrFileName;							{  Str63 on MacOS }
	END;


	RoutingFlags						= UInt32;
	FolderRoutingPtr = ^FolderRouting;
	FolderRouting = RECORD
		descSize:				Size;
		fileType:				OSType;
		routeFromFolder:		FolderType;
		routeToFolder:			FolderType;
		flags:					RoutingFlags;
	END;

	{	 routing constants 	}
	{   These are bits in the .flags field of the FindFolderUserRedirectionGlobals struct }

CONST
																{     Set this bit to 1 in the .flags field of a FindFolderUserRedirectionGlobals }
																{     structure if the userName in the struct should be used as the current }
																{     "User" name }
	kFindFolderRedirectionFlagUseDistinctUserFoldersBit = 0;	{     Set this bit to 1 and the currentUserFolderVRefNum and currentUserFolderDirID }
																{     fields of the user record will get used instead of finding the user folder }
																{     with the userName field. }
	kFindFolderRedirectionFlagUseGivenVRefAndDirIDAsUserFolderBit = 1; {     Set this bit to 1 and the remoteUserFolderVRefNum and remoteUserFolderDirID }
																{     fields of the user record will get used instead of finding the user folder }
																{     with the userName field. }
	kFindFolderRedirectionFlagsUseGivenVRefNumAndDirIDAsRemoteUserFolderBit = 2;


TYPE
	FindFolderUserRedirectionGlobalsPtr = ^FindFolderUserRedirectionGlobals;
	FindFolderUserRedirectionGlobals = RECORD
		version:				UInt32;
		flags:					UInt32;
		userName:				Str31;
		userNameScript:			INTEGER;
		currentUserFolderVRefNum: INTEGER;
		currentUserFolderDirID:	LONGINT;
		remoteUserFolderVRefNum: INTEGER;
		remoteUserFolderDirID:	LONGINT;
	END;


CONST
	kFolderManagerUserRedirectionGlobalsCurrentVersion = 1;

	{
	    These are passed into FindFolderExtended(), FindFolderInternalExtended(), and
	    FindFolderNewInstallerEntryExtended() in the flags field. 
	}
	kFindFolderExtendedFlagsDoNotFollowAliasesBit = 0;
	kFindFolderExtendedFlagsDoNotUseUserFolderBit = 1;
	kFindFolderExtendedFlagsUseOtherUserRecord = $01000000;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	FolderManagerNotificationProcPtr = FUNCTION(message: OSType; arg: UNIV Ptr; userRefCon: UNIV Ptr): OSStatus;
{$ELSEC}
	FolderManagerNotificationProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	FolderManagerNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FolderManagerNotificationUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppFolderManagerNotificationProcInfo = $00000FF0;
	{
	 *  NewFolderManagerNotificationUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0.2 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewFolderManagerNotificationUPP(userRoutine: FolderManagerNotificationProcPtr): FolderManagerNotificationUPP; { old name was NewFolderManagerNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeFolderManagerNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeFolderManagerNotificationUPP(userUPP: FolderManagerNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeFolderManagerNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeFolderManagerNotificationUPP(message: OSType; arg: UNIV Ptr; userRefCon: UNIV Ptr; userRoutine: FolderManagerNotificationUPP): OSStatus; { old name was CallFolderManagerNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


CONST
	kFolderManagerNotificationMessageUserLogIn = 'log+';		{     Sent by system & third party software after a user logs in.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner }
	kFolderManagerNotificationMessagePreUserLogIn = 'logj';		{     Sent by system & third party software before a user logs in.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner }
	kFolderManagerNotificationMessageUserLogOut = 'log-';		{     Sent by system & third party software before a user logs out.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner }
	kFolderManagerNotificationMessagePostUserLogOut = 'logp';	{     Sent by system & third party software after a user logs out.  arg should point to a valid FindFolderUserRedirectionGlobals structure or nil for the owner }
	kFolderManagerNotificationDiscardCachedData = 'dche';		{     Sent by system & third party software when the entire Folder Manager cache should be flushed }
	kFolderManagerNotificationMessageLoginStartup = 'stup';		{     Sent by 'Login' application the first time it starts up after each boot }


	{   These get used in the options parameter of FolderManagerRegisterNotificationProc() }
	kDoNotRemoveWhenCurrentApplicationQuitsBit = 0;
	kDoNotRemoveWheCurrentApplicationQuitsBit = 0;				{     Going away soon, use kDoNotRemoveWheCurrentApplicationQuitsBit }

	{   These get used in the options parameter of FolderManagerCallNotificationProcs() }
	kStopIfAnyNotificationProcReturnsErrorBit = 31;

	{	*************************	}
	{	 Folder Manager routines 	}
	{	*************************	}
	{	 Folder Manager administration routines 	}
	{
	 *  AddFolderDescriptor()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AddFolderDescriptor(foldType: FolderType; flags: FolderDescFlags; foldClass: FolderClass; foldLocation: FolderLocation; badgeSignature: OSType; badgeType: OSType; name: StrFileName; replaceFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $A823;
	{$ENDC}

{
 *  GetFolderDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetFolderDescriptor(foldType: FolderType; descSize: Size; VAR foldDesc: FolderDesc): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $A823;
	{$ENDC}

{
 *  GetFolderTypes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetFolderTypes(requestedTypeCount: UInt32; VAR totalTypeCount: UInt32; VAR theTypes: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $A823;
	{$ENDC}

{
 *  RemoveFolderDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveFolderDescriptor(foldType: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $A823;
	{$ENDC}

{ legacy routines }
{
 *  GetFolderName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetFolderName(vRefNum: INTEGER; foldType: OSType; VAR foundVRefNum: INTEGER; VAR name: StrFileName): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $A823;
	{$ENDC}

{ routing routines }
{
 *  AddFolderRouting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddFolderRouting(fileType: OSType; routeFromFolder: FolderType; routeToFolder: FolderType; flags: RoutingFlags; replaceFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0926, $A823;
	{$ENDC}

{
 *  RemoveFolderRouting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveFolderRouting(fileType: OSType; routeFromFolder: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0427, $A823;
	{$ENDC}

{
 *  FindFolderRouting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FindFolderRouting(fileType: OSType; routeFromFolder: FolderType; VAR routeToFolder: FolderType; VAR flags: RoutingFlags): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0822, $A823;
	{$ENDC}

{
 *  GetFolderRoutings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetFolderRoutings(requestedRoutingCount: UInt32; VAR totalRoutingCount: UInt32; routingSize: Size; VAR theRoutings: FolderRouting): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $081E, $A823;
	{$ENDC}

{
 *  InvalidateFolderDescriptorCache()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvalidateFolderDescriptorCache(vRefNum: INTEGER; dirID: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0325, $A823;
	{$ENDC}

{
 *  IdentifyFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FoldersLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IdentifyFolder(vRefNum: INTEGER; dirID: LONGINT; VAR foldType: FolderType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $051F, $A823;
	{$ENDC}


{
 *  FolderManagerRegisterNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FolderManagerRegisterNotificationProc(notificationProc: FolderManagerNotificationUPP; refCon: UNIV Ptr; options: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $062F, $A823;
	{$ENDC}

{
 *  FolderManagerUnregisterNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FolderManagerUnregisterNotificationProc(notificationProc: FolderManagerNotificationUPP; refCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0430, $A823;
	{$ENDC}

{
 *  FolderManagerRegisterCallNotificationProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FolderManagerRegisterCallNotificationProcs(message: OSType; arg: UNIV Ptr; options: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0631, $A823;
	{$ENDC}

{*****************************}
{ MultiUser (At Ease) globals }
{*****************************}
{
   This structure has been through some evolution since the early days of At Ease 1.0.  The structure
   has been expanded (and developers should assume that it will continue this way into the future).  Older
   fields have been obsoleted as the features have changed in newer versions of the code.
}

{  Some fields in here are really only valid for the network version of Macintosh Manager }


TYPE
	MultiUserGestaltPtr = ^MultiUserGestalt;
	MultiUserGestalt = RECORD
																		{     Version 1 fields. }
		giVersion:				INTEGER;								{  structure version: 0 = invalid, 6 = OS 9 }
		giReserved0:			INTEGER;								{  [OBSOLETE with v3] giIsActive: if true then At Ease is currently running }
		giReserved1:			INTEGER;								{  [OBSOLETE] if true then auto create alias }
		giReserved2:			INTEGER;								{  [OBSOLETE with v6]  if true then request floppy on new saves }
		giReserved3:			INTEGER;								{  [OBSOLETE] if true then hypercard stacks are shown on Applications panel }
		giReserved4:			FSSpec;									{  [OBSOLETE with v6] location of At Ease Items folder }
																		{     Version 2 fields. }
		giDocsVRefNum:			INTEGER;								{  vrefnum of user's documents location (only valid if not on floppy) }
		giDocsDirID:			LONGINT;								{  directory id of user's documents folder (only valid if not on floppy) }
		giForceSaves:			INTEGER;								{  true if user is forced to save to their documents folder }
		giForceOpens:			INTEGER;								{  true if user is forced to open from their documents folder }
		giSetupName:			Str31;									{  name of current setup }
		giUserName:				Str31;									{  name of current user }
		giFrontAppName:			Str31;									{  name of the frontmost application }
		giReserved5:			INTEGER;								{  [OBSOLETE with v6] true if user has Go To Finder menu item }
		giIsOn:					INTEGER;								{  true if Multiple Users/Macintosh Manager is on right now }
																		{     Version 3 fields. }
																		{   There were no additional fields for version 3.x }
																		{     Version 4 fields. }
		giUserLoggedInType:		INTEGER;								{  0 = normal user, 1 = workgroup admin, 2 = global admin }
		giUserEncryptPwd:		PACKED ARRAY [0..15] OF CHAR;			{  encrypted user password (our digest form) }
		giUserEnvironment:		INTEGER;								{  0 = panels, 1 = normal Finder, 2 = limited/restricted Finder }
		giReserved6:			LONGINT;								{  [OBSOLETE] }
		giReserved7:			LONGINT;								{  [OBSOLETE] }
		giDisableScrnShots:		BOOLEAN;								{  true if screen shots are not allowed }
																		{     Version 5 fields. }
		giSupportsAsyncFSCalls:	BOOLEAN;								{  Finder uses this to tell if our patches support async trap patches }
		giPrefsVRefNum:			INTEGER;								{  vrefnum of preferences }
		giPrefsDirID:			LONGINT;								{  dirID of the At Ease Items folder on preferences volume }
		giUserLogInTime:		UInt32;									{  time in seconds we've been logged in (0 or 1 mean not logged in) }
		giUsingPrintQuotas:		BOOLEAN;								{  true if logged in user is using printer quotas }
		giUsingDiskQuotas:		BOOLEAN;								{  true if logged in user has disk quotas active }
																		{  Version 6 fields - As of Mac OS 9's "Multiple Users 1.0" }
		giInSystemAccess:		BOOLEAN;								{  true if system is in System Access (i.e., owner logged in) }
		giUserFolderEnabled:	BOOLEAN;								{  true if FindFolder is redirecting folders (uses giUserName for user) }
		giReserved8:			INTEGER;
		giReserved9:			LONGINT;
		giInLoginScreen:		BOOLEAN;								{  true if no user has logged in (including owner) }
																		{  May have more fields added in future, so never check for sizeof(GestaltRec) }
	END;

	MultiUserGestaltHandle				= ^MultiUserGestaltPtr;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FoldersIncludes}

{$ENDC} {__FOLDERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
