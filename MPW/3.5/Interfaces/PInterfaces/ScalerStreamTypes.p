{
     File:       ScalerStreamTypes.p
 
     Contains:   Scaler streaming data structures and constants for OFA 1.x
 
     Version:    Technology: Quickdraw GX 1.1
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
 UNIT ScalerStreamTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SCALERSTREAMTYPES__}
{$SETC __SCALERSTREAMTYPES__ := 1}

{$I+}
{$SETC ScalerStreamTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __SFNTTYPES__}
{$I SFNTTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ ScalerStream input/output types }

CONST
	cexec68K					= $00000001;
	truetypeStreamType			= $00000001;
	type1StreamType				= $00000002;
	type3StreamType				= $00000004;
	type42StreamType			= $00000008;
	type42GXStreamType			= $00000010;
	portableStreamType			= $00000020;
	flattenedStreamType			= $00000040;
	cidType2StreamType			= $00000080;
	cidType0StreamType			= $00000100;
	type1CFFStreamType			= $00000200;
	evenOddModifierStreamType	= $00008000;
	eexecBinaryModifierStreamType = $00010000;					{  encrypted portion of Type1Stream to be binary  }
	unicodeMappingModifierStreamType = $00020000;				{  include glyph ID to unicode mapping info for PDF  }
	scalerSpecifcModifierMask	= $0000F000;					{  for scaler's internal use  }
	streamTypeModifierMask		= $FFFFF000;					{  16 bits for Apple, 4 bits for scaler  }

	{	 Possible streamed font formats 	}

TYPE
	scalerStreamTypeFlag				= UInt32;

CONST
	downloadStreamAction		= 0;							{  Transmit the (possibly sparse) font data  }
	asciiDownloadStreamAction	= 1;							{  Transmit font data to a 7-bit ASCII destination  }
	fontSizeQueryStreamAction	= 2;							{  Estimate in-printer memory used if the font were downloaded  }
	encodingOnlyStreamAction	= 3;							{  Transmit only the encoding for the font  }
	prerequisiteQueryStreamAction = 4;							{  Return a list of prerequisite items needed for the font  }
	prerequisiteItemStreamAction = 5;							{  Transmit a specified prerequisite item  }
	variationQueryStreamAction	= 6;							{  Return information regarding support for variation streaming  }
	variationPSOperatorStreamAction = 7;						{  Transmit Postscript code necessary to effect variation of a font  }


TYPE
	scalerStreamAction					= LONGINT;

CONST
	selectAllVariations			= -1;							{  Special variationCount value meaning include all variation data  }


TYPE
	scalerPrerequisiteItemPtr = ^scalerPrerequisiteItem;
	scalerPrerequisiteItem = RECORD
		enumeration:			LONGINT;								{  Shorthand tag identifying the item  }
		size:					LONGINT;								{  Worst case vm in printer item requires  }
		name:					SInt8;									{  Name to be used by the client when emitting the item (Pascal string)  }
	END;

	scalerStreamPtr = ^scalerStream;
	scalerStream = RECORD
		streamRefCon:			Ptr;									{  <- private reference for client  }
		targetVersion:			ConstCStringPtr;						{  <- e.g. Postscript printer name (C string)  }
		types:					scalerStreamTypeFlag;					{  <->    Data stream formats desired/supplied  }
		action:					scalerStreamAction;						{  <-     What action to take  }
		memorySize:				UInt32;									{  -> Worst case memory use (vm) in printer or as sfnt  }
		variationCount:			LONGINT;								{  <- The number of variations, or selectAllVariations  }
		variations:				Ptr;									{  <- A pointer to an array of the variations (gxFontVariation)  }
		CASE INTEGER OF
																		{  Normal font streaming information }
		0: (
			encoding:			IntegerPtr;								{  <- Intention is * unsigned short[256]  }
			glyphBits:			LongIntPtr;								{  <->    Bitvector: a bit for each glyph, 1 = desired/supplied  }
			name:				CStringPtr;								{  <->    The printer font name to use/used (C string)  }
		   );
																		{  Used to obtain a list of prerequisites from the scaler }
		1: (
			size:				LONGINT;								{  ->     Size of the prereq. list in bytes (0 indicates no prerequisites) }
			list:				Ptr;									{  <- Pointer to client block to hold list (nil = list size query only)  }
		   );
		2: (
			prerequisiteItem:	LONGINT;								{  <-     Enumeration value for the prerequisite item to be streamed. }
			);
		3: (
			variationQueryResult: LONGINT;								{  -> Output from the variationQueryStreamAction  }
			);
	END;

	scalerStreamDataPtr = ^scalerStreamData;
	scalerStreamData = RECORD
		hexFlag:				LONGINT;								{  Indicates that the data is to be interpreted as hex, versus binary  }
		byteCount:				LONGINT;								{  Number of bytes in the data being streamed  }
		data:					Ptr;									{  Pointer to the data being streamed  }
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ScalerStreamTypesIncludes}

{$ENDC} {__SCALERSTREAMTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
