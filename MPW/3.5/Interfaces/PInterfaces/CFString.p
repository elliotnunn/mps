{
     File:       CFString.p
 
     Contains:   CoreFoundation strings
 
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
 UNIT CFString;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFSTRING__}
{$SETC __CFSTRING__ := 1}

{$I+}
{$SETC CFStringIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
Please note: CFStrings are conceptually an array of Unicode characters.
However, in general, how a CFString stores this array is an implementation
detail. For instance, CFString might choose to use an array of 8-bit characters;
to store its contents; or it might use multiple blocks of memory; or whatever.
Furthermore, the implementation might change depending on the default
system encoding, the user's language, the OS, or even a given release.

What this means is that you should use the following advanced functions with care:

  CFStringGetPascalStringPtr()
  CFStringGetCStringPtr()
  CFStringGetCharactersPtr()

These functions either return the desired pointer quickly, in constant time, or they
return NULL, which indicates you should use some of the other function, as shown
in this example:

    Str255 buffer;
    StringPtr ptr = CFStringGetPascalStringPtr(str, encoding);
    if (ptr == NULL) (
        if (CFStringGetPascalString(str, buffer, 256, encoding)) ptr = buffer;
    )

Note that CFStringGetPascalString call might still return NULL --- but that will happen
in two circumstances only: The conversion from the UniChar contents of CFString
to the specified encoding fails, or the buffer is too small.

If you need a copy of the buffer in the above example, you might consider simply
calling CFStringGetPascalString() in all cases --- CFStringGetPascalStringPtr()
is simply an optimization.

In addition, the following functions, which create immutable CFStrings from developer
supplied buffers without copying the buffers, might have to actually copy
under certain circumstances (If they do copy, the buffer will be dealt with by the
"contentsDeallocator" argument.):

  CFStringCreateWithPascalStringNoCopy()
  CFStringCreateWithCStringNoCopy()
  CFStringCreateWithCharactersNoCopy()

You should of course never depend on the backing store of these CFStrings being
what you provided, and in other no circumstance should you change the contents
of that buffer (given that would break the invariant about the CFString being immutable).

Having said all this, there are actually ways to create a CFString where the backing store
is external, and can be manipulated by the developer or CFString itself:

  CFStringCreateMutableWithExternalCharactersNoCopy()
  CFStringSetExternalCharactersNoCopy()

A "contentsAllocator" is used to realloc or free the backing store by CFString.
kCFAllocatorNull can be provided to assure CFString will never realloc or free the buffer.
Developer can call CFStringSetExternalCharactersNoCopy() to update
CFString's idea of what's going on, if the buffer is changed externally. In these
strings, CFStringGetCharactersPtr() is guaranteed to return the external buffer.

These functions are here to allow wrapping a buffer of UniChar characters in a CFString,
allowing the buffer to passed into CFString functions and also manipulated via CFString
mutation functions. In general, developers should not use this technique for all strings,
as it prevents CFString from using certain optimizations.
}
{ Identifier for character encoding; the values are the same as Text Encoding Converter TextEncoding.
}

TYPE
	CFStringEncoding					= UInt32;
	CFStringEncodingPtr					= ^CFStringEncoding;
	{	 Platform-independent built-in encodings; always available on all platforms.
	   Call CFStringGetSystemEncoding() to get the default system encoding.
		}
	CFStringBuiltInEncodings 	= SInt32;
CONST
	kCFStringEncodingInvalidId	= $FFFFFFFF;
	kCFStringEncodingMacRoman	= 0;
	kCFStringEncodingWindowsLatin1 = $0500;						{  ANSI codepage 1252  }
	kCFStringEncodingISOLatin1	= $0201;						{  ISO 8859-1  }
	kCFStringEncodingNextStepLatin = $0B01;						{  NextStep encoding }
	kCFStringEncodingASCII		= $0600;						{  0..127 (in creating CFString, values greater than 0x7F are treated as corresponding Unicode value)  }
	kCFStringEncodingUnicode	= $0100;						{  kTextEncodingUnicodeDefault  + kTextEncodingDefaultFormat (aka kUnicode16BitFormat)  }
	kCFStringEncodingUTF8		= $08000100;					{  kTextEncodingUnicodeDefault + kUnicodeUTF8Format  }
	kCFStringEncodingNonLossyASCII = $0BFF;						{  7bit Unicode variants used by YellowBox & Java  }

	{	 CFString type ID 	}
	{
	 *  CFStringGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFStringGetTypeID: CFTypeID; C;

{ Macro to allow creation of compile-time constant strings; the argument should be a constant string.

CFSTR(), not being a "Copy" or "Create" function, does not return a new
reference for you. So, you should not release the return value. This is
much like constant C or Pascal strings --- when you use "hello world"
in a program, you do not free it.

However, strings returned from CFSTR() can be retained and released in a
properly nested fashion, just like any other CF type. That is, if you pass
a CFSTR() return value to a function such as SetMenuItemWithCFString(), the
function can retain it, then later, when it's done with it, it can release it.
}
{** Immutable string creation functions **}
{ Functions to create basic immutable strings. The provided allocator is used for all memory activity in these functions.
}
{ These functions copy the provided buffer into CFString's internal storage. }
{
 *  CFStringCreateWithPascalString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateWithPascalString(alloc: CFAllocatorRef; pStr: Str255; encoding: CFStringEncoding): CFStringRef; C;

{
 *  CFStringCreateWithCString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateWithCString(alloc: CFAllocatorRef; cStr: ConstCStringPtr; encoding: CFStringEncoding): CFStringRef; C;

{
 *  CFStringCreateWithCharacters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateWithCharacters(alloc: CFAllocatorRef; {CONST}VAR chars: UniChar; numChars: CFIndex): CFStringRef; C;

{ These functions try not to copy the provided buffer. The buffer will be deallocated
with the provided contentsDeallocator when it's no longer needed; to not free
the buffer, specify kCFAllocatorNull here. As usual, NULL means default allocator.
NOTE: Do not count on these buffers as being used by the string;
in some cases the CFString might free the buffer and use something else
(for instance if it decides to always use Unicode encoding internally).
In addition, some encodings are not used internally; in
those cases CFString might also dump the provided buffer and use its own.
}
{
 *  CFStringCreateWithPascalStringNoCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateWithPascalStringNoCopy(alloc: CFAllocatorRef; pStr: Str255; encoding: CFStringEncoding; contentsDeallocator: CFAllocatorRef): CFStringRef; C;

{
 *  CFStringCreateWithCStringNoCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateWithCStringNoCopy(alloc: CFAllocatorRef; cStr: ConstCStringPtr; encoding: CFStringEncoding; contentsDeallocator: CFAllocatorRef): CFStringRef; C;

{
 *  CFStringCreateWithCharactersNoCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateWithCharactersNoCopy(alloc: CFAllocatorRef; {CONST}VAR chars: UniChar; numChars: CFIndex; contentsDeallocator: CFAllocatorRef): CFStringRef; C;

{ Create copies of part or all of the string.
}
{
 *  CFStringCreateWithSubstring()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateWithSubstring(alloc: CFAllocatorRef; str: CFStringRef; range: CFRange): CFStringRef; C;

{
 *  CFStringCreateCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateCopy(alloc: CFAllocatorRef; theString: CFStringRef): CFStringRef; C;

{ Functions to create mutable strings. "maxLength", if not 0, is a hard bound on the length of the string. If 0, there is no limit on the length.
}
{
 *  CFStringCreateMutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateMutable(alloc: CFAllocatorRef; maxLength: CFIndex): CFMutableStringRef; C;

{
 *  CFStringCreateMutableCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateMutableCopy(alloc: CFAllocatorRef; maxLength: CFIndex; theString: CFStringRef): CFMutableStringRef; C;

{ This function creates a mutable string that has a developer supplied and directly editable backing store.
The string will be manipulated within the provided buffer (if any) until it outgrows capacity; then the
externalCharactersAllocator will be consulted for more memory. When the CFString is deallocated, the
buffer will be freed with the externalCharactersAllocator. Provide kCFAllocatorNull here to prevent the buffer
from ever being reallocated or deallocated by CFString. See comments at top of this file for more info.
}
{
 *  CFStringCreateMutableWithExternalCharactersNoCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateMutableWithExternalCharactersNoCopy(alloc: CFAllocatorRef; VAR chars: UniChar; numChars: CFIndex; capacity: CFIndex; externalCharactersAllocator: CFAllocatorRef): CFMutableStringRef; C;

{** Basic accessors for the contents **}
{ Number of 16-bit Unicode characters in the string.
}
{
 *  CFStringGetLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetLength(theString: CFStringRef): CFIndex; C;

{ Extracting the contents of the string. For obtaining multiple characters, calling
CFStringGetCharacters() is more efficient than multiple calls to CFStringGetCharacterAtIndex().
If the length of the string is not known (so you can't use a fixed size buffer for CFStringGetCharacters()),
another method is to use is CFStringGetCharacterFromInlineBuffer() (see further below).
}
{
 *  CFStringGetCharacterAtIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetCharacterAtIndex(theString: CFStringRef; idx: CFIndex): UniChar; C;

{
 *  CFStringGetCharacters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringGetCharacters(theString: CFStringRef; range: CFRange; VAR buffer: UniChar); C;

{** Conversion to other encodings **}
{ These two convert into the provided buffer; they return FALSE if conversion isn't possible
(due to conversion error, or not enough space in the provided buffer).
These functions do zero-terminate or put the length byte; the provided bufferSize should include
space for this (so pass 256 for Str255). More sophisticated usages can go through CFStringGetBytes().
These functions are equivalent to calling CFStringGetBytes() with
the range of the string; lossByte = 0; and isExternalRepresentation = FALSE;
if successful, they then insert the leading length of terminating zero, as desired.
}
{
 *  CFStringGetPascalString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetPascalString(theString: CFStringRef; buffer: StringPtr; bufferSize: CFIndex; encoding: CFStringEncoding): BOOLEAN; C;

{
 *  CFStringGetCString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetCString(theString: CFStringRef; buffer: CStringPtr; bufferSize: CFIndex; encoding: CFStringEncoding): BOOLEAN; C;

{ These functions attempt to return in O(1) time the desired format for the string.
Note that although this means a pointer to the internal structure is being returned,
this can't always be counted on. Please see note at the top of the file for more
details.
}
{
 *  CFStringGetPascalStringPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetPascalStringPtr(theString: CFStringRef; encoding: CFStringEncoding): ConstStringPtr; C;

{ Be prepared for NULL }
{
 *  CFStringGetCStringPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetCStringPtr(theString: CFStringRef; encoding: CFStringEncoding): ConstCStringPtr; C;

{ Be prepared for NULL }
{
 *  CFStringGetCharactersPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetCharactersPtr(theString: CFStringRef): UniCharPtr; C;

{ Be prepared for NULL }
{ The primitive conversion routine; allows you to convert a string piece at a time
   into a fixed size buffer. Returns number of characters converted.
   Characters that cannot be converted to the specified encoding are represented
   with the byte specified by lossByte; if lossByte is 0, then lossy conversion
   is not allowed and conversion stops, returning partial results.
   Pass buffer==NULL if you don't care about the converted string (but just the convertability,
   or number of bytes required).
   maxBufLength indicates the maximum number of bytes to generate. It is ignored when buffer==NULL.
   Does not zero-terminate. If you want to create Pascal or C string, allow one extra byte at start or end.
   Setting isExternalRepresentation causes any extra bytes that would allow
   the data to be made persistent to be included; for instance, the Unicode BOM.
}
{
 *  CFStringGetBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetBytes(theString: CFStringRef; range: CFRange; encoding: CFStringEncoding; lossByte: ByteParameter; isExternalRepresentation: BOOLEAN; VAR buffer: UInt8; maxBufLen: CFIndex; VAR usedBufLen: CFIndex): CFIndex; C;

{ This one goes the other way by creating a CFString from a bag of bytes.
This is much like CFStringCreateWithPascalString or CFStringCreateWithCString,
except the length is supplied explicitly. In addition, you can specify whether
the data is an external format --- that is, whether to pay attention to the
BOM character (if any) and do byte swapping if necessary
}
{
 *  CFStringCreateWithBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateWithBytes(alloc: CFAllocatorRef; {CONST}VAR bytes: UInt8; numBytes: CFIndex; encoding: CFStringEncoding; isExternalRepresentation: BOOLEAN): CFStringRef; C;

{ Convenience functions String <-> Data. These generate "external" formats, that is, formats that
   can be written out to disk. For instance, if the encoding is Unicode, CFStringCreateFromExternalRepresentation()
   pays attention to the BOM character (if any) and does byte swapping if necessary.
   Similarly CFStringCreateExternalRepresentation() will always include a BOM character if the encoding is
   Unicode. See above for description of lossByte.
}
{
 *  CFStringCreateFromExternalRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateFromExternalRepresentation(alloc: CFAllocatorRef; data: CFDataRef; encoding: CFStringEncoding): CFStringRef; C;

{ May return NULL on conversion error }
{
 *  CFStringCreateExternalRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateExternalRepresentation(alloc: CFAllocatorRef; theString: CFStringRef; encoding: CFStringEncoding; lossByte: ByteParameter): CFDataRef; C;

{ May return NULL on conversion error }
{ Hints about the contents of a string
}
{
 *  CFStringGetSmallestEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetSmallestEncoding(theString: CFStringRef): CFStringEncoding; C;

{ Result in O(n) time max }
{
 *  CFStringGetFastestEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetFastestEncoding(theString: CFStringRef): CFStringEncoding; C;

{ Result in O(1) time max }
{ General encoding info
}
{
 *  CFStringGetSystemEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetSystemEncoding: CFStringEncoding; C;

{ The default encoding for the system; untagged 8-bit characters are usually in this encoding }
{
 *  CFStringGetMaximumSizeForEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetMaximumSizeForEncoding(length: CFIndex; encoding: CFStringEncoding): CFIndex; C;

{ Max bytes a string of specified length (in UniChars) will take up if encoded }
{** Comparison functions. **}

TYPE
	CFStringCompareFlags 		= SInt32;
CONST
																{  Flags used in all find and compare operations  }
	kCFCompareCaseInsensitive	= 1;
	kCFCompareBackwards			= 4;							{  Starting from the end of the string  }
	kCFCompareAnchored			= 8;							{  Only at the specified starting point  }
	kCFCompareNonliteral		= 16;							{  If specified, loose equivalence is performed (o-umlaut == o, umlaut)  }
	kCFCompareLocalized			= 32;							{  User's default locale is used for the comparisons  }
	kCFCompareNumerically		= 64;							{  Numeric comparison is used; that is, Foo2.txt < Foo7.txt < Foo25.txt  }

	{	 The main comparison routine; compares specified range of the string to another.
	   locale == NULL indicates canonical locale
		}
	{
	 *  CFStringCompareWithOptions()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFStringCompareWithOptions(theString1: CFStringRef; theString2: CFStringRef; rangeToCompare: CFRange; compareOptions: CFOptionFlags): CFComparisonResult; C;

{ Comparison convenience suitable for passing as sorting functions.
}
{
 *  CFStringCompare()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCompare(theString1: CFStringRef; theString2: CFStringRef; compareOptions: CFOptionFlags): CFComparisonResult; C;

{ Find routines; CFStringFindWithOptions() returns the found range in the CFRange * argument;  You can pass NULL for simple discovery check.
   CFStringCreateArrayWithFindResults() returns an array of CFRange pointers, or NULL if there are no matches.
}
{
 *  CFStringFindWithOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringFindWithOptions(theString: CFStringRef; stringToFind: CFStringRef; rangeToSearch: CFRange; searchOptions: CFOptionFlags; VAR result: CFRange): BOOLEAN; C;

{
 *  CFStringCreateArrayWithFindResults()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateArrayWithFindResults(alloc: CFAllocatorRef; theString: CFStringRef; stringToFind: CFStringRef; rangeToSearch: CFRange; compareOptions: CFOptionFlags): CFArrayRef; C;

{ Find conveniences
}
{
 *  CFStringFind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringFind(theString: CFStringRef; stringToFind: CFStringRef; compareOptions: CFOptionFlags): CFRange; C;

{
 *  CFStringHasPrefix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringHasPrefix(theString: CFStringRef; prefix: CFStringRef): BOOLEAN; C;

{
 *  CFStringHasSuffix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringHasSuffix(theString: CFStringRef; suffix: CFStringRef): BOOLEAN; C;

{ Find range of bounds of the line(s) that span the indicated range (startIndex, numChars),
   taking into account various possible line separator sequences (CR, CRLF, LF, and Unicode LS, PS).
   All return values are "optional" (provide NULL if you don't want them)
     lineStartIndex: index of first character in line
     lineEndIndex: index of first character of the next line (including terminating line separator characters)
     contentsEndIndex: index of the first line separator character
   Thus, lineEndIndex - lineStartIndex is the number of chars in the line, including the line separators
         contentsEndIndex - lineStartIndex is the number of chars in the line w/out the line separators
}
{
 *  CFStringGetLineBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringGetLineBounds(theString: CFStringRef; range: CFRange; VAR lineBeginIndex: CFIndex; VAR lineEndIndex: CFIndex; VAR contentsEndIndex: CFIndex); C;

{** Exploding and joining strings with a separator string **}
{
 *  CFStringCreateByCombiningStrings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateByCombiningStrings(alloc: CFAllocatorRef; theArray: CFArrayRef; separatorString: CFStringRef): CFStringRef; C;

{ Empty array returns empty string; one element array returns the element }
{
 *  CFStringCreateArrayBySeparatingStrings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringCreateArrayBySeparatingStrings(alloc: CFAllocatorRef; theString: CFStringRef; separatorString: CFStringRef): CFArrayRef; C;

{ No separators in the string returns array with that string; string == sep returns two empty strings }
{** Parsing non-localized numbers from strings **}
{
 *  CFStringGetIntValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetIntValue(str: CFStringRef): SInt32; C;

{ Skips whitespace; returns 0 on error, MAX or -MAX on overflow }
{
 *  CFStringGetDoubleValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetDoubleValue(str: CFStringRef): Double; C;

{ Skips whitespace; returns 0.0 on error }
{** MutableString functions **}
{ CFStringAppend("abcdef", "xxxxx") -> "abcdefxxxxx"
   CFStringDelete("abcdef", CFRangeMake(2, 3)) -> "abf"
   CFStringReplace("abcdef", CFRangeMake(2, 3), "xxxxx") -> "abxxxxxf"
   CFStringReplaceAll("abcdef", "xxxxx") -> "xxxxx"
}
{
 *  CFStringAppend()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringAppend(theString: CFMutableStringRef; appendedString: CFStringRef); C;

{
 *  CFStringAppendCharacters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringAppendCharacters(theString: CFMutableStringRef; {CONST}VAR chars: UniChar; numChars: CFIndex); C;

{
 *  CFStringAppendPascalString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringAppendPascalString(theString: CFMutableStringRef; pStr: Str255; encoding: CFStringEncoding); C;

{
 *  CFStringAppendCString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringAppendCString(theString: CFMutableStringRef; cStr: ConstCStringPtr; encoding: CFStringEncoding); C;

{
 *  CFStringAppendFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringAppendFormat(theString: CFMutableStringRef; formatOptions: CFDictionaryRef; format: CFStringRef; ...); C;

{
 *  CFStringInsert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringInsert(str: CFMutableStringRef; idx: CFIndex; insertedStr: CFStringRef); C;

{
 *  CFStringDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringDelete(theString: CFMutableStringRef; range: CFRange); C;

{
 *  CFStringReplace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringReplace(theString: CFMutableStringRef; range: CFRange; replacement: CFStringRef); C;

{
 *  CFStringReplaceAll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringReplaceAll(theString: CFMutableStringRef; replacement: CFStringRef); C;

{ Replaces whole string }
{ This function will make the contents of a mutable CFString point directly at the specified UniChar array.
it works only with CFStrings created with CFStringCreateMutableWithExternalCharactersNoCopy().
This function does not free the previous buffer.
The string will be manipulated within the provided buffer (if any) until it outgrows capacity; then the
externalCharactersAllocator will be consulted for more memory.
See comments at the top of this file for more info.
}
{
 *  CFStringSetExternalCharactersNoCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringSetExternalCharactersNoCopy(theString: CFMutableStringRef; VAR chars: UniChar; length: CFIndex; capacity: CFIndex); C;

{ Works only on specially created mutable strings! }
{ CFStringPad() will pad or cut down a string to the specified size.
   The pad string is used as the fill string; indexIntoPad specifies which character to start with.
     CFStringPad("abc", " ", 9, 0) ->  "abc      "
     CFStringPad("abc", ". ", 9, 1) -> "abc . . ."
     CFStringPad("abcdef", ?, 3, ?) -> "abc"

     CFStringTrim() will trim the specified string from both ends of the string.
     CFStringTrimWhitespace() will do the same with white space characters (tab, newline, etc)
     CFStringTrim("  abc ", " ") -> "abc"
     CFStringTrim("* * * *abc * ", "* ") -> "*abc "
}
{
 *  CFStringPad()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringPad(theString: CFMutableStringRef; padString: CFStringRef; length: CFIndex; indexIntoPad: CFIndex); C;

{
 *  CFStringTrim()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringTrim(theString: CFMutableStringRef; trimString: CFStringRef); C;

{
 *  CFStringTrimWhitespace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringTrimWhitespace(theString: CFMutableStringRef); C;

{
 *  CFStringLowercase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringLowercase(theString: CFMutableStringRef; localeTBD: UNIV Ptr); C;

{
 *  CFStringUppercase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringUppercase(theString: CFMutableStringRef; localeTBD: UNIV Ptr); C;

{
 *  CFStringCapitalize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFStringCapitalize(theString: CFMutableStringRef; localeTBD: UNIV Ptr); C;

{ This returns availability of the encoding on the system
}
{
 *  CFStringIsEncodingAvailable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringIsEncodingAvailable(encoding: CFStringEncoding): BOOLEAN; C;

{ This function returns list of available encodings.  The returned list is terminated with kCFStringEncodingInvalidId and owned by the system.
}
{
 *  CFStringGetListOfAvailableEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetListOfAvailableEncodings: CFStringEncodingPtr; C;

{ Returns name of the encoding
}
{
 *  CFStringGetNameOfEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetNameOfEncoding(encoding: CFStringEncoding): CFStringRef; C;

{ ID mapping functions from/to YellowBox NSStringEncoding.  Returns kCFStringEncodingInvalidId if no mapping exists.
}
{
 *  CFStringConvertEncodingToNSStringEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringConvertEncodingToNSStringEncoding(encoding: CFStringEncoding): UInt32; C;

{
 *  CFStringConvertNSStringEncodingToEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringConvertNSStringEncodingToEncoding(encoding: UInt32): CFStringEncoding; C;

{ ID mapping functions from/to Microsoft Windows codepage (covers both OEM & ANSI).  Returns kCFStringEncodingInvalidId if no mapping exists.
}
{
 *  CFStringConvertEncodingToWindowsCodepage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringConvertEncodingToWindowsCodepage(encoding: CFStringEncoding): UInt32; C;

{
 *  CFStringConvertWindowsCodepageToEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringConvertWindowsCodepageToEncoding(codepage: UInt32): CFStringEncoding; C;

{ ID mapping functions from/to IANA registery charset names.  Returns kCFStringEncodingInvalidId if no mapping exists.
}
{
 *  CFStringConvertIANACharSetNameToEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringConvertIANACharSetNameToEncoding(theString: CFStringRef): CFStringEncoding; C;

{
 *  CFStringConvertEncodingToIANACharSetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringConvertEncodingToIANACharSetName(encoding: CFStringEncoding): CFStringRef; C;

{ Returns the most compatible MacOS script value for the input encoding }
{ i.e. kCFStringEncodingMacRoman -> kCFStringEncodingMacRoman }
{     kCFStringEncodingWindowsLatin1 -> kCFStringEncodingMacRoman }
{     kCFStringEncodingISO_2022_JP -> kCFStringEncodingMacJapanese }
{
 *  CFStringGetMostCompatibleMacStringEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFStringGetMostCompatibleMacStringEncoding(encoding: CFStringEncoding): CFStringEncoding; C;


{ Rest of the stuff in this file is private and should not be used directly
}
{ For debugging only
   Use CFShow() to printf the description of any CFType;
   Use CFShowStr() to printf detailed info about a CFString
}
{
 *  CFShow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFShow(obj: CFTypeRef); C;

{
 *  CFShowStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFShowStr(str: CFStringRef); C;

{ This function is private and should not be used directly }
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFStringIncludes}

{$ENDC} {__CFSTRING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
