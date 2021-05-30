/*
	File:		TSMTE.h

	Contains:	Definitions for TSMTE

	Written by:	Kida Yasuo, Hara Keisuke

	Copyright:	©1991, 1992 Apple Operations and Technologies Japan, Inc.
				All rights reserved.
*/

#ifndef	__TSMTE__
#define	__TSMTE__

#ifndef	__TEXTEDIT__
#include <TextEdit.h>
#endif
#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#ifndef	__TEXTSERVICES__
#include "TextServices.h"
#endif



// Signature, interface types.

#define kTSMTESignature			'tmTE'
#define kTSMTEInterfaceType		kTSMTESignature
#define kTSMTEDialog			'tmDI'


// Gestalt

#define gestaltTSMTEAttr		kTSMTESignature
#define gestaltTSMTE			0
#define gestaltTSMTEVersion		'tmTV'
#define kTSMTEVersion			0x100 


// Callback procedure definitions

typedef pascal void ( *TSMPreUpdateProcPtr)(
	TEHandle	textH,
	long		refCon);

typedef pascal void ( *TSMPostUpdateProcPtr)(
	TEHandle	textH,
	long		fixLen,
	long		inputAreaStart,
	long		inputAreaEnd,
	long		pinStart,
	long		pinEnd,
	long		refCon);


// TSMTERec

enum {
	kTSMTEAutoScroll	= 1				//	auto scroll on
};

typedef struct
{
	TEHandle				textH;			// TEHandle
	TSMPreUpdateProcPtr		preUpdateProc;	// if not nil, this is called before updating text
	TSMPostUpdateProcPtr	postUpdateProc;	// if not nil, this is called after updating text
	long					updateFlag;		// flags described above
	long					refCon;			// reference constant used by application
} TSMTERec, *TSMTERecPtr, **TSMTERecHandle;


// TSMDalogRecord

typedef struct TSMDialogRecord
{
	DialogRecord		fDialog;		// Dialog Record
	TSMDocumentID		fDocID;			// TSMDocument ID
	TSMTERecHandle		fTsmteRecH;		// Handle to the TSMTERec
	long				fTSMTERsvd[3];	// •Internally used•
} TSMDialogRecord, *TSMDialogPeek;


#endif
