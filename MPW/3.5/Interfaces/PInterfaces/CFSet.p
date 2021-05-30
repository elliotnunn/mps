{
     File:       CFSet.p
 
     Contains:   CoreFoundation set collection
 
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
 UNIT CFSet;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFSET__}
{$SETC __CFSET__ := 1}

{$I+}
{$SETC CFSetIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFSetRetainCallBack = FUNCTION(allocator: CFAllocatorRef; value: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFSetRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFSetReleaseCallBack = PROCEDURE(allocator: CFAllocatorRef; value: UNIV Ptr); C;
{$ELSEC}
	CFSetReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFSetCopyDescriptionCallBack = FUNCTION(value: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFSetCopyDescriptionCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFSetEqualCallBack = FUNCTION(value1: UNIV Ptr; value2: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFSetEqualCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFSetHashCallBack = FUNCTION(value: UNIV Ptr): CFHashCode; C;
{$ELSEC}
	CFSetHashCallBack = ProcPtr;
{$ENDC}

	CFSetCallBacksPtr = ^CFSetCallBacks;
	CFSetCallBacks = RECORD
		version:				CFIndex;
		retain:					CFSetRetainCallBack;
		release:				CFSetReleaseCallBack;
		copyDescription:		CFSetCopyDescriptionCallBack;
		equal:					CFSetEqualCallBack;
		hash:					CFSetHashCallBack;
	END;

	{
	 *  kCFTypeSetCallBacks
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFCopyStringSetCallBacks
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CFSetApplierFunction = PROCEDURE(value: UNIV Ptr; context: UNIV Ptr); C;
{$ELSEC}
	CFSetApplierFunction = ProcPtr;
{$ENDC}

	CFSetRef    = ^LONGINT; { an opaque 32-bit type }
	CFSetRefPtr = ^CFSetRef;  { when a VAR xx:CFSetRef parameter can be nil, it is changed to xx: CFSetRefPtr }
	CFMutableSetRef    = CFSetRef;
	CFMutableSetRefPtr = ^CFMutableSetRef;  { when a VAR xx:CFMutableSetRef parameter can be nil, it is changed to xx: CFMutableSetRefPtr }
	{
	 *  CFSetGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFSetGetTypeID: CFTypeID; C;

{
 *  CFSetCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFSetCreate(allocator: CFAllocatorRef; VAR values: UNIV Ptr; numValues: CFIndex; {CONST}VAR callBacks: CFSetCallBacks): CFSetRef; C;

{
 *  CFSetCreateCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFSetCreateCopy(allocator: CFAllocatorRef; theSet: CFSetRef): CFSetRef; C;

{
 *  CFSetCreateMutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFSetCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex; {CONST}VAR callBacks: CFSetCallBacks): CFMutableSetRef; C;

{
 *  CFSetCreateMutableCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFSetCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; theSet: CFSetRef): CFMutableSetRef; C;

{
 *  CFSetGetCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFSetGetCount(theSet: CFSetRef): CFIndex; C;

{
 *  CFSetGetCountOfValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFSetGetCountOfValue(theSet: CFSetRef; value: UNIV Ptr): CFIndex; C;

{
 *  CFSetContainsValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFSetContainsValue(theSet: CFSetRef; value: UNIV Ptr): BOOLEAN; C;

{
 *  CFSetGetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFSetGetValue(theSet: CFSetRef; value: UNIV Ptr): Ptr; C;

{
 *  CFSetGetValueIfPresent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFSetGetValueIfPresent(theSet: CFSetRef; candidate: UNIV Ptr; VAR value: UNIV Ptr): BOOLEAN; C;

{
 *  CFSetGetValues()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFSetGetValues(theSet: CFSetRef; VAR values: UNIV Ptr); C;

{
 *  CFSetApplyFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFSetApplyFunction(theSet: CFSetRef; applier: CFSetApplierFunction; context: UNIV Ptr); C;

{
 *  CFSetAddValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFSetAddValue(theSet: CFMutableSetRef; value: UNIV Ptr); C;

{
 *  CFSetReplaceValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFSetReplaceValue(theSet: CFMutableSetRef; value: UNIV Ptr); C;

{
 *  CFSetSetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFSetSetValue(theSet: CFMutableSetRef; value: UNIV Ptr); C;

{
 *  CFSetRemoveValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFSetRemoveValue(theSet: CFMutableSetRef; value: UNIV Ptr); C;

{
 *  CFSetRemoveAllValues()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFSetRemoveAllValues(theSet: CFMutableSetRef); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFSetIncludes}

{$ENDC} {__CFSET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
