/*
 	File:		ControlStrip.h
 
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
 
*/

#ifndef __CONTROLSTRIP__
#define __CONTROLSTRIP__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __MENUS__
#include <Menus.h>
#endif
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Controls.h>										*/
/*	#include <Windows.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*	#include <TextEdit.h>										*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	sdevInitModule				= 0,							/* initialize the module*/
	sdevCloseModule				= 1,							/* clean up before being closed*/
	sdevFeatures				= 2,							/* return feature bits*/
	sdevGetDisplayWidth			= 3,							/* returns the width of the module's display*/
	sdevPeriodicTickle			= 4,							/* periodic tickle when nothing else is happening*/
	sdevDrawStatus				= 5,							/* update the interface in the Control Strip*/
	sdevMouseClick				= 6,							/* user clicked on the module's display area in the Control Strip*/
	sdevSaveSettings			= 7,							/* saved any changed settings in module's preferences file*/
	sdevShowBalloonHelp			= 8								/* puts up a help balloon, if the module has one to display*/
};

/*********************************************************************************************

	Features supported by the module.  If a bit is set, it means that feature is supported.
	All undefined bits are reserved for future use by Apple, and should be set to zero.

*********************************************************************************************/
enum {
	sdevWantMouseClicks			= 0,							/* notify the module of mouseDown events*/
	sdevDontAutoTrack			= 1,							/* call the module to do mouse tracking*/
	sdevHasCustomHelp			= 2,							/* module provides its own help messages*/
	sdevKeepModuleLocked		= 3								/* module needs to be locked in the heap*/
};

/*********************************************************************************************

	Result values returned by the sdevPeriodicTickle and sdevIconMouseClick selectors.
	If a bit is set, the module can request that a specific function is performed by
	the Control Strip.  A result of zero will do nothing.  All undefined bits are reserved
	for future use by Apple, and should be set to zero.

*********************************************************************************************/
enum {
	sdevResizeDisplay			= 0,							/* resize the module's display*/
	sdevNeedToSave				= 1,							/* need to save changed settings, when convenient*/
	sdevHelpStateChange			= 2,							/* need to update the help message because of a state change*/
	sdevCloseNow				= 3								/* close a module because it doesn't want to stay around*/
};

/*********************************************************************************************

	miscellaneous

*********************************************************************************************/
enum {
	sdevFileType				= 'sdev'
};

enum {
	sdevMenuItemMark			= '•'
};

/*	direction values for SBDrawBarGraph*/
enum {
	BarGraphSlopeLeft			= -1,							/* max end of sloping bar graph is on the left*/
	BarGraphFlatRight			= 0,							/* max end of flat bar graph is on the right*/
	BarGraphSlopeRight			= 1								/* max end of sloping bar graph is on the right*/
};

/*********************************************************************************************

	utility routines to provide standard interface elements and support for common functions

*********************************************************************************************/
extern pascal Boolean SBIsControlStripVisible(void)
 TWOWORDINLINE(0x7000, 0xAAF2);
extern pascal void SBShowHideControlStrip(Boolean showIt)
 THREEWORDINLINE(0x303C, 0x0101, 0xAAF2);
extern pascal Boolean SBSafeToAccessStartupDisk(void)
 TWOWORDINLINE(0x7002, 0xAAF2);
extern pascal short SBOpenModuleResourceFile(OSType fileCreator)
 THREEWORDINLINE(0x303C, 0x0203, 0xAAF2);
extern pascal OSErr SBLoadPreferences(ConstStr255Param prefsResourceName, Handle *preferences)
 THREEWORDINLINE(0x303C, 0x0404, 0xAAF2);
extern pascal OSErr SBSavePreferences(ConstStr255Param prefsResourceName, Handle preferences)
 THREEWORDINLINE(0x303C, 0x0405, 0xAAF2);
extern pascal void SBGetDetachedIndString(StringPtr theString, Handle stringList, short whichString)
 THREEWORDINLINE(0x303C, 0x0506, 0xAAF2);
extern pascal OSErr SBGetDetachIconSuite(Handle *theIconSuite, short theResID, unsigned long selector)
 THREEWORDINLINE(0x303C, 0x0507, 0xAAF2);
extern pascal short SBTrackPopupMenu(const Rect *moduleRect, MenuHandle theMenu)
 THREEWORDINLINE(0x303C, 0x0408, 0xAAF2);
extern pascal short SBTrackSlider(const Rect *moduleRect, short ticksOnSlider, short initialValue)
 THREEWORDINLINE(0x303C, 0x0409, 0xAAF2);
extern pascal OSErr SBShowHelpString(const Rect *moduleRect, StringPtr helpString)
 THREEWORDINLINE(0x303C, 0x040A, 0xAAF2);
extern pascal short SBGetBarGraphWidth(short barCount)
 THREEWORDINLINE(0x303C, 0x010B, 0xAAF2);
extern pascal void SBDrawBarGraph(short level, short barCount, short direction, Point barGraphTopLeft)
 THREEWORDINLINE(0x303C, 0x050C, 0xAAF2);
extern pascal void SBModalDialogInContext(ModalFilterUPP filterProc, short *itemHit)
 THREEWORDINLINE(0x303C, 0x040D, 0xAAF2);
/* The following routines are available in Control Strip 1.2 and later. */
extern pascal OSErr SBGetControlStripFontID(short *fontID)
 THREEWORDINLINE(0x303C, 0x020E, 0xAAF2);
extern pascal OSErr SBSetControlStripFontID(short fontID)
 THREEWORDINLINE(0x303C, 0x010F, 0xAAF2);
extern pascal OSErr SBGetControlStripFontSize(short *fontSize)
 THREEWORDINLINE(0x303C, 0x0210, 0xAAF2);
extern pascal OSErr SBSetControlStripFontSize(short fontSize)
 THREEWORDINLINE(0x303C, 0x0111, 0xAAF2);
extern pascal OSErr SBGetShowHideHotKey(short *modifiers, unsigned char *keyCode)
 THREEWORDINLINE(0x303C, 0x0412, 0xAAF2);
extern pascal OSErr SBSetShowHideHotKey(short modifiers, unsigned char keyCode)
 THREEWORDINLINE(0x303C, 0x0213, 0xAAF2);
extern pascal OSErr SBIsShowHideHotKeyEnabled(Boolean *enabled)
 THREEWORDINLINE(0x303C, 0x0214, 0xAAF2);
extern pascal OSErr SBEnableShowHideHotKey(Boolean enabled)
 THREEWORDINLINE(0x303C, 0x0115, 0xAAF2);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CONTROLSTRIP__ */
