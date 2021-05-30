{
 	File:		CodeFragments.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CodeFragments;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CODEFRAGMENTS__}
{$SETC __CODEFRAGMENTS__ := 1}

{$I+}
{$SETC CodeFragmentsIncludes := UsingIncludes}
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

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kCFragResourceType			= 'cfrg';
	kCFragResourceID			= 0;
	kCFragLibraryFileType		= 'shlb';

	
TYPE
	CFragArchitecture = OSType;


CONST
	kPowerPCCFragArch			= 'pwpc';
	kMotorola68KCFragArch		= 'm68k';
	kAnyCFragArch				= $3F3F3F3F;

{$IFC GENERATINGPOWERPC }
	kCurrentCFragArch			= kPowerPCCFragArch;

{$ENDC}
{$IFC GENERATING68K }
	kCurrentCFragArch			= kMotorola68KCFragArch;

{$ENDC}
	
TYPE
	CFragConnectionID = UInt32;

	CFragClosureID = UInt32;

	CFragContextID = UInt32;

	CFragContainerID = UInt32;

	
TYPE
	CFragLoadOptions = UInt32;


CONST
	kLoadCFrag					= $01;							{ Try to use existing copy, load if not found.}
	kFindCFrag					= $02;							{ Try find an existing copy, don't load if not found.}
	kNewCFragCopy				= $05;							{ Load a new copy whether one already exists or not.}
	kInplaceCFrag				= $80;							{ Use data sections directly in the container.}

	kUnresolvedCFragSymbolAddress = 0;

	
TYPE
	CFragSymbolClass = UInt8;


CONST
	kCodeCFragSymbol			= 0;
	kDataCFragSymbol			= 1;
	kTVectorCFragSymbol			= 2;
	kTOCCFragSymbol				= 3;
	kGlueCFragSymbol			= 4;

	
TYPE
	CFragUsage = UInt8;


CONST
	kImportLibraryCFrag			= 0;							{ Standard CFM import library.}
	kApplicationCFrag			= 1;							{ Macintosh application.}
	kDropInAdditionCFrag		= 2;							{ Private extension to an application or library.}

	kIsCompleteCFrag			= 0;							{ A "base" fragment, not an update.}
	kFirstCFragUpdate			= 1;							{ The first update, others are numbered 2, 3, ...}

	
TYPE
	CFragLocatorKind = UInt8;


CONST
	kMemoryCFragLocator			= 0;							{ Container is already addressable.}
	kDataForkCFragLocator		= 1;							{ Container is in a file's data fork.}
	kResourceCFragLocator		= 2;							{ Container is in a file's resource fork.}
	kByteStreamCFragLocator		= 3;							{ Container is in a given file fork as a byte stream.}

	kCFragGoesToEOF				= 0;


TYPE
	CFragOldMemoryLocator = PACKED RECORD
		address:				LogicalAddress;
		length:					UInt32;
		inPlace:				BOOLEAN;
		reserved3a:				ARRAY [0..2] OF UInt8;					{ ! Do not use this!}
	END;

	CFragHFSDiskFlatLocator = RECORD
		fileSpec:				FSSpecPtr;
		offset:					UInt32;
		length:					UInt32;
	END;

{ ! This must have a file specification at the same offset as a data fork locator!}
	CFragHFSSegmentedLocator = PACKED RECORD
		fileSpec:				FSSpecPtr;
		rsrcType:				OSType;
		rsrcID:					SInt16;
		reserved2a:				UInt16;									{ ! Do not use this!}
	END;

	CFragHFSLocator = RECORD
		where:					SInt32;									{ Really of type CFragLocatorKind.}
		CASE INTEGER OF
		0: (
			onDisk:						CFragHFSDiskFlatLocator;			{ First so debugger shows this form.}
		   );
		1: (
			inMem:						CFragOldMemoryLocator;
		   );
		2: (
			inSegs:						CFragHFSSegmentedLocator;
		   );
	END;

	CFragHFSLocatorPtr = ^CFragHFSLocator;

{ -------------------------------------------------------------------------------------------}
{ The parameter block passed to fragment initialization functions.  The locator and name}
{ pointers are valid only for the duration of the initialization routine.  I.e. if you want}
{ to save the locator or name, save the contents, not the pointers.  Initialization routines}
{ take one parameter, a pointer to the parameter block, and return a success/failure result.}
{ ! Note that the initialization function returns an OSErr.  Any result other than noErr will}
{ ! cause the entire load to be aborted at that point.}
	CFragInitBlock = RECORD
		contextID:				CFragContextID;
		closureID:				CFragClosureID;
		connectionID:			CFragConnectionID;
		fragLocator:			CFragHFSLocator;
		libName:				StringPtr;
		reserved4a:				UInt32;									{ ! Do not use this!}
		reserved4b:				UInt32;									{ ! Do not use this!}
		reserved4c:				UInt32;									{ ! Do not use this!}
		reserved4d:				UInt32;									{ ! Do not use this!}
	END;

	CFragInitBlockPtr = ^CFragInitBlock;

	CFragInitFunction = ProcPtr;  { FUNCTION ((CONST)VAR theInitBlock: CFragInitBlock): OSErr; }

	CFragTermRoutine = ProcPtr;  { PROCEDURE ; }

	CFragInitFunctionPtr = ^CFragInitFunction;

	CFragTermRoutinePtr = ^CFragTermRoutine;

{ §}
{ ===========================================================================================}
{ Routines}
{ ========}

FUNCTION GetSharedLibrary(libName: ConstStr63Param; archType: OSType; loadFlags: CFragLoadOptions; VAR connID: CFragConnectionID; VAR mainAddr: Ptr; VAR errMessage: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0001, $AA5A;
	{$ENDC}
FUNCTION GetDiskFragment({CONST}VAR fileSpec: FSSpec; offset: UInt32; length: UInt32; fragName: ConstStr63Param; loadFlags: CFragLoadOptions; VAR connID: CFragConnectionID; VAR mainAddr: Ptr; VAR errMessage: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0002, $AA5A;
	{$ENDC}
FUNCTION GetMemFragment(memAddr: UNIV Ptr; length: UInt32; fragName: ConstStr63Param; loadFlags: CFragLoadOptions; VAR connID: CFragConnectionID; VAR mainAddr: Ptr; VAR errMessage: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0003, $AA5A;
	{$ENDC}
FUNCTION CloseConnection(VAR connID: CFragConnectionID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $AA5A;
	{$ENDC}
FUNCTION FindSymbol(connID: CFragConnectionID; symName: ConstStr255Param; VAR symAddr: Ptr; VAR symClass: CFragSymbolClass): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0005, $AA5A;
	{$ENDC}
FUNCTION CountSymbols(connID: CFragConnectionID; VAR symCount: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0006, $AA5A;
	{$ENDC}
FUNCTION GetIndSymbol(connID: CFragConnectionID; symIndex: LONGINT; VAR symName: Str255; VAR symAddr: Ptr; VAR symClass: CFragSymbolClass): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0007, $AA5A;
	{$ENDC}
{$IFC OLDROUTINENAMES }
	
TYPE
	ConnectionID = CFragConnectionID;

	LoadFlags = CFragLoadOptions;

	SymClass = CFragSymbolClass;

	MemFragment = CFragOldMemoryLocator;

	DiskFragment = CFragHFSDiskFlatLocator;

	SegmentedFragment = CFragHFSSegmentedLocator;

	FragmentLocator = CFragHFSLocator;

	FragmentLocatorPtr = CFragHFSLocatorPtr;

	InitBlock = CFragInitBlock;

	InitBlockPtr = CFragInitBlockPtr;

	ConnectionInitializationRoutine = CFragInitFunction;

	ConnectionTerminationRoutine = CFragTermRoutine;


CONST
	kPowerPCArch				= kPowerPCCFragArch;
	kMotorola68KArch			= kMotorola68KCFragArch;
	kAnyArchType				= kAnyCFragArch;
	kNoLibName					= 0;
	kNoConnectionID				= 0;
	kLoadLib					= kLoadCFrag;
	kFindLib					= kFindCFrag;
	kLoadNewCopy				= kNewCFragCopy;
	kUseInPlace					= kInplaceCFrag;
	kCodeSym					= kCodeCFragSymbol;
	kDataSym					= kDataCFragSymbol;
	kTVectSym					= kTVectorCFragSymbol;
	kTOCSym						= kTOCCFragSymbol;
	kGlueSym					= kGlueCFragSymbol;
	kInMem						= kMemoryCFragLocator;
	kOnDiskFlat					= kDataForkCFragLocator;
	kOnDiskSegmented			= kResourceCFragLocator;
	kIsLib						= kImportLibraryCFrag;
	kIsApp						= kApplicationCFrag;
	kIsDropIn					= kDropInAdditionCFrag;
	kFullLib					= kIsCompleteCFrag;
	kUpdateLib					= kFirstCFragUpdate;
	kWholeFork					= kCFragGoesToEOF;
	kCFMRsrcType				= kCFragResourceType;
	kCFMRsrcID					= kCFragResourceID;
	kSHLBFileType				= kCFragLibraryFileType;
	kUnresolvedSymbolAddress	= kUnresolvedCFragSymbolAddress;

	kPowerPC					= kPowerPCCFragArch;
	kMotorola68K				= kMotorola68KCFragArch;

{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CodeFragmentsIncludes}

{$ENDC} {__CODEFRAGMENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
