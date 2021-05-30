{
     File:       NameRegistry.p
 
     Contains:   NameRegistry Interfaces
 
     Version:    Technology: MacOS
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT NameRegistry;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NAMEREGISTRY__}
{$SETC __NAMEREGISTRY__ := 1}

{$I+}
{$SETC NameRegistryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{******************************************************************************
 * 
 * Foundation Types
 *
 }
{ Value of a property }

TYPE
	RegPropertyValue					= Ptr;
	{	 Length of property value 	}
	RegPropertyValueSize				= UInt32;
	{	******************************************************************************
	 * 
	 * RegEntryID   :   The Global x-Namespace Entry Identifier
	 *
	 	}
	RegEntryIDPtr = ^RegEntryID;
	RegEntryID = RECORD
		contents:				ARRAY [0..3] OF UInt32;
	END;

	{	******************************************************************************
	 *
	 * Root Entry Name Definitions  (Applies to all Names in the RootNameSpace)
	 *
	 *  • Names are a colon-separated list of name components.  Name components
	 *    may not themselves contain colons.  
	 *  • Names are presented as null-terminated ASCII character strings.
	 *  • Names follow similar parsing rules to Apple file system absolute
	 *    and relative paths.  However the '::' parent directory syntax is
	 *    not currently supported.
	 	}
	{	 Max length of Entry Name 	}

CONST
	kRegCStrMaxEntryNameLength	= 47;

	{	 Entry Names are single byte ASCII 	}

TYPE
	RegCStrEntryName					= CHAR;
	RegCStrEntryNamePtr					= ^CHAR;
	{  length of RegCStrEntryNameBuf =  kRegCStrMaxEntryNameLength+1 }
	RegCStrEntryNameBuf					= PACKED ARRAY [0..47] OF CHAR;
	RegCStrPathName						= CHAR;
	RegPathNameSize						= UInt32;

CONST
	kRegPathNameSeparator		= 58;							{  0x3A  }
	kRegEntryNameTerminator		= $00;							{  '\0'  }
	kRegPathNameTerminator		= $00;							{  '\0'  }

	{	******************************************************************************
	 *
	 * Property Name and ID Definitions
	 *  (Applies to all Properties Regardless of NameSpace)
	 	}
	kRegMaximumPropertyNameLength = 31;							{  Max length of Property Name  }
	kRegPropertyNameTerminator	= $00;							{  '\0'  }


TYPE
	RegPropertyNameBuf					= PACKED ARRAY [0..31] OF CHAR;
	RegPropertyName						= CHAR;
	RegPropertyNamePtr					= ^CHAR;
	{	******************************************************************************
	 *
	 * Iteration Operations
	 *
	 *  These specify direction when traversing the name relationships
	 	}
	RegIterationOp						= UInt32;
	RegEntryIterationOp					= RegIterationOp;

CONST
																{  Absolute locations }
	kRegIterRoot				= $00000002;					{  "Upward" Relationships  }
	kRegIterParents				= $00000003;					{  include all  parent(s) of entry  }
																{  "Downward" Relationships }
	kRegIterChildren			= $00000004;					{  include all children  }
	kRegIterSubTrees			= $00000005;					{  include all sub trees of entry  }
	kRegIterDescendants			= $00000005;					{  include all descendants of entry  }
																{  "Horizontal" Relationships  }
	kRegIterSibling				= $00000006;					{  include all siblings  }
																{  Keep doing the same thing }
	kRegIterContinue			= $00000001;

	{	******************************************************************************
	 *
	 * Name Entry and Property Modifiers
	 *
	 *
	 *
	 * Modifiers describe special characteristics of names
	 * and properties.  Modifiers might be supported for
	 * some names and not others.
	 * 
	 * Device Drivers should not rely on functionality
	 * specified as a modifier.
	 	}

TYPE
	RegModifiers						= UInt32;
	RegEntryModifiers					= RegModifiers;
	RegPropertyModifiers				= RegModifiers;

CONST
	kRegNoModifiers				= $00000000;					{  no entry modifiers in place  }
	kRegUniversalModifierMask	= $0000FFFF;					{  mods to all entries  }
	kRegNameSpaceModifierMask	= $00FF0000;					{  mods to all entries within namespace  }
	kRegModifierMask			= $FF000000;					{  mods to just this entry  }

	{	 Universal Property Modifiers 	}
	kRegPropertyValueIsSavedToNVRAM = $00000020;				{  property is non-volatile (saved in NVRAM)  }
	kRegPropertyValueIsSavedToDisk = $00000040;					{  property is non-volatile (saved on disk)  }

	{	 NameRegistry version, Gestalt/PEF-style -- MUST BE KEPT IN SYNC WITH MAKEFILE !! 	}
	LatestNR_PEFVersion			= $01030000;					{  latest NameRegistryLib version (Gestalt/PEF-style)  }

	{	 ///////////////////////
	//
	// The Registry API
	//
	/////////////////////// 	}
	{	 NameRegistry dispatch indexes 	}
	kSelectRegistryEntryIDInit	= 0;
	kSelectRegistryEntryIDCompare = 1;
	kSelectRegistryEntryIDCopy	= 2;
	kSelectRegistryEntryIDDispose = 3;
	kSelectRegistryCStrEntryCreate = 4;
	kSelectRegistryEntryDelete	= 5;
	kSelectRegistryEntryCopy	= 6;
	kSelectRegistryEntryIterateCreate = 7;
	kSelectRegistryEntryIterateDispose = 8;
	kSelectRegistryEntryIterateSet = 9;
	kSelectRegistryEntryIterate	= 10;
	kSelectRegistryEntrySearch	= 11;
	kSelectRegistryCStrEntryLookup = 12;
	kSelectRegistryEntryToPathSize = 13;
	kSelectRegistryCStrEntryToPath = 14;
	kSelectRegistryCStrEntryToName = 15;
	kSelectRegistryPropertyCreate = 16;
	kSelectRegistryPropertyDelete = 17;
	kSelectRegistryPropertyRename = 18;
	kSelectRegistryPropertyIterateCreate = 19;
	kSelectRegistryPropertyIterateDispose = 20;
	kSelectRegistryPropertyIterate = 21;
	kSelectRegistryPropertyGetSize = 22;
	kSelectRegistryPropertyGet	= 23;
	kSelectRegistryPropertySet	= 24;
	kSelectRegistryEntryGetMod	= 25;
	kSelectRegistryEntrySetMod	= 26;
	kSelectRegistryPropertyGetMod = 27;
	kSelectRegistryPropertySetMod = 28;
	kSelectRegistryEntryMod		= 29;
	kSelectRegistryEntryPropertyMod = 30;						{  if you add more selectors here, remember to change 'kSelectRegistryHighestSelector' below }
	kSelectRegistryHighestSelector = 30;


	{	 ///////////////////////
	//
	// Entry Management
	//
	/////////////////////// 	}

	{	-------------------------------
	 * EntryID handling
	 	}
	{	
	 * Initialize an EntryID to a known invalid state
	 *   note: invalid != uninitialized
	 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  RegistryEntryIDInit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION RegistryEntryIDInit(VAR id: RegEntryID): OSStatus; C;
{
 * Compare EntryID's for equality or if invalid
 *
 * If a NULL value is given for either id1 or id2, the other id 
 * is compared with an invalid ID.  If both are NULL, the id's 
 * are consided equal (result = true). 
 }
{
 *  RegistryEntryIDCompare()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryIDCompare({CONST}VAR id1: RegEntryID; {CONST}VAR id2: RegEntryID): BOOLEAN; C;
{
 * Copy an EntryID
 }
{
 *  RegistryEntryIDCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryIDCopy({CONST}VAR src: RegEntryID; VAR dst: RegEntryID): OSStatus; C;
{
 * Free an ID so it can be reused.
 }
{
 *  RegistryEntryIDDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryIDDispose(VAR id: RegEntryID): OSStatus; C;
{-------------------------------
 * Adding and removing entries
 *
 * If (parentEntry) is NULL, the name is assumed
 * to be a rooted path. It is rooted to an anonymous, unnamed root.
 }
{
 *  RegistryCStrEntryCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryCStrEntryCreate({CONST}VAR parentEntry: RegEntryID; {CONST}VAR name: RegCStrPathName; VAR newEntry: RegEntryID): OSStatus; C;
{
 *  RegistryEntryDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryDelete({CONST}VAR id: RegEntryID): OSStatus; C;
{
 *  RegistryEntryCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryCopy(VAR parentEntryID: RegEntryID; VAR sourceDevice: RegEntryID; VAR destDevice: RegEntryID): OSStatus; C;
{---------------------------
 * Traversing the namespace
 *
 * To support arbitrary namespace implementations in the future,
 * I have hidden the form that the place pointer takes.  The previous
 * interface exposed the place pointer by specifying it as a
 * RegEntryID.
 *
 * I have also removed any notion of returning the entries
 * in a particular order, because an implementation might
 * return the names in semi-random order.  Many name service
 * implementations will store the names in a hashed lookup
 * table.
 *
 * Writing code to traverse some set of names consists of
 * a call to begin the iteration, the iteration loop, and
 * a call to end the iteration.  The begin call initializes
 * the iteration cookie data structure.  The call to end the 
 * iteration should be called even in the case of error so 
 * that allocated data structures can be freed.
 *
 *  Create(...)
 *  do (
 *      Iterate(...);
 *  ) while (!done);
 *  Dispose(...);
 *
 * This is the basic code structure for callers of the iteration
 * interface.
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	RegEntryIter    = ^LONGINT; { an opaque 32-bit type }
	RegEntryIterPtr = ^RegEntryIter;  { when a VAR xx:RegEntryIter parameter can be nil, it is changed to xx: RegEntryIterPtr }
	{	 
	 * create/dispose the iterator structure
	 *   defaults to root with relationship = kRegIterDescendants
	 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  RegistryEntryIterateCreate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION RegistryEntryIterateCreate(VAR cookie: RegEntryIter): OSStatus; C;
{
 *  RegistryEntryIterateDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryIterateDispose(VAR cookie: RegEntryIter): OSStatus; C;
{ 
 * set Entry Iterator to specified entry
 }
{
 *  RegistryEntryIterateSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryIterateSet(VAR cookie: RegEntryIter; {CONST}VAR startEntryID: RegEntryID): OSStatus; C;
{
 * Return each value of the iteration
 *
 * return entries related to the current entry
 * with the specified relationship
 }
{
 *  RegistryEntryIterate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryIterate(VAR cookie: RegEntryIter; relationship: RegEntryIterationOp; VAR foundEntry: RegEntryID; VAR done: BOOLEAN): OSStatus; C;
{
 * return entries with the specified property
 *
 * A NULL RegPropertyValue pointer will return an
 * entry with the property containing any value.
 }
{
 *  RegistryEntrySearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntrySearch(VAR cookie: RegEntryIter; relationship: RegEntryIterationOp; VAR foundEntry: RegEntryID; VAR done: BOOLEAN; {CONST}VAR propertyName: RegPropertyName; propertyValue: UNIV Ptr; propertySize: RegPropertyValueSize): OSStatus; C;
{--------------------------------
 * Find a name in the namespace
 *
 * This is the fast lookup mechanism.
 * NOTE:  A reverse lookup mechanism
 *    has not been provided because
 *        some name services may not
 *        provide a fast, general reverse
 *        lookup.
 }
{
 *  RegistryCStrEntryLookup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryCStrEntryLookup({CONST}VAR searchPointID: RegEntryID; {CONST}VAR pathName: RegCStrPathName; VAR foundEntry: RegEntryID): OSStatus; C;
{---------------------------------------------
 * Convert an entry to a rooted name string
 *
 * A utility routine to turn an Entry ID
 * back into a name string.
 }
{
 *  RegistryEntryToPathSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryToPathSize({CONST}VAR entryID: RegEntryID; VAR pathSize: RegPathNameSize): OSStatus; C;
{
 *  RegistryCStrEntryToPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryCStrEntryToPath({CONST}VAR entryID: RegEntryID; VAR pathName: RegCStrPathName; pathSize: RegPathNameSize): OSStatus; C;
{
 * Parse a path name.
 *
 * Retrieve the last component of the path, and
 * return a spec for the parent.
 }
{
 *  RegistryCStrEntryToName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryCStrEntryToName({CONST}VAR entryID: RegEntryID; VAR parentEntry: RegEntryID; VAR nameComponent: RegCStrEntryName; VAR done: BOOLEAN): OSStatus; C;
{ //////////////////////////////////////////////////////
//
// Property Management
//
////////////////////////////////////////////////////// }
{-------------------------------
 * Adding and removing properties
 }
{
 *  RegistryPropertyCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertyCreate({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName; propertyValue: UNIV Ptr; propertySize: RegPropertyValueSize): OSStatus; C;
{
 *  RegistryPropertyDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertyDelete({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName): OSStatus; C;
{
 *  RegistryPropertyRename()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertyRename({CONST}VAR entry: RegEntryID; {CONST}VAR oldName: RegPropertyName; {CONST}VAR newName: RegPropertyName): OSStatus; C;
{---------------------------
 * Traversing the Properties of a name
 *
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	RegPropertyIter    = ^LONGINT; { an opaque 32-bit type }
	RegPropertyIterPtr = ^RegPropertyIter;  { when a VAR xx:RegPropertyIter parameter can be nil, it is changed to xx: RegPropertyIterPtr }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  RegistryPropertyIterateCreate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION RegistryPropertyIterateCreate({CONST}VAR entry: RegEntryID; VAR cookie: RegPropertyIter): OSStatus; C;
{
 *  RegistryPropertyIterateDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertyIterateDispose(VAR cookie: RegPropertyIter): OSStatus; C;
{
 *  RegistryPropertyIterate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertyIterate(VAR cookie: RegPropertyIter; VAR foundProperty: RegPropertyName; VAR done: BOOLEAN): OSStatus; C;
{
 * Get the value of the specified property for the specified entry.
 *
 }
{
 *  RegistryPropertyGetSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertyGetSize({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName; VAR propertySize: RegPropertyValueSize): OSStatus; C;
{
 * (*propertySize) is the maximum size of the value returned in the buffer
 * pointed to by (propertyValue).  Upon return, (*propertySize) is the size of the
 * value returned.
 }
{
 *  RegistryPropertyGet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertyGet({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName; propertyValue: UNIV Ptr; VAR propertySize: RegPropertyValueSize): OSStatus; C;
{
 *  RegistryPropertySet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertySet({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName; propertyValue: UNIV Ptr; propertySize: RegPropertyValueSize): OSStatus; C;
{ //////////////////////////////////////////////////////
//
// Modifier Management
//
////////////////////////////////////////////////////// }
{
 * Modifiers describe special characteristics of names
 * and properties.  Modifiers might be supported for
 * some names and not others.
 * 
 * Device Drivers should not rely on functionality
 * specified as a modifier.  These interfaces
 * are for use in writing Experts.
 }
{
 * Get and Set operators for entry modifiers
 }
{
 *  RegistryEntryGetMod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryGetMod({CONST}VAR entry: RegEntryID; VAR modifiers: RegEntryModifiers): OSStatus; C;
{
 *  RegistryEntrySetMod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntrySetMod({CONST}VAR entry: RegEntryID; modifiers: RegEntryModifiers): OSStatus; C;
{
 * Get and Set operators for property modifiers
 }
{
 *  RegistryPropertyGetMod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertyGetMod({CONST}VAR entry: RegEntryID; {CONST}VAR name: RegPropertyName; VAR modifiers: RegPropertyModifiers): OSStatus; C;
{
 *  RegistryPropertySetMod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryPropertySetMod({CONST}VAR entry: RegEntryID; {CONST}VAR name: RegPropertyName; modifiers: RegPropertyModifiers): OSStatus; C;
{
 * Iterator operator for entry modifier search
 }
{
 *  RegistryEntryMod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryMod(VAR cookie: RegEntryIter; relationship: RegEntryIterationOp; VAR foundEntry: RegEntryID; VAR done: BOOLEAN; matchingModifiers: RegEntryModifiers): OSStatus; C;
{
 * Iterator operator for entries with matching 
 * property modifiers
 }
{
 *  RegistryEntryPropertyMod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegistryEntryPropertyMod(VAR cookie: RegEntryIter; relationship: RegEntryIterationOp; VAR foundEntry: RegEntryID; VAR done: BOOLEAN; matchingModifiers: RegPropertyModifiers): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NameRegistryIncludes}

{$ENDC} {__NAMEREGISTRY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
