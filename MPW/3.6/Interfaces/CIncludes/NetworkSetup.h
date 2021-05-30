/*
     File:       NetworkSetup.h
 
     Contains:   Network Setup Interfaces
 
     Version:    Technology: 1.3.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __NETWORKSETUP__
#define __NETWORKSETUP__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

#if CALL_NOT_IN_CARBON
#ifndef __NETWORKSETUPTYPES__
#define __NETWORKSETUPTYPES__
typedef struct OpaqueCfgDatabaseRef*    CfgDatabaseRef;
enum {
  kInvalidCfgAreaID             = 0
};

typedef UInt32                          CfgAreaID;
typedef OSType                          CfgEntityClass;
typedef OSType                          CfgEntityType;
struct CfgEntityRef {
  CfgAreaID           fLoc;
  UInt32              fReserved;
  Str255              fID;
};
typedef struct CfgEntityRef             CfgEntityRef;
struct CfgResourceLocator {
  FSSpec              fFile;
  SInt16              fResID;
};
typedef struct CfgResourceLocator       CfgResourceLocator;
struct CfgEntityInfo {
  CfgEntityClass      fClass;
  CfgEntityType       fType;
  Str255              fName;
  CfgResourceLocator  fIcon;
};
typedef struct CfgEntityInfo            CfgEntityInfo;

typedef void *                          CfgEntityAccessID;
struct CfgPrefsHeader {
  UInt16              fSize;                  /* size, in bytes, does not include this header */
  UInt16              fVersion;
  OSType              fType;
};
typedef struct CfgPrefsHeader           CfgPrefsHeader;
/*    -------------------------------------------------------------------------
    Error codes
    ------------------------------------------------------------------------- */
enum {
  kCfgErrDatabaseChanged        = -3290, /* database has changed since last call - close and reopen DB*/
  kCfgErrAreaNotFound           = -3291, /* Area doesn't exist*/
  kCfgErrAreaAlreadyExists      = -3292, /* Area already exists*/
  kCfgErrAreaNotOpen            = -3293, /* Area needs to open first*/
  kCfgErrConfigLocked           = -3294, /* Access conflict - retry later*/
  kCfgErrEntityNotFound         = -3295, /* An entity with this name doesn't exist*/
  kCfgErrEntityAlreadyExists    = -3296, /* An entity with this name already exists*/
  kCfgErrPrefsTypeNotFound      = -3297, /* A preference with this prefsType doesn't exist*/
  kCfgErrDataTruncated          = -3298, /* Data truncated when read buffer too small*/
  kCfgErrFileCorrupted          = -3299, /* The database format appears to be corrupted.*/
  kCfgErrFirst                  = kCfgErrDatabaseChanged,
  kCfgErrLast                   = kCfgErrFileCorrupted
};

/*  reserve a 'free' tag for free blocks*/
enum {
  kCfgFreePref                  = FOUR_CHAR_CODE('free')
};

/*    -------------------------------------------------------------------------
    CfgEntityClass / CfgEntityType

    The database can distinguish between several classes of objects and 
    several types withing each class
    Use of different classes allow to store type of information in the same database

    Other entity classes and types can be defined by developers.
    they should be unique and registered with Developer Tech Support (DTS)
    ------------------------------------------------------------------------- */
enum {
  kCfgClassAnyEntity            = FOUR_CHAR_CODE('****'),
  kCfgClassUnknownEntity        = 0x3F3F3F3F,
  kCfgTypeAnyEntity             = FOUR_CHAR_CODE('****'),
  kCfgTypeUnknownEntity         = 0x3F3F3F3F
};

/*    -------------------------------------------------------------------------
    For CfgIsSameEntityRef
    ------------------------------------------------------------------------- */
enum {
  kCfgIgnoreArea                = true,
  kCfgDontIgnoreArea            = false
};

#endif   /* __NETWORKSETUPTYPES__ */
/*******************************************************************************
**  Configuration Information Access API 
********************************************************************************/
/*    -------------------------------------------------------------------------
    Database access
    ------------------------------------------------------------------------- */
#if CALL_NOT_IN_CARBON
/*
 *  OTCfgOpenDatabase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgOpenDatabase(CfgDatabaseRef * dbRef);


/*
    OTCfgOpenDatabase()

    Inputs:     none
    Outputs:    CfgDatabaseRef* dbRef           Reference to opened database
    Returns:    OSStatus                        *** list errors ***

    Opens Network Setup for a given client. This call should be made prior to any other call.
*/
/*
 *  OTCfgCloseDatabase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgCloseDatabase(CfgDatabaseRef * dbRef);


/*
    OTCfgCloseDatabase()

    Inputs:     CfgDatabaseRef* dbRef           Reference to opened database
    Outputs:    CfgDatabaseRef* dbRef           Reference to opened database is cleared
    Returns:    OSStatus                        *** list errors ***

    Closes Network Setup for a given client. This call should be made when the client no 
    longer wants to use Network Setup.  
*/
/*    -------------------------------------------------------------------------
    Area management
    ------------------------------------------------------------------------- */
/*
 *  OTCfgGetAreasCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetAreasCount(
  CfgDatabaseRef   dbRef,
  ItemCount *      itemCount);


/*
    OTCfgGetAreasCount()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
    Outputs:    ItemCount* itemCount            Number of entities defined
    Returns:    OSStatus                        *** list errors ***

    Returns the number of areas currently defined.
*/
/*
 *  OTCfgGetAreasList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetAreasList(
  CfgDatabaseRef   dbRef,
  ItemCount *      itemCount,
  CfgAreaID        areaID[],        /* can be NULL */
  Str255           areaName[]);     /* can be NULL */


/*
    OTCfgGetAreasList()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                ItemCount* itemCount            Number of entities requested
                CfgAreaID areaID[]              Pointer to array of *itemCount area IDs
                Str255 areaName[]               Pointer to array of *itemCount area names
    Outputs:    ItemCount* itemCount            Number of entities defined
                CfgAreaID areaID[]              Filled in array of area IDs
                Str255 areaName[]               Filled in array of area names
    Returns:    OSStatus                        *** list errors ***

    Returns a list of area IDs and names. On entry, count should be set to whatever OTCfgGetAreasCount 
    returned.  On exit, count contains the actual number of areas found. This can be less than the 
    initial count value if areas were deleted in the meantime.  The id and name parameters are stored 
    in arrays that should each be able to contain count values.
*/
/*
 *  OTCfgGetCurrentArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetCurrentArea(
  CfgDatabaseRef   dbRef,
  CfgAreaID *      areaID);


/*
    OTCfgGetCurrentArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
    Outputs:    CfgAreaID* areaID               ID of current area
    Returns:    OSStatus                        *** list errors ***

    Returns the id of the current area.
*/
/*
 *  OTCfgSetCurrentArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgSetCurrentArea(
  CfgDatabaseRef   dbRef,
  CfgAreaID        areaID);


/*
    OTCfgSetCurrentArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to make active
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Sets the current area. If the area doesn’t exist kCfgErrAreaNotFound is returned.
*/
/*
 *  OTCfgCreateArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgCreateArea(
  CfgDatabaseRef     dbRef,
  ConstStr255Param   areaName,
  CfgAreaID *        areaID);


/*
    OTCfgCreateArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                ConstStr255Param areaName       Name of area to create
    Outputs:    CfgAreaID* areaID               ID of newly created area
    Returns:    OSStatus                        *** list errors ***

    Creates a new area with the specified name. Then name must be unique or kCfgErrAreaAlreadyExists 
    will be returned.
*/
/*
 *  OTCfgDeleteArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgDeleteArea(
  CfgDatabaseRef   dbRef,
  CfgAreaID        areaID);


/*
    OTCfgDeleteArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to delete
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Deletes the specified area. If the area doesn’t exist kCfgErrAreaNotFound is returned.
*/
/*
 *  OTCfgDuplicateArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgDuplicateArea(
  CfgDatabaseRef   dbRef,
  CfgAreaID        sourceAreaID,
  CfgAreaID        destAreaID);


/*
    OTCfgDuplicateArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID sourceAreaID          Area to duplicate
                CfgAreaID destAreaID            Area to contain duplicate
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Duplicates the source area content into the destination area. Both areas should exist prior to 
    making this call. If either area doesn’t exist kCfgErrAreaNotFound is returned.
*/
/*
 *  OTCfgSetAreaName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgSetAreaName(
  CfgDatabaseRef     dbRef,
  CfgAreaID          areaID,
  ConstStr255Param   areaName,
  CfgAreaID *        newAreaID);


/*
    OTCfgSetAreaName()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area being named
                ConstStr255Param areaName       New name for area
    Outputs:    CfgAreaID* newAreaID            ID of renamed area
    Returns:    OSStatus                        *** list errors ***

    Renames the specified area. A new id is returned: it should be used from now on. If the area 
    doesn’t exist kCfgErrAreaNotFound is returned.
*/
/*
 *  OTCfgGetAreaName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetAreaName(
  CfgDatabaseRef   dbRef,
  CfgAreaID        areaID,
  Str255           areaName);


/*
    OTCfgGetAreaName()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area being queried
    Outputs:    Str255 areaName                 Name of area
    Returns:    OSStatus                        *** list errors ***

    Gets the name of the specified area. If the area doesn’t exist kCfgErrAreaNotFound is returned.
    
    Requires Network Setup 1.0.1 or higher.
*/
/*    -------------------------------------------------------------------------
    Configuration Database API
    
    Single Writer ONLY!!!
    ------------------------------------------------------------------------- */
/*    -------------------------------------------------------------------------
    Opening an area for reading
    ------------------------------------------------------------------------- */
/*
 *  OTCfgOpenArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgOpenArea(
  CfgDatabaseRef   dbRef,
  CfgAreaID        areaID);


/*
    OTCfgOpenArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to open
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Opens the specified area for reading. If the area doesn’t exist kCfgErrAreaNotFound is returned.
*/
/*
 *  OTCfgCloseArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgCloseArea(
  CfgDatabaseRef   dbRef,
  CfgAreaID        areaID);


/*
    OTCfgCloseArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to close
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Closes an area opened for reading. If the area doesn’t exist kCfgErrAreaNotFound is returned.  
*/
/*
    For write access
*/
/*
 *  OTCfgBeginAreaModifications()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgBeginAreaModifications(
  CfgDatabaseRef   dbRef,
  CfgAreaID        readAreaID,
  CfgAreaID *      writeAreaID);


/*
    OTCfgBeginAreaModifications()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID readAreaID            ID of area opened for reading
    Outputs:    CfgAreaID* writeAreaID          ID of area opened for modification
    Returns:    OSStatus                        *** list errors ***

    Opens the specified area for writing. A new area id is provided.  This area id should be used to 
    enumerate, add, delete, read and write to the modified data. The original id can still be used to 
    access the original unmodified data. If the area doesn’t exist, kCfgErrAreaNotFound is returned.
*/
/*
 *  OTCfgCommitAreaModifications()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgCommitAreaModifications(
  CfgDatabaseRef   dbRef,
  CfgAreaID        readAreaID,
  CfgAreaID        writeAreaID);


/*
    OTCfgCommitAreaModifications()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID readAreaID            ID of area opened for reading
                CfgAreaID writeAreaID           ID of area opened for modification
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Closes an area opened for writing.  All modifications are committed and readers are informed that 
    the database changed state.  The readAreaID should be the ID of the original area passed to
    OTCfgBeginAreaModifications.  The writeAreaID should be the ID returned by OTCfgBeginAreaModifications.
    If either area doesn’t exist or there is a mismatch between readAreaID and writeAreaID,
    kCfgErrAreaNotFound is returned.
*/
/*
 *  OTCfgAbortAreaModifications()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgAbortAreaModifications(
  CfgDatabaseRef   dbRef,
  CfgAreaID        readAreaID);


/*
    OTCfgAbortAreaModifications()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID readAreaID            ID of area opened for reading
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Closes an area opened for writing, discarding any modification. The areaID should be the id of 
    the original area. If the area doesn’t exist or the wrong id is passed kCfgErrAreaNotFound is 
    returned.
*/
/*
    Working with entities

    Entities can be manipulated as soon as an area has been opened.  The same calls work both for 
    areas opened for reading or for modification. In the latter case, the calls can be used on the 
    original or new area id to access the original data or the modified data.
*/
/*
    For everybody
    Count receives the actual number of entities
*/
/*
 *  OTCfgGetEntitiesCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetEntitiesCount(
  CfgDatabaseRef   dbRef,
  CfgAreaID        areaID,
  CfgEntityClass   entityClass,
  CfgEntityType    entityType,
  ItemCount *      itemCount);


/*
    OTCfgGetEntitiesCount()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to count
                CfgEntityClass entityClass      Class of entities to count
                CfgEntityType entityType        Type of entities to count
    Outputs:    ItemCount* itemCount            Count of matching entities
    Returns:    OSStatus                        *** list errors ***

    Returns the number of entities of the specified class and type in the specified area. To obtain 
    all entities regardless of their class or type pass kCfgClassAnyEntity or kCfgTypeAnyEntity. If 
    the area doesn’t exist, kCfgErrAreaNotFound is returned.
*/

/*
    Count as input, is the number of entities to read;
    count as output, receives the actual number of entities or the number you specified. 
*/
/*
 *  OTCfgGetEntitiesList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetEntitiesList(
  CfgDatabaseRef   dbRef,
  CfgAreaID        areaID,
  CfgEntityClass   entityClass,
  CfgEntityType    entityType,
  ItemCount *      itemCount,
  CfgEntityRef     entityRef[],       /* can be NULL */
  CfgEntityInfo    entityInfo[]);     /* can be NULL */


/*
    OTCfgGetEntitiesList()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to list
                CfgEntityClass entityClass      Class of entities to list
                CfgEntityType entityType        Type of entities to list
                ItemCount* itemCount            Count of entities requested
                CfgEntityRef entityRef[]        Pointer to array of *itemCount entity refs
                CfgEntityInfo entityInfo[]      Pointer to array of *itemCount entity infos
    Outputs:    ItemCount* itemCount            Count of entities listed
                CfgEntityRef entityRef[]        Filled in array of *itemCount entity refs
                CfgEntityInfo entityInfo[]      Filled in array of *itemCount entity infos
    Returns:    OSStatus                        *** list errors ***

    Returns the list of entities of the specified class and type in the specified area. To obtain all 
    entities regardless of their class or type pass kCfgClassAnyEntity or kCfgTypeAnyEntity. The 
    count parameter should have the value obtained by CfgGetEntitiesCount.  On exit count may be less 
    if some entities were deleted in the meantime. The id and info parameters should be arrays large 
    enough to hold count entries. If the area doesn’t exist, 
    kCfgErrAreaNotFound is returned.  The info array contains information about each entity, 
    including its class, type, name and the area of its icon:

    struct CfgEntityInfo
    {
        CfgEntityClass      fClass;
        CfgEntityType       fType;
        ConstStr255Param    fName;
        CfgResourceLocator  fIcon;
    };
*/
/*
 *  OTCfgCreateEntity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgCreateEntity(
  CfgDatabaseRef         dbRef,
  CfgAreaID              areaID,
  const CfgEntityInfo *  entityInfo,
  CfgEntityRef *         entityRef);


/*
    OTCfgCreateEntity()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to contain entity
                CfgEntityInfo* entityInfo       Information that defines the entity
    Outputs:    CfgEntityRef* entityRef         Reference to entity created
    Returns:    OSStatus                        *** list errors ***

    Creates a new entity with the specified class, type and name and returns an id for it. If the 
    area doesn’t exist, kCfgErrAreaNotFound is returned. If there is already 
    an entity with the same name kCfgErrEntityAlreadyExists is returned.
*/
/*
 *  OTCfgDeleteEntity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgDeleteEntity(
  CfgDatabaseRef        dbRef,
  const CfgEntityRef *  entityRef);


/*
    OTCfgDeleteEntity()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef* entityRef         Reference to entity to delete
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Deletes the specified entity. If there is no entity with this id, kCfgEntityNotfoundErr is returned
*/
/*
 *  OTCfgDuplicateEntity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgDuplicateEntity(
  CfgDatabaseRef        dbRef,
  const CfgEntityRef *  entityRef,
  const CfgEntityRef *  newEntityRef);


/*
    OTCfgDuplicateEntity()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef* entityRef         Reference to entity to duplicate
                CfgEntityRef* newEntityRef      Reference to destination entity
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Copies the contents of entityRef into newEntityRef. Both entities must exit.
    If either entity doesn’t exist kCfgErrEntityNotFound is returned.
*/
/*
 *  OTCfgSetEntityName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgSetEntityName(
  CfgDatabaseRef        dbRef,
  const CfgEntityRef *  entityRef,
  ConstStr255Param      entityName,
  CfgEntityRef *        newEntityRef);


/*
    OTCfgSetEntityName()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef* entityRef         Reference to entity to rename
                ConstStr255Param entityName     New name for entity
    Outputs:    CfgEntityRef* newEntityRef      Reference to renamed entity
    Returns:    OSStatus                        *** list errors ***

    Renames the specified entity. If the entity doesn’t exist kCfgEntityNotfoundErr is returned. If 
    there is already an entity with that name kCfgErrEntityAlreadyExists is returned.
*/
/*
 *  OTCfgGetEntityArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
OTCfgGetEntityArea(
  const CfgEntityRef *  entityRef,
  CfgAreaID *           areaID);


/*
    OTCfgGetEntityArea()

    Inputs:     CfgEntityRef *entityRef         Reference to an entity
    Outputs:    CfgAreaID *areaID               ID of area that contains the entity
    Returns:    none

    Returns the area ID associated with the specified entity reference.
*/
/*
 *  OTCfgGetEntityName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
OTCfgGetEntityName(
  const CfgEntityRef *  entityRef,
  Str255                entityName);


/*
    OTCfgGetEntityName()

    Inputs:     CfgEntityRef *entityRef         Reference to an entity
    Outputs:    Str255 entityName               Name of the entity
    Returns:    none

    Returns the entity name associated with the specified entity reference.
*/
#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  OTCfgGetEntityLogicalName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetEntityLogicalName(
  CfgDatabaseRef        dbRef,
  const CfgEntityRef *  entityRef,
  Str255                entityName);


/*
    OTCfgGetEntityName()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef *entityRef         Reference to an entity
    Outputs:    Str255 entityName               Logical Name of the entity
    Returns:    none

    Returns the logical name associated with the specified entity reference.
*/
#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  OTCfgChangeEntityArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
OTCfgChangeEntityArea(
  CfgEntityRef *  entityRef,
  CfgAreaID       newAreaID);


/*
    OTCfgChangeEntityArea()

    Inputs:     CfgEntityRef *entityRef         Reference to an entity
                CfgAreaID newAreaID             ID of area to contain moved entity
    Outputs:    none
    Returns:    none

    Changes the area ID associated with the specified entity reference.
*/
/*    -------------------------------------------------------------------------
    These API calls are for the protocol developers to compare the IDs.
    ------------------------------------------------------------------------- */
/*    -------------------------------------------------------------------------
    For OTCfgIsSameEntityRef
    ------------------------------------------------------------------------- */
#endif  /* CALL_NOT_IN_CARBON */

enum {
  kOTCfgIgnoreArea              = kCfgIgnoreArea,
  kOTCfgDontIgnoreArea          = kCfgDontIgnoreArea
};

#if CALL_NOT_IN_CARBON
/*
 *  OTCfgIsSameEntityRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
OTCfgIsSameEntityRef(
  const CfgEntityRef *  entityRef1,
  const CfgEntityRef *  entityRef2,
  Boolean               ignoreArea);


/*
    OTCfgIsSameEntityRef()

    Inputs:     CfgEntityRef* entityRef1        Reference to an entity
                CfgEntityRef* entityRef2        Reference to another entity
                Boolean ignoreArea              If true, ignore the area ID
    Outputs:    none
    Returns:    Boolean                         If true, entity references match

    Compare two entity references. If ignoreArea is true, and the two entity names are the same, then return 
    true. If ignoreArea is false, then the area IDs must be the same, as well as the entity names 
    must be the same, then can return true.
*/
/*
 *  OTCfgIsSameAreaID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
OTCfgIsSameAreaID(
  CfgAreaID   areaID1,
  CfgAreaID   areaID2);


/*
    OTCfgIsSameAreaID()

    Inputs:     CfgAreaID areaID1               ID of an area
                CfgAreaID areaID2               ID of another area
    Outputs:    none
    Returns:    Boolean                         If true, area IDs match

    Compare two area IDs. Return true for matching area IDs, and return false for the different area IDs.
*/
/*    -------------------------------------------------------------------------
    Dealing with individual preferences
    ------------------------------------------------------------------------- */
/*    -------------------------------------------------------------------------
    Open Preferences
    if writer = true, GetPrefs and SetPrefs are allowed, else only GetPrefs is allowed.
    ------------------------------------------------------------------------- */
/*
 *  OTCfgOpenPrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgOpenPrefs(
  CfgDatabaseRef        dbRef,
  const CfgEntityRef *  entityRef,
  Boolean               writer,
  CfgEntityAccessID *   accessID);


/*
    OTCfgOpenPrefs()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef* entityRef         Reference to an entity
                Boolean writer                  If true, open for write
    Outputs:    CfgEntityAccessID* accessID     ID for entity access
    Returns:    OSStatus                        *** list errors ***

    Open the specified entity and return the CfgEntityAccessID for the following access of the 
    content of the entity. If writer is true, CfgGetPrefs and CfgSetPrefs are allowed, otherwise only 
    CfgGetPrefs is allowed.
*/
/*
 *  OTCfgClosePrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgClosePrefs(CfgEntityAccessID accessID);


/*
    OTCfgClosePrefs()

    Inputs:     CfgEntityAccessID* accessID     ID for entity to close
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Close the entity with the specified CfgEntityAccessID.
*/
/*    -------------------------------------------------------------------------
    Get/Set Preferences

    Accessing the content of an entity

    These API calls are for the protocol developers. It supports multiple preferences per entity. Each 
    preference is identified by an OSType (typically called prefsType). The structure of the
    preference data is protocol stack dependent.
    ------------------------------------------------------------------------- */
/*
 *  OTCfgSetPrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgSetPrefs(
  CfgEntityAccessID   accessID,
  OSType              prefsType,
  const void *        data,
  ByteCount           length);


/*
    OTCfgSetPrefs()

    Inputs:     CfgEntityAccessID* accessID     ID of entity to access
                OSType prefsType                Preference type to set
                void* data                      Address of data
                ByteCount length                Number of bytes of data
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Write the data to the specified preference, creating the preference if necessary.
    The preference is identified by the prefsType. If the entity is not opened for
    the writer, an error code is returned.
*/
#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  OTCfgDeletePrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgDeletePrefs(
  CfgEntityAccessID   accessID,
  OSType              prefsType);


/*
    OTCfgDeletePrefs()

    Inputs:     CfgEntityAccessID* accessID     ID of entity to access
                OSType prefsType                Preference type to get
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Delete the specified preference. The preference is identified by the prefsType. 
*/
#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  OTCfgGetPrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetPrefs(
  CfgEntityAccessID   accessID,
  OSType              prefsType,
  void *              data,
  ByteCount           length);


/*
    OTCfgGetPrefs()

    Inputs:     CfgEntityAccessID* accessID     ID of entity to access
                OSType prefsType                Preference type to get
                void* data                      Address for data
                ByteCount length                Number of bytes of data requested
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Read the data from the specified preference to the passed buffer. The preference is identified by the 
    prefsType. If the passed buffer is too small, kCfgErrDataTruncated is returned, but will copy as 
    many data as possible to the buffer.
*/
/*
 *  OTCfgGetPrefsSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetPrefsSize(
  CfgEntityAccessID   accessID,
  OSType              prefsType,
  ByteCount *         length);


/*
    OTCfgGetPrefsSize()

    Inputs:     CfgEntityAccessID* accessID     ID of entity to access
                OSType prefsType                Preference type to get
                ByteCount length                Number of bytes of data available
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Returns the length, in bytes, of the specified preference. The preference is identified by the prefsType.
*/
#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  OTCfgGetTemplate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetTemplate(
  CfgEntityClass   entityClass,
  CfgEntityType    entityType,
  OSType           prefsType,
  void *           data,
  ByteCount *      dataSize);


/*
    OTCfgGetDefault()

    Inputs:     OSType      entityClass         entityClass
                OSType      entityType          entityType
                OSType      prefsType           prefsType
                ByteCount*  dataSize            maximum length of buffer
    Outputs:    void*       data                template for the preference class/type/prefsType
                ByteCount*  dataSize            actual length of template
    Returns:    OSStatus                        *** list errors ***

    This routine returns the template for the specified preference class, type, and prefsType.
*/
/*
    Due to a human error, OTCfgGetDefault was published with the entity type and class parameters reversed, 
    with respect to the other calls that take these same parameters.  Please, use OTCfgGetTemplate instead.  
*/
#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  OTCfgGetDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
OTCfgGetDefault(
  OSType   entityType,
  OSType   entityClass,
  OSType   prefsType);


/*
    OTCfgGetDefault()

    Inputs:     OSType  entityType              entityType
                OSType  entityClass             entityClass
                OSType  prefsType               prefsType
    Outputs:    none
    Returns:    Handle                          default preference for the preference type/class/prefsType

    This routine returns the default preference value for the specified preference type, class, and prefsType.
*/
/*    -------------------------------------------------------------------------
    Get table of contents for prefs
    ------------------------------------------------------------------------- */
/*
 *  OTCfgGetPrefsTOCCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetPrefsTOCCount(
  CfgEntityAccessID   accessID,
  ItemCount *         itemCount);


/*
    OTCfgGetPrefsTOCCount()

    Inputs:     CfgEntityAccessID* accessID     ID of entity to access
    Outputs:    ItemCount* itemCount            Number of entries available
    Returns:    OSStatus                        *** list errors ***

    Get the count of all the preference in the entity.
*/
/*
 *  OTCfgGetPrefsTOC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgGetPrefsTOC(
  CfgEntityAccessID   accessID,
  ItemCount *         itemCount,
  CfgPrefsHeader      prefsTOC[]);


/*
    OTCfgGetPrefsTOC()

    Inputs:     CfgEntityAccessID* accessID     ID of entity to access
                ItemCount* itemCount            Number of entries requested
                CfgPrefsHeader prefsTOC[]       Pointer to array of *itemCount pref headers
    Outputs:    ItemCount* itemCount            Number of entries returned
                CfgPrefsHeader prefsTOC[]       Filled in array of *itemCount pref headers
    Returns:    OSStatus                        *** list errors ***

    Get the list of all the preference in the entity. Return the number of preferences in the count. 
    prefsTOC has to be big enough to hold information about all the preference.

    Current versions of Network Setup don’t read the input value of itemCount to ensure
    that the returned preference information doesn't write off the end of the prefsTOC array.
    This is too be fixed in a future version.  The upshot is that:
    
     a) always call OTCfgGetPrefsTOCCount before calling this routine and then allocate
        an appropriate sized array to pass to prefsTOC
     b) before calling this routine, always set up itemCount to the size of the prefsTOC
        array so that your code will run on future systems
*/
/*    -------------------------------------------------------------------------
    Database Change Notification
    ------------------------------------------------------------------------- */
#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( void , OTCfgNotifyProcPtr )(void *contextPtr, UInt32 code, SInt32 result, void *cookie);
struct OTCfgNotifierEntry {
  CfgDatabaseRef      dbRef;
  CfgEntityClass      theClass;
  CfgEntityType       theType;
  OTCfgNotifyProcPtr  notifier;
  void *              contextPtr;
  CfgAreaID           theArea;
};
typedef struct OTCfgNotifierEntry       OTCfgNotifierEntry;
#if CALL_NOT_IN_CARBON
/*
 *  OTCfgInstallNotifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgInstallNotifier(
  CfgDatabaseRef       dbRef,
  CfgEntityClass       theClass,
  CfgEntityType        theType,
  OTCfgNotifyProcPtr   notifier,
  void *               contextPtr);      /* can be NULL */


/*
    OTCfgInstallNotifier()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityClass theClass         receives notifications about changes to this class
                CfgEntityType theType           receives notifications about changes to this type
                OTCfgNotifyProcPtr notifier     address of callback routine
                void* contextPtr                refCon for callback routine
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Installs a notifier that Network Setup will call when interesting things happen.

    Requires Network Setup 1.1 or higher.
*/
/*
 *  OTCfgRemoveNotifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
OTCfgRemoveNotifier(
  CfgDatabaseRef   dbRef,
  CfgEntityClass   theClass,
  CfgEntityType    theType);


/*
    OTCfgRemoveNotifier()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityClass theClass         remove notifier for this class
                CfgEntityType theType           remove notifier for this type
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Removes a notifier previously installed with OTCfgRemoveNotifier.

    Requires Network Setup 1.1 or higher.
*/
/* Constants for the code parameter of the notifier installed by OTCfgInstallNotifier.*/

#endif  /* CALL_NOT_IN_CARBON */

enum {
  kOTCfgDatabaseChanged         = 0x10000000 + 0 /* result will be kCfgErrDatabaseChanged, cookie is meaningless*/
};

/*    -------------------------------------------------------------------------
    Remote Access Preference Utilities
    ------------------------------------------------------------------------- */
#if CALL_NOT_IN_CARBON
/*
 *  OTCfgEncrypt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( SInt16 )
OTCfgEncrypt(
  UInt8 *  key,
  UInt8 *  data,
  SInt16   dataLen);


/*
    OTCfgEncrypt()

    Inputs:     UInt8 *key                      encryption key ( user name )
                UInt8 *data                     data to encrypt ( password )
                SInt16 dataLen                  length of data to encrypt
    Outputs:    UInt8 *data                     encrypted data
    Returns:    SInt16                          length of encrypted data

    Encrypt the password, using the user name as the encryption key.  Return the encrypted password and its length.  
    
    Requires Network Setup 1.1 or higher.
*/
/*
 *  OTCfgDecrypt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( SInt16 )
OTCfgDecrypt(
  UInt8 *  key,
  UInt8 *  data,
  SInt16   dataLen);


/*
    OTCfgDecrypt()

    Inputs:     UInt8 *key                      encryption key ( user name )
                UInt8 *data                     data to decrypt ( password )
                SInt16 dataLen                  length of data to decrypt
    Outputs:    UInt8 *data                     decrypted data
    Returns:    SInt16                          length of decrypted data

    Decrypt the password, using the user name as the encryption key.  Return the decrypted password and its length.  

    Requires Network Setup 1.1 or higher.
*/

/*    -------------------------------------------------------------------------
    CfgEntityClass / CfgEntityType

    The database can distinguish between several classes of objects and 
    several types withing each class
    Use of different classes allow to store type of information in the same database

    Other entity classes and types can be defined by developers.
    they should be unique and registered with Developer Tech Support (DTS)
    ------------------------------------------------------------------------- */
#endif  /* CALL_NOT_IN_CARBON */

enum {
  kOTCfgClassNetworkConnection  = FOUR_CHAR_CODE('otnc'),
  kOTCfgClassGlobalSettings     = FOUR_CHAR_CODE('otgl'),
  kOTCfgClassServer             = FOUR_CHAR_CODE('otsv'),
  kOTCfgTypeGeneric             = FOUR_CHAR_CODE('otan'),
  kOTCfgTypeAppleTalk           = FOUR_CHAR_CODE('atlk'),
  kOTCfgTypeTCPv4               = FOUR_CHAR_CODE('tcp4'),
  kOTCfgTypeTCPv6               = FOUR_CHAR_CODE('tcp6'),
  kOTCfgTypeDNS                 = FOUR_CHAR_CODE('dns '),
  kOTCfgTypeRemote              = FOUR_CHAR_CODE('ara '),
  kOTCfgTypeDial                = FOUR_CHAR_CODE('dial'),
  kOTCfgTypeModem               = FOUR_CHAR_CODE('modm'),
  kOTCfgTypeInfrared            = FOUR_CHAR_CODE('infr'),
  kOTCfgClassSetOfSettings      = FOUR_CHAR_CODE('otsc'),
  kOTCfgTypeSetOfSettings       = FOUR_CHAR_CODE('otst')
};

/*    *****************************************************
    *************** Preference Structures ***************
    *****************************************************
*/

/*  ------------------ Network Setup ------------------ */


enum {
  kOTCfgSetsStructPref          = FOUR_CHAR_CODE('stru'), /* CfgSetsStruct*/
  kOTCfgSetsElementPref         = FOUR_CHAR_CODE('elem'), /* CfgSetsElement*/
  kOTCfgSetsVectorPref          = FOUR_CHAR_CODE('vect') /* CfgSetsVector*/
};

/*
   Bits and masks for the fFlags field of CfgSetsStruct.
   Second line.
*/
enum {
  kOTCfgSetsFlagActiveBit       = 0
};

enum {
  kOTCfgSetsFlagActiveMask      = 0x0001
};


/* Indexes for the fTimes field of CfgSetsStruct.*/
enum {
  kOTCfgIndexSetsActive         = 0,
  kOTCfgIndexSetsEdit           = 1,
  kOTCfgIndexSetsLimit          = 2     /*    last value, no comma*/
};

struct CfgSetsStruct {
  UInt32              fFlags;
  UInt32              fTimes[2];
};
typedef struct CfgSetsStruct            CfgSetsStruct;
struct CfgSetsElement {
  CfgEntityRef        fEntityRef;
  CfgEntityInfo       fEntityInfo;
};
typedef struct CfgSetsElement           CfgSetsElement;
struct CfgSetsVector {
  UInt32              fCount;
  CfgSetsElement      fElements[1];
};
typedef struct CfgSetsVector            CfgSetsVector;


enum {
  kOTCfgFlagRecordVersion       = 0x01200120,
  kOTCfgProtocolActive          = (1 << 0),
  kOTCfgProtocolMultihoming     = (1 << 16),
  kOTCfgProtocolLimit           = 0x00010001
};

struct OTCfgFlagRecord {
  UInt32              fVersion;
  UInt32              fFlags;
};
typedef struct OTCfgFlagRecord          OTCfgFlagRecord;


/*  ------------------ Common ------------------    */



/* Per-connection preference types*/

enum {
  kOTCfgUserVisibleNamePref     = FOUR_CHAR_CODE('pnam'), /* Pascal string*/
  kOTCfgVersionPref             = FOUR_CHAR_CODE('cvrs'), /* UInt16, values should be 1*/
  kOTCfgPortUserVisibleNamePref = FOUR_CHAR_CODE('port'), /* Pascal string*/
  kOTCfgPortUIName              = FOUR_CHAR_CODE('otgn'), /* Pascal String*/
  kOTCfgProtocolUserVisibleNamePref = FOUR_CHAR_CODE('prot'), /* C string (TCP/IP = "tcp", AppleTalk = "ddp", n/a for others)*/
  kOTCfgAdminPasswordPref       = FOUR_CHAR_CODE('pwrd'), /* not to be documented*/
  kOTCfgProtocolOptionsPref     = FOUR_CHAR_CODE('opts') /* UInt32, protocol specific flags*/
};


/* Global preference types*/

enum {
  kOTCfgUserModePref            = FOUR_CHAR_CODE('ulvl'), /* OTCfgUserMode, TCP/IP and AppleTalk only*/
  kOTCfgPrefWindowPositionPref  = FOUR_CHAR_CODE('wpos') /* Point, global coordinates, TCP/IP, AppleTalk, Infrared only*/
};


/* Per-connection backward compatibility preference types*/

enum {
  kOTCfgCompatNamePref          = FOUR_CHAR_CODE('cnam'),
  kOTCfgCompatResourceNamePref  = FOUR_CHAR_CODE('resn')
};


/* Global backward compatibility preference types*/

enum {
  kOTCfgCompatSelectedPref      = FOUR_CHAR_CODE('ccfg'),
  kOTCfgCompatResourceIDPref    = FOUR_CHAR_CODE('resi')
};


/*
   For most control panels that support a concept of "user mode",
   the OTCfgUserMode preference holds (or is used as a field in 
   another preference to hold) the current user mode.
*/
typedef UInt16 OTCfgUserMode;
enum {
  kOTCfgBasicUserMode           = 1,
  kOTCfgAdvancedUserMode        = 2,
  kOTCfgAdminUserMode           = 3     /* admin mode is never valid in a preference, here for completeness only*/
};



/*
   The exceptions (and there has to be exceptions, right) are Remote
   Access and Modem, where the user mode is always stored as a UInt32
   instead of a UInt16.  The constant values from OTCfgUserMode apply though.
*/

typedef UInt32                          OTCfgUserMode32;


/*  ------------------ AppleTalk ------------------ */



/* Per-connection preference types*/

enum {
  kOTCfgATalkGeneralPref        = FOUR_CHAR_CODE('atpf'), /* OTCfgATalkGeneral*/
  kOTCfgATalkLocksPref          = FOUR_CHAR_CODE('lcks'), /* OTCfgATalkLocks*/
  kOTCfgATalkPortDeviceTypePref = FOUR_CHAR_CODE('ptfm') /* OTCfgATalkPortDeviceType*/
};


/* Global preference types*/

enum {
  kOTCfgATalkNetworkArchitecturePref = FOUR_CHAR_CODE('neta') /* OTCfgATalkNetworkArchitecture*/
};


/*
   OTCfgATalkGeneralAARP is a sub-structure of OTCfgATalkGeneral.
   It defines parameters for the AppleTalk Address Resolution Protocol
   (AARP) component of the AppleTalk protocol stack.
*/
struct OTCfgATalkGeneralAARP {
  UInt16              fVersion;               /* must be 1*/
  UInt16              fSize;                  /* must be sizeof(OTCfgATalkGeneralAARP)*/
  UInt32              fAgingCount;            /* default of 8*/
  UInt32              fAgingInterval;         /* ms, default of 10000*/
  UInt32              fProtAddrLen;           /* bytes, must be 4, ignored by current versions of OT*/
  UInt32              fHWAddrLen;             /* bytes, must be 6, ignored by current versions of OT*/
  UInt32              fMaxEntries;            /* default of 100*/
  UInt32              fProbeInterval;         /* ms, default of 200*/
  UInt32              fProbeRetryCount;       /* default of 10*/
  UInt32              fRequestInterval;       /* ms, default of 200*/
  UInt32              fRequestRetryCount;     /* default of 8*/
};
typedef struct OTCfgATalkGeneralAARP    OTCfgATalkGeneralAARP;


/*
   OTCfgATalkUnloadOptions controls whether AppleTalk is active or not.
   The various constants deserve some explanation.  The original definition
   of this field was as an inactivity timeout (in minutes), similar to that
   implemented by TCP/IP in current versions of OT.  However, before OT 1.0
   shipped Apple realised that loading and unloading AppleTalk on demand
   was not possible, so this was redefined as a flag, with zero meaning
   inactive and not-zero meaning active.  However, the default preferences
   were not updated to reflect this change.  So, it is possible to see
   the values defined below stored in this field.
   When reading, you should treat zero as inactive, and all non-zero values
   as active.  When writing, you should write either kOTCfgATalkInactive
   or kOTCfgATalkActive, never kOTCfgATalkDefaultUnloadTimeout.
*/
typedef UInt8 OTCfgATalkUnloadOptions;
enum {
  kOTCfgATalkInactive           = 0,
  kOTCfgATalkDefaultUnloadTimeout = 5,
  kOTCfgATalkActive             = 0xFF
};




/*
   OTCfgATalkGeneralDDP is a sub-structure of OTCfgATalkGeneral.
   It defines parameters for the Datagram Deliver Protocol
   (DDP) component of the AppleTalk protocol stack.
*/
struct OTCfgATalkGeneralDDP {
  UInt16              fVersion;               /* must be 1*/
  UInt16              fSize;                  /* must be sizeof(OTCfgATalkGeneralDDP)*/
  UInt32              fTSDUSize;              /* must be 586*/
  OTCfgATalkUnloadOptions  fLoadType;         /* whether AppleTalk is active, see the discussion above*/
  UInt8               fNode;                  /* last acquired node number, or fixed node to use*/
  UInt16              fNetwork;               /* last acquired network, or fixed network to use*/
  UInt16              fRTMPRequestLimit;      /* must be 3, ignored by current versions of OT*/
  UInt16              fRTMPRequestInterval;   /* ms, must be 200, ignored by current versions of OT*/
  UInt32              fAddressGenLimit;       /* default of 250*/
  UInt32              fBRCAgingInterval;      /* ms, must be 40000, BRC = best routing cache, ignored by current versions of OT*/
  UInt32              fRTMPAgingInterval;     /* ms, must be 50000, ignored by current versions of OT*/
  UInt32              fMaxAddrTries;          /* default of 4096*/
  Boolean             fDefaultChecksum;       /* default of false, does DDP checksum by default*/
  Boolean             fIsFixedNode;           /* default of false, using fixed net/node*/
  UInt8               fMyZone[33];            /* last acquired zone*/
};
typedef struct OTCfgATalkGeneralDDP     OTCfgATalkGeneralDDP;


/*
   OTCfgATalkGeneralNBP is a sub-structure of OTCfgATalkGeneral.
   It defines parameters for the Name Binding Protocol 
   (NBP) component of the AppleTalk protocol stack.
*/
struct OTCfgATalkGeneralNBP {
  UInt16              fVersion;               /* must be 1*/
  UInt16              fSize;                  /* must be sizeof(OTCfgATalkGeneralNBP)*/
  UInt32              fTSDUSize;              /* default of 584*/
  UInt32              fDefaultRetryInterval;  /* ms, default of 800*/
  UInt32              fDefaultRetryCount;     /* default of 3*/
  Boolean             fCaseSensitiveCompare;  /* default of false*/
  UInt8               fPad;                   /* must be 0*/
};
typedef struct OTCfgATalkGeneralNBP     OTCfgATalkGeneralNBP;


/*
   OTCfgATalkGeneralZIP is a sub-structure of OTCfgATalkGeneral.
   It defines parameters for the Zone Information Protocol
   (ZIP) component of the AppleTalk protocol stack.
*/
struct OTCfgATalkGeneralZIP {
  UInt16              fVersion;               /* must be 1*/
  UInt16              fSize;                  /* must be sizeof(OTCfgATalkGeneralZIP)*/
  UInt32              fGetZoneInterval;       /* ms, default of 2000*/
  UInt32              fZoneListInterval;      /* ms, defalut of 2000*/
  UInt16              fDDPInfoTimeout;        /* ms, default of 4000;*/
  UInt8               fGetZoneRetries;        /* default of 4*/
  UInt8               fZoneListRetries;       /* default of 4*/
  Boolean             fChecksumFlag;          /* default of 0*/
  UInt8               fPad;                   /* must be 0*/
};
typedef struct OTCfgATalkGeneralZIP     OTCfgATalkGeneralZIP;


/*
   OTCfgATalkGeneralATP is a sub-structure of OTCfgATalkGeneral.
   It defines parameters for the AppleTalk Transaction Protocol
   (ATP) component of the AppleTalk protocol stack.
*/
struct OTCfgATalkGeneralATP {
  UInt16              fVersion;               /* must be 1*/
  UInt16              fSize;                  /* must be sizeof(OTCfgATalkGeneralATP)*/
  UInt32              fTSDUSize;              /* default of 578*/
  UInt32              fDefaultRetryInterval;  /* ms, default of 2000*/
  UInt32              fDefaultRetryCount;     /* default of 8*/
  UInt8               fDefaultReleaseTimer;   /* default of 0, same format as ATP_OPT_RELTIMER option*/
  Boolean             fDefaultALOSetting;     /* default of false*/
};
typedef struct OTCfgATalkGeneralATP     OTCfgATalkGeneralATP;


/*
   OTCfgATalkGeneralADSP is a sub-structure of OTCfgATalkGeneral.
   It defines parameters for the AppleTalk Data Stream Protocol
   (ADSP) component of the AppleTalk protocol stack.
*/
struct OTCfgATalkGeneralADSP {
  UInt16              fVersion;               /* must be 1*/
  UInt16              fSize;                  /* must be sizeof(OTCfgATalkGeneralADSP)*/
  UInt32              fDefaultSendBlocking;   /* bytes, default of 16*/
  UInt32              fTSDUSize;              /* default of 572*/
  UInt32              fETSDUSize;             /* default of 572*/
  UInt32              fDefaultOpenInterval;   /* ms, default of 3000*/
  UInt32              fDefaultProbeInterval;  /* ms, default of 30000*/
  UInt32              fMinRoundTripTime;      /* ms, default of 100*/
  UInt32              fDefaultSendInterval;   /* ms, default of 100*/
  UInt32              fDefaultRecvWindow;     /* bytes, must be 27648, ignored by current versions of OT*/
  UInt8               fDefaultOpenRetries;    /* default of 3*/
  UInt8               fDefaultBadSeqMax;      /* default of 3*/
  UInt8               fDefaultProbeRetries;   /* default of 4*/
  UInt8               fMaxConsecutiveDataPackets; /* default of 48*/
  Boolean             fDefaultChecksum;       /* default of false*/
  Boolean             fDefaultEOM;            /* default of false*/
};
typedef struct OTCfgATalkGeneralADSP    OTCfgATalkGeneralADSP;


/*
   OTCfgATalkGeneralPAP is a sub-structure of OTCfgATalkGeneral.
   It defines parameters for the Printer Access Protocol
   (PAP) component of the AppleTalk protocol stack.
*/
struct OTCfgATalkGeneralPAP {
  UInt16              fVersion;               /* must be 1*/
  UInt16              fSize;                  /* must be sizeof(OTCfgATalkGeneralPAP)*/
  UInt32              fDefaultOpenInterval;   /* ms, default of 2000*/
  UInt32              fDefaultTickleInterval; /* ms, default of 15000*/
  UInt8               fDefaultOpenRetries;    /* default of 0*/
  UInt8               fDefaultTickleRetries;  /* default of 8*/
  UInt8               fDefaultReplies;        /* must be 8, ignored by current versions of OT*/
  Boolean             fDefaultPAPEOMEnabled;  /* default of false*/
};
typedef struct OTCfgATalkGeneralPAP     OTCfgATalkGeneralPAP;


/*
   OTCfgATalkGeneralASP is a sub-structure of OTCfgATalkGeneral.
   It defines parameters for the AppleTalk Session Protocol
   (ASP) component of the AppleTalk protocol stack.
   IMPORTANT:  Open Transport does not currently include a native
   ASP implemention, and the classic AppleTalk ASP implementation
   does not heed these preferences.
*/
struct OTCfgATalkGeneralASP {
  UInt16              fVersion;               /* must be 1*/
  UInt16              fSize;                  /* must be sizeof(OTCfgATalkGeneralASP)*/
  UInt32              fDefaultTickleInterval; /* ms, must be 30000, ignored by current versions of OT*/
  UInt8               fDefaultTickleRetries;  /* must be 8, ignored by current versions of OT*/
  UInt8               fDefaultReplies;        /* must be 8, ignored by current versions of OT*/
};
typedef struct OTCfgATalkGeneralASP     OTCfgATalkGeneralASP;


/*
   The OTCfgATalkGeneral structure is a conglomeration of the above structures
   and is used to access the kOTCfgATalkGeneralPref preference.
*/
struct OTCfgATalkGeneral {
  UInt16              fVersion;               /* must be 0*/
  UInt16              fNumPrefs;              /* must be 0*/
  UInt32              fPort;                  /* a reference to the port over which this configuration is running*/
  void *              fLink;                  /* run-time use only, must be nil*/
  void *              fPrefs[8];              /* run-time use only, initialise to nil*/
  OTCfgATalkGeneralAARP  aarpPrefs;
  OTCfgATalkGeneralDDP  ddpPrefs;
  OTCfgATalkGeneralNBP  nbpPrefs;
  OTCfgATalkGeneralZIP  zipPrefs;
  OTCfgATalkGeneralATP  atpPrefs;
  OTCfgATalkGeneralADSP  adspPrefs;
  OTCfgATalkGeneralPAP  papPrefs;
  OTCfgATalkGeneralASP  aspPrefs;
};
typedef struct OTCfgATalkGeneral        OTCfgATalkGeneral;


/*
   OTCfgATalkLocks determines which preferences have been
   locked by the administrator mode of the control panel.
*/
struct OTCfgATalkLocks {
  UInt16              fLocks;                 /* a bit field, see the definitions below*/
};
typedef struct OTCfgATalkLocks          OTCfgATalkLocks;

enum {
  kOTCfgATalkPortLockMask       = 0x01,
  kOTCfgATalkZoneLockMask       = 0x02,
  kOTCfgATalkAddressLockMask    = 0x04,
  kOTCfgATalkConnectionLockMask = 0x08,
  kOTCfgATalkSharingLockMask    = 0x10
};




/*
   OTCfgATalkPortDeviceType holds either the OT device type (eg kOTEthernetDevice)
   or an ADEV ID for the current port.  It is not used by the AppleTalk
   protocol stack, but it is used by the AppleTalk control panel.
*/
struct OTCfgATalkPortDeviceType {
  UInt16              fDeviceType;
};
typedef struct OTCfgATalkPortDeviceType OTCfgATalkPortDeviceType;


/*
   OTCfgATalkNetworkArchitecture is a vestigial remnent of the
   "Network Software Selector" in System 7.5.3 through 7.5.5.
*/
struct OTCfgATalkNetworkArchitecture {
  UInt32              fVersion;               /* must be 0*/
  OSType              fNetworkArchitecture;   /* must be 'OTOn'*/
};
typedef struct OTCfgATalkNetworkArchitecture OTCfgATalkNetworkArchitecture;
/* Masks for the kOTCfgProtocolOptionsPref preference.*/

enum {
  kOTCfgATalkNoBadRouterUpNotification = 1 << 0,
  kOTCfgATalkNoAllNodesTakenNotification = 1 << 1,
  kOTCfgATalkNoFixedNodeTakenNotification = 1 << 2,
  kOTCfgATalkNoInternetAvailableNotification = 1 << 3,
  kOTCfgATalkNoCableRangeChangeNotification = 1 << 4,
  kOTCfgATalkNoRouterDownNotification = 1 << 5,
  kOTCfgATalkNoRouterUpNotification = 1 << 6,
  kOTCfgATalkNoFixedNodeBadNotification = 1 << 7
};




/*  ------------------ Infrared ------------------  */



/* Per-connection preference types*/

enum {
  kOTCfgIRGeneralPref           = FOUR_CHAR_CODE('atpf') /* OTCfgIRGeneral*/
};

typedef UInt16 OTCfgIRPortSetting;
enum {
  kOTCfgIRIrDA                  = 0,
  kOTCfgIRIRTalk                = 1
};

struct OTCfgIRGeneral {
  UInt32              fVersion;               /* must be 0*/
  UInt32              fPortRef;               /* reference to IR port*/
  OTCfgIRPortSetting  fPortSetting;           /* IrDA or IRTalk, use constants defined above*/
  Boolean             fNotifyOnDisconnect;
  Boolean             fDisplayIRControlStrip;
};
typedef struct OTCfgIRGeneral           OTCfgIRGeneral;


/*  ------------------ TCP/IP (v4) ------------------   */



/* Per-connection preference types*/

enum {
  kOTCfgTCPInterfacesPref       = FOUR_CHAR_CODE('iitf'), /* OTCfgTCPInterfaces (packed)*/
  kOTCfgTCPDeviceTypePref       = FOUR_CHAR_CODE('dtyp'), /* UInt16 (device type)*/
  kOTCfgTCPRoutersListPref      = FOUR_CHAR_CODE('irte'), /* OTCfgTCPRoutersList*/
  kOTCfgTCPSearchListPref       = FOUR_CHAR_CODE('ihst'), /* OTCfgTCPSearchList (packed)*/
  kOTCfgTCPDNSServersListPref   = FOUR_CHAR_CODE('idns'), /* OTCfgTCPDNSServersList*/
  kOTCfgTCPSearchDomainsPref    = FOUR_CHAR_CODE('isdm'), /* OTCfgTCPSearchDomains*/
  kOTCfgTCPDHCPLeaseInfoPref    = FOUR_CHAR_CODE('dclt'), /* OTCfgTCPDHCPLeaseInfo*/
  kOTCfgTCPDHCPClientIDPref     = FOUR_CHAR_CODE('dcid'), /* DHCP client ID, Pascal string*/
  kOTCfgTCPUnloadAttrPref       = FOUR_CHAR_CODE('unld'), /* OTCfgTCPUnloadAttr*/
  kOTCfgTCPLocksPref            = FOUR_CHAR_CODE('stng'), /* OTCfgTCPLocks*/
  kOTCfgTCPPushBelowIPPref      = FOUR_CHAR_CODE('crpt'), /* single module to push below IP, Pascal string*/
  kOTCfgTCPPushBelowIPListPref  = FOUR_CHAR_CODE('blip') /* list of modules to push below IP (Mac OS 9.0 and higher), 'STR#' format*/
};


/*
   OTCfgTCPConfigMethod is used as a field of OTCfgTCPInterfacesUnpacked
   to denote how TCP/IP should acquire an address.
*/
typedef UInt8 OTCfgTCPConfigMethod;
enum {
  kOTCfgManualConfig            = 0,
  kOTCfgRARPConfig              = 1,
  kOTCfgBOOTPConfig             = 2,
  kOTCfgDHCPConfig              = 3,
  kOTCfgMacIPConfig             = 4
};


/*
   The OTCfgTCPInterfacesPacked structure holds information
   about the TCP/IP interfaces configured on the computer.
   IMPORTANT: You must pack this structure when writing it to the
   database and unpack it when reading it from the database.
    The OTCfgTCPInterfacesPacked structure is a complex case, consisting of 
    a fixed size structure, appended after a variable length string.
*/

/*  Use this macro to help access the movable part. */

#define OTCfgTCPInterfacesPackedPartPointer( h ) ( (OTCfgTCPInterfacesPackedPart*) &( (**( (OTCfgTCPInterfacesPacked**) h )).fAppleTalkZone[ (**( (OTCfgTCPInterfacesPacked**) h )).fAppleTalkZone[0] + 1 ] ) )

struct OTCfgTCPInterfacesPackedPart {
  UInt8               path[36];
  UInt8               module[32];
  UInt32              framing;
};
typedef struct OTCfgTCPInterfacesPackedPart OTCfgTCPInterfacesPackedPart;
/*
    This structure also contains an IP address and subnet mask that are not aligned on a four byte boundary.  
    In order to avoid compiler warnings, and the possibility of code that won't work, 
    these fields are defined here as four character arrays.  
    It is suggested that BlockMoveData be used to copy to and from a field of type InetHost.  
*/
struct OTCfgTCPInterfacesPacked {
  UInt16              fCount;
  UInt8               fConfigMethod;
  UInt8               fIPAddress[4];
  UInt8               fSubnetMask[4];
  UInt8               fAppleTalkZone[256];
  UInt8               part[72];
};
typedef struct OTCfgTCPInterfacesPacked OTCfgTCPInterfacesPacked;
/*
   The OTCfgTCPInterfacesUnpacked structure holds information
   about the TCP/IP interfaces configured on the computer.
   IMPORTANT: You must pack this structure when writing it to the
   database and unpack it when reading it from the database.
*/
struct OTCfgTCPInterfacesUnpacked {
  UInt16              fCount;                 /* always 1 in current versions of OT*/
  UInt8               pad1;                   /* remove this pad byte when packing*/
  OTCfgTCPConfigMethod  fConfigMethod;
  UInt32              fIPAddress;
  UInt32              fSubnetMask;
  Str32               fAppleTalkZone;         /* remove bytes beyond end of string when packing*/
  UInt8               pad2;                   /* remove this pad byte when packing*/
  UInt8               path[36];
  UInt8               module[32];
  UInt32              framing;
};
typedef struct OTCfgTCPInterfacesUnpacked OTCfgTCPInterfacesUnpacked;


/*
   The OTCfgTCPRoutersListEntry structure is an array element
   in the OTCfgTCPRoutersList preference.
*/
struct OTCfgTCPRoutersListEntry {
  UInt32              fToHost;                /*    must be 0*/
  UInt32              fViaHost;               /*    router address*/
  UInt16              fLocal;                 /*    must be 0*/
  UInt16              fHost;                  /*    must be 0*/
};
typedef struct OTCfgTCPRoutersListEntry OTCfgTCPRoutersListEntry;


/*
   The OTCfgTCPRoutersList preferences is used to hold the
   configured list of routers.
*/
struct OTCfgTCPRoutersList {
  UInt16              fCount;
  OTCfgTCPRoutersListEntry  fList[1];
};
typedef struct OTCfgTCPRoutersList      OTCfgTCPRoutersList;
/*
   The OTCfgTCPSearchList preference holds some basic information
   about the DNS configuration.
   IMPORTANT: You must pack this structure when writing it to the
   database and unpack it when reading it from the database.
*/
struct OTCfgTCPSearchList {
  UInt8               fPrimaryInterfaceIndex; /* always 1 in current versions of OT*/
  UInt8               pad0;                   /* required by Interfacer*/
  Str255              fLocalDomainName;       /* in the file, these strings are packed*/
  Str255              fAdmindomain;
};
typedef struct OTCfgTCPSearchList       OTCfgTCPSearchList;


/*
   The OTCfgTCPDNSServersList preference holds the configured
   list of name servers.
*/
struct OTCfgTCPDNSServersList {
  UInt16              fCount;
  UInt32              fAddressesList[1];
};
typedef struct OTCfgTCPDNSServersList   OTCfgTCPDNSServersList;


/*
   The OTCfgTCPSearchDomains preference holds the configured
   list additional search domains.
   IMPORTANT: This preference is actually stored in string list
   format, ie the same format as a 'STR#' resource.
*/
struct OTCfgTCPSearchDomains {
  UInt16              fCount;
  Str255              fFirstSearchDomains;    /* subsequent search domains are packed after this one*/
};
typedef struct OTCfgTCPSearchDomains    OTCfgTCPSearchDomains;


/*
   The OTCfgTCPDHCPLeaseInfo preference holds information about
   the DHCP lease.
*/
struct OTCfgTCPDHCPLeaseInfo {
  UInt32              ipIPAddr;
  UInt32              ipConfigServer;
  UInt32              ipLeaseGrantTime;
  UInt32              ipLeaseExpirationTime;
};
typedef struct OTCfgTCPDHCPLeaseInfo    OTCfgTCPDHCPLeaseInfo;


/*
   The OTCfgTCPUnloadAttr preference determines whether TCP/IP is
   active or inactive and, if active, whether it will
   unload after 2 minutes of inactivity.
*/
typedef UInt16 OTCfgTCPUnloadAttr;
enum {
  kOTCfgTCPActiveLoadedOnDemand = 1,
  kOTCfgTCPActiveAlwaysLoaded   = 2,
  kOTCfgTCPInactive             = 3
};




/*
   OTCfgTCPLocks determines which preferences have been
   locked by the administrator mode of the control panel.
   
   IMPORTANT: This structure has an odd size.  See notes below.
*/
struct OTCfgTCPLocks {
  UInt8               pad1;                   /* Set this and all other pad fields to 0.*/
  UInt8               lockConnectViaPopup;
  UInt8               pad2;
  UInt8               lockConfigurePopup;
  UInt8               pad3;
  UInt8               lockAppleTalkZone;
  UInt8               pad4;
  UInt8               lockIPAddress;
  UInt8               pad5;
  UInt8               lockLocalDomainName;
  UInt8               pad6;
  UInt8               lockSubnetMask;
  UInt8               pad7;
  UInt8               lockRoutersList;
  UInt8               pad8;
  UInt8               lockDNSServersList;
  UInt8               pad9;
  UInt8               lockAdminDomainName;
  UInt8               pad10;
  UInt8               lockSearchDomains;
  UInt8               pad11;
  UInt8               lockUnknown;
  UInt8               pad12;
  UInt8               lock8023;
  UInt8               pad13;
  UInt8               lockDHCPClientID;       /* this field added in OT 2.0*/
  UInt8               pad14;                  /* this field added in OT 2.0*/
};
typedef struct OTCfgTCPLocks            OTCfgTCPLocks;
/*
   The OTCfgTCPLocks preference has an odd size, either 25 or
   27 bytes depending on the verson on OT.  It is impossible
   to represent an odd size structure in 68K aligned C structures,
   because the compiler always pads structures to an even size.
   So, when reading and writing this preference you should use one
   of the constants defined below.
*/
enum {
  kOTCfgTCPLocksPrefPre2_0Size  = 25,
  kOTCfgTCPLocksPref2_0Size     = 27,
  kOTCfgTCPLocksPrefCurrentSize = kOTCfgTCPLocksPref2_0Size
};


/* Masks for the kOTCfgProtocolOptionsPref preference.*/

enum {
  kOTCfgDontDoPMTUDiscoveryMask = 0x0001, /* Turns off Path MTU Discovery*/
  kOTCfgDontShutDownOnARPCollisionMask = 0x0002, /* To be able to Disable ARP Collision ShutDown */
  kOTCfgDHCPInformMask          = 0x0004, /* Enables DHCPINFORM instead of DHCPREQUEST*/
  kOTCfgOversizeOffNetPacketsMask = 0x0008, /* With PMTU off, don't limit off-net packet to 576 bytes*/
  kOTCfgDHCPDontPreserveLeaseMask = 0x0010 /* Turns off DHCP INIT-REBOOT capability.*/
};



/*  ------------------ DNS ------------------   */



/* Per-connection preference types*/

enum {
  kOTCfgTypeDNSidns             = FOUR_CHAR_CODE('idns'),
  kOTCfgTypeDNSisdm             = FOUR_CHAR_CODE('isdm'),
  kOTCfgTypeDNSihst             = FOUR_CHAR_CODE('ihst'),
  kOTCfgTypeDNSstng             = FOUR_CHAR_CODE('stng')
};



/*  ------------------ Modem ------------------ */



/* Per-connection preference types*/

enum {
  kOTCfgModemGeneralPrefs       = FOUR_CHAR_CODE('ccl '), /* OTCfgModemGeneral*/
  kOTCfgModemLocksPref          = FOUR_CHAR_CODE('lkmd'), /* OTCfgModemLocks*/
  kOTCfgModemAdminPasswordPref  = FOUR_CHAR_CODE('mdpw') /* not to be documented*/
};


/* Global preference types*/

enum {
  kOTCfgModemApplicationPref    = FOUR_CHAR_CODE('mapt') /* OTCfgModemApplication*/
};


/*
   OTCfgModemDialogToneMode specifies the handling of the dial
   tone within a OTCfgModemGeneral preference.
*/
typedef UInt32 OTCfgModemDialogToneMode;
enum {
  kOTCfgModemDialToneNormal     = 0,
  kOTCfgModemDialToneIgnore     = 1,
  kOTCfgModemDialToneManual     = 2
};




/*
   The OTCfgModemGeneral preference holds the important
   per-connection preferences for Modem.
*/
struct OTCfgModemGeneral {
  UInt32              version;                /* see "Remote Access Versions" note, below*/
  Boolean             useModemScript;         /* whether to use a modem script, must be true*/
  UInt8               pad;                    /* must be 0*/
  FSSpec              modemScript;            /* the modem script (CCL) to use*/
  Boolean             modemSpeakerOn;         /* whether to dial with the speaker on*/
  Boolean             modemPulseDial;         /* true if pulse dial, false if tone dial*/
  OTCfgModemDialogToneMode  modemDialToneMode; /* constants are given above*/
  char                lowerLayerName[36];     /* C string, name of underlying serial port*/
};
typedef struct OTCfgModemGeneral        OTCfgModemGeneral;


/*
   OTCfgModemLocks determines which preferences have been
   locked by the administrator mode of the control panel.
*/
struct OTCfgModemLocks {
  UInt32              version;                /* must be 1*/
  UInt32              port;                   /* the underlying serial port is locked (1) or not locked (0)*/
  UInt32              script;                 /* the modem script (CCL) is locked (1) or not locked (0)*/
  UInt32              speaker;                /* the speaker settings are locked (1) or not locked (0)*/
  UInt32              dialing;                /* the pulse/tone dial setting is locked (1) or not locked (0)*/
};
typedef struct OTCfgModemLocks          OTCfgModemLocks;


/* Preferences for the modem application itself.*/
struct OTCfgModemApplication {
  UInt32              version;                /* must be 1*/
  Point               windowPos;              /* global coordinates, window position*/
  OTCfgUserMode32     userMode;               /* must be kOTCfgBasicUserMode, Modem control panel has no "advance" mode*/
};
typedef struct OTCfgModemApplication    OTCfgModemApplication;


/*  ------------------ Remote Access ------------------ */



/*
    Remote Access Versions
    ----------------------
    Many Remote Access preferences include a version number.  Depending
    on how the preferences were constructed, the version might either
    be kOTCfgRemoteDefaultVersion or kOTCfgRemoteAcceptedVersion.  It
    turns out that Remote Access doesn't actually check the version,
    so both versions work equally well.  However, you should abide by
    the following rules:
    
      o When reading the version number field, accept both
        kOTCfgRemoteDefaultVersion and kOTCfgRemoteAcceptedVersion.
      o When writing the version number field, write kOTCfgRemoteDefaultVersion.
*/
enum {
  kOTCfgRemoteDefaultVersion    = 0x00020003,
  kOTCfgRemoteAcceptedVersion   = 0x00010000
};


/* Per-connection preference types*/

enum {
  kOTCfgRemoteARAPPref          = FOUR_CHAR_CODE('arap'), /* OTCfgRemoteARAP*/
  kOTCfgRemoteAddressPref       = FOUR_CHAR_CODE('cadr'), /* 'TEXT' format, max 255 characters, see also OTCfgRemoteConnect*/
  kOTCfgRemoteChatPref          = FOUR_CHAR_CODE('ccha'), /* 'TEXT', see also OTCfgRemoteConnect*/
  kOTCfgRemoteDialingPref       = FOUR_CHAR_CODE('cdia'), /* OTCfgRemoteDialing*/
  kOTCfgRemoteAlternateAddressPref = FOUR_CHAR_CODE('cead'), /* OTCfgRemoteAlternateAddress*/
  kOTCfgRemoteClientLocksPref   = FOUR_CHAR_CODE('clks'), /* OTCfgRemoteClientLocks*/
  kOTCfgRemoteClientMiscPref    = FOUR_CHAR_CODE('cmsc'), /* OTCfgRemoteClientMisc*/
  kOTCfgRemoteConnectPref       = FOUR_CHAR_CODE('conn'), /* OTCfgRemoteConnect*/
  kOTCfgRemoteUserPref          = FOUR_CHAR_CODE('cusr'), /* user name, Pascal string*/
  kOTCfgRemoteDialAssistPref    = FOUR_CHAR_CODE('dass'), /* OTCfgRemoteDialAssist*/
  kOTCfgRemoteIPCPPref          = FOUR_CHAR_CODE('ipcp'), /* OTCfgRemoteIPCP*/
  kOTCfgRemoteLCPPref           = FOUR_CHAR_CODE('lcp '), /* OTCfgRemoteLCP*/
  kOTCfgRemoteLogOptionsPref    = FOUR_CHAR_CODE('logo'), /* OTCfgRemoteLogOptions*/
  kOTCfgRemotePasswordPref      = FOUR_CHAR_CODE('pass'), /* OTCfgRemotePassword*/
  kOTCfgRemoteTerminalPref      = FOUR_CHAR_CODE('term'), /* OTCfgRemoteTerminal*/
  kOTCfgRemoteUserModePref      = FOUR_CHAR_CODE('usmd'), /* OTCfgRemoteUserMode*/
  kOTCfgRemoteSecurityDataPref  = FOUR_CHAR_CODE('csec'), /* untyped data for external security modules*/
  kOTCfgRemoteX25Pref           = FOUR_CHAR_CODE('x25 ') /* OTCfgRemoteX25*/
};


/* Global preference types*/

enum {
  kOTCfgRemoteServerPortPref    = FOUR_CHAR_CODE('port'), /* OTCfgRemoteServerPort*/
  kOTCfgRemoteServerPref        = FOUR_CHAR_CODE('srvr'), /* OTCfgRemoteServer*/
  kOTCfgRemoteApplicationPref   = FOUR_CHAR_CODE('capt') /* OTCfgRemoteApplication*/
};




/*
   The OTCfgRemoteARAP preference holds connection information
   for the ARAP protocol modules.
   Also used as part of a Remote Access server configuration.
*/
struct OTCfgRemoteARAP {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  char                lowerLayerName[36];     /* C string, name of underlying modem port, must be "Script"*/
};
typedef struct OTCfgRemoteARAP          OTCfgRemoteARAP;


/*
   OTCfgRemoteRedialMode specifies the handling of redial
   within a OTCfgRemoteDialing preference.
*/
typedef UInt32 OTCfgRemoteRedialMode;
enum {
  kOTCfgRemoteRedialNone        = 2,
  kOTCfgRemoteRedialMain        = 3,
  kOTCfgRemoteRedialMainAndAlternate = 4
};




/*
   The OTCfgRemoteDialing controls the dialing characteristics
   of outgoing connections.
*/
struct OTCfgRemoteDialing {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  UInt32              fType;                  /* must be 'dial'*/
  UInt32              additionalPtr;          /* must be 0*/
  OTCfgRemoteRedialMode  dialMode;            /* constants are given above*/
  UInt32              redialTries;            /* only valid if dialMode != kOTCfgRemoteRedialNone*/
  UInt32              redialDelay;            /* ms, only valid if dialMode != kOTCfgRemoteRedialNone*/
  UInt32              pad;                    /* must be zero*/
};
typedef struct OTCfgRemoteDialing       OTCfgRemoteDialing;


/*
   The OTCfgRemoteAlternateAddress holds the alternate phone number
   to dial if the dialMode field of the OTCfgRemoteDialing 
   preference is kOTCfgRemoteRedialMainAndAlternate.
*/
struct OTCfgRemoteAlternateAddress {
  UInt32              pad;                    /* must be zero*/
  Str255              alternateAddress;
};
typedef struct OTCfgRemoteAlternateAddress OTCfgRemoteAlternateAddress;


/*
   OTCfgRemoteClientLocks determines which preferences have been
   locked by the administrator mode of the control panel.
*/
struct OTCfgRemoteClientLocks {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  UInt32              name;                   /* "Name" field is locked (1) or unlocked (0)*/
  UInt32              password;               /* "Password" field is locked (1) or unlocked (0)*/
  UInt32              number;                 /* "Number" field is locked (1) or unlocked (0)*/
  UInt32              errorCheck;             /* "Allow error correction and compression in modem" checkbox is locked (1) or unlocked (0)*/
  UInt32              headerCompress;         /* "Use TCP header compression" checkbox is locked (1) or unlocked (0)*/
  UInt32              termWindow;             /* "Connect to a command-line host" options are locked (1) or unlocked (0)*/
  UInt32              reminder;               /* "Reminders" options are locked (1) or unlocked (0)*/
  UInt32              autoConn;               /* "Connect automatically when starting TCP/IP applications" checkbox is locked (1) or unlocked (0)*/
  UInt32              redial;                 /* "Redialing" panel is locked (1) or unlocked (0)*/
  UInt32              useProtocolLock;        /* "Use protocol" popup is locked (1) or unlocked (0)*/
  UInt32              useVerboseLogLock;      /* "Use verbose logging" checkbox is locked (1) or unlocked (0)*/
  UInt32              regUserOrGuestLock;     /* "Register User"/"Guest" radio buttons are locked (1) or unlocked (0)*/
  UInt32              dialAssistLock;         /* "Use DialAssist" checkbox is locked (1) or unlocked (0)*/
  UInt32              savePasswordLock;       /* "Save password" checkbox is locked (1) or unlocked (0)*/
  UInt32              useOpenStatusAppLock;   /* "Open Status Application" checkbox is locked (1) or unlocked (0)*/
  UInt32              reserved[1];            /* must be 0*/
};
typedef struct OTCfgRemoteClientLocks   OTCfgRemoteClientLocks;


/*
   The OTCfgRemoteClientMisc preference holds, as you might guess,
   one miscellaneous preference.
*/
struct OTCfgRemoteClientMisc {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  UInt32              connectAutomatically;   /* connect automatically when starting TCP/IP applications (1), or not (0)*/
};
typedef struct OTCfgRemoteClientMisc    OTCfgRemoteClientMisc;


/* The following types are used by the OTCfgRemoteConnect preference.*/
typedef UInt32 OTCfgRemotePPPConnectScript;
enum {
  kOTCfgRemotePPPConnectScriptNone = 0, /* no chat script*/
  kOTCfgRemotePPPConnectScriptTerminalWindow = 1, /* use a terminal window*/
  kOTCfgRemotePPPConnectScriptScript = 2 /* use save chat script (OTCfgRemoteChat)*/
};

typedef UInt32 OTCfgRemoteProtocol;
enum {
  kOTCfgRemoteProtocolPPP       = 1,    /* PPP only*/
  kOTCfgRemoteProtocolARAP      = 2,    /* ARAP only*/
  kOTCfgRemoteProtocolAuto      = 3     /* auto-detect PPP or ARAP (not support in ARA 3.5 and above)*/
};




/*
   The OTCfgRemoteConnect holds the core connection information
   for a Remote Access configuration.
*/
struct OTCfgRemoteConnect {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  UInt32              fType;                  /* must be 0*/
  UInt32              isGuest;                /* registered user (0) or guest (1) login*/
  UInt32              canInteract;            /* must be 1*/
  UInt32              showStatus;             /* must be 0*/
  UInt32              passwordSaved;          /* use saved password (1) or not (0)*/
  UInt32              flashConnectedIcon;     /* flash menu bar reminder icon (1) or not (0)*/
  UInt32              issueConnectedReminders; /* issue Notification Manager reminders (1) or not (0)*/
  SInt32              reminderMinutes;        /* minutes, time between each reminder*/
  UInt32              connectManually;        /* must be 0*/
  UInt32              allowModemDataCompression; /* allow modem data compression (1) or not (0), only valid for PPP connections*/
  OTCfgRemotePPPConnectScript  chatMode;      /* constants are given above*/
  OTCfgRemoteProtocol  serialProtocolMode;    /* constants are given above*/
  UInt32              passwordPtr;            /* run-time use only, initialise to 0, read ignore & preserve*/
  UInt32              userNamePtr;            /* run-time use only, initialise to 0, read ignore & preserve*/
  UInt32              addressLength;          /* length of phone number (OTCfgRemoteAddress)*/
  UInt32              addressPtr;             /* run-time use only, initialise to 0, read ignore & preserve*/
  Str63               chatScriptName;         /* user-visible name of chat script*/
  UInt32              chatScriptLength;       /* length of chat script (OTCfgRemoteChat)*/
  UInt32              chatScriptPtr;          /* run-time use only, initialise to 0, read ignore & preserve*/
  UInt32              additional;             /* run-time use only, initialise to 0, read ignore & preserve*/
  UInt32              useSecurityModule;      /* must be 0*/
  OSType              securitySignature;      /* must be 0*/
  UInt32              securityDataLength;     /* must be 0*/
  UInt32              securityDataPtr;        /* must be 0*/
};
typedef struct OTCfgRemoteConnect       OTCfgRemoteConnect;


/* OTCfgRemoteDialAssist*/
struct OTCfgRemoteDialAssist {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  UInt32              isAssisted;             /* 0 for no assist (default), 1 for assist*/
  Str31               areaCodeStr;
  Str31               countryCodeStr;
};
typedef struct OTCfgRemoteDialAssist    OTCfgRemoteDialAssist;


/*
   The OTCfgRemoteIPCP preference holds configuration information
   for the Internet Protocol Control Protocol (IPCP) layer of PPP.
   The contents of this record only make sense for PPP connections
   and are ignored for ARAP connections.
   Also used as part of a Remote Access server configuration.
*/
struct OTCfgRemoteIPCP {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  UInt32              reserved[2];            /* must be 0*/
  UInt32              maxConfig;              /* must be 10*/
  UInt32              maxTerminate;           /* must be 10*/
  UInt32              maxFailureLocal;        /* must be 10*/
  UInt32              maxFailureRemote;       /* must be 10*/
  UInt32              timerPeriod;            /* ms, must be 10000*/
  UInt32              localIPAddress;         /* must be 0*/
  UInt32              remoteIPAddress;        /* must be 0*/
  UInt32              allowAddressNegotiation; /* must be 1*/
  UInt16              idleTimerEnabled;       /* disconnect if line idle (1) or not (0)*/
  UInt16              compressTCPHeaders;     /* Van Jacobsen header compression allowed (1) or not (0)*/
  UInt32              idleTimerMilliseconds;  /* ms, if idleTimerEnabled, disconnect if idle for*/
};
typedef struct OTCfgRemoteIPCP          OTCfgRemoteIPCP;


/*
   The OTCfgRemoteLCP preference holds configuration information
   for the Link Control Protocol (LCP) layer of PPP.  The contents
   of this record only make sense for PPP connections and are
   ignored for ARAP connections.
   Also used as part of a Remote Access server configuration.
*/
struct OTCfgRemoteLCP {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  UInt32              reserved[2];            /* must be 0*/
  char                lowerLayerName[36];     /* C string, name of underlying modem port, must be "Script"*/
  UInt32              maxConfig;              /* must be 10*/
  UInt32              maxTerminate;           /* must be 10*/
  UInt32              maxFailureLocal;        /* must be 10*/
  UInt32              maxFailureRemote;       /* must be 10*/
  UInt32              timerPeriod;            /* ms, must be 10000*/
  UInt32              echoTrigger;            /* ms, must be 10000*/
  UInt32              echoTimeout;            /* ms, must be 10000*/
  UInt32              echoRetries;            /* 5*/
  UInt32              compressionType;        /* 3*/
  UInt32              mruSize;                /* must be 1500*/
  UInt32              upperMRULimit;          /* must be 4500*/
  UInt32              lowerMRULimit;          /* must be 0*/
  UInt32              txACCMap;               /* must be 0       */
  UInt32              rcACCMap;               /* must be 0*/
  UInt32              isNoLAPB;               /* must be 0*/
};
typedef struct OTCfgRemoteLCP           OTCfgRemoteLCP;


/* OTCfgRemoteLogLevel is used as a field in OTCfgRemoteLogOptions.*/
typedef UInt32 OTCfgRemoteLogLevel;
enum {
  kOTCfgRemoteLogLevelNormal    = 0,
  kOTCfgRemoteLogLevelVerbose   = 1
};




/*
   The OTCfgRemoteLogOptions preference controls the level
   of logging done by ARA.
*/
struct OTCfgRemoteLogOptions {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  OSType              fType;                  /* must be 'lgop'*/
  UInt32              additionalPtr;          /* run-time use only, initialise to 0, read ignore & preserve*/
  OTCfgRemoteLogLevel  logLevel;              /* constants are given above*/
  UInt32              launchStatusApp;        /* 0 for not launch, 1 for launch, Remote Access 3.5 and higher */
  UInt32              reserved[3];            /* must be zero*/
};
typedef struct OTCfgRemoteLogOptions    OTCfgRemoteLogOptions;


/*
   OTCfgRemotePassword holds the user's dialup password, in a scrambled
   form.  You can use OTCfgEncrypt to scramble a password and OTCfgDecrypt
   to descramble it.
*/
struct OTCfgRemotePassword {
  UInt8               data[256];
};
typedef struct OTCfgRemotePassword      OTCfgRemotePassword;


/* OTCfgRemoteTerminal holds preferences used by the PPP terminal window.*/
struct OTCfgRemoteTerminal {
  UInt32              fVersion;               /* must be 1*/
  Boolean             fLocalEcho;             /* whether to echo typed characters, default false*/
  Boolean             fNonModal;              /* must be false*/
  Boolean             fPowerUser;             /* must be false*/
  Boolean             fQuitWhenPPPStarts;     /* as set in the options dialog, default true*/
  Boolean             fDontAskVarStr;         /* default false*/
  Boolean             fNoVarStrReplace;       /* must be false*/
  Boolean             fLFAfterCR;             /* must be false*/
  Boolean             fAskToSaveOnQuit;       /* as set in the options dialog, default false*/
  Rect                fWindowRect;            /* must be zero*/
  Style               fTypedCharStyle;        /* style used for characters type,    default to bold   (2)*/
  Style               fPrintedCharStyle;      /* style used for characters printed, default to normal (0)*/
  Style               fEchoedCharStyle;       /* style used for characters echoed,  default to italic (1)*/
  UInt8               pad;                    /* must be zero*/
  SInt16              fFontSize;              /* default is 9*/
  Str255              fFontName;              /* default is "\pMonaco" on Roman systems*/
};
typedef struct OTCfgRemoteTerminal      OTCfgRemoteTerminal;


/*
   The OTCfgRemoteUserMode holds user mode preferences, such
   as the current user mode and the admin password.
*/

struct OTCfgRemoteUserMode {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  OTCfgUserMode32     userMode;               /* current user mode*/
  Str255              adminPassword;          /* format not to be documented*/
};
typedef struct OTCfgRemoteUserMode      OTCfgRemoteUserMode;


/*
   The OTCfgRemoteX25 preference is used to hold information
   about X.25 connections.  For standard dial-up connections,
   all fields (except version) must be filled with zeroes.
*/
struct OTCfgRemoteX25 {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  UInt32              fType;                  /* this and remaining fields must be 0*/
  UInt32              additionalPtr;
  FSSpec              script;
  UInt8               address[256];
  UInt8               userName[256];
  UInt8               closedUserGroup[5];
  Boolean             reverseCharge;
};
typedef struct OTCfgRemoteX25           OTCfgRemoteX25;



/*
   OTCfgRemoteServer is a meta-preference that points to the other active
   preferences for the Remote Access server.
*/
struct OTCfgRemoteServer {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  SInt16              configCount;            /* number of active configurations, must be 1 for personal server*/
  SInt16              configIDs[1];           /* array of IDs of active configurations, must have one entry containing 0 for personal server*/
};
typedef struct OTCfgRemoteServer        OTCfgRemoteServer;


/* The following types are used in the OTCfgRemoteServerPort preference.*/
typedef UInt32 OTCfgRemoteAnswerMode;
enum {
  kOTCfgAnswerModeOff           = 0,    /* answering disabled*/
  kOTCfgAnswerModeNormal        = 1,    /* answering enabled*/
  kOTCfgAnswerModeTransfer      = 2,    /* answering as a callback server, not valid for personal server*/
  kOTCfgAnswerModeCallback      = 3     /* answering enabled in callback mode*/
};

typedef UInt32 OTCfgRemoteNetworkProtocol;
enum {
  kOTCfgNetProtoNone            = 0,
  kOTCfgNetProtoIP              = 1,    /* allow IPCP connections*/
  kOTCfgNetProtoAT              = 2,    /* allow AppleTalk connections (ATCP, ARAP)*/
  kOTCfgNetProtoAny             = (kOTCfgNetProtoIP | kOTCfgNetProtoAT) /* allow connections of either type*/
};

typedef UInt8 OTCfgRemoteNetAccessMode;
enum {
  kOTCfgNetAccessModeUnrestricted = 0,  /* connected client can see things on server and things on server's network*/
  kOTCfgNetAccessModeThisMacOnly = 1    /* connected client can only see things on server machine*/
};




/*
   OTCfgRemoteServerPort holds the primary configuration information for
   the personal server.
*/
struct OTCfgRemoteServerPort {
  UInt32              version;                /* see "Remote Access Versions" note, above*/
  SInt16              configID;               /* ID of this port config, matches element of configIDs array in OTCfgRemoteServer, must be 0 for personal server*/
  Str255              password;               /* security zone bypass password, plain text*/
  OTCfgRemoteAnswerMode  answerMode;          /* see values defined above*/
  Boolean             limitConnectTime;       /* if true, following field limits duration of client connections*/
  UInt8               pad;                    /* must be 0*/
  UInt32              maxConnectSeconds;      /* seconds, default is 3600*/
  OTCfgRemoteProtocol  serialProtoFlags;      /* see values defined above*/
  OTCfgRemoteNetworkProtocol  networkProtoFlags; /* see values defined above*/
  OTCfgRemoteNetAccessMode  netAccessMode;    /* see values defined above*/
  Boolean             requiresCCL;            /* must be true*/
  char                portName[64];           /* C string, must be zero for personal server*/
  char                serialLayerName[36];    /* C string, OT port name of serial port*/
  UInt32              localIPAddress;         /* IP address to offer to client*/
};
typedef struct OTCfgRemoteServerPort    OTCfgRemoteServerPort;


/*
   The OTCfgRemoteApplication preference holds preferences for the
   Remote Access (or OT/PPP) application.
*/
struct OTCfgRemoteApplication {
  UInt32              version;                /* IMPORTANT: NOT a standard Remote Access version number, must be 3 for ARA, 1 for OT/PPP*/
  Point               fWindowPosition;        /* global coordinates, window position*/
  UInt32              tabChoice;              /* currently chosen tab in Options dialog, 1 for Redialing, 2 for Connection, 3 for Protocol*/
  OTCfgUserMode32     fUserMode;              /* current user mode*/
  UInt32              fSetupVisible;          /* "Setup" is disclosed (1) or not (0)*/
};
typedef struct OTCfgRemoteApplication   OTCfgRemoteApplication;


/*  ------------------ OLDROUTINENAMES ------------------   */



/*
   Older versions of this header file defined a lot of types and constants
   that were inconsistently named and confusing.  This new version of the header
   file has tidied up all of these definitions, as shown above.  For the
   sake of source code compatibility, the previous definitions are still available,
   but you have to define the compiler variable OLDROUTINENAMES to get them.
   This is a temporary measure.  Apple will remove these definitions in a future
   version of this header file.  You should start transitioning your source code
   to the new definitions are soon as possible.
*/

#if OLDROUTINENAMES
enum {
  kOTCfgTypeStruct              = kOTCfgSetsStructPref,
  kOTCfgTypeElement             = kOTCfgSetsElementPref,
  kOTCfgTypeVector              = kOTCfgSetsVectorPref
};

/* OLDROUTINENAMES*/

/* Old, confusing names for common preference types.*/

enum {
  kOTCfgTypeConfigName          = kOTCfgCompatNamePref,
  kOTCfgTypeConfigSelected      = kOTCfgCompatSelectedPref,
  kOTCfgTypeUserLevel           = kOTCfgUserModePref,
  kOTCfgTypeWindowPosition      = kOTCfgPrefWindowPositionPref
};

/* OLDROUTINENAMES*/

/*
   Old, protocol-specific names for common preferences.  If the preference
   is still supported, the old name is just an alias for the new name.
   If the preference isn't support, the old name is a straight constant,
   and you should stop using it.
*/

enum {
  kOTCfgTypeAppleTalkVersion    = kOTCfgVersionPref,
  kOTCfgTypeTCPcvrs             = kOTCfgVersionPref,
  kOTCfgTypeTCPVersion          = kOTCfgVersionPref,
  kOTCfgTypeTCPPort             = kOTCfgPortUserVisibleNamePref,
  kOTCfgTypeAppleTalkPort       = kOTCfgPortUserVisibleNamePref,
  kOTCfgTypeTCPProtocol         = kOTCfgProtocolUserVisibleNamePref,
  kOTCfgTypeAppleTalkProtocol   = kOTCfgProtocolUserVisibleNamePref,
  kOTCfgTypeAppleTalkPassword   = kOTCfgAdminPasswordPref,
  kOTCfgTypeDNSPassword         = kOTCfgAdminPasswordPref,
  kOTCfgTypeTCPPassword         = kOTCfgAdminPasswordPref,
  kOTCfgTypeRemoteARAP          = kOTCfgRemoteARAPPref,
  kOTCfgTypeRemoteAddress       = kOTCfgRemoteAddressPref,
  kOTCfgTypeRemoteChat          = kOTCfgRemoteChatPref,
  kOTCfgTypeRemoteDialing       = kOTCfgRemoteDialingPref,
  kOTCfgTypeRemoteExtAddress    = kOTCfgRemoteAlternateAddressPref,
  kOTCfgTypeRemoteClientLocks   = kOTCfgRemoteClientLocksPref,
  kOTCfgTypeRemoteClientMisc    = kOTCfgRemoteClientMiscPref,
  kOTCfgTypeRemoteConnect       = kOTCfgRemoteConnectPref,
  kOTCfgTypeRemoteUser          = kOTCfgRemoteUserPref,
  kOTCfgTypeRemoteDialAssist    = kOTCfgRemoteDialAssistPref,
  kOTCfgTypeRemoteIPCP          = kOTCfgRemoteIPCPPref,
  kOTCfgTypeRemoteLCP           = kOTCfgRemoteLCPPref,
  kOTCfgTypeRemoteLogOptions    = kOTCfgRemoteLogOptionsPref,
  kOTCfgTypeRemotePassword      = kOTCfgRemotePasswordPref,
  kOTCfgTypeRemoteServer        = kOTCfgRemoteServerPref,
  kOTCfgTypeRemoteTerminal      = kOTCfgRemoteTerminalPref,
  kOTCfgTypeRemoteUserMode      = kOTCfgRemoteUserModePref,
  kOTCfgTypeRemoteX25           = kOTCfgRemoteX25Pref,
  kOTCfgTypeRemoteApp           = kOTCfgRemoteApplicationPref,
  kOTCfgTypeRemotePort          = kOTCfgRemoteServerPortPref,
  kOTCfgTypeAppleTalkPrefs      = kOTCfgATalkGeneralPref,
  kOTCfgTypeAppleTalkLocks      = kOTCfgATalkLocksPref,
  kOTCfgTypeAppleTalkPortFamily = kOTCfgATalkPortDeviceTypePref,
  kOTCfgTypeInfraredPrefs       = kOTCfgIRGeneralPref,
  kOTCfgTypeInfraredGlobal      = FOUR_CHAR_CODE('irgo'),
  kOTCfgTypeTCPdclt             = kOTCfgTCPDHCPLeaseInfoPref,
  kOTCfgTypeTCPSearchList       = kOTCfgTCPSearchListPref,
  kOTCfgTypeTCPihst             = kOTCfgTCPSearchListPref,
  kOTCfgTypeTCPidns             = kOTCfgTCPDNSServersListPref,
  kOTCfgTypeTCPServersList      = kOTCfgTCPDNSServersListPref,
  kOTCfgTypeTCPiitf             = kOTCfgTCPInterfacesPref,
  kOTCfgTypeTCPPrefs            = kOTCfgTCPInterfacesPref,
  kOTCfgTypeTCPisdm             = kOTCfgTCPSearchDomainsPref,
  kOTCfgTypeTCPDomainsList      = kOTCfgTCPSearchDomainsPref,
  kOTCfgTypeTCPdcid             = kOTCfgTCPDHCPClientIDPref,
  kOTCfgTypeTCPdtyp             = kOTCfgTCPDeviceTypePref,
  kOTCfgTypeTCPRoutersList      = kOTCfgTCPRoutersListPref,
  kOTCfgTypeTCPirte             = kOTCfgTCPRoutersListPref,
  kOTCfgTypeTCPstng             = kOTCfgTCPLocksPref,
  kOTCfgTypeTCPLocks            = kOTCfgTCPLocksPref,
  kOTCfgTypeTCPunld             = kOTCfgTCPUnloadAttrPref,
  kOTCfgTypeTCPUnloadType       = kOTCfgTCPUnloadAttrPref,
  kOTCfgTypeTCPalis             = FOUR_CHAR_CODE('alis'),
  kOTCfgTypeTCPara              = FOUR_CHAR_CODE('ipcp'), /* defining this as 'ipcp' makes no sense,*/
                                        /* but changing it to kOTCfgRemoteIPCPPref could break someone*/
  kOTCfgTypeTCPDevType          = FOUR_CHAR_CODE('dvty'),
  kOTCfgTypeModemModem          = kOTCfgModemGeneralPrefs,
  kOTCfgTypeModemLocks          = kOTCfgModemLocksPref,
  kOTCfgTypeModemAdminPswd      = kOTCfgModemAdminPasswordPref,
  kOTCfgTypeModemApp            = kOTCfgModemApplicationPref
};

/* OLDROUTINENAMES*/

enum {
  kOTCfgIndexAppleTalkAARP      = 0,
  kOTCfgIndexAppleTalkDDP       = 1,
  kOTCfgIndexAppleTalkNBP       = 2,
  kOTCfgIndexAppleTalkZIP       = 3,
  kOTCfgIndexAppleTalkATP       = 4,
  kOTCfgIndexAppleTalkADSP      = 5,
  kOTCfgIndexAppleTalkPAP       = 6,
  kOTCfgIndexAppleTalkASP       = 7,
  kOTCfgIndexAppleTalkLast      = 7
};

/* OLDROUTINENAMES*/

/* See OTCfgATalkGeneral.*/
struct OTCfgAppleTalkPrefs {
  UInt16              fVersion;
  UInt16              fNumPrefs;
  UInt32              fPort;
  void *              fLink;
  void *              fPrefs[8];
};
typedef struct OTCfgAppleTalkPrefs      OTCfgAppleTalkPrefs;
/* OLDROUTINENAMES*/

typedef OTCfgATalkGeneralAARP           OTCfgAARPPrefs;
/* OLDROUTINENAMES*/
typedef OTCfgATalkGeneralDDP            OTCfgDDPPrefs;
/* OLDROUTINENAMES*/
/* See OTCfgATalkGeneral.*/
struct OTCfgATPFPrefs {
  OTCfgAppleTalkPrefs  fAT;
  OTCfgAARPPrefs      fAARP;
  OTCfgDDPPrefs       fDDP;
  char                fFill[122];
};
typedef struct OTCfgATPFPrefs           OTCfgATPFPrefs;
/* OLDROUTINENAMES*/
struct OTCfgIRPrefs {
  CfgPrefsHeader      fHdr;
  UInt32              fPort;
  OTCfgIRPortSetting  fPortSetting;
  Boolean             fNotifyOnDisconnect;
  Boolean             fDisplayIRControlStrip;
  Point               fWindowPosition;
};
typedef struct OTCfgIRPrefs             OTCfgIRPrefs;
/* OLDROUTINENAMES*/
struct OTCfgIRGlobal {
  CfgPrefsHeader      fHdr;                   /* standard prefererences header*/
  UInt32              fOptions;               /* options bitmask*/
  UInt32              fNotifyMask;            /* Notification options.*/
  UInt32              fUnloadTimeout;         /* Unload timeout (in milliseconds)*/
};
typedef struct OTCfgIRGlobal            OTCfgIRGlobal;
/* OLDROUTINENAMES*/

typedef OTCfgTCPDHCPLeaseInfo           OTCfgDHCPRecord;
typedef OTCfgTCPSearchList              OTCfgHSTFPrefs;
typedef OTCfgTCPRoutersListEntry        OTCfgIRTEEntry;
typedef OTCfgTCPRoutersList             OTCfgIRTEPrefs;
/* OLDROUTINENAMES*/
/* Use OTCfgTCPDNSServersList instead of OTCfgIDNSPrefs.*/

struct OTCfgIDNSPrefs {
  short               fCount;
  UInt32              fAddressesList;
};
typedef struct OTCfgIDNSPrefs           OTCfgIDNSPrefs;
/* OLDROUTINENAMES*/
/*  This is your worst case, a fixed size structure, tacked on after a variable length string.*/
/*  Use the macro to help access the movable beast. */

#define kIITFPartP( h ) ( (OTCfgIITFPrefsPart*) &( (**( (OTCfgIITFPrefs**) h )).fAppleTalkZone[ (**( (OTCfgIITFPrefs**) h )).fAppleTalkZone[0] + 1 ] ) )

/*
    This structure also contains an IP address and subnet mask that are not aligned on a four byte boundary.  
    In order to avoid compiler warnings, and the possibility of code that won't work, 
    these fields are defined here as four character arrays.  
    It is suggested that BlockMoveData be used to copy to and from a field of type InetHost.  
*/
/* OLDROUTINENAMES*/

struct OTCfgIITFPrefsPart {
  char                path[36];
  char                module[32];
  unsigned long       framing;
};
typedef struct OTCfgIITFPrefsPart       OTCfgIITFPrefsPart;
/* OLDROUTINENAMES*/
struct OTCfgIITFPrefs {
  short               fCount;
  UInt8               fConfigMethod;
                                              /*    this structure IS packed!*/
                                              /*    Followed by:*/
  UInt8               fIPAddress[4];
  UInt8               fSubnetMask[4];
  UInt8               fAppleTalkZone[256];
                                              /*    this structure IS packed!*/
  UInt8               fFiller;
  OTCfgIITFPrefsPart  part;
};
typedef struct OTCfgIITFPrefs           OTCfgIITFPrefs;
/* OLDROUTINENAMES*/
/* Use OTCfgTCPSearchDomains instead of OTCfgIDNSPrefs.*/

struct OTCfgISDMPrefs {
  short               fCount;
  Str255              fDomainsList;
};
typedef struct OTCfgISDMPrefs           OTCfgISDMPrefs;
/* OLDROUTINENAMES*/

typedef OTCfgModemGeneral               OTCfgRemoteConfigModem;
typedef OTCfgModemApplication           OTCfgModemAppPrefs;
/* OLDROUTINENAMES*/
enum {
  kOTCfgRemoteMaxPasswordLength = 255,
  kOTCfgRemoteMaxPasswordSize   = (255 + 1),
  kOTCfgRemoteMaxUserNameLength = 255,
  kOTCfgRemoteMaxUserNameSize   = (255 + 1),
  kOTCfgRemoteMaxAddressLength  = 255,
  kOTCfgRemoteMaxAddressSize    = (255 + 1),
  kOTCfgRemoteMaxServerNameLength = 32,
  kOTCfgRemoteMaxServerNameSize = (32 + 1),
  kOTCfgRemoteMaxMessageLength  = 255,
  kOTCfgRemoteMaxMessageSize    = (255 + 1),
  kOTCfgRemoteMaxX25ClosedUserGroupLength = 4,
  kOTCfgRemoteInfiniteSeconds   = (long)0xFFFFFFFF,
  kOTCfgRemoteMinReminderMinutes = 1,
  kOTCfgRemoteChatScriptFileCreator = FOUR_CHAR_CODE('ttxt'),
  kOTCfgRemoteChatScriptFileType = FOUR_CHAR_CODE('TEXT'),
  kOTCfgRemoteMaxChatScriptLength = 0x8000
};

/* OLDROUTINENAMES*/

typedef OTCfgRemoteAlternateAddress     OTCfgRemoteAddress;
/* OLDROUTINENAMES*/
struct OTCfgRemoteScript {
  UInt32              version;
  UInt32              fType;
  void *              additional;
  UInt32              scriptType;
  UInt32              scriptLength;
  UInt8 *             scriptData;
};
typedef struct OTCfgRemoteScript        OTCfgRemoteScript;
/* OLDROUTINENAMES*/

typedef OTCfgRemoteX25                  OTCfgRemoteX25Info;
/* OLDROUTINENAMES*/
typedef OTCfgRemoteApplication          OTCfgRemoteConfigCAPT;
/* OLDROUTINENAMES*/

struct OTCfgRemoteUserMessage {
  UInt32              version;
  SInt32              messageID;
  UInt8               userMessage[256];
  UInt8               userDiagnostic[256];
};
typedef struct OTCfgRemoteUserMessage   OTCfgRemoteUserMessage;
/* OLDROUTINENAMES*/
struct OTCfgRemoteDisconnect {
  UInt32              whenSeconds;
  UInt32              showStatus;
};
typedef struct OTCfgRemoteDisconnect    OTCfgRemoteDisconnect;
/* OLDROUTINENAMES*/
struct OTCfgRemoteIsRemote {
  UInt32              net;
  UInt32              node;
  UInt32              isRemote;
};
typedef struct OTCfgRemoteIsRemote      OTCfgRemoteIsRemote;
/* OLDROUTINENAMES*/
struct OTCfgRemoteConnectInfo {
  OTCfgRemoteConnect * connectInfo;
};
typedef struct OTCfgRemoteConnectInfo   OTCfgRemoteConnectInfo;
/* OLDROUTINENAMES*/
enum {
  kOTCfgRemoteStatusIdle        = 1,
  kOTCfgRemoteStatusConnecting  = 2,
  kOTCfgRemoteStatusConnected   = 3,
  kOTCfgRemoteStatusDisconnecting = 4
};

/* OLDROUTINENAMES*/

struct OTCfgRemoteStatus {
  UInt32              status;
  Boolean             answerEnabled;
  char                pad00;
  UInt32              secondsConnected;
  UInt32              secondsRemaining;
  UInt8               userName[256];
  UInt8               serverName[33];
  char                pad01;
  UInt32              messageIndex;
  UInt8               message[256];
  UInt32              serialProtocolMode;
  UInt8               baudMessage[256];
  Boolean             isServer;
  char                pad02;
  UInt32              bytesIn;
  UInt32              bytesOut;
  UInt32              linkSpeed;
  UInt32              localIPAddress;
  UInt32              remoteIPAddress;
};
typedef struct OTCfgRemoteStatus        OTCfgRemoteStatus;
/* OLDROUTINENAMES*/

typedef UInt32                          OTCfgRemoteEventCode;
/* OLDROUTINENAMES*/
typedef CALLBACK_API_C( void , RANotifyProcPtr )(void *contextPtr, OTCfgRemoteEventCode code, OSStatus result, void *cookie);
/* OLDROUTINENAMES*/
struct OTCfgRemoteNotifier {
  RANotifyProcPtr     procPtr;
  void *              contextPtr;
};
typedef struct OTCfgRemoteNotifier      OTCfgRemoteNotifier;
/* OLDROUTINENAMES*/
struct OTCfgRemoteRequest {
  SInt8               reserved1[16];
  OSErr               result;
  SInt8               reserved2[8];
  SInt16              requestCode;
  SInt16              portId;
  union {
    OTCfgRemoteNotifier  Notifier;
    OTCfgRemoteConnect  Connect;
    OTCfgRemoteDisconnect  Disconnect;
    OTCfgRemoteStatus   Status;
    OTCfgRemoteIsRemote  IsRemote;
    OTCfgRemoteConnectInfo  ConnectInfo;
  }                       fType;
};
typedef struct OTCfgRemoteRequest       OTCfgRemoteRequest;
#endif  /* OLDROUTINENAMES */

#endif  /* CALL_NOT_IN_CARBON */


#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __NETWORKSETUP__ */

