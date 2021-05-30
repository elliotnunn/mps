/*
	File:		cfrg.c

	Contains:	Converts a 'cfrg' resource into an easily understood form

	Written by:	Richard Clark

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 1/13/94	RC		Created

	To Do:
*/

#ifndef __MEMORY__
	#include <Memory.h>
#endif

#ifndef __RESOURCES__
	#include <Resources.h>
#endif

#ifndef __STDDEF__
	#include <stddef.h>
#endif

#ifndef __STRING__
	#include <string.h>
#endif

#include "cfrg.h"


OSErr Parse_cfrg (Handle theResource, irHand internalCopy)
{
	// Copy the relevant items from the 'cfrg' resource into our internal format
	SignedByte	oldResourceState, oldInternalState;
	short		itemCount, index;
	Ptr			itemStart;
	long		headerSize = offsetof(cfrgHeader, arrayStart);
	OSErr		err = noErr;

	// Lock our original resource up high so we can access it easily
	oldResourceState = HGetState(theResource);
	MoveHHi(theResource); HLock(theResource);
	oldInternalState = HGetState(theResource);
	
	// set the size of the destination block
	itemCount = (*(hdrHand)theResource)->itemCount;
	SetHandleSize((Handle)internalCopy, offsetof(internalResource, itemList)
										+ itemCount * sizeof(internalItem));
	err = MemError();
	if (err) goto done;
	HLock((Handle)internalCopy);
	
	// Copy the relevant fields from the header
	(*internalCopy)->version = (*(hdrHand)theResource)->version;
	(*internalCopy)->itemCount = itemCount;
	
	// Transfer each item from the cfrg into the internal resource
	if (itemCount == 0) goto done;
	itemStart = &(*(hdrHand)theResource)->arrayStart;
	for (index = 0; index < itemCount; index++) {
		cfrgItem* 		srcItem;
		internalItem* 	dstItem;
		
		srcItem = (cfrgItem*)itemStart;
		dstItem = &(*internalCopy)->itemList[index];
		
		dstItem->archType		= srcItem->archType;
		dstItem->updateLevel	= srcItem->updateLevel;
		dstItem->currVersion	= srcItem->currVersion;
		dstItem->oldDefVersion	= srcItem->oldDefVersion;
		dstItem->appStackSize	= srcItem->appStackSize;
		dstItem->appSubFolder	= srcItem->appSubFolder;
		dstItem->usage			= srcItem->usage;
		dstItem->location		= srcItem->location;
		dstItem->codeOffset		= srcItem->codeOffset;
		dstItem->codeLength		= srcItem->codeLength;
		BlockMove(srcItem->name, dstItem->name, srcItem->name[0]+1);
		
		itemStart += srcItem->itemSize;
	}

done:
	HSetState(theResource, oldResourceState);
	HSetState((Handle)internalCopy, oldInternalState);
	return err;	
}

OSErr Build_cfrg (irHand internalCopy, Handle theResource)
{
	// Construct a cfrg resource from our internal template
	SignedByte		oldResourceState, oldInternalState;
	OSErr			err;
	unsigned long	headerSize =  offsetof(cfrgHeader, arrayStart);
	unsigned long	bytesCopied;
	short			itemCount, index;

	// Construct the header by setting the destination handle to that
	// size, clearing the memory, and then inserting the version and
	// item count values
	oldResourceState = HGetState(theResource);
	oldResourceState = HGetState((Handle)internalCopy);
	MoveHHi((Handle)internalCopy); HLock((Handle)internalCopy);
	
	SetHandleSize(theResource, headerSize);
	err = MemError();
	if (err) goto done;
	memset(*theResource, 0, headerSize);
	((cfrgHeader*)(*theResource))->version = (*internalCopy)->version;
	itemCount = (*internalCopy)->itemCount;
	((cfrgHeader*)(*theResource))->itemCount = itemCount;
	
	// Now, copy each item individually
	bytesCopied = headerSize;
	for (index = 0; index < itemCount; index++) {
		cfrgItem*		dstPtr;
		internalItem*	srcPtr;
		long			itemSize;
		unsigned long	newSize;
		
		// Calculate the size of this entry
		srcPtr = &(*internalCopy)->itemList[index];
		itemSize = offsetof(cfrgItem, name) + srcPtr->name[0] + 1;
		itemSize += itemSize & 0x0003;	// Pad up to the next multiple of 4
		
		// Extend and clear the handle
		newSize = bytesCopied + itemSize;
		SetHandleSize(theResource, newSize);
		err = MemError();
		if (err) goto done;
		dstPtr = (cfrgItem*)(((unsigned long)*theResource) + bytesCopied);
		memset((Ptr)dstPtr, 0, itemSize);
				
		// Transfer the individual fields
		dstPtr->archType		= srcPtr->archType;
		dstPtr->updateLevel		= srcPtr->updateLevel;
		dstPtr->currVersion		= srcPtr->currVersion;
		dstPtr->oldDefVersion	= srcPtr->oldDefVersion;
		dstPtr->appStackSize	= srcPtr->appStackSize;
		dstPtr->appSubFolder	= srcPtr->appSubFolder;
		dstPtr->usage			= srcPtr->usage;
		dstPtr->location		= srcPtr->location;
		dstPtr->codeOffset		= srcPtr->codeOffset;
		dstPtr->codeLength		= srcPtr->codeLength;
		dstPtr->itemSize		= itemSize;
		BlockMove(srcPtr->name, dstPtr->name, srcPtr->name[0] + 1);

		bytesCopied = newSize;
	}

done:
	HSetState(theResource, oldResourceState);
	HSetState((Handle)internalCopy, oldInternalState);
	return err;
}