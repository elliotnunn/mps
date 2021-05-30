{
     File:       CFDictionary.p
 
     Contains:   CoreFoundation dictionary collection
 
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
 UNIT CFDictionary;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFDICTIONARY__}
{$SETC __CFDICTIONARY__ := 1}

{$I+}
{$SETC CFDictionaryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{
 *  CFDictionary
 *  
 *  Discussion:
 *    CFDictionary implements a container which pairs pointer-sized
 *    keys with pointer-sized values. Values are accessed via arbitrary
 *    user-defined keys. A CFDictionary differs from a CFArray in that
 *    the key used to access a particular value in the dictionary
 *    remains the same as values are added to or removed from the
 *    dictionary, unless a value associated with its particular key is
 *    replaced or removed. In a CFArray, the key (or index) used to
 *    retrieve a particular value can change over time as values are
 *    added to or deleted from the array. Also unlike an array, there
 *    is no ordering among values in a dictionary. To enable later
 *    retrieval of a value, the key of the key-value pair should be
 *    constant (or treated as constant); if the key changes after being
 *    used to put a value in the dictionary, the value may not be
 *    retrievable. The keys of a dictionary form a set; that is, no two
 *    keys which are equal to one another are present in the dictionary
 *    at any time. 
 *    
 *    Dictionaries come in two flavors, immutable, which cannot have
 *    values added to them or removed from them after the dictionary is
 *    created, and mutable, to which you can add values or from which
 *    remove values. Mutable dictionaries have two subflavors,
 *    fixed-capacity, for which there is a maximum number set at
 *    creation time of values which can be put into the dictionary, and
 *    variable capacity, which can have an unlimited number of values
 *    (or rather, limited only by constraints external to CFDictionary,
 *    like the amount of available memory). Fixed-capacity dictionaries
 *    can be somewhat higher performing, if you can put a definate
 *    upper limit on the number of values that might be put into the
 *    dictionary. 
 *    
 *    As with all CoreFoundation collection types, dictionaries
 *    maintain hard references on the values you put in them, but the
 *    retaining and releasing functions are user-defined callbacks that
 *    can actually do whatever the user wants (for example, nothing).
 *    
 *    
 *    Although a particular implementation of CFDictionary may not use
 *    hashing and a hash table for storage of the values, the keys have
 *    a hash-code generating function defined for them, and a function
 *    to test for equality of two keys. These two functions together
 *    must maintain the invariant that if equal(X, Y), then hash(X) ==
 *    hash(Y). Note that the converse will not generally be true (but
 *    the contrapositive, if hash(X) != hash(Y), then !equal(X, Y),
 *    will be as required by Boolean logic). If the hash() and equal()
 *    key callbacks are NULL, the key is used as a pointer-sized
 *    integer, and pointer equality is used. Care should be taken to
 *    provide a hash() callback which will compute sufficiently
 *    dispersed hash codes for the key set for best performance.
 *    
 *    
 *    Computational Complexity The access time for a value in the
 *    dictionary is guaranteed to be at worst O(lg N) for any
 *    implementation, current and future, but will often be O(1)
 *    (constant time). Insertion or deletion operations will typically
 *    be constant time as well, but are O(N*lg N) in the worst case in
 *    some implementations. Access of values through a key is faster
 *    than accessing values directly (if there are any such
 *    operations). Dictionaries will tend to use significantly more
 *    memory than a array with the same number of values.
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryRetainCallBack = FUNCTION(allocator: CFAllocatorRef; value: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFDictionaryRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryReleaseCallBack = PROCEDURE(allocator: CFAllocatorRef; value: UNIV Ptr); C;
{$ELSEC}
	CFDictionaryReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryCopyDescriptionCallBack = FUNCTION(value: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFDictionaryCopyDescriptionCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryEqualCallBack = FUNCTION(value1: UNIV Ptr; value2: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFDictionaryEqualCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryHashCallBack = FUNCTION(value: UNIV Ptr): CFHashCode; C;
{$ELSEC}
	CFDictionaryHashCallBack = ProcPtr;
{$ENDC}


	{
	 *  CFDictionaryKeyCallBacks
	 *  
	 *  Discussion:
	 *    Structure containing the callbacks for keys of a CFDictionary.
	 	}
	CFDictionaryKeyCallBacksPtr = ^CFDictionaryKeyCallBacks;
	CFDictionaryKeyCallBacks = RECORD
		version:				CFIndex;
		retain:					CFDictionaryRetainCallBack;
		release:				CFDictionaryReleaseCallBack;
		copyDescription:		CFDictionaryCopyDescriptionCallBack;
		equal:					CFDictionaryEqualCallBack;
		hash:					CFDictionaryHashCallBack;
	END;

	{
	 *  kCFTypeDictionaryKeyCallBacks
	 *  
	 *  Discussion:
	 *    Predefined CFDictionaryKeyCallBacks structure containing a set of
	 *    callbacks appropriate for use when the keys of a CFDictionary are
	 *    all CFTypes.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFCopyStringDictionaryKeyCallBacks
	 *  
	 *  Discussion:
	 *    Predefined CFDictionaryKeyCallBacks structure containing a set of
	 *    callbacks appropriate for use when the keys of a CFDictionary are
	 *    all CFStrings, which may be mutable and need to be copied in
	 *    order to serve as constant keys for the values in the dictionary.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}

	{
	 *  CFDictionaryValueCallBacks
	 *  
	 *  Discussion:
	 *    Structure containing the callbacks for values of a CFDictionary.
	 	}
	CFDictionaryValueCallBacksPtr = ^CFDictionaryValueCallBacks;
	CFDictionaryValueCallBacks = RECORD
		version:				CFIndex;
		retain:					CFDictionaryRetainCallBack;
		release:				CFDictionaryReleaseCallBack;
		copyDescription:		CFDictionaryCopyDescriptionCallBack;
		equal:					CFDictionaryEqualCallBack;
	END;

	{
	 *  kCFTypeDictionaryValueCallBacks
	 *  
	 *  Discussion:
	 *    Predefined CFDictionaryValueCallBacks structure containing a set
	 *    of callbacks appropriate for use when the values in a
	 *    CFDictionary are all CFTypes.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}

	{
	 *  CFDictionaryApplierFunction
	 *  
	 *  Discussion:
	 *    Type of the callback function used by the apply functions of
	 *    CFDictionarys.
	 *  
	 *  Parameters:
	 *    
	 *    key:
	 *      The current key for the value.
	 *    
	 *    val:
	 *      The current value from the dictionary.
	 *    
	 *    context:
	 *      The user-defined context parameter given to the apply function.
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	CFDictionaryApplierFunction = PROCEDURE(key: UNIV Ptr; value: UNIV Ptr; context: UNIV Ptr); C;
{$ELSEC}
	CFDictionaryApplierFunction = ProcPtr;
{$ENDC}


	{
	 *  CFDictionaryRef
	 *  
	 *  Discussion:
	 *    This is the type of a reference to immutable CFDictionarys.
	 	}
	CFDictionaryRef    = ^LONGINT; { an opaque 32-bit type }
	CFDictionaryRefPtr = ^CFDictionaryRef;  { when a VAR xx:CFDictionaryRef parameter can be nil, it is changed to xx: CFDictionaryRefPtr }

	{
	 *  CFMutableDictionaryRef
	 *  
	 *  Discussion:
	 *    This is the type of a reference to mutable CFDictionarys.
	 	}
	CFMutableDictionaryRef    = CFDictionaryRef;
	CFMutableDictionaryRefPtr = ^CFMutableDictionaryRef;  { when a VAR xx:CFMutableDictionaryRef parameter can be nil, it is changed to xx: CFMutableDictionaryRefPtr }
	{
	 *  CFDictionaryGetTypeID()
	 *  
	 *  Discussion:
	 *    Returns the type identifier of all CFDictionary instances.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFDictionaryGetTypeID: CFTypeID; C;

{
 *  CFDictionaryCreate()
 *  
 *  Discussion:
 *    Creates a new immutable dictionary with the given values.
 *  
 *  Parameters:
 *    
 *    allocator:
 *      The CFAllocator which should be used to allocate memory for the
 *      dictionary and its storage for values. This parameter may be
 *      NULL in which case the current default CFAllocator is used. If
 *      this reference is not a valid CFAllocator, the behavior is
 *      undefined.
 *    
 *    keys:
 *      A C array of the pointer-sized keys to be used for the parallel
 *      C array of values to be put into the dictionary. This parameter
 *      may be NULL if the numValues parameter is 0. This C array is
 *      not changed or freed by this function. If this parameter is not
 *      a valid pointer to a C array of at least numValues pointers,
 *      the behavior is undefined.
 *    
 *    values:
 *      A C array of the pointer-sized values to be in the dictionary.
 *      This parameter may be NULL if the numValues parameter is 0.
 *      This C array is not changed or freed by this function. If this
 *      parameter is not a valid pointer to a C array of at least
 *      numValues pointers, the behavior is undefined.
 *    
 *    numValues:
 *      The number of values to copy from the keys and values C arrays
 *      into the CFDictionary. This number will be the count of the
 *      dictionary. If this parameter is negative, or greater than the
 *      number of values actually in the keys or values C arrays, the
 *      behavior is undefined.
 *    
 *    keyCallBacks:
 *      A pointer to a CFDictionaryKeyCallBacks structure initialized
 *      with the callbacks for the dictionary to use on each key in the
 *      dictionary. The retain callback will be used within this
 *      function, for example, to retain all of the new keys from the
 *      keys C array. A copy of the contents of the callbacks structure
 *      is made, so that a pointer to a structure on the stack can be
 *      passed in, or can be reused for multiple dictionary creations.
 *      If the version field of this callbacks structure is not one of
 *      the defined ones for CFDictionary, the behavior is undefined.
 *      The retain field may be NULL, in which case the CFDictionary
 *      will do nothing to add a retain to the keys of the contained
 *      values. The release field may be NULL, in which case the
 *      CFDictionary will do nothing to remove the dictionary's retain
 *      (if any) on the keys when the dictionary is destroyed or a
 *      key-value pair is removed. If the copyDescription field is
 *      NULL, the dictionary will create a simple description for a
 *      key. If the equal field is NULL, the dictionary will use
 *      pointer equality to test for equality of keys. If the hash
 *      field is NULL, a key will be converted from a pointer to an
 *      integer to compute the hash code. This callbacks parameter
 *      itself may be NULL, which is treated as if a valid structure of
 *      version 0 with all fields NULL had been passed in. Otherwise,
 *      if any of the fields are not valid pointers to functions of the
 *      correct type, or this parameter is not a valid pointer to a
 *      CFDictionaryKeyCallBacks callbacks structure, the behavior is
 *      undefined. If any of the keys put into the dictionary is not
 *      one understood by one of the callback functions the behavior
 *      when that callback function is used is undefined.
 *    
 *    valueCallBacks:
 *      A pointer to a CFDictionaryValueCallBacks structure initialized
 *      with the callbacks for the dictionary to use on each value in
 *      the dictionary. The retain callback will be used within this
 *      function, for example, to retain all of the new values from the
 *      values C array. A copy of the contents of the callbacks
 *      structure is made, so that a pointer to a structure on the
 *      stack can be passed in, or can be reused for multiple
 *      dictionary creations. If the version field of this callbacks
 *      structure is not one of the defined ones for CFDictionary, the
 *      behavior is undefined. The retain field may be NULL, in which
 *      case the CFDictionary will do nothing to add a retain to values
 *      as they are put into the dictionary. The release field may be
 *      NULL, in which case the CFDictionary will do nothing to remove
 *      the dictionary's retain (if any) on the values when the
 *      dictionary is destroyed or a key-value pair is removed. If the
 *      copyDescription field is NULL, the dictionary will create a
 *      simple description for a value. If the equal field is NULL, the
 *      dictionary will use pointer equality to test for equality of
 *      values. This callbacks parameter itself may be NULL, which is
 *      treated as if a valid structure of version 0 with all fields
 *      NULL had been passed in. Otherwise, if any of the fields are
 *      not valid pointers to functions of the correct type, or this
 *      parameter is not a valid pointer to a
 *      CFDictionaryValueCallBacks callbacks structure, the behavior is
 *      undefined. If any of the values put into the dictionary is not
 *      one understood by one of the callback functions the behavior
 *      when that callback function is used is undefined.
 *  
 *  Result:
 *    A reference to the new immutable CFDictionary.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryCreate(allocator: CFAllocatorRef; VAR keys: UNIV Ptr; VAR values: UNIV Ptr; numValues: CFIndex; {CONST}VAR keyCallBacks: CFDictionaryKeyCallBacks; {CONST}VAR valueCallBacks: CFDictionaryValueCallBacks): CFDictionaryRef; C;

{
 *  CFDictionaryCreateCopy()
 *  
 *  Discussion:
 *    Creates a new immutable dictionary with the key-value pairs from
 *    the given dictionary.
 *  
 *  Parameters:
 *    
 *    allocator:
 *      The CFAllocator which should be used to allocate memory for the
 *      dictionary and its storage for values. This parameter may be
 *      NULL in which case the current default CFAllocator is used. If
 *      this reference is not a valid CFAllocator, the behavior is
 *      undefined.
 *    
 *    theDict:
 *      The dictionary which is to be copied. The keys and values from
 *      the dictionary are copied as pointers into the new dictionary
 *      (that is, the values themselves are copied, not that which the
 *      values point to, if anything). However, the keys and values are
 *      also retained by the new dictionary using the retain function
 *      of the original dictionary. The count of the new dictionary
 *      will be the same as the given dictionary. The new dictionary
 *      uses the same callbacks as the dictionary to be copied. If this
 *      parameter is not a valid CFDictionary, the behavior is
 *      undefined.
 *  
 *  Result:
 *    A reference to the new immutable CFDictionary.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryCreateCopy(allocator: CFAllocatorRef; theDict: CFDictionaryRef): CFDictionaryRef; C;

{
 *  CFDictionaryCreateMutable()
 *  
 *  Discussion:
 *    Creates a new mutable dictionary.
 *  
 *  Parameters:
 *    
 *    allocator:
 *      The CFAllocator which should be used to allocate memory for the
 *      dictionary and its storage for values. This parameter may be
 *      NULL in which case the current default CFAllocator is used. If
 *      this reference is not a valid CFAllocator, the behavior is
 *      undefined.
 *    
 *    capacity:
 *      The maximum number of values that can be contained by the
 *      CFDictionary. The dictionary starts empty, and can grow to this
 *      number of values (and it can have less). If this parameter is
 *      0, the dictionary's maximum capacity is unlimited (or rather,
 *      only limited by address space and available memory
 *      constraints). If this parameter is negative, the behavior is
 *      undefined.
 *    
 *    keyCallBacks:
 *      A pointer to a CFDictionaryKeyCallBacks structure initialized
 *      with the callbacks for the dictionary to use on each key in the
 *      dictionary. A copy of the contents of the callbacks structure
 *      is made, so that a pointer to a structure on the stack can be
 *      passed in, or can be reused for multiple dictionary creations.
 *      If the version field of this callbacks structure is not one of
 *      the defined ones for CFDictionary, the behavior is undefined.
 *      The retain field may be NULL, in which case the CFDictionary
 *      will do nothing to add a retain to the keys of the contained
 *      values. The release field may be NULL, in which case the
 *      CFDictionary will do nothing to remove the dictionary's retain
 *      (if any) on the keys when the dictionary is destroyed or a
 *      key-value pair is removed. If the copyDescription field is
 *      NULL, the dictionary will create a simple description for a
 *      key. If the equal field is NULL, the dictionary will use
 *      pointer equality to test for equality of keys. If the hash
 *      field is NULL, a key will be converted from a pointer to an
 *      integer to compute the hash code. This callbacks parameter
 *      itself may be NULL, which is treated as if a valid structure of
 *      version 0 with all fields NULL had been passed in. Otherwise,
 *      if any of the fields are not valid pointers to functions of the
 *      correct type, or this parameter is not a valid pointer to a
 *      CFDictionaryKeyCallBacks callbacks structure, the behavior is
 *      undefined. If any of the keys put into the dictionary is not
 *      one understood by one of the callback functions the behavior
 *      when that callback function is used is undefined.
 *    
 *    valueCallBacks:
 *      A pointer to a CFDictionaryValueCallBacks structure initialized
 *      with the callbacks for the dictionary to use on each value in
 *      the dictionary. The retain callback will be used within this
 *      function, for example, to retain all of the new values from the
 *      values C array. A copy of the contents of the callbacks
 *      structure is made, so that a pointer to a structure on the
 *      stack can be passed in, or can be reused for multiple
 *      dictionary creations. If the version field of this callbacks
 *      structure is not one of the defined ones for CFDictionary, the
 *      behavior is undefined. The retain field may be NULL, in which
 *      case the CFDictionary will do nothing to add a retain to values
 *      as they are put into the dictionary. The release field may be
 *      NULL, in which case the CFDictionary will do nothing to remove
 *      the dictionary's retain (if any) on the values when the
 *      dictionary is destroyed or a key-value pair is removed. If the
 *      copyDescription field is NULL, the dictionary will create a
 *      simple description for a value. If the equal field is NULL, the
 *      dictionary will use pointer equality to test for equality of
 *      values. This callbacks parameter itself may be NULL, which is
 *      treated as if a valid structure of version 0 with all fields
 *      NULL had been passed in. Otherwise, if any of the fields are
 *      not valid pointers to functions of the correct type, or this
 *      parameter is not a valid pointer to a
 *      CFDictionaryValueCallBacks callbacks structure, the behavior is
 *      undefined. If any of the values put into the dictionary is not
 *      one understood by one of the callback functions the behavior
 *      when that callback function is used is undefined.
 *  
 *  Result:
 *    A reference to the new mutable CFDictionary.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryCreateMutable(allocator: CFAllocatorRef; capacity: CFIndex; {CONST}VAR keyCallBacks: CFDictionaryKeyCallBacks; {CONST}VAR valueCallBacks: CFDictionaryValueCallBacks): CFMutableDictionaryRef; C;

{
 *  CFDictionaryCreateMutableCopy()
 *  
 *  Discussion:
 *    Creates a new mutable dictionary with the key-value pairs from
 *    the given dictionary.
 *  
 *  Parameters:
 *    
 *    allocator:
 *      The CFAllocator which should be used to allocate memory for the
 *      dictionary and its storage for values. This parameter may be
 *      NULL in which case the current default CFAllocator is used. If
 *      this reference is not a valid CFAllocator, the behavior is
 *      undefined.
 *    
 *    capacity:
 *      The maximum number of values that can be contained by the
 *      CFDictionary. The dictionary starts empty, and can grow to this
 *      number of values (and it can have less). If this parameter is
 *      0, the dictionary's maximum capacity is unlimited (or rather,
 *      only limited by address space and available memory
 *      constraints). This parameter must be greater than or equal to
 *      the count of the dictionary which is to be copied, or the
 *      behavior is undefined. If this parameter is negative, the
 *      behavior is undefined.
 *    
 *    theDict:
 *      The dictionary which is to be copied. The keys and values from
 *      the dictionary are copied as pointers into the new dictionary
 *      (that is, the values themselves are copied, not that which the
 *      values point to, if anything). However, the keys and values are
 *      also retained by the new dictionary using the retain function
 *      of the original dictionary. The count of the new dictionary
 *      will be the same as the given dictionary. The new dictionary
 *      uses the same callbacks as the dictionary to be copied. If this
 *      parameter is not a valid CFDictionary, the behavior is
 *      undefined.
 *  
 *  Result:
 *    A reference to the new mutable CFDictionary.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryCreateMutableCopy(allocator: CFAllocatorRef; capacity: CFIndex; theDict: CFDictionaryRef): CFMutableDictionaryRef; C;

{
 *  CFDictionaryGetCount()
 *  
 *  Discussion:
 *    Returns the number of values currently in the dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to be queried. If this parameter is not a valid
 *      CFDictionary, the behavior is undefined.
 *  
 *  Result:
 *    The number of values in the dictionary.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryGetCount(theDict: CFDictionaryRef): CFIndex; C;

{
 *  CFDictionaryGetCountOfKey()
 *  
 *  Discussion:
 *    Counts the number of times the given key occurs in the dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to be searched. If this parameter is not a valid
 *      CFDictionary, the behavior is undefined.
 *    
 *    key:
 *      The key for which to find matches in the dictionary. The hash()
 *      and equal() key callbacks provided when the dictionary was
 *      created are used to compare. If the hash() key callback was
 *      NULL, the key is treated as a pointer and converted to an
 *      integer. If the equal() key callback was NULL, pointer equality
 *      (in C, ==) is used. If key, or any of the keys in the
 *      dictionary, are not understood by the equal() callback, the
 *      behavior is undefined.
 *  
 *  Result:
 *    Returns 1 if a matching key is used by the dictionary, 0
 *    otherwise.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryGetCountOfKey(theDict: CFDictionaryRef; key: UNIV Ptr): CFIndex; C;

{
 *  CFDictionaryGetCountOfValue()
 *  
 *  Discussion:
 *    Counts the number of times the given value occurs in the
 *    dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to be searched. If this parameter is not a valid
 *      CFDictionary, the behavior is undefined.
 *    
 *    value:
 *      The value for which to find matches in the dictionary. The
 *      equal() callback provided when the dictionary was created is
 *      used to compare. If the equal() value callback was NULL,
 *      pointer equality (in C, ==) is used. If value, or any of the
 *      values in the dictionary, are not understood by the equal()
 *      callback, the behavior is undefined.
 *  
 *  Result:
 *    The number of times the given value occurs in the dictionary.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryGetCountOfValue(theDict: CFDictionaryRef; value: UNIV Ptr): CFIndex; C;

{
 *  CFDictionaryContainsKey()
 *  
 *  Discussion:
 *    Reports whether or not the key is in the dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to be searched. If this parameter is not a valid
 *      CFDictionary, the behavior is undefined.
 *    
 *    key:
 *      The key for which to find matches in the dictionary. The hash()
 *      and equal() key callbacks provided when the dictionary was
 *      created are used to compare. If the hash() key callback was
 *      NULL, the key is treated as a pointer and converted to an
 *      integer. If the equal() key callback was NULL, pointer equality
 *      (in C, ==) is used. If key, or any of the keys in the
 *      dictionary, are not understood by the equal() callback, the
 *      behavior is undefined.
 *  
 *  Result:
 *    TRUE, if the key is in the dictionary, otherwise FALSE.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryContainsKey(theDict: CFDictionaryRef; key: UNIV Ptr): BOOLEAN; C;

{
 *  CFDictionaryContainsValue()
 *  
 *  Discussion:
 *    Reports whether or not the value is in the dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to be searched. If this parameter is not a valid
 *      CFDictionary, the behavior is undefined.
 *    
 *    value:
 *      The value for which to find matches in the dictionary. The
 *      equal() callback provided when the dictionary was created is
 *      used to compare. If the equal() callback was NULL, pointer
 *      equality (in C, ==) is used. If value, or any of the values in
 *      the dictionary, are not understood by the equal() callback, the
 *      behavior is undefined.
 *  
 *  Result:
 *    TRUE, if the value is in the dictionary, otherwise FALSE.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryContainsValue(theDict: CFDictionaryRef; value: UNIV Ptr): BOOLEAN; C;

{
 *  CFDictionaryGetValue()
 *  
 *  Discussion:
 *    Retrieves the value associated with the given key.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to be queried. If this parameter is not a valid
 *      CFDictionary, the behavior is undefined.
 *    
 *    key:
 *      The key for which to find a match in the dictionary. The hash()
 *      and equal() key callbacks provided when the dictionary was
 *      created are used to compare. If the hash() key callback was
 *      NULL, the key is treated as a pointer and converted to an
 *      integer. If the equal() key callback was NULL, pointer equality
 *      (in C, ==) is used. If key, or any of the keys in the
 *      dictionary, are not understood by the equal() callback, the
 *      behavior is undefined.
 *  
 *  Result:
 *    The value with the given key in the dictionary, or NULL if no
 *    key-value pair with a matching key exists. Since NULL can be a
 *    valid value in some dictionaries, the function
 *    CFDictionaryGetValueIfPresent() must be used to distinguish
 *    NULL-no-found from NULL-is-the-value.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryGetValue(theDict: CFDictionaryRef; key: UNIV Ptr): Ptr; C;

{
 *  CFDictionaryGetValueIfPresent()
 *  
 *  Discussion:
 *    Retrieves the value associated with the given key.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to be queried. If this parameter is not a valid
 *      CFDictionary, the behavior is undefined.
 *    
 *    key:
 *      The key for which to find a match in the dictionary. The hash()
 *      and equal() key callbacks provided when the dictionary was
 *      created are used to compare. If the hash() key callback was
 *      NULL, the key is treated as a pointer and converted to an
 *      integer. If the equal() key callback was NULL, pointer equality
 *      (in C, ==) is used. If key, or any of the keys in the
 *      dictionary, are not understood by the equal() callback, the
 *      behavior is undefined.
 *    
 *    value:
 *      A pointer to memory which should be filled with the
 *      pointer-sized value if a matching key is found. If no key match
 *      is found, the contents of the storage pointed to by this
 *      parameter are undefined. This parameter may be NULL, in which
 *      case the value from the dictionary is not returned (but the
 *      return value of this function still indicates whether or not
 *      the key-value pair was present).
 *  
 *  Result:
 *    TRUE, if a matching key was found, FALSE otherwise.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDictionaryGetValueIfPresent(theDict: CFDictionaryRef; key: UNIV Ptr; VAR value: UNIV Ptr): BOOLEAN; C;

{
 *  CFDictionaryGetKeysAndValues()
 *  
 *  Discussion:
 *    Fills the two buffers with the keys and values from the
 *    dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to be queried. If this parameter is not a valid
 *      CFDictionary, the behavior is undefined.
 *    
 *    keys:
 *      A C array of pointer-sized values to be filled with keys from
 *      the dictionary. The keys and values C arrays are parallel to
 *      each other (that is, the items at the same indices form a
 *      key-value pair from the dictionary). This parameter may be NULL
 *      if the keys are not desired. If this parameter is not a valid
 *      pointer to a C array of at least CFDictionaryGetCount()
 *      pointers, or NULL, the behavior is undefined.
 *    
 *    values:
 *      A C array of pointer-sized values to be filled with values from
 *      the dictionary. The keys and values C arrays are parallel to
 *      each other (that is, the items at the same indices form a
 *      key-value pair from the dictionary). This parameter may be NULL
 *      if the values are not desired. If this parameter is not a valid
 *      pointer to a C array of at least CFDictionaryGetCount()
 *      pointers, or NULL, the behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDictionaryGetKeysAndValues(theDict: CFDictionaryRef; VAR keys: UNIV Ptr; VAR values: UNIV Ptr); C;

{
 *  CFDictionaryApplyFunction()
 *  
 *  Discussion:
 *    Calls a function once for each value in the dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to be queried. If this parameter is not a valid
 *      CFDictionary, the behavior is undefined.
 *    
 *    applier:
 *      The callback function to call once for each value in the
 *      dictionary. If this parameter is not a pointer to a function of
 *      the correct prototype, the behavior is undefined. If there are
 *      keys or values which the applier function does not expect or
 *      cannot properly apply to, the behavior is undefined.
 *    
 *    context:
 *      A pointer-sized user-defined value, which is passed as the
 *      third parameter to the applier function, but is otherwise
 *      unused by this function. If the context is not what is expected
 *      by the applier function, the behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDictionaryApplyFunction(theDict: CFDictionaryRef; applier: CFDictionaryApplierFunction; context: UNIV Ptr); C;

{
 *  CFDictionaryAddValue()
 *  
 *  Discussion:
 *    Adds the key-value pair to the dictionary if no such key already
 *    exists.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to which the value is to be added. If this
 *      parameter is not a valid mutable CFDictionary, the behavior is
 *      undefined. If the dictionary is a fixed-capacity dictionary and
 *      it is full before this operation, the behavior is undefined.
 *    
 *    key:
 *      The key of the value to add to the dictionary. The key is
 *      retained by the dictionary using the retain callback provided
 *      when the dictionary was created. If the key is not of the sort
 *      expected by the retain callback, the behavior is undefined. If
 *      a key which matches this key is already present in the
 *      dictionary, this function does nothing ("add if absent").
 *    
 *    value:
 *      The value to add to the dictionary. The value is retained by
 *      the dictionary using the retain callback provided when the
 *      dictionary was created. If the value is not of the sort
 *      expected by the retain callback, the behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDictionaryAddValue(theDict: CFMutableDictionaryRef; key: UNIV Ptr; value: UNIV Ptr); C;

{
 *  CFDictionarySetValue()
 *  
 *  Discussion:
 *    Sets the value of the key in the dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to which the value is to be set. If this
 *      parameter is not a valid mutable CFDictionary, the behavior is
 *      undefined. If the dictionary is a fixed-capacity dictionary and
 *      it is full before this operation, and the key does not exist in
 *      the dictionary, the behavior is undefined.
 *    
 *    key:
 *      The key of the value to set into the dictionary. If a key which
 *      matches this key is already present in the dictionary, only the
 *      value is changed ("add if absent, replace if present"). If no
 *      key matches the given key, the key-value pair is added to the
 *      dictionary. If added, the key is retained by the dictionary,
 *      using the retain callback provided when the dictionary was
 *      created. If the key is not of the sort expected by the key
 *      retain callback, the behavior is undefined.
 *    
 *    value:
 *      The value to add to or replace into the dictionary. The value
 *      is retained by the dictionary using the retain callback
 *      provided when the dictionary was created, and the previous
 *      value if any is released. If the value is not of the sort
 *      expected by the retain or release callbacks, the behavior is
 *      undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDictionarySetValue(theDict: CFMutableDictionaryRef; key: UNIV Ptr; value: UNIV Ptr); C;

{
 *  CFDictionaryReplaceValue()
 *  
 *  Discussion:
 *    Replaces the value of the key in the dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary to which the value is to be replaced. If this
 *      parameter is not a valid mutable CFDictionary, the behavior is
 *      undefined.
 *    
 *    key:
 *      The key of the value to replace in the dictionary. If a key
 *      which matches this key is present in the dictionary, the value
 *      is changed to the given value, otherwise this function does
 *      nothing ("replace if present").
 *    
 *    value:
 *      The value to replace into the dictionary. The value is retained
 *      by the dictionary using the retain callback provided when the
 *      dictionary was created, and the previous value is released. If
 *      the value is not of the sort expected by the retain or release
 *      callbacks, the behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDictionaryReplaceValue(theDict: CFMutableDictionaryRef; key: UNIV Ptr; value: UNIV Ptr); C;

{
 *  CFDictionaryRemoveValue()
 *  
 *  Discussion:
 *    Removes the value of the key from the dictionary.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary from which the value is to be removed. If this
 *      parameter is not a valid mutable CFDictionary, the behavior is
 *      undefined.
 *    
 *    key:
 *      The key of the value to remove from the dictionary. If a key
 *      which matches this key is present in the dictionary, the
 *      key-value pair is removed from the dictionary, otherwise this
 *      function does nothing ("remove if present").
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDictionaryRemoveValue(theDict: CFMutableDictionaryRef; key: UNIV Ptr); C;

{
 *  CFDictionaryRemoveAllValues()
 *  
 *  Discussion:
 *    Removes all the values from the dictionary, making it empty.
 *  
 *  Parameters:
 *    
 *    theDict:
 *      The dictionary from which all of the values are to be removed.
 *      If this parameter is not a valid mutable CFDictionary, the
 *      behavior is undefined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFDictionaryRemoveAllValues(theDict: CFMutableDictionaryRef); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFDictionaryIncludes}

{$ENDC} {__CFDICTIONARY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
