/*
	File:		ToolLoader.c

	Contains:	Routines to load, unload, and list all available tools

	Written by:	Richard Clark, Alan Lillich

	Copyright:	© 1993 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 1/13/94	RC		Added calls to parse a cfrg resource and
				 					thereby determine whether we have 68K or PowerPC
									code in the data fork or a resource. Also added
									code to support loading PowerPC tools from
									emulated 68K code.
									
				11/28/93	RC		Extracted from Muslin, and simplified
	To Do:
*/


#ifndef __FILES__
	#include <Files.h>
#endif

#ifndef __RESOURCES__
	#include <Resources.h>
#endif

#ifndef __LOWMEM__
	#include <LowMem.h>		// for MemError
#endif

#ifndef __ERRORS__
	#include <Errors.h>
#endif

#ifndef __MENUS__
	#include <Menus.h>
#endif

#ifndef __OSUTILS__
	#include <OSUtils.h>
#endif

#ifndef __TEXTUTILS__
	#include <TextUtils.h>
#endif

#ifndef __MIXEDMODE__
	#include <MixedMode.h>
#endif

#ifndef __FRAGLOAD__
	#include <FragLoad.h>
#endif


#include "ToolAPI.h"
#include "ModApp.h"
#include "Prototypes.h"
#include "cfrg.h"

enum {
		// Possible locations for our code
		kUnknown,
		kBuiltin,
		kInResource,
		kInDataFork
	};
	
	enum { kToolResType = 'TOOL' };
	


enum {
	rToolFolderNameSTR = 1001
	 };


// === Local prototypes
static OSErr GetFolderDirID (short volID, long parentDirID, StringPtr folderName, long* subFolderDirID);
static void GetLoaderInfo (FSSpec *toolSpec, short *codeType, short *codeLocation);

// -------- Global variables which are used only by this file
static short			toolFolderVol	= 0;
static long				toolFolderDirID = 0;

void InitToolLoader(void)
{
	// This routine is responsible for locating the tools sub-folder in the same folder as our application.
	// It needs to be called early in the initialization routine, before some other routine has had a chance
	// to change the default directory.
	OSErr			err;
	StringHandle	toolFolderName;
	long			appDirID;
	
	// Get the volume and folder information for this application
	// ??? Would it be better to get the app's resRefNum and look up the volume & dirID that way?
	err = HGetVol(NULL, &toolFolderVol, &appDirID);
	if (err) return; 								// HGetVol failed?!

	// Now, locate the subfolder in this folder
	toolFolderName = GetString(rToolFolderNameSTR);
	if (toolFolderName == NULL) return; 			// No folder name, so abort
	HLock((Handle)toolFolderName);
	err = GetFolderDirID (toolFolderVol, appDirID, (StringPtr)*toolFolderName, &toolFolderDirID);
	// Ignore the error, because it just indicates that the folder wasn't found. FindTools will
	// alert the user if this is the case.
	ReleaseResource((Handle)toolFolderName);
} /* InitToolLoader */


OSErr FindNamedTool (Str31 toolName, FSSpec *toolSpec)
// Find the named tool in our list of available tools
{
	OSErr	err;
	
	err = FSMakeFSSpec(toolFolderVol, toolFolderDirID, toolName, toolSpec);
	return err;
} /* FindNamedTool */


void GetToolNames (ToolInstallProcPtr InstallNameCallback)
// Iterate over the list of installed tools, calling the InstallNameCallback for each
{
	FSSpec			currTool;
	CInfoPBPtr		myCPB;           /* for the PBGetCatInfo call */
	Str31			fileName;
	short			index;
	OSErr			err;
	
	if ((toolFolderVol == 0) || (toolFolderDirID == 0)) {
//		AlertUser(kNeedsToolFolder);
// <<< Disable the tools menu?
		return; // Something wasn't initialized properly
	}
			
	// Walk through the folder, calling the callback for each file
	myCPB = (void*)NewPtrClear(sizeof(CInfoPBRec));
	if (err = MemError()) goto done;
	*fileName = '\0';	/* Empty the name */
	myCPB->hFileInfo.ioNamePtr = (StringPtr)&fileName;
	myCPB->hFileInfo.ioVRefNum = toolFolderVol;
	index = 1;
	err = noErr;
	do {
		myCPB->hFileInfo.ioFDirIndex= index;
		myCPB->hFileInfo.ioDirID= toolFolderDirID;	/* we need to do this every time    	*/
													/* through, since GetCatInfo       	 	*/
													/* returns ioFlNum in this field		*/
		myCPB->hFileInfo.filler2= 0;				/* Clear the ioACUser byte if search is	*/
													/* interested in it. Nonserver volumes won't  */
													/* clear it for you and the value returned is */
													/* meaningless. */
		err = PBGetCatInfoSync(myCPB);
		if (err == noErr) {
			if (((myCPB->hFileInfo.ioFlAttrib & ioDirMask) == 0) && (myCPB->hFileInfo.ioFlFndrInfo.fdCreator == kCreatorCode)) {
				/* we have a file, check the file type & add it to our menu */
				if (myCPB->hFileInfo.ioFlFndrInfo.fdType == kToolType) {
					FSMakeFSSpec(toolFolderVol, toolFolderDirID, myCPB->hFileInfo.ioNamePtr, &currTool);
					InstallNameCallback(currTool);
				}
			}
		}
		index++;	// Examine the next file
	} while (err == noErr);
	
done:
	DisposPtr((Ptr) myCPB);	// No need to check for a NULL pointer, as the Memory Mgr now does that
} /* GetToolNames */


	
void GetLoaderInfo (FSSpec *toolSpec, short *codeType, short *codeLocation)
// Determine what type of code we have, and whether the code is in the data fork
// or in a resource.
{
	short	refNum = -1;
	Handle	resourceScratch;
	
	*codeLocation = kUnknown;
	
	// We have to have a 'TOOL' resource and/or a 'cfrg' resource
	// so open the resource file
	refNum = FSpOpenResFile(toolSpec, fsRdPerm);
	if (ResError() != noErr) goto done;
	
	// Do we have a 'TOOL' resource?
	resourceScratch = Get1IndResource(kToolResType, 1);
	if (resourceScratch) {
		/* Assume it's 68K code (this will work on PowerPC even if the resource */
		/* is PowerPC code w/ a Routine Descriptor) */
		*codeLocation = kInResource;
		*codeType = kM68kISA;
	}
	
	if (gHasCFM) {
		// Do we have a 'cfrg' resource? If so, it could take precedence 
		// We'll look inside the 'cfrg' resource to get the code type and form
		irHand	parsedResource = NewHandleClear(sizeof(internalResource));
		
		resourceScratch = Get1Resource(kCFMRsrcType, kCFMRsrcID);
		if (ResError() || (resourceScratch == NULL)) goto done;
		
		if (parsedResource) {
			short location;
			
			Parse_cfrg(resourceScratch, parsedResource);
			
			// We could check the "usage" field to see if this is a drop in
			// (kIsDropIn == 2), but we won't bother, as the file type &
			// creator was enough of a clue, and the file wouldn't be in
			// the Modules menu if it wasn't a drop-in
			
			// Find out what type of code we have here
			if ((*parsedResource)->itemList[0].archType == 'pwpc')
				*codeType = kPowerPCISA;
			else // Other types haven't been defined, so assume 68K
				*codeType = kM68kISA;
			
			// Find out where the code is located
			location = (*parsedResource)->itemList[0].location;
			if (location == 1 /* kOnDiskFlat */)
				*codeLocation = kInDataFork;
			else if (location == 0 /* kInMem */) 
				*codeLocation = kInResource;
			
			DisposHandle((Handle)parsedResource);
		}
	}

done:
	if (refNum != -1)
		CloseResFile(refNum);
}


static OSErr LoadFromResource(FSSpec *toolSpec, short codeType, WindowPtr wp, ToolStartupProcPtr *toolStartup)
{
	OSErr				err;
	Handle				toolHandle;
 	short				refNum = -1;
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	short				resNum;

	Str255				errName;
	ConnectionID		connID;

	// Get the tool. 68K tools have a resource ID of 0, PowerPC tools have a resource ID
	// of 1
	if (codeType == kPowerPCISA)
		resNum = 1;
	else
		resNum = 0;
	
	refNum = FSpOpenResFile(toolSpec, fsCurPerm);
	if ((err = ResError()) == noErr) {
		// Get the tool and detach it from the resource file
		toolHandle = GetResource(kToolResType, resNum);
		if ((err = ResError()) == noErr) {
			DetachResource(toolHandle);
			MoveHHi(toolHandle); HLock(toolHandle);
			
			if (codeType == kPowerPCISA) {
				// This is PowerPC code, so it must be "prepared"
				err = GetMemFragment((Ptr)*toolHandle, 0, toolSpec->name, kLoadNewCopy, &connID, (Ptr*)toolStartup, errName);
				if (err) {
					DebugStr(errName);
					goto done;
				}
	
			} else {
				// This is 68K code, so just dereference the handle
				connID = 0;
				*toolStartup = (ToolStartupProcPtr)*toolHandle;
			}
		}
	}
	if (refNum != -1)									// Close the file if open
		CloseResFile(refNum);
		
	// Fill in some information in the DrawingWindowPeek record
	aWindow->toolResource = toolHandle;
	aWindow->connectionID = connID;	
	aWindow->toolLocation = kInResource;
	aWindow->toolSpec = *toolSpec;
		
done:	
	return err;
}


static OSErr LoadViaCFM (FSSpec *toolSpec, WindowPtr wp, ToolStartupProcPtr *toolStartup)
{
	// We've discoverd that our code is in the data fork of the fil, so ask the Code Fragment
	// Manager to load it.
	
	OSErr				err;
	Str255				errName;
	ConnectionID		connID;
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;

	// Use the CFM to load the tool, and return its entry point and a Connection ID
	if (!gHasCFM) {
		err = kCFMNotPresent;
		goto done;
	}
	
	err = GetDiskFragment(toolSpec, 0, 0, toolSpec->name, kLoadNewCopy, &connID, (Ptr*)toolStartup, errName);
	if (err) {
		DebugStr(errName);
		goto done;
	}
	
	// Fill in some information in the DrawingWindowPeek record
	aWindow->connectionID = connID;
	aWindow->toolResource = NULL;
	aWindow->toolLocation = kInDataFork;
	aWindow->toolSpec = *toolSpec;

done:	
	return err;
}

// We might want to call NewRoutineDescriptor from 68K code running emulated on a PowerPC.
// (This may seem strange, but what happens if the user installs the 68K ModApp with
// a "fat" module? We still want the full performance benefits of the module.) However,
// compiling the code for 68K causes MixedMode.h to insert a "dummy" version of
// NewRoutineDescriptor which doesn't actually allocate a routine descriptor. Therefore,
// we're defining an "inline" version here, only to be called if MixedMode is 
// actually present.
//
// N.B. Another solution would involve #defining USESROUTINEDESCRIPTORS before including
// 		MixedMode.h, but this could foul up the definitions in TOOLAPI.h.

#if USES68KINLINES
	pascal UniversalProcPtr InlineNewRoutineDescriptor(ProcPtr theProc, ProcInfoType theProcInfo, ISAType theISA)
 		= {0x303C, 0x0000, 0xAA59};
#endif

static OSErr InitializeTool(ToolStartupProcPtr toolStartup, WindowPtr wp, short codeType)
{
	// Execute the tool's startup sequence, which will fill in the table of routine pointers
	OSErr	err;
	
	if (toolStartup == NULL)
		return kGenericError;
	
	if (codeType == GetCurrentISA()) {
		// The module's code type and the application's code type match, so
		// make the call directly
		err = toolStartup(wp);
	} else {
		// The application and module are of different code types, so create
		// a routine descriptor, then call it
		ToolStartupUPP	startupUPP = NULL;
	
		// We better have Mixed Mode, or this won't work...
		if (!gHasMixedMode) {
			err = kMixedModeNotPresent;
			goto done;
		}
		
		#if USES68KINLINES
			startupUPP = (ToolStartupUPP)InlineNewRoutineDescriptor((ProcPtr)toolStartup, uppToolStartupProcInfo, codeType);
		#else
			startupUPP = (ToolStartupUPP)NewRoutineDescriptor(toolStartup, uppToolStartupProcInfo, codeType);
		#endif
		if (startupUPP) {
			err = CallToolStartupProc(startupUPP, wp);	// If compiled for 68K, this is a direct call. Otherwise, it uses CallUniversalProc
			DisposeRoutineDescriptor(startupUPP);
		}
	}

done:
	return err;
}

OSErr LoadTool (FSSpec *toolSpec, WindowPtr wp)
// Use the Code Fragment Manager to pull the specified tool into memory
// and attch it to the window
{
	// Locate the named tool in the folder and load it up
	Boolean				loadedOK = false;
	OSErr				err;
	short	 			codeType;
	short	 			codeLocation;
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;
	ToolStartupProcPtr	toolStartup;

	if (wp == NULL) return noErr;	// No window? Give up!
	SetPort(wp);
	// Determine if this tool should be pulled in via the CFM
	GetLoaderInfo (toolSpec, &codeType, &codeLocation);
	aWindow->toolLocation = codeLocation;
	switch (codeLocation) {
		case kUnknown:
			AlertUser(kCodeNotFound, 0);
			goto done;
		break;
		
		case kInResource:
			err = LoadFromResource (toolSpec, codeType, wp, &toolStartup);
		break;
		
		case kInDataFork:
			err = LoadViaCFM(toolSpec, wp, &toolStartup);
		break;
	}
	
	if (err == noErr) {
		err = InitializeTool(toolStartup, wp, codeType);
		aWindow->currMenuBar = GetMenuBar();
	}
	
	if (err) {
		// Let the user know if there was a problem in loading or initialization
		AlertUser(0, err);
		goto done;
	}
	
	SetWTitle(wp, toolSpec->name);
		
done:
	UseMenuBar(aWindow->currMenuBar);	// Make sure the menu handling tools know about our menu bar
	return err;
} /* LoadTool */


OSErr UnloadTool (WindowPtr wp)
// Remove this tool from memory (this assumes that the tool's shutdown routine has
// been called already
{
	OSErr				err = noErr;
	DrawingWindowPeek	aWindow = (DrawingWindowPeek)wp;

	if ((aWindow == NULL) || ((aWindow->connectionID == 0) && (aWindow->toolResource == NULL)))
		return noErr;	// No window? Give up!

	if (aWindow->toolRoutines.shutdownProc)
		CallToolShutdownProc(aWindow->toolRoutines.shutdownProc, wp);	// Call via Mixed Mode
	
	UseMenuBar(NULL);
	if (aWindow->currMenuBar) {
		DisposHandle(aWindow->currMenuBar);
		aWindow->currMenuBar = NULL;
	}

	if (gHasCFM && (aWindow->connectionID)) {
		// This tool was opened via the CFM, so close it via the CFM
		ConnectionID		connID;
		
		connID = aWindow->connectionID;
		err = CloseConnection(&connID);
	}
	
	if (aWindow->toolLocation == kInResource)
		// This tool was loaded in from a resource, so dump the handle
		DisposHandle((Handle)aWindow->toolResource);

	aWindow->toolRoutines.shutdownProc = NULL;
	aWindow->toolRoutines.menuAdjustProc = NULL;
	aWindow->toolRoutines.menuDispatchProc = NULL;
	aWindow->toolRoutines.toolIdleProc = NULL;
	aWindow->toolRoutines.toolUpdateProc = NULL;
	aWindow->toolRoutines.toolClickProc = NULL;
	aWindow->toolRoutines.toolWindowMovedProc = NULL;
	aWindow->toolRoutines.toolWindowResizedProc = NULL;
	aWindow->toolRoutines.toolWindowActivateProc = NULL;
	
	aWindow->connectionID = 0;
	aWindow->toolResource = NULL;
	aWindow->toolRefCon = 0;

	return err;
} /* UnloadTool */


// -------- Private routine used to scan a folder for a list of tool files	


static OSErr GetFolderDirID (short volID, long parentDirID, StringPtr folderName,
					   long* subFolderDirID)
{ 
	CInfoPBPtr	myCPBPtr;           /* for the PBGetCatInfo call */
	OSErr		err;
	
	myCPBPtr = (void*)NewPtrClear(sizeof(HFileInfo));
	if (err = MemError()) goto done;
	
	myCPBPtr->hFileInfo.ioNamePtr 	= folderName;
	myCPBPtr->hFileInfo.ioVRefNum 	= volID;
	myCPBPtr->hFileInfo.ioFDirIndex	= 0;
	myCPBPtr->hFileInfo.ioDirID		= parentDirID;
		
	err= PBGetCatInfoSync(myCPBPtr);
	if (err == noErr) {
		if ((myCPBPtr->hFileInfo.ioFlAttrib & ioDirMask) != 0) {   /* we have a directory */
			*subFolderDirID = myCPBPtr->hFileInfo.ioDirID;
		} else
			err = dirNFErr;	/* If this isn't a directory, signal "not found" */
	}

done:
	DisposPtr((Ptr)myCPBPtr);
	return err;
}
