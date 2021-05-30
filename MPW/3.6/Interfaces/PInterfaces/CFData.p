{
     File:       CFData.p
 
     Contains:   CoreFoundation block of bytes
 
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
 UNIT CFData;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFDATA__}
{$SETC __CFDATA__ := 1}

{$I+}
{$SETC CFDataIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFDataRef    = ^LONGINT; { an opaque 32-bit type }
	CFDataRefPtr = ^CFDataRef;  { when a VAR xx:CFDataRef parameter can be nil, it is changed to xx: CFDataRefPtr }
	CFMutableDataRef    = CFDataRef;
	CFMutableDataRefPtr = ^CFMutableDataRef;  { when a VAR xx:CFMutableDataRef parameter can be nil, it is changed to xx: CFMutableDataRefPtr }
	{
	 *  CFDataGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFDataGetTypeID: CFTypeID; C;

{
 *  CFDataCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDataCreate(allocator: CFAllocatorRef; {CONST}VAR bytes: UInt8; length: CFIndex): CFDataRef; C;

{
 *  CFDataCreateWithBytesNoCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDataCreateWithBytesNoCopy(allocator: CFAllocatorRef; {CONST}VAR bytes: UInt8; length: CFIndex; bytesDeallocator: CFAllocatorRef): CFDataRef; C;

{ Pass kCFAllocatorNull as bytesDeallocator to assure the bytes aren't freed }
{
 *  CFDataCreateCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDataCreateCopy(allocator: CFAllocatorRef; theData: CFDataRef): CFDataRef; C;

{
 *  CFDataCreateMutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDataCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex): CFMutableDataRef; C;

{
 *  CFDataCreateMutableCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDataCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; theData: CFDataRef): CFMutableDataRef; C;

{
 *  CFDataGetLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDataGetLength(theData: CFDataRef): CFIndex; C;

{
 *  CFDataGetBytePtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDataGetBytePtr(theData: CFDataRef): Ptr; C;

{
 *  CFDataGetMutableBytePtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDataGetMutableBytePtr(theData: CFMutableDataRef): Ptr; C;

{
 *  CFDataGetBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDataGetBytes(theData: CFDataRef; range: CFRange; VAR buffer: UInt8); C;

{
 *  CFDataSetLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDataSetLength(theData: CFMutableDataRef; length: CFIndex); C;

{
 *  CFDataIncreaseLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDataIncreaseLength(theData: CFMutableDataRef; extraLength: CFIndex); C;

{
 *  CFDataAppendBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDataAppendBytes(theData: CFMutableDataRef; {CONST}VAR bytes: UInt8; length: CFIndex); C;

{
 *  CFDataReplaceBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDataReplaceBytes(theData: CFMutableDataRef; range: CFRange; {CONST}VAR newBytes: UInt8; newLength: CFIndex); C;

{
 *  CFDataDeleteBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDataDeleteBytes(theData: CFMutableDataRef; range: CFRange); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFDataIncludes}

{$ENDC} {__CFDATA__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
