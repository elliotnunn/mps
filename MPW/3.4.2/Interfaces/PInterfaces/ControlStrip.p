{
 	File:		ControlStrip.p
 
 	Contains:	Control Strip (for Powerbooks and Duos) Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
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
 UNIT ControlStrip;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CONTROLSTRIP__}
{$SETC __CONTROLSTRIP__ := 1}

{$I+}
{$SETC ControlStripIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{	Memory.p													}
{		MixedMode.p												}
{	Quickdraw.p													}
{		QuickdrawText.p											}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	Errors.p													}
{	Controls.p													}
{	Windows.p													}
{		Events.p												}
{			OSUtils.p											}
{	TextEdit.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	sdevInitModule				= 0;							{ initialize the module}
	sdevCloseModule				= 1;							{ clean up before being closed}
	sdevFeatures				= 2;							{ return feature bits}
	sdevGetDisplayWidth			= 3;							{ returns the width of the module's display}
	sdevPeriodicTickle			= 4;							{ periodic tickle when nothing else is happening}
	sdevDrawStatus				= 5;							{ update the interface in the Control Strip}
	sdevMouseClick				= 6;							{ user clicked on the module's display area in the Control Strip}
	sdevSaveSettings			= 7;							{ saved any changed settings in module's preferences file}
	sdevShowBalloonHelp			= 8;							{ puts up a help balloon, if the module has one to display}

{********************************************************************************************

	Features supported by the module.  If a bit is set, it means that feature is supported.
	All undefined bits are reserved for future use by Apple, and should be set to zero.

********************************************************************************************}
	sdevWantMouseClicks			= 0;							{ notify the module of mouseDown events}
	sdevDontAutoTrack			= 1;							{ call the module to do mouse tracking}
	sdevHasCustomHelp			= 2;							{ module provides its own help messages}
	sdevKeepModuleLocked		= 3;							{ module needs to be locked in the heap}

{********************************************************************************************

	Result values returned by the sdevPeriodicTickle and sdevIconMouseClick selectors.
	If a bit is set, the module can request that a specific function is performed by
	the Control Strip.  A result of zero will do nothing.  All undefined bits are reserved
	for future use by Apple, and should be set to zero.

********************************************************************************************}
	sdevResizeDisplay			= 0;							{ resize the module's display}
	sdevNeedToSave				= 1;							{ need to save changed settings, when convenient}
	sdevHelpStateChange			= 2;							{ need to update the help message because of a state change}
	sdevCloseNow				= 3;							{ close a module because it doesn't want to stay around}

{********************************************************************************************

	miscellaneous

********************************************************************************************}
	sdevFileType				= 'sdev';

	sdevMenuItemMark			= '•';

{	direction values for SBDrawBarGraph}
	BarGraphSlopeLeft			= -1;							{ max end of sloping bar graph is on the left}
	BarGraphFlatRight			= 0;							{ max end of flat bar graph is on the right}
	BarGraphSlopeRight			= 1;							{ max end of sloping bar graph is on the right}

{********************************************************************************************

	utility routines to provide standard interface elements and support for common functions

********************************************************************************************}

FUNCTION SBIsControlStripVisible: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $AAF2;
	{$ENDC}
PROCEDURE SBShowHideControlStrip(showIt: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0101, $AAF2;
	{$ENDC}
FUNCTION SBSafeToAccessStartupDisk: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $AAF2;
	{$ENDC}
FUNCTION SBOpenModuleResourceFile(fileCreator: OSType): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0203, $AAF2;
	{$ENDC}
FUNCTION SBLoadPreferences(prefsResourceName: ConstStr255Param; VAR preferences: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0404, $AAF2;
	{$ENDC}
FUNCTION SBSavePreferences(prefsResourceName: ConstStr255Param; preferences: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0405, $AAF2;
	{$ENDC}
PROCEDURE SBGetDetachedIndString(theString: StringPtr; stringList: Handle; whichString: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0506, $AAF2;
	{$ENDC}
FUNCTION SBGetDetachIconSuite(VAR theIconSuite: Handle; theResID: INTEGER; selector: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0507, $AAF2;
	{$ENDC}
FUNCTION SBTrackPopupMenu({CONST}VAR moduleRect: Rect; theMenu: MenuHandle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0408, $AAF2;
	{$ENDC}
FUNCTION SBTrackSlider({CONST}VAR moduleRect: Rect; ticksOnSlider: INTEGER; initialValue: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0409, $AAF2;
	{$ENDC}
FUNCTION SBShowHelpString({CONST}VAR moduleRect: Rect; helpString: StringPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040A, $AAF2;
	{$ENDC}
FUNCTION SBGetBarGraphWidth(barCount: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $010B, $AAF2;
	{$ENDC}
PROCEDURE SBDrawBarGraph(level: INTEGER; barCount: INTEGER; direction: INTEGER; barGraphTopLeft: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $050C, $AAF2;
	{$ENDC}
PROCEDURE SBModalDialogInContext(filterProc: ModalFilterUPP; VAR itemHit: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040D, $AAF2;
	{$ENDC}
{ The following routines are available in Control Strip 1.2 and later. }
FUNCTION SBGetControlStripFontID(VAR fontID: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020E, $AAF2;
	{$ENDC}
FUNCTION SBSetControlStripFontID(fontID: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $010F, $AAF2;
	{$ENDC}
FUNCTION SBGetControlStripFontSize(VAR fontSize: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0210, $AAF2;
	{$ENDC}
FUNCTION SBSetControlStripFontSize(fontSize: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0111, $AAF2;
	{$ENDC}
FUNCTION SBGetShowHideHotKey(VAR modifiers: INTEGER; VAR keyCode: CHAR): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0412, $AAF2;
	{$ENDC}
FUNCTION SBSetShowHideHotKey(modifiers: INTEGER; keyCode: ByteParameter): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0213, $AAF2;
	{$ENDC}
FUNCTION SBIsShowHideHotKeyEnabled(VAR enabled: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0214, $AAF2;
	{$ENDC}
FUNCTION SBEnableShowHideHotKey(enabled: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0115, $AAF2;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ControlStripIncludes}

{$ENDC} {__CONTROLSTRIP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
