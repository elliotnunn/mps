/*
 File Memory.c
 Copyright Apple Computer, Inc. 1985, 1986
 All rights reserved.

 * Memory - report the amount of free space in the
 * application and system heap, and on the boot volume.
 *
 * This is the sample C desk accessory.  The desk accessory does not
 * use any global variables.  Instead, it allocates a handle to a
 * structure that holds some "global" variables.  This sample program
 * could be written without having to use this structure, but then it
 * wouldn't be as informative...
 */
# include <types.h>
# include <osutils.h>				/* for devices.h */
# include <memory.h>				/* for THz */
# include <devices.h>				/* for DCtlPtr */
# include <events.h>				/* for EventRecord */
# include <quickdraw.h> 			/* for Rect */
# include <fonts.h> 				/* for monaco */
# include <windows.h>				/* for WindowPtr */
# include <files.h> 				/* for GetVolInfo() */

# define noErr	0			/* in lieu of <errors.h> */

/*
 * Macro to compute owned resource id
 */

# define OWNEDRSRCID(id)	(0xC000 | (((-(id)) - 1) << 5))

/*
 * String constant indexes for STR# resource
 */

# define	APPHEAP 1
# define	SYSHEAP 2
# define	DISK	3
# define	FREEON	4

/* This structure type holds the global variables used by this desk accessory */

typedef struct {
	int 	rsrcID; 		/* Computed rsrc id of STR# and WIND resources */
	char	strBuf[256];	/* Buffer to read strings into */
} Globals;

static char *text();

pascal short
DRVROpen(ctlPB, dCtl)
CntrlParam *ctlPB;
DCtlPtr dCtl;
{
	GrafPtr savePort;
	WindowPeek myWindow;
	long heapGrow;
	/*
	 * If the windowPtr is non-nil, we already have a window open.
	 * This desk accessory ignores multiple opens.
	 */
	if (dCtl->dCtlWindow != nil) return(noErr);

	GetPort(&savePort);
	
	/*
	 * Get a handle to some storage that will hold our pseudo-global
	 * variables.  Save the handle in a location accessible by
	 * all the driver routines.
	 */
	dCtl->dCtlStorage = NewHandle(sizeof(Globals));
	/*
	 * Compute the resource id of the owned 'STR#' resource that
	 * contains all of the program's text strings.  The id is saved
	 * in one place that can be accessed by all the driver routines.
	 */
	((Globals *)(*dCtl->dCtlStorage))->rsrcID = OWNEDRSRCID(dCtl->dCtlRefNum);
	
	/*
	 * wStorage = nil (allocate on the heap)
	 * visible = false, behind = -1, goAway = true, refCon = 0
	 */
	myWindow = GetNewWindow(((Globals *)(*dCtl->dCtlStorage))->rsrcID, nil, (WindowPtr) -1);
	/*
	 * Set windowKind to the DA refNum, which is negative.
	 */
	myWindow->windowKind = dCtl->dCtlRefNum;
	/*
	 * Store the windowPtr in the Device Control Entry
	 */
	dCtl->dCtlWindow = myWindow;
	/*
	 * Now compact the heap in the most violent way.
	 * Purge whatever's purgeable.
	 */
	(void) MaxMem(&heapGrow);

	SetPort(savePort);
	return(noErr);
}

pascal short
DRVRPrime(ctlPB, dCtl)
CntrlParam *ctlPB;
DCtlPtr dCtl;
{
	return(noErr);			/* Not used in this desk accessory */
}

pascal short
DRVRStatus(ctlPB, dCtl)
CntrlParam *ctlPB;
DCtlPtr dCtl;
{
	return(noErr);			/* Not used in this desk accessory */
}

pascal short
DRVRControl(ctlPB, dCtl)
CntrlParam *ctlPB;
DCtlPtr dCtl;
{
	extern void doCtlEvent(), doPeriodic();
	/*
	 * The current grafPort is saved & restored by the Desk Manager
	 */
	switch (ctlPB->csCode) {
		default:
			break;
		case 64:				/* accEvent */
			HLock(dCtl->dCtlStorage);	/* Lock handle since it will be dereferenced */
			doCtlEvent( *((EventRecord **) &ctlPB->csParam[0]),
					(Globals *)(*dCtl->dCtlStorage));
			HUnlock(dCtl->dCtlStorage);
			break;
		case 65:				/* periodicEvent */
			doPeriodic(dCtl);
			break;
	}
	return(0);
}

static void
doCtlEvent(theEvent, globals)
register EventRecord *theEvent;
Globals *globals;	/* Pointer to globals passed along the procedure call chain */
{
	extern void drawWindow();
	register WindowPtr myWindow;

	switch (theEvent->what) {
		default:
			break;
		case updateEvt:
			myWindow = (WindowPtr) theEvent->message;
			SetPort(myWindow);
			BeginUpdate(myWindow);
			drawWindow(myWindow, globals);
			EndUpdate(myWindow);
			break;
	}

	return;
}

static void
doPeriodic(dCtl)
DCtlPtr dCtl;
{
	extern void drawWindow();

	SetPort(dCtl->dCtlWindow);
	HLock(dCtl->dCtlStorage);	/* Lock handle since it will be dereferenced */
	drawWindow(dCtl->dCtlWindow, (Globals *)(*dCtl->dCtlStorage));
	HUnlock(dCtl->dCtlStorage);

	return;
}

/*
 * Display the contents of the window.
 * The current port is assumed to be set to the window.
 */
static void
drawWindow(window, globals)
WindowPtr window;
Globals *globals;	/* Pointer to globals passed along the procedure call chain */
{
	THz 			saveZone;
	char			volName[28];
	HVolumeParam	myParamBlk; 

	if (window == nil) return;		/* "can't happen" */

	TextMode(srcCopy);
	TextFont(monaco);
	TextSize(9);

	MoveTo(6, 10);
	TextFace(bold);

	saveZone = GetZone();

	DrawString(text(APPHEAP, globals));
	SetZone(ApplicZone());
	printNum(FreeMem());

	DrawString(text(SYSHEAP, globals));
	SetZone(SystemZone());
	printNum(FreeMem());

	SetZone(saveZone);

	DrawString(text(DISK, globals));
	myParamBlk.ioNamePtr = &volName[0];
	myParamBlk.ioVRefNum = 0;		/* Boot volume */
	myParamBlk.ioVolIndex = 0;
	(void) PBHGetVInfo(&myParamBlk, false);
	printNum(myParamBlk.ioVAlBlkSiz * myParamBlk.ioVFrBlk);

	DrawString(text(FREEON, globals));
	TextFace(underline);
	DrawString(p2cstr(volName));

	return;
}

static
printNum(num)
int num;
{
	char numStr[32];

	TextFace(normal);
	NumToString(num, numStr);
	DrawString(numStr);
	TextFace(bold);

	return;
}

pascal short
DRVRClose(ctlPB, dCtl)
char *ctlPB;
DCtlPtr dCtl;
{						/* Save & Restore current grafPort? */
	WindowPtr window;

	window = (WindowPtr) dCtl->dCtlWindow;
	if ( window != nil) {
		dCtl->dCtlWindow = nil;
		DisposeWindow(window);
	}

	return(0);
}

static char *
text(index, globals)
int index;
Globals *globals;	/* Pointer to globals passed along the procedure call chain */
{
	GetIndString(globals->strBuf, globals->rsrcID, index);
	return(globals->strBuf);
}
