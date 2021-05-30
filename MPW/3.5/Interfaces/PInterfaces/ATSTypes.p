{
     File:       ATSTypes.p
 
     Contains:   Public interfaces for Apple Type Services components.
 
     Version:    Technology: CarbonLib 1.1
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
 UNIT ATSTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ATSTYPES__}
{$SETC __ATSTYPES__ := 1}

{$I+}
{$SETC ATSTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	FMGeneration						= UInt32;
	{	 The FMFontFamily reference represents a collection of fonts with the same design
	   characteristics. It replaces the standard QuickDraw font identifer and may be used
	   with all QuickDraw functions including GetFontName and TextFont. It cannot be used
	   with the Resource Manager to access information from a FOND resource handle. A font
	   reference does not imply a particular script system, nor is the character encoding
	   of a font family determined by an arithmetic mapping of its value.
		}
	FMFontFamily						= SInt16;
	FMFontStyle							= SInt16;
	FMFontSize							= SInt16;
	{	 
	   The font family is a collection of fonts, each of which is identified
	   by an FMFont reference that maps to a single object registered with
	   the font database. The font references associated with the font
	   family consist of individual outline and bitmapped fonts that may be
	   used with the font access routines of the Font Manager and ATS.
		}
	FMFont								= UInt32;
	FMFontFamilyInstancePtr = ^FMFontFamilyInstance;
	FMFontFamilyInstance = RECORD
		fontFamily:				FMFontFamily;
		fontStyle:				FMFontStyle;
	END;

	FMFontFamilyIteratorPtr = ^FMFontFamilyIterator;
	FMFontFamilyIterator = RECORD
		reserved:				ARRAY [0..15] OF UInt32;
	END;

	FMFontIteratorPtr = ^FMFontIterator;
	FMFontIterator = RECORD
		reserved:				ARRAY [0..15] OF UInt32;
	END;

	FMFontFamilyInstanceIteratorPtr = ^FMFontFamilyInstanceIterator;
	FMFontFamilyInstanceIterator = RECORD
		reserved:				ARRAY [0..15] OF UInt32;
	END;


CONST
	kInvalidGeneration			= 0;
	kInvalidFontFamily			= -1;
	kInvalidFont				= 0;

	kFMCurrentFilterFormat		= 0;

	kFMDefaultOptions			= 0;
	kFMUseGlobalScopeOption		= $00000001;


TYPE
	FMFilterSelector 			= UInt32;
CONST
	kFMFontTechnologyFilterSelector = 1;
	kFMFontContainerFilterSelector = 2;
	kFMGenerationFilterSelector	= 3;
	kFMFontFamilyCallbackFilterSelector = 4;
	kFMFontCallbackFilterSelector = 5;
	kFMFontDirectoryFilterSelector = 6;

	kFMTrueTypeFontTechnology	= 'true';
	kFMPostScriptFontTechnology	= 'typ1';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	FMFontFamilyCallbackFilterProcPtr = FUNCTION(iFontFamily: FMFontFamily; iRefCon: UNIV Ptr): OSStatus;
{$ELSEC}
	FMFontFamilyCallbackFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FMFontCallbackFilterProcPtr = FUNCTION(iFont: FMFont; iRefCon: UNIV Ptr): OSStatus;
{$ELSEC}
	FMFontCallbackFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	FMFontFamilyCallbackFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FMFontFamilyCallbackFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FMFontCallbackFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FMFontCallbackFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppFMFontFamilyCallbackFilterProcInfo = $000003B0;
	uppFMFontCallbackFilterProcInfo = $000003F0;
	{
	 *  NewFMFontFamilyCallbackFilterUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewFMFontFamilyCallbackFilterUPP(userRoutine: FMFontFamilyCallbackFilterProcPtr): FMFontFamilyCallbackFilterUPP; { old name was NewFMFontFamilyCallbackFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFMFontCallbackFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewFMFontCallbackFilterUPP(userRoutine: FMFontCallbackFilterProcPtr): FMFontCallbackFilterUPP; { old name was NewFMFontCallbackFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeFMFontFamilyCallbackFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeFMFontFamilyCallbackFilterUPP(userUPP: FMFontFamilyCallbackFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFMFontCallbackFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeFMFontCallbackFilterUPP(userUPP: FMFontCallbackFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeFMFontFamilyCallbackFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeFMFontFamilyCallbackFilterUPP(iFontFamily: FMFontFamily; iRefCon: UNIV Ptr; userRoutine: FMFontFamilyCallbackFilterUPP): OSStatus; { old name was CallFMFontFamilyCallbackFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFMFontCallbackFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeFMFontCallbackFilterUPP(iFont: FMFont; iRefCon: UNIV Ptr; userRoutine: FMFontCallbackFilterUPP): OSStatus; { old name was CallFMFontCallbackFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


TYPE
	FMFontDirectoryFilterPtr = ^FMFontDirectoryFilter;
	FMFontDirectoryFilter = RECORD
		fontFolderDomain:		SInt16;
		reserved:				ARRAY [0..1] OF UInt32;
	END;

	FMFilterPtr = ^FMFilter;
	FMFilter = RECORD
		format:					UInt32;
		selector:				FMFilterSelector;
		CASE INTEGER OF
		0: (
			fontTechnologyFilter: FourCharCode;
			);
		1: (
			fontContainerFilter: FSSpec;
			);
		2: (
			generationFilter:	FMGeneration;
			);
		3: (
			fontFamilyCallbackFilter: FMFontFamilyCallbackFilterUPP;
			);
		4: (
			fontCallbackFilter:	FMFontCallbackFilterUPP;
			);
		5: (
			fontDirectoryFilter: FMFontDirectoryFilter;
			);
	END;

	ATSOptionFlags						= OptionBits;
	ATSGeneration						= UInt32;
	ATSFontContainerRef					= UInt32;
	ATSFontFamilyRef					= UInt32;
	ATSFontRef							= UInt32;
	ATSGlyphRef							= UInt16;
	ATSFontSize							= Float32;

CONST
	kATSGenerationUnspecified	= 0;
	kATSFontContainerRefUnspecified = 0;
	kATSFontFamilyRefUnspecified = 0;
	kATSFontRefUnspecified		= 0;


TYPE
	ATSFontMetricsPtr = ^ATSFontMetrics;
	ATSFontMetrics = RECORD
		version:				UInt32;
		ascent:					Float32;								{  Maximum height above baseline reached by the glyphs in the font  }
																		{  or maximum distance to the right of the centerline reached by the glyphs in the font  }
		descent:				Float32;								{  Maximum depth below baseline reached by the glyphs in the font  }
																		{  or maximum distance to the left of the centerline reached by the glyphs in the font  }
		leading:				Float32;								{  Desired spacing between lines of text  }
		avgAdvanceWidth:		Float32;
		maxAdvanceWidth:		Float32;								{  Maximum advance width or height of the glyphs in the font  }
		minLeftSideBearing:		Float32;								{  Minimum left or top side bearing  }
		minRightSideBearing:	Float32;								{  Minimum right or bottom side bearing  }
		stemWidth:				Float32;								{  Width of the dominant vertical stems of the glyphs in the font  }
		stemHeight:				Float32;								{  Vertical width of the dominant horizontal stems of glyphs in the font  }
		capHeight:				Float32;								{  Height of a capital letter from the baseline to the top of the letter  }
		xHeight:				Float32;								{  Height of lowercase characters in a font, specifically the letter x, excluding ascenders and descenders  }
		italicAngle:			Float32;								{  Angle in degrees counterclockwise from the vertical of the dominant vertical strokes of the glyphs in the font  }
		underlinePosition:		Float32;								{  Distance from the baseline for positioning underlining strokes  }
		underlineThickness:		Float32;								{  Stroke width for underlining  }
	END;


CONST
	kATSItalicQDSkew			= $00004000;					{  fixed value of 0.25  }
	kATSBoldQDStretch			= $00018000;					{  fixed value of 1.50  }
	kATSRadiansFactor			= 1144;							{  fixed value of approx. pi/180 (0.0174560546875)  }

	{	 Glyph outline path constants used in ATSFontGetNativeCurveType. 	}

TYPE
	ATSCurveType 				= UInt16;
CONST
	kATSCubicCurveType			= $0001;
	kATSQuadCurveType			= $0002;
	kATSOtherCurveType			= $0003;


TYPE
	ATSUCurvePathPtr = ^ATSUCurvePath;
	ATSUCurvePath = RECORD
		vectors:				UInt32;
		controlBits:			ARRAY [0..0] OF UInt32;
		vector:					ARRAY [0..0] OF Float32Point;
	END;

	ATSUCurvePathsPtr = ^ATSUCurvePaths;
	ATSUCurvePaths = RECORD
		contours:				UInt32;
		contour:				ARRAY [0..0] OF ATSUCurvePath;
	END;

	{	 Glyph ideal metrics 	}
	ATSGlyphIdealMetricsPtr = ^ATSGlyphIdealMetrics;
	ATSGlyphIdealMetrics = RECORD
		advance:				Float32Point;
		sideBearing:			Float32Point;
		otherSideBearing:		Float32Point;
	END;

	{	 Glyph screen metrics 	}
	ATSGlyphScreenMetricsPtr = ^ATSGlyphScreenMetrics;
	ATSGlyphScreenMetrics = RECORD
		deviceAdvance:			Float32Point;
		topLeft:				Float32Point;
		height:					UInt32;
		width:					UInt32;
		sideBearing:			Float32Point;
		otherSideBearing:		Float32Point;
	END;

	GlyphID								= ATSGlyphRef;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ATSTypesIncludes}

{$ENDC} {__ATSTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
