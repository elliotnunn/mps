/*
 	File:		ColorPickerComponents.h
 
 	Contains:	Color Picker Component Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __COLORPICKERCOMPONENTS__
#define __COLORPICKERCOMPONENTS__


#ifndef __COLORPICKER__
#include <ColorPicker.h>
#endif
/*	#include <Quickdraw.h>										*/
/*		#include <Types.h>										*/
/*			#include <ConditionalMacros.h>						*/
/*		#include <MixedMode.h>									*/
/*		#include <QuickdrawText.h>								*/
/*	#include <Windows.h>										*/
/*		#include <Memory.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*		#include <Controls.h>									*/
/*			#include <Menus.h>									*/
/*	#include <Dialogs.h>										*/
/*		#include <Errors.h>										*/
/*		#include <TextEdit.h>									*/
/*	#include <CMApplication.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <Printing.h>									*/
/*		#include <CMICCProfile.h>								*/
/*	#include <Balloons.h>										*/

#ifndef __COMPONENTS__
#include <Components.h>
#endif

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
	kPickerComponentType		= 'cpkr'
};

enum PickerMessages {
	kInitPicker,
	kTestGraphicsWorld,
	kGetDialog,
	kGetItemList,
	kGetColor,
	kSetColor,
	kEvent,
	kEdit,
	kSetVisibility,
	kDrawPicker,
	kItemHit,
	kSetBaseItem,
	kGetProfile,
	kSetProfile,
	kGetPrompt,
	kSetPrompt,
	kGetIconData,
	kGetEditMenuState,
	kSetOrigin,
	kExtractHelpItem
};

extern pascal long InitPicker(ComponentInstance thePicker, PickerInitData *data);
extern pascal DialogPtr GetDialog(ComponentInstance thePicker);
extern pascal long TestGraphicsWorld(ComponentInstance thePicker, PickerInitData *data);
extern pascal long GetTheColor(ComponentInstance thePicker, ColorType whichColor, PMColorPtr color);
extern pascal long SetTheColor(ComponentInstance thePicker, ColorType whichColor, PMColorPtr color);
extern pascal long DoEvent(ComponentInstance thePicker, EventData *data);
extern pascal long DoEdit(ComponentInstance thePicker, EditData *data);
extern pascal long SetVisibility(ComponentInstance thePicker, Boolean visible);
extern pascal long DisplayPicker(ComponentInstance thePicker);
extern pascal long ItemHit(ComponentInstance thePicker, ItemHitData *data);
extern pascal long GetItemList(ComponentInstance thePicker);
extern pascal long SetBaseItem(ComponentInstance thePicker, short baseItem);
extern pascal CMProfileHandle GetTheProfile(ComponentInstance thePicker);
extern pascal long SetTheProfile(ComponentInstance thePicker, CMProfileHandle profile);
extern pascal long GetPrompt(ComponentInstance thePicker, Str255 prompt);
extern pascal long SetPrompt(ComponentInstance thePicker, Str255 prompt);
extern pascal long GetIconData(ComponentInstance thePicker, PickerIconData *data);
extern pascal long GetEditMenuState(ComponentInstance thePicker, PickerMenuState *mState);
extern pascal long SetTheOrigin(ComponentInstance thePicker, Point where);
extern pascal long ExtractHelpItem(ComponentInstance thePicker, short itemNo, short whichMsg, HelpItemInfo *helpInfo);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __COLORPICKERCOMPONENTS__ */
