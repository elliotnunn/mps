
{
Created: Tuesday, September 10, 1991 at 2:03 PM
 Icons.p
 Pascal Interface to the Macintosh Libraries

  Copyright Apple Computer, Inc. 1990-1991
  All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Icons;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingIcons}
{$SETC UsingIcons := 1}


CONST

{ The following are icons for which there are both icon suites and SICNs. }
genericDocumentIconResource = -4000;
genericStationeryIconResource = -3985;
genericEditionFileIconResource = -3989;
genericApplicationIconResource = -3996;
genericDeskAccessoryIconResource = -3991;

genericFolderIconResource = -3999;
privateFolderIconResource = -3994;

floppyIconResource = -3998;
trashIconResource = -3993;

{ The following are icons for which there are SICNs only. }
desktopIconResource = -3992;
openFolderIconResource = -3997;
genericHardDiskIconResource = -3995;
genericFileServerIconResource = -3972;
genericSuitcaseIconResource = -3970;
genericMoverObjectIconResource = -3969;

{ The following are icons for which there are icon suites only. }
genericPreferencesIconResource = -3971;
genericQueryDocumentIconResource = -16506;
genericExtensionIconResource = -16415;

systemFolderIconResource = -3983;
appleMenuFolderIconResource = -3982;
startupFolderIconResource = -3981;
ownedFolderIconResource = -3980;
dropFolderIconResource = -3979;
sharedFolderIconResource = -3978;
mountedFolderIconResource = -3977;
controlPanelFolderIconResource = -3976;
printMonitorFolderIconResource = -3975;
preferencesFolderIconResource = -3974;
extensionsFolderIconResource = -3973;

fullTrashIconResource = -3984;

large1BitMask = 'ICN#';
large4BitData = 'icl4';
large8BitData = 'icl8';
small1BitMask = 'ics#';
small4BitData = 'ics4';
small8BitData = 'ics8';
mini1BitMask = 'icm#';
mini4BitData = 'icm4';
mini8BitData = 'icm8';


{$ENDC} { UsingIcons }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

