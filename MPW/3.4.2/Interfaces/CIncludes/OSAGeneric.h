/*
 	File:		OSAGeneric.h
 
 	Contains:	AppleScript Generic Component Interfaces.
 
 	Version:	Technology:	AppleScript 1.1
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __OSAGENERIC__
#define __OSAGENERIC__


#ifndef __ERRORS__
#include <Errors.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Types.h>											*/
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <OSUtils.h>										*/
/*	#include <Events.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __OSA__
#include <OSA.h>
#endif
/*	#include <AEObjects.h>										*/
/*	#include <Components.h>										*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/* 	NOTE:	This interface defines a "generic scripting component."
			The Generic Scripting Component allows automatic dispatch to a
			specific scripting component that conforms to the OSA interface.
			This component supports OSA, by calling AppleScript or some other 
			scripting component.  Additionally it provides access to the default
			and the user-prefered scripting component.
*/

enum {
/* Component version this header file describes */
	kGenericComponentVersion	= 0x0100
};

enum {
	kGSSSelectGetDefaultScriptingComponent = 0x1001,
	kGSSSelectSetDefaultScriptingComponent = 0x1002,
	kGSSSelectGetScriptingComponent = 0x1003,
	kGSSSelectGetScriptingComponentFromStored = 0x1004,
	kGSSSelectGenericToRealID	= 0x1005,
	kGSSSelectRealToGenericID	= 0x1006,
	kGSSSelectOutOfRange		= 0x1007
};

typedef OSType ScriptingComponentSelector;

typedef OSAID GenericID;

/* get and set the default scripting component */
extern pascal OSAError OSAGetDefaultScriptingComponent(ComponentInstance genericScriptingComponent, ScriptingComponentSelector *scriptingSubType)
 FIVEWORDINLINE(0x2F3C, 4, 0x1001, 0x7000, 0xA82A);
extern pascal OSAError OSASetDefaultScriptingComponent(ComponentInstance genericScriptingComponent, ScriptingComponentSelector scriptingSubType)
 FIVEWORDINLINE(0x2F3C, 4, 0x1002, 0x7000, 0xA82A);
/* get a scripting component instance from its subtype code */
extern pascal OSAError OSAGetScriptingComponent(ComponentInstance genericScriptingComponent, ScriptingComponentSelector scriptingSubType, ComponentInstance *scriptingInstance)
 FIVEWORDINLINE(0x2F3C, 8, 0x1003, 0x7000, 0xA82A);
/* get a scripting component selector (subType) from a stored script */
extern pascal OSAError OSAGetScriptingComponentFromStored(ComponentInstance genericScriptingComponent, const AEDesc *scriptData, ScriptingComponentSelector *scriptingSubType)
 FIVEWORDINLINE(0x2F3C, 8, 0x1004, 0x7000, 0xA82A);
/* get a real component instance and script id from a generic id */
extern pascal OSAError OSAGenericToRealID(ComponentInstance genericScriptingComponent, OSAID *theScriptID, ComponentInstance *theExactComponent)
 FIVEWORDINLINE(0x2F3C, 8, 0x1005, 0x7000, 0xA82A);
/* get a generic id from a real component instance and script id */
extern pascal OSAError OSARealToGenericID(ComponentInstance genericScriptingComponent, OSAID *theScriptID, ComponentInstance theExactComponent)
 FIVEWORDINLINE(0x2F3C, 8, 0x1006, 0x7000, 0xA82A);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __OSAGENERIC__ */
