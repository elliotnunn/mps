/*
** Apple Macintosh Developer Technical Support
**
** Program:     DTS.Lib
** File:        TUndoObj.c
** Written by:  Eric Soldan
**
** Copyright © 1992 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */

#ifndef __OSEVENTS__
#include <OSEvents.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

//#ifndef __STRING__
//#include <String.h>
//#endif

#ifndef __TREEOBJ__
#include "TreeObj.h"
#endif

#ifndef __UTILITIES__
#include "Utilities.h"
#endif



#pragma segment TreeObj
long	TUndoObj(TreeObjHndl hndl, short message, long data)
{
	char	*cptr;

	switch (message) {
		case VHMESSAGE:
			cptr = ((VHFormatDataPtr)data)->data;
			ccatchr(cptr, 13, 2);
			ccat   (cptr, "$10: TUndoObj:");
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $00: root         = $");
			ccathex(cptr, '0', 8, 8, (long)mDerefUndo(hndl)->root);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $04: frHndl       = $");
			ccathex(cptr, '0', 8, 8, (long)mDerefUndo(hndl)->frHndl);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $08: disabled     = ");
			ccatdec(cptr, mDerefUndo(hndl)->disabled);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $0A: lastEditType = ");
			ccatdec(cptr, mDerefUndo(hndl)->lastEditType);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $0C: undoDepth    = ");
			ccatdec(cptr, mDerefUndo(hndl)->undoDepth);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $0E: maxNumUndos  = ");
			ccatdec(cptr, mDerefUndo(hndl)->maxNumUndos);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $10: numSaveUndos = ");
			ccatdec(cptr, mDerefUndo(hndl)->numSaveUndos);
			return(true);
			break;

		default:
			break;
	}

	return(noErr);
}



