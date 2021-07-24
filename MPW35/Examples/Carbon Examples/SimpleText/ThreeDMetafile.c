/*
	File:		ThreeDMetafile.c

	Contains:	3D viewer support for SimpleText

    Version:	Mac OS X

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

	Copyright © 1994-2001 Apple Computer, Inc., All Rights Reserved
*/

#include "MacIncludes.h"
#include <String.h>
#include <MixedMode.h>
#include "ThreeDMetafile.h"


#if ALLOW_QUICKTIME
static GlobalEntry	gProcPointers[] =
	{
	{uppViewerLibNewProcInfo, nil},
	{uppViewerLibDisposeProcInfo, nil},

	{uppViewerLibUseFileProcInfo, nil},
	{uppViewerLibUseDataProcInfo, nil},
	
	{uppViewerLibWriteFileProcInfo, nil},
	{uppViewerLibWriteDataProcInfo, nil},
	
	{uppViewerLibDrawProcInfo, nil},

	{uppViewerLibGetPictProcInfo, nil},
	{uppViewerLibGetButtonRectProcInfo, nil},

	{uppViewerLibGetDimensionProcInfo, nil},

	{uppViewerLibSetFlagsProcInfo, nil},
	{uppViewerLibGetFlagsProcInfo, nil},

	{uppViewerLibSetBoundsProcInfo, nil},
	{uppViewerLibGetBoundsProcInfo, nil},

	{uppViewerLibSetPortProcInfo, nil},
	{uppViewerLibGetPortProcInfo, nil},

	{uppViewerLibEventProcInfo, nil},
	{uppViewerLibAdjustCursorProcInfo, nil},

	{uppViewerLibGetStateProcInfo, nil},

	{uppViewerLibClearProcInfo, nil},
	{uppViewerLibCutProcInfo, nil},
	{uppViewerLibCopyProcInfo, nil},
	{uppViewerLibPasteProcInfo, nil}
	};	
#endif
	

// --------------------------------------------------------------------------------------------------------------
// PRIVATE ROUTINES
// --------------------------------------------------------------------------------------------------------------
static UniversalProcPtr MakeARoutineDescriptor(void *theProc, ProcInfoType theProcInfo)
/*
	The Symantec compiler doesn't like jumping into statically done routine descriptors,
	so we have to actually allocate them as pointers.  Sigh.
*/
{
	RoutineDescriptor rd /* = BUILD_ROUTINE_DESCRIPTOR(0, nil)*/;
	
	Ptr	newPtr;
	
	rd.routineRecords[0].procInfo = theProcInfo;
	rd.routineRecords[0].procDescriptor = theProc;
	rd.routineRecords[0].ISA = kPowerPCISA + kPowerPCRTA;
	newPtr = NewPtrClear(sizeof(rd));
	if (newPtr)
		BlockMove(&rd, newPtr, sizeof(rd));
	return((UniversalProcPtr) newPtr);
	
} // MakeARoutineDescriptor

// --------------------------------------------------------------------------------------------------------------
static void FillInEntryPoints(void)
{
#if ALLOW_QUICKTIME
	long				result;
	
	if ( 
		(Gestalt('qd3d', &result) == noErr) && 
		(Gestalt('sysa', &result) == noErr) && (result == 2) 
		)
		{
		CFragSymbolClass	symClass;
		CFragConnectionID	connID;
		Ptr 				mainAddr;
		Str255				errName;
		long				procID = 0;
		
		if (GetSharedLibrary("\pQD3DViewerLib", 'pwpc', 1, &connID, &mainAddr, errName) == noErr)
			{
			FindSymbol(connID, "\pQ3ViewerNew", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerDispose", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			
			FindSymbol(connID, "\pQ3ViewerUseFile", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerUseData", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerWriteFile", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerWriteData", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerDraw", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerGetPict", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerGetButtonRect", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerGetDimension", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerSetFlags", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerGetFlags", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerSetBounds", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerGetBounds", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerSetPort", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerGetPort", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerEvent", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerAdjustCursor", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerGetState", (Ptr*)&gProcPointers[procID++].entry, &symClass);

			FindSymbol(connID, "\pQ3ViewerClear", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerCut", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerCopy", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			FindSymbol(connID, "\pQ3ViewerPaste", (Ptr*)&gProcPointers[procID++].entry, &symClass);
			}
		
		// build the routine descriptors
		{
		short	i;
		
		for (i = 0; i < procID; ++i)
			gProcPointers[i].entry = MakeARoutineDescriptor(gProcPointers[i].entry, gProcPointers[i].info);
		}
		
		// as long as it isn't NIL, we're OK
		if (gProcPointers[0].entry)
			gMachineInfo.haveThreeD = true;
		}
#endif
} // FillInEntryPoints

// --------------------------------------------------------------------------------------------------------------
// OOP INTERFACE ROUTINES
// --------------------------------------------------------------------------------------------------------------

static OSErr ThreeDCloseWindow(
			WindowPtr pWindow, 
			WindowDataPtr pData)
{
#pragma unused (pWindow)

#if ALLOW_QUICKTIME
	ViewerLib_Dispose( ((ThreeDDataPtr)pData)->viewerObject);
#else
#pragma unused (pWindow, pData)
#endif

	return(noErr);
	
} // ThreeDCloseWindow

// --------------------------------------------------------------------------------------------------------------
static OSErr ThreeDGetBalloon(
			WindowPtr pWindow, 
			WindowDataPtr pData, 
			Point *localMouse,
			short * returnedBalloonIndex, 
			Rect *returnedRectangle)
{
#pragma unused (pWindow, pData, localMouse, returnedBalloonIndex, returnedRectangle)

	*returnedBalloonIndex = iDidTheBalloon;
	
	return(noErr);
	
} // ThreeDGetBalloon

// --------------------------------------------------------------------------------------------------------------
static Boolean	ThreeDFilterEvent(
			WindowPtr pWindow, 
			WindowDataPtr pData, 
			EventRecord *pEvent)
{
#pragma unused (pWindow)
	
#if ALLOW_QUICKTIME
	if (pEvent->what == activateEvt)
		{
		if (pEvent->modifiers & activeFlag)
			ViewerLib_SetFlags(((ThreeDDataPtr)pData)->viewerObject, ViewerLib_GetFlags(((ThreeDDataPtr)pData)->viewerObject) | kQ3ViewerActive);
		else
			ViewerLib_SetFlags(((ThreeDDataPtr)pData)->viewerObject, ViewerLib_GetFlags(((ThreeDDataPtr)pData)->viewerObject) & ~kQ3ViewerActive);
		}
		
	return((Boolean)ViewerLib_Event (((ThreeDDataPtr)pData)->viewerObject, pEvent));
#else
#pragma unused (pWindow, pData, pEvent)
	return false;
#endif
	
} // ThreeDFilterEvent


// --------------------------------------------------------------------------------------------------------------
static OSErr ThreeDAdjustCursor(WindowPtr pWindow, WindowDataPtr pData, Point *localMouse, RgnHandle globalRgn)
{
#pragma unused (pWindow, pData, localMouse, globalRgn)

	OSErr anErr = noErr;

#if ALLOW_QUICKTIME
	ViewerLib_AdjustCursor(((ThreeDDataPtr)pData)->viewerObject, localMouse);
	
	// since we don't know how the Viewer will adjust the cursor, make sure we get continuous calls
	SetEmptyRgn(globalRgn);
#endif
	
	return(eActionAlreadyHandled);
	
} // ThreeDAdjustCursor

// --------------------------------------------------------------------------------------------------------------
static OSErr ThreeDGetCoachRectangle(WindowPtr pWindow, WindowDataPtr pData, Rect *pRect, Ptr name)
{
#pragma unused (pWindow, pData, pRect, name)

	OSErr anErr = fnfErr;
	
#if ALLOW_QUICKTIME
	if (strcmp(name, "Camera") == 0)
		anErr = ViewerLib_GetButtonRect(((ThreeDDataPtr)pData)->viewerObject, kQ3ViewerButtonCamera, pRect);
	if (strcmp(name, "Truck") == 0)
		anErr = ViewerLib_GetButtonRect(((ThreeDDataPtr)pData)->viewerObject, kQ3ViewerButtonTruck, pRect);
	if (strcmp(name, "Orbit") == 0)
		anErr = ViewerLib_GetButtonRect(((ThreeDDataPtr)pData)->viewerObject, kQ3ViewerButtonOrbit, pRect);
	if (strcmp(name, "Zoom") == 0)
		anErr = ViewerLib_GetButtonRect(((ThreeDDataPtr)pData)->viewerObject, kQ3ViewerButtonZoom, pRect);
	if (strcmp(name, "Dolly") == 0)
		anErr = ViewerLib_GetButtonRect(((ThreeDDataPtr)pData)->viewerObject, kQ3ViewerButtonDolly, pRect);
#endif
			
	return(anErr);
	
} // ThreeDGetCoachRectangle

// --------------------------------------------------------------------------------------------------------------
void ThreeDGetFileTypes(
		OSType * pFileTypes,
		OSType * pDocumentTypes,
		short * numTypes)
{
#if ALLOW_QUICKTIME
	if (!gMachineInfo.haveThreeD)
		FillInEntryPoints();
		
	if (gMachineInfo.haveThreeD)
		{
		pFileTypes[*numTypes] 		= '3DMF';
		pDocumentTypes[*numTypes] 	= kThreeDWindow;
		(*numTypes)++;
		}
#else
#pragma unused (pFileTypes, pDocumentTypes, numTypes)
#endif
} // ThreeDGetFileTypes

// --------------------------------------------------------------------------------------------------------------
static OSErr	ThreeDUpdateWindow(WindowPtr pWindow, WindowDataPtr pData)
{
#pragma unused (pWindow, pData)

#if ALLOW_QUICKTIME
	ViewerLib_Draw(((ThreeDDataPtr)pData)->viewerObject);
#endif
	
	return(noErr);
	
} // ThreeDUpdateWindow

// --------------------------------------------------------------------------------------------------------------
static OSErr	ThreeDAdjustMenus(WindowPtr pWindow, WindowDataPtr pData)
{
#pragma unused (pWindow, pData)

	OSErr anErr = noErr;
	
#if ALLOW_QUICKTIME
	if (ViewerLib_GetState(((ThreeDDataPtr)pData)->viewerObject) ) 
		EnableCommand(cCopy);
#endif

	return(anErr);
	
} // ThreeDAdjustMenus

// --------------------------------------------------------------------------------------------------------------
static OSErr	ThreeDCommand(WindowPtr pWindow, WindowDataPtr pData, short commandID, long menuResult)
{
#pragma unused (menuResult)

#if ALLOW_QUICKTIME
	OSErr						anErr = noErr;
	ViewerObject			 	theViewer = ((ThreeDDataPtr)pData)->viewerObject;
	
	SetPortWindowPort (pWindow);

	switch (commandID) 
		{
		case cCopy:
			anErr = ViewerLib_Copy(theViewer);
			if (anErr == noErr)
				anErr = eActionAlreadyHandled;
			break;
		} // switch (commandID)
	return(anErr);
#else
#pragma unused (pWindow, pData, commandID, menuResult)
	return(noErr);
#endif
	
} // ThreeDCommand

// --------------------------------------------------------------------------------------------------------------
static OSErr	ThreeDMakeWindow(
			WindowPtr pWindow,
			WindowDataPtr pData)
{

#if ALLOW_QUICKTIME
	OSErr						anErr = noErr;
	ViewerObject				viewerObj;

	pData->pCloseWindow 		= (CloseWindowProc)			ThreeDCloseWindow;
	pData->pFilterEvent 		= (FilterEventProc)			ThreeDFilterEvent;
	pData->pGetBalloon 			= (GetBalloonProc)			ThreeDGetBalloon;
	pData->pUpdateWindow 		= (UpdateWindowProc)		ThreeDUpdateWindow;
	pData->pAdjustMenus 		= (AdjustMenusProc)			ThreeDAdjustMenus;
	pData->pCommand	 			= (CommandProc)				ThreeDCommand;
	pData->pAdjustCursor 		= (AdjustCursorProc)		ThreeDAdjustCursor;
	pData->pGetCoachRectangle	= (GetCoachRectangleProc)	ThreeDGetCoachRectangle;

	pData->dragWindowAligned	= 0;
	
	viewerObj = ViewerLib_New((CGrafPtr )pWindow,  &pData->contentRect,  kQ3ViewerDefault | kQ3ViewerDraggingOff); 

	if (viewerObj == 0)
		{
		anErr = memFullErr;
		}
	else
		{
		anErr = ViewerLib_UseFile(viewerObj, pData->dataRefNum);
		if (anErr == noErr)
			((ThreeDDataPtr)pData)->viewerObject = viewerObj;
		else
			ViewerLib_Dispose(viewerObj);
		
		}
	return(anErr);
#else
#pragma unused (pWindow, pData)
	return(noErr);
#endif
	
	
} // ThreeDMakeWindow

// --------------------------------------------------------------------------------------------------------------
OSStatus	ThreeDPreflightWindow(PreflightPtr pPreflightData)
{	
#if ALLOW_QUICKTIME
	pPreflightData->continueWithOpen 	= true;
	pPreflightData->makeProcPtr 		= ThreeDMakeWindow;
	pPreflightData->resourceID			= kThreeDWindowID;
	pPreflightData->storageSize 		= sizeof(ThreeDDataRecord);
#else
#pragma unused (pPreflightData)
#endif

	return(noErr);
	
} // ThreeDPreflightWindow
