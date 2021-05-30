{
     File:       NumberFormatting.p
 
     Contains:   Utilites for formatting numbers
 
     Version:    Technology: 
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT NumberFormatting;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NUMBERFORMATTING__}
{$SETC __NUMBERFORMATTING__ := 1}

{$I+}
{$SETC NumberFormattingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __INTLRESOURCES__}
{$I IntlResources.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{

    Here are the current System 7 routine names and the translations to the older forms.
    Please use the newer forms in all new code and migrate the older names out of existing
    code as maintainance permits.
    
    New Name                    Old Name(s)
    
    ExtendedToString            FormatX2Str
    FormatRecToString           Format2Str
    NumToString             
    StringToExtended            FormatStr2X
    StringToFormatRec           Str2Format
    StringToNum             

}

TYPE
	NumFormatStringPtr = ^NumFormatString;
	NumFormatString = PACKED RECORD
		fLength:				UInt8;
		fVersion:				UInt8;
		data:					PACKED ARRAY [0..253] OF CHAR;			{  private data  }
	END;

	NumFormatStringRec					= NumFormatString;
	NumFormatStringRecPtr 				= ^NumFormatStringRec;
	FormatStatus						= INTEGER;

CONST
	fVNumber					= 0;							{  first version of NumFormatString  }


TYPE
	FormatClass							= SInt8;

CONST
	fPositive					= 0;
	fNegative					= 1;
	fZero						= 2;


TYPE
	FormatResultType					= SInt8;

CONST
	fFormatOK					= 0;
	fBestGuess					= 1;
	fOutOfSynch					= 2;
	fSpuriousChars				= 3;
	fMissingDelimiter			= 4;
	fExtraDecimal				= 5;
	fMissingLiteral				= 6;
	fExtraExp					= 7;
	fFormatOverflow				= 8;
	fFormStrIsNAN				= 9;
	fBadPartsTable				= 10;
	fExtraPercent				= 11;
	fExtraSeparator				= 12;
	fEmptyFormatString			= 13;


TYPE
	FVectorPtr = ^FVector;
	FVector = RECORD
		start:					INTEGER;
		length:					INTEGER;
	END;

	{	 index by [fPositive..fZero] 	}
	TripleInt							= ARRAY [0..2] OF FVector;
	{
	 *  StringToNum()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE StringToNum(theString: Str255; VAR theNum: LONGINT);

{
 *  NumToString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE NumToString(theNum: LONGINT; VAR theString: Str255);

{
 *  ExtendedToString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ExtendedToString({CONST}VAR x: extended80; {CONST}VAR myCanonical: NumFormatString; {CONST}VAR partsTable: NumberParts; VAR outString: Str255): FormatStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8210, $FFE8, $A8B5;
	{$ENDC}

{
 *  StringToExtended()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StringToExtended(source: Str255; {CONST}VAR myCanonical: NumFormatString; {CONST}VAR partsTable: NumberParts; VAR x: extended80): FormatStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8210, $FFE6, $A8B5;
	{$ENDC}

{
 *  StringToFormatRec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StringToFormatRec(inString: Str255; {CONST}VAR partsTable: NumberParts; VAR outString: NumFormatString): FormatStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $FFEC, $A8B5;
	{$ENDC}

{
 *  FormatRecToString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FormatRecToString({CONST}VAR myCanonical: NumFormatString; {CONST}VAR partsTable: NumberParts; VAR outString: Str255; VAR positions: TripleInt): FormatStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8210, $FFEA, $A8B5;
	{$ENDC}


{$IFC OLDROUTINENAMES }
{$ENDC}  {OLDROUTINENAMES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NumberFormattingIncludes}

{$ENDC} {__NUMBERFORMATTING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
