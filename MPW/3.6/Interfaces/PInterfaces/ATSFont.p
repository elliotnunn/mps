{
     File:       ATSFont.p
 
     Contains:   Public interface to the font access and data management functions of ATS.
 
     Version:    Technology: Mac OS
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ATSFont;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ATSFONT__}
{$SETC __ATSFONT__ := 1}

{$I+}
{$SETC ATSFontIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __ATSTYPES__}
{$I ATSTypes.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __SFNTTYPES__}
{$I SFNTTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kATSOptionFlagsDefault		= 0;
	kATSOptionFlagsComposeFontPostScriptName = $01;				{  ATSFontGetPostScriptName  }
	kATSOptionFlagsUseDataForkAsResourceFork = $0100;			{  ATSFontActivateFromFileSpecification  }
	kATSOptionFlagsUseResourceFork = $0200;
	kATSOptionFlagsUseDataFork	= $0300;

	kATSIterationCompleted		= -980;
	kATSInvalidFontFamilyAccess	= -981;
	kATSInvalidFontAccess		= -982;
	kATSIterationScopeModified	= -983;
	kATSInvalidFontTableAccess	= -984;
	kATSInvalidFontContainerAccess = -985;


TYPE
	ATSFontContext						= UInt32;

CONST
	kATSFontContextUnspecified	= 0;
	kATSFontContextGlobal		= 1;


TYPE
	ATSFontFormat						= UInt32;

CONST
	kATSFontFormatUnspecified	= 0;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ATSFontFamilyApplierFunction = FUNCTION(iFamily: ATSFontFamilyRef; iRefCon: UNIV Ptr): OSStatus; C;
{$ELSEC}
	ATSFontFamilyApplierFunction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATSFontApplierFunction = FUNCTION(iFont: ATSFontRef; iRefCon: UNIV Ptr): OSStatus; C;
{$ELSEC}
	ATSFontApplierFunction = ProcPtr;
{$ENDC}

	ATSFontFamilyIterator    = ^LONGINT; { an opaque 32-bit type }
	ATSFontFamilyIteratorPtr = ^ATSFontFamilyIterator;  { when a VAR xx:ATSFontFamilyIterator parameter can be nil, it is changed to xx: ATSFontFamilyIteratorPtr }
	ATSFontIterator    = ^LONGINT; { an opaque 32-bit type }
	ATSFontIteratorPtr = ^ATSFontIterator;  { when a VAR xx:ATSFontIterator parameter can be nil, it is changed to xx: ATSFontIteratorPtr }

CONST
	kATSFontFilterCurrentVersion = 0;


TYPE
	ATSFontFilterSelector 		= SInt32;
CONST
	kATSFontFilterSelectorUnspecified = 0;
	kATSFontFilterSelectorGeneration = 3;
	kATSFontFilterSelectorFontFamily = 7;
	kATSFontFilterSelectorFontFamilyApplierFunction = 8;
	kATSFontFilterSelectorFontApplierFunction = 9;


TYPE
	ATSFontFilterPtr = ^ATSFontFilter;
	ATSFontFilter = RECORD
		version:				UInt32;
		filterSelector:			ATSFontFilterSelector;
		CASE INTEGER OF
		0: (
			generationFilter:	ATSGeneration;
			);
		1: (
			fontFamilyFilter:	ATSFontFamilyRef;
			);
		2: (
			fontFamilyApplierFunctionFilter: ATSFontFamilyApplierFunction;
			);
		3: (
			fontApplierFunctionFilter: ATSFontApplierFunction;
			);
	END;

	{	 ----------------------------------------------------------------------------------------- 	}
	{	 Font container                                                                            	}
	{	 ----------------------------------------------------------------------------------------- 	}
	{
	 *  ATSGetGeneration()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION ATSGetGeneration: ATSGeneration; C;

{
 *  ATSFontActivateFromFileSpecification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontActivateFromFileSpecification({CONST}VAR iFile: FSSpec; iContext: ATSFontContext; iFormat: ATSFontFormat; iReserved: UNIV Ptr; iOptions: ATSOptionFlags; VAR oContainer: ATSFontContainerRef): OSStatus; C;

{
 *  ATSFontActivateFromMemory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontActivateFromMemory(iData: LogicalAddress; iLength: ByteCount; iContext: ATSFontContext; iFormat: ATSFontFormat; iReserved: UNIV Ptr; iOptions: ATSOptionFlags; VAR oContainer: ATSFontContainerRef): OSStatus; C;

{
 *  ATSFontDeactivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontDeactivate(iContainer: ATSFontContainerRef; iRefCon: UNIV Ptr; iOptions: ATSOptionFlags): OSStatus; C;

{ ----------------------------------------------------------------------------------------- }
{ Font family                                                                               }
{ ----------------------------------------------------------------------------------------- }
{
 *  ATSFontFamilyApplyFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyApplyFunction(iFunction: ATSFontFamilyApplierFunction; iRefCon: UNIV Ptr): OSStatus; C;

{
 *  ATSFontFamilyIteratorCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyIteratorCreate(iContext: ATSFontContext; iFilter: {Const}ATSFontFilterPtr; iRefCon: UNIV Ptr; iOptions: ATSOptionFlags; VAR ioIterator: ATSFontFamilyIterator): OSStatus; C;

{
 *  ATSFontFamilyIteratorRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyIteratorRelease(VAR ioIterator: ATSFontFamilyIterator): OSStatus; C;

{
 *  ATSFontFamilyIteratorReset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyIteratorReset(iContext: ATSFontContext; iFilter: {Const}ATSFontFilterPtr; iRefCon: UNIV Ptr; iOptions: ATSOptionFlags; VAR ioIterator: ATSFontFamilyIterator): OSStatus; C;

{
 *  ATSFontFamilyIteratorNext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyIteratorNext(iIterator: ATSFontFamilyIterator; VAR oFamily: ATSFontFamilyRef): OSStatus; C;

{
 *  ATSFontFamilyFindFromName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyFindFromName(iName: CFStringRef; iOptions: ATSOptionFlags): ATSFontFamilyRef; C;

{
 *  ATSFontFamilyGetGeneration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyGetGeneration(iFamily: ATSFontFamilyRef): ATSGeneration; C;

{
 *  ATSFontFamilyGetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyGetName(iFamily: ATSFontFamilyRef; iOptions: ATSOptionFlags; VAR oName: CFStringRef): OSStatus; C;

{
 *  ATSFontFamilyGetEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyGetEncoding(iFamily: ATSFontFamilyRef): TextEncoding; C;

{ ----------------------------------------------------------------------------------------- }
{ Font                                                                                      }
{ ----------------------------------------------------------------------------------------- }
{
 *  ATSFontApplyFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontApplyFunction(iFunction: ATSFontApplierFunction; iRefCon: UNIV Ptr): OSStatus; C;

{
 *  ATSFontIteratorCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontIteratorCreate(iContext: ATSFontContext; iFilter: {Const}ATSFontFilterPtr; iRefCon: UNIV Ptr; iOptions: ATSOptionFlags; VAR ioIterator: ATSFontIterator): OSStatus; C;

{
 *  ATSFontIteratorRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontIteratorRelease(VAR ioIterator: ATSFontIterator): OSStatus; C;

{
 *  ATSFontIteratorReset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontIteratorReset(iContext: ATSFontContext; iFilter: {Const}ATSFontFilterPtr; iRefCon: UNIV Ptr; iOptions: ATSOptionFlags; VAR ioIterator: ATSFontIterator): OSStatus; C;

{
 *  ATSFontIteratorNext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontIteratorNext(iIterator: ATSFontIterator; VAR oFont: ATSFontRef): OSStatus; C;

{
 *  ATSFontFindFromName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFindFromName(iName: CFStringRef; iOptions: ATSOptionFlags): ATSFontRef; C;

{
 *  ATSFontFindFromPostScriptName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFindFromPostScriptName(iName: CFStringRef; iOptions: ATSOptionFlags): ATSFontRef; C;

{
 *  ATSFontFindFromContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFindFromContainer(iContainer: ATSFontContainerRef; iOptions: ATSOptionFlags; iCount: ItemCount; VAR ioArray: ATSFontRef; VAR oCount: ItemCount): OSStatus; C;

{
 *  ATSFontGetGeneration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontGetGeneration(iFont: ATSFontRef): ATSGeneration; C;

{
 *  ATSFontGetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontGetName(iFont: ATSFontRef; iOptions: ATSOptionFlags; VAR oName: CFStringRef): OSStatus; C;

{
 *  ATSFontGetPostScriptName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontGetPostScriptName(iFont: ATSFontRef; iOptions: ATSOptionFlags; VAR oName: CFStringRef): OSStatus; C;

{
 *  ATSFontGetTableDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontGetTableDirectory(iFont: ATSFontRef; iBufferSize: ByteCount; ioBuffer: UNIV Ptr; VAR oSize: ByteCount): OSStatus; C;

{
 *  ATSFontGetTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontGetTable(iFont: ATSFontRef; iTag: FourCharCode; iOffset: ByteOffset; iBufferSize: ByteCount; ioBuffer: UNIV Ptr; VAR oSize: ByteCount): OSStatus; C;

{
 *  ATSFontGetHorizontalMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontGetHorizontalMetrics(iFont: ATSFontRef; iOptions: ATSOptionFlags; VAR oMetrics: ATSFontMetrics): OSStatus; C;

{
 *  ATSFontGetVerticalMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontGetVerticalMetrics(iFont: ATSFontRef; iOptions: ATSOptionFlags; VAR oMetrics: ATSFontMetrics): OSStatus; C;

{ ----------------------------------------------------------------------------------------- }
{ Compatibiity                                                                              }
{ ----------------------------------------------------------------------------------------- }
{
 *  ATSFontFamilyFindFromQuickDrawName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyFindFromQuickDrawName(iName: Str255): ATSFontFamilyRef; C;

{
 *  ATSFontFamilyGetQuickDrawName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontFamilyGetQuickDrawName(iFamily: ATSFontFamilyRef; VAR oName: Str255): OSStatus; C;

{
 *  ATSFontGetFileSpecification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontGetFileSpecification(iFont: ATSFontRef; VAR oFile: FSSpec): OSStatus; C;

{
 *  ATSFontGetFontFamilyResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ATSFontGetFontFamilyResource(iFont: ATSFontRef; iBufferSize: ByteCount; ioBuffer: UNIV Ptr; VAR oSize: ByteCount): OSStatus; C;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ATSFontIncludes}

{$ENDC} {__ATSFONT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
