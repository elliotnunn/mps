{
     File:       FindByContent.p
 
     Contains:   Public search interface for the Find by Content shared library
 
     Version:    Technology: 2.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FindByContent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FINDBYCONTENT__}
{$SETC __FINDBYCONTENT__ := 1}

{$I+}
{$SETC FindByContentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{
   ***************************************************************************
   Language constants used with FBCIndexItemsInLanguages: these numbers are bits
   in a 64-bit array that consists of two UInt32 words.  In the current implementation
   the low word is always 0, so values for the high word are given.  If both UInt32
   words are 0, the default value of kDefaultLanguagesHighWord is used.
   ***************************************************************************
}

CONST
																{  languages that use the Roman character mapping }
	englishHighWord				= $80000000;
	dutchHighWord				= $40000000;					{  also Afrikaans }
	germanHighWord				= $20000000;
	swedishHighWord				= $10000000;					{  also Norwegian }
	danishHighWord				= $08000000;
	spanishHighWord				= $04000000;					{  also Catalan }
	portugueseHighWord			= $02000000;
	italianHighWord				= $01000000;
	frenchHighWord				= $00800000;
	romanHighWord				= $00400000;					{  other languages using Roman alphabet }
																{  Languages that use other mappings }
	icelandicHighWord			= $00200000;					{  also Faroese }
	hebrewHighWord				= $00100000;					{  also Yiddish }
	arabicHighWord				= $00080000;					{  also Farsi, Urdu }
	centeuroHighWord			= $00040000;					{  Central European languages not using Cyrillic }
	croatianHighWord			= $00020000;
	turkishHighWord				= $00010000;
	romanianHighWord			= $00008000;
	greekHighWord				= $00004000;
	cyrillicHighWord			= $00002000;					{  all languages using Cyrillic }
	devanagariHighWord			= $00001000;
	gujuratiHighWord			= $00000800;
	gurmukhiHighWord			= $00000400;
	japaneseHighWord			= $00000200;
	koreanHighWord				= $00000100;
	kDefaultLanguagesHighWord	= $FF800000;					{  sum of first 9 }


	{
	   ***************************************************************************
	   Phase values
	   These values are passed to the client's callback function to indicate what
	   the FBC code is doing.
	   ***************************************************************************
	}
																{  indexing phases }
	kFBCphIndexing				= 0;
	kFBCphFlushing				= 1;
	kFBCphMerging				= 2;
	kFBCphMakingIndexAccessor	= 3;
	kFBCphCompacting			= 4;
	kFBCphIndexWaiting			= 5;							{  access phases }
	kFBCphSearching				= 6;
	kFBCphMakingAccessAccessor	= 7;
	kFBCphAccessWaiting			= 8;							{  summarization }
	kFBCphSummarizing			= 9;							{  indexing or access }
	kFBCphIdle					= 10;
	kFBCphCanceling				= 11;



	{
	   ***************************************************************************
	   Pointer types
	   These point to memory allocated by the FBC shared library, and must be deallocated
	   by calls that are defined below.
	   ***************************************************************************
	}

	{  A collection of state information for searching }

TYPE
	FBCSearchSession    = ^LONGINT; { an opaque 32-bit type }
	FBCSearchSessionPtr = ^FBCSearchSession;  { when a VAR xx:FBCSearchSession parameter can be nil, it is changed to xx: FBCSearchSessionPtr }
	{  a FBCWordList is a pointer to an array of pointers to c-strings }
	FBCWordListRecPtr = ^FBCWordListRec;
	FBCWordListRec = RECORD
		words:					ARRAY [0..0] OF ConstCStringPtr;		{  array of pointers to c-strings }
	END;

	FBCWordList							= ^FBCWordListRec;
	{
	   ***************************************************************************
	   Callback function type for progress reporting and cancelation during
	   searching and indexing.  The client's callback function should call
	   WaitNextEvent; a "sleep" value of 1 is suggested.  If the callback function
	   wants to cancel the current operation (indexing, search, or doc-terms
	   retrieval) it should return true.
	   ***************************************************************************
	}

{$IFC TYPED_FUNCTION_POINTERS}
	FBCCallbackProcPtr = FUNCTION(phase: UInt16; percentDone: Single; data: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	FBCCallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	FBCCallbackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FBCCallbackUPP = FBCCallbackProcPtr;
{$ENDC}	

CONST
	uppFBCCallbackProcInfo = $00000F91;
	{
	 *  NewFBCCallbackUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0.2 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewFBCCallbackUPP(userRoutine: FBCCallbackProcPtr): FBCCallbackUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeFBCCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeFBCCallbackUPP(userUPP: FBCCallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeFBCCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeFBCCallbackUPP(phase: UInt16; percentDone: Single; data: UNIV Ptr; userRoutine: FBCCallbackUPP): BOOLEAN;
{
   ***************************************************************************
   Set the callback function for progress reporting and cancelation during
   searching and indexing, and set the amount of heap space to reserve for
   the client's use when FBC allocates memory.
   ***************************************************************************
}
{
 *  FBCSetCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FBCSetCallback(fn: FBCCallbackUPP; data: UNIV Ptr); C;

{
 *  FBCSetHeapReservation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FBCSetHeapReservation(bytes: UInt32); C;

{
   ***************************************************************************
   Find out whether a volume is indexed, the date & time of its last
   completed  update, and its physical size.
   ***************************************************************************
}

{
 *  FBCVolumeIsIndexed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCVolumeIsIndexed(theVRefNum: SInt16): BOOLEAN; C;

{
 *  FBCVolumeIsRemote()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCVolumeIsRemote(theVRefNum: SInt16): BOOLEAN; C;

{
 *  FBCVolumeIndexTimeStamp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCVolumeIndexTimeStamp(theVRefNum: SInt16; VAR timeStamp: UInt32): OSErr; C;

{
 *  FBCVolumeIndexPhysicalSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCVolumeIndexPhysicalSize(theVRefNum: SInt16; VAR size: UInt32): OSErr; C;

{
   ***************************************************************************
   Create & configure a search session
   ***************************************************************************
}

{
 *  FBCCreateSearchSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCCreateSearchSession(VAR searchSession: FBCSearchSession): OSErr; C;

{
 *  FBCAddAllVolumesToSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCAddAllVolumesToSession(theSession: FBCSearchSession; includeRemote: BOOLEAN): OSErr; C;

{
 *  FBCSetSessionVolumes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCSetSessionVolumes(theSession: FBCSearchSession; {CONST}VAR vRefNums: SInt16; numVolumes: UInt16): OSErr; C;

{
 *  FBCAddVolumeToSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCAddVolumeToSession(theSession: FBCSearchSession; vRefNum: SInt16): OSErr; C;

{
 *  FBCRemoveVolumeFromSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCRemoveVolumeFromSession(theSession: FBCSearchSession; vRefNum: SInt16): OSErr; C;

{
 *  FBCGetSessionVolumeCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCGetSessionVolumeCount(theSession: FBCSearchSession; VAR count: UInt16): OSErr; C;

{
 *  FBCGetSessionVolumes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCGetSessionVolumes(theSession: FBCSearchSession; VAR vRefNums: SInt16; VAR numVolumes: UInt16): OSErr; C;

{
 *  FBCCloneSearchSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCCloneSearchSession(original: FBCSearchSession; VAR clone: FBCSearchSession): OSErr; C;

{
   ***************************************************************************
   Execute a search
   ***************************************************************************
}

{
 *  FBCDoQuerySearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCDoQuerySearch(theSession: FBCSearchSession; queryText: CStringPtr; {CONST}VAR targetDirs: FSSpec; numTargets: UInt32; maxHits: UInt32; maxHitWords: UInt32): OSErr; C;

{
 *  FBCDoCFStringSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCDoCFStringSearch(theSession: FBCSearchSession; queryString: CFStringRef; {CONST}VAR targetDirs: FSSpec; numTargets: UInt32; maxHits: UInt32; maxHitWords: UInt32): OSErr; C;

{
 *  FBCDoExampleSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCDoExampleSearch(theSession: FBCSearchSession; {CONST}VAR exampleHitNums: UInt32; numExamples: UInt32; {CONST}VAR targetDirs: FSSpec; numTargets: UInt32; maxHits: UInt32; maxHitWords: UInt32): OSErr; C;

{
 *  FBCBlindExampleSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCBlindExampleSearch(VAR examples: FSSpec; numExamples: UInt32; {CONST}VAR targetDirs: FSSpec; numTargets: UInt32; maxHits: UInt32; maxHitWords: UInt32; allIndexes: BOOLEAN; includeRemote: BOOLEAN; VAR theSession: FBCSearchSession): OSErr; C;


{
   ***************************************************************************
   Get information about hits [wrapper for THitItem C++ API]
   ***************************************************************************
}

{
 *  FBCGetHitCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCGetHitCount(theSession: FBCSearchSession; VAR count: UInt32): OSErr; C;

{
 *  FBCGetHitDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCGetHitDocument(theSession: FBCSearchSession; hitNumber: UInt32; VAR theDocument: FSSpec): OSErr; C;

{
 *  FBCGetHitDocumentRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCGetHitDocumentRef(theSession: FBCSearchSession; hitNumber: UInt32; VAR theDocument: FSRef): OSErr; C;

{
 *  FBCGetHitScore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCGetHitScore(theSession: FBCSearchSession; hitNumber: UInt32; VAR score: Single): OSErr; C;

{
 *  FBCGetMatchedWords()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCGetMatchedWords(theSession: FBCSearchSession; hitNumber: UInt32; VAR wordCount: UInt32; VAR list: FBCWordList): OSErr; C;

{
 *  FBCGetTopicWords()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCGetTopicWords(theSession: FBCSearchSession; hitNumber: UInt32; VAR wordCount: UInt32; VAR list: FBCWordList): OSErr; C;


{
   ***************************************************************************
   Summarize a buffer of text
   ***************************************************************************
}

{
 *  FBCSummarize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCSummarize(inBuf: UNIV Ptr; inLength: UInt32; outBuf: UNIV Ptr; VAR outLength: UInt32; VAR numSentences: UInt32): OSErr; C;

{
   ***************************************************************************
   Deallocate hit lists, word arrays, and search sessions
   ***************************************************************************
}

{
 *  FBCReleaseSessionHits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCReleaseSessionHits(theSession: FBCSearchSession): OSErr; C;

{
 *  FBCDestroyWordList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCDestroyWordList(theList: FBCWordList; wordCount: UInt32): OSErr; C;

{
 *  FBCDestroySearchSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCDestroySearchSession(theSession: FBCSearchSession): OSErr; C;

{
   ***************************************************************************
   Index one or more files and/or folders
   ***************************************************************************
}

{
 *  FBCIndexItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FindByContent 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCIndexItems(theItems: FSSpecArrayPtr; itemCount: UInt32): OSErr; C;

{
 *  FBCIndexItemsInLanguages()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCIndexItemsInLanguages(theItems: FSSpecArrayPtr; itemCount: UInt32; languageHighBits: UInt32; languageLowBits: UInt32): OSErr; C;

{
   ***************************************************************************
   (OS X only) Given a folder, find the folder that contains the index file
   of the given index
   ***************************************************************************
}

{
 *  FBCFindIndexFileFolderForFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCFindIndexFileFolderForFolder(VAR inFolder: FSRef; VAR outFolder: FSRef): OSErr; C;

{
   ***************************************************************************
   (OS X only) Given a folder, delete the index file that indexes it
   ***************************************************************************
}

{
 *  FBCDeleteIndexFileForFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FBCDeleteIndexFileForFolder({CONST}VAR folder: FSRef): OSErr; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FindByContentIncludes}

{$ENDC} {__FINDBYCONTENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
