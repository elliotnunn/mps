/*

	File:		ComResource.h

	Contains:	Resource definitions for the QuickTime sample code framework. 

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

//////////
//
// menu IDs
//
// Windows accesses menu items with a single "menu item identifier", which is of type UINT.
// Macintosh accesses menu items with both a menu ID and a menu item index. To be able to 
// access menu items in a cross-platform manner, we will map the pair of numbers associated
// with a Macintosh menu item into a single "menu item identifier", using the MENU_IDENTIFIER
// macro defined in the file ComFramework.h. This means that the menu item identifiers that
// we use in our Windows code depend on the values we use for the menu ID and menu item indices
// in the Macintosh resource file.
//
//////////

// resource IDs for Macintosh menus
#define kMenuBarResID                   128
#define kAppleMenuResID                 128
#define kFileMenuResID					129
#define kEditMenuResID					130
#define kTestMenuResID					131

// IDs for Apple menu items
#define kAboutMenuItem					1

// IDs for File and Edit menus and menu items
#define IDS_FILEMENU                    33024	// ((kFileMenuResID<<8)+(0))
#define IDM_FILENEW						33025
#define IDM_FILEOPEN                    33026
#define IDM_FILECLOSE                   33027
#define IDM_FILESAVE                 	33028
#define IDM_FILESAVEAS                 	33029
#define IDM_EXIT                        33031

#define IDS_EDITMENU                    33280	// ((kEditMenuResID<<8)+(0))
#define IDM_EDITUNDO                    33281
#define IDM_EDITCUT                     33283
#define IDM_EDITCOPY                    33284
#define IDM_EDITPASTE                   33285
#define IDM_EDITCLEAR                   33286
#define IDM_EDITSELECTALL               33288
#define IDM_EDITSELECTNONE				33289

#define IDS_TESTMENU              	    33536	// ((kTestMenuResID<<8)+(0))
#define IDM_CONTROLLER                  33537	// ((kTestMenuResID<<8)+(1))
#define IDM_SPEAKER_BUTTON              33538	// ((kTestMenuResID<<8)+(2))

// IDs for Window menu and menu items (Windows-only)
#define IDS_WINDOWMENU                  1300
#define IDM_WINDOWTILE                  1301
#define IDM_WINDOWCASCADE               1302
#define IDM_WINDOWCLOSEALL              1303
#define IDM_WINDOWICONS                 1304
#define IDM_WINDOWCHILD                 1310

// Windows-only resource IDs
#define IDS_HELPMENU                    1400
#define IDM_ABOUT                       1401
#define IDC_STATIC                      -1

#define IDS_APPNAME                     1
#define IDS_DESCRIPTION                 2
#define WINDOWMENU                      3
#define IDS_FILTERSTRING                3
#define IDS_SAVEONCLOSE              	2000
#define IDS_SAVEONQUIT              	2001
#define IDI_APPICON                     101
#define IDI_CHILDICON                   102
#define IDD_ABOUT                       103


