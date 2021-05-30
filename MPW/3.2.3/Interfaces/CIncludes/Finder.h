
/************************************************************

Created: Wednesday, November 27, 1991 at 11:28 AM
 Finder.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc. 1990-1991
  All rights reserved

************************************************************/


#ifndef __FINDER__
#define __FINDER__





/* make only the following consts avaiable to resource files that include this file */

#define kCustomIconResource -16455			/* Custom icon family resource ID */

#define kContainerFolderAliasType 'fdrp'	/* type for folder aliases */
#define kContainerTrashAliasType 'trsh'		/* type for trash folder aliases */
#define kContainerHardDiskAliasType 'hdsk'	/* type for hard disk aliases */
#define kContainerFloppyAliasType 'flpy'	/* type for floppy aliases */
#define kContainerServerAliasType 'srvr'	/* type for server aliases */
#define kApplicationAliasType 'adrp'		/* type for application aliases */
#define kContainerAliasType 'drop'			/* type for all other containers */

/* type for Special folder aliases */
#define kSystemFolderAliasType 'fasy'
#define kAppleMenuFolderAliasType 'faam'
#define kStartupFolderAliasType 'fast'
#define kPrintMonitorDocsFolderAliasType 'fapn'
#define kPreferencesFolderAliasType 'fapf'
#define kControlPanelFolderAliasType 'fact'
#define kExtensionFolderAliasType 'faex'

/* type for AppleShare folder aliases */
#define kExportedFolderAliasType 'faet'
#define kDropFolderAliasType 'fadr'
#define kSharedFolderAliasType 'fash'
#define kMountedFolderAliasType 'famn'


/*Finder Flags*/
#define kIsOnDesk 0x1
#define kColor 0xE

/*kColorReserved = $10
kRequiresSwitchLaunch = $20*/

#define kIsShared 0x40

/*kHasNoINITs = $80*/

#define kHasBeenInited 0x100

/*kReserved = $200*/

#define kHasCustomIcon 0x400
#define kIsStationary 0x800
#define kNameLocked 0x1000
#define kHasBundle 0x2000
#define kIsInvisible 0x4000
#define kIsAlias 0x8000



#endif
