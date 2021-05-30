{
 	File:		Folders.p
 
 	Contains:	Folder Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	MixedMode.p													}
{	OSUtils.p													}
{		Memory.p												}
{	Finder.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kOnSystemDisk				= $8000;
	kCreateFolder				= true;
	kDontCreateFolder			= false;
	kSystemFolderType			= 'macs';						{ the system folder }
	kDesktopFolderType			= 'desk';						{ the desktop folder; objects in this folder show on the desk top. }
	kTrashFolderType			= 'trsh';						{ the trash folder; objects in this folder show up in the trash }
	kWhereToEmptyTrashFolderType = 'empt';						{ the "empty trash" folder; Finder starts empty from here down }
	kPrintMonitorDocsFolderType	= 'prnt';						{ Print Monitor documents }
	kStartupFolderType			= 'strt';						{ Finder objects (applications, documents, DAs, aliases, to...) to open at startup go here }
	kShutdownFolderType			= 'shdf';						{ Finder objects (applications, documents, DAs, aliases, to...) to open at shutdown go here }
	kAppleMenuFolderType		= 'amnu';						{ Finder objects to put into the Apple menu go here }
	kControlPanelFolderType		= 'ctrl';						{ Control Panels go here (may contain INITs) }
	kExtensionFolderType		= 'extn';						{ Finder extensions go here }
	kFontsFolderType			= 'font';						{ Fonts go here }
	kPreferencesFolderType		= 'pref';						{ preferences for applications go here }
	kTemporaryFolderType		= 'temp';

{$IFC SystemSevenOrLater }

FUNCTION FindFolder(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $A823;
	{$ENDC}
{$ELSEC}

FUNCTION FindFolder(vRefNum: INTEGER; folderType: OSType; createFolder: BOOLEAN; VAR foundVRefNum: INTEGER; VAR foundDirID: LONGINT): OSErr;
{$ENDC}
FUNCTION ReleaseFolder(vRefNum: INTEGER; folderType: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $A823;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FoldersIncludes}

{$ENDC} {__FOLDERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
