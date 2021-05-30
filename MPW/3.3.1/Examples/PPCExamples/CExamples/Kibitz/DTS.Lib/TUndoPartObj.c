/*
** Apple Macintosh Developer Technical Support
**
** Program:     DTS.Lib
** File:        TUndoPartObj.c
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
long	TUndoPartObj(TreeObjHndl hndl, short message, long data)
{
	short	fileRefNum;
	char	*cptr;

	switch (message) {
		case CONVERTMESSAGE:
			switch (data) {
				case CONVERTTOID:
					Hndl2ID(&mDerefUndoPart(hndl)->shndl);
					Hndl2ID(&mDerefUndoPart(hndl)->dhndl);
					break;
				case CONVERTTOHNDL:
					ID2Hndl(hndl, &mDerefUndoPart(hndl)->shndl);
					ID2Hndl(hndl, &mDerefUndoPart(hndl)->dhndl);
					break;
			}
			break;

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
			ccat   (cptr, "$10: TUndoPartObj:");
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $00: actionType = ");
			ccatdec(cptr, mDerefUndoPart(hndl)->actionType);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $02: shndl      = $");
			ccathex(cptr, '0', 8, 8, (long)mDerefUndoPart(hndl)->shndl);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $06: scnum      = ");
			ccatdec(cptr, mDerefUndoPart(hndl)->scnum);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $08: dhndl      = $");
			ccathex(cptr, '0', 8, 8, (long)mDerefUndoPart(hndl)->dhndl);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $0C: dcnum      = ");
			ccatdec(cptr, mDerefUndoPart(hndl)->dcnum);
			ccatchr(cptr, 13, 1);
			ccat   (cptr, "  $0E: deepCopy   = ");
			ccatdec(cptr, mDerefUndoPart(hndl)->deepCopy);
			return(true);
			break;

		default:
			break;
	}

	return(noErr);
}



