/*
	File:		Common.h

	Contains:	common interfaces for NavSample

	Version:	1.4

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

	Copyright © 1996-2001 Apple Computer, Inc., All Rights Reserved
*/

#pragma once

#ifndef Common_Defs
#define Common_Defs
#ifdef __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <Carbon.h>
#endif

#ifdef __MRC__
#include <Windows.h>
#include <Dialogs.h>
#include <Navigation.h>
#include <TextUtils.h>
#include <Gestalt.h>
#include <ControlDefinitions.h>
#endif	// __MRC__

#define kStr255Len			255		// this length is for NewPtr call, used before making a Toolbox call
#define kNameLen			32		// file name length

enum checkboxstate { dechecked,checked };

#define kStrangeErr			-1

#define kActive				0
#define kInactive			255

// ASCII key characters
#define kCrChar				13		// carriage return key 
#define kDelChar			8		// delete key 
#define kEnterChar			3		// enter char 
#define kPeriodChar			46		// period char 
#define kTabKey				9		// tab char 
#define kYKey				121
#define kNKey				110
#define kEscKey				27
#define kColon				58
#define kZero				48
#define kNine				57
#define kUpperDChar			68
#define kLowerDChar			100

#define	dOK					1
#define dCancel				2

#define kDelayTick			10		// ticks for button hiliting
#define kWindowWidth		350		// width size for the text window
#define kWindowHeight		450

#define	kMaxDocumentCount	100		// maximum number of documents allowed

#define	InitialH			16
#define	InitialV			42

#define	TopMargin			6
#define	LeftMargin			6
#define	RightMargin			6
#define	BottomMargin		6

#define	ScrollResolution	12

#define kOpenRsrcID			300
#define kOpenRsrcID2		301

// file constants
#define	kFileCreator		'CPAP'
#define	kFileType			'TEXT'
#define kFileTypePICT		'PICT'
#define kOpenRsrcType		'open'

// resource constants
#define rIconSuite			128

#define iIconSuite			3

// alert resources constants:
#define rSaveChangesID		128
#define rRevertID			129
#define rGenericAlertID		130
#define rAboutID			131

// resource string constants
#define	rAppStringsID		128
enum {
	sApplicationName 		= 1,
	sTranslationLockedErr,
	sTranslationErr,
	sOpeningErr,
	sReadErr,				// 5
	sWriteToBusyFileErr,
	sBusyOpen,
	sChooseFile,
	sChooseFolder,
	sChooseVolume,			// 10
	sCreateFolder,
	sChooseObject,
	sChooseApp,
	sSaveCopyMessage,
	slSavePromptIndex,		// 15
	slClosingIndex,
	slQuittingIndex,
	sAddRemoveTitle,
	sLowMemoryErr,
	sDiskFullErr,			// 20
	sWriteErr,
	sUntitled,
	sNameCopy,
	sAddTitle,
	sCantDismissTitle,		// 25
	sAlreadyInList,
	sCantOpenSysFolder,
	sCustomShowPrompt,
	sCustomFormatPrompt,
	sCustomMenuTitle1,		// 30
	sCustomMenuTitle2,
	sCustomMenuTitle3,
	sCancelTitle,
	sDontSaveTitle,
	sAlertMessage,			// 35
	sFileLocked,
	sCustomCarbonEventPrompt
};

#define	MenuStringsID		129
enum {
	slCantUndo = 1,
	slUndoDrag,
	slRedoDrag
};

// menu resource constants
#define	MenuBarID			128

#define	idAppleMenu			128
#define	AboutItem			1

#define	idFileMenu			129
#define	NewItem				1
#define	OpenItem			2
#define	CloseItem			4
#define	SaveItem			5
#define SaveACopyItem		6
#define	RevertItem			7
//-
#define DictionaryItem		9
//-
#define	PageSetupItem		11
#define	PrintItem			12
#define QuitSeperator		13
#define	QuitItem			14

#define	idEditMenu			130
#define	iUndo				1
#define	iCut				3
#define	iCopy				4
#define	iPaste				5
#define	iClear				6
#define	iSelectAll			7

#define idClassicMenu		131
#define iSelectDir			1
#define iSelectVol			2
#define iSelectObject		3
#define iSelectApp			4
#define iCreateFolder		5
//-
#define iCustomOpen			7
#define iAddFiles			8
//-
#define iCustShow			10
#define iFullyCustShow		11
//-
#define iCustFormat			13
#define iFullyCustFormat	14
//-
#define iNewFile			16

#define idModernMenu		132
#define iCreateConfirm		1
//-
#define iCreateOpen			3
#define iCreateSave			4
#define iCreateChoose		5
#define iCreateNewFolder	6
//-
#define iCustomShowPopup	8
#define iCustomCarbonEvents	9

#define rCommandPopup		135

#define kScrollBarWidth 	16
#define kScrollBarPos 		kScrollBarWidth-1

// Nav customization: custom dialog items:
#define kControlListID			134
#define kControlListIDInset		132
#define kPopupCommand 			1
#define kAllowDismissCheck		2
#define kPictItem				3
#define kRadioOneItem			6
#define kRadioTwoItem			7
#define kButtonItem				8


// offscreen drawing:
typedef struct WindowOffscreen
{
	CGrafPtr		windowPort;
	GDHandle		windowDevice;
	GWorldPtr		offscreenWorld;
} WindowOffscreen;

WindowOffscreen* DrawOffscreen(WindowPtr theWindow);


#define mBarHeight	(short *)0x0BAA		// Low mem global for menu bar
#define EventQueue  (QHdrPtr)0x14A 		// Event queue header (10 bytes)
#define Mouse		((Point*)0x830)		// processed mouse
#define KeyTime 	(long*)0x186		// tickcount when KEYLAST was rec'd 

#define TopLeft(aRect)	(* (Point *) &(aRect).top)
#define BotRight(aRect)	(* (Point *) &(aRect).bottom)

#define RectWidth(aRect) ((aRect).right - (aRect).left)
#define RectHeight(aRect) ((aRect).bottom - (aRect).top)

#define Max(X, Y) ( ((X)>(Y)) ? (X) : (Y) )
#define Min(X, Y) (  ((X)>(Y)) ? (Y) : (X) )

#define Pin(VALUE, MIN, MAX) ( ((VALUE) < (MIN)) ? (MIN) : ( ((VALUE) > (MAX)) ? (MAX) : (VALUE) ) )

// these are values are used to keep "unique" set of preferences for each Nav dialog,
// for example: using more than one NavChooseObject style dialog in one application:
#define kOpenPrefKey			1
#define kSavePrefKey			2
#define kSelectFilePrefKey		3
#define kSelectFolderPrefKey	4
#define kSelectVolumePrefKey	5
#define kNewFolderPrefKey		6
#define kSelectObjectPrefKey	7
#define kSelectAppPrefKey		8

//***************************************************************************************

struct AlertParm
{
    Boolean useCancelButton;
    Boolean useDiscardButton;
    short messageStrListID;
    short messageStrItem;
    short explainStrListID;
    short explainStrItem;
};
typedef struct AlertParm AlertParm;
typedef AlertParm* AlertParmPtr;
                            
DialogItemIndex	DoModernAlert( AlertParmPtr myAlertParamRec );

//***************************************************************************************

void SetItemEnable( MenuHandle theMenu, short theItem, short enable );

// utility routines for detecting keydowns
Boolean ModifierDown( long keyMask, Boolean exactMatch );
Boolean OptionDown( void );
Boolean ShiftDown( void );
Boolean CommandDown( void );
Boolean ControlDown( void );

short RandTween(short low, short high);

// file utilities:
OSErr PathNameFromDirID(long dirID, short vRefNum, StringPtr fullPathName, short maxPathLength, short full);
Boolean FSSpecsEq(FSSpec* a, FSSpec* b);
pascal void myEventProc(NavEventCallbackMessage callBackSelctor, NavCBRecPtr callBackParms, NavCallBackUserData callBackUD);

// dialog control utilities
void hiliteTheButton(DialogPtr theDialog, short whichItem);
void AdornButton(DialogPtr theDialog, short whichItem);
unsigned char* GetItemStr(DialogPtr theDialog, short theItem, unsigned char* theString);
void PokeItemStr(DialogPtr theDialog, short theItem, unsigned char* theString);
void PokeCtlVal(DialogPtr theDialog, short theItem, short value);
void PokeCtlHilite(DialogPtr theDialog, short theItem, short value);

// string utilities
OSType Str2OSType(Str255 theStr);
long MyStrLen(char* s);
long myStringToLong(char* s);
short myStringToShort(char* s);
void myStrCpy(char* dst, char* src);
void myStrCat(char* dst, char* src);
unsigned char* ConcatPP(unsigned char* a,unsigned char* b);
char* MyP2CCopy(unsigned char* psrc,char* ctarget);
unsigned char* MyC2PStr(char* theStr);
char* MyP2CStr(unsigned char* theStr);

void DrawIconSuite(short resID, Rect destRect);
void myDebugCStr(char* msg);
void AdjustCursor(Point theLoc, RgnHandle theRgn);


// *******************************************************************

// prototypes for 'Utilities.c'
short TEIsFrontOfLine( short offset, TEHandle theTE );
short TEGetLine( short offset, TEHandle theTE );
short myTECut( TEHandle theTE );
short myTEPaste( TEHandle theTE, short* spaceBefore, short* spaceAfter );

// prototypes for 'Offscreen.c'
void DrawOnscreen( WindowOffscreen* theOffscreen );

// prototypes for 'menu.c'
void AdjustMenus( void );
void DoMenuCommand( long select );

// prototypes for 'event.c'
void EventLoop(void);
#if UNIVERSAL_INTERFACES_VERSION<=0x0335
pascal OSErr MyHandleOAPP( const AppleEvent* theAppleEvent, AppleEvent* reply, UInt32 handlerRefCon );
pascal OSErr MyHandleODOC( const AppleEvent* theAppleEvent, AppleEvent* reply, UInt32 handlerRefCon );
pascal OSErr MyHandleQUIT( const AppleEvent* theAppleEvent, AppleEvent* reply, UInt32 handlerRefCon );
#else
pascal OSErr MyHandleOAPP( const AppleEvent* theAppleEvent, AppleEvent* reply, long handlerRefCon );
pascal OSErr MyHandleODOC( const AppleEvent* theAppleEvent, AppleEvent* reply, long handlerRefCon );
pascal OSErr MyHandleQUIT( const AppleEvent* theAppleEvent, AppleEvent* reply, long handlerRefCon );
#endif

void DoLowMemAlert( void );

OSErr myAEGetDescData( const AEDesc* desc, DescType* typeCode, void* dataBuffer, ByteCount maximumSize, ByteCount* actualSize );

long FSpGetDirID( FSSpec* theSpec );

// shared code between menus.c and modern.c:
OSErr DoStdAlert( unsigned char* title, short* itemHit );
Boolean	HandleCustomControls( WindowRef window, NavDialogRef navDialog, ControlRef whichControl, short baseItem, short itemNum );
void HandleCommandPopup( ControlHandle thePopup, NavDialogRef navDialog );
void RightJustifyPict( NavCBRecPtr callBackParms );

#endif // Common_Defs