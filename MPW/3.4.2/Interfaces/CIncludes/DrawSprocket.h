/*
 *	File:			DrawSprocket.h
 *
 *	Version:		DrawSprocket 1.1
 *
 *	Dependencies:	Universal Interfaces 2.1.2 on ETO #20
 *
 *	Contents:		Public interfaces for DrawSprocket.
 *
 *	Bugs:			If you find a problem with this file or DrawSprocketLib,
 *					please send e-mail describing the problem in enough detail
 *					to be reproduced, and include the version number above, the
 *					version of MacOS and hardware configuration information to
 *					sprockets@adr.apple.com.
 *
 *	Copyright (c) 1996 Apple Computer, Inc.  All rights reserved.
 */

#ifndef __DRAWSPROCKET__
#define __DRAWSPROCKET__

#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif

#ifndef __DISPLAYS__
#include <Displays.h>
#endif

#if GENERATINGPOWERPC

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=power
#endif

/*
********************************************************************************
** error/warning codes
********************************************************************************
*/
enum {
	kDSpNotInitializedErr				= -30440L,
	kDSpSystemSWTooOldErr				= -30441L,
	kDSpInvalidContextErr				= -30442L,
	kDSpInvalidAttributesErr			= -30443L,
	kDSpContextAlreadyReservedErr		= -30444L,
	kDSpContextNotReservedErr			= -30445L,
	kDSpContextNotFoundErr				= -30446L,
	kDSpFrameRateNotReadyErr			= -30447L,
	kDSpConfirmSwitchWarning			= -30448L,
	kDSpInternalErr						= -30449L,
	kDSpStereoContextErr				= -30450L
};

/*
********************************************************************************
** constants
********************************************************************************
*/
typedef UInt32 DSpDepthMask;
enum {
	kDSpDepthMask_1		= 1U<<0,
	kDSpDepthMask_2		= 1U<<1,
	kDSpDepthMask_4		= 1U<<2,
	kDSpDepthMask_8		= 1U<<3,
	kDSpDepthMask_16	= 1U<<4,
	kDSpDepthMask_32	= 1U<<5,
	kDSpDepthMask_All	= ~0U
};

typedef UInt32 DSpColorNeeds;
enum {
	kDSpColorNeeds_DontCare	= 0L,
	kDSpColorNeeds_Request	= 1L,
	kDSpColorNeeds_Require	= 2L
};

typedef UInt32 DSpContextState;
enum {
	kDSpContextState_Active		= 0L,
	kDSpContextState_Paused		= 1L,
	kDSpContextState_Inactive	= 2L
};

/* kDSpContextOption_QD3DAccel not yet implemented */
typedef UInt32 DSpContextOption;
enum {
/*	kDSpContextOption_QD3DAccel		= 1U<<0,*/
	kDSpContextOption_PageFlip		= 1U<<1,
	kDSpContextOption_DontSyncVBL	= 1U<<2,
	kDSpContextOption_Stereoscopic	= 1U<<3
};

typedef UInt32 DSpAltBufferOption;
enum {
	kDSpAltBufferOption_RowBytesEqualsWidth		= 1U<<0
};

typedef UInt32 DSpBufferKind;
enum {
	kDSpBufferKind_Normal	= 0U,
	kDSpBufferKind_LeftEye	= 0U,
	kDSpBufferKind_RightEye	= 1U
};

typedef UInt32 DSpBlitMode;
enum
{
	kDSpBlitMode_SrcKey			= 1U << 0,
	kDSpBlitMode_DstKey			= 1U << 1,
	kDSpBlitMode_Interpolation	= 1U << 2
};

/*
********************************************************************************
** data types
********************************************************************************
*/
typedef struct DSpAltBufferPrivate *DSpAltBufferReference;
typedef struct DSpContextPrivate *DSpContextReference;

#define kDSpEveryContext ((DSpContextReference)NULL)

typedef Boolean (*DSpEventProcPtr)( EventRecord *inEvent );
typedef Boolean (*DSpCallbackProcPtr)( DSpContextReference inContext,
			void *inRefCon );

struct DSpContextAttributes {
	Fixed				frequency;
	UInt32				displayWidth;
	UInt32				displayHeight;
	UInt32				reserved1;
	UInt32				reserved2;
	UInt32				colorNeeds;
	CTabHandle			colorTable;
	OptionBits			contextOptions;
	OptionBits			backBufferDepthMask;
	OptionBits			displayDepthMask;
	UInt32				backBufferBestDepth;
	UInt32				displayBestDepth;
	UInt32				pageCount;
	Boolean				gameMustConfirmSwitch;
	UInt32				reserved3[4];
};
typedef struct DSpContextAttributes DSpContextAttributes;
typedef struct DSpContextAttributes *DSpContextAttributesPtr;

struct DSpAltBufferAttributes {
	UInt32				width;
	UInt32				height;
	DSpAltBufferOption	options;
	UInt32				reserved[4];
};
typedef struct DSpAltBufferAttributes DSpAltBufferAttributes;

typedef void (*DSpBlitDoneProc)(struct DSpBlitInfo *);

typedef struct DSpBlitInfo
{
	Boolean				completionFlag;
	DSpBlitDoneProc		completionProc;
	DSpContextReference	srcContext;
	CGrafPtr			srcBuffer;
	Rect				srcRect;
	UInt32				srcKey;
	
	DSpContextReference	dstContext;
	CGrafPtr			dstBuffer;
	Rect				dstRect;
	UInt32				dstKey;
	
	DSpBlitMode			mode;
	UInt32				reserved[4];
} DSpBlitInfo, *DSpBlitInfoPtr;

/*
********************************************************************************
** function prototypes
********************************************************************************
*/

/*
** global operations
*/
extern OSStatus DSpStartup( void );
extern OSStatus DSpShutdown( void );

extern OSStatus DSpGetFirstContext( DisplayIDType inDisplayID,
			DSpContextReference *outContext );
extern OSStatus DSpGetNextContext( DSpContextReference inCurrentContext,
			DSpContextReference *outContext );

extern OSStatus DSpFindBestContext(
			DSpContextAttributesPtr inDesiredAttributes,
			DSpContextReference *outContext );

extern OSStatus DSpCanUserSelectContext(
			DSpContextAttributesPtr inDesiredAttributes,
			Boolean *outUserCanSelectContext );
extern OSStatus DSpUserSelectContext(
			DSpContextAttributesPtr inDesiredAttributes,
			DisplayIDType inDialogDisplayLocation, DSpEventProcPtr inEventProc,
			DSpContextReference *outContext );

extern OSStatus DSpProcessEvent( EventRecord *inEvent, Boolean *outEventWasProcessed );

extern OSStatus DSpSetBlankingColor( const RGBColor *inRGBColor );

extern OSStatus DSpSetDebugMode( Boolean inDebugMode );

extern OSStatus DSpFindContextFromPoint( Point inGlobalPoint,
			DSpContextReference *outContext );

extern OSStatus DSpGetMouse( Point *outGlobalPoint );

/*
** alternate buffer operations
*/
extern OSStatus DSpAltBuffer_New( DSpContextReference inContext, Boolean inVRAMBuffer,
			DSpAltBufferAttributes *inAttributes, DSpAltBufferReference *outAltBuffer );
extern OSStatus DSpAltBuffer_Dispose( DSpAltBufferReference inAltBuffer );
extern OSStatus DSpAltBuffer_InvalRect( DSpAltBufferReference inAltBuffer,
			const Rect *inInvalidRect );
extern OSStatus DSpAltBuffer_GetCGrafPtr( DSpAltBufferReference inAltBuffer,
			DSpBufferKind inBufferKind, CGrafPtr *outCGrafPtr,
			GDHandle *outGDevice );

/*
** context operations
*/

/* general */
extern OSStatus DSpContext_GetAttributes( DSpContextReference inContext,
			DSpContextAttributesPtr outAttributes );

extern OSStatus DSpContext_Reserve( DSpContextReference inContext,
			DSpContextAttributesPtr inDesiredAttributes );
extern OSStatus DSpContext_Release( DSpContextReference inContext );

extern OSStatus DSpContext_GetDisplayID( DSpContextReference inContext,
			DisplayIDType *outDisplayID );

extern OSStatus DSpContext_GlobalToLocal( DSpContextReference inContext,
			Point *ioPoint );
extern OSStatus DSpContext_LocalToGlobal( DSpContextReference inContext,
			Point *ioPoint );

extern OSStatus DSpContext_SetVBLProc( DSpContextReference inContext,
			DSpCallbackProcPtr inProcPtr, void *inRefCon );

extern OSStatus DSpContext_GetFlattenedSize( DSpContextReference inContext,
			UInt32 *outFlatContextSize );
extern OSStatus DSpContext_Flatten( DSpContextReference inContext,
			void *outFlatContext );
extern OSStatus DSpContext_Restore( void *inFlatContext,
			DSpContextReference *outRestoredContext );

extern OSStatus DSpContext_GetMonitorFrequency( DSpContextReference inContext,
			Fixed *outFrequency );
extern OSStatus DSpContext_SetMaxFrameRate( DSpContextReference inContext,
			UInt32 inMaxFPS );
extern OSStatus DSpContext_GetMaxFrameRate( DSpContextReference inContext,
			UInt32 *outMaxFPS );

extern OSStatus DSpContext_SetState( DSpContextReference inContext,
			DSpContextState inState );
extern OSStatus DSpContext_GetState( DSpContextReference inContext,
			DSpContextState *outState );

extern OSStatus DSpContext_IsBusy( DSpContextReference inContext,
			Boolean *outBusyFlag );

/* dirty rectangles */
extern OSStatus DSpContext_SetDirtyRectGridSize( DSpContextReference inContext,
			UInt32 inCellPixelWidth, UInt32 inCellPixelHeight );
extern OSStatus DSpContext_GetDirtyRectGridSize( DSpContextReference inContext,
			UInt32 *outCellPixelWidth, UInt32 *outCellPixelHeight );
extern OSStatus DSpContext_GetDirtyRectGridUnits( DSpContextReference inContext,
			UInt32 *outCellPixelWidth, UInt32 *outCellPixelHeight );
extern OSStatus DSpContext_InvalBackBufferRect( DSpContextReference inContext,
			const Rect *inRect );

/* underlays */
extern OSStatus DSpContext_SetUnderlayAltBuffer( DSpContextReference inContext,
			DSpAltBufferReference inNewUnderlay );
extern OSStatus DSpContext_GetUnderlayAltBuffer( DSpContextReference inContext,
			DSpAltBufferReference *outUnderlay );

/* gamma */
extern OSStatus DSpContext_FadeGammaOut( DSpContextReference inContext,
			RGBColor *inZeroIntensityColor );
extern OSStatus DSpContext_FadeGammaIn( DSpContextReference inContext,
			RGBColor *inZeroIntensityColor );
extern OSStatus DSpContext_FadeGamma( DSpContextReference inContext,
			SInt32 inPercentOfOriginalIntensity,
			RGBColor *inZeroIntensityColor );

/* buffering */
extern OSStatus DSpContext_SwapBuffers( DSpContextReference inContext,
			DSpCallbackProcPtr inBusyProc, void *inUserRefCon );
extern OSStatus DSpContext_GetBackBuffer( DSpContextReference inContext,
			DSpBufferKind inBufferKind, CGrafPtr *outBackBuffer );

/* clut operations */
extern OSStatus DSpContext_SetCLUTEntries( DSpContextReference inContext,
			const ColorSpec *inEntries, UInt16 inStartingEntry,
			UInt16 inLastEntry );
extern OSStatus DSpContext_GetCLUTEntries( DSpContextReference inContext,
			ColorSpec *outEntries, UInt16 inStartingEntry,
			UInt16 inLastEntry );

/* blit operations */
extern OSStatus DSpBlit_Faster(DSpBlitInfoPtr inBlitInfo, Boolean inAsyncFlag);
extern OSStatus DSpBlit_Fastest(DSpBlitInfoPtr inBlitInfo, Boolean inAsyncFlag);
			
#ifdef __cplusplus
}
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif /* GENERATINGPOWERPC */
#endif /* __DRAWSPROCKET__ */
