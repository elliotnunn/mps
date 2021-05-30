/*
 	File:		NameRegistry.h
 
 	Contains:	NameRegistry Interfaces .
 
 	Version:	Technology:	PowerSurge 1.0.2.
 				Package:	Universal Interfaces 2.1.2 on ETO #20
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __NAMEREGISTRY__
#define __NAMEREGISTRY__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

typedef void *RegPropertyValue;

/* Length of property value */
typedef UInt32 RegPropertyValueSize;

/* Namespace generation number */
typedef UInt32 RegSpecGeneration;

/* ******************************************************************************
** 
** RegEntryID	:	The Global x-Namespace Entry Identifier
//
*/
struct RegEntryID {
	UInt8							opaque[16];
};
typedef struct RegEntryID RegEntryID, *RegEntryIDPtr;

/* ******************************************************************************
**
** Root Entry Name Definitions	(Applies to all Names in the RootNameSpace)
//
//	* Names are a colon separated list of name components.  Name components
//	  may not themselves contain colons.  
//	* Names are presented as null terminated Unicode character strings.
//	* Names follow similar parsing rules to Apple file system absolute
//	  and relative paths.  However the '::' parent directory syntax is
//	  not currently supported.
*/
/* Max length of Entry Name */

enum {
	kRegCStrMaxEntryNameLength	= 47
};

/* Entry Names are single byte ASCII */
typedef char RegCStrEntryName, *RegCStrEntryNamePtr, RegCStrEntryNameBuf[kRegCStrMaxEntryNameLength + 1];

typedef char RegCStrPathName;

typedef UInt32 RegPathNameSize;


enum {
	kRegPathNameSeparator		= 0x3A,							/* ':'  */
	kRegEntryNameTerminator		= 0x00,							/* '\0' */
	kRegPathNameTerminator		= 0x00							/* '\0' */
};

/* ******************************************************************************
**
** Property Name and ID Definitions
//	(Applies to all Properties Regardless of NameSpace)
*/
enum {
	kRegMaximumPropertyNameLength = 31,							/* Max length of Property Name */
	kRegPropertyNameTerminator	= 0x00							/* '\0' */
};

typedef char RegPropertyName, *RegPropertyNamePtr, RegPropertyNameBuf[kRegMaximumPropertyNameLength + 1];

/* ******************************************************************************
**
** Iteration Operations
//
//	These specify direction when traversing the name relationships
*/
typedef UInt32 RegIterationOp;

typedef RegIterationOp RegEntryIterationOp;


enum {
/*
	** Absolute locations
	*/
	kRegIterRoot				= 0x2UL,
/*
	** "Upward" Relationships	
	*/
	kRegIterParents				= 0x3UL,						/* include all  parent(s) of entry */
/*
	** "Downward" Relationships
	//
	*/
	kRegIterChildren			= 0x4UL,						/* include all children */
	kRegIterSubTrees			= 0x5UL,						/* include all sub trees of entry */
	kRegIterDescendants			= 0x5UL,						/* include all descendants of entry */
/*
	** "Horizontal" Relationships	
	*/
	kRegIterSibling				= 0x6UL,						/* include all siblings */
/*
	** Keep doing the same thing
	*/
	kRegIterContinue			= 0x1UL
};

/* ******************************************************************************
**
** Name Entry and Property Modifiers
//

//
// Modifiers describe special characteristics of names
// and properties.  Modifiers might be supported for
// some names and not others.
// 
// Device Drivers should not rely on functionality
// specified as a modifier.
*/
typedef UInt32 RegModifiers;

typedef RegModifiers RegEntryModifiers;

typedef RegModifiers RegPropertyModifiers;


enum {
	kRegNoModifiers				= 0x00000000UL,					/* no entry modifiers in place */
	kRegUniversalModifierMask	= 0x0000FFFFUL,					/* mods to all entries */
	kRegNameSpaceModifierMask	= 0x00FF0000UL,					/* mods to all entries within namespace */
	kRegModifierMask			= 0xFF000000UL					/* mods to just this entry */
};

/* Universal Property Modifiers */
enum {
	kRegPropertyValueIsSavedToNVRAM = 0x00000020UL,				/* property is non-volatile (saved in NVRAM) */
	kRegPropertyValueIsSavedToDisk = 0x00000040UL				/* property is non-volatile (saved on disk) */
};

/* ***********************
**
** The Registry API
//
/////////////////////// */
/* ***********************
**
** Entry Management
//
/////////////////////// */
/*-------------------------------
 * EntryID handling
 */
/*
 * Initialize an EntryID to an known invalid state
 *   note: invalid != uninitialized
 */
extern OSStatus RegistryEntryIDInit(RegEntryID *id);
/*
 * Compare EntryID's for equality or if invalid
 *
 * If a NULL value is given for either id1 or id2 the other id 
 * is compared with and invalid ID.  If both are NULL, the id's 
 * are consided equal (result = true). 
 */
extern Boolean RegistryEntryIDCompare(const RegEntryID *id1, const RegEntryID *id2);
/*
 * Copy an EntryID
 */
extern OSStatus RegistryEntryIDCopy(const RegEntryID *src, RegEntryID *dst);
/*
 * Free an ID so it can be reused.
 */
extern OSStatus RegistryEntryIDDispose(RegEntryID *id);
/*-------------------------------
 * Adding and removing entries
 *
 * If (parentEntry) is NULL, the name is assumed
 * to be a rooted path. It is rooted to an anonymous, unnamed root.
 */
extern OSStatus RegistryCStrEntryCreate(const RegEntryID *parentEntry, const RegCStrPathName *name, RegEntryID *newEntry);
extern OSStatus RegistryEntryDelete(const RegEntryID *id);
struct RegEntryIter {
	void							*opaque;
};
typedef struct RegEntryIter *RegEntryIterPtr;

typedef struct RegEntryIter RegEntryIter;

/* 
 * create/dispose the iterator structure
 *   defaults to root with relationship = kReIterDescendants
 */
extern OSStatus RegistryEntryIterateCreate(RegEntryIter *cookie);
extern OSStatus RegistryEntryIterateDispose(RegEntryIter *cookie);
/* 
 * set Entry Iterator to specified entry
 */
extern OSStatus RegistryEntryIterateSet(RegEntryIter *cookie, const RegEntryID *startEntryID);
/*
 * Return each value of the iteration
 *
 * return entries related to the current entry
 * with the specified relationship
 */
extern OSStatus RegistryEntryIterate(RegEntryIter *cookie, RegEntryIterationOp relationship, RegEntryID *foundEntry, Boolean *done);
/*
 * return entries with the specified property
 *
 * A NULL RegPropertyValue pointer will return an
 * entry with the property containing any value.
 */
extern OSStatus RegistryEntrySearch(RegEntryIter *cookie, RegEntryIterationOp relationship, RegEntryID *foundEntry, Boolean *done, const RegPropertyName *propertyName, const void *propertyValue, RegPropertyValueSize propertySize);
/*--------------------------------
 * Find a name in the namespace
 *
 * This is the fast lookup mechanism.
 * NOTE:  A reverse lookup mechanism
 *	  has not been provided because
 *        some name services may not
 *        provide a fast, general reverse
 *        lookup.
 */
extern OSStatus RegistryCStrEntryLookup(const RegEntryID *searchPointID, const RegCStrPathName *pathName, RegEntryID *foundEntry);
/*---------------------------------------------
 * Convert an entry to a rooted name string
 *
 * A utility routine to turn an Entry ID
 * back into a name string.
 */
extern OSStatus RegistryEntryToPathSize(const RegEntryID *entryID, RegPathNameSize *pathSize);
extern OSStatus RegistryCStrEntryToPath(const RegEntryID *entryID, RegCStrPathName *pathName, RegPathNameSize pathSize);
/*
 * Parse a path name.
 *
 * Retrieve the last component of the path, and
 * return a spec for the parent.
 */
extern OSStatus RegistryCStrEntryToName(const RegEntryID *entryID, RegEntryID *parentEntry, RegCStrEntryName *nameComponent, Boolean *done);
/* ******************************************************
**
** Property Management
//
////////////////////////////////////////////////////// */
/*-------------------------------
 * Adding and removing properties
 */
extern OSStatus RegistryPropertyCreate(const RegEntryID *entryID, const RegPropertyName *propertyName, const void *propertyValue, RegPropertyValueSize propertySize);
extern OSStatus RegistryPropertyDelete(const RegEntryID *entryID, const RegPropertyName *propertyName);
/*---------------------------
 * Traversing the Properties of a name
 *
 */
struct RegPropertyIter {
	void							*opaque;
};
typedef struct RegPropertyIter *RegPropertyIterPtr;

typedef struct RegPropertyIter RegPropertyIter;

extern OSStatus RegistryPropertyIterateCreate(const RegEntryID *entry, RegPropertyIter *cookie);
extern OSStatus RegistryPropertyIterateDispose(RegPropertyIter *cookie);
extern OSStatus RegistryPropertyIterate(RegPropertyIter *cookie, RegPropertyName *foundProperty, Boolean *done);
/*
 * Get the value of the specified property for the specified entry.
 *
 */
extern OSStatus RegistryPropertyGetSize(const RegEntryID *entryID, const RegPropertyName *propertyName, RegPropertyValueSize *propertySize);
/*
 * (*siz) is the maximum size of the value returned in the buffer
 * pointer to by (val).  Upon return, (*siz) is the size of the
 * value returned.
 */
extern OSStatus RegistryPropertyGet(const RegEntryID *entryID, const RegPropertyName *propertyName, void *propertyValue, RegPropertyValueSize *propertySize);
extern OSStatus RegistryPropertySet(const RegEntryID *entryID, const RegPropertyName *propertyName, const void *propertyValue, RegPropertyValueSize propertySize);
/* ******************************************************
**
** Modibute (err, I mean Modifier) Management
//
////////////////////////////////////////////////////// */
/*
 * Modifiers describe special characteristics of names
 * and properties.  Modifiers might be supported for
 * some names and not others.
 * 
 * Device Drivers should not rely on functionality
 * specified as a modifier.  These interfaces
 * are for use in writing Experts.
 */
/*
 * Get and Set operators for entry modifiers
 */
extern OSStatus RegistryEntryGetMod(const RegEntryID *entry, RegEntryModifiers *modifiers);
extern OSStatus RegistryEntrySetMod(const RegEntryID *entry, RegEntryModifiers modifiers);
/*
 * Get and Set operators for property modifiers
 */
extern OSStatus RegistryPropertyGetMod(const RegEntryID *entry, const RegPropertyName *name, RegPropertyModifiers *modifiers);
extern OSStatus RegistryPropertySetMod(const RegEntryID *entry, const RegPropertyName *name, RegPropertyModifiers modifiers);
/*
 * Iterator operator for entry modifier search
 */
extern OSStatus RegistryEntryMod(RegEntryIter *cookie, RegEntryIterationOp relationship, RegEntryID *foundEntry, Boolean *done, RegEntryModifiers matchingModifiers);
/*
 * Iterator operator for entries with matching 
 * property modifiers
 */
extern OSStatus RegistryEntryPropertyMod(RegEntryIter *cookie, RegEntryIterationOp relationship, RegEntryID *foundEntry, Boolean *done, RegPropertyModifiers matchingModifiers);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __NAMEREGISTRY__ */
