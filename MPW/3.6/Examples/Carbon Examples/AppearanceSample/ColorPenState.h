/*
	File:		ColorPenState.h

	Contains:	Utility routines to save and restore the graphics state of a grafport.

	Version:    CarbonLib 1.0.2 SDK

	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "Apple Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.

	© 1997-1999 by Apple Computer, Inc. All rights reserved.
*/

#ifndef __COLORPENSTATE__
#define __COLORPENSTATE__

#include <Quickdraw.h>

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

struct ColorPenState
{
	RGBColor		foreColor;
	RGBColor		backColor;
	PenState		pen;
	SInt16			textMode;
	PixPatHandle	pnPixPat;
	PixPatHandle	bkPixPat;
	UInt32			fgColor;
	UInt32			bkColor;
};
typedef struct ColorPenState ColorPenState;

#ifdef __cplusplus
extern "C" {
#endif

//	NOTE: The hasColor parameter is going away! Be warned...

extern void		GetColorAndPenState( ColorPenState* state );
extern void		SetColorAndPenState( ColorPenState* state );
extern void		NormalizeColorAndPen();

#ifdef __cplusplus
}
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif // __COLORPENSTATE__
