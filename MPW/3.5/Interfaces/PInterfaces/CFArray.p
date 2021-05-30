{
     File:       CFArray.p
 
     Contains:   CoreFoundation array collection
 
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
 UNIT CFArray;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFARRAY__}
{$SETC __CFARRAY__ := 1}

{$I+}
{$SETC CFArrayIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{
 *  CFArray
 *  
 *  Discussion:
 *    CFArray implements an ordered, compact container of pointer-sized
 *    values. Values are accessed via integer keys (indices), from the
 *    range 0 to N-1, where N is the number of values in the array when
 *    an operation is performed. The array is said to be "compact"
 *    because deleted or inserted values do not leave a gap in the key
 *    space -- the values with higher-numbered indices have their
 *    indices renumbered lower (or higher, in the case of insertion) so
 *    that the set of valid indices is always in the integer range [0,
 *    N-1]. Thus, the index to access a particular value in the array
 *    may change over time as other values are inserted into or deleted
 *    from the array. 
 *    
 *    Arrays come in two flavors, immutable, which cannot have values
 *    added to them or removed from them after the array is created,
 *    and mutable, to which you can add values or from which remove
 *    values. Mutable arrays have two subflavors, fixed-capacity, for
 *    which there is a maximum number set at creation time of values
 *    which can be put into the array, and variable capacity, which can
 *    have an unlimited number of values (or rather, limited only by
 *    constraints external to CFArray, like the amount of available
 *    memory). Fixed-capacity arrays can be somewhat higher performing,
 *    if you can put a definate upper limit on the number of values
 *    that might be put into the array. 
 *    
 *    As with all CoreFoundation collection types, arrays maintain hard
 *    references on the values you put in them, but the retaining and
 *    releasing functions are user-defined callbacks that can actually
 *    do whatever the user wants (for example, nothing). 
 *    
 *    Computational Complexity The access time for a value in the array
 *    is guaranteed to be at worst O(lg N) for any implementation,
 *    current and future, but will often be O(1) (constant time).
 *    Linear search operations similarly have a worst case complexity
 *    of O(N*lg N), though typically the bounds will be tighter, and so
 *    on. Insertion or deletion operations will typically be linear in
 *    the number of values in the array, but may be O(N*lg N) clearly
 *    in the worst case in some implementations. There are no favored
 *    positions within the array for performance; that is, it is not
 *    necessarily faster access values with low indices, or to insert
 *    or delete values with high indices, or whatever.
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayRetainCallBack = FUNCTION(allocator: CFAllocatorRef; value: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFArrayRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayReleaseCallBack = PROCEDURE(allocator: CFAllocatorRef; value: UNIV Ptr); C;
{$ELSEC}
	CFArrayReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayCopyDescriptionCallBack = FUNCTION(value: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFArrayCopyDescriptionCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayEqualCallBack = FUNCTION(value1: UNIV Ptr; value2: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFArrayEqualCallBack = ProcPtr;
{$ENDC}


	{
	 *  CFArrayCallBacks
	 *  
	 *  Discussion:
	 *    Structure containing the callbacks of a CFArray.
	 	}
	CFArrayCallBacksPtr = ^CFArrayCallBacks;
	CFArrayCallBacks = RECORD
		version:				CFIndex;
		retain:					CFArrayRetainCallBack;
		release:				CFArrayReleaseCallBack;
		copyDescription:		CFArrayCopyDescriptionCallBack;
		equal:					CFArrayEqualCallBack;
	END;

	{
	 *  kCFTypeArrayCallBacks
	 *  
	 *  Discussion:
	 *    Predefined CFArrayCallBacks structure containing a set of
	 *    callbacks appropriate for use when the values in a CFArray are
	 *    all CFTypes.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}

	{
	 *  CFArrayApplierFunction
	 *  
	 *  Discussion:
	 *    Type of the callback function used by the apply functions of
	 *    CFArrays.
	 *  
	 *  Parameters:
	 *    
	 *    val:
	 *      The current value from the array.
	 *    
	 *    context:
	 *      The user-defined context parameter given to the apply function.
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CFArrayApplierFunction = PROCEDURE(value: UNIV Ptr; context: UNIV Ptr); C;
{$ELSEC}
	CFArrayApplierFunction = ProcPtr;
{$ENDC}


	{
	 *  CFArrayRef
	 *  
	 *  Discussion:
	 *    This is the type of a reference to immutable CFArrays.
	 	}
	CFArrayRef    = ^LONGINT; { an opaque 32-bit type }
	CFArrayRefPtr = ^CFArrayRef;  { when a VAR xx:CFArrayRef parameter can be nil, it is changed to xx: CFArrayRefPtr }

	{
	 *  CFMutableArrayRef
	 *  
	 *  Discussion:
	 *    This is the type of a reference to mutable CFArrays.
	 	}
	CFMutableArrayRef    = CFArrayRef;
	CFMutableArrayRefPtr = ^CFMutableArrayRef;  { when a VAR xx:CFMutableArrayRef parameter can be nil, it is changed to xx: CFMutableArrayRefPtr }
	{
	 *  CFArrayGetTypeID()
	 *  
	 *  Discussion:
	 *    Returns the type identifier of all CFArray instances.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFArrayGetTypeID: CFTypeID; C;

{
 *  CFArrayCreate()
 *  
 *  Discussion:
 *    Creates a new immutable array with the given values.
 *  
 *  Parameters:
 *    
 *    allocator:
 *      The CFAllocator which should be used to allocate memory for the
 *      array and its storage for values. This parameter may be NULL in
 *      which case the current default CFAllocator is used. If this
 *      reference is not a valid CFAllocator, the behavior is undefined.
 *    
 *    values:
 *      A C array of the pointer-sized values to be in the array. The
 *      values in the array are ordered in the same order in which they
 *      appear in this C array. This parameter may be NULL if the
 *      numValues parameter is 0. This C array is not changed or freed
 *      by this function. If this parameter is not a valid pointer to a
 *      C array of at least numValues pointers, the behavior is
 *      undefined.
 *    
 *    numValues:
 *      The number of values to copy from the values C array into the
 *      CFArray. This number will be the count of the array. If this
 *      parameter is negative, or greater than the number of values
 *      actually in the values C array, the behavior is undefined.
 *    
 *    callBacks:
 *      A pointer to a CFArrayCallBacks structure initialized with the
 *      callbacks for the array to use on each value in the array. The
 *      retain callback will be used within this function, for example,
 *      to retain all of the new values from the values C array. A copy
 *      of the contents of the callbacks structure is made, so that a
 *      pointer to a structure on the stack can be passed in, or can be
 *      reused for multiple array creations. If the version field of
 *      this callbacks structure is not one of the defined ones for
 *      CFArray, the behavior is undefined. The retain field may be
 *      NULL, in which case the CFArray will do nothing to add a retain
 *      to the contained values for the array. The release field may be
 *      NULL, in which case the CFArray will do nothing to remove the
 *      array's retain (if any) on the values when the array is
 *      destroyed. If the copyDescription field is NULL, the array will
 *      create a simple description for the value. If the equal field
 *      is NULL, the array will use pointer equality to test for
 *      equality of values. This callbacks parameter itself may be
 *      NULL, which is treated as if a valid structure of version 0
 *      with all fields NULL had been passed in. Otherwise, if any of
 *      the fields are not valid pointers to functions of the correct
 *      type, or this parameter is not a valid pointer to a 
 *      CFArrayCallBacks callbacks structure, the behavior is
 *      undefined. If any of the values put into the array is not one
 *      understood by one of the callback functions the behavior when
 *      that callback function is used is undefined.
 *  
 *  Result:
 *    A reference to the new immutable CFArray.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayCreate(allocator: CFAllocatorRef; VAR values: UNIV Ptr; numValues: CFIndex; {CONST}VAR callBacks: CFArrayCallBacks): CFArrayRef; C;

{
 *  CFArrayCreateCopy()
 *  
 *  Discussion:
 *    Creates a new immutable array with the values from the given
 *    array.
 *  
 *  Parameters:
 *    
 *    allocator:
 *      The CFAllocator which should be used to allocate memory for the
 *      array and its storage for values. This parameter may be NULL in
 *      which case the current default CFAllocator is used. If this
 *      reference is not a valid CFAllocator, the behavior is undefined.
 *    
 *    theArray:
 *      The array which is to be copied. The values from the array are
 *      copied as pointers into the new array (that is, the values
 *      themselves are copied, not that which the values point to, if
 *      anything). However, the values are also retained by the new
 *      array. The count of the new array will be the same as the given
 *      array. The new array uses the same callbacks as the array to be
 *      copied. If this parameter is not a valid CFArray, the behavior
 *      is undefined.
 *  
 *  Result:
 *    A reference to the new immutable CFArray.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayCreateCopy(allocator: CFAllocatorRef; theArray: CFArrayRef): CFArrayRef; C;

{
 *  CFArrayCreateMutable()
 *  
 *  Discussion:
 *    Creates a new empty mutable array.
 *  
 *  Parameters:
 *    
 *    allocator:
 *      The CFAllocator which should be used to allocate memory for the
 *      array and its storage for values. This parameter may be NULL in
 *      which case the current default CFAllocator is used. If this
 *      reference is not a valid CFAllocator, the behavior is undefined.
 *    
 *    capacity:
 *      The maximum number of values that can be contained by the
 *      CFArray. The array starts empty, and can grow to this number of
 *      values (and it can have less). If this parameter is 0, the
 *      array's maximum capacity is unlimited (or rather, only limited
 *      by address space and available memory constraints). If this
 *      parameter is negative, the behavior is undefined.
 *    
 *    callBacks:
 *      A pointer to a CFArrayCallBacks structure initialized with the
 *      callbacks for the array to use on each value in the array. A
 *      copy of the contents of the callbacks structure is made, so
 *      that a pointer to a structure on the stack can be passed in, or
 *      can be reused for multiple array creations. If the version
 *      field of this callbacks structure is not one of the defined
 *      ones for CFArray, the behavior is undefined. The retain field
 *      may be NULL, in which case the CFArray will do nothing to add a
 *      retain to the contained values for the array. The release field
 *      may be NULL, in which case the CFArray will do nothing to
 *      remove the arrays retain (if any) on the values when the array
 *      is destroyed. If the copyDescription field is NULL, the array
 *      will create a simple description for the value. If the equal
 *      field is NULL, the array will use pointer equality to test for
 *      equality of values. This callbacks parameter itself may be
 *      NULL, which is treated as if a valid structure of version 0
 *      with all fields NULL had been passed in. Otherwise, if any of
 *      the fields are not valid pointers to functions of the correct
 *      type, or this parameter is not a valid pointer to a 
 *      CFArrayCallBacks callbacks structure, the behavior is
 *      undefined. If any of the values put into the array is not one
 *      understood by one of the callback functions the behavior when
 *      that callback function is used is undefined.
 *  
 *  Result:
 *    A reference to the new mutable CFArray.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex; {CONST}VAR callBacks: CFArrayCallBacks): CFMutableArrayRef; C;

{
 *  CFArrayCreateMutableCopy()
 *  
 *  Discussion:
 *    Creates a new mutable array with the values from the given array.
 *  
 *  Parameters:
 *    
 *    allocator:
 *      The CFAllocator which should be used to allocate memory for the
 *      array and its storage for values. This parameter may be NULL in
 *      which case the current default CFAllocator is used. If this
 *      reference is not a valid CFAllocator, the behavior is undefined.
 *    
 *    capacity:
 *      The maximum number of values that can be contained by the
 *      CFArray. The array starts empty, and can grow to this number of
 *      values (and it can have less). If this parameter is 0, the
 *      array's maximum capacity is unlimited (or rather, only limited
 *      by address space and available memory constraints). This
 *      parameter must be greater than or equal to the count of the
 *      array which is to be copied, or the behavior is undefined. If
 *      this parameter is negative, the behavior is undefined.
 *    
 *    theArray:
 *      The array which is to be copied. The values from the array are
 *      copied as pointers into the new array (that is, the values
 *      themselves are copied, not that which the values point to, if
 *      anything). However, the values are also retained by the new
 *      array. The count of the new array will be the same as the given
 *      array. The new array uses the same callbacks as the array to be
 *      copied. If this parameter is not a valid CFArray, the behavior
 *      is undefined.
 *  
 *  Result:
 *    A reference to the new mutable CFArray.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; theArray: CFArrayRef): CFMutableArrayRef; C;

{
 *  CFArrayGetCount()
 *  
 *  Discussion:
 *    Returns the number of values currently in the array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to be queried. If this parameter is not a valid
 *      CFArray, the behavior is undefined.
 *  
 *  Result:
 *    The number of values in the array.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayGetCount(theArray: CFArrayRef): CFIndex; C;

{
 *  CFArrayGetCountOfValue()
 *  
 *  Discussion:
 *    Counts the number of times the given value occurs in the array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to be searched. If this parameter is not a valid
 *      CFArray, the behavior is undefined.
 *    
 *    range:
 *      The range within the array to search. If the range location or
 *      end point (defined by the location plus length minus 1) are
 *      outside the index space of the array (0 to N-1 inclusive, where
 *      N is the count of the array), the behavior is undefined. If the
 *      range length is negative, the behavior is undefined. The range
 *      may be empty (length 0).
 *    
 *    value:
 *      The value for which to find matches in the array. The equal()
 *      callback provided when the array was created is used to
 *      compare. If the equal() callback was NULL, pointer equality (in
 *      C, ==) is used. If value, or any of the values in the array,
 *      are not understood by the equal() callback, the behavior is
 *      undefined.
 *  
 *  Result:
 *    The number of times the given value occurs in the array, within
 *    the specified range.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayGetCountOfValue(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr): CFIndex; C;

{
 *  CFArrayContainsValue()
 *  
 *  Discussion:
 *    Reports whether or not the value is in the array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to be searched. If this parameter is not a valid
 *      CFArray, the behavior is undefined.
 *    
 *    range:
 *      The range within the array to search. If the range location or
 *      end point (defined by the location plus length minus 1) are
 *      outside the index space of the array (0 to N-1 inclusive, where
 *      N is the count of the array), the behavior is undefined. If the
 *      range length is negative, the behavior is undefined. The range
 *      may be empty (length 0).
 *    
 *    value:
 *      The value for which to find matches in the array. The equal()
 *      callback provided when the array was created is used to
 *      compare. If the equal() callback was NULL, pointer equality (in
 *      C, ==) is used. If value, or any of the values in the array,
 *      are not understood by the equal() callback, the behavior is
 *      undefined.
 *  
 *  Result:
 *    TRUE, if the value is in the specified range of the array,
 *    otherwise FALSE.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayContainsValue(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr): BOOLEAN; C;

{
 *  CFArrayGetValueAtIndex()
 *  
 *  Discussion:
 *    Retrieves the value at the given index.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to be queried. If this parameter is not a valid
 *      CFArray, the behavior is undefined.
 *    
 *    idx:
 *      The index of the value to retrieve. If the index is outside the
 *      index space of the array (0 to N-1 inclusive, where N is the
 *      count of the array), the behavior is undefined.
 *  
 *  Result:
 *    The value with the given index in the array.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayGetValueAtIndex(theArray: CFArrayRef; idx: CFIndex): Ptr; C;

{
 *  CFArrayGetValues()
 *  
 *  Discussion:
 *    Fills the buffer with values from the array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to be queried. If this parameter is not a valid
 *      CFArray, the behavior is undefined.
 *    
 *    range:
 *      The range of values within the array to retrieve. If the range
 *      location or end point (defined by the location plus length
 *      minus 1) are outside the index space of the array (0 to N-1
 *      inclusive, where N is the count of the array), the behavior is
 *      undefined. If the range length is negative, the behavior is
 *      undefined. The range may be empty (length 0), in which case no
 *      values are put into the buffer.
 *    
 *    values:
 *      A C array of pointer-sized values to be filled with values from
 *      the array. The values in the C array are ordered in the same
 *      order in which they appear in the array. If this parameter is
 *      not a valid pointer to a C array of at least range.length
 *      pointers, the behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArrayGetValues(theArray: CFArrayRef; range: CFRange; VAR values: UNIV Ptr); C;

{
 *  CFArrayApplyFunction()
 *  
 *  Discussion:
 *    Calls a function once for each value in the array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to be operated upon. If this parameter is not a valid
 *      CFArray, the behavior is undefined.
 *    
 *    range:
 *      The range of values within the array to which to apply the
 *      function. If the range location or end point (defined by the
 *      location plus length minus 1) are outside the index space of
 *      the array (0 to N-1 inclusive, where N is the count of the
 *      array), the behavior is undefined. If the range length is
 *      negative, the behavior is undefined. The range may be empty
 *      (length 0).
 *    
 *    applier:
 *      The callback function to call once for each value in the given
 *      range in the array. If this parameter is not a pointer to a
 *      function of the correct prototype, the behavior is undefined.
 *      If there are values in the range which the applier function
 *      does not expect or cannot properly apply to, the behavior is
 *      undefined.
 *    
 *    context:
 *      A pointer-sized user-defined value, which is passed as the
 *      second parameter to the applier function, but is otherwise
 *      unused by this function. If the context is not what is expected
 *      by the applier function, the behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArrayApplyFunction(theArray: CFArrayRef; range: CFRange; applier: CFArrayApplierFunction; context: UNIV Ptr); C;

{
 *  CFArrayGetFirstIndexOfValue()
 *  
 *  Discussion:
 *    Searches the array for the value.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to be searched. If this parameter is not a valid
 *      CFArray, the behavior is undefined.
 *    
 *    range:
 *      The range within the array to search. If the range location or
 *      end point (defined by the location plus length minus 1) are
 *      outside the index space of the array (0 to N-1 inclusive, where
 *      N is the count of the array), the behavior is undefined. If the
 *      range length is negative, the behavior is undefined. The range
 *      may be empty (length 0). The search progresses from the
 *      smallest index defined by the range to the largest.
 *    
 *    value:
 *      The value for which to find a match in the array. The equal()
 *      callback provided when the array was created is used to
 *      compare. If the equal() callback was NULL, pointer equality (in
 *      C, ==) is used. If value, or any of the values in the array,
 *      are not understood by the equal() callback, the behavior is
 *      undefined.
 *  
 *  Result:
 *    The lowest index of the matching values in the range, or -1 if no
 *    value in the range matched.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayGetFirstIndexOfValue(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr): CFIndex; C;

{
 *  CFArrayGetLastIndexOfValue()
 *  
 *  Discussion:
 *    Searches the array for the value.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to be searched. If this parameter is not a valid
 *      CFArray, the behavior is undefined.
 *    
 *    range:
 *      The range within the array to search. If the range location or
 *      end point (defined by the location plus length minus 1) are
 *      outside the index space of the array (0 to N-1 inclusive, where
 *      N is the count of the array), the behavior is undefined. If the
 *      range length is negative, the behavior is undefined. The range
 *      may be empty (length 0). The search progresses from the largest
 *      index defined by the range to the smallest.
 *    
 *    value:
 *      The value for which to find a match in the array. The equal()
 *      callback provided when the array was created is used to
 *      compare. If the equal() callback was NULL, pointer equality (in
 *      C, ==) is used. If value, or any of the values in the array,
 *      are not understood by the equal() callback, the behavior is
 *      undefined.
 *  
 *  Result:
 *    The highest index of the matching values in the range, or -1 if
 *    no value in the range matched.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayGetLastIndexOfValue(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr): CFIndex; C;

{
 *  CFArrayBSearchValues()
 *  
 *  Discussion:
 *    Searches the array for the value using a binary search algorithm.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to be searched. If this parameter is not a valid
 *      CFArray, the behavior is undefined. If the array is not sorted
 *      from least to greatest according to the comparator function,
 *      the behavior is undefined.
 *    
 *    range:
 *      The range within the array to search. If the range location or
 *      end point (defined by the location plus length minus 1) are
 *      outside the index space of the array (0 to N-1 inclusive, where
 *      N is the count of the array), the behavior is undefined. If the
 *      range length is negative, the behavior is undefined. The range
 *      may be empty (length 0).
 *    
 *    value:
 *      The value for which to find a match in the array. If value, or
 *      any of the values in the array, are not understood by the
 *      comparator callback, the behavior is undefined.
 *    
 *    comparator:
 *      The function with the comparator function type signature which
 *      is used in the binary search operation to compare values in the
 *      array with the given value. If this parameter is not a pointer
 *      to a function of the correct prototype, the behavior is
 *      undefined. If there are values in the range which the
 *      comparator function does not expect or cannot properly compare,
 *      the behavior is undefined.
 *    
 *    context:
 *      A pointer-sized user-defined value, which is passed as the
 *      third parameter to the comparator function, but is otherwise
 *      unused by this function. If the context is not what is expected
 *      by the comparator function, the behavior is undefined.
 *  
 *  Result:
 *    The return value is either 1) the index of a value that matched,
 *    if the target value matches one or more in the range, 2) greater
 *    than or equal to the end point of the range, if the value is
 *    greater than all the values in the range, or 3) the index of the
 *    value greater than the target value, if the value lies between
 *    two of (or less than all of) the values in the range.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFArrayBSearchValues(theArray: CFArrayRef; range: CFRange; value: UNIV Ptr; comparator: CFComparatorFunction; context: UNIV Ptr): CFIndex; C;

{
 *  CFArrayAppendValue()
 *  
 *  Discussion:
 *    Adds the value to the array giving it the new largest index.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to which the value is to be added. If this parameter
 *      is not a valid mutable CFArray, the behavior is undefined. If
 *      the array is a fixed-capacity array and it is full before this
 *      operation, the behavior is undefined.
 *    
 *    value:
 *      The value to add to the array. The value is retained by the
 *      array using the retain callback provided when the array was
 *      created. If the value is not of the sort expected by the retain
 *      callback, the behavior is undefined. The value is assigned to
 *      the index one larger than the previous largest index, and the
 *      count of the array is increased by one.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArrayAppendValue(theArray: CFMutableArrayRef; value: UNIV Ptr); C;

{
 *  CFArrayInsertValueAtIndex()
 *  
 *  Discussion:
 *    Adds the value to the array giving it the given index.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to which the value is to be added. If this parameter
 *      is not a valid mutable CFArray, the behavior is undefined. If
 *      the array is a fixed-capacity array and it is full before this
 *      operation, the behavior is undefined.
 *    
 *    idx:
 *      The index to which to add the new value. If the index is
 *      outside the index space of the array (0 to N inclusive, where N
 *      is the count of the array before the operation), the behavior
 *      is undefined. If the index is the same as N, this function has
 *      the same effect as CFArrayAppendValue().
 *    
 *    value:
 *      The value to add to the array. The value is retained by the
 *      array using the retain callback provided when the array was
 *      created. If the value is not of the sort expected by the retain
 *      callback, the behavior is undefined. The value is assigned to
 *      the given index, and all values with equal and larger indices
 *      have their indexes increased by one.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArrayInsertValueAtIndex(theArray: CFMutableArrayRef; idx: CFIndex; value: UNIV Ptr); C;

{
 *  CFArraySetValueAtIndex()
 *  
 *  Discussion:
 *    Changes the value with the given index in the array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array in which the value is to be changed. If this
 *      parameter is not a valid mutable CFArray, the behavior is
 *      undefined. If the array is a fixed-capacity array and it is
 *      full before this operation and the index is the same as N, the
 *      behavior is undefined.
 *    
 *    idx:
 *      The index to which to set the new value. If the index is
 *      outside the index space of the array (0 to N inclusive, where N
 *      is the count of the array before the operation), the behavior
 *      is undefined. If the index is the same as N, this function has
 *      the same effect as CFArrayAppendValue().
 *    
 *    value:
 *      The value to set in the array. The value is retained by the
 *      array using the retain callback provided when the array was
 *      created, and the previous value with that index is released. If
 *      the value is not of the sort expected by the retain callback,
 *      the behavior is undefined. The indices of other values is not
 *      affected.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArraySetValueAtIndex(theArray: CFMutableArrayRef; idx: CFIndex; value: UNIV Ptr); C;

{
 *  CFArrayRemoveValueAtIndex()
 *  
 *  Discussion:
 *    Removes the value with the given index from the array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array from which the value is to be removed. If this
 *      parameter is not a valid mutable CFArray, the behavior is
 *      undefined.
 *    
 *    idx:
 *      The index from which to remove the value. If the index is
 *      outside the index space of the array (0 to N-1 inclusive, where
 *      N is the count of the array before the operation), the behavior
 *      is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArrayRemoveValueAtIndex(theArray: CFMutableArrayRef; idx: CFIndex); C;

{
 *  CFArrayRemoveAllValues()
 *  
 *  Discussion:
 *    Removes all the values from the array, making it empty.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array from which all of the values are to be removed. If
 *      this parameter is not a valid mutable CFArray, the behavior is
 *      undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArrayRemoveAllValues(theArray: CFMutableArrayRef); C;

{
 *  CFArrayReplaceValues()
 *  
 *  Discussion:
 *    Replaces a range of values in the array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array from which all of the values are to be removed. If
 *      this parameter is not a valid mutable CFArray, the behavior is
 *      undefined.
 *    
 *    range:
 *      The range of values within the array to replace. If the range
 *      location or end point (defined by the location plus length
 *      minus 1) are outside the index space of the array (0 to N
 *      inclusive, where N is the count of the array), the behavior is
 *      undefined. If the range length is negative, the behavior is
 *      undefined. The range may be empty (length 0), in which case the
 *      new values are merely inserted at the range location.
 *    
 *    newValues:
 *      A C array of the pointer-sized values to be placed into the
 *      array. The new values in the array are ordered in the same
 *      order in which they appear in this C array. This parameter may
 *      be NULL if the newCount parameter is 0. This C array is not
 *      changed or freed by this function. If this parameter is not a
 *      valid pointer to a C array of at least newCount pointers, the
 *      behavior is undefined.
 *    
 *    newCount:
 *      The number of values to copy from the values C array into the
 *      CFArray. If this parameter is different than the range length,
 *      the excess newCount values will be inserted after the range, or
 *      the excess range values will be deleted. This parameter may be
 *      0, in which case no new values are replaced into the array and
 *      the values in the range are simply removed. If this parameter
 *      is negative, or greater than the number of values actually in
 *      the newValues C array, the behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArrayReplaceValues(theArray: CFMutableArrayRef; range: CFRange; VAR newValues: UNIV Ptr; newCount: CFIndex); C;

{
 *  CFArrayExchangeValuesAtIndices()
 *  
 *  Discussion:
 *    Exchanges the values at two indices of the array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array of which the values are to be swapped. If this
 *      parameter is not a valid mutable CFArray, the behavior is
 *      undefined.
 *    
 *    idx1:
 *      The first index whose values should be swapped. If the index is
 *      outside the index space of the array (0 to N-1 inclusive, where
 *      N is the count of the array before the operation), the behavior
 *      is undefined.
 *    
 *    idx2:
 *      The second index whose values should be swapped. If the index
 *      is outside the index space of the array (0 to N-1 inclusive,
 *      where N is the count of the array before the operation), the
 *      behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArrayExchangeValuesAtIndices(theArray: CFMutableArrayRef; idx1: CFIndex; idx2: CFIndex); C;

{
 *  CFArraySortValues()
 *  
 *  Discussion:
 *    Sorts the values in the array using the given comparison function.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array whose values are to be sorted. If this parameter is
 *      not a valid mutable CFArray, the behavior is undefined.
 *    
 *    range:
 *      The range of values within the array to sort. If the range
 *      location or end point (defined by the location plus length
 *      minus 1) are outside the index space of the array (0 to N-1
 *      inclusive, where N is the count of the array), the behavior is
 *      undefined. If the range length is negative, the behavior is
 *      undefined. The range may be empty (length 0).
 *    
 *    comparator:
 *      The function with the comparator function type signature which
 *      is used in the sort operation to compare values in the array
 *      with the given value. If this parameter is not a pointer to a
 *      function of the correct prototype, the the behavior is
 *      undefined. If there are values in the array which the
 *      comparator function does not expect or cannot properly compare,
 *      the behavior is undefined. The values in the range are sorted
 *      from least to greatest according to this function.
 *    
 *    context:
 *      A pointer-sized user-defined value, which is passed as the
 *      third parameter to the comparator function, but is otherwise
 *      unused by this function. If the context is not what is expected
 *      by the comparator function, the behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArraySortValues(theArray: CFMutableArrayRef; range: CFRange; comparator: CFComparatorFunction; context: UNIV Ptr); C;

{
 *  CFArrayAppendArray()
 *  
 *  Discussion:
 *    Adds the values from an array to another array.
 *  
 *  Parameters:
 *    
 *    theArray:
 *      The array to which values from the otherArray are to be added.
 *      If this parameter is not a valid mutable CFArray, the behavior
 *      is undefined. If the array is a fixed-capacity array and adding
 *      range.length values from the otherArray exceeds the capacity of
 *      the array, the behavior is undefined.
 *    
 *    otherArray:
 *      The array providing the values to be added to the array. If
 *      this parameter is not a valid CFArray, the behavior is
 *      undefined.
 *    
 *    otherRange:
 *      The range within the otherArray from which to add the values to
 *      the array. If the range location or end point (defined by the
 *      location plus length minus 1) are outside the index space of
 *      the otherArray (0 to N-1 inclusive, where N is the count of the
 *      otherArray), the behavior is undefined. The new values are
 *      retained by the array using the retain callback provided when
 *      the array was created. If the values are not of the sort
 *      expected by the retain callback, the behavior is undefined. The
 *      values are assigned to the indices one larger than the previous
 *      largest index in the array, and beyond, and the count of the
 *      array is increased by range.length. The values are assigned new
 *      indices in the array from smallest to largest index in the
 *      order in which they appear in the otherArray.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFArrayAppendArray(theArray: CFMutableArrayRef; otherArray: CFArrayRef; otherRange: CFRange); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFArrayIncludes}

{$ENDC} {__CFARRAY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
