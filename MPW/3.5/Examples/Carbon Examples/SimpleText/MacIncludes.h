/*
	File:		MacIncludes.h

	Contains:	This file contains all of the Mac includes that one needs

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

	Copyright © 1990-2001 Apple Computer, Inc., All Rights Reserved
*/


#ifndef __MACINCLUDES__
#define __MACINCLUDES__

#if (!defined(UseMacDump))

#ifndef BUILDING_FOR_SYSTEM7
	#define BUILDING_FOR_SYSTEM7 1
#endif

#if defined(USE_UMBRELLA_HEADERS) && USE_UMBRELLA_HEADERS
#include <Carbon.h>
#else
#include <MacTypes.h>
#include <Resources.h>
#include <Quickdraw.h>
#include <Fonts.h>
#include <Events.h>
#include <MacWindows.h>
#include <Menus.h>
#include <TextEdit.h>
#include <Dialogs.h>
#include <ToolUtils.h>
#include <MacMemory.h>
#include <SegLoad.h>
#include <ControlDefinitions.h>
#include <Files.h>
#include <OSUtils.h>
#include <Traps.h>	
#include <Script.h>
#include <ColorPicker.h>
#include <FixMath.h>
#include <Packages.h>
#include <Palettes.h>
#include <QDOffscreen.h>
#include <Sound.h>
#include <Errors.h>
#include <AppleEvents.h>
#include <DiskInit.h>
#include <Retrace.h>
#include <Folders.h>
#include <Lists.h>
//#include <CTBUtilities.h>
#include <Gestalt.h>
#include <Finder.h>
#include <Scrap.h>
#include <Devices.h>
#include <Video.h>
#include <Aliases.h>
#include <SoundInput.h>
#include <Movies.h>
#include <Printing.h>
#include <PMApplication.h>
#include <Balloons.h>
#include <MixedMode.h>
#include <Drag.h>
#include <TextServices.h>
#include <TSMTE.h>
#include <AppleGuide.h>
#include <Speech.h>
#include <Icons.h>
#include <LowMem.h>
#include <CodeFragments.h>
#include <TextUtils.h>
#include <Appearance.h>
#include <PLStringFuncs.h>
#include <OSA.h>		// for AppleScript
#include <AEDataModel.h>	// for AppleScript
#include <Threads.h>
#include <Controls.h>
#include <ImageCompression.h>	// for CustomGetFilePreview
#include <Components.h>		// for AppleScript
#include <Processes.h>

#if MOUSE_WHEEL_SUPPORT
#include <CarbonEvents.h>
#endif

#if ALLOW_QUICKTIME
#include "QuickTimeComponents.h"
// #include "GraphicsImporter.h"
#endif

#define nrequire(CONDITION, LABEL) if (true) {if ((CONDITION)) goto LABEL; }
#define require(CONDITION, LABEL) if (true) {if (!(CONDITION)) goto LABEL; }
#endif

// #include "AGFile.h"
#include "NavigationServicesSupport.h"

// Balloons.h
#define kDefaultBalloonVariant	2

// For looking at all of our windows, not just the visible ones.

// No glue for this either, sigh.
#define TESetClickLoop(L,H) ((**(H)).clickLoop = (L))

// defines I like to use all of the time
extern void _DataInit();		// part of Runtime library

#define TopLeft(aRect)	(* (Point *) &(aRect).top)
#define BotRight(aRect)	(* (Point *) &(aRect).bottom)

#define RectWidth(aRect) ((aRect).right - (aRect).left)
#define RectHeight(aRect) ((aRect).bottom - (aRect).top)

#define Max(X, Y) ( ((X)>(Y)) ? (X) : (Y) )
#define Min(X, Y) (  ((X)>(Y)) ? (Y) : (X) )

#define Pin(VALUE, MIN, MAX) ( ((VALUE) < (MIN)) ? (MIN) : ( ((VALUE) > (MAX)) ? (MAX) : (VALUE) ) )

// The Pascal equivalent of strcpy, takes two Pascal string pointers
#define PSTRCPY(P1, P2)	BlockMove(P2, P1, P2[0]+1)

// Concatante one character C onto the string S 
#define CHARCAT(S, C)	S[(S[0]+1)] = C; S[0]++;

/* The Pascal equivalent of strcat, takes two Pascal string pointers */
#define PSTRCAT(P1, P2) 						\
	BlockMove(&P2[1], &P1[(P1[0]+1)], P2[0]);	\
	P1[0] += P2[0];

	#if defined(MakeMacDump)
		#pragma dump "MacIncludesDump"
	#endif

#else		// from the if !defined at the top of the file

	#if defined(UseMacDump)
		#pragma load "MacIncludesDump"
	#endif
#endif

// this is a workaround for the current lack of prototypes for the old
// scrap APIs in Scrap.h. I would just go ahead and adopt the new routines
// but they aren't implemented on X yet...
#if PRAGMA_STRUCT_ALIGN
        #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
        #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
        #pragma pack(2)
#endif

EXTERN_API( long )
GetScrap                                                (Handle                                 destination,
                                                                 ScrapFlavorType                flavorType,
                                                                 SInt32 *                               offset)
                                ONEWORDINLINE(0xA9FD);

EXTERN_API( OSStatus )
ZeroScrap                                               (void)
                                ONEWORDINLINE(0xA9FC);

EXTERN_API( OSStatus )
PutScrap                                                (SInt32                                 sourceBufferByteCount,
                                                                 ScrapFlavorType                flavorType,
                                                                 const void *                   sourceBuffer)
                ONEWORDINLINE(0xA9FE);
#if PRAGMA_STRUCT_ALIGN
        #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
        #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
        #pragma pack()
#endif

#endif /* __MACINCLUDES__ */
