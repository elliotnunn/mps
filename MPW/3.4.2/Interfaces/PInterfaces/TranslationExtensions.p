{
 	File:		TranslationExtensions.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TranslationExtensions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TRANSLATIONEXTENSIONS__}
{$SETC __TRANSLATIONEXTENSIONS__ := 1}

{$I+}
{$SETC TranslationExtensionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	OSUtils.p													}
{	Finder.p													}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	QuickdrawText.p												}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kSupportsFileTranslation	= 1;
	kSupportsScrapTranslation	= 2;
	kTranslatorCanGenerateFilename = 4;

	
TYPE
	FileType = OSType;

	ScrapType = ResType;

	TranslationAttributes = LONGINT;


CONST
	taDstDocNeedsResourceFork	= 1;
	taDstIsAppTranslation		= 2;


TYPE
	FileTypeSpec = RECORD
		format:					FileType;
		hint:					LONGINT;
		flags:					TranslationAttributes;					{ taDstDocNeedsResourceFork, taDstIsAppTranslation}
		catInfoType:			OSType;
		catInfoCreator:			OSType;
	END;

	FileTranslationList = RECORD
		modDate:				LONGINT;
		groupCount:				LONGINT;
		{ 	unsigned long	group1SrcCount;}
		{ 	unsigned long	group1SrcEntrySize = sizeof(FileTypeSpec);}
		{  FileTypeSpec	group1SrcTypes[group1SrcCount]}
		{  unsigned long	group1DstCount;}
		{  unsigned long	group1DstEntrySize = sizeof(FileTypeSpec);}
		{  FileTypeSpec	group1DstTypes[group1DstCount]}
	END;

	FileTranslationListPtr = ^FileTranslationList;
	FileTranslationListHandle = ^FileTranslationListPtr;

	ScrapTypeSpec = RECORD
		format:					ScrapType;
		hint:					LONGINT;
	END;

	ScrapTranslationList = RECORD
		modDate:				LONGINT;
		groupCount:				LONGINT;
		{ 	unsigned long		group1SrcCount;}
		{ 	unsigned long		group1SrcEntrySize = sizeof(ScrapTypeSpec);}
		{  ScrapTypeSpec		group1SrcTypes[group1SrcCount]}
		{  unsigned long		group1DstCount;}
		{ 	unsigned long		group1DstEntrySize = sizeof(ScrapTypeSpec);}
		{  ScrapTypeSpec		group1DstTypes[group1DstCount]}
	END;

	ScrapTranslationListPtr = ^ScrapTranslationList;
	ScrapTranslationListHandle = ^ScrapTranslationListPtr;

{ definition of callbacks to update progress dialog}
	TranslationRefNum = LONGINT;

{****************************************************************************************
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
}

FUNCTION SetTranslationAdvertisement(refNum: TranslationRefNum; advertisement: PicHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $ABFC;
	{$ENDC}
{****************************************************************************************
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
}
FUNCTION UpdateTranslationProgress(refNum: TranslationRefNum; percentDone: INTEGER; VAR canceled: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $ABFC;
	{$ENDC}
{ ComponentMgr selectors for routines}

CONST
	kTranslateGetFileTranslationList = 0;						{ component selectors}
	kTranslateIdentifyFile		= 1;
	kTranslateTranslateFile		= 2;
	kTranslateGetTranslatedFilename = 3;
	kTranslateGetScrapTranslationList = 10;						{ skip to scrap routines}
	kTranslateIdentifyScrap		= 11;
	kTranslateTranslateScrap	= 12;

{ Routines to implment in a file translation extension}
TYPE
	DoGetFileTranslationListProcPtr = ProcPtr;  { FUNCTION (self: ComponentInstance; translationList: FileTranslationListHandle): ComponentResult; }

	DoIdentifyFileProcPtr = ProcPtr;  { FUNCTION (self: ComponentInstance; (CONST)VAR theDocument: FSSpec; VAR docType: FileType): ComponentResult; }

	DoTranslateFileProcPtr = ProcPtr;  { FUNCTION (self: ComponentInstance; refNum: TranslationRefNum; (CONST)VAR sourceDocument: FSSpec; srcType: FileType; srcTypeHint: LONGINT; (CONST)VAR dstDoc: FSSpec; dstType: FileType; dstTypeHint: LONGINT): ComponentResult; }

	DoGetTranslatedFilenameProcPtr = ProcPtr;  { FUNCTION (self: ComponentInstance; dstType: FileType; dstTypeHint: LONGINT; VAR theDocument: FSSpec): ComponentResult; }

{ Routine to implement in a scrap translation extension}
	DoGetScrapTranslationListProcPtr = ProcPtr;  { FUNCTION (self: ComponentInstance; list: ScrapTranslationListHandle): ComponentResult; }

	DoIdentifyScrapProcPtr = ProcPtr;  { FUNCTION (self: ComponentInstance; dataPtr: UNIV Ptr; dataLength: Size; VAR dataFormat: ScrapType): ComponentResult; }

	DoTranslateScrapProcPtr = ProcPtr;  { FUNCTION (self: ComponentInstance; refNum: TranslationRefNum; srcDataPtr: UNIV Ptr; srcDataLength: Size; srcType: ScrapType; srcTypeHint: LONGINT; dstData: Handle; dstType: ScrapType; dstTypeHint: LONGINT): ComponentResult; }


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TranslationExtensionsIncludes}

{$ENDC} {__TRANSLATIONEXTENSIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
