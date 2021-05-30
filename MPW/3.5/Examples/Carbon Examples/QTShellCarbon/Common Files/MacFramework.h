/*


	File:		MacFramework.h

	Contains:	Basic functions for windows, menus, and similar things.

	Written by:	Tim Monroe

	Copyright:	Copyright © 2001 by Apple Computer, Inc., All Rights Reserved.

	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
				("Apple") in consideration of your agreement to the following terms, and your
				use, installation, modification or redistribution of this Apple software
				constitutes acceptance of these terms.  If you do not agree with these terms,
				please do not use, install, modify or redistribute this Apple software.

				In consideration of your agreement to abide by the following terms, and subject
				to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
				copyrights in this original Apple software (the "Apple Software"), to use,
				reproduce, modify and redistribute the Apple Software, with or without
				modifications, in source and/or binary forms; provided that if you redistribute
				the Apple Software in its entirety and without modifications, you must retain
				this notice and the following text and disclaimers in all such redistributions of
				the Apple Software.  Neither the name, trademarks, service marks or logos of
				Apple Computer, Inc. may be used to endorse or promote products derived from the
				Apple Software without specific prior written permission from Apple.  Except as
				expressly stated in this notice, no other rights or licenses, express or implied,
				are granted by Apple herein, including but not limited to any patent rights that
				may be infringed by your derivative works or by other works in which the Apple
				Software may be incorporated.

				The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
				WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
				WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
				PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
				COMBINATION WITH YOUR PRODUCTS.

				IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
				CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
				GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
				ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
				OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
				(INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
				ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#pragma once


//////////
//	   
// header files
//	   
//////////

#ifdef __MRC__

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif

#ifndef __CONTROLDEFINITIONS__
#include <ControlDefinitions.h>
#endif

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __DEVICES__
#include <Devices.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#ifndef __DISKINIT__
#include <DiskInit.h>
#endif

#ifndef __FIXMATH__
#include <FixMath.h>
#endif

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __MACMEMORY__
#include <MacMemory.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __PROCESSES__
#include <Processes.h>
#endif

#ifndef __QUICKTIMECOMPONENTS__
#include <QuickTimeComponents.h>
#endif

#ifndef __SEGLOAD__
#include <SegLoad.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __TRAPS__
#include <Traps.h>
#endif

#ifndef _STDIO_H
#include <stdio.h>
#endif

#ifndef _STRING_H
#include <string.h>
#endif

#endif	// __MRC__

#include "ComFramework.h"


//////////
//
// constants
//
//////////

#define kEmergencyMemorySize		40*1024L		// size of the block of memory used for our grow zone procedure
#define kExtraStackSpaceSize		32*1024L		// amount of additional stack space
#define kWNEDefaultSleep			1				// WaitNextEvent sleep time
#define kBroughtToFront				3				// number of times to call EventAvail at application startup

// resource IDs for dialogs
#define kAboutBoxID					128				// dialog ID for About box
#define kAlertErrorID				129				// dialog ID for warning box

// resource ID for string resource containing application's name
#define kAppNameResID				1000
#define kAppNameResIndex			1

#define kDefaultWindowTitle			"\puntitled"			
#define kDefaultWindowRect			{10,10,480,640}			


//////////
//
// function prototypes
//	   
//////////

static void					QTFrame_InitMacEnvironment (long theNumMoreMasters);
pascal long					QTFrame_GrowZoneProcedure (Size theBytesNeeded);
static Boolean 				QTFrame_InitMenuBar (void);
static void 				QTFrame_MainEventLoop (void);
void						QTFrame_HandleEvent (EventRecord *theEvent);
void 						QTFrame_HandleMenuCommand (long theMenuResult);
void 						QTFrame_HandleKeyPress (EventRecord *theEvent);
PASCAL_RTN void				QTFrame_StandardUserItemProcedure (DialogPtr theDialog, short theItem);
PASCAL_RTN Boolean			QTFrame_StandardModalDialogEventFilter (DialogPtr theDialog, EventRecord *theEvent, short *theItemHit);
static Boolean				QTFrame_CheckMovieControllers (EventRecord *theEvent);
void 						QTFrame_ShowWarning (Str255 theMessage, OSErr theErr);