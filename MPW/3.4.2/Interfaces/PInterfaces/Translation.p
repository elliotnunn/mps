{
 	File:		Translation.p
 
 	Contains:	Translation Manager (Macintosh Easy Open) Interfaces.
 
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
 UNIT Translation;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TRANSLATION__}
{$SETC __TRANSLATION__ := 1}

{$I+}
{$SETC TranslationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	MixedMode.p													}
{	OSUtils.p													}
{		Memory.p												}
{	Finder.p													}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$IFC UNDEFINED __TRANSLATIONEXTENSIONS__}
{$I TranslationExtensions.p}
{$ENDC}
{	Quickdraw.p													}
{		QuickdrawText.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	DocOpenMethod = INTEGER;


CONST
	domCannot					= 0;
	domNative					= 1;
	domTranslateFirst			= 2;
	domWildcard					= 3;

{ 0L terminated array of OSTypes, or FileTypes}
	
TYPE
	TypesBlock = ARRAY [0..63] OF OSType;

	TypesBlockPtr = ^OSType;

{ Progress dialog resource ID}

CONST
	kTranslationScrapProgressDialogID = -16555;

{ block of data that describes how to translate}

TYPE
	FileTranslationSpec = RECORD
		componentSignature:		OSType;
		translationSystemInfo:	Ptr;
		src:					FileTypeSpec;
		dst:					FileTypeSpec;
	END;

	FileTranslationSpecArrayPtr = ^FileTranslationSpec;

{****************************************************************************************
* 
*   GetFileTypesThatAppCanNativelyOpen
* 
*  This routine returns a list of all FileTypes that an application can open by itself
* 
*  Enter:	appVRefNumHint		volume where application resides (can be wrong, and if is, will be used as a starting point)
* 			appSignature		signature (creator) of application
* 			nativeTypes			pointer to a buffer to be filled with up to 64 FileTypes
* 
*  Exit:	nativeTypes			zero terminated array of FileTypes that can be opened by app
}

FUNCTION GetFileTypesThatAppCanNativelyOpen(appVRefNumHint: INTEGER; appSignature: OSType; VAR nativeTypes: FileType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701C, $ABFC;
	{$ENDC}
{****************************************************************************************
* 
*  ExtendFileTypeList
* 
*  This routine makes a new list of file types that can be translated into a type in the given list
*  Used by StandardFile
* 
*  Enter:	originalTypeList		pointer to list of file types that can be opened
* 			numberOriginalTypes		number of file types in orgTypeList
*  			extendedTypeList		pointer to a buffer to be filled with file types
* 			numberExtendedTypes		max number of file types that can be put in extendedTypeList
* 
*  Exit:	extendedTypeList		buffer filled in with file types that can be translated
* 			numberExtendedTypes		number of file types put in extendedTypeList
}
FUNCTION ExtendFileTypeList({CONST}VAR originalTypeList: FileType; numberOriginalTypes: INTEGER; VAR extendedTypeList: FileType; VAR numberExtendedTypes: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $ABFC;
	{$ENDC}
{****************************************************************************************
* 
* 
*  This routine checks if a file can be opened by a particular application.
*  If so, it returns if it needs to be translated first, and if so then how.
*  The FileTypes that the app can open are specified by nativelyOpenableTypes,
*  or if it is NULL, GetFileTypesThatAppCanNativelyOpen is called.
* 
*  Enter:	targetDocument		document to check if it can be opened
* 			appVRefNumHint		vRefNum of application to open doc ( can be wrong, and if is, will be used as a starting point)
* 			appSignature		signature (creator) of application to open doc
* 			nativeTypes			zero terminated list of FileTypes app can open natively, or NULL to use default list
* 			onlyNative			whether to consider if document can be translated before opening
* 			howToOpen			pointer to buffer in which to put how the document can be opened
* 			howToTranslate		pointer to buffer in which to put a FileTranslationSpec record
* 
*  Exit:	howToOpen			whether file needs to be translated to be read
* 			howToTranslate		if file can be translated, buffer filled in with how to translate
* 			returns				noErr, noPrefAppErr
}
FUNCTION CanDocBeOpened({CONST}VAR targetDocument: FSSpec; appVRefNumHint: INTEGER; appSignature: OSType; {CONST}VAR nativeTypes: FileType; onlyNative: BOOLEAN; VAR howToOpen: DocOpenMethod; VAR howToTranslate: FileTranslationSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701E, $ABFC;
	{$ENDC}
{****************************************************************************************
* 
*  GetFileTranslationPaths
* 
*  This routine returns a list of all ways a translation can occure to or from a FileType.
*  The app is checked to exist.  The hint for each app is the VRefNum and DTRefNum
* 
*  Enter:	srcDoc			source file or NULL for all matches
* 			dstDoc			destination FileType or NULL for all matches
* 			maxResultCount
* 			resultBuffer
*  Exit:	number of paths
}
FUNCTION GetFileTranslationPaths(VAR srcDocument: FSSpec; dstDocType: FileType; maxResultCount: INTEGER; resultBuffer: FileTranslationSpecArrayPtr): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7038, $ABFC;
	{$ENDC}
{****************************************************************************************
* 
*  GetPathFromTranslationDialog
* 
*  This routine, with a given document, application, and a passed typelist will display the
*  Macintosh Easy Open translation dialog allowing the user to make a choice.  The choice
*  made will be written as a preference (so the next call to CanDocBeOpened() will work).
*  The routine returns the translation path information.
* 
*  Enter:	theDocument			FSSpec to document to open
* 			theApplication		FSSpec to application to open document
* 			typeList			Nil terminated list of FileType's (e.g. SFTypeList-like) of types
* 								you would like the documented translated to.  Order most perferred
* 								to least.
* 
*  Exit:	howToOpen			Translation method needed to open document
* 			howToTranslate		Translation specification
* 			returns				Any errors that might occur.
}
FUNCTION GetPathFromTranslationDialog({CONST}VAR theDocument: FSSpec; {CONST}VAR theApplication: FSSpec; typeList: TypesBlockPtr; VAR howToOpen: DocOpenMethod; VAR howToTranslate: FileTranslationSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7037, $ABFC;
	{$ENDC}
{****************************************************************************************
* 
*   TranslateFile
* 
*  This routine reads a file of one format and writes it to another file in another format. 
*  The information on how to translated is generated by the routine CanDocBeOpened.
*  TranslateFile calls through to the TranslateFile Extension's DoTranslateFile routine.  
*  The destination file must not exist.  It is created by this routine.  
* 
*  Enter:	sourceDocument			input file to translate
* 			destinationDocument		output file of translation
* 			howToTranslate			pointer to info on how to translate
*  Exit:	returns					noErr, badTranslationSpecErr 
}
FUNCTION TranslateFile({CONST}VAR sourceDocument: FSSpec; {CONST}VAR destinationDocument: FSSpec; {CONST}VAR howToTranslate: FileTranslationSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $ABFC;
	{$ENDC}
{****************************************************************************************
* 
*   GetDocumentKindString
* 
*  This routine returns the string the Finder should show for the "kind" of a document
*  in the GetInfo window and in the kind column of a list view.  
* 
*  Enter:	docVRefNum		The volume containing the document
* 			docType			The catInfo.fdType of the document
* 			docCreator		The catInfo.fdCreator of the document
* 			kindString		pointer to where to return the string
* 
*  Exit:	kindString		pascal string.  Ex: "\pSurfCalc spreadsheet"
* 			returns			noErr, or afpItemNoFound if kind could not be determined
}
FUNCTION GetDocumentKindString(docVRefNum: INTEGER; docType: OSType; docCreator: OSType; VAR kindString: Str63): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7016, $ABFC;
	{$ENDC}
{****************************************************************************************
* 
*  GetTranslationExtensionName
* 
*  This routine returns the translation system name from a specified TranslationSpec
* 
*  Enter:	translationMethod	The translation path to get the translation name from
* 
*  Exit:	extensionName		The name of the translation system
* 			returns				Any errors that might occur
}
FUNCTION GetTranslationExtensionName({CONST}VAR translationMethod: FileTranslationSpec; VAR extensionName: Str31): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7036, $ABFC;
	{$ENDC}
{****************************************************************************************
* 
*  GetScrapDataProcPtr
* 
*  This is a prototype for the function you must supply to TranslateScrap. It is called to 
*  get the data to be translated.  The first call TranslateScrap will make to this is to
*  ask for the 'fmts' data.  That is a special.   You should resize and fill in the handle
*  with a list all the formats that you have available to be translated, and the length of each.
*  (See I.M. VI 4-23 for details of 'fmts').  It will then be called again asking for one of  
*  the formats that 'fmts' list said was available.
* 
*  Enter:	requestedFormat			Format of data that TranslateScrap needs.
* 			dataH					Handle in which to put the requested data
* 			srcDataGetterRefCon		Extra parameter for you passed to TranslateScrap
* 			
*  Exit:	dataH					Handle is resized and filled with data in requested format
}
TYPE
	GetScrapDataProcPtr = ProcPtr;  { FUNCTION GetScrapData(requestedFormat: ScrapType; dataH: Handle; srcDataGetterRefCon: UNIV Ptr): OSErr; }
	GetScrapDataUPP = UniversalProcPtr;

CONST
	uppGetScrapDataProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewGetScrapDataProc(userRoutine: GetScrapDataProcPtr): GetScrapDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallGetScrapDataProc(requestedFormat: ScrapType; dataH: Handle; srcDataGetterRefCon: UNIV Ptr; userRoutine: GetScrapDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	GetScrapData = GetScrapDataUPP;

{****************************************************************************************
* 
*  TranslateScrap
* 
*  This routine resizes the destination handle and fills it with data of the requested format.
*  The data is generated by translated one or more source formats of data supplied by
*  the procedure srcDataGetter.  
*  This routine is automatically called by GetScrap and ReadEdition.  You only need to call
*  this if you need to translated scrap style data, but are not using the ScrapMgr or EditionMgr.
* 
*  Enter:	sourceDataGetter			Pointer to routine that can get src data
* 			sourceDataGetterRefCon		Extra parameter for dataGetter
* 			destinationFormat			Format of data desired
* 			destinationData				Handle in which to store translated data
* 			
*  Exit:	dstData						Handle is resized and filled with data in requested format
}

FUNCTION TranslateScrap(sourceDataGetter: GetScrapData; sourceDataGetterRefCon: UNIV Ptr; destinationFormat: ScrapType; destinationData: Handle; progressDialogID: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $ABFC;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TranslationIncludes}

{$ENDC} {__TRANSLATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
