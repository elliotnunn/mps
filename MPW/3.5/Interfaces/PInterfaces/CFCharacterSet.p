{
     File:       CFCharacterSet.p
 
     Contains:   CoreFoundation character sets
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFCharacterSet;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFCHARACTERSET__}
{$SETC __CFCHARACTERSET__ := 1}

{$I+}
{$SETC CFCharacterSetIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFCharacterSetRef    = ^LONGINT; { an opaque 32-bit type }
	CFCharacterSetRefPtr = ^CFCharacterSetRef;  { when a VAR xx:CFCharacterSetRef parameter can be nil, it is changed to xx: CFCharacterSetRefPtr }
	CFMutableCharacterSetRef    = CFCharacterSetRef;
	CFMutableCharacterSetRefPtr = ^CFMutableCharacterSetRef;  { when a VAR xx:CFMutableCharacterSetRef parameter can be nil, it is changed to xx: CFMutableCharacterSetRefPtr }
	CFCharacterSetPredefinedSet  = SInt32;
CONST
	kCFCharacterSetControl		= 1;
	kCFCharacterSetWhitespace	= 2;
	kCFCharacterSetWhitespaceAndNewline = 3;
	kCFCharacterSetDecimalDigit	= 4;
	kCFCharacterSetLetter		= 5;
	kCFCharacterSetLowercaseLetter = 6;
	kCFCharacterSetUppercaseLetter = 7;
	kCFCharacterSetNonBase		= 8;
	kCFCharacterSetDecomposable	= 9;
	kCFCharacterSetAlphaNumeric	= 10;
	kCFCharacterSetPunctuation	= 11;
	kCFCharacterSetIllegal		= 12;

	{
	 *  CFCharacterSetGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFCharacterSetGetTypeID: CFTypeID; C;

{
 *  CFCharacterSetGetPredefined()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFCharacterSetGetPredefined(theSetIdentifier: CFCharacterSetPredefinedSet): CFCharacterSetRef; C;

{
 *  CFCharacterSetCreateWithCharactersInRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFCharacterSetCreateWithCharactersInRange(alloc: CFAllocatorRef; theRange: CFRange): CFCharacterSetRef; C;

{
 *  CFCharacterSetCreateWithCharactersInString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFCharacterSetCreateWithCharactersInString(alloc: CFAllocatorRef; theString: CFStringRef): CFCharacterSetRef; C;

{
 *  CFCharacterSetCreateWithBitmapRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFCharacterSetCreateWithBitmapRepresentation(alloc: CFAllocatorRef; theData: CFDataRef): CFCharacterSetRef; C;

{
 *  CFCharacterSetCreateMutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFCharacterSetCreateMutable(alloc: CFAllocatorRef): CFMutableCharacterSetRef; C;

{
 *  CFCharacterSetCreateMutableCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFCharacterSetCreateMutableCopy(alloc: CFAllocatorRef; theSet: CFCharacterSetRef): CFMutableCharacterSetRef; C;

{
 *  CFCharacterSetIsCharacterMember()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFCharacterSetIsCharacterMember(theSet: CFCharacterSetRef; theChar: UniChar): BOOLEAN; C;

{
 *  CFCharacterSetCreateBitmapRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFCharacterSetCreateBitmapRepresentation(alloc: CFAllocatorRef; theSet: CFCharacterSetRef): CFDataRef; C;

{
 *  CFCharacterSetAddCharactersInRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFCharacterSetAddCharactersInRange(theSet: CFMutableCharacterSetRef; theRange: CFRange); C;

{
 *  CFCharacterSetRemoveCharactersInRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFCharacterSetRemoveCharactersInRange(theSet: CFMutableCharacterSetRef; theRange: CFRange); C;

{
 *  CFCharacterSetAddCharactersInString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFCharacterSetAddCharactersInString(theSet: CFMutableCharacterSetRef; theString: CFStringRef); C;

{
 *  CFCharacterSetRemoveCharactersInString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFCharacterSetRemoveCharactersInString(theSet: CFMutableCharacterSetRef; theString: CFStringRef); C;

{
 *  CFCharacterSetUnion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFCharacterSetUnion(theSet: CFMutableCharacterSetRef; theOtherSet: CFCharacterSetRef); C;

{
 *  CFCharacterSetIntersect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFCharacterSetIntersect(theSet: CFMutableCharacterSetRef; theOtherSet: CFCharacterSetRef); C;

{
 *  CFCharacterSetInvert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFCharacterSetInvert(theSet: CFMutableCharacterSetRef); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFCharacterSetIncludes}

{$ENDC} {__CFCHARACTERSET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
