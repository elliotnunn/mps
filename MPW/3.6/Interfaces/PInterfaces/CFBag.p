{
     File:       CFBag.p
 
     Contains:   CoreFoundation bag collection
 
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
 UNIT CFBag;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFBAG__}
{$SETC __CFBAG__ := 1}

{$I+}
{$SETC CFBagIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFBagRetainCallBack = FUNCTION(allocator: CFAllocatorRef; value: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFBagRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFBagReleaseCallBack = PROCEDURE(allocator: CFAllocatorRef; value: UNIV Ptr); C;
{$ELSEC}
	CFBagReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFBagCopyDescriptionCallBack = FUNCTION(value: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFBagCopyDescriptionCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFBagEqualCallBack = FUNCTION(value1: UNIV Ptr; value2: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFBagEqualCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFBagHashCallBack = FUNCTION(value: UNIV Ptr): CFHashCode; C;
{$ELSEC}
	CFBagHashCallBack = ProcPtr;
{$ENDC}

	CFBagCallBacksPtr = ^CFBagCallBacks;
	CFBagCallBacks = RECORD
		version:				CFIndex;
		retain:					CFBagRetainCallBack;
		release:				CFBagReleaseCallBack;
		copyDescription:		CFBagCopyDescriptionCallBack;
		equal:					CFBagEqualCallBack;
		hash:					CFBagHashCallBack;
	END;

	{
	 *  kCFTypeBagCallBacks
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFCopyStringBagCallBacks
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CFBagApplierFunction = PROCEDURE(value: UNIV Ptr; context: UNIV Ptr); C;
{$ELSEC}
	CFBagApplierFunction = ProcPtr;
{$ENDC}

	CFBagRef    = ^LONGINT; { an opaque 32-bit type }
	CFBagRefPtr = ^CFBagRef;  { when a VAR xx:CFBagRef parameter can be nil, it is changed to xx: CFBagRefPtr }
	CFMutableBagRef    = CFBagRef;
	CFMutableBagRefPtr = ^CFMutableBagRef;  { when a VAR xx:CFMutableBagRef parameter can be nil, it is changed to xx: CFMutableBagRefPtr }
	{
	 *  CFBagGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFBagGetTypeID: CFTypeID; C;

{
 *  CFBagCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBagCreate(allocator: CFAllocatorRef; VAR values: UNIV Ptr; numValues: CFIndex; {CONST}VAR callBacks: CFBagCallBacks): CFBagRef; C;

{
 *  CFBagCreateCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBagCreateCopy(allocator: CFAllocatorRef; theBag: CFBagRef): CFBagRef; C;

{
 *  CFBagCreateMutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBagCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex; {CONST}VAR callBacks: CFBagCallBacks): CFMutableBagRef; C;

{
 *  CFBagCreateMutableCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBagCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; theBag: CFBagRef): CFMutableBagRef; C;

{
 *  CFBagGetCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBagGetCount(theBag: CFBagRef): CFIndex; C;

{
 *  CFBagGetCountOfValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBagGetCountOfValue(theBag: CFBagRef; value: UNIV Ptr): CFIndex; C;

{
 *  CFBagContainsValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBagContainsValue(theBag: CFBagRef; value: UNIV Ptr): BOOLEAN; C;

{
 *  CFBagGetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBagGetValue(theBag: CFBagRef; value: UNIV Ptr): Ptr; C;

{
 *  CFBagGetValueIfPresent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBagGetValueIfPresent(theBag: CFBagRef; candidate: UNIV Ptr; VAR value: UNIV Ptr): BOOLEAN; C;

{
 *  CFBagGetValues()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBagGetValues(theBag: CFBagRef; VAR values: UNIV Ptr); C;

{
 *  CFBagApplyFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBagApplyFunction(theBag: CFBagRef; applier: CFBagApplierFunction; context: UNIV Ptr); C;

{
 *  CFBagAddValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBagAddValue(theBag: CFMutableBagRef; value: UNIV Ptr); C;

{
 *  CFBagReplaceValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBagReplaceValue(theBag: CFMutableBagRef; value: UNIV Ptr); C;

{
 *  CFBagSetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBagSetValue(theBag: CFMutableBagRef; value: UNIV Ptr); C;

{
 *  CFBagRemoveValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBagRemoveValue(theBag: CFMutableBagRef; value: UNIV Ptr); C;

{
 *  CFBagRemoveAllValues()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBagRemoveAllValues(theBag: CFMutableBagRef); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFBagIncludes}

{$ENDC} {__CFBAG__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
