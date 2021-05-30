{
     File:       CFNumber.p
 
     Contains:   CoreFoundation numbers
 
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
 UNIT CFNumber;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFNUMBER__}
{$SETC __CFNUMBER__ := 1}

{$I+}
{$SETC CFNumberIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFBooleanRef    = ^LONGINT; { an opaque 32-bit type }
	CFBooleanRefPtr = ^CFBooleanRef;  { when a VAR xx:CFBooleanRef parameter can be nil, it is changed to xx: CFBooleanRefPtr }
	{
	 *  kCFBooleanTrue
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFBooleanFalse
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  CFBooleanGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFBooleanGetTypeID: CFTypeID; C;

{
 *  CFBooleanGetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBooleanGetValue(boolean: CFBooleanRef): BOOLEAN; C;


TYPE
	CFNumberType 				= SInt32;
CONST
																{  Types from MacTypes.h  }
	kCFNumberSInt8Type			= 1;
	kCFNumberSInt16Type			= 2;
	kCFNumberSInt32Type			= 3;
	kCFNumberSInt64Type			= 4;
	kCFNumberFloat32Type		= 5;
	kCFNumberFloat64Type		= 6;							{  64-bit IEEE 754  }
																{  Basic C types  }
	kCFNumberCharType			= 7;
	kCFNumberShortType			= 8;
	kCFNumberIntType			= 9;
	kCFNumberLongType			= 10;
	kCFNumberLongLongType		= 11;
	kCFNumberFloatType			= 12;
	kCFNumberDoubleType			= 13;							{  Other  }
	kCFNumberCFIndexType		= 14;
	kCFNumberMaxType			= 14;


TYPE
	CFNumberRef    = ^LONGINT; { an opaque 32-bit type }
	CFNumberRefPtr = ^CFNumberRef;  { when a VAR xx:CFNumberRef parameter can be nil, it is changed to xx: CFNumberRefPtr }
	{
	 *  kCFNumberPositiveInfinity
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFNumberNegativeInfinity
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFNumberNaN
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  CFNumberGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFNumberGetTypeID: CFTypeID; C;

{
    Creates a CFNumber with the given value. The type of number pointed
    to by the valuePtr is specified by type. If type is a floating point
    type and the value represents one of the infinities or NaN, the
    well-defined CFNumber for that value is returned. If either of
    valuePtr or type is an invalid value, the result is undefined.
}
{
 *  CFNumberCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFNumberCreate(allocator: CFAllocatorRef; theType: CFNumberType; valuePtr: UNIV Ptr): CFNumberRef; C;

{
    Returns the storage format of the CFNumber's value.  Note that
    this is not necessarily the type provided in CFNumberCreate().
}
{
 *  CFNumberGetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFNumberGetType(number: CFNumberRef): CFNumberType; C;

{
    Returns the size in bytes of the type of the number.
}
{
 *  CFNumberGetByteSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFNumberGetByteSize(number: CFNumberRef): CFIndex; C;

{
    Returns TRUE if the type of the CFNumber's value is one of
    the defined floating point types.
}
{
 *  CFNumberIsFloatType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFNumberIsFloatType(number: CFNumberRef): BOOLEAN; C;

{
    Copies the CFNumber's value into the space pointed to by
    valuePtr, as the specified type. If conversion needs to take
    place, the conversion rules follow human expectation and not
    C's promotion and truncation rules. If the conversion is
    lossy, or the value is out of range, FALSE is returned. Best
    attempt at conversion will still be in *valuePtr.
}
{
 *  CFNumberGetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFNumberGetValue(number: CFNumberRef; theType: CFNumberType; valuePtr: UNIV Ptr): BOOLEAN; C;

{
    Compares the two CFNumber instances. If conversion of the
    types of the values is needed, the conversion and comparison
    follow human expectations and not C's promotion and comparison
    rules. Negative zero compares less than positive zero.
    Positive infinity compares greater than everything except
    itself, to which it compares equal. Negative infinity compares
    less than everything except itself, to which it compares equal.
    Unlike standard practice, if both numbers are NaN, then they
    compare equal; if only one of the numbers is NaN, then the NaN
    compares greater than the other number if it is negative, and
    smaller than the other number if it is positive. (Note that in
    CFEqual() with two CFNumbers, if either or both of the numbers
    is NaN, FALSE is returned.)
}
{
 *  CFNumberCompare()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFNumberCompare(number: CFNumberRef; otherNumber: CFNumberRef; context: UNIV Ptr): CFComparisonResult; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFNumberIncludes}

{$ENDC} {__CFNUMBER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
