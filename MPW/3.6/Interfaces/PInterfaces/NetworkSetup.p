{
     File:       NetworkSetup.p
 
     Contains:   Network Setup Interfaces
 
     Version:    Technology: 1.3.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT NetworkSetup;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NETWORKSETUP__}
{$SETC __NETWORKSETUP__ := 1}

{$I+}
{$SETC NetworkSetupIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }

TYPE
	CfgDatabaseRef    = ^LONGINT; { an opaque 32-bit type }
	CfgDatabaseRefPtr = ^CfgDatabaseRef;  { when a VAR xx:CfgDatabaseRef parameter can be nil, it is changed to xx: CfgDatabaseRefPtr }

CONST
	kInvalidCfgAreaID			= 0;


TYPE
	CfgAreaID							= UInt32;
	CfgEntityClass						= OSType;
	CfgEntityType						= OSType;
	CfgEntityRefPtr = ^CfgEntityRef;
	CfgEntityRef = RECORD
		fLoc:					CfgAreaID;
		fReserved:				UInt32;
		fID:					Str255;
	END;

	CfgResourceLocatorPtr = ^CfgResourceLocator;
	CfgResourceLocator = RECORD
		fFile:					FSSpec;
		fResID:					SInt16;
	END;

	CfgEntityInfoPtr = ^CfgEntityInfo;
	CfgEntityInfo = RECORD
		fClass:					CfgEntityClass;
		fType:					CfgEntityType;
		fName:					Str255;
		fIcon:					CfgResourceLocator;
	END;

	CfgEntityAccessID					= Ptr;
	CfgPrefsHeaderPtr = ^CfgPrefsHeader;
	CfgPrefsHeader = RECORD
		fSize:					UInt16;									{  size, in bytes, does not include this header  }
		fVersion:				UInt16;
		fType:					OSType;
	END;

	{	    -------------------------------------------------------------------------
	    Error codes
	    ------------------------------------------------------------------------- 	}

CONST
	kCfgErrDatabaseChanged		= -3290;						{  database has changed since last call - close and reopen DB }
	kCfgErrAreaNotFound			= -3291;						{  Area doesn't exist }
	kCfgErrAreaAlreadyExists	= -3292;						{  Area already exists }
	kCfgErrAreaNotOpen			= -3293;						{  Area needs to open first }
	kCfgErrConfigLocked			= -3294;						{  Access conflict - retry later }
	kCfgErrEntityNotFound		= -3295;						{  An entity with this name doesn't exist }
	kCfgErrEntityAlreadyExists	= -3296;						{  An entity with this name already exists }
	kCfgErrPrefsTypeNotFound	= -3297;						{  A preference with this prefsType doesn't exist }
	kCfgErrDataTruncated		= -3298;						{  Data truncated when read buffer too small }
	kCfgErrFileCorrupted		= -3299;						{  The database format appears to be corrupted. }
	kCfgErrFirst				= -3290;
	kCfgErrLast					= -3299;

	{   reserve a 'free' tag for free blocks }
	kCfgFreePref				= 'free';

	{	    -------------------------------------------------------------------------
	    CfgEntityClass / CfgEntityType
	
	    The database can distinguish between several classes of objects and 
	    several types withing each class
	    Use of different classes allow to store type of information in the same database
	
	    Other entity classes and types can be defined by developers.
	    they should be unique and registered with Developer Tech Support (DTS)
	    ------------------------------------------------------------------------- 	}
	kCfgClassAnyEntity			= '****';
	kCfgClassUnknownEntity		= '????';
	kCfgTypeAnyEntity			= '****';
	kCfgTypeUnknownEntity		= '????';

	{	    -------------------------------------------------------------------------
	    For CfgIsSameEntityRef
	    ------------------------------------------------------------------------- 	}
	kCfgIgnoreArea				= true;
	kCfgDontIgnoreArea			= false;

	{	******************************************************************************
	**  Configuration Information Access API 
	*******************************************************************************	}
	{	    -------------------------------------------------------------------------
	    Database access
	    ------------------------------------------------------------------------- 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTCfgOpenDatabase()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTCfgOpenDatabase(VAR dbRef: CfgDatabaseRef): OSStatus;

{
    OTCfgOpenDatabase()

    Inputs:     none
    Outputs:    CfgDatabaseRef* dbRef           Reference to opened database
    Returns:    OSStatus                        *** list errors ***

    Opens Network Setup for a given client. This call should be made prior to any other call.
}
{
 *  OTCfgCloseDatabase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgCloseDatabase(VAR dbRef: CfgDatabaseRef): OSStatus;

{
    OTCfgCloseDatabase()

    Inputs:     CfgDatabaseRef* dbRef           Reference to opened database
    Outputs:    CfgDatabaseRef* dbRef           Reference to opened database is cleared
    Returns:    OSStatus                        *** list errors ***

    Closes Network Setup for a given client. This call should be made when the client no 
    longer wants to use Network Setup.  
}
{    -------------------------------------------------------------------------
    Area management
    ------------------------------------------------------------------------- }
{
 *  OTCfgGetAreasCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetAreasCount(dbRef: CfgDatabaseRef; VAR itemCount: ItemCount): OSStatus;

{
    OTCfgGetAreasCount()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
    Outputs:    ItemCount* itemCount            Number of entities defined
    Returns:    OSStatus                        *** list errors ***

    Returns the number of areas currently defined.
}
{
 *  OTCfgGetAreasList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetAreasList(dbRef: CfgDatabaseRef; VAR itemCount: ItemCount; areaID: LongIntPtr; VAR areaName: Str255): OSStatus;

{
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
}
{
 *  OTCfgGetCurrentArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetCurrentArea(dbRef: CfgDatabaseRef; VAR areaID: CfgAreaID): OSStatus;

{
    OTCfgGetCurrentArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
    Outputs:    CfgAreaID* areaID               ID of current area
    Returns:    OSStatus                        *** list errors ***

    Returns the id of the current area.
}
{
 *  OTCfgSetCurrentArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgSetCurrentArea(dbRef: CfgDatabaseRef; areaID: CfgAreaID): OSStatus;

{
    OTCfgSetCurrentArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to make active
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Sets the current area. If the area doesn’t exist kCfgErrAreaNotFound is returned.
}
{
 *  OTCfgCreateArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgCreateArea(dbRef: CfgDatabaseRef; areaName: Str255; VAR areaID: CfgAreaID): OSStatus;

{
    OTCfgCreateArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                ConstStr255Param areaName       Name of area to create
    Outputs:    CfgAreaID* areaID               ID of newly created area
    Returns:    OSStatus                        *** list errors ***

    Creates a new area with the specified name. Then name must be unique or kCfgErrAreaAlreadyExists 
    will be returned.
}
{
 *  OTCfgDeleteArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgDeleteArea(dbRef: CfgDatabaseRef; areaID: CfgAreaID): OSStatus;

{
    OTCfgDeleteArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to delete
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Deletes the specified area. If the area doesn’t exist kCfgErrAreaNotFound is returned.
}
{
 *  OTCfgDuplicateArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgDuplicateArea(dbRef: CfgDatabaseRef; sourceAreaID: CfgAreaID; destAreaID: CfgAreaID): OSStatus;

{
    OTCfgDuplicateArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID sourceAreaID          Area to duplicate
                CfgAreaID destAreaID            Area to contain duplicate
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Duplicates the source area content into the destination area. Both areas should exist prior to 
    making this call. If either area doesn’t exist kCfgErrAreaNotFound is returned.
}
{
 *  OTCfgSetAreaName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgSetAreaName(dbRef: CfgDatabaseRef; areaID: CfgAreaID; areaName: Str255; VAR newAreaID: CfgAreaID): OSStatus;

{
    OTCfgSetAreaName()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area being named
                ConstStr255Param areaName       New name for area
    Outputs:    CfgAreaID* newAreaID            ID of renamed area
    Returns:    OSStatus                        *** list errors ***

    Renames the specified area. A new id is returned: it should be used from now on. If the area 
    doesn’t exist kCfgErrAreaNotFound is returned.
}
{
 *  OTCfgGetAreaName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetAreaName(dbRef: CfgDatabaseRef; areaID: CfgAreaID; VAR areaName: Str255): OSStatus;

{
    OTCfgGetAreaName()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area being queried
    Outputs:    Str255 areaName                 Name of area
    Returns:    OSStatus                        *** list errors ***

    Gets the name of the specified area. If the area doesn’t exist kCfgErrAreaNotFound is returned.
    
    Requires Network Setup 1.0.1 or higher.
}
{    -------------------------------------------------------------------------
    Configuration Database API
    
    Single Writer ONLY!!!
    ------------------------------------------------------------------------- }
{    -------------------------------------------------------------------------
    Opening an area for reading
    ------------------------------------------------------------------------- }
{
 *  OTCfgOpenArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgOpenArea(dbRef: CfgDatabaseRef; areaID: CfgAreaID): OSStatus;

{
    OTCfgOpenArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to open
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Opens the specified area for reading. If the area doesn’t exist kCfgErrAreaNotFound is returned.
}
{
 *  OTCfgCloseArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgCloseArea(dbRef: CfgDatabaseRef; areaID: CfgAreaID): OSStatus;

{
    OTCfgCloseArea()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to close
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Closes an area opened for reading. If the area doesn’t exist kCfgErrAreaNotFound is returned.  
}
{
    For write access
}
{
 *  OTCfgBeginAreaModifications()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgBeginAreaModifications(dbRef: CfgDatabaseRef; readAreaID: CfgAreaID; VAR writeAreaID: CfgAreaID): OSStatus;

{
    OTCfgBeginAreaModifications()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID readAreaID            ID of area opened for reading
    Outputs:    CfgAreaID* writeAreaID          ID of area opened for modification
    Returns:    OSStatus                        *** list errors ***

    Opens the specified area for writing. A new area id is provided.  This area id should be used to 
    enumerate, add, delete, read and write to the modified data. The original id can still be used to 
    access the original unmodified data. If the area doesn’t exist, kCfgErrAreaNotFound is returned.
}
{
 *  OTCfgCommitAreaModifications()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgCommitAreaModifications(dbRef: CfgDatabaseRef; readAreaID: CfgAreaID; writeAreaID: CfgAreaID): OSStatus;

{
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
}
{
 *  OTCfgAbortAreaModifications()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgAbortAreaModifications(dbRef: CfgDatabaseRef; readAreaID: CfgAreaID): OSStatus;

{
    OTCfgAbortAreaModifications()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID readAreaID            ID of area opened for reading
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Closes an area opened for writing, discarding any modification. The areaID should be the id of 
    the original area. If the area doesn’t exist or the wrong id is passed kCfgErrAreaNotFound is 
    returned.
}
{
    Working with entities

    Entities can be manipulated as soon as an area has been opened.  The same calls work both for 
    areas opened for reading or for modification. In the latter case, the calls can be used on the 
    original or new area id to access the original data or the modified data.
}
{
    For everybody
    Count receives the actual number of entities
}
{
 *  OTCfgGetEntitiesCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetEntitiesCount(dbRef: CfgDatabaseRef; areaID: CfgAreaID; entityClass: CfgEntityClass; entityType: CfgEntityType; VAR itemCount: ItemCount): OSStatus;

{
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
}

{
    Count as input, is the number of entities to read;
    count as output, receives the actual number of entities or the number you specified. 
}
{
 *  OTCfgGetEntitiesList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetEntitiesList(dbRef: CfgDatabaseRef; areaID: CfgAreaID; entityClass: CfgEntityClass; entityType: CfgEntityType; VAR itemCount: ItemCount; entityRef: CfgEntityRefPtr; entityInfo: CfgEntityInfoPtr): OSStatus;

{
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
    (
        CfgEntityClass      fClass;
        CfgEntityType       fType;
        ConstStr255Param    fName;
        CfgResourceLocator  fIcon;
    );
}
{
 *  OTCfgCreateEntity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgCreateEntity(dbRef: CfgDatabaseRef; areaID: CfgAreaID; {CONST}VAR entityInfo: CfgEntityInfo; VAR entityRef: CfgEntityRef): OSStatus;

{
    OTCfgCreateEntity()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgAreaID areaID                ID of area to contain entity
                CfgEntityInfo* entityInfo       Information that defines the entity
    Outputs:    CfgEntityRef* entityRef         Reference to entity created
    Returns:    OSStatus                        *** list errors ***

    Creates a new entity with the specified class, type and name and returns an id for it. If the 
    area doesn’t exist, kCfgErrAreaNotFound is returned. If there is already 
    an entity with the same name kCfgErrEntityAlreadyExists is returned.
}
{
 *  OTCfgDeleteEntity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgDeleteEntity(dbRef: CfgDatabaseRef; {CONST}VAR entityRef: CfgEntityRef): OSStatus;

{
    OTCfgDeleteEntity()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef* entityRef         Reference to entity to delete
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Deletes the specified entity. If there is no entity with this id, kCfgEntityNotfoundErr is returned
}
{
 *  OTCfgDuplicateEntity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgDuplicateEntity(dbRef: CfgDatabaseRef; {CONST}VAR entityRef: CfgEntityRef; {CONST}VAR newEntityRef: CfgEntityRef): OSStatus;

{
    OTCfgDuplicateEntity()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef* entityRef         Reference to entity to duplicate
                CfgEntityRef* newEntityRef      Reference to destination entity
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Copies the contents of entityRef into newEntityRef. Both entities must exit.
    If either entity doesn’t exist kCfgErrEntityNotFound is returned.
}
{
 *  OTCfgSetEntityName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgSetEntityName(dbRef: CfgDatabaseRef; {CONST}VAR entityRef: CfgEntityRef; entityName: Str255; VAR newEntityRef: CfgEntityRef): OSStatus;

{
    OTCfgSetEntityName()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef* entityRef         Reference to entity to rename
                ConstStr255Param entityName     New name for entity
    Outputs:    CfgEntityRef* newEntityRef      Reference to renamed entity
    Returns:    OSStatus                        *** list errors ***

    Renames the specified entity. If the entity doesn’t exist kCfgEntityNotfoundErr is returned. If 
    there is already an entity with that name kCfgErrEntityAlreadyExists is returned.
}
{
 *  OTCfgGetEntityArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCfgGetEntityArea({CONST}VAR entityRef: CfgEntityRef; VAR areaID: CfgAreaID);

{
    OTCfgGetEntityArea()

    Inputs:     CfgEntityRef *entityRef         Reference to an entity
    Outputs:    CfgAreaID *areaID               ID of area that contains the entity
    Returns:    none

    Returns the area ID associated with the specified entity reference.
}
{
 *  OTCfgGetEntityName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCfgGetEntityName({CONST}VAR entityRef: CfgEntityRef; VAR entityName: Str255);

{
    OTCfgGetEntityName()

    Inputs:     CfgEntityRef *entityRef         Reference to an entity
    Outputs:    Str255 entityName               Name of the entity
    Returns:    none

    Returns the entity name associated with the specified entity reference.
}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTCfgGetEntityLogicalName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetEntityLogicalName(dbRef: CfgDatabaseRef; {CONST}VAR entityRef: CfgEntityRef; VAR entityName: Str255): OSStatus;

{
    OTCfgGetEntityName()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef *entityRef         Reference to an entity
    Outputs:    Str255 entityName               Logical Name of the entity
    Returns:    none

    Returns the logical name associated with the specified entity reference.
}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTCfgChangeEntityArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OTCfgChangeEntityArea(VAR entityRef: CfgEntityRef; newAreaID: CfgAreaID);

{
    OTCfgChangeEntityArea()

    Inputs:     CfgEntityRef *entityRef         Reference to an entity
                CfgAreaID newAreaID             ID of area to contain moved entity
    Outputs:    none
    Returns:    none

    Changes the area ID associated with the specified entity reference.
}
{    -------------------------------------------------------------------------
    These API calls are for the protocol developers to compare the IDs.
    ------------------------------------------------------------------------- }
{    -------------------------------------------------------------------------
    For OTCfgIsSameEntityRef
    ------------------------------------------------------------------------- }
{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kOTCfgIgnoreArea			= 1;
	kOTCfgDontIgnoreArea		= 0;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTCfgIsSameEntityRef()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTCfgIsSameEntityRef({CONST}VAR entityRef1: CfgEntityRef; {CONST}VAR entityRef2: CfgEntityRef; ignoreArea: BOOLEAN): BOOLEAN;

{
    OTCfgIsSameEntityRef()

    Inputs:     CfgEntityRef* entityRef1        Reference to an entity
                CfgEntityRef* entityRef2        Reference to another entity
                Boolean ignoreArea              If true, ignore the area ID
    Outputs:    none
    Returns:    Boolean                         If true, entity references match

    Compare two entity references. If ignoreArea is true, and the two entity names are the same, then return 
    true. If ignoreArea is false, then the area IDs must be the same, as well as the entity names 
    must be the same, then can return true.
}
{
 *  OTCfgIsSameAreaID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgIsSameAreaID(areaID1: CfgAreaID; areaID2: CfgAreaID): BOOLEAN;

{
    OTCfgIsSameAreaID()

    Inputs:     CfgAreaID areaID1               ID of an area
                CfgAreaID areaID2               ID of another area
    Outputs:    none
    Returns:    Boolean                         If true, area IDs match

    Compare two area IDs. Return true for matching area IDs, and return false for the different area IDs.
}
{    -------------------------------------------------------------------------
    Dealing with individual preferences
    ------------------------------------------------------------------------- }
{    -------------------------------------------------------------------------
    Open Preferences
    if writer = true, GetPrefs and SetPrefs are allowed, else only GetPrefs is allowed.
    ------------------------------------------------------------------------- }
{
 *  OTCfgOpenPrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgOpenPrefs(dbRef: CfgDatabaseRef; {CONST}VAR entityRef: CfgEntityRef; writer: BOOLEAN; VAR accessID: CfgEntityAccessID): OSStatus;

{
    OTCfgOpenPrefs()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityRef* entityRef         Reference to an entity
                Boolean writer                  If true, open for write
    Outputs:    CfgEntityAccessID* accessID     ID for entity access
    Returns:    OSStatus                        *** list errors ***

    Open the specified entity and return the CfgEntityAccessID for the following access of the 
    content of the entity. If writer is true, CfgGetPrefs and CfgSetPrefs are allowed, otherwise only 
    CfgGetPrefs is allowed.
}
{
 *  OTCfgClosePrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgClosePrefs(accessID: CfgEntityAccessID): OSStatus;

{
    OTCfgClosePrefs()

    Inputs:     CfgEntityAccessID* accessID     ID for entity to close
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Close the entity with the specified CfgEntityAccessID.
}
{    -------------------------------------------------------------------------
    Get/Set Preferences

    Accessing the content of an entity

    These API calls are for the protocol developers. It supports multiple preferences per entity. Each 
    preference is identified by an OSType (typically called prefsType). The structure of the
    preference data is protocol stack dependent.
    ------------------------------------------------------------------------- }
{
 *  OTCfgSetPrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgSetPrefs(accessID: CfgEntityAccessID; prefsType: OSType; data: UNIV Ptr; length: ByteCount): OSStatus;

{
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
}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTCfgDeletePrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgDeletePrefs(accessID: CfgEntityAccessID; prefsType: OSType): OSStatus;

{
    OTCfgDeletePrefs()

    Inputs:     CfgEntityAccessID* accessID     ID of entity to access
                OSType prefsType                Preference type to get
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Delete the specified preference. The preference is identified by the prefsType. 
}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTCfgGetPrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetPrefs(accessID: CfgEntityAccessID; prefsType: OSType; data: UNIV Ptr; length: ByteCount): OSStatus;

{
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
}
{
 *  OTCfgGetPrefsSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetPrefsSize(accessID: CfgEntityAccessID; prefsType: OSType; VAR length: ByteCount): OSStatus;

{
    OTCfgGetPrefsSize()

    Inputs:     CfgEntityAccessID* accessID     ID of entity to access
                OSType prefsType                Preference type to get
                ByteCount length                Number of bytes of data available
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Returns the length, in bytes, of the specified preference. The preference is identified by the prefsType.
}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTCfgGetTemplate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetTemplate(entityClass: CfgEntityClass; entityType: CfgEntityType; prefsType: OSType; data: UNIV Ptr; VAR dataSize: ByteCount): OSStatus;

{
    OTCfgGetDefault()

    Inputs:     OSType      entityClass         entityClass
                OSType      entityType          entityType
                OSType      prefsType           prefsType
                ByteCount*  dataSize            maximum length of buffer
    Outputs:    void*       data                template for the preference class/type/prefsType
                ByteCount*  dataSize            actual length of template
    Returns:    OSStatus                        *** list errors ***

    This routine returns the template for the specified preference class, type, and prefsType.
}
{
    Due to a human error, OTCfgGetDefault was published with the entity type and class parameters reversed, 
    with respect to the other calls that take these same parameters.  Please, use OTCfgGetTemplate instead.  
}
{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC CALL_NOT_IN_CARBON }
{
 *  OTCfgGetDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetDefault(entityType: OSType; entityClass: OSType; prefsType: OSType): Handle;

{
    OTCfgGetDefault()

    Inputs:     OSType  entityType              entityType
                OSType  entityClass             entityClass
                OSType  prefsType               prefsType
    Outputs:    none
    Returns:    Handle                          default preference for the preference type/class/prefsType

    This routine returns the default preference value for the specified preference type, class, and prefsType.
}
{    -------------------------------------------------------------------------
    Get table of contents for prefs
    ------------------------------------------------------------------------- }
{
 *  OTCfgGetPrefsTOCCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetPrefsTOCCount(accessID: CfgEntityAccessID; VAR itemCount: ItemCount): OSStatus;

{
    OTCfgGetPrefsTOCCount()

    Inputs:     CfgEntityAccessID* accessID     ID of entity to access
    Outputs:    ItemCount* itemCount            Number of entries available
    Returns:    OSStatus                        *** list errors ***

    Get the count of all the preference in the entity.
}
{
 *  OTCfgGetPrefsTOC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgGetPrefsTOC(accessID: CfgEntityAccessID; VAR itemCount: ItemCount; VAR prefsTOC: CfgPrefsHeader): OSStatus;

{
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
}
{    -------------------------------------------------------------------------
    Database Change Notification
    ------------------------------------------------------------------------- }
{$ENDC}  {CALL_NOT_IN_CARBON}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	OTCfgNotifyProcPtr = PROCEDURE(contextPtr: UNIV Ptr; code: UInt32; result: SInt32; cookie: UNIV Ptr);
{$ELSEC}
	OTCfgNotifyProcPtr = ProcPtr;
{$ENDC}

	OTCfgNotifierEntryPtr = ^OTCfgNotifierEntry;
	OTCfgNotifierEntry = RECORD
		dbRef:					CfgDatabaseRef;
		theClass:				CfgEntityClass;
		theType:				CfgEntityType;
		notifier:				OTCfgNotifyProcPtr;
		contextPtr:				Ptr;
		theArea:				CfgAreaID;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTCfgInstallNotifier()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTCfgInstallNotifier(dbRef: CfgDatabaseRef; theClass: CfgEntityClass; theType: CfgEntityType; notifier: OTCfgNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;

{
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
}
{
 *  OTCfgRemoveNotifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgRemoveNotifier(dbRef: CfgDatabaseRef; theClass: CfgEntityClass; theType: CfgEntityType): OSStatus;

{
    OTCfgRemoveNotifier()

    Inputs:     CfgDatabaseRef dbRef            Reference to opened database
                CfgEntityClass theClass         remove notifier for this class
                CfgEntityType theType           remove notifier for this type
    Outputs:    none
    Returns:    OSStatus                        *** list errors ***

    Removes a notifier previously installed with OTCfgRemoveNotifier.

    Requires Network Setup 1.1 or higher.
}
{  Constants for the code parameter of the notifier installed by OTCfgInstallNotifier. }

{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kOTCfgDatabaseChanged		= $10000000;					{  result will be kCfgErrDatabaseChanged, cookie is meaningless }

	{	    -------------------------------------------------------------------------
	    Remote Access Preference Utilities
	    ------------------------------------------------------------------------- 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  OTCfgEncrypt()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION OTCfgEncrypt(VAR key: UInt8; VAR data: UInt8; dataLen: SInt16): SInt16;

{
    OTCfgEncrypt()

    Inputs:     UInt8 *key                      encryption key ( user name )
                UInt8 *data                     data to encrypt ( password )
                SInt16 dataLen                  length of data to encrypt
    Outputs:    UInt8 *data                     encrypted data
    Returns:    SInt16                          length of encrypted data

    Encrypt the password, using the user name as the encryption key.  Return the encrypted password and its length.  
    
    Requires Network Setup 1.1 or higher.
}
{
 *  OTCfgDecrypt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CfgOpenTpt 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTCfgDecrypt(VAR key: UInt8; VAR data: UInt8; dataLen: SInt16): SInt16;

{
    OTCfgDecrypt()

    Inputs:     UInt8 *key                      encryption key ( user name )
                UInt8 *data                     data to decrypt ( password )
                SInt16 dataLen                  length of data to decrypt
    Outputs:    UInt8 *data                     decrypted data
    Returns:    SInt16                          length of decrypted data

    Decrypt the password, using the user name as the encryption key.  Return the decrypted password and its length.  

    Requires Network Setup 1.1 or higher.
}

{    -------------------------------------------------------------------------
    CfgEntityClass / CfgEntityType

    The database can distinguish between several classes of objects and 
    several types withing each class
    Use of different classes allow to store type of information in the same database

    Other entity classes and types can be defined by developers.
    they should be unique and registered with Developer Tech Support (DTS)
    ------------------------------------------------------------------------- }
{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kOTCfgClassNetworkConnection = 'otnc';
	kOTCfgClassGlobalSettings	= 'otgl';
	kOTCfgClassServer			= 'otsv';
	kOTCfgTypeGeneric			= 'otan';
	kOTCfgTypeAppleTalk			= 'atlk';
	kOTCfgTypeTCPv4				= 'tcp4';
	kOTCfgTypeTCPv6				= 'tcp6';
	kOTCfgTypeDNS				= 'dns ';
	kOTCfgTypeRemote			= 'ara ';
	kOTCfgTypeDial				= 'dial';
	kOTCfgTypeModem				= 'modm';
	kOTCfgTypeInfrared			= 'infr';
	kOTCfgClassSetOfSettings	= 'otsc';
	kOTCfgTypeSetOfSettings		= 'otst';

	{	    *****************************************************
	    *************** Preference Structures ***************
	    *****************************************************
		}

	{	  ------------------ Network Setup ------------------ 	}


	kOTCfgSetsStructPref		= 'stru';						{  CfgSetsStruct }
	kOTCfgSetsElementPref		= 'elem';						{  CfgSetsElement }
	kOTCfgSetsVectorPref		= 'vect';						{  CfgSetsVector }

	{
	   Bits and masks for the fFlags field of CfgSetsStruct.
	   Second line.
	}
	kOTCfgSetsFlagActiveBit		= 0;

	kOTCfgSetsFlagActiveMask	= $0001;


	{  Indexes for the fTimes field of CfgSetsStruct. }
	kOTCfgIndexSetsActive		= 0;
	kOTCfgIndexSetsEdit			= 1;
	kOTCfgIndexSetsLimit		= 2;							{     last value, no comma }


TYPE
	CfgSetsStructPtr = ^CfgSetsStruct;
	CfgSetsStruct = RECORD
		fFlags:					UInt32;
		fTimes:					ARRAY [0..1] OF UInt32;
	END;

	CfgSetsElementPtr = ^CfgSetsElement;
	CfgSetsElement = RECORD
		fEntityRef:				CfgEntityRef;
		fEntityInfo:			CfgEntityInfo;
	END;

	CfgSetsVectorPtr = ^CfgSetsVector;
	CfgSetsVector = RECORD
		fCount:					UInt32;
		fElements:				ARRAY [0..0] OF CfgSetsElement;
	END;




CONST
	kOTCfgFlagRecordVersion		= $01200120;
	kOTCfgProtocolActive		= $01;
	kOTCfgProtocolMultihoming	= $00010000;
	kOTCfgProtocolLimit			= $00010001;


TYPE
	OTCfgFlagRecordPtr = ^OTCfgFlagRecord;
	OTCfgFlagRecord = RECORD
		fVersion:				UInt32;
		fFlags:					UInt32;
	END;



	{	  ------------------ Common ------------------    	}



	{  Per-connection preference types }


CONST
	kOTCfgUserVisibleNamePref	= 'pnam';						{  Pascal string }
	kOTCfgVersionPref			= 'cvrs';						{  UInt16, values should be 1 }
	kOTCfgPortUserVisibleNamePref = 'port';						{  Pascal string }
	kOTCfgPortUIName			= 'otgn';						{  Pascal String }
	kOTCfgProtocolUserVisibleNamePref = 'prot';					{  C string (TCP/IP = "tcp", AppleTalk = "ddp", n/a for others) }
	kOTCfgAdminPasswordPref		= 'pwrd';						{  not to be documented }
	kOTCfgProtocolOptionsPref	= 'opts';						{  UInt32, protocol specific flags }


	{  Global preference types }

	kOTCfgUserModePref			= 'ulvl';						{  OTCfgUserMode, TCP/IP and AppleTalk only }
	kOTCfgPrefWindowPositionPref = 'wpos';						{  Point, global coordinates, TCP/IP, AppleTalk, Infrared only }


	{  Per-connection backward compatibility preference types }

	kOTCfgCompatNamePref		= 'cnam';
	kOTCfgCompatResourceNamePref = 'resn';


	{  Global backward compatibility preference types }

	kOTCfgCompatSelectedPref	= 'ccfg';
	kOTCfgCompatResourceIDPref	= 'resi';


	{
	   For most control panels that support a concept of "user mode",
	   the OTCfgUserMode preference holds (or is used as a field in 
	   another preference to hold) the current user mode.
	}

TYPE
	OTCfgUserMode 				= UInt16;
CONST
	kOTCfgBasicUserMode			= 1;
	kOTCfgAdvancedUserMode		= 2;
	kOTCfgAdminUserMode			= 3;							{  admin mode is never valid in a preference, here for completeness only }



	{
	   The exceptions (and there has to be exceptions, right) are Remote
	   Access and Modem, where the user mode is always stored as a UInt32
	   instead of a UInt16.  The constant values from OTCfgUserMode apply though.
	}

TYPE
	OTCfgUserMode32						= UInt32;


	{	  ------------------ AppleTalk ------------------ 	}



	{  Per-connection preference types }


CONST
	kOTCfgATalkGeneralPref		= 'atpf';						{  OTCfgATalkGeneral }
	kOTCfgATalkLocksPref		= 'lcks';						{  OTCfgATalkLocks }
	kOTCfgATalkPortDeviceTypePref = 'ptfm';						{  OTCfgATalkPortDeviceType }


	{  Global preference types }

	kOTCfgATalkNetworkArchitecturePref = 'neta';				{  OTCfgATalkNetworkArchitecture }


	{
	   OTCfgATalkGeneralAARP is a sub-structure of OTCfgATalkGeneral.
	   It defines parameters for the AppleTalk Address Resolution Protocol
	   (AARP) component of the AppleTalk protocol stack.
	}

TYPE
	OTCfgATalkGeneralAARPPtr = ^OTCfgATalkGeneralAARP;
	OTCfgATalkGeneralAARP = RECORD
		fVersion:				UInt16;									{  must be 1 }
		fSize:					UInt16;									{  must be sizeof(OTCfgATalkGeneralAARP) }
		fAgingCount:			UInt32;									{  default of 8 }
		fAgingInterval:			UInt32;									{  ms, default of 10000 }
		fProtAddrLen:			UInt32;									{  bytes, must be 4, ignored by current versions of OT }
		fHWAddrLen:				UInt32;									{  bytes, must be 6, ignored by current versions of OT }
		fMaxEntries:			UInt32;									{  default of 100 }
		fProbeInterval:			UInt32;									{  ms, default of 200 }
		fProbeRetryCount:		UInt32;									{  default of 10 }
		fRequestInterval:		UInt32;									{  ms, default of 200 }
		fRequestRetryCount:		UInt32;									{  default of 8 }
	END;



	{
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
	}
	OTCfgATalkUnloadOptions 	= UInt8;
CONST
	kOTCfgATalkInactive			= 0;
	kOTCfgATalkDefaultUnloadTimeout = 5;
	kOTCfgATalkActive			= $FF;




	{
	   OTCfgATalkGeneralDDP is a sub-structure of OTCfgATalkGeneral.
	   It defines parameters for the Datagram Deliver Protocol
	   (DDP) component of the AppleTalk protocol stack.
	}

TYPE
	OTCfgATalkGeneralDDPPtr = ^OTCfgATalkGeneralDDP;
	OTCfgATalkGeneralDDP = RECORD
		fVersion:				UInt16;									{  must be 1 }
		fSize:					UInt16;									{  must be sizeof(OTCfgATalkGeneralDDP) }
		fTSDUSize:				UInt32;									{  must be 586 }
		fLoadType:				SInt8;									{  whether AppleTalk is active, see the discussion above }
		fNode:					SInt8;									{  last acquired node number, or fixed node to use }
		fNetwork:				UInt16;									{  last acquired network, or fixed network to use }
		fRTMPRequestLimit:		UInt16;									{  must be 3, ignored by current versions of OT }
		fRTMPRequestInterval:	UInt16;									{  ms, must be 200, ignored by current versions of OT }
		fAddressGenLimit:		UInt32;									{  default of 250 }
		fBRCAgingInterval:		UInt32;									{  ms, must be 40000, BRC = best routing cache, ignored by current versions of OT }
		fRTMPAgingInterval:		UInt32;									{  ms, must be 50000, ignored by current versions of OT }
		fMaxAddrTries:			UInt32;									{  default of 4096 }
		fDefaultChecksum:		BOOLEAN;								{  default of false, does DDP checksum by default }
		fIsFixedNode:			BOOLEAN;								{  default of false, using fixed net/node }
		fMyZone:				PACKED ARRAY [0..32] OF UInt8;			{  last acquired zone }
	END;



	{
	   OTCfgATalkGeneralNBP is a sub-structure of OTCfgATalkGeneral.
	   It defines parameters for the Name Binding Protocol 
	   (NBP) component of the AppleTalk protocol stack.
	}
	OTCfgATalkGeneralNBPPtr = ^OTCfgATalkGeneralNBP;
	OTCfgATalkGeneralNBP = RECORD
		fVersion:				UInt16;									{  must be 1 }
		fSize:					UInt16;									{  must be sizeof(OTCfgATalkGeneralNBP) }
		fTSDUSize:				UInt32;									{  default of 584 }
		fDefaultRetryInterval:	UInt32;									{  ms, default of 800 }
		fDefaultRetryCount:		UInt32;									{  default of 3 }
		fCaseSensitiveCompare:	BOOLEAN;								{  default of false }
		fPad:					SInt8;									{  must be 0 }
	END;



	{
	   OTCfgATalkGeneralZIP is a sub-structure of OTCfgATalkGeneral.
	   It defines parameters for the Zone Information Protocol
	   (ZIP) component of the AppleTalk protocol stack.
	}
	OTCfgATalkGeneralZIPPtr = ^OTCfgATalkGeneralZIP;
	OTCfgATalkGeneralZIP = RECORD
		fVersion:				UInt16;									{  must be 1 }
		fSize:					UInt16;									{  must be sizeof(OTCfgATalkGeneralZIP) }
		fGetZoneInterval:		UInt32;									{  ms, default of 2000 }
		fZoneListInterval:		UInt32;									{  ms, defalut of 2000 }
		fDDPInfoTimeout:		UInt16;									{  ms, default of 4000; }
		fGetZoneRetries:		SInt8;									{  default of 4 }
		fZoneListRetries:		SInt8;									{  default of 4 }
		fChecksumFlag:			BOOLEAN;								{  default of 0 }
		fPad:					SInt8;									{  must be 0 }
	END;



	{
	   OTCfgATalkGeneralATP is a sub-structure of OTCfgATalkGeneral.
	   It defines parameters for the AppleTalk Transaction Protocol
	   (ATP) component of the AppleTalk protocol stack.
	}
	OTCfgATalkGeneralATPPtr = ^OTCfgATalkGeneralATP;
	OTCfgATalkGeneralATP = RECORD
		fVersion:				UInt16;									{  must be 1 }
		fSize:					UInt16;									{  must be sizeof(OTCfgATalkGeneralATP) }
		fTSDUSize:				UInt32;									{  default of 578 }
		fDefaultRetryInterval:	UInt32;									{  ms, default of 2000 }
		fDefaultRetryCount:		UInt32;									{  default of 8 }
		fDefaultReleaseTimer:	SInt8;									{  default of 0, same format as ATP_OPT_RELTIMER option }
		fDefaultALOSetting:		BOOLEAN;								{  default of false }
	END;



	{
	   OTCfgATalkGeneralADSP is a sub-structure of OTCfgATalkGeneral.
	   It defines parameters for the AppleTalk Data Stream Protocol
	   (ADSP) component of the AppleTalk protocol stack.
	}
	OTCfgATalkGeneralADSPPtr = ^OTCfgATalkGeneralADSP;
	OTCfgATalkGeneralADSP = RECORD
		fVersion:				UInt16;									{  must be 1 }
		fSize:					UInt16;									{  must be sizeof(OTCfgATalkGeneralADSP) }
		fDefaultSendBlocking:	UInt32;									{  bytes, default of 16 }
		fTSDUSize:				UInt32;									{  default of 572 }
		fETSDUSize:				UInt32;									{  default of 572 }
		fDefaultOpenInterval:	UInt32;									{  ms, default of 3000 }
		fDefaultProbeInterval:	UInt32;									{  ms, default of 30000 }
		fMinRoundTripTime:		UInt32;									{  ms, default of 100 }
		fDefaultSendInterval:	UInt32;									{  ms, default of 100 }
		fDefaultRecvWindow:		UInt32;									{  bytes, must be 27648, ignored by current versions of OT }
		fDefaultOpenRetries:	SInt8;									{  default of 3 }
		fDefaultBadSeqMax:		SInt8;									{  default of 3 }
		fDefaultProbeRetries:	SInt8;									{  default of 4 }
		fMaxConsecutiveDataPackets: SInt8;								{  default of 48 }
		fDefaultChecksum:		BOOLEAN;								{  default of false }
		fDefaultEOM:			BOOLEAN;								{  default of false }
	END;



	{
	   OTCfgATalkGeneralPAP is a sub-structure of OTCfgATalkGeneral.
	   It defines parameters for the Printer Access Protocol
	   (PAP) component of the AppleTalk protocol stack.
	}
	OTCfgATalkGeneralPAPPtr = ^OTCfgATalkGeneralPAP;
	OTCfgATalkGeneralPAP = RECORD
		fVersion:				UInt16;									{  must be 1 }
		fSize:					UInt16;									{  must be sizeof(OTCfgATalkGeneralPAP) }
		fDefaultOpenInterval:	UInt32;									{  ms, default of 2000 }
		fDefaultTickleInterval:	UInt32;									{  ms, default of 15000 }
		fDefaultOpenRetries:	SInt8;									{  default of 0 }
		fDefaultTickleRetries:	SInt8;									{  default of 8 }
		fDefaultReplies:		SInt8;									{  must be 8, ignored by current versions of OT }
		fDefaultPAPEOMEnabled:	BOOLEAN;								{  default of false }
	END;



	{
	   OTCfgATalkGeneralASP is a sub-structure of OTCfgATalkGeneral.
	   It defines parameters for the AppleTalk Session Protocol
	   (ASP) component of the AppleTalk protocol stack.
	   IMPORTANT:  Open Transport does not currently include a native
	   ASP implemention, and the classic AppleTalk ASP implementation
	   does not heed these preferences.
	}
	OTCfgATalkGeneralASPPtr = ^OTCfgATalkGeneralASP;
	OTCfgATalkGeneralASP = RECORD
		fVersion:				UInt16;									{  must be 1 }
		fSize:					UInt16;									{  must be sizeof(OTCfgATalkGeneralASP) }
		fDefaultTickleInterval:	UInt32;									{  ms, must be 30000, ignored by current versions of OT }
		fDefaultTickleRetries:	SInt8;									{  must be 8, ignored by current versions of OT }
		fDefaultReplies:		SInt8;									{  must be 8, ignored by current versions of OT }
	END;



	{
	   The OTCfgATalkGeneral structure is a conglomeration of the above structures
	   and is used to access the kOTCfgATalkGeneralPref preference.
	}
	OTCfgATalkGeneralPtr = ^OTCfgATalkGeneral;
	OTCfgATalkGeneral = RECORD
		fVersion:				UInt16;									{  must be 0 }
		fNumPrefs:				UInt16;									{  must be 0 }
		fPort:					UInt32;									{  a reference to the port over which this configuration is running }
		fLink:					Ptr;									{  run-time use only, must be nil }
		fPrefs:					ARRAY [0..7] OF Ptr;					{  run-time use only, initialise to nil }
		aarpPrefs:				OTCfgATalkGeneralAARP;
		ddpPrefs:				OTCfgATalkGeneralDDP;
		nbpPrefs:				OTCfgATalkGeneralNBP;
		zipPrefs:				OTCfgATalkGeneralZIP;
		atpPrefs:				OTCfgATalkGeneralATP;
		adspPrefs:				OTCfgATalkGeneralADSP;
		papPrefs:				OTCfgATalkGeneralPAP;
		aspPrefs:				OTCfgATalkGeneralASP;
	END;



	{
	   OTCfgATalkLocks determines which preferences have been
	   locked by the administrator mode of the control panel.
	}
	OTCfgATalkLocksPtr = ^OTCfgATalkLocks;
	OTCfgATalkLocks = RECORD
		fLocks:					UInt16;									{  a bit field, see the definitions below }
	END;



CONST
	kOTCfgATalkPortLockMask		= $01;
	kOTCfgATalkZoneLockMask		= $02;
	kOTCfgATalkAddressLockMask	= $04;
	kOTCfgATalkConnectionLockMask = $08;
	kOTCfgATalkSharingLockMask	= $10;




	{
	   OTCfgATalkPortDeviceType holds either the OT device type (eg kOTEthernetDevice)
	   or an ADEV ID for the current port.  It is not used by the AppleTalk
	   protocol stack, but it is used by the AppleTalk control panel.
	}

TYPE
	OTCfgATalkPortDeviceTypePtr = ^OTCfgATalkPortDeviceType;
	OTCfgATalkPortDeviceType = RECORD
		fDeviceType:			UInt16;
	END;



	{
	   OTCfgATalkNetworkArchitecture is a vestigial remnent of the
	   "Network Software Selector" in System 7.5.3 through 7.5.5.
	}
	OTCfgATalkNetworkArchitecturePtr = ^OTCfgATalkNetworkArchitecture;
	OTCfgATalkNetworkArchitecture = RECORD
		fVersion:				UInt32;									{  must be 0 }
		fNetworkArchitecture:	OSType;									{  must be 'OTOn' }
	END;

	{  Masks for the kOTCfgProtocolOptionsPref preference. }


CONST
	kOTCfgATalkNoBadRouterUpNotification = $01;
	kOTCfgATalkNoAllNodesTakenNotification = $02;
	kOTCfgATalkNoFixedNodeTakenNotification = $04;
	kOTCfgATalkNoInternetAvailableNotification = $08;
	kOTCfgATalkNoCableRangeChangeNotification = $10;
	kOTCfgATalkNoRouterDownNotification = $20;
	kOTCfgATalkNoRouterUpNotification = $40;
	kOTCfgATalkNoFixedNodeBadNotification = $80;




	{	  ------------------ Infrared ------------------  	}



	{  Per-connection preference types }

	kOTCfgIRGeneralPref			= 'atpf';						{  OTCfgIRGeneral }


TYPE
	OTCfgIRPortSetting 			= UInt16;
CONST
	kOTCfgIRIrDA				= 0;
	kOTCfgIRIRTalk				= 1;


TYPE
	OTCfgIRGeneralPtr = ^OTCfgIRGeneral;
	OTCfgIRGeneral = RECORD
		fVersion:				UInt32;									{  must be 0 }
		fPortRef:				UInt32;									{  reference to IR port }
		fPortSetting:			OTCfgIRPortSetting;						{  IrDA or IRTalk, use constants defined above }
		fNotifyOnDisconnect:	BOOLEAN;
		fDisplayIRControlStrip:	BOOLEAN;
	END;



	{	  ------------------ TCP/IP (v4) ------------------   	}



	{  Per-connection preference types }


CONST
	kOTCfgTCPInterfacesPref		= 'iitf';						{  OTCfgTCPInterfaces (packed) }
	kOTCfgTCPDeviceTypePref		= 'dtyp';						{  UInt16 (device type) }
	kOTCfgTCPRoutersListPref	= 'irte';						{  OTCfgTCPRoutersList }
	kOTCfgTCPSearchListPref		= 'ihst';						{  OTCfgTCPSearchList (packed) }
	kOTCfgTCPDNSServersListPref	= 'idns';						{  OTCfgTCPDNSServersList }
	kOTCfgTCPSearchDomainsPref	= 'isdm';						{  OTCfgTCPSearchDomains }
	kOTCfgTCPDHCPLeaseInfoPref	= 'dclt';						{  OTCfgTCPDHCPLeaseInfo }
	kOTCfgTCPDHCPClientIDPref	= 'dcid';						{  DHCP client ID, Pascal string }
	kOTCfgTCPUnloadAttrPref		= 'unld';						{  OTCfgTCPUnloadAttr }
	kOTCfgTCPLocksPref			= 'stng';						{  OTCfgTCPLocks }
	kOTCfgTCPPushBelowIPPref	= 'crpt';						{  single module to push below IP, Pascal string }
	kOTCfgTCPPushBelowIPListPref = 'blip';						{  list of modules to push below IP (Mac OS 9.0 and higher), 'STR#' format }


	{
	   OTCfgTCPConfigMethod is used as a field of OTCfgTCPInterfacesUnpacked
	   to denote how TCP/IP should acquire an address.
	}

TYPE
	OTCfgTCPConfigMethod 		= UInt8;
CONST
	kOTCfgManualConfig			= 0;
	kOTCfgRARPConfig			= 1;
	kOTCfgBOOTPConfig			= 2;
	kOTCfgDHCPConfig			= 3;
	kOTCfgMacIPConfig			= 4;


	{
	   The OTCfgTCPInterfacesPacked structure holds information
	   about the TCP/IP interfaces configured on the computer.
	   IMPORTANT: You must pack this structure when writing it to the
	   database and unpack it when reading it from the database.
	    The OTCfgTCPInterfacesPacked structure is a complex case, consisting of 
	    a fixed size structure, appended after a variable length string.
	}

TYPE
	OTCfgTCPInterfacesPackedPartPtr = ^OTCfgTCPInterfacesPackedPart;
	OTCfgTCPInterfacesPackedPart = RECORD
		path:					PACKED ARRAY [0..35] OF UInt8;
		module:					PACKED ARRAY [0..31] OF UInt8;
		framing:				UInt32;
	END;

	{
	    This structure also contains an IP address and subnet mask that are not aligned on a four byte boundary.  
	    In order to avoid compiler warnings, and the possibility of code that won't work, 
	    these fields are defined here as four character arrays.  
	    It is suggested that BlockMoveData be used to copy to and from a field of type InetHost.  
	}
	OTCfgTCPInterfacesPackedPtr = ^OTCfgTCPInterfacesPacked;
	OTCfgTCPInterfacesPacked = PACKED RECORD
		fCount:					UInt16;
		fConfigMethod:			UInt8;
		fIPAddress:				PACKED ARRAY [0..3] OF UInt8;
		fSubnetMask:			PACKED ARRAY [0..3] OF UInt8;
		fAppleTalkZone:			PACKED ARRAY [0..255] OF UInt8;
		part:					PACKED ARRAY [0..71] OF UInt8;
	END;

	{
	   The OTCfgTCPInterfacesUnpacked structure holds information
	   about the TCP/IP interfaces configured on the computer.
	   IMPORTANT: You must pack this structure when writing it to the
	   database and unpack it when reading it from the database.
	}
	OTCfgTCPInterfacesUnpackedPtr = ^OTCfgTCPInterfacesUnpacked;
	OTCfgTCPInterfacesUnpacked = RECORD
		fCount:					UInt16;									{  always 1 in current versions of OT }
		pad1:					SInt8;									{  remove this pad byte when packing }
		fConfigMethod:			SInt8;
		fIPAddress:				UInt32;
		fSubnetMask:			UInt32;
		fAppleTalkZone:			Str32;									{  remove bytes beyond end of string when packing }
		pad2:					SInt8;									{  remove this pad byte when packing }
		path:					PACKED ARRAY [0..35] OF UInt8;
		module:					PACKED ARRAY [0..31] OF UInt8;
		framing:				UInt32;
	END;



	{
	   The OTCfgTCPRoutersListEntry structure is an array element
	   in the OTCfgTCPRoutersList preference.
	}
	OTCfgTCPRoutersListEntryPtr = ^OTCfgTCPRoutersListEntry;
	OTCfgTCPRoutersListEntry = RECORD
		fToHost:				UInt32;									{     must be 0 }
		fViaHost:				UInt32;									{     router address }
		fLocal:					UInt16;									{     must be 0 }
		fHost:					UInt16;									{     must be 0 }
	END;



	{
	   The OTCfgTCPRoutersList preferences is used to hold the
	   configured list of routers.
	}
	OTCfgTCPRoutersListPtr = ^OTCfgTCPRoutersList;
	OTCfgTCPRoutersList = RECORD
		fCount:					UInt16;
		fList:					ARRAY [0..0] OF OTCfgTCPRoutersListEntry;
	END;

	{
	   The OTCfgTCPSearchList preference holds some basic information
	   about the DNS configuration.
	   IMPORTANT: You must pack this structure when writing it to the
	   database and unpack it when reading it from the database.
	}
	OTCfgTCPSearchListPtr = ^OTCfgTCPSearchList;
	OTCfgTCPSearchList = PACKED RECORD
		fPrimaryInterfaceIndex:	UInt8;									{  always 1 in current versions of OT }
		pad0:					UInt8;									{  required by Interfacer }
		fLocalDomainName:		Str255;									{  in the file, these strings are packed }
		fAdmindomain:			Str255;
	END;



	{
	   The OTCfgTCPDNSServersList preference holds the configured
	   list of name servers.
	}
	OTCfgTCPDNSServersListPtr = ^OTCfgTCPDNSServersList;
	OTCfgTCPDNSServersList = RECORD
		fCount:					UInt16;
		fAddressesList:			ARRAY [0..0] OF UInt32;
	END;



	{
	   The OTCfgTCPSearchDomains preference holds the configured
	   list additional search domains.
	   IMPORTANT: This preference is actually stored in string list
	   format, ie the same format as a 'STR#' resource.
	}
	OTCfgTCPSearchDomainsPtr = ^OTCfgTCPSearchDomains;
	OTCfgTCPSearchDomains = RECORD
		fCount:					UInt16;
		fFirstSearchDomains:	Str255;									{  subsequent search domains are packed after this one }
	END;



	{
	   The OTCfgTCPDHCPLeaseInfo preference holds information about
	   the DHCP lease.
	}
	OTCfgTCPDHCPLeaseInfoPtr = ^OTCfgTCPDHCPLeaseInfo;
	OTCfgTCPDHCPLeaseInfo = RECORD
		ipIPAddr:				UInt32;
		ipConfigServer:			UInt32;
		ipLeaseGrantTime:		UInt32;
		ipLeaseExpirationTime:	UInt32;
	END;



	{
	   The OTCfgTCPUnloadAttr preference determines whether TCP/IP is
	   active or inactive and, if active, whether it will
	   unload after 2 minutes of inactivity.
	}
	OTCfgTCPUnloadAttr 			= UInt16;
CONST
	kOTCfgTCPActiveLoadedOnDemand = 1;
	kOTCfgTCPActiveAlwaysLoaded	= 2;
	kOTCfgTCPInactive			= 3;




	{
	   OTCfgTCPLocks determines which preferences have been
	   locked by the administrator mode of the control panel.
	   
	   IMPORTANT: This structure has an odd size.  See notes below.
	}

TYPE
	OTCfgTCPLocksPtr = ^OTCfgTCPLocks;
	OTCfgTCPLocks = RECORD
		pad1:					SInt8;									{  Set this and all other pad fields to 0. }
		lockConnectViaPopup:	SInt8;
		pad2:					SInt8;
		lockConfigurePopup:		SInt8;
		pad3:					SInt8;
		lockAppleTalkZone:		SInt8;
		pad4:					SInt8;
		lockIPAddress:			SInt8;
		pad5:					SInt8;
		lockLocalDomainName:	SInt8;
		pad6:					SInt8;
		lockSubnetMask:			SInt8;
		pad7:					SInt8;
		lockRoutersList:		SInt8;
		pad8:					SInt8;
		lockDNSServersList:		SInt8;
		pad9:					SInt8;
		lockAdminDomainName:	SInt8;
		pad10:					SInt8;
		lockSearchDomains:		SInt8;
		pad11:					SInt8;
		lockUnknown:			SInt8;
		pad12:					SInt8;
		lock8023:				SInt8;
		pad13:					SInt8;
		lockDHCPClientID:		SInt8;									{  this field added in OT 2.0 }
		pad14:					SInt8;									{  this field added in OT 2.0 }
	END;

	{
	   The OTCfgTCPLocks preference has an odd size, either 25 or
	   27 bytes depending on the verson on OT.  It is impossible
	   to represent an odd size structure in 68K aligned C structures,
	   because the compiler always pads structures to an even size.
	   So, when reading and writing this preference you should use one
	   of the constants defined below.
	}

CONST
	kOTCfgTCPLocksPrefPre2_0Size = 25;
	kOTCfgTCPLocksPref2_0Size	= 27;
	kOTCfgTCPLocksPrefCurrentSize = 27;


	{  Masks for the kOTCfgProtocolOptionsPref preference. }

	kOTCfgDontDoPMTUDiscoveryMask = $0001;						{  Turns off Path MTU Discovery }
	kOTCfgDontShutDownOnARPCollisionMask = $0002;				{  To be able to Disable ARP Collision ShutDown  }
	kOTCfgDHCPInformMask		= $0004;						{  Enables DHCPINFORM instead of DHCPREQUEST }
	kOTCfgOversizeOffNetPacketsMask = $0008;					{  With PMTU off, don't limit off-net packet to 576 bytes }
	kOTCfgDHCPDontPreserveLeaseMask = $0010;					{  Turns off DHCP INIT-REBOOT capability. }



	{	  ------------------ DNS ------------------   	}



	{  Per-connection preference types }

	kOTCfgTypeDNSidns			= 'idns';
	kOTCfgTypeDNSisdm			= 'isdm';
	kOTCfgTypeDNSihst			= 'ihst';
	kOTCfgTypeDNSstng			= 'stng';



	{	  ------------------ Modem ------------------ 	}



	{  Per-connection preference types }

	kOTCfgModemGeneralPrefs		= 'ccl ';						{  OTCfgModemGeneral }
	kOTCfgModemLocksPref		= 'lkmd';						{  OTCfgModemLocks }
	kOTCfgModemAdminPasswordPref = 'mdpw';						{  not to be documented }


	{  Global preference types }

	kOTCfgModemApplicationPref	= 'mapt';						{  OTCfgModemApplication }


	{
	   OTCfgModemDialogToneMode specifies the handling of the dial
	   tone within a OTCfgModemGeneral preference.
	}

TYPE
	OTCfgModemDialogToneMode 	= UInt32;
CONST
	kOTCfgModemDialToneNormal	= 0;
	kOTCfgModemDialToneIgnore	= 1;
	kOTCfgModemDialToneManual	= 2;




	{
	   The OTCfgModemGeneral preference holds the important
	   per-connection preferences for Modem.
	}

TYPE
	OTCfgModemGeneralPtr = ^OTCfgModemGeneral;
	OTCfgModemGeneral = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, below }
		useModemScript:			BOOLEAN;								{  whether to use a modem script, must be true }
		pad:					SInt8;									{  must be 0 }
		modemScript:			FSSpec;									{  the modem script (CCL) to use }
		modemSpeakerOn:			BOOLEAN;								{  whether to dial with the speaker on }
		modemPulseDial:			BOOLEAN;								{  true if pulse dial, false if tone dial }
		modemDialToneMode:		OTCfgModemDialogToneMode;				{  constants are given above }
		lowerLayerName:			PACKED ARRAY [0..35] OF CHAR;			{  C string, name of underlying serial port }
	END;



	{
	   OTCfgModemLocks determines which preferences have been
	   locked by the administrator mode of the control panel.
	}
	OTCfgModemLocksPtr = ^OTCfgModemLocks;
	OTCfgModemLocks = RECORD
		version:				UInt32;									{  must be 1 }
		port:					UInt32;									{  the underlying serial port is locked (1) or not locked (0) }
		script:					UInt32;									{  the modem script (CCL) is locked (1) or not locked (0) }
		speaker:				UInt32;									{  the speaker settings are locked (1) or not locked (0) }
		dialing:				UInt32;									{  the pulse/tone dial setting is locked (1) or not locked (0) }
	END;



	{  Preferences for the modem application itself. }
	OTCfgModemApplicationPtr = ^OTCfgModemApplication;
	OTCfgModemApplication = RECORD
		version:				UInt32;									{  must be 1 }
		windowPos:				Point;									{  global coordinates, window position }
		userMode:				OTCfgUserMode32;						{  must be kOTCfgBasicUserMode, Modem control panel has no "advance" mode }
	END;



	{	  ------------------ Remote Access ------------------ 	}



	{	
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
		}

CONST
	kOTCfgRemoteDefaultVersion	= $00020003;
	kOTCfgRemoteAcceptedVersion	= $00010000;


	{  Per-connection preference types }

	kOTCfgRemoteARAPPref		= 'arap';						{  OTCfgRemoteARAP }
	kOTCfgRemoteAddressPref		= 'cadr';						{  'TEXT' format, max 255 characters, see also OTCfgRemoteConnect }
	kOTCfgRemoteChatPref		= 'ccha';						{  'TEXT', see also OTCfgRemoteConnect }
	kOTCfgRemoteDialingPref		= 'cdia';						{  OTCfgRemoteDialing }
	kOTCfgRemoteAlternateAddressPref = 'cead';					{  OTCfgRemoteAlternateAddress }
	kOTCfgRemoteClientLocksPref	= 'clks';						{  OTCfgRemoteClientLocks }
	kOTCfgRemoteClientMiscPref	= 'cmsc';						{  OTCfgRemoteClientMisc }
	kOTCfgRemoteConnectPref		= 'conn';						{  OTCfgRemoteConnect }
	kOTCfgRemoteUserPref		= 'cusr';						{  user name, Pascal string }
	kOTCfgRemoteDialAssistPref	= 'dass';						{  OTCfgRemoteDialAssist }
	kOTCfgRemoteIPCPPref		= 'ipcp';						{  OTCfgRemoteIPCP }
	kOTCfgRemoteLCPPref			= 'lcp ';						{  OTCfgRemoteLCP }
	kOTCfgRemoteLogOptionsPref	= 'logo';						{  OTCfgRemoteLogOptions }
	kOTCfgRemotePasswordPref	= 'pass';						{  OTCfgRemotePassword }
	kOTCfgRemoteTerminalPref	= 'term';						{  OTCfgRemoteTerminal }
	kOTCfgRemoteUserModePref	= 'usmd';						{  OTCfgRemoteUserMode }
	kOTCfgRemoteSecurityDataPref = 'csec';						{  untyped data for external security modules }
	kOTCfgRemoteX25Pref			= 'x25 ';						{  OTCfgRemoteX25 }


	{  Global preference types }

	kOTCfgRemoteServerPortPref	= 'port';						{  OTCfgRemoteServerPort }
	kOTCfgRemoteServerPref		= 'srvr';						{  OTCfgRemoteServer }
	kOTCfgRemoteApplicationPref	= 'capt';						{  OTCfgRemoteApplication }




	{
	   The OTCfgRemoteARAP preference holds connection information
	   for the ARAP protocol modules.
	   Also used as part of a Remote Access server configuration.
	}

TYPE
	OTCfgRemoteARAPPtr = ^OTCfgRemoteARAP;
	OTCfgRemoteARAP = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		lowerLayerName:			PACKED ARRAY [0..35] OF CHAR;			{  C string, name of underlying modem port, must be "Script" }
	END;



	{
	   OTCfgRemoteRedialMode specifies the handling of redial
	   within a OTCfgRemoteDialing preference.
	}
	OTCfgRemoteRedialMode 		= UInt32;
CONST
	kOTCfgRemoteRedialNone		= 2;
	kOTCfgRemoteRedialMain		= 3;
	kOTCfgRemoteRedialMainAndAlternate = 4;




	{
	   The OTCfgRemoteDialing controls the dialing characteristics
	   of outgoing connections.
	}

TYPE
	OTCfgRemoteDialingPtr = ^OTCfgRemoteDialing;
	OTCfgRemoteDialing = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		fType:					UInt32;									{  must be 'dial' }
		additionalPtr:			UInt32;									{  must be 0 }
		dialMode:				OTCfgRemoteRedialMode;					{  constants are given above }
		redialTries:			UInt32;									{  only valid if dialMode != kOTCfgRemoteRedialNone }
		redialDelay:			UInt32;									{  ms, only valid if dialMode != kOTCfgRemoteRedialNone }
		pad:					UInt32;									{  must be zero }
	END;



	{
	   The OTCfgRemoteAlternateAddress holds the alternate phone number
	   to dial if the dialMode field of the OTCfgRemoteDialing 
	   preference is kOTCfgRemoteRedialMainAndAlternate.
	}
	OTCfgRemoteAlternateAddressPtr = ^OTCfgRemoteAlternateAddress;
	OTCfgRemoteAlternateAddress = RECORD
		pad:					UInt32;									{  must be zero }
		alternateAddress:		Str255;
	END;



	{
	   OTCfgRemoteClientLocks determines which preferences have been
	   locked by the administrator mode of the control panel.
	}
	OTCfgRemoteClientLocksPtr = ^OTCfgRemoteClientLocks;
	OTCfgRemoteClientLocks = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		name:					UInt32;									{  "Name" field is locked (1) or unlocked (0) }
		password:				UInt32;									{  "Password" field is locked (1) or unlocked (0) }
		number:					UInt32;									{  "Number" field is locked (1) or unlocked (0) }
		errorCheck:				UInt32;									{  "Allow error correction and compression in modem" checkbox is locked (1) or unlocked (0) }
		headerCompress:			UInt32;									{  "Use TCP header compression" checkbox is locked (1) or unlocked (0) }
		termWindow:				UInt32;									{  "Connect to a command-line host" options are locked (1) or unlocked (0) }
		reminder:				UInt32;									{  "Reminders" options are locked (1) or unlocked (0) }
		autoConn:				UInt32;									{  "Connect automatically when starting TCP/IP applications" checkbox is locked (1) or unlocked (0) }
		redial:					UInt32;									{  "Redialing" panel is locked (1) or unlocked (0) }
		useProtocolLock:		UInt32;									{  "Use protocol" popup is locked (1) or unlocked (0) }
		useVerboseLogLock:		UInt32;									{  "Use verbose logging" checkbox is locked (1) or unlocked (0) }
		regUserOrGuestLock:		UInt32;									{  "Register User"/"Guest" radio buttons are locked (1) or unlocked (0) }
		dialAssistLock:			UInt32;									{  "Use DialAssist" checkbox is locked (1) or unlocked (0) }
		savePasswordLock:		UInt32;									{  "Save password" checkbox is locked (1) or unlocked (0) }
		useOpenStatusAppLock:	UInt32;									{  "Open Status Application" checkbox is locked (1) or unlocked (0) }
		reserved:				ARRAY [0..0] OF UInt32;					{  must be 0 }
	END;



	{
	   The OTCfgRemoteClientMisc preference holds, as you might guess,
	   one miscellaneous preference.
	}
	OTCfgRemoteClientMiscPtr = ^OTCfgRemoteClientMisc;
	OTCfgRemoteClientMisc = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		connectAutomatically:	UInt32;									{  connect automatically when starting TCP/IP applications (1), or not (0) }
	END;



	{  The following types are used by the OTCfgRemoteConnect preference. }
	OTCfgRemotePPPConnectScript  = UInt32;
CONST
	kOTCfgRemotePPPConnectScriptNone = 0;						{  no chat script }
	kOTCfgRemotePPPConnectScriptTerminalWindow = 1;				{  use a terminal window }
	kOTCfgRemotePPPConnectScriptScript = 2;						{  use save chat script (OTCfgRemoteChat) }


TYPE
	OTCfgRemoteProtocol 		= UInt32;
CONST
	kOTCfgRemoteProtocolPPP		= 1;							{  PPP only }
	kOTCfgRemoteProtocolARAP	= 2;							{  ARAP only }
	kOTCfgRemoteProtocolAuto	= 3;							{  auto-detect PPP or ARAP (not support in ARA 3.5 and above) }




	{
	   The OTCfgRemoteConnect holds the core connection information
	   for a Remote Access configuration.
	}

TYPE
	OTCfgRemoteConnectPtr = ^OTCfgRemoteConnect;
	OTCfgRemoteConnect = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		fType:					UInt32;									{  must be 0 }
		isGuest:				UInt32;									{  registered user (0) or guest (1) login }
		canInteract:			UInt32;									{  must be 1 }
		showStatus:				UInt32;									{  must be 0 }
		passwordSaved:			UInt32;									{  use saved password (1) or not (0) }
		flashConnectedIcon:		UInt32;									{  flash menu bar reminder icon (1) or not (0) }
		issueConnectedReminders: UInt32;								{  issue Notification Manager reminders (1) or not (0) }
		reminderMinutes:		SInt32;									{  minutes, time between each reminder }
		connectManually:		UInt32;									{  must be 0 }
		allowModemDataCompression: UInt32;								{  allow modem data compression (1) or not (0), only valid for PPP connections }
		chatMode:				OTCfgRemotePPPConnectScript;			{  constants are given above }
		serialProtocolMode:		OTCfgRemoteProtocol;					{  constants are given above }
		passwordPtr:			UInt32;									{  run-time use only, initialise to 0, read ignore & preserve }
		userNamePtr:			UInt32;									{  run-time use only, initialise to 0, read ignore & preserve }
		addressLength:			UInt32;									{  length of phone number (OTCfgRemoteAddress) }
		addressPtr:				UInt32;									{  run-time use only, initialise to 0, read ignore & preserve }
		chatScriptName:			Str63;									{  user-visible name of chat script }
		chatScriptLength:		UInt32;									{  length of chat script (OTCfgRemoteChat) }
		chatScriptPtr:			UInt32;									{  run-time use only, initialise to 0, read ignore & preserve }
		additional:				UInt32;									{  run-time use only, initialise to 0, read ignore & preserve }
		useSecurityModule:		UInt32;									{  must be 0 }
		securitySignature:		OSType;									{  must be 0 }
		securityDataLength:		UInt32;									{  must be 0 }
		securityDataPtr:		UInt32;									{  must be 0 }
	END;



	{  OTCfgRemoteDialAssist }
	OTCfgRemoteDialAssistPtr = ^OTCfgRemoteDialAssist;
	OTCfgRemoteDialAssist = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		isAssisted:				UInt32;									{  0 for no assist (default), 1 for assist }
		areaCodeStr:			Str31;
		countryCodeStr:			Str31;
	END;



	{
	   The OTCfgRemoteIPCP preference holds configuration information
	   for the Internet Protocol Control Protocol (IPCP) layer of PPP.
	   The contents of this record only make sense for PPP connections
	   and are ignored for ARAP connections.
	   Also used as part of a Remote Access server configuration.
	}
	OTCfgRemoteIPCPPtr = ^OTCfgRemoteIPCP;
	OTCfgRemoteIPCP = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		reserved:				ARRAY [0..1] OF UInt32;					{  must be 0 }
		maxConfig:				UInt32;									{  must be 10 }
		maxTerminate:			UInt32;									{  must be 10 }
		maxFailureLocal:		UInt32;									{  must be 10 }
		maxFailureRemote:		UInt32;									{  must be 10 }
		timerPeriod:			UInt32;									{  ms, must be 10000 }
		localIPAddress:			UInt32;									{  must be 0 }
		remoteIPAddress:		UInt32;									{  must be 0 }
		allowAddressNegotiation: UInt32;								{  must be 1 }
		idleTimerEnabled:		UInt16;									{  disconnect if line idle (1) or not (0) }
		compressTCPHeaders:		UInt16;									{  Van Jacobsen header compression allowed (1) or not (0) }
		idleTimerMilliseconds:	UInt32;									{  ms, if idleTimerEnabled, disconnect if idle for }
	END;



	{
	   The OTCfgRemoteLCP preference holds configuration information
	   for the Link Control Protocol (LCP) layer of PPP.  The contents
	   of this record only make sense for PPP connections and are
	   ignored for ARAP connections.
	   Also used as part of a Remote Access server configuration.
	}
	OTCfgRemoteLCPPtr = ^OTCfgRemoteLCP;
	OTCfgRemoteLCP = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		reserved:				ARRAY [0..1] OF UInt32;					{  must be 0 }
		lowerLayerName:			PACKED ARRAY [0..35] OF CHAR;			{  C string, name of underlying modem port, must be "Script" }
		maxConfig:				UInt32;									{  must be 10 }
		maxTerminate:			UInt32;									{  must be 10 }
		maxFailureLocal:		UInt32;									{  must be 10 }
		maxFailureRemote:		UInt32;									{  must be 10 }
		timerPeriod:			UInt32;									{  ms, must be 10000 }
		echoTrigger:			UInt32;									{  ms, must be 10000 }
		echoTimeout:			UInt32;									{  ms, must be 10000 }
		echoRetries:			UInt32;									{  5 }
		compressionType:		UInt32;									{  3 }
		mruSize:				UInt32;									{  must be 1500 }
		upperMRULimit:			UInt32;									{  must be 4500 }
		lowerMRULimit:			UInt32;									{  must be 0 }
		txACCMap:				UInt32;									{  must be 0        }
		rcACCMap:				UInt32;									{  must be 0 }
		isNoLAPB:				UInt32;									{  must be 0 }
	END;



	{  OTCfgRemoteLogLevel is used as a field in OTCfgRemoteLogOptions. }
	OTCfgRemoteLogLevel 		= UInt32;
CONST
	kOTCfgRemoteLogLevelNormal	= 0;
	kOTCfgRemoteLogLevelVerbose	= 1;




	{
	   The OTCfgRemoteLogOptions preference controls the level
	   of logging done by ARA.
	}

TYPE
	OTCfgRemoteLogOptionsPtr = ^OTCfgRemoteLogOptions;
	OTCfgRemoteLogOptions = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		fType:					OSType;									{  must be 'lgop' }
		additionalPtr:			UInt32;									{  run-time use only, initialise to 0, read ignore & preserve }
		logLevel:				OTCfgRemoteLogLevel;					{  constants are given above }
		launchStatusApp:		UInt32;									{  0 for not launch, 1 for launch, Remote Access 3.5 and higher  }
		reserved:				ARRAY [0..2] OF UInt32;					{  must be zero }
	END;



	{
	   OTCfgRemotePassword holds the user's dialup password, in a scrambled
	   form.  You can use OTCfgEncrypt to scramble a password and OTCfgDecrypt
	   to descramble it.
	}
	OTCfgRemotePasswordPtr = ^OTCfgRemotePassword;
	OTCfgRemotePassword = RECORD
		data:					PACKED ARRAY [0..255] OF UInt8;
	END;



	{  OTCfgRemoteTerminal holds preferences used by the PPP terminal window. }
	OTCfgRemoteTerminalPtr = ^OTCfgRemoteTerminal;
	OTCfgRemoteTerminal = RECORD
		fVersion:				UInt32;									{  must be 1 }
		fLocalEcho:				BOOLEAN;								{  whether to echo typed characters, default false }
		fNonModal:				BOOLEAN;								{  must be false }
		fPowerUser:				BOOLEAN;								{  must be false }
		fQuitWhenPPPStarts:		BOOLEAN;								{  as set in the options dialog, default true }
		fDontAskVarStr:			BOOLEAN;								{  default false }
		fNoVarStrReplace:		BOOLEAN;								{  must be false }
		fLFAfterCR:				BOOLEAN;								{  must be false }
		fAskToSaveOnQuit:		BOOLEAN;								{  as set in the options dialog, default false }
		fWindowRect:			Rect;									{  must be zero }
		fTypedCharStyle:		SInt8;									{  style used for characters type,    default to bold   (2) }
		fPrintedCharStyle:		SInt8;									{  style used for characters printed, default to normal (0) }
		fEchoedCharStyle:		SInt8;									{  style used for characters echoed,  default to italic (1) }
		pad:					SInt8;									{  must be zero }
		fFontSize:				SInt16;									{  default is 9 }
		fFontName:				Str255;									{  default is "\pMonaco" on Roman systems }
	END;



	{
	   The OTCfgRemoteUserMode holds user mode preferences, such
	   as the current user mode and the admin password.
	}

	OTCfgRemoteUserModePtr = ^OTCfgRemoteUserMode;
	OTCfgRemoteUserMode = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		userMode:				OTCfgUserMode32;						{  current user mode }
		adminPassword:			Str255;									{  format not to be documented }
	END;



	{
	   The OTCfgRemoteX25 preference is used to hold information
	   about X.25 connections.  For standard dial-up connections,
	   all fields (except version) must be filled with zeroes.
	}
	OTCfgRemoteX25Ptr = ^OTCfgRemoteX25;
	OTCfgRemoteX25 = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		fType:					UInt32;									{  this and remaining fields must be 0 }
		additionalPtr:			UInt32;
		script:					FSSpec;
		address:				PACKED ARRAY [0..255] OF UInt8;
		userName:				PACKED ARRAY [0..255] OF UInt8;
		closedUserGroup:		PACKED ARRAY [0..4] OF UInt8;
		reverseCharge:			BOOLEAN;
	END;




	{
	   OTCfgRemoteServer is a meta-preference that points to the other active
	   preferences for the Remote Access server.
	}
	OTCfgRemoteServerPtr = ^OTCfgRemoteServer;
	OTCfgRemoteServer = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		configCount:			SInt16;									{  number of active configurations, must be 1 for personal server }
		configIDs:				ARRAY [0..0] OF SInt16;					{  array of IDs of active configurations, must have one entry containing 0 for personal server }
	END;



	{  The following types are used in the OTCfgRemoteServerPort preference. }
	OTCfgRemoteAnswerMode 		= UInt32;
CONST
	kOTCfgAnswerModeOff			= 0;							{  answering disabled }
	kOTCfgAnswerModeNormal		= 1;							{  answering enabled }
	kOTCfgAnswerModeTransfer	= 2;							{  answering as a callback server, not valid for personal server }
	kOTCfgAnswerModeCallback	= 3;							{  answering enabled in callback mode }


TYPE
	OTCfgRemoteNetworkProtocol 	= UInt32;
CONST
	kOTCfgNetProtoNone			= 0;
	kOTCfgNetProtoIP			= 1;							{  allow IPCP connections }
	kOTCfgNetProtoAT			= 2;							{  allow AppleTalk connections (ATCP, ARAP) }
	kOTCfgNetProtoAny			= 3;							{  allow connections of either type }


TYPE
	OTCfgRemoteNetAccessMode 	= UInt8;
CONST
	kOTCfgNetAccessModeUnrestricted = 0;						{  connected client can see things on server and things on server's network }
	kOTCfgNetAccessModeThisMacOnly = 1;							{  connected client can only see things on server machine }




	{
	   OTCfgRemoteServerPort holds the primary configuration information for
	   the personal server.
	}

TYPE
	OTCfgRemoteServerPortPtr = ^OTCfgRemoteServerPort;
	OTCfgRemoteServerPort = RECORD
		version:				UInt32;									{  see "Remote Access Versions" note, above }
		configID:				SInt16;									{  ID of this port config, matches element of configIDs array in OTCfgRemoteServer, must be 0 for personal server }
		password:				Str255;									{  security zone bypass password, plain text }
		answerMode:				OTCfgRemoteAnswerMode;					{  see values defined above }
		limitConnectTime:		BOOLEAN;								{  if true, following field limits duration of client connections }
		pad:					SInt8;									{  must be 0 }
		maxConnectSeconds:		UInt32;									{  seconds, default is 3600 }
		serialProtoFlags:		OTCfgRemoteProtocol;					{  see values defined above }
		networkProtoFlags:		OTCfgRemoteNetworkProtocol;				{  see values defined above }
		netAccessMode:			SInt8;									{  see values defined above }
		requiresCCL:			BOOLEAN;								{  must be true }
		portName:				PACKED ARRAY [0..63] OF CHAR;			{  C string, must be zero for personal server }
		serialLayerName:		PACKED ARRAY [0..35] OF CHAR;			{  C string, OT port name of serial port }
		localIPAddress:			UInt32;									{  IP address to offer to client }
	END;



	{
	   The OTCfgRemoteApplication preference holds preferences for the
	   Remote Access (or OT/PPP) application.
	}
	OTCfgRemoteApplicationPtr = ^OTCfgRemoteApplication;
	OTCfgRemoteApplication = RECORD
		version:				UInt32;									{  IMPORTANT: NOT a standard Remote Access version number, must be 3 for ARA, 1 for OT/PPP }
		fWindowPosition:		Point;									{  global coordinates, window position }
		tabChoice:				UInt32;									{  currently chosen tab in Options dialog, 1 for Redialing, 2 for Connection, 3 for Protocol }
		fUserMode:				OTCfgUserMode32;						{  current user mode }
		fSetupVisible:			UInt32;									{  "Setup" is disclosed (1) or not (0) }
	END;



	{	  ------------------ OLDROUTINENAMES ------------------   	}



	{
	   Older versions of this header file defined a lot of types and constants
	   that were inconsistently named and confusing.  This new version of the header
	   file has tidied up all of these definitions, as shown above.  For the
	   sake of source code compatibility, the previous definitions are still available,
	   but you have to define the compiler variable OLDROUTINENAMES to get them.
	   This is a temporary measure.  Apple will remove these definitions in a future
	   version of this header file.  You should start transitioning your source code
	   to the new definitions are soon as possible.
	}

{$IFC OLDROUTINENAMES }

CONST
	kOTCfgTypeStruct			= 'stru';
	kOTCfgTypeElement			= 'elem';
	kOTCfgTypeVector			= 'vect';

	{  OLDROUTINENAMES }

	{  Old, confusing names for common preference types. }

	kOTCfgTypeConfigName		= 'cnam';
	kOTCfgTypeConfigSelected	= 'ccfg';
	kOTCfgTypeUserLevel			= 'ulvl';
	kOTCfgTypeWindowPosition	= 'wpos';

	{  OLDROUTINENAMES }

	{
	   Old, protocol-specific names for common preferences.  If the preference
	   is still supported, the old name is just an alias for the new name.
	   If the preference isn't support, the old name is a straight constant,
	   and you should stop using it.
	}

	kOTCfgTypeAppleTalkVersion	= 'cvrs';
	kOTCfgTypeTCPcvrs			= 'cvrs';
	kOTCfgTypeTCPVersion		= 'cvrs';
	kOTCfgTypeTCPPort			= 'port';
	kOTCfgTypeAppleTalkPort		= 'port';
	kOTCfgTypeTCPProtocol		= 'prot';
	kOTCfgTypeAppleTalkProtocol	= 'prot';
	kOTCfgTypeAppleTalkPassword	= 'pwrd';
	kOTCfgTypeDNSPassword		= 'pwrd';
	kOTCfgTypeTCPPassword		= 'pwrd';
	kOTCfgTypeRemoteARAP		= 'arap';
	kOTCfgTypeRemoteAddress		= 'cadr';
	kOTCfgTypeRemoteChat		= 'ccha';
	kOTCfgTypeRemoteDialing		= 'cdia';
	kOTCfgTypeRemoteExtAddress	= 'cead';
	kOTCfgTypeRemoteClientLocks	= 'clks';
	kOTCfgTypeRemoteClientMisc	= 'cmsc';
	kOTCfgTypeRemoteConnect		= 'conn';
	kOTCfgTypeRemoteUser		= 'cusr';
	kOTCfgTypeRemoteDialAssist	= 'dass';
	kOTCfgTypeRemoteIPCP		= 'ipcp';
	kOTCfgTypeRemoteLCP			= 'lcp ';
	kOTCfgTypeRemoteLogOptions	= 'logo';
	kOTCfgTypeRemotePassword	= 'pass';
	kOTCfgTypeRemoteServer		= 'srvr';
	kOTCfgTypeRemoteTerminal	= 'term';
	kOTCfgTypeRemoteUserMode	= 'usmd';
	kOTCfgTypeRemoteX25			= 'x25 ';
	kOTCfgTypeRemoteApp			= 'capt';
	kOTCfgTypeRemotePort		= 'port';
	kOTCfgTypeAppleTalkPrefs	= 'atpf';
	kOTCfgTypeAppleTalkLocks	= 'lcks';
	kOTCfgTypeAppleTalkPortFamily = 'ptfm';
	kOTCfgTypeInfraredPrefs		= 'atpf';
	kOTCfgTypeInfraredGlobal	= 'irgo';
	kOTCfgTypeTCPdclt			= 'dclt';
	kOTCfgTypeTCPSearchList		= 'ihst';
	kOTCfgTypeTCPihst			= 'ihst';
	kOTCfgTypeTCPidns			= 'idns';
	kOTCfgTypeTCPServersList	= 'idns';
	kOTCfgTypeTCPiitf			= 'iitf';
	kOTCfgTypeTCPPrefs			= 'iitf';
	kOTCfgTypeTCPisdm			= 'isdm';
	kOTCfgTypeTCPDomainsList	= 'isdm';
	kOTCfgTypeTCPdcid			= 'dcid';
	kOTCfgTypeTCPdtyp			= 'dtyp';
	kOTCfgTypeTCPRoutersList	= 'irte';
	kOTCfgTypeTCPirte			= 'irte';
	kOTCfgTypeTCPstng			= 'stng';
	kOTCfgTypeTCPLocks			= 'stng';
	kOTCfgTypeTCPunld			= 'unld';
	kOTCfgTypeTCPUnloadType		= 'unld';
	kOTCfgTypeTCPalis			= 'alis';
	kOTCfgTypeTCPara			= 'ipcp';						{  defining this as 'ipcp' makes no sense, }
																{  but changing it to kOTCfgRemoteIPCPPref could break someone }
	kOTCfgTypeTCPDevType		= 'dvty';
	kOTCfgTypeModemModem		= 'ccl ';
	kOTCfgTypeModemLocks		= 'lkmd';
	kOTCfgTypeModemAdminPswd	= 'mdpw';
	kOTCfgTypeModemApp			= 'mapt';

	{  OLDROUTINENAMES }

	kOTCfgIndexAppleTalkAARP	= 0;
	kOTCfgIndexAppleTalkDDP		= 1;
	kOTCfgIndexAppleTalkNBP		= 2;
	kOTCfgIndexAppleTalkZIP		= 3;
	kOTCfgIndexAppleTalkATP		= 4;
	kOTCfgIndexAppleTalkADSP	= 5;
	kOTCfgIndexAppleTalkPAP		= 6;
	kOTCfgIndexAppleTalkASP		= 7;
	kOTCfgIndexAppleTalkLast	= 7;

	{  OLDROUTINENAMES }

	{  See OTCfgATalkGeneral. }

TYPE
	OTCfgAppleTalkPrefsPtr = ^OTCfgAppleTalkPrefs;
	OTCfgAppleTalkPrefs = RECORD
		fVersion:				UInt16;
		fNumPrefs:				UInt16;
		fPort:					UInt32;
		fLink:					Ptr;
		fPrefs:					ARRAY [0..7] OF Ptr;
	END;

	{  OLDROUTINENAMES }
	OTCfgAARPPrefs						= OTCfgATalkGeneralAARP;
	OTCfgAARPPrefsPtr 					= ^OTCfgAARPPrefs;
	{  OLDROUTINENAMES }
	OTCfgDDPPrefs						= OTCfgATalkGeneralDDP;
	OTCfgDDPPrefsPtr 					= ^OTCfgDDPPrefs;
	{  OLDROUTINENAMES }
	{  See OTCfgATalkGeneral. }
	OTCfgATPFPrefsPtr = ^OTCfgATPFPrefs;
	OTCfgATPFPrefs = RECORD
		fAT:					OTCfgAppleTalkPrefs;
		fAARP:					OTCfgAARPPrefs;
		fDDP:					OTCfgDDPPrefs;
		fFill:					PACKED ARRAY [0..121] OF CHAR;
	END;

	{  OLDROUTINENAMES }
	OTCfgIRPrefsPtr = ^OTCfgIRPrefs;
	OTCfgIRPrefs = RECORD
		fHdr:					CfgPrefsHeader;
		fPort:					UInt32;
		fPortSetting:			OTCfgIRPortSetting;
		fNotifyOnDisconnect:	BOOLEAN;
		fDisplayIRControlStrip:	BOOLEAN;
		fWindowPosition:		Point;
	END;

	{  OLDROUTINENAMES }
	OTCfgIRGlobalPtr = ^OTCfgIRGlobal;
	OTCfgIRGlobal = RECORD
		fHdr:					CfgPrefsHeader;							{  standard prefererences header }
		fOptions:				UInt32;									{  options bitmask }
		fNotifyMask:			UInt32;									{  Notification options. }
		fUnloadTimeout:			UInt32;									{  Unload timeout (in milliseconds) }
	END;

	{  OLDROUTINENAMES }
	OTCfgDHCPRecord						= OTCfgTCPDHCPLeaseInfo;
	OTCfgDHCPRecordPtr 					= ^OTCfgDHCPRecord;
	OTCfgHSTFPrefs						= OTCfgTCPSearchList;
	OTCfgHSTFPrefsPtr 					= ^OTCfgHSTFPrefs;
	OTCfgIRTEEntry						= OTCfgTCPRoutersListEntry;
	OTCfgIRTEEntryPtr 					= ^OTCfgIRTEEntry;
	OTCfgIRTEPrefs						= OTCfgTCPRoutersList;
	OTCfgIRTEPrefsPtr 					= ^OTCfgIRTEPrefs;
	{  OLDROUTINENAMES }
	{  Use OTCfgTCPDNSServersList instead of OTCfgIDNSPrefs. }

	OTCfgIDNSPrefsPtr = ^OTCfgIDNSPrefs;
	OTCfgIDNSPrefs = RECORD
		fCount:					INTEGER;
		fAddressesList:			UInt32;
	END;

	{  OLDROUTINENAMES }
	{   This is your worst case, a fixed size structure, tacked on after a variable length string. }
	{
	    This structure also contains an IP address and subnet mask that are not aligned on a four byte boundary.  
	    In order to avoid compiler warnings, and the possibility of code that won't work, 
	    these fields are defined here as four character arrays.  
	    It is suggested that BlockMoveData be used to copy to and from a field of type InetHost.  
	}
	{  OLDROUTINENAMES }

	OTCfgIITFPrefsPartPtr = ^OTCfgIITFPrefsPart;
	OTCfgIITFPrefsPart = RECORD
		path:					PACKED ARRAY [0..35] OF CHAR;
		module:					PACKED ARRAY [0..31] OF CHAR;
		framing:				UInt32;
	END;

	{  OLDROUTINENAMES }
	OTCfgIITFPrefsPtr = ^OTCfgIITFPrefs;
	OTCfgIITFPrefs = PACKED RECORD
		fCount:					INTEGER;
		fConfigMethod:			UInt8;
																		{     this structure IS packed! }
																		{     Followed by: }
		fIPAddress:				PACKED ARRAY [0..3] OF UInt8;
		fSubnetMask:			PACKED ARRAY [0..3] OF UInt8;
		fAppleTalkZone:			PACKED ARRAY [0..255] OF UInt8;
																		{     this structure IS packed! }
		fFiller:				UInt8;
		part:					OTCfgIITFPrefsPart;
	END;

	{  OLDROUTINENAMES }
	{  Use OTCfgTCPSearchDomains instead of OTCfgIDNSPrefs. }

	OTCfgISDMPrefsPtr = ^OTCfgISDMPrefs;
	OTCfgISDMPrefs = RECORD
		fCount:					INTEGER;
		fDomainsList:			Str255;
	END;

	{  OLDROUTINENAMES }
	OTCfgRemoteConfigModem				= OTCfgModemGeneral;
	OTCfgRemoteConfigModemPtr 			= ^OTCfgRemoteConfigModem;
	OTCfgModemAppPrefs					= OTCfgModemApplication;
	OTCfgModemAppPrefsPtr 				= ^OTCfgModemAppPrefs;
	{  OLDROUTINENAMES }

CONST
	kOTCfgRemoteMaxPasswordLength = 255;
	kOTCfgRemoteMaxPasswordSize	= 256;
	kOTCfgRemoteMaxUserNameLength = 255;
	kOTCfgRemoteMaxUserNameSize	= 256;
	kOTCfgRemoteMaxAddressLength = 255;
	kOTCfgRemoteMaxAddressSize	= 256;
	kOTCfgRemoteMaxServerNameLength = 32;
	kOTCfgRemoteMaxServerNameSize = 33;
	kOTCfgRemoteMaxMessageLength = 255;
	kOTCfgRemoteMaxMessageSize	= 256;
	kOTCfgRemoteMaxX25ClosedUserGroupLength = 4;
	kOTCfgRemoteInfiniteSeconds	= $FFFFFFFF;
	kOTCfgRemoteMinReminderMinutes = 1;
	kOTCfgRemoteChatScriptFileCreator = 'ttxt';
	kOTCfgRemoteChatScriptFileType = 'TEXT';
	kOTCfgRemoteMaxChatScriptLength = $8000;

	{  OLDROUTINENAMES }


TYPE
	OTCfgRemoteAddress					= OTCfgRemoteAlternateAddress;
	OTCfgRemoteAddressPtr 				= ^OTCfgRemoteAddress;
	{  OLDROUTINENAMES }
	OTCfgRemoteScriptPtr = ^OTCfgRemoteScript;
	OTCfgRemoteScript = RECORD
		version:				UInt32;
		fType:					UInt32;
		additional:				Ptr;
		scriptType:				UInt32;
		scriptLength:			UInt32;
		scriptData:				Ptr;
	END;

	{  OLDROUTINENAMES }
	OTCfgRemoteX25Info					= OTCfgRemoteX25;
	OTCfgRemoteX25InfoPtr 				= ^OTCfgRemoteX25Info;
	{  OLDROUTINENAMES }
	OTCfgRemoteConfigCAPT				= OTCfgRemoteApplication;
	OTCfgRemoteConfigCAPTPtr 			= ^OTCfgRemoteConfigCAPT;
	{  OLDROUTINENAMES }

	OTCfgRemoteUserMessagePtr = ^OTCfgRemoteUserMessage;
	OTCfgRemoteUserMessage = RECORD
		version:				UInt32;
		messageID:				SInt32;
		userMessage:			PACKED ARRAY [0..255] OF UInt8;
		userDiagnostic:			PACKED ARRAY [0..255] OF UInt8;
	END;

	{  OLDROUTINENAMES }
	OTCfgRemoteDisconnectPtr = ^OTCfgRemoteDisconnect;
	OTCfgRemoteDisconnect = RECORD
		whenSeconds:			UInt32;
		showStatus:				UInt32;
	END;

	{  OLDROUTINENAMES }
	OTCfgRemoteIsRemotePtr = ^OTCfgRemoteIsRemote;
	OTCfgRemoteIsRemote = RECORD
		net:					UInt32;
		node:					UInt32;
		isRemote:				UInt32;
	END;

	{  OLDROUTINENAMES }
	OTCfgRemoteConnectInfoPtr = ^OTCfgRemoteConnectInfo;
	OTCfgRemoteConnectInfo = RECORD
		connectInfo:			OTCfgRemoteConnectPtr;
	END;

	{  OLDROUTINENAMES }

CONST
	kOTCfgRemoteStatusIdle		= 1;
	kOTCfgRemoteStatusConnecting = 2;
	kOTCfgRemoteStatusConnected	= 3;
	kOTCfgRemoteStatusDisconnecting = 4;

	{  OLDROUTINENAMES }


TYPE
	OTCfgRemoteStatusPtr = ^OTCfgRemoteStatus;
	OTCfgRemoteStatus = RECORD
		status:					UInt32;
		answerEnabled:			BOOLEAN;
		pad00:					SInt8;
		secondsConnected:		UInt32;
		secondsRemaining:		UInt32;
		userName:				PACKED ARRAY [0..255] OF UInt8;
		serverName:				PACKED ARRAY [0..32] OF UInt8;
		pad01:					SInt8;
		messageIndex:			UInt32;
		message:				PACKED ARRAY [0..255] OF UInt8;
		serialProtocolMode:		UInt32;
		baudMessage:			PACKED ARRAY [0..255] OF UInt8;
		isServer:				BOOLEAN;
		pad02:					SInt8;
		bytesIn:				UInt32;
		bytesOut:				UInt32;
		linkSpeed:				UInt32;
		localIPAddress:			UInt32;
		remoteIPAddress:		UInt32;
	END;

	{  OLDROUTINENAMES }
	OTCfgRemoteEventCode				= UInt32;
	{  OLDROUTINENAMES }
{$IFC TYPED_FUNCTION_POINTERS}
	RANotifyProcPtr = PROCEDURE(contextPtr: UNIV Ptr; code: OTCfgRemoteEventCode; result: OSStatus; cookie: UNIV Ptr); C;
{$ELSEC}
	RANotifyProcPtr = ProcPtr;
{$ENDC}

	{  OLDROUTINENAMES }
	OTCfgRemoteNotifierPtr = ^OTCfgRemoteNotifier;
	OTCfgRemoteNotifier = RECORD
		procPtr:				RANotifyProcPtr;
		contextPtr:				Ptr;
	END;

	{  OLDROUTINENAMES }
	OTCfgRemoteRequestPtr = ^OTCfgRemoteRequest;
	OTCfgRemoteRequest = RECORD
		reserved1:				ARRAY [0..15] OF SInt8;
		result:					OSErr;
		reserved2:				ARRAY [0..7] OF SInt8;
		requestCode:			SInt16;
		portId:					SInt16;
		CASE INTEGER OF
		0: (
			Notifier:			OTCfgRemoteNotifier;
			);
		1: (
			Connect:			OTCfgRemoteConnect;
			);
		2: (
			Disconnect:			OTCfgRemoteDisconnect;
			);
		3: (
			Status:				OTCfgRemoteStatus;
			);
		4: (
			IsRemote:			OTCfgRemoteIsRemote;
			);
		5: (
			ConnectInfo:		OTCfgRemoteConnectInfo;
			);
	END;

{$ENDC}  {OLDROUTINENAMES}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NetworkSetupIncludes}

{$ENDC} {__NETWORKSETUP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
