/*
	File:		ASDebugging.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __ASDEBUGGING__
#define __ASDEBUGGING__

#ifndef __APPLESCRIPT__
#include <AppleScript.h>
/*	#include <OSA.h>											*/
/*		#include <AppleEvents.h>								*/
/*			#include <Types.h>									*/
/*				#include <ConditionalMacros.h>					*/
/*				#include <MixedMode.h>							*/
/*					#include <Traps.h>							*/
/*			#include <Memory.h>									*/
/*			#include <OSUtils.h>								*/
/*			#include <Events.h>									*/
/*				#include <Quickdraw.h>							*/
/*					#include <QuickdrawText.h>					*/
/*						#include <IntlResources.h>				*/
/*			#include <EPPC.h>									*/
/*				#include <PPCToolBox.h>							*/
/*					#include <AppleTalk.h>						*/
/*				#include <Processes.h>							*/
/*					#include <Files.h>							*/
/*						#include <SegLoad.h>					*/
/*			#include <Notification.h>							*/
/*		#include <AEObjects.h>									*/
/*		#include <Components.h>									*/
/*	#include <TextEdit.h>										*/
#endif

#ifdef __cplusplus
extern "C" {
#endif

enum  {
/* 	This mode flag can be passed to OSASetProperty or OSASetHandler
		and will prevent properties or handlers from being defined in a context
		that doesn't already have bindings for them. An error is returned if
		a current binding doesn't already exist. */
	kOSAModeDontDefine			= 0x0001
};


////////////////////////////////////////////////////////////////////////////////


// Component Selectors


////////////////////////////////////////////////////////////////////////////////

#define kASSelectSetPropertyObsolete 0x1101

#define kASSelectGetPropertyObsolete 0x1102

#define kASSelectSetHandlerObsolete 0x1103

#define kASSelectGetHandlerObsolete 0x1104

#define kASSelectGetAppTerminologyObsolete 0x1105

#define kASSelectSetProperty 0x1106

#define kASSelectGetProperty 0x1107

#define kASSelectSetHandler 0x1108

#define kASSelectGetHandler 0x1109

#define kASSelectGetAppTerminology 0x110A

#define kASSelectGetSysTerminology 0x110B

#define kASSelectGetPropertyNames 0x110C

#define kASSelectGetHandlerNames 0x110D

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

// Errors:


//	errOSASystemError		operation failed

extern pascal OSAError OSAGetSysTerminology(ComponentInstance scriptingComponent, long modeFlags, short terminologyID, AEDesc *terminologyList)
 FIVEWORDINLINE(0x2F3C, 10, 0x110B, 0x7000, 0xA82A);

// Errors:


//	errOSASystemError		operation failed


// Notes on terminology ID


//


// A terminology ID is derived from script code and language code


// as follows;


//


//		terminologyID = ((scriptCode & 0x7F) << 8) | (langCode & 0xFF)


//


////////////////////////////////////////////////////////////////////////////////


// Obsolete versions provided for backward compatibility:

extern pascal OSAError ASSetProperty(ComponentInstance scriptingComponent, OSAID contextID, const AEDesc *variableName, OSAID scriptValueID)
 FIVEWORDINLINE(0x2F3C, 12, 0x1101, 0x7000, 0xA82A);
extern pascal OSAError ASGetProperty(ComponentInstance scriptingComponent, OSAID contextID, const AEDesc *variableName, OSAID *resultingScriptValueID)
 FIVEWORDINLINE(0x2F3C, 12, 0x1102, 0x7000, 0xA82A);
extern pascal OSAError ASSetHandler(ComponentInstance scriptingComponent, OSAID contextID, const AEDesc *handlerName, OSAID compiledScriptID)
 FIVEWORDINLINE(0x2F3C, 12, 0x1103, 0x7000, 0xA82A);
extern pascal OSAError ASGetHandler(ComponentInstance scriptingComponent, OSAID contextID, const AEDesc *handlerName, OSAID *resultingCompiledScriptID)
 FIVEWORDINLINE(0x2F3C, 12, 0x1104, 0x7000, 0xA82A);
extern pascal OSAError ASGetAppTerminology(ComponentInstance scriptingComponent, FSSpec *fileSpec, short terminologID, Boolean *didLaunch, AEDesc *terminologyList)
 FIVEWORDINLINE(0x2F3C, 14, 0x1105, 0x7000, 0xA82A);

// Errors:


//	errOSASystemError		operation failed


////////////////////////////////////////////////////////////////////////////////

#ifdef __cplusplus
}
#endif

#endif

