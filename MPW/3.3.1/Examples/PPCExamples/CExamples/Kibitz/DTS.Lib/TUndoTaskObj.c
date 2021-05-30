/*
** Apple Macintosh Developer Technical Support
**
** Program:     DTS.Lib
** File:        TUndoTaskObj.c
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
long	TUndoTaskObj(TreeObjHndl hndl, short message, long data)
{
	short	fileRefNum;
	char	*cptr;
	Point	pt;

	switch (message) {
		case FREADMESSAGE:
			fileRefNum = data;
			return(ReadTreeObjData(hndl, fileRefNum));
			break;

		case FWRITEMESSAGE:
			fileRefNum = data;
			return(WriteTreeObjData(hndl, fileRefNum));
			break;

		case VHMESSAGE:
			cptr = ((VHFormatDataPtr)data)->data;
			ccatchr(cptr, 13, 2);
			ccat   (cptr, "$10: TUndoTaskObj:");
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $00: editType   = ");
			ccatdec(cptr, mDerefUndoTask(hndl)->editType);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $02: undoOrigin = (");
			pt = mDerefUndoTask(hndl)->undoOrigin;
			ccatdec(cptr, pt.v);
			ccat   (cptr, ",");
			ccatdec(cptr, pt.h);
			ccat   (cptr, ")");
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $06: redoOrigin = (");
			pt = mDerefUndoTask(hndl)->redoOrigin;
			ccatdec(cptr, pt.v);
			ccat   (cptr, ",");
			ccatdec(cptr, pt.h);
			ccat   (cptr, ")");
			return(true);
			break;

		default:
			break;
	}

	return(noErr);
}



