/*-----------------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	Collection of Utilities for DTS Sample code
#
#	Program:	Utilities.c.o
#	File:		UtilitiesCommon.h	-	Common Source for C and Rez
#
#	Copyright © 1988-1990 Apple Computer, Inc.
#	All rights reserved.
#
-----------------------------------------------------------------------------------------*/

#define kUseCreatorString		(-1)		/* Pass this to StandardAbout if you would
											   like the string stored in your creator
											   resource to appear in the about box. */
#define kUseRealAppName			(-2)		/* Pass this to StandardAbout if you would
											   like the name of your application to
											   appear in the about box. */

#define rUtilErrorAlert			256			/* dlg ID used in ErrorAlert */
#define rUtilErrorMessageAlert	257			/* dlg ID used in ErrorAlertMessage */
#define rStdAboutAlert			258			/* dlg ID used for About box. */

#define rUtilStrings			256			/* STR# resource we use for errors. */
#define eStandardErr			1			/* Generic "An error occured" string. */
#define eNoMenuBar				2			/* "No 'MBAR' resource was found." */

#define kButtonFrameSize		3			/* button frame’s pen size */
#define kButtonFrameInset		(-4)		/* inset rectangle adjustment around button */

#define kExtremeNeg				(-32768)	/* kExtremeNeg and kExtremePos are used to set
											   up wide open rectangles and regions. */
#define kExtremePos				(32767 - 1)	/* required to address an old region bug */
	
#define kDITop					0x0050		/* kTopLeft - for positioning the Disk
											   Initialization dialogs. */
#define kDILeft					0x0070

#define kControlInvisible		0
#define kControlVisible			0xFF
#define kCntlActivate			0			/* enabled control’s hilite state */
#define kCntlDeactivate			0xFF		/* disabled control’s hilite state */
#define kCntlOn					1			/* control’s value when truned on */
#define kCntlOff				0			/* control’s value when truned off */
#define kSelect					1			/* select the control */
#define kDeselect				0			/* deselect the control */

#define kScrollbarWidth			16			/* kScrollBarWidth can be used in
											   calculating values for control
											   positioning and sizing.*/
#define kScrollbarAdjust		(kScrollbarWidth - 1)


