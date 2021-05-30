/*
 	File:		ASDebugging.h
 
 	Contains:	AppleScript Debugging Interfaces.
 
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

#ifndef __ASDEBUGGING__
#define __ASDEBUGGING__


#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*		#include <ConditionalMacros.h>							*/
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

#ifndef __APPLESCRIPT__
#include <AppleScript.h>
#endif
/*	#include <OSA.h>											*/
/*		#include <AEObjects.h>									*/
/*		#include <Components.h>									*/
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
/* 	This mode flag can be passed to OSASetProperty or OSASetHandler
		and will prevent properties or handlers from being defined in a context
		that doesn't already have bindings for them. An error is returned if
		a current binding doesn't already exist. */
	kOSAModeDontDefine			= 0x0001
};

/**************************************************************************
	Component Selectors
**************************************************************************/
enum {
	kASSelectSetPropertyObsolete = 0x1101,
	kASSelectGetPropertyObsolete = 0x1101,
	kASSelectSetHandlerObsolete	= 0x1103,
	kASSelectGetHandlerObsolete	= 0x1104,
	kASSelectGetAppTerminologyObsolete = 0x1105,
	kASSelectSetProperty		= 0x1106,
	kASSelectGetProperty		= 0x1107,
	kASSelectSetHandler			= 0x1108,
	kASSelectGetHandler			= 0x1109,
	kASSelectGetAppTerminology	= 0x110A,
	kASSelectGetSysTerminology	= 0x110B,
	kASSelectGetPropertyNames	= 0x110C,
	kASSelectGetHandlerNames	= 0x110D
};

/**************************************************************************
	Context Accessors
**************************************************************************/
extern pascal OSAError OSASetProperty(ComponentInstance scriptingComponent, long modeFlags, OSAID contextID, const AEDesc *variableName, OSAID scriptValueID)
 FIVEWORDINLINE(0x2F3C, 16, 0x1106, 0x7000, 0xA82A);
extern pascal OSAError OSAGetProperty(ComponentInstance scriptingComponent, long modeFlags, OSAID contextID, const AEDesc *variableName, OSAID *resultingScriptValueID)
 FIVEWORDINLINE(0x2F3C, 16, 0x1107, 0x7000, 0xA82A);
extern pascal OSAError OSAGetPropertyNames(ComponentInstance scriptingComponent, long modeFlags, OSAID contextID, AEDescList *resultingPropertyNames)
 FIVEWORDINLINE(0x2F3C, 12, 0x110C, 0x7000, 0xA82A);
extern pascal OSAError OSASetHandler(ComponentInstance scriptingComponent, long modeFlags, OSAID contextID, const AEDesc *handlerName, OSAID compiledScriptID)
 FIVEWORDINLINE(0x2F3C, 16, 0x1108, 0x7000, 0xA82A);
extern pascal OSAError OSAGetHandler(ComponentInstance scriptingComponent, long modeFlags, OSAID contextID, const AEDesc *handlerName, OSAID *resultingCompiledScriptID)
 FIVEWORDINLINE(0x2F3C, 16, 0x1109, 0x7000, 0xA82A);
extern pascal OSAError OSAGetHandlerNames(ComponentInstance scriptingComponent, long modeFlags, OSAID contextID, AEDescList *resultingHandlerNames)
 FIVEWORDINLINE(0x2F3C, 12, 0x110D, 0x7000, 0xA82A);
extern pascal OSAError OSAGetAppTerminology(ComponentInstance scriptingComponent, long modeFlags, FSSpec *fileSpec, short terminologyID, Boolean *didLaunch, AEDesc *terminologyList)
 FIVEWORDINLINE(0x2F3C, 18, 0x110A, 0x7000, 0xA82A);
/* Errors:
	   errOSASystemError		operation failed
	*/
extern pascal OSAError OSAGetSysTerminology(ComponentInstance scriptingComponent, long modeFlags, short terminologyID, AEDesc *terminologyList)
 FIVEWORDINLINE(0x2F3C, 10, 0x110B, 0x7000, 0xA82A);
/* Errors:
	   errOSASystemError		operation failed
	*/
/* Notes on terminology ID

	A terminology ID is derived from script code and language code
	as follows;

		terminologyID = ((scriptCode & 0x7F) << 8) | (langCode & 0xFF)
*/
/**************************************************************************
	Obsolete versions provided for backward compatibility:
*/
extern pascal OSAError ASSetProperty(ComponentInstance scriptingComponent, OSAID contextID, const AEDesc *variableName, OSAID scriptValueID)
 FIVEWORDINLINE(0x2F3C, 12, 0x1101, 0x7000, 0xA82A);
extern pascal OSAError ASGetProperty(ComponentInstance scriptingComponent, OSAID contextID, const AEDesc *variableName, OSAID *resultingScriptValueID)
 FIVEWORDINLINE(0x2F3C, 12, 0x1101, 0x7000, 0xA82A);
extern pascal OSAError ASSetHandler(ComponentInstance scriptingComponent, OSAID contextID, const AEDesc *handlerName, OSAID compiledScriptID)
 FIVEWORDINLINE(0x2F3C, 12, 0x1103, 0x7000, 0xA82A);
extern pascal OSAError ASGetHandler(ComponentInstance scriptingComponent, OSAID contextID, const AEDesc *handlerName, OSAID *resultingCompiledScriptID)
 FIVEWORDINLINE(0x2F3C, 12, 0x1104, 0x7000, 0xA82A);
extern pascal OSAError ASGetAppTerminology(ComponentInstance scriptingComponent, FSSpec *fileSpec, short terminologID, Boolean *didLaunch, AEDesc *terminologyList)
 FIVEWORDINLINE(0x2F3C, 14, 0x1105, 0x7000, 0xA82A);
/* Errors:
		errOSASystemError		operation failed
	*/
/**************************************************************************/

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __ASDEBUGGING__ */
