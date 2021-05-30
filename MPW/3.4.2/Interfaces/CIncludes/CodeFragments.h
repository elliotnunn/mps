/*
 	File:		CodeFragments.h
 
 	Contains:	Code Fragment Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __CODEFRAGMENTS__
#define __CODEFRAGMENTS__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <MixedMode.h>										*/
/*	#include <OSUtils.h>										*/
/*		#include <Memory.h>										*/
/*	#include <Finder.h>											*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	kCFragResourceType			= 'cfrg',
	kCFragResourceID			= 0,
	kCFragLibraryFileType		= 'shlb'
};

typedef OSType CFragArchitecture;


enum {
	kPowerPCCFragArch			= 'pwpc',
	kMotorola68KCFragArch		= 'm68k',
	kAnyCFragArch				= 0x3F3F3F3F
};

#if GENERATINGPOWERPC
enum {
	kCurrentCFragArch			= kPowerPCCFragArch
};

#endif
#if GENERATING68K	
enum {
	kCurrentCFragArch			= kMotorola68KCFragArch
};

#endif
typedef UInt32 CFragConnectionID;

typedef UInt32 CFragClosureID;

typedef UInt32 CFragContextID;

typedef UInt32 CFragContainerID;

typedef UInt32 CFragLoadOptions;


enum {
	kLoadCFrag					= 0x01,							/* Try to use existing copy, load if not found.*/
	kFindCFrag					= 0x02,							/* Try find an existing copy, don't load if not found.*/
	kNewCFragCopy				= 0x05,							/* Load a new copy whether one already exists or not.*/
	kInplaceCFrag				= 0x80							/* Use data sections directly in the container.*/
};

enum {
	kUnresolvedCFragSymbolAddress = 0
};

typedef UInt8 CFragSymbolClass;


enum {
	kCodeCFragSymbol			= 0,
	kDataCFragSymbol			= 1,
	kTVectorCFragSymbol			= 2,
	kTOCCFragSymbol				= 3,
	kGlueCFragSymbol			= 4
};

typedef UInt8 CFragUsage;


enum {
	kImportLibraryCFrag			= 0,							/* Standard CFM import library.*/
	kApplicationCFrag			= 1,							/* Macintosh application.*/
	kDropInAdditionCFrag		= 2								/* Private extension to an application or library.*/
};

enum {
	kIsCompleteCFrag			= 0,							/* A "base" fragment, not an update.*/
	kFirstCFragUpdate			= 1								/* The first update, others are numbered 2, 3, ...*/
};

typedef UInt8 CFragLocatorKind;


enum {
	kMemoryCFragLocator			= 0,							/* Container is already addressable.*/
	kDataForkCFragLocator		= 1,							/* Container is in a file's data fork.*/
	kResourceCFragLocator		= 2,							/* Container is in a file's resource fork.*/
	kByteStreamCFragLocator		= 3								/* Container is in a given file fork as a byte stream.*/
};

#define IsFileLocation(where) 	\
	( ((where) == kDataForkCFragLocator)	||  \
	((where) == kResourceCFragLocator)	||  \
	((where) == kByteStreamCFragLocator) )
enum {
	kCFragGoesToEOF				= 0
};

struct CFragOldMemoryLocator {
	LogicalAddress					address;
	UInt32							length;
	Boolean							inPlace;
	UInt8							reserved3a[3];				/* ! Do not use this!*/
};

typedef struct CFragOldMemoryLocator CFragOldMemoryLocator;

struct CFragHFSDiskFlatLocator {
	FSSpecPtr						fileSpec;
	UInt32							offset;
	UInt32							length;
};
typedef struct CFragHFSDiskFlatLocator CFragHFSDiskFlatLocator;

/* ! This must have a file specification at the same offset as a data fork locator!*/
struct CFragHFSSegmentedLocator {
	FSSpecPtr						fileSpec;
	OSType							rsrcType;
	SInt16							rsrcID;
	UInt16							reserved2a;					/* ! Do not use this!*/
};

typedef struct CFragHFSSegmentedLocator CFragHFSSegmentedLocator;

struct CFragHFSLocator {
	SInt32							where;						/* Really of type CFragLocatorKind.*/
	union {
		CFragHFSDiskFlatLocator			onDisk;					/* First so debugger shows this form.*/
		CFragOldMemoryLocator			inMem;
		CFragHFSSegmentedLocator		inSegs;
	} u;
};

typedef struct CFragHFSLocator CFragHFSLocator;

typedef CFragHFSLocator *CFragHFSLocatorPtr;

/* -------------------------------------------------------------------------------------------*/
/* The parameter block passed to fragment initialization functions.  The locator and name*/
/* pointers are valid only for the duration of the initialization routine.  I.e. if you want*/
/* to save the locator or name, save the contents, not the pointers.  Initialization routines*/
/* take one parameter, a pointer to the parameter block, and return a success/failure result.*/
/* ! Note that the initialization function returns an OSErr.  Any result other than noErr will*/
/* ! cause the entire load to be aborted at that point.*/
struct CFragInitBlock {
	CFragContextID					contextID;
	CFragClosureID					closureID;
	CFragConnectionID				connectionID;
	CFragHFSLocator					fragLocator;
	StringPtr						libName;
	UInt32							reserved4a;					/* ! Do not use this!*/
	UInt32							reserved4b;					/* ! Do not use this!*/
	UInt32							reserved4c;					/* ! Do not use this!*/
	UInt32							reserved4d;					/* ! Do not use this!*/
};
typedef struct CFragInitBlock CFragInitBlock;

typedef CFragInitBlock *CFragInitBlockPtr;

typedef pascal OSErr CFragInitFunction(const CFragInitBlock *theInitBlock);
typedef pascal void CFragTermRoutine(void);
typedef CFragInitFunction *CFragInitFunctionPtr;

typedef CFragTermRoutine *CFragTermRoutinePtr;

/* §*/
/* ===========================================================================================*/
/* Routines*/
/* ========*/
extern pascal OSErr GetSharedLibrary(ConstStr63Param libName, OSType archType, CFragLoadOptions loadFlags, CFragConnectionID *connID, Ptr *mainAddr, Str255 errMessage)
 THREEWORDINLINE(0x3F3C, 0x0001, 0xAA5A);
extern pascal OSErr GetDiskFragment(const FSSpec *fileSpec, UInt32 offset, UInt32 length, ConstStr63Param fragName, CFragLoadOptions loadFlags, CFragConnectionID *connID, Ptr *mainAddr, Str255 errMessage)
 THREEWORDINLINE(0x3F3C, 0x0002, 0xAA5A);
extern pascal OSErr GetMemFragment(void *memAddr, UInt32 length, ConstStr63Param fragName, CFragLoadOptions loadFlags, CFragConnectionID *connID, Ptr *mainAddr, Str255 errMessage)
 THREEWORDINLINE(0x3F3C, 0x0003, 0xAA5A);
extern pascal OSErr CloseConnection(CFragConnectionID *connID)
 THREEWORDINLINE(0x3F3C, 0x0004, 0xAA5A);
extern pascal OSErr FindSymbol(CFragConnectionID connID, ConstStr255Param symName, Ptr *symAddr, CFragSymbolClass *symClass)
 THREEWORDINLINE(0x3F3C, 0x0005, 0xAA5A);
extern pascal OSErr CountSymbols(CFragConnectionID connID, long *symCount)
 THREEWORDINLINE(0x3F3C, 0x0006, 0xAA5A);
extern pascal OSErr GetIndSymbol(CFragConnectionID connID, long symIndex, Str255 symName, Ptr *symAddr, CFragSymbolClass *symClass)
 THREEWORDINLINE(0x3F3C, 0x0007, 0xAA5A);
#if OLDROUTINENAMES
typedef CFragConnectionID ConnectionID;

typedef CFragLoadOptions LoadFlags;

typedef CFragSymbolClass SymClass;

typedef CFragOldMemoryLocator MemFragment;

typedef CFragHFSDiskFlatLocator DiskFragment;

typedef CFragHFSSegmentedLocator SegmentedFragment;

typedef CFragHFSLocator FragmentLocator;

typedef CFragHFSLocatorPtr FragmentLocatorPtr;

typedef CFragInitBlock InitBlock;

typedef CFragInitBlockPtr InitBlockPtr;

typedef CFragInitFunction ConnectionInitializationRoutine;

typedef CFragTermRoutine ConnectionTerminationRoutine;


enum {
	kPowerPCArch				= kPowerPCCFragArch,
	kMotorola68KArch			= kMotorola68KCFragArch,
	kAnyArchType				= kAnyCFragArch,
	kNoLibName					= 0,
	kNoConnectionID				= 0,
	kLoadLib					= kLoadCFrag,
	kFindLib					= kFindCFrag,
	kLoadNewCopy				= kNewCFragCopy,
	kUseInPlace					= kInplaceCFrag,
	kCodeSym					= kCodeCFragSymbol,
	kDataSym					= kDataCFragSymbol,
	kTVectSym					= kTVectorCFragSymbol,
	kTOCSym						= kTOCCFragSymbol,
	kGlueSym					= kGlueCFragSymbol,
	kInMem						= kMemoryCFragLocator,
	kOnDiskFlat					= kDataForkCFragLocator,
	kOnDiskSegmented			= kResourceCFragLocator,
	kIsLib						= kImportLibraryCFrag,
	kIsApp						= kApplicationCFrag,
	kIsDropIn					= kDropInAdditionCFrag,
	kFullLib					= kIsCompleteCFrag,
	kUpdateLib					= kFirstCFragUpdate,
	kWholeFork					= kCFragGoesToEOF,
	kCFMRsrcType				= kCFragResourceType,
	kCFMRsrcID					= kCFragResourceID,
	kSHLBFileType				= kCFragLibraryFileType,
	kUnresolvedSymbolAddress	= kUnresolvedCFragSymbolAddress
};

enum {
	kPowerPC					= kPowerPCCFragArch,
	kMotorola68K				= kMotorola68KCFragArch
};

#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CODEFRAGMENTS__ */
