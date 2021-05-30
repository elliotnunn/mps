/*
	File:		OpenTptCommon.h

	Contains:	Equates for Open Transport development needed both by clients
				and by kernel.

	Copyright:	© 1993-1996 by Apple Computer, Inc. and Mentat Inc., all rights reserved.


*/

#ifndef __OPENTPTCOMMON__
#define __OPENTPTCOMMON__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

#if defined(__MWERKS__) && GENERATING68K
#pragma pointers_in_D0
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


/*******************************************************************************
** Bitmap functions
**
** These functions atomically deal with a bitmap that is multiple-bytes long
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif
	//
	// Set the first clear bit in "bitMap", starting with bit "startBit",
	// giving up after "numBits".  Returns the bit # that was set, or
	// a kOTNotFoundErr if there was no clear bit available
	//
	extern OTResult	OTSetFirstClearBit(UInt8* bitMap, size_t startBit, size_t numBits);
	//
	// Standard clear, set and test bit functions
	//
	extern Boolean	OTClearBit(UInt8* bitMap, size_t bitNo);
	extern Boolean	OTSetBit(UInt8* bitMap, size_t bitNo);
	extern Boolean	OTTestBit(UInt8* bitMap, size_t bitNo);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** OTHashList
**
** This implements a simple, but efficient hash list.  It is not
** thread-safe.
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

	typedef struct OTHashList	OTHashList;

	typedef UInt32 (*OTHashProcPtr)(OTLink* linkToHash);
	typedef Boolean (*OTHashSearchProcPtr)(const void* ref, OTLink* linkToCheck);

	//
	// Return the number of bytes of memory needed to create a hash list
	// of at least "numEntries" entries.
	//
	extern size_t		OTCalculateHashListMemoryNeeds(size_t numEntries);
	//
	// Create an OTHashList from "memory".  Return an error if it
	// couldn't be done.
	//
	extern OTResult		OTInitHashList(void* memory, size_t numBytes, OTHashProcPtr);
	extern void			OTAddToHashList(OTHashList*, OTLink*);
	extern Boolean		OTRemoveLinkFromHashList(OTHashList*, OTLink*);
	extern Boolean		OTIsInHashList(OTHashList*, OTLink*);
	extern OTLink*		OTFindInHashList(OTHashList*, OTHashSearchProcPtr proc,
										 const void* refPtr, UInt32 hashValue);
	extern OTLink*		OTRemoveFromHashList(OTHashList*, OTHashSearchProcPtr proc,
											 const void* refPtr, UInt32 hashValue);

	struct OTHashList
	{
		OTHashProcPtr		fHashProc;
		size_t				fHashTableSize;
		OTLink**			fHashBuckets;

#ifdef __cplusplus
			void		Add(OTLink* toAdd)
							{ OTAddToHashList(this, toAdd); }
							
			Boolean		RemoveLink(OTLink* toRemove)
							{ return OTRemoveLinkFromHashList(this, toRemove); }
							
			OTLink*		Remove(OTHashSearchProcPtr proc,
							   const void* refPtr, UInt32 hashValue)
							{ return OTRemoveFromHashList(this, proc, refPtr, hashValue); }
							
			Boolean		IsInList(OTLink* toFind)
							{ return OTIsInHashList(this, toFind); }
							
			OTLink*		FindLink(OTHashSearchProcPtr proc, const void* refPtr,
								 UInt32 hash)
							{	return OTFindInHashList(this, proc, refPtr, hash); }
#endif
	};

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** Random functions
** 
** These implement a very simple random number generator
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

	extern UInt32	OTGetRandomSeed();
	extern UInt32	OTGetRandomNumber(UInt32* seed, UInt32 lo, UInt32 hi);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** A simple gating mechanism to singly thread processing of requests.
**
** Remember - this structure must be on a 4-byte boundary.
********************************************************************************/

typedef Boolean	(*OTGateProcPtr)(OTLink*);

struct OTGate
{
	OTLIFO			fLIFO;
	OTList			fList;
	OTGateProcPtr	fProc;
	SInt32			fNumQueued;
	SInt32			fInside;
};

typedef struct OTGate	OTGate;

#ifdef __cplusplus
extern "C" {
#endif

extern void		OTInitGate(OTGate*, OTGateProcPtr proc);
extern Boolean	OTEnterGate(OTGate*, OTLink*);
extern Boolean	OTLeaveGate(OTGate*);

#ifdef __cplusplus
}
#endif

#if defined(__MWERKS__) && GENERATING68K
#pragma pointers_in_A0
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#endif
