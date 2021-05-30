/*
 	File:		TerminalTools.h
 
 	Contains:	Communications Toolbox Terminal tools Interfaces.
 
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

#ifndef __TERMINALTOOLS__
#define __TERMINALTOOLS__


#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Errors.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <Memory.h>											*/
/*		#include <Types.h>										*/
/*		#include <MixedMode.h>									*/
/*	#include <Menus.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <Controls.h>										*/
/*	#include <Windows.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*	#include <TextEdit.h>										*/

#ifndef __TERMINALS__
#include <Terminals.h>
#endif
/*	#include <CTBUtilities.h>									*/
/*		#include <StandardFile.h>								*/
/*			#include <Files.h>									*/
/*				#include <Finder.h>								*/
/*		#include <AppleTalk.h>									*/
/*	#include <Connections.h>									*/

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
	tdefType					= 'tdef',
	tvalType					= 'tval',
	tsetType					= 'tset',
	tlocType					= 'tloc',
	tscrType					= 'tscr',
	tbndType					= 'tbnd',
	tverType					= 'vers',
/* messages */
	tmInitMsg					= 0,
	tmDisposeMsg				= 1,
	tmSuspendMsg				= 2,
	tmResumeMsg					= 3,
	tmMenuMsg					= 4,
	tmEventMsg					= 5,
	tmActivateMsg				= 6,
	tmDeactivateMsg				= 7,
	tmGetErrorStringMsg			= 8,
	tmIdleMsg					= 50,
	tmResetMsg					= 51,
	tmKeyMsg					= 100,
	tmStreamMsg					= 101,
	tmResizeMsg					= 102,
	tmUpdateMsg					= 103,
	tmClickMsg					= 104,
	tmGetSelectionMsg			= 105,
	tmSetSelectionMsg			= 106,
	tmScrollMsg					= 107,
	tmClearMsg					= 108
};

enum {
	tmGetLineMsg				= 109,
	tmPaintMsg					= 110,
	tmCursorMsg					= 111,
	tmGetEnvironsMsg			= 112,
	tmDoTermKeyMsg				= 113,
	tmCountTermKeysMsg			= 114,
	tmGetIndTermKeyMsg			= 115,
/* messages for validate DefProc    */
	tmValidateMsg				= 0,
	tmDefaultMsg				= 1,
/* messages for Setup DefProc    */
	tmSpreflightMsg				= 0,
	tmSsetupMsg					= 1,
	tmSitemMsg					= 2,
	tmSfilterMsg				= 3,
	tmScleanupMsg				= 4,
/* messages for scripting defProc    */
	tmMgetMsg					= 0,
	tmMsetMsg					= 1,
/* messages for localization defProc  */
	tmL2English					= 0,
	tmL2Intl					= 1
};

typedef struct TMSearchBlock TMSearchBlock, *TMSearchBlockPtr;

struct TMSearchBlock {
	StringHandle					theString;
	Rect							where;
	TMSearchTypes					searchType;
	TerminalSearchCallBackUPP		callBack;
	short							refnum;
	TMSearchBlockPtr				next;
};
typedef struct TMSetupStruct TMSetupStruct, *TMSetupPtr;

struct TMSetupStruct {
	DialogPtr						theDialog;
	short							count;
	Ptr								theConfig;
	short							procID;						/* procID of the tool */
};

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __TERMINALTOOLS__ */
