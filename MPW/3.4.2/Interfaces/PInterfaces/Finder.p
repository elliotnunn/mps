{
 	File:		Finder.p
 
 	Contains:	Finder flags and container types.
 
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
 UNIT Finder;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FINDER__}
{$SETC __FINDER__ := 1}

{$I+}
{$SETC FinderIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ Make only the following consts avaiable to resource files that include this file }
	kCustomIconResource			= -16455;						{ Custom icon family resource ID }
	kContainerFolderAliasType	= 'fdrp';						{ type for folder aliases }
	kContainerTrashAliasType	= 'trsh';						{ type for trash folder aliases }
	kContainerHardDiskAliasType	= 'hdsk';						{ type for hard disk aliases }
	kContainerFloppyAliasType	= 'flpy';						{ type for floppy aliases }
	kContainerServerAliasType	= 'srvr';						{ type for server aliases }
	kApplicationAliasType		= 'adrp';						{ type for application aliases }
	kContainerAliasType			= 'drop';						{ type for all other containers }
{ types for Special folder aliases }
	kSystemFolderAliasType		= 'fasy';
	kAppleMenuFolderAliasType	= 'faam';
	kStartupFolderAliasType		= 'fast';
	kPrintMonitorDocsFolderAliasType = 'fapn';
	kPreferencesFolderAliasType	= 'fapf';
	kControlPanelFolderAliasType = 'fact';
	kExtensionFolderAliasType	= 'faex';
{ types for AppleShare folder aliases }
	kExportedFolderAliasType	= 'faet';
	kDropFolderAliasType		= 'fadr';
	kSharedFolderAliasType		= 'fash';
	kMountedFolderAliasType		= 'famn';

{ Finder Flags }
	kIsOnDesk					= $1;
	kColor						= $E;
	kIsShared					= $40;
	kHasBeenInited				= $100;
	kHasCustomIcon				= $400;
	kIsStationery				= $800;
	kIsStationary				= $800;
	kNameLocked					= $1000;
	kHasBundle					= $2000;
	kIsInvisible				= $4000;
	kIsAlias					= $8000;

{	
	The following declerations used to be in Files.i, 
	but are Finder specific and were moved here.
}
{$IFC NOT OLDROUTINELOCATIONS }
{ Finder Constants }
	fOnDesk						= 1;
	fHasBundle					= 8192;
	fTrash						= -3;
	fDesktop					= -2;
	fDisk						= 0;


TYPE
	FInfo = RECORD
		fdType:					OSType;									{the type of the file}
		fdCreator:				OSType;									{file's creator}
		fdFlags:				INTEGER;								{flags ex. hasbundle,invisible,locked, etc.}
		fdLocation:				Point;									{file's location in folder}
		fdFldr:					INTEGER;								{folder containing file}
	END;

	FXInfo = RECORD
		fdIconID:				INTEGER;								{Icon ID}
		fdUnused:				ARRAY [0..2] OF INTEGER;				{unused but reserved 6 bytes}
		fdScript:				SInt8;									{Script flag and number}
		fdXFlags:				SInt8;									{More flag bits}
		fdComment:				INTEGER;								{Comment ID}
		fdPutAway:				LONGINT;								{Home Dir ID}
	END;

	DInfo = RECORD
		frRect:					Rect;									{folder rect}
		frFlags:				INTEGER;								{Flags}
		frLocation:				Point;									{folder location}
		frView:					INTEGER;								{folder view}
	END;

	DXInfo = RECORD
		frScroll:				Point;									{scroll position}
		frOpenChain:			LONGINT;								{DirID chain of open folders}
		frScript:				SInt8;									{Script flag and number}
		frXFlags:				SInt8;									{More flag bits}
		frComment:				INTEGER;								{comment}
		frPutAway:				LONGINT;								{DirID}
	END;

{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FinderIncludes}

{$ENDC} {__FINDER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
