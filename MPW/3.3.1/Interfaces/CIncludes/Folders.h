/*
	File:		Folders.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __FOLDERS__
#define __FOLDERS__

#ifndef __TYPES__
#include <Types.h>
/*	#include <ConditionalMacros.h>								*/
/*	#include <MixedMode.h>										*/
/*		#include <Traps.h>										*/
#endif

#ifndef __FILES__
#include <Files.h>
/*	#include <OSUtils.h>										*/
/*	#include <SegLoad.h>										*/
#endif

#define kCreateFolder true

#define kDontCreateFolder false

#define kSystemFolderType 'macs'

#define kDesktopFolderType 'desk'

#define kTrashFolderType 'trsh'

#define kWhereToEmptyTrashFolderType 'empt'

#define kPrintMonitorDocsFolderType 'prnt'

#define kStartupFolderType 'strt'

#define kAppleMenuFolderType 'amnu'

#define kControlPanelFolderType 'ctrl'

#define kExtensionFolderType 'extn'

#define kFontsFolderType 'font'

#define kPreferencesFolderType 'pref'

#define kTemporaryFolderType 'temp'

enum  {
	kOnSystemDisk				= 0x8000
};

#ifdef __cplusplus
extern "C" {
#endif

#if SystemSevenOrLater
extern pascal OSErr FindFolder(short vRefNum, OSType folderType, Boolean createFolder, short *foundVRefNum, long *foundDirID)
 TWOWORDINLINE(0x7000, 0xA823);
#else
extern pascal OSErr FindFolder(short vRefNum, OSType folderType, Boolean createFolder, short *foundVRefNum, long *foundDirID);
#endif

#ifdef __cplusplus
}
#endif

#endif

