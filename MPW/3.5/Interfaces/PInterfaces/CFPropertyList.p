{
     File:       CFPropertyList.p
 
     Contains:   CoreFoundation PropertyList
 
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
 UNIT CFPropertyList;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFPROPERTYLIST__}
{$SETC __CFPROPERTYLIST__ := 1}

{$I+}
{$SETC CFPropertyListIncludes := UsingIncludes}
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

{
    Type to mean any instance of a property list type;
    currently, CFString, CFData, CFNumber, CFBoolean, CFDate,
    CFArray, and CFDictionary.
}

TYPE
	CFPropertyListRef					= CFTypeRef;
	CFPropertyListMutabilityOptions  = SInt32;
CONST
	kCFPropertyListImmutable	= 0;
	kCFPropertyListMutableContainers = 1;
	kCFPropertyListMutableContainersAndLeaves = 2;

	{	
	    Creates a property list object from its XML description; xmlData should
	    be the raw bytes of that description, possibly the contents of an XML
	    file. Returns NULL if the data cannot be parsed; if the parse fails
	    and errorString is non-NULL, a human-readable description of the failure
	    is returned in errorString. It is the caller's responsibility to release
	    either the returned object or the error string, whichever is applicable.
		}
	{
	 *  CFPropertyListCreateFromXMLData()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFPropertyListCreateFromXMLData(allocator: CFAllocatorRef; xmlData: CFDataRef; mutabilityOption: CFOptionFlags; VAR errorString: CFStringRef): CFPropertyListRef; C;

{
    Returns the XML description of the given object; propertyList must
    be one of the supported property list types, and (for composite types
    like CFArray and CFDictionary) must not contain any elements that
    are not themselves of a property list type. If a non-property list
    type is encountered, NULL is returned. The returned data is
    appropriate for writing out to an XML file. Note that a data, not a
    string, is returned because the bytes contain in them a description
    of the string encoding used.
}
{
 *  CFPropertyListCreateXMLData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPropertyListCreateXMLData(allocator: CFAllocatorRef; propertyList: CFPropertyListRef): CFDataRef; C;

{
    Recursively creates a copy of the given property list (so nested arrays
    and dictionaries are copied as well as the top-most container). The
    resulting property list has the mutability characteristics determined
    by mutabilityOption.
}
{
 *  CFPropertyListCreateDeepCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPropertyListCreateDeepCopy(allocator: CFAllocatorRef; propertyList: CFPropertyListRef; mutabilityOption: CFOptionFlags): CFPropertyListRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFPropertyListIncludes}

{$ENDC} {__CFPROPERTYLIST__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
