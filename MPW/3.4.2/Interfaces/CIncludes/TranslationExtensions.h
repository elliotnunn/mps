/*
 	File:		TranslationExtensions.h
 
 	Contains:	Macintosh Easy Open Translation Extension Interfaces.
 
 	Version:	Technology:	Macintosh Easy Open 1.1
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __TRANSLATIONEXTENSIONS__
#define __TRANSLATIONEXTENSIONS__

#define kSupportsFileTranslation		1
#define kSupportsScrapTranslation		2
#define kTranslatorCanGenerateFilename	4

#ifndef REZ

#ifndef __MEMORY__
#include <Memory.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <MixedMode.h>										*/

#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <OSUtils.h>										*/
/*	#include <Finder.h>											*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <QuickdrawText.h>									*/

#ifndef __COMPONENTS__
#include <Components.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

typedef OSType FileType;

typedef ResType ScrapType;

typedef unsigned long TranslationAttributes;


enum {
	taDstDocNeedsResourceFork	= 1,
	taDstIsAppTranslation		= 2
};

struct FileTypeSpec {
	FileType						format;
	long							hint;
	TranslationAttributes			flags;						/* taDstDocNeedsResourceFork, taDstIsAppTranslation*/
	OSType							catInfoType;
	OSType							catInfoCreator;
};
typedef struct FileTypeSpec FileTypeSpec;

struct FileTranslationList {
	unsigned long					modDate;
	unsigned long					groupCount;
/* 	unsigned long	group1SrcCount;*/
/* 	unsigned long	group1SrcEntrySize = sizeof(FileTypeSpec);*/
/*  FileTypeSpec	group1SrcTypes[group1SrcCount]*/
/*  unsigned long	group1DstCount;*/
/*  unsigned long	group1DstEntrySize = sizeof(FileTypeSpec);*/
/*  FileTypeSpec	group1DstTypes[group1DstCount]*/
};
typedef struct FileTranslationList FileTranslationList;

typedef FileTranslationList *FileTranslationListPtr, **FileTranslationListHandle;

struct ScrapTypeSpec {
	ScrapType						format;
	long							hint;
};
typedef struct ScrapTypeSpec ScrapTypeSpec;

struct ScrapTranslationList {
	unsigned long					modDate;
	unsigned long					groupCount;
/* 	unsigned long		group1SrcCount;*/
/* 	unsigned long		group1SrcEntrySize = sizeof(ScrapTypeSpec);*/
/*  ScrapTypeSpec		group1SrcTypes[group1SrcCount]*/
/*  unsigned long		group1DstCount;*/
/* 	unsigned long		group1DstEntrySize = sizeof(ScrapTypeSpec);*/
/*  ScrapTypeSpec		group1DstTypes[group1DstCount]*/
};
typedef struct ScrapTranslationList ScrapTranslationList;

typedef ScrapTranslationList *ScrapTranslationListPtr, **ScrapTranslationListHandle;

/* definition of callbacks to update progress dialog*/
typedef long TranslationRefNum;

/*****************************************************************************************
*
* This routine sets the advertisement in the top half of the progress dialog.
* It is called once at the beginning of your DoTranslateFile routine.
*
* Enter:	refNum			Translation reference supplied to DoTranslateFile.
*			advertisement	A handle to the picture to display.  This must be non-purgable.
*							Before returning from DoTranslateFile, you should dispose
*							of the memory.  (Normally, it is in the temp translation heap
*							so it is cleaned up for you.)
*
* Exit:	returns			noErr, paramErr, or memFullErr
*/
extern pascal OSErr SetTranslationAdvertisement(TranslationRefNum refNum, PicHandle advertisement)
 TWOWORDINLINE(0x7002, 0xABFC);
/*****************************************************************************************
*
* This routine updates the progress bar in the progress dialog.
* It is called repeatedly from within your DoTranslateFile routine.
* It should be called often, so that the user will get feedback if he tries to cancel.
*
* Enter:	refNum		translation reference supplied to DoTranslateFile.
*			progress	percent complete (0-100)
*
* Exit:		canceled	TRUE if the user clicked the Cancel button, FALSE otherwise
*			returns		noErr, paramErr, or memFullErr
*/
extern pascal OSErr UpdateTranslationProgress(TranslationRefNum refNum, short percentDone, Boolean *canceled)
 TWOWORDINLINE(0x7001, 0xABFC);
/* ComponentMgr selectors for routines*/

enum {
	kTranslateGetFileTranslationList = 0,						/* component selectors*/
	kTranslateIdentifyFile,
	kTranslateTranslateFile,
	kTranslateGetTranslatedFilename,
	kTranslateGetScrapTranslationList = 10,						/* skip to scrap routines*/
	kTranslateIdentifyScrap,
	kTranslateTranslateScrap
};

/* Routines to implment in a file translation extension*/
typedef pascal ComponentResult (*DoGetFileTranslationListProcPtr)(ComponentInstance self, FileTranslationListHandle translationList);
typedef pascal ComponentResult (*DoIdentifyFileProcPtr)(ComponentInstance self, const FSSpec *theDocument, FileType *docType);
typedef pascal ComponentResult (*DoTranslateFileProcPtr)(ComponentInstance self, TranslationRefNum refNum, const FSSpec *sourceDocument, FileType srcType, long srcTypeHint, const FSSpec *dstDoc, FileType dstType, long dstTypeHint);
typedef pascal ComponentResult (*DoGetTranslatedFilenameProcPtr)(ComponentInstance self, FileType dstType, long dstTypeHint, FSSpec *theDocument);
/* Routine to implement in a scrap translation extension*/
typedef pascal ComponentResult (*DoGetScrapTranslationListProcPtr)(ComponentInstance self, ScrapTranslationListHandle list);
typedef pascal ComponentResult (*DoIdentifyScrapProcPtr)(ComponentInstance self, const void *dataPtr, Size dataLength, ScrapType *dataFormat);
typedef pascal ComponentResult (*DoTranslateScrapProcPtr)(ComponentInstance self, TranslationRefNum refNum, const void *srcDataPtr, Size srcDataLength, ScrapType srcType, long srcTypeHint, Handle dstData, ScrapType dstType, long dstTypeHint);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* REZ */
#endif /* __TRANSLATIONEXTENSIONS__ */
