/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	Kibitz
#
#	Kibitz.h	-	Rez and C Include Source
#
#	Copyright © 1989-1992 Apple Computer, Inc.
#	All rights reserved.
#
------------------------------------------------------------------------------*/


#ifndef __KIBITZCOMMON__
#define __KIBITZCOMMON__

/*	Kibitz.c and Kibitz.r include this file. */

#define gameCreator		'KBTZ'
#define gameFileType	'YAK0'
#define mssgFileType	'YAKM'

#define rSliderCtl	4352

#define rConfigBase	300
#define rSliderBase	310

#define kMinSize	400				/* application's minimum size (in K) */
#define kPrefSize	400				/* application's preferred size (in K) */


#define	rMenuBar	128				/* application's menu bar */
#define	rAboutAlert	128				/* about alert */
#define	rErrorAlert	129				/* error alert */
#define	rWindow		128				/* application's window */

#define rWindowYPos		60
#define rWindowHeight	263
#define rWindowXPos		40
#define rWindowWidth	504

/* kOSEvent is the event number of the suspend/resume and mouse-moved events sent
   by MultiFinder. Once we determine that an event is an osEvent, we look at the
   high byte of the message sent to determine which kind it is. To differentiate
   suspend and resume events we check the resumeMask bit. */

#define	kOSEvent				app4Evt	/* event used by MultiFinder */
#define	kSuspendResumeMessage	1		/* high byte of suspend/resume event message */
#define	kResumeMask				1		/* bit of message field for resume vs. suspend */
#define	kMouseMovedMessage		0xFA	/* high byte of mouse-moved event message */
#define	kNoEvents				0		/* no events mask */


/* The following constants are used to identify menus and their items. The menu IDs
   have an "m" prefix and the item numbers within each menu have an "i" prefix. */

#define	mApple					128		/* Apple menu */
#define	iAbout					1

#define	mFile					129		/* File menu */
#define	iNew					1
#define iOpen					2
#define iMessage				3
#define	iClose					5
#define iSave					6
#define	iSaveAs					7
#define	iSaveBoardImage			8
#define iDuplicate				9
#define iRevert					10
#define	iPageSetup				12
#define	iPrint					13
#define	iQuit					15

#define	mEdit					130		/* Edit menu */
#define	iUndo					1
#define	iCut					3
#define	iCopy					4
#define	iPaste					5
#define	iClear					6
#define	iSelectAll				8

/* menu constants for game */
#define mGame					131
#define iConfigureGame			1
#define iInvertBoard			2
#define	iArrangeBoard			4
#define	iPlayOnePlayer			5
#define	iPlayTwoPlayer			6
#define	iFindTwoPlayer			8
#define	iGoToMove				10
#define	iAlgOut					11
#define	iAlgIn					12

#define mSpeech					132
#define iSayMessage				1
#define iSayMove				2
#define iSelectVoice			4



/*	kTopLeft - This is for positioning the Disk Initialization dialogs. */

#define kDITop					0x0050
#define kDILeft					0x0070


/*	1.01 - kMinHeap - This is the minimum result from the following
	equation:

		ORD(GetApplLimit) - ORD(ApplicZone)

	for the application to run. It will insure that enough memory will
	be around for reasonable-sized scraps, FKEYs, etc. to exist with the
	application, and still give the application some 'breathing room'.
	To derive this number, we ran under a MultiFinder partition that was
	our requested minimum size, as given in the 'SIZE' resource. */

#define kMinHeap				21 * 1024


/*	1.01 - kMinSpace - This is the minimum result from PurgeSpace, when called
	at initialization time, for the application to run. This number acts
	as a double-check to insure that there really is enough memory for the
	application to run, including what has been taken up already by
	pre-loaded resources, the scrap, code, and other sundry memory blocks. */

#define kMinSpace				8 * 1024



/* These #defines are used to set enable/disable flags of a menu */

#define AllItems	0b1111111111111111111111111111111	/* 31 flags */
#define NoItems		0b0000000000000000000000000000000
#define MenuItem1	0b0000000000000000000000000000001
#define MenuItem2	0b0000000000000000000000000000010
#define MenuItem3	0b0000000000000000000000000000100
#define MenuItem4	0b0000000000000000000000000001000
#define MenuItem5	0b0000000000000000000000000010000
#define MenuItem6	0b0000000000000000000000000100000
#define MenuItem7	0b0000000000000000000000001000000
#define MenuItem8	0b0000000000000000000000010000000
#define MenuItem9	0b0000000000000000000000100000000
#define MenuItem10	0b0000000000000000000001000000000
#define MenuItem11	0b0000000000000000000010000000000
#define MenuItem12	0b0000000000000000000100000000000
#define MenuItem13	0b0000000000000000001000000000000
#define MenuItem14	0b0000000000000000010000000000000


#define A_USERITEM	2
#define sErrorOccurred 1			/* Strings to display in the user item */
#define sErrorNumber 2
#define sEventWhat 3
#define sEventMessage 4
#define sMessageID 5


#define rYesNoCancel	 250
#define rNoYesCancel	 255
#define rOpenReadOnly	 260
#define rPawnPromotion	 265
#define rConfigureGame	 270
#define rArrangeWarning	 275
#define rRevertWarning	 280
#define rPrStatusDlg	 285
#define rGoToMove		 290
#define rComputerResigns 300

#define handCursor			257
#define closedHandCursor	258
#define ibeamCursor			259


/* miscellaneous string list ID */
#define rMiscStrings 366
#define ksSFprompt 1
#define ksOrigName 2
#define ksClosing  3
#define ksQuitting 4
#define ksMssgName 5


/* Not-good-at-all startup error messages. */
#define rBadNewsStrings			367
#define sWimpyMachine			1		/* Strings to display in the user item */
#define sHeapTooSmall			2
#define sNoFreeRoomInHeap		3
#define sBadThingHappened		4


#define rDynHelpStrings		368
#define rDynHelpSlider		1


#define rGameStat			257
#define rSendMessage		257
#define rMoveNotify			258
#define rErrInitAppleEvents	258
#define rMssgNotify			259
#define rWhiteStarts		260
#define rBlackStarts		261
#define rResign				262
#define rDraw				263
#define rRecordSound		264
#define rSendSound			265

#define rPPCText    500
#define sTitleText  1
#define sAppText    2



#endif

