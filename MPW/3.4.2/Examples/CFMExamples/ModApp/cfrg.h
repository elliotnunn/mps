/*
	File:		cfrg.h

	Contains:	Data structures which define the 'cfrg' resource format
				and a simplified version for ModApp's use.

	Written by:	Richard Clark

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 1/13/94	RC		Created

	To Do:
*/

#ifndef __CFRG__
#define __CFRG__

#ifndef __TYPES__
	#include <Types.h>
#endif


// The format of the 'cfrg' on disk. This is defined in <CodeFragmentTypes.r>
#ifdef powerc
	#pragma options align=mac68k
#endif

struct cfrgHeader {
	long 	res1;
	long 	res2;
	long 	version;
	long 	res3;
	long 	res4;
	long 	filler1;
	long 	filler2;
	long 	itemCount;
	char	arrayStart;	// Array of externalItems begins here
};
typedef struct cfrgHeader cfrgHeader, *hdrPtr, **hdrHand;

struct cfrgItem {
	OSType 	archType;
	long 	updateLevel;
	long	currVersion;
	long	oldDefVersion;
	long	appStackSize;
	short	appSubFolder;
	char	usage;
	char	location;
	long	codeOffset;
	long	codeLength;
	long	res1;
	long	res2;
	short	itemSize; // %4 == 0
	Str255	name;
	// Only make the final p-string as long as needed, then align to
	// a longword boundary
};
typedef struct cfrgItem cfrgItem;
#ifdef powerc
	#pragma options align=reset
#endif


// The structure of our simplified, editable version of the 'cfrg'
struct internalItem {
	OSType 	archType;
	long 	updateLevel;
	long	currVersion;
	long	oldDefVersion;
	long	appStackSize;
	short	appSubFolder;
	short	usage;
	short	location;
	long	codeOffset;
	long	codeLength;
	Str255	name;
};
typedef struct internalItem internalItem;

struct internalResource {
	long 			version;
	long 			itemCount;
	internalItem	itemList[1];
};
typedef struct internalResource internalResource, *irPtr, **irHand;

/* ===== Prototypes ===== */
OSErr Parse_cfrg (Handle theResource, irHand internalCopy);
OSErr Build_cfrg (irHand internalCopy, Handle theResource);


#endif /* __CFRG__ */
