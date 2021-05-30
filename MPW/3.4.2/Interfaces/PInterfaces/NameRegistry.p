{
 	File:		NameRegistry.p
 
 	Contains:	NameRegistry Interfaces
 
 	Version:	Technology:	PowerSurge 1.0.2.
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
 * Name Registry - API for device driver name registration
 *
 * This interface provides access to the namespace used
 * by device drivers.  The data structures and entry points
 * are specialized and simplified for device driver use.
}
{
 //////////////////////////////////////////////////////////////////////////////
//
// Data Structures
//
}
{
 //////////////////////////////////////////////////////////////////////////////
// 
// Foundation Types
//
}
{  Value of a property  }

TYPE
	RegPropertyValue					= Ptr;
{  Length of property value  }
	RegPropertyValueSize				= UInt32;
{
 //////////////////////////////////////////////////////////////////////////////
// 
// RegEntryID	:	The Global x-Namespace Entry Identifier
//
}
{  RegEntryID:	The Global Entry ID }
	RegEntryID = RECORD
		contents:				ARRAY [0..15] OF SInt8;
	END;
	RegEntryIDPtr 						= ^RegEntryID;
{
 //////////////////////////////////////////////////////////////////////////////
//
// Root Entry Name Definitions	(Applies to all Names in the RootNameSpace)
//
//	* Names are a colon-separated list of name components.  Name components
//	  may not themselves contain colons.  
//	* Names are presented as null-terminated ASCII character strings.
//	* Names follow similar parsing rules to Apple file system absolute
//	  and relative paths.  However the '::' parent directory syntax is
//	  not currently supported.
}
{  Max length of Entry Name  }

CONST
	kRegCStrMaxEntryNameLength	= 47;

{  Entry Names are single byte ASCII  }

TYPE
	RegCStrEntryName					= CHAR;
	RegCStrEntryNamePtr					= ^CHAR;
{  length of RegCStrEntryNameBuf =  kRegCStrMaxEntryNameLength+1 }
	RegCStrEntryNameBuf					= PACKED ARRAY [0..47] OF CHAR;
	RegCStrPathName						= CHAR;
	RegPathNameSize						= UInt32;

CONST
	kRegPathNameSeparator		= $3A;							{  ':'   }
	kRegEntryNameTerminator		= $00;							{  '\0'  }
	kRegPathNameTerminator		= $00;							{  '\0'  }

{
 //////////////////////////////////////////////////////////////////////////////
//
// Property Name and ID Definitions
//	(Applies to all Properties Regardless of NameSpace)
}
	kRegMaximumPropertyNameLength = 31;							{  Max length of Property Name  }
	kRegPropertyNameTerminator	= $00;							{  '\0'  }


TYPE
	RegPropertyName						= CHAR;
	RegPropertyNamePtr					= ^CHAR;
{
 //////////////////////////////////////////////////////////////////////////////
//
// Iteration Operations
//
//	These specify direction when traversing the name relationships
}
	RegIterationOp						= UInt32;
	RegEntryIterationOp					= RegIterationOp;

CONST
																{  Absolute locations }
	kRegIterRoot				= $00000002;					{  "Upward" Relationships	 }
	kRegIterParents				= $00000003;					{  include all  parent(s) of entry  }
																{  "Downward" Relationships }
	kRegIterChildren			= $00000004;					{  include all children  }
	kRegIterSubTrees			= $00000005;					{  include all sub trees of entry  }
	kRegIterDescendants			= $00000005;					{  include all descendants of entry  }
																{  "Horizontal" Relationships	 }
	kRegIterSibling				= $00000006;					{  include all siblings  }
																{  Keep doing the same thing }
	kRegIterContinue			= $00000001;

{
 //////////////////////////////////////////////////////////////////////////////
//
// Name Entry and Property Modifiers
//

//
// Modifiers describe special characteristics of names
// and properties.  Modifiers might be supported for
// some names and not others.
// 
// Device Drivers should not rely on functionality
// specified as a modifier.
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

{  Universal Property Modifiers  }
	kRegPropertyValueIsSavedToNVRAM = $00000020;				{  property is non-volatile (saved in NVRAM)  }
	kRegPropertyValueIsSavedToDisk = $00000040;					{  property is non-volatile (saved on disk)  }

{
 ///////////////////////
//
// The Registry API
//
/////////////////////// 
}
{
 ///////////////////////
//
// Entry Management
//
/////////////////////// 
}
{
-------------------------------
 * EntryID handling
}
{
 * Initialize an EntryID to a known invalid state
 *   note: invalid != uninitialized
}
FUNCTION RegistryEntryIDInit(VAR id: RegEntryID): OSStatus; C;
{
 * Compare EntryID's for equality or if invalid
 *
 * If a NULL value is given for either id1 or id2, the other id 
 * is compared with an invalid ID.  If both are NULL, the id's 
 * are consided equal (result = true). 
}
FUNCTION RegistryEntryIDCompare({CONST}VAR id1: RegEntryID; {CONST}VAR id2: RegEntryID): BOOLEAN; C;
{
 * Copy an EntryID
}
FUNCTION RegistryEntryIDCopy({CONST}VAR src: RegEntryID; VAR dst: RegEntryID): OSStatus; C;
{
 * Free an ID so it can be reused.
}
FUNCTION RegistryEntryIDDispose(VAR id: RegEntryID): OSStatus; C;
{
-------------------------------
 * Adding and removing entries
 *
 * If (parentEntry) is NULL, the name is assumed
 * to be a rooted path. It is rooted to an anonymous, unnamed root.
}
FUNCTION RegistryCStrEntryCreate({CONST}VAR parentEntry: RegEntryID; {CONST}VAR name: RegCStrPathName; VAR newEntry: RegEntryID): OSStatus; C;
FUNCTION RegistryEntryDelete({CONST}VAR id: RegEntryID): OSStatus; C;

TYPE
	RegEntryIter = ^LONGINT;
{
 * create/dispose the iterator structure
 *   defaults to root with relationship = kRegIterDescendants
}
FUNCTION RegistryEntryIterateCreate(VAR cookie: RegEntryIter): OSStatus; C;
FUNCTION RegistryEntryIterateDispose(VAR cookie: RegEntryIter): OSStatus; C;
{
 * set Entry Iterator to specified entry
}
FUNCTION RegistryEntryIterateSet(VAR cookie: RegEntryIter; {CONST}VAR startEntryID: RegEntryID): OSStatus; C;
{
 * Return each value of the iteration
 *
 * return entries related to the current entry
 * with the specified relationship
}
FUNCTION RegistryEntryIterate(VAR cookie: RegEntryIter; relationship: RegEntryIterationOp; VAR foundEntry: RegEntryID; VAR done: BOOLEAN): OSStatus; C;
{
 * return entries with the specified property
 *
 * A NULL RegPropertyValue pointer will return an
 * entry with the property containing any value.
}
FUNCTION RegistryEntrySearch(VAR cookie: RegEntryIter; relationship: RegEntryIterationOp; VAR foundEntry: RegEntryID; VAR done: BOOLEAN; {CONST}VAR propertyName: RegPropertyName; propertyValue: UNIV Ptr; propertySize: RegPropertyValueSize): OSStatus; C;
{
--------------------------------
 * Find a name in the namespace
 *
 * This is the fast lookup mechanism.
 * NOTE:  A reverse lookup mechanism
 *	  has not been provided because
 *        some name services may not
 *        provide a fast, general reverse
 *        lookup.
}
FUNCTION RegistryCStrEntryLookup({CONST}VAR searchPointID: RegEntryID; {CONST}VAR pathName: RegCStrPathName; VAR foundEntry: RegEntryID): OSStatus; C;
{
---------------------------------------------
 * Convert an entry to a rooted name string
 *
 * A utility routine to turn an Entry ID
 * back into a name string.
}
FUNCTION RegistryEntryToPathSize({CONST}VAR entryID: RegEntryID; VAR pathSize: RegPathNameSize): OSStatus; C;
FUNCTION RegistryCStrEntryToPath({CONST}VAR entryID: RegEntryID; VAR pathName: RegCStrPathName; pathSize: RegPathNameSize): OSStatus; C;
{
 * Parse a path name.
 *
 * Retrieve the last component of the path, and
 * return a spec for the parent.
}
FUNCTION RegistryCStrEntryToName({CONST}VAR entryID: RegEntryID; VAR parentEntry: RegEntryID; VAR nameComponent: RegCStrEntryName; VAR done: BOOLEAN): OSStatus; C;
{
 //////////////////////////////////////////////////////
//
// Property Management
//
////////////////////////////////////////////////////// 
}
{
-------------------------------
 * Adding and removing properties
}
FUNCTION RegistryPropertyCreate({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName; propertyValue: UNIV Ptr; propertySize: RegPropertyValueSize): OSStatus; C;
FUNCTION RegistryPropertyDelete({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName): OSStatus; C;
{
---------------------------
 * Traversing the Properties of a name
 *
}

TYPE
	RegPropertyIter = ^LONGINT;
FUNCTION RegistryPropertyIterateCreate({CONST}VAR entry: RegEntryID; VAR cookie: RegPropertyIter): OSStatus; C;
FUNCTION RegistryPropertyIterateDispose(VAR cookie: RegPropertyIter): OSStatus; C;
FUNCTION RegistryPropertyIterate(VAR cookie: RegPropertyIter; VAR foundProperty: RegPropertyName; VAR done: BOOLEAN): OSStatus; C;
{
 * Get the value of the specified property for the specified entry.
 *
}
FUNCTION RegistryPropertyGetSize({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName; VAR propertySize: RegPropertyValueSize): OSStatus; C;
{
 * (*propertySize) is the maximum size of the value returned in the buffer
 * pointed to by (propertyValue).  Upon return, (*propertySize) is the size of the
 * value returned.
}
FUNCTION RegistryPropertyGet({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName; propertyValue: UNIV Ptr; VAR propertySize: RegPropertyValueSize): OSStatus; C;
FUNCTION RegistryPropertySet({CONST}VAR entryID: RegEntryID; {CONST}VAR propertyName: RegPropertyName; propertyValue: UNIV Ptr; propertySize: RegPropertyValueSize): OSStatus; C;
{
 //////////////////////////////////////////////////////
//
// Modibute (err, I mean Modifier) Management
//
////////////////////////////////////////////////////// 
}
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
FUNCTION RegistryEntryGetMod({CONST}VAR entry: RegEntryID; VAR modifiers: RegEntryModifiers): OSStatus; C;
FUNCTION RegistryEntrySetMod({CONST}VAR entry: RegEntryID; modifiers: RegEntryModifiers): OSStatus; C;
{
 * Get and Set operators for property modifiers
}
FUNCTION RegistryPropertyGetMod({CONST}VAR entry: RegEntryID; {CONST}VAR name: RegPropertyName; VAR modifiers: RegPropertyModifiers): OSStatus; C;
FUNCTION RegistryPropertySetMod({CONST}VAR entry: RegEntryID; {CONST}VAR name: RegPropertyName; modifiers: RegPropertyModifiers): OSStatus; C;
{
 * Iterator operator for entry modifier search
}
FUNCTION RegistryEntryMod(VAR cookie: RegEntryIter; relationship: RegEntryIterationOp; VAR foundEntry: RegEntryID; VAR done: BOOLEAN; matchingModifiers: RegEntryModifiers): OSStatus; C;
{
 * Iterator operator for entries with matching 
 * property modifiers
}
FUNCTION RegistryEntryPropertyMod(VAR cookie: RegEntryIter; relationship: RegEntryIterationOp; VAR foundEntry: RegEntryID; VAR done: BOOLEAN; matchingModifiers: RegPropertyModifiers): OSStatus; C;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NameRegistryIncludes}

{$ENDC} {__NAMEREGISTRY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
