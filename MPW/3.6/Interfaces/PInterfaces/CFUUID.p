{
     File:       CFUUID.p
 
     Contains:   CoreFoundation UUIDs
 
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
 UNIT CFUUID;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFUUID__}
{$SETC __CFUUID__ := 1}

{$I+}
{$SETC CFUUIDIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFUUIDRef    = ^LONGINT; { an opaque 32-bit type }
	CFUUIDRefPtr = ^CFUUIDRef;  { when a VAR xx:CFUUIDRef parameter can be nil, it is changed to xx: CFUUIDRefPtr }
	CFUUIDBytesPtr = ^CFUUIDBytes;
	CFUUIDBytes = RECORD
		byte0:					SInt8;
		byte1:					SInt8;
		byte2:					SInt8;
		byte3:					SInt8;
		byte4:					SInt8;
		byte5:					SInt8;
		byte6:					SInt8;
		byte7:					SInt8;
		byte8:					SInt8;
		byte9:					SInt8;
		byte10:					SInt8;
		byte11:					SInt8;
		byte12:					SInt8;
		byte13:					SInt8;
		byte14:					SInt8;
		byte15:					SInt8;
	END;

	{	 The CFUUIDBytes struct is a 128-bit struct that contains the
	raw UUID.  A CFUUIDRef can provide such a struct from the
	CFUUIDGetUUIDBytes() function.  This struct is suitable for
	passing to APIs that expect a raw UUID.
		}
	{
	 *  CFUUIDGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFUUIDGetTypeID: CFTypeID; C;

{
 *  CFUUIDCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFUUIDCreate(alloc: CFAllocatorRef): CFUUIDRef; C;

{ Create and return a brand new unique identifier }
{
 *  CFUUIDCreateWithBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFUUIDCreateWithBytes(alloc: CFAllocatorRef; byte0: ByteParameter; byte1: ByteParameter; byte2: ByteParameter; byte3: ByteParameter; byte4: ByteParameter; byte5: ByteParameter; byte6: ByteParameter; byte7: ByteParameter; byte8: ByteParameter; byte9: ByteParameter; byte10: ByteParameter; byte11: ByteParameter; byte12: ByteParameter; byte13: ByteParameter; byte14: ByteParameter; byte15: ByteParameter): CFUUIDRef; C;

{ Create and return an identifier with the given contents.  This may return an existing instance with its ref count bumped because of uniquing. }
{
 *  CFUUIDCreateFromString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFUUIDCreateFromString(alloc: CFAllocatorRef; uuidStr: CFStringRef): CFUUIDRef; C;

{ Converts from a string representation to the UUID.  This may return an existing instance with its ref count bumped because of uniquing. }
{
 *  CFUUIDCreateString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFUUIDCreateString(alloc: CFAllocatorRef; uuid: CFUUIDRef): CFStringRef; C;

{ Converts from a UUID to its string representation. }
{
 *  CFUUIDGetConstantUUIDWithBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFUUIDGetConstantUUIDWithBytes(alloc: CFAllocatorRef; byte0: ByteParameter; byte1: ByteParameter; byte2: ByteParameter; byte3: ByteParameter; byte4: ByteParameter; byte5: ByteParameter; byte6: ByteParameter; byte7: ByteParameter; byte8: ByteParameter; byte9: ByteParameter; byte10: ByteParameter; byte11: ByteParameter; byte12: ByteParameter; byte13: ByteParameter; byte14: ByteParameter; byte15: ByteParameter): CFUUIDRef; C;

{ This returns an immortal CFUUIDRef that should not be released.  It can be used in headers to declare UUID constants with #define. }
{
 *  CFUUIDGetUUIDBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFUUIDGetUUIDBytes(uuid: CFUUIDRef): CFUUIDBytes; C;

{
 *  CFUUIDCreateFromUUIDBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFUUIDCreateFromUUIDBytes(alloc: CFAllocatorRef; bytes: CFUUIDBytes): CFUUIDRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFUUIDIncludes}

{$ENDC} {__CFUUID__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
