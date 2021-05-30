{
     File:       Finder.p
 
     Contains:   Finder flags and container types.
 
     Version:    Technology: Mac OS 8.5
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
 UNIT Finder;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FINDER__}
{$SETC __FINDER__ := 1}

{$I+}
{$SETC FinderIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Creator and type of clipping files }

CONST
	kClippingCreator			= 'drag';
	kClippingPictureType		= 'clpp';
	kClippingTextType			= 'clpt';
	kClippingSoundType			= 'clps';
	kClippingUnknownType		= 'clpu';


	{	 Creator and type of Internet Location files 	}
	kInternetLocationCreator	= 'drag';
	kInternetLocationHTTP		= 'ilht';
	kInternetLocationFTP		= 'ilft';
	kInternetLocationFile		= 'ilfi';
	kInternetLocationMail		= 'ilma';
	kInternetLocationNNTP		= 'ilnw';
	kInternetLocationAFP		= 'ilaf';
	kInternetLocationAppleTalk	= 'ilat';
	kInternetLocationNSL		= 'ilns';
	kInternetLocationGeneric	= 'ilge';



	kCustomIconResource			= -16455;						{  Custom icon family resource ID  }

	{	 In order to specify any of the information described in the 	}
	{	 CustomBadgeResource data structure you must clear the kExtendedFlagsAreInvalid 	}
	{	 and set kExtendedFlagHasCustomBadge of the FXInfo.fdXFlags or DXInfo.frXFlags field, 	}
	{	 and add a resource of type kCustomBadgeResourceType and ID kCustomBadgeResourceID to 	}
	{	 the file or to the "Icon/n" file for a folder 	}
	kCustomBadgeResourceType	= 'badg';
	kCustomBadgeResourceID		= -16455;
	kCustomBadgeResourceVersion	= 0;


TYPE
	CustomBadgeResourcePtr = ^CustomBadgeResource;
	CustomBadgeResource = RECORD
		version:				SInt16;									{  This is version kCustomBadgeResourceVersion }
		customBadgeResourceID:	SInt16;									{  If not 0, the ID of a resource to use on top }
																		{  of the icon for this file or folder }
		customBadgeType:		OSType;									{  If not 0, the type and creator of an icon }
		customBadgeCreator:		OSType;									{  to use on top of the icon }
		windowBadgeType:		OSType;									{  If not 0, the type and creator of an icon }
		windowBadgeCreator:		OSType;									{  to display in the header of the window for this  }
																		{  file or folder }
		overrideType:			OSType;									{  If not 0, the type and creator of an icon to }
		overrideCreator:		OSType;									{  use INSTEAD of the icon for this file or folder }
	END;

	CustomBadgeResourceHandle			= ^CustomBadgeResourcePtr;
	{	 You can specify routing information for a file by including a 'rout' 0 
	    resource in it and setting the kExtendedFlagHasRoutingInfo bit in the extended 
	    Finder flags. 
	    The 'rout' resource is an array of RoutingResourceEntry. Each entry is considered
	    in turn. The first matching entry is used.
	    If the creator and fileType match the file being dropped and targetFolder match
	    the folder ID of the folder being dropped onto, then the file is rerouted 
	    into the specified destination folder.
	    The only target folder currently supported is the system folder, 
	    kSystemFolderType = 'macs'.
		}

CONST
	kRoutingResourceType		= 'rout';
	kRoutingResourceID			= 0;


TYPE
	RoutingResourceEntryPtr = ^RoutingResourceEntry;
	RoutingResourceEntry = RECORD
		creator:				OSType;									{  Use '****' or 0 to match any creator  }
		fileType:				OSType;									{  Use '****' or 0 to match any file type  }
		targetFolder:			OSType;									{  Folder ID of the folder this file was dropped onto  }
		destinationFolder:		OSType;									{  Folder that the source will be routed to  }
		reservedField:			OSType;									{  Set to 0  }
	END;

	RoutingResourcePtr					= ^RoutingResourceEntry;
	RoutingResourceHandle				= ^RoutingResourcePtr;

	{	 Types for special container aliases 	}

CONST
	kContainerFolderAliasType	= 'fdrp';						{  type for folder aliases  }
	kContainerTrashAliasType	= 'trsh';						{  type for trash folder aliases  }
	kContainerHardDiskAliasType	= 'hdsk';						{  type for hard disk aliases  }
	kContainerFloppyAliasType	= 'flpy';						{  type for floppy aliases  }
	kContainerServerAliasType	= 'srvr';						{  type for server aliases  }
	kApplicationAliasType		= 'adrp';						{  type for application aliases  }
	kContainerAliasType			= 'drop';						{  type for all other containers  }
	kDesktopPrinterAliasType	= 'dtpa';						{  type for Desktop Printer alias  }
	kContainerCDROMAliasType	= 'cddr';						{  type for CD-ROM alias  }
	kApplicationCPAliasType		= 'acdp';						{  type for application control panel alias  }
	kApplicationDAAliasType		= 'addp';						{  type for application DA alias  }
	kPackageAliasType			= 'fpka';						{  type for plain package alias  }
	kAppPackageAliasType		= 'fapa';						{  type for application package alias  }

	{	 Types for Special folder aliases 	}
	kSystemFolderAliasType		= 'fasy';
	kAppleMenuFolderAliasType	= 'faam';
	kStartupFolderAliasType		= 'fast';
	kPrintMonitorDocsFolderAliasType = 'fapn';
	kPreferencesFolderAliasType	= 'fapf';
	kControlPanelFolderAliasType = 'fact';
	kExtensionFolderAliasType	= 'faex';

	{	 Types for AppleShare folder aliases 	}
	kExportedFolderAliasType	= 'faet';
	kDropFolderAliasType		= 'fadr';
	kSharedFolderAliasType		= 'fash';
	kMountedFolderAliasType		= 'famn';

	{	 Finder flags (finderFlags, fdFlags and frFlags) 	}
	{	 Any flag reserved or not specified should be set to 0. 	}
	{	 If a flag applies to a file, but not to a folder, make sure to check 	}
	{	 that the item is not a folder by checking ((ParamBlockRec.ioFlAttrib & ioDirMask) == 0) 	}
	kIsOnDesk					= $0001;						{  Files and folders (System 6)  }
	kColor						= $000E;						{  Files and folders  }
																{  bit 0x0020 was kRequireSwitchLaunch, but is now reserved for future use }
	kIsShared					= $0040;						{  Files only (Applications only)  }
																{  If clear, the application needs to write to  }
																{  its resource fork, and therefore cannot be  }
																{  shared on a server  }
	kHasNoINITs					= $0080;						{  Files only (Extensions/Control Panels only)  }
																{  This file contains no INIT resource  }
	kHasBeenInited				= $0100;						{  Files only  }
																{  Clear if the file contains desktop database  }
																{  resources ('BNDL', 'FREF', 'open', 'kind'...)  }
																{  that have not been added yet. Set only by the Finder  }
																{  Reserved for folders - make sure this bit is cleared for folders  }
																{  bit 0x0200 was the letter bit for AOCE, but is now reserved for future use  }
	kHasCustomIcon				= $0400;						{  Files and folders  }
	kIsStationery				= $0800;						{  Files only  }
	kNameLocked					= $1000;						{  Files and folders  }
	kHasBundle					= $2000;						{  Files only  }
	kIsInvisible				= $4000;						{  Files and folders  }
	kIsAlias					= $8000;						{  Files only  }

	{	 Obsolete. Use names defined above. 	}
	fOnDesk						= $0001;
	fHasBundle					= $2000;
	fInvisible					= $4000;

	{	 Obsolete 	}
	fTrash						= -3;
	fDesktop					= -2;
	fDisk						= 0;

{$IFC OLDROUTINENAMES }
	kIsStationary				= $0800;

{$ENDC}  {OLDROUTINENAMES}

	{	 Extended flags (extendedFinderFlags, fdXFlags and frXFlags) 	}
	{	 Any flag not specified should be set to 0. 	}
	kExtendedFlagsAreInvalid	= $8000;						{  If set the other extended flags are ignored  }
	kExtendedFlagHasCustomBadge	= $0100;						{  Set if the file or folder has a badge resource  }
	kExtendedFlagHasRoutingInfo	= $0004;						{  Set if the file contains routing info resource  }



	{	 Use a filetype in this range to indicate that a file is temporarily busy 	}
	{	 (while it is being downloaded or installed, for example).  This prevents 	}
	{	 Finder 8.5 and later from trying to change the item's attributes before it 	}
	{	 is fully created. -- If you provide a series of 'BNDL' icons for your creator 	}
	{	 and some of these filetypes, you can achieve limited icon animation while 	}
	{	 the file creation progresses. 	}
	kFirstMagicBusyFiletype		= 'bzy ';
	kLastMagicBusyFiletype		= 'bzy?';

	{	 Use this date as a file's or folder's creation date to indicate that it is 	}
	{	 temporarily busy (while it is being downloaded or installed, for example). 	}
	{	 This prevents Finder from trying to change the item's attributes before it 	}
	{	 is fully created (Finder 8.5 and 8.6 check file creation dates; later Finders 	}
	{	 may check folder creation dates as well). 	}
	kMagicBusyCreationDate		= $4F3AFDB0;


	{	------------------------------------------------------------------------	}
	{
	   The following data structures are binary compatible with FInfo, DInfo,
	   FXInfo and DXInfo but represent the Mac OS 8 semantic of the fields.
	   Use these data structures preferably to FInfo, etc...
	}
	{	------------------------------------------------------------------------	}


TYPE
	FileInfoPtr = ^FileInfo;
	FileInfo = RECORD
		fileType:				OSType;									{  The type of the file  }
		fileCreator:			OSType;									{  The file's creator  }
		finderFlags:			UInt16;									{  ex: kHasBundle, kIsInvisible...  }
		location:				Point;									{  File's location in the folder  }
																		{  If set to (0, 0), the Finder will place the item automatically  }
		reservedField:			UInt16;									{  (set to 0)  }
	END;

	FolderInfoPtr = ^FolderInfo;
	FolderInfo = RECORD
		windowBounds:			Rect;									{  The position and dimension of the folder's window  }
		finderFlags:			UInt16;									{  ex. kIsInvisible, kNameLocked, etc. }
		location:				Point;									{  Folder's location in the parent folder  }
																		{  If set to (0, 0), the Finder will place the item automatically  }
		reservedField:			UInt16;									{  (set to 0)  }
	END;

	ExtendedFileInfoPtr = ^ExtendedFileInfo;
	ExtendedFileInfo = RECORD
		reserved1:				ARRAY [0..3] OF SInt16;					{  Reserved (set to 0)  }
		extendedFinderFlags:	UInt16;									{  Extended flags (custom badge, routing info...)  }
		reserved2:				SInt16;									{  Reserved (set to 0). Comment ID if high-bit is clear  }
		putAwayFolderID:		SInt32;									{  Put away folder ID  }
	END;

	ExtendedFolderInfoPtr = ^ExtendedFolderInfo;
	ExtendedFolderInfo = RECORD
		scrollPosition:			Point;									{  Scroll position (for icon views)  }
		reserved1:				SInt32;									{  Reserved (set to 0)  }
		extendedFinderFlags:	UInt16;									{  Extended flags (custom badge, routing info...)  }
		reserved2:				SInt16;									{  Reserved (set to 0). Comment ID if high-bit is clear  }
		putAwayFolderID:		SInt32;									{  Put away folder ID  }
	END;

	{	------------------------------------------------------------------------	}
	{
	   The following data structures are here for compatibility.
	   Use the new data structures replacing them if possible (i.e. FileInfo 
	   instead of FInfo, etc...)
	}
	{	------------------------------------------------------------------------	}
	{	 File info 	}
	{
	     IMPORTANT:
	     In MacOS 8, the fdFldr field has become reserved for the Finder.
	}
	FInfoPtr = ^FInfo;
	FInfo = RECORD
		fdType:					OSType;									{  The type of the file  }
		fdCreator:				OSType;									{  The file's creator  }
		fdFlags:				UInt16;									{  Flags ex. kHasBundle, kIsInvisible, etc.  }
		fdLocation:				Point;									{  File's location in folder.  }
																		{  If set to (0, 0), the Finder will place the item automatically  }
		fdFldr:					SInt16;									{  Reserved (set to 0)  }
	END;

	{	 Extended file info 	}
	{
	     IMPORTANT:
	     In MacOS 8, the fdIconID and fdComment fields were changed
	     to become reserved fields for the Finder.
	     The fdScript has become an extended flag.
	}
	FXInfoPtr = ^FXInfo;
	FXInfo = RECORD
		fdIconID:				SInt16;									{  Reserved (set to 0)  }
		fdReserved:				ARRAY [0..2] OF SInt16;					{  Reserved (set to 0)  }
		fdScript:				SInt8;									{  Extended flags. Script code if high-bit is set  }
		fdXFlags:				SInt8;									{  Extended flags  }
		fdComment:				SInt16;									{  Reserved (set to 0). Comment ID if high-bit is clear  }
		fdPutAway:				SInt32;									{  Put away folder ID  }
	END;

	{	 Folder info 	}
	{
	     IMPORTANT:
	     In MacOS 8, the frView field was changed to become reserved 
	     field for the Finder.
	}
	DInfoPtr = ^DInfo;
	DInfo = RECORD
		frRect:					Rect;									{  Folder's window bounds  }
		frFlags:				UInt16;									{  Flags ex. kIsInvisible, kNameLocked, etc. }
		frLocation:				Point;									{  Folder's location in parent folder  }
																		{  If set to (0, 0), the Finder will place the item automatically  }
		frView:					SInt16;									{  Reserved (set to 0)  }
	END;

	{	 Extended folder info 	}
	{
	     IMPORTANT:
	     In MacOS 8, the frOpenChain and frComment fields were changed
	     to become reserved fields for the Finder.
	     The frScript has become an extended flag.
	}
	DXInfoPtr = ^DXInfo;
	DXInfo = RECORD
		frScroll:				Point;									{  Scroll position  }
		frOpenChain:			SInt32;									{  Reserved (set to 0)  }
		frScript:				SInt8;									{  Extended flags. Script code if high-bit is set  }
		frXFlags:				SInt8;									{  Extended flags  }
		frComment:				SInt16;									{  Reserved (set to 0). Comment ID if high-bit is clear  }
		frPutAway:				SInt32;									{  Put away folder ID  }
	END;

	{  ControlPanelDefProcPtr and cdev constants have all been moved to Processes.i }
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FinderIncludes}

{$ENDC} {__FINDER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
