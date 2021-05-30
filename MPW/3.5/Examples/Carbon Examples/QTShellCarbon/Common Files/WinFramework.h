/*

	File:		WinFramework.h

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

#ifndef __Prefix_File__
#include "WinPrefix.h"
#endif

#ifndef _WINDOWS_
#include <windows.h>
#endif

#ifndef __FIXMATH__
#include <FixMath.h>
#endif

#ifndef __QTML__
#include <QTML.h>
#endif

#ifndef __SCRAP__
#include <Scrap.h>
#endif

#ifndef _STDLIB_H
#include <stdlib.h>
#endif

#ifndef __malloc_h__ 
#include <malloc.h>
#endif

#include "ComFramework.h"
#include "ComResource.h"


//////////
//
// constants
//
//////////

#define	WM_PUMPMOVIE				(WM_USER+0)
#define	WM_OPENDROPPEDFILES			(WM_USER+1)
#define USEEXPLORERSTYLE			(LOBYTE(LOWORD(GetVersion()))>=4)
#define kOpenDialogCustomData		11						// an arbitrary value that allows our dialog proc to detect the Open File dialog box
#define kAlertMessageMaxLength		256						// maximum length of a message in the QTFrame_ShowCautionAlert message box

#define kWinFilePathSeparator		(char)'\\'				// on Windows, the file path separator is '\\'


//////////
//
// function prototypes
//	   
//////////

LRESULT CALLBACK 			QTFrame_FrameWndProc (HWND theWnd, UINT theMessage, UINT wParam, LONG lParam);
LRESULT CALLBACK 			QTFrame_MovieWndProc (HWND theWnd, UINT theMessage, UINT wParam, LONG lParam);
void						QTFrame_OpenCommandLineMovies (LPSTR theCmdLine);
int							QTFrame_ShowCautionAlert (HWND theWnd, UINT theID, UINT theIconStyle, UINT theButtonStyle, LPSTR theTitle, LPSTR theArgument);
static UINT APIENTRY		QTFrame_DialogProcedure (HWND theDialog, UINT theMessage, WPARAM wParam, LPARAM lParam);
static void					QTFrame_CalcWindowMinMaxInfo (HWND theWnd, LPMINMAXINFO lpMinMax);
