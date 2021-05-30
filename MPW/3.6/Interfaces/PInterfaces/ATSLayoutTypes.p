{
     File:       ATSLayoutTypes.p
 
     Contains:   Apple Type Services layout public structures and constants.
 
     Version:    Technology: Mac OS 9/Carbon
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ATSLayoutTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ATSLAYOUTTYPES__}
{$SETC __ATSLAYOUTTYPES__ := 1}

{$I+}
{$SETC ATSLayoutTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __SFNTLAYOUTTYPES__}
{$I SFNTLayoutTypes.p}
{$ENDC}

{$IFC UNDEFINED __ATSTYPES__}
{$I ATSTypes.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ --------------------------------------------------------------------------- }
{ CONSTANTS and related scalar types }
{ --------------------------------------------------------------------------- }
{ Miscellaneous constants }

CONST
	kATSUseLineHeight			= $7FFFFFFF;					{  assignment to use natural line ascent/descent values  }
	kATSNoTracking				= $80000000;					{  negativeInfinity  }


TYPE
	ATSLineLayoutOptions				= UInt32;

CONST
	kATSLineNoLayoutOptions		= $00000000;					{  no options  }
	kATSLineIsDisplayOnly		= $00000001;					{  specifies to optimize for displaying text only  }
	kATSLineHasNoHangers		= $00000002;					{  specifies that no hangers to be formed on the line  }
	kATSLineHasNoOpticalAlignment = $00000004;					{  specifies that no optical alignment to be performed on the line  }
	kATSLineKeepSpacesOutOfMargin = $00000008;					{  specifies that space charcters should not be treated as hangers  }
	kATSLineNoSpecialJustification = $00000010;					{  specifies no post-compensation justification is to be performed  }
	kATSLineLastNoJustification	= $00000020;					{  specifies that if the line is the last of a paragraph, it will not get justified  }
	kATSLineFractDisable		= $00000040;					{  specifies that the displayed line glyphs will adjust for device metrics  }
	kATSLineImposeNoAngleForEnds = $00000080;					{  specifies that the carets at the ends of the line will be guarenteed to be perpendicular to the baseline  }
	kATSLineFillOutToWidth		= $00000100;					{  highlights for the line end characters will be extended to 0 and the specified line width  }
	kATSLineTabAdjustEnabled	= $00000200;					{  specifies that the tab character width will be automatically adjusted to fit the specified line width  }
	kATSLineAppleReserved		= $FFFFFC00;					{  these bits are reserved by Apple and will result in a invalid value error if attemped to set  }


TYPE
	ATSStyleRenderingOptions			= UInt32;

CONST
	kATSStyleNoOptions			= $00000000;					{  no options  }
	kATSStyleApplyHints			= $00000001;					{  specifies that ATS produce "hinted" glyph outlines (default is on)  }
																{     kATSStyleApplyAntiAliasing           = 0x00000002L,  /* specifies that ATS produce antialiased glyph images (default is on) future feature */ }
	kATSStyleAppleReserved		= $FFFFFFFE;					{  these bits are reserved by Apple and will result in a invalid value error if attemped to set  }

	{	 For accessing glyph bounds 	}
	kATSUseCaretOrigins			= 0;
	kATSUseDeviceOrigins		= 1;
	kATSUseFractionalOrigins	= 2;
	kATSUseOriginFlags			= 3;

	{	 --------------------------------------------------------------------------- 	}
	{	 STRUCTURED TYPES and related constants 	}
	{	 --------------------------------------------------------------------------- 	}

	{	
	    The ATSTrapezoid structure supplies a convenient container
	    for glyph bounds in trapezoidal form.
		}

TYPE
	ATSTrapezoidPtr = ^ATSTrapezoid;
	ATSTrapezoid = RECORD
		upperLeft:				FixedPoint;
		upperRight:				FixedPoint;
		lowerRight:				FixedPoint;
		lowerLeft:				FixedPoint;
	END;

	{	
	    The JustWidthDeltaEntryOverride structure specifies values for the grow and shrink case during
	    justification, both on the left and on the right. It also contains flags.  This particular structure
	    is used for passing justification overrides to LLC.  For further sfnt resource 'just' table
	    constants and structures, see SFNTLayoutTypes.h.
		}
	ATSJustWidthDeltaEntryOverridePtr = ^ATSJustWidthDeltaEntryOverride;
	ATSJustWidthDeltaEntryOverride = RECORD
		beforeGrowLimit:		Fixed;									{  ems AW can grow by at most on LT  }
		beforeShrinkLimit:		Fixed;									{  ems AW can shrink by at most on LT  }
		afterGrowLimit:			Fixed;									{  ems AW can grow by at most on RB  }
		afterShrinkLimit:		Fixed;									{  ems AW can shrink by at most on RB  }
		growFlags:				JustificationFlags;						{  flags controlling grow case  }
		shrinkFlags:			JustificationFlags;						{  flags controlling shrink case  }
	END;

	{	 The JustPriorityOverrides type is an array of 4 width delta records, one per priority level override. 	}
	ATSJustPriorityWidthDeltaOverrides	= ARRAY [0..3] OF ATSJustWidthDeltaEntryOverride;
	{	 --------------------------------------------------------------------------- 	}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ATSLayoutTypesIncludes}

{$ENDC} {__ATSLAYOUTTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
