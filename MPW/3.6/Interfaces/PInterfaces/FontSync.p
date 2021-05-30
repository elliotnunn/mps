{
     File:       FontSync.p
 
     Contains:   Public interface for FontSync
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FontSync;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FONTSYNC__}
{$SETC __FONTSYNC__ := 1}

{$I+}
{$SETC FontSyncIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __FONTS__}
{$I Fonts.p}
{$ENDC}
{$IFC UNDEFINED __SFNTTYPES__}
{$I SFNTTypes.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


{ Matching Options }

TYPE
	FNSMatchOptions 			= UInt32;
CONST
	kFNSMatchNames				= $00000001;					{  font names must match  }
	kFNSMatchTechnology			= $00000002;					{  scaler technology must match  }
	kFNSMatchGlyphs				= $00000004;					{  glyph data must match  }
	kFNSMatchEncodings			= $00000008;					{  cmaps must match  }
	kFNSMatchQDMetrics			= $00000010;					{  QuickDraw Text metrics must match  }
	kFNSMatchATSUMetrics		= $00000020;					{  ATSUI metrics (incl. vertical) must match  }
	kFNSMatchKerning			= $00000040;					{  kerning data must match  }
	kFNSMatchWSLayout			= $00000080;					{  WorldScript layout tables must match  }
	kFNSMatchAATLayout			= $00000100;					{  AAT (incl. OpenType) layout tables must match  }
	kFNSMatchPrintEncoding		= $00000200;					{  PostScript font and glyph names and re-encoding vector must match  }
	kFNSMissingDataNoMatch		= $80000000;					{  treat missing data as mismatch  }
	kFNSMatchAll				= $FFFFFFFF;					{  everything must match  }
	kFNSMatchDefaults			= 0;							{  use global default match options  }

	{
	 *  FNSMatchDefaultsGet()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION FNSMatchDefaultsGet: FNSMatchOptions; C;


{ Version control }

TYPE
	FNSObjectVersion 			= UInt32;
CONST
	kFNSVersionDontCare			= 0;
	kFNSCurSysInfoVersion		= 1;

	{  No features defined yet. }

TYPE
	FNSFeatureFlags						= UInt32;
	{
	   The FontSync library version number is binary-coded decimal:
	   8 bits of major version, 4 minor version and 4 bits revision.
	}
	FNSSysInfoPtr = ^FNSSysInfo;
	FNSSysInfo = RECORD
		iSysInfoVersion:		FNSObjectVersion;						{  fill this in before calling FNSSysInfoGet }
		oFeatures:				FNSFeatureFlags;
		oCurRefVersion:			FNSObjectVersion;
		oMinRefVersion:			FNSObjectVersion;
		oCurProfileVersion:		FNSObjectVersion;
		oMinProfileVersion:		FNSObjectVersion;
		oFontSyncVersion:		UInt16;
	END;

	{
	 *  FNSSysInfoGet()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE FNSSysInfoGet(VAR ioInfo: FNSSysInfo); C;


{ FontSync References }

TYPE
	FNSFontReference    = ^LONGINT; { an opaque 32-bit type }
	FNSFontReferencePtr = ^FNSFontReference;  { when a VAR xx:FNSFontReference parameter can be nil, it is changed to xx: FNSFontReferencePtr }
	{
	 *  FNSReferenceGetVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION FNSReferenceGetVersion(iReference: FNSFontReference; VAR oVersion: FNSObjectVersion): OSStatus; C;

{
 *  FNSReferenceDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceDispose(iReference: FNSFontReference): OSStatus; C;

{
 *  FNSReferenceMatch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceMatch(iReference1: FNSFontReference; iReference2: FNSFontReference; iOptions: FNSMatchOptions; VAR oFailedMatchOptions: FNSMatchOptions): OSStatus; C;

{
 *  FNSReferenceFlattenedSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceFlattenedSize(iReference: FNSFontReference; VAR oFlattenedSize: ByteCount): OSStatus; C;

{
 *  FNSReferenceFlatten()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceFlatten(iReference: FNSFontReference; oFlatReference: UNIV Ptr; VAR oFlattenedSize: ByteCount): OSStatus; C;

{
 *  FNSReferenceUnflatten()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceUnflatten(iFlatReference: UNIV Ptr; iFlattenedSize: ByteCount; VAR oReference: FNSFontReference): OSStatus; C;


{ FontSync Profiles }

CONST
	kFNSCreatorDefault			= 0;
	kFNSProfileFileType			= 'fnsp';


TYPE
	FNSFontProfile    = ^LONGINT; { an opaque 32-bit type }
	FNSFontProfilePtr = ^FNSFontProfile;  { when a VAR xx:FNSFontProfile parameter can be nil, it is changed to xx: FNSFontProfilePtr }
	{
	 *  FNSProfileCreate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION FNSProfileCreate({CONST}VAR iFile: FSSpec; iCreator: FourCharCode; iEstNumRefs: ItemCount; iDesiredVersion: FNSObjectVersion; VAR oProfile: FNSFontProfile): OSStatus; C;

{
 *  FNSProfileOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileOpen({CONST}VAR iFile: FSSpec; iOpenForWrite: BOOLEAN; VAR oProfile: FNSFontProfile): OSStatus; C;

{
 *  FNSProfileGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileGetVersion(iProfile: FNSFontProfile; VAR oVersion: FNSObjectVersion): OSStatus; C;

{
 *  FNSProfileCompact()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileCompact(iProfile: FNSFontProfile): OSStatus; C;

{
 *  FNSProfileClose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileClose(iProfile: FNSFontProfile): OSStatus; C;

{
 *  FNSProfileAddReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileAddReference(iProfile: FNSFontProfile; iReference: FNSFontReference): OSStatus; C;

{
 *  FNSProfileRemoveReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileRemoveReference(iProfile: FNSFontProfile; iReference: FNSFontReference): OSStatus; C;

{
 *  FNSProfileRemoveIndReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileRemoveIndReference(iProfile: FNSFontProfile; iIndex: UInt32): OSStatus; C;

{
 *  FNSProfileClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileClear(iProfile: FNSFontProfile): OSStatus; C;

{
 *  FNSProfileCountReferences()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileCountReferences(iProfile: FNSFontProfile; VAR oCount: ItemCount): OSStatus; C;

{
 *  FNSProfileGetIndReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileGetIndReference(iProfile: FNSFontProfile; iWhichReference: UInt32; VAR oReference: FNSFontReference): OSStatus; C;

{
 *  FNSProfileMatchReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSProfileMatchReference(iProfile: FNSFontProfile; iReference: FNSFontReference; iMatchOptions: FNSMatchOptions; iOutputSize: ItemCount; oIndices: LongIntPtr; VAR oNumMatches: ItemCount): OSStatus; C;


{ Mapping to and from Font Objects }
{
 *  FNSReferenceCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceCreate(iFont: FMFont; iDesiredVersion: FNSObjectVersion; VAR oReference: FNSFontReference): OSStatus; C;

{
 *  FNSReferenceMatchFonts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceMatchFonts(iReference: FNSFontReference; iMatchOptions: FNSMatchOptions; iOutputSize: ItemCount; oFonts: LongIntPtr; VAR oNumMatches: ItemCount): OSStatus; C;


{ Mapping to and from Font Families }
{
 *  FNSReferenceCreateFromFamily()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceCreateFromFamily(iFamily: FMFontFamily; iStyle: FMFontStyle; iDesiredVersion: FNSObjectVersion; oReference: FNSFontReferencePtr; VAR oActualStyle: FMFontStyle): OSStatus; C;

{
 *  FNSReferenceMatchFamilies()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceMatchFamilies(iReference: FNSFontReference; iMatchOptions: FNSMatchOptions; iOutputSize: ItemCount; oFonts: FMFontFamilyInstancePtr; VAR oNumMatches: ItemCount): OSStatus; C;


{ UI Support }
{
 *  FNSReferenceGetFamilyInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceGetFamilyInfo(iReference: FNSFontReference; oFamilyName: StringPtr; VAR oFamilyNameScript: ScriptCode; VAR oActualStyle: FMFontStyle): OSStatus; C;

{
 *  FNSReferenceCountNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceCountNames(iReference: FNSFontReference; VAR oNameCount: ItemCount): OSStatus; C;

{
 *  FNSReferenceGetIndName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceGetIndName(iReference: FNSFontReference; iFontNameIndex: ItemCount; iMaximumNameLength: ByteCount; oName: Ptr; VAR oActualNameLength: ByteCount; VAR oFontNameCode: FontNameCode; VAR oFontNamePlatform: FontPlatformCode; VAR oFontNameScript: FontScriptCode; VAR oFontNameLanguage: FontLanguageCode): OSStatus; C;

{
 *  FNSReferenceFindName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSReferenceFindName(iReference: FNSFontReference; iFontNameCode: FontNameCode; iFontNamePlatform: FontPlatformCode; iFontNameScript: FontScriptCode; iFontNameLanguage: FontLanguageCode; iMaximumNameLength: ByteCount; oName: Ptr; VAR oActualNameLength: ByteCount; VAR oFontNameIndex: ItemCount): OSStatus; C;

{ Miscellany }
{
 *  FNSEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in FontSyncLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FNSEnabled: BOOLEAN; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FontSyncIncludes}

{$ENDC} {__FONTSYNC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
