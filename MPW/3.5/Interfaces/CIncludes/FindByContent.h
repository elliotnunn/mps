/*
     File:       FindByContent.h
 
     Contains:   Public search interface for the Find by Content shared library
 
     Version:    Technology: 2.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __FINDBYCONTENT__
#define __FINDBYCONTENT__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif



#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif


/*
   ***************************************************************************
   Language constants used with FBCIndexItemsInLanguages: these numbers are bits
   in a 64-bit array that consists of two UInt32 words.  In the current implementation
   the low word is always 0, so values for the high word are given.  If both UInt32
   words are 0, the default value of kDefaultLanguagesHighWord is used.
   ***************************************************************************
*/
enum {
                                        /* languages that use the Roman character mapping*/
  englishHighWord               = (long)0x80000000,
  dutchHighWord                 = 0x40000000, /* also Afrikaans*/
  germanHighWord                = 0x20000000,
  swedishHighWord               = 0x10000000, /* also Norwegian*/
  danishHighWord                = 0x08000000,
  spanishHighWord               = 0x04000000, /* also Catalan*/
  portugueseHighWord            = 0x02000000,
  italianHighWord               = 0x01000000,
  frenchHighWord                = 0x00800000,
  romanHighWord                 = 0x00400000, /* other languages using Roman alphabet*/
                                        /* Languages that use other mappings*/
  icelandicHighWord             = 0x00200000, /* also Faroese*/
  hebrewHighWord                = 0x00100000, /* also Yiddish*/
  arabicHighWord                = 0x00080000, /* also Farsi, Urdu*/
  centeuroHighWord              = 0x00040000, /* Central European languages not using Cyrillic*/
  croatianHighWord              = 0x00020000,
  turkishHighWord               = 0x00010000,
  romanianHighWord              = 0x00008000,
  greekHighWord                 = 0x00004000,
  cyrillicHighWord              = 0x00002000, /* all languages using Cyrillic*/
  devanagariHighWord            = 0x00001000,
  gujuratiHighWord              = 0x00000800,
  gurmukhiHighWord              = 0x00000400,
  japaneseHighWord              = 0x00000200,
  koreanHighWord                = 0x00000100,
  kDefaultLanguagesHighWord     = (long)0xFF800000 /* sum of first 9*/
};


/*
   ***************************************************************************
   Phase values
   These values are passed to the client's callback function to indicate what
   the FBC code is doing.
   ***************************************************************************
*/
enum {
                                        /* indexing phases*/
  kFBCphIndexing                = 0,
  kFBCphFlushing                = 1,
  kFBCphMerging                 = 2,
  kFBCphMakingIndexAccessor     = 3,
  kFBCphCompacting              = 4,
  kFBCphIndexWaiting            = 5,    /* access phases*/
  kFBCphSearching               = 6,
  kFBCphMakingAccessAccessor    = 7,
  kFBCphAccessWaiting           = 8,    /* summarization*/
  kFBCphSummarizing             = 9,    /* indexing or access*/
  kFBCphIdle                    = 10,
  kFBCphCanceling               = 11
};



/*
   ***************************************************************************
   Pointer types
   These point to memory allocated by the FBC shared library, and must be deallocated
   by calls that are defined below.
   ***************************************************************************
*/

/* A collection of state information for searching*/
typedef struct OpaqueFBCSearchSession*  FBCSearchSession;
/* An ordinary C string (used for hit/doc terms)*/
typedef char *                          FBCWordItem;
/* An array of WordItems*/
typedef FBCWordItem *                   FBCWordList;
/*
   ***************************************************************************
   Callback function type for progress reporting and cancelation during
   searching and indexing.  The client's callback function should call
   WaitNextEvent; a "sleep" value of 1 is suggested.  If the callback function
   wants to cancel the current operation (indexing, search, or doc-terms
   retrieval) it should return true.
   ***************************************************************************
*/

typedef CALLBACK_API_C( Boolean , FBCCallbackProcPtr )(UInt16 phase, float percentDone, void *data);
typedef TVECTOR_UPP_TYPE(FBCCallbackProcPtr)                    FBCCallbackUPP;
/*
 *  NewFBCCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( FBCCallbackUPP )
NewFBCCallbackUPP(FBCCallbackProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppFBCCallbackProcInfo = 0x00000F91 };  /* 1_byte Func(2_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline FBCCallbackUPP NewFBCCallbackUPP(FBCCallbackProcPtr userRoutine) { return userRoutine; }
  #else
    #define NewFBCCallbackUPP(userRoutine) (userRoutine)
  #endif
#endif

/*
 *  DisposeFBCCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeFBCCallbackUPP(FBCCallbackUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeFBCCallbackUPP(FBCCallbackUPP) {}
  #else
    #define DisposeFBCCallbackUPP(userUPP)
  #endif
#endif

/*
 *  InvokeFBCCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
InvokeFBCCallbackUPP(
  UInt16          phase,
  float           percentDone,
  void *          data,
  FBCCallbackUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline Boolean InvokeFBCCallbackUPP(UInt16 phase, float percentDone, void * data, FBCCallbackUPP userUPP) { return (*userUPP)(phase, percentDone, data); }
  #else
    #define InvokeFBCCallbackUPP(phase, percentDone, data, userUPP) (*userUPP)(phase, percentDone, data)
  #endif
#endif

/*
   ***************************************************************************
   Set the callback function for progress reporting and cancelation during
   searching and indexing, and set the amount of heap space to reserve for
   the client's use when FBC allocates memory.
   ***************************************************************************
*/
/*
 *  FBCSetCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
FBCSetCallback(
  FBCCallbackUPP   fn,
  void *           data);


/*
 *  FBCSetHeapReservation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
FBCSetHeapReservation(UInt32 bytes);


/*
   ***************************************************************************
   Find out whether a volume is indexed, the date & time of its last
   completed  update, and its physical size.
   ***************************************************************************
*/

/*
 *  FBCVolumeIsIndexed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
FBCVolumeIsIndexed(SInt16 theVRefNum);


/*
 *  FBCVolumeIsRemote()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
FBCVolumeIsRemote(SInt16 theVRefNum);


/*
 *  FBCVolumeIndexTimeStamp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCVolumeIndexTimeStamp(
  SInt16    theVRefNum,
  UInt32 *  timeStamp);


/*
 *  FBCVolumeIndexPhysicalSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCVolumeIndexPhysicalSize(
  SInt16    theVRefNum,
  UInt32 *  size);


/*
   ***************************************************************************
   Create & configure a search session
   ***************************************************************************
*/

/*
 *  FBCCreateSearchSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCCreateSearchSession(FBCSearchSession * searchSession);


/*
 *  FBCAddAllVolumesToSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCAddAllVolumesToSession(
  FBCSearchSession   theSession,
  Boolean            includeRemote);


/*
 *  FBCSetSessionVolumes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCSetSessionVolumes(
  FBCSearchSession   theSession,
  const SInt16       vRefNums[],
  UInt16             numVolumes);


/*
 *  FBCAddVolumeToSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCAddVolumeToSession(
  FBCSearchSession   theSession,
  SInt16             vRefNum);


/*
 *  FBCRemoveVolumeFromSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCRemoveVolumeFromSession(
  FBCSearchSession   theSession,
  SInt16             vRefNum);


/*
 *  FBCGetSessionVolumeCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCGetSessionVolumeCount(
  FBCSearchSession   theSession,
  UInt16 *           count);


/*
 *  FBCGetSessionVolumes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCGetSessionVolumes(
  FBCSearchSession   theSession,
  SInt16             vRefNums[],
  UInt16 *           numVolumes);


/*
 *  FBCCloneSearchSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCCloneSearchSession(
  FBCSearchSession    original,
  FBCSearchSession *  clone);


/*
   ***************************************************************************
   Execute a search
   ***************************************************************************
*/

/*
 *  FBCDoQuerySearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCDoQuerySearch(
  FBCSearchSession   theSession,
  char *             queryText,
  const FSSpec       targetDirs[],
  UInt32             numTargets,
  UInt32             maxHits,
  UInt32             maxHitWords);


/*
 *  FBCDoCFStringSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCDoCFStringSearch(
  FBCSearchSession   theSession,
  CFStringRef        queryString,
  const FSSpec       targetDirs[],
  UInt32             numTargets,
  UInt32             maxHits,
  UInt32             maxHitWords);


/*
 *  FBCDoExampleSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCDoExampleSearch(
  FBCSearchSession   theSession,
  const UInt32 *     exampleHitNums,
  UInt32             numExamples,
  const FSSpec       targetDirs[],
  UInt32             numTargets,
  UInt32             maxHits,
  UInt32             maxHitWords);


/*
 *  FBCBlindExampleSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCBlindExampleSearch(
  FSSpec              examples[],
  UInt32              numExamples,
  const FSSpec        targetDirs[],
  UInt32              numTargets,
  UInt32              maxHits,
  UInt32              maxHitWords,
  Boolean             allIndexes,
  Boolean             includeRemote,
  FBCSearchSession *  theSession);



/*
   ***************************************************************************
   Get information about hits [wrapper for THitItem C++ API]
   ***************************************************************************
*/

/*
 *  FBCGetHitCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCGetHitCount(
  FBCSearchSession   theSession,
  UInt32 *           count);


/*
 *  FBCGetHitDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCGetHitDocument(
  FBCSearchSession   theSession,
  UInt32             hitNumber,
  FSSpec *           theDocument);


/*
 *  FBCGetHitDocumentRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCGetHitDocumentRef(
  FBCSearchSession   theSession,
  UInt32             hitNumber,
  FSRef *            theDocument);


/*
 *  FBCGetHitScore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCGetHitScore(
  FBCSearchSession   theSession,
  UInt32             hitNumber,
  float *            score);


/*
 *  FBCGetMatchedWords()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCGetMatchedWords(
  FBCSearchSession   theSession,
  UInt32             hitNumber,
  UInt32 *           wordCount,
  FBCWordList *      list);


/*
 *  FBCGetTopicWords()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCGetTopicWords(
  FBCSearchSession   theSession,
  UInt32             hitNumber,
  UInt32 *           wordCount,
  FBCWordList *      list);



/*
   ***************************************************************************
   Summarize a buffer of text
   ***************************************************************************
*/

/*
 *  FBCSummarize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCSummarize(
  void *    inBuf,
  UInt32    inLength,
  void *    outBuf,
  UInt32 *  outLength,
  UInt32 *  numSentences);


/*
   ***************************************************************************
   Deallocate hit lists, word arrays, and search sessions
   ***************************************************************************
*/

/*
 *  FBCReleaseSessionHits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCReleaseSessionHits(FBCSearchSession theSession);


/*
 *  FBCDestroyWordList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCDestroyWordList(
  FBCWordList   theList,
  UInt32        wordCount);


/*
 *  FBCDestroySearchSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCDestroySearchSession(FBCSearchSession theSession);


/*
   ***************************************************************************
   Index one or more files and/or folders
   ***************************************************************************
*/

/*
 *  FBCIndexItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCIndexItems(
  FSSpecArrayPtr   theItems,
  UInt32           itemCount);


/*
 *  FBCIndexItemsInLanguages()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCIndexItemsInLanguages(
  FSSpecArrayPtr   theItems,
  UInt32           itemCount,
  UInt32           languageHighBits,
  UInt32           languageLowBits);


/*
   ***************************************************************************
   (OS X only) Given a folder, find the folder that contains the index file
   of the given index
   ***************************************************************************
*/

/*
 *  FBCFindIndexFileFolderForFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCFindIndexFileFolderForFolder(
  FSRef *  inFolder,
  FSRef *  outFolder);


/*
   ***************************************************************************
   (OS X only) Given a folder, delete the index file that indexes it
   ***************************************************************************
*/

/*
 *  FBCDeleteIndexFileForFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSErr )
FBCDeleteIndexFileForFolder(const FSRef * folder);



#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __FINDBYCONTENT__ */

