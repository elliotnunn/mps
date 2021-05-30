{
     File:       Aliases.p
 
     Contains:   Alias Manager Interfaces.
 
     Version:    Technology: Mac OS 8.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1989-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Aliases;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ALIASES__}
{$SETC __ALIASES__ := 1}

{$I+}
{$SETC AliasesIncludes := UsingIncludes}
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


CONST
	rAliasType					= 'alis';						{  Aliases are stored as resources of this type  }

																{  define alias resolution action rules mask  }
	kARMMountVol				= $00000001;					{  mount the volume automatically  }
	kARMNoUI					= $00000002;					{  no user interface allowed during resolution  }
	kARMMultVols				= $00000008;					{  search on multiple volumes  }
	kARMSearch					= $00000100;					{  search quickly  }
	kARMSearchMore				= $00000200;					{  search further  }
	kARMSearchRelFirst			= $00000400;					{  search target on a relative path first  }

																{  define alias record information types  }
	asiZoneName					= -3;							{  get zone name  }
	asiServerName				= -2;							{  get server name  }
	asiVolumeName				= -1;							{  get volume name  }
	asiAliasName				= 0;							{  get aliased file/folder/volume name  }
	asiParentName				= 1;							{  get parent folder name  }

	{	 ResolveAliasFileWithMountFlags options 	}
	kResolveAliasFileNoUI		= $00000001;					{  no user interaction during resolution  }

	{	 define the alias record that will be the blackbox for the caller 	}

TYPE
	AliasRecordPtr = ^AliasRecord;
	AliasRecord = RECORD
		userType:				OSType;									{  appl stored type like creator type  }
		aliasSize:				UInt16;									{  alias record size in bytes, for appl usage  }
	END;

	AliasPtr							= ^AliasRecord;
	AliasHandle							= ^AliasPtr;
	{	 alias record information type 	}
	AliasInfoType						= INTEGER;
	{
	 *  NewAlias()
	 *  
	 *  Summary:
	 *    create a new alias between fromFile and target, returns alias
	 *    record handle
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewAlias(fromFile: {Const}FSSpecPtr; {CONST}VAR target: FSSpec; VAR alias: AliasHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $A823;
	{$ENDC}

{
 *  NewAliasMinimal()
 *  
 *  Summary:
 *    create a minimal new alias for a target and return alias record
 *    handle
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewAliasMinimal({CONST}VAR target: FSSpec; VAR alias: AliasHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $A823;
	{$ENDC}

{
 *  NewAliasMinimalFromFullPath()
 *  
 *  Summary:
 *    create a minimal new alias from a target fullpath (optional zone
 *    and server name) and return alias record handle
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewAliasMinimalFromFullPath(fullPathLength: INTEGER; fullPath: UNIV Ptr; zoneName: Str32; serverName: Str31; VAR alias: AliasHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $A823;
	{$ENDC}

{
 *  ResolveAlias()
 *  
 *  Summary:
 *    given an alias handle and fromFile, resolve the alias, update the
 *    alias record and return aliased filename and wasChanged flag.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ResolveAlias(fromFile: {Const}FSSpecPtr; alias: AliasHandle; VAR target: FSSpec; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $A823;
	{$ENDC}

{
 *  GetAliasInfo()
 *  
 *  Summary:
 *    given an alias handle and an index specifying requested alias
 *    information type, return the information from alias record as a
 *    string.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetAliasInfo(alias: AliasHandle; index: AliasInfoType; VAR theString: Str63): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $A823;
	{$ENDC}


{
 *  IsAliasFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsAliasFile({CONST}VAR fileFSSpec: FSSpec; VAR aliasFileFlag: BOOLEAN; VAR folderFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702A, $A823;
	{$ENDC}

{
 *  ResolveAliasWithMountFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ResolveAliasWithMountFlags(fromFile: {Const}FSSpecPtr; alias: AliasHandle; VAR target: FSSpec; VAR wasChanged: BOOLEAN; mountFlags: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702B, $A823;
	{$ENDC}

{
 *  ResolveAliasFile()
 *  
 *  Summary:
 *    Given a file spec, return target file spec if input file spec is
 *    an alias. It resolves the entire alias chain or one step of the
 *    chain.  It returns info about whether the target is a folder or
 *    file; and whether the input file spec was an alias or not.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ResolveAliasFile(VAR theSpec: FSSpec; resolveAliasChains: BOOLEAN; VAR targetIsFolder: BOOLEAN; VAR wasAliased: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $A823;
	{$ENDC}


{
 *  ResolveAliasFileWithMountFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ResolveAliasFileWithMountFlags(VAR theSpec: FSSpec; resolveAliasChains: BOOLEAN; VAR targetIsFolder: BOOLEAN; VAR wasAliased: BOOLEAN; mountFlags: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7029, $A823;
	{$ENDC}

{
 *  FollowFinderAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FollowFinderAlias(fromFile: {Const}FSSpecPtr; alias: AliasHandle; logon: BOOLEAN; VAR target: FSSpec; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $A823;
	{$ENDC}

{ 
   Low Level Routines 
}
{
 *  UpdateAlias()
 *  
 *  Summary:
 *    given a fromFile-target pair and an alias handle, update the
 *    alias record pointed to by alias handle to represent target as
 *    the new alias.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UpdateAlias(fromFile: {Const}FSSpecPtr; {CONST}VAR target: FSSpec; alias: AliasHandle; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $A823;
	{$ENDC}



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	AliasFilterProcPtr = FUNCTION(cpbPtr: CInfoPBPtr; VAR quitFlag: BOOLEAN; myDataPtr: Ptr): BOOLEAN;
{$ELSEC}
	AliasFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	AliasFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AliasFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppAliasFilterProcInfo = $00000FD0;
	{
	 *  NewAliasFilterUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewAliasFilterUPP(userRoutine: AliasFilterProcPtr): AliasFilterUPP; { old name was NewAliasFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeAliasFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAliasFilterUPP(userUPP: AliasFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeAliasFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeAliasFilterUPP(cpbPtr: CInfoPBPtr; VAR quitFlag: BOOLEAN; myDataPtr: Ptr; userRoutine: AliasFilterUPP): BOOLEAN; { old name was CallAliasFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  MatchAlias()
 *  
 *  Summary:
 *    Given an alias handle and fromFile, match the alias and return
 *    aliased filename(s) and needsUpdate flag
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MatchAlias(fromFile: {Const}FSSpecPtr; rulesMask: UInt32; alias: AliasHandle; VAR aliasCount: INTEGER; aliasList: FSSpecArrayPtr; VAR needsUpdate: BOOLEAN; aliasFilter: AliasFilterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $A823;
	{$ENDC}



{
 *  ResolveAliasFileWithMountFlagsNoUI()
 *  
 *  Summary:
 *    variation on ResolveAliasFile that does not prompt user with a
 *    dialog
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ResolveAliasFileWithMountFlagsNoUI(VAR theSpec: FSSpec; resolveAliasChains: BOOLEAN; VAR targetIsFolder: BOOLEAN; VAR wasAliased: BOOLEAN; mountFlags: UInt32): OSErr;

{
 *  MatchAliasNoUI()
 *  
 *  Summary:
 *    variation on MatchAlias that does not prompt user with a dialog
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MatchAliasNoUI(fromFile: {Const}FSSpecPtr; rulesMask: UInt32; alias: AliasHandle; VAR aliasCount: INTEGER; aliasList: FSSpecArrayPtr; VAR needsUpdate: BOOLEAN; aliasFilter: AliasFilterUPP; yourDataPtr: UNIV Ptr): OSErr;

{
 *  FSNewAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSNewAlias(fromFile: {Const}FSRefPtr; {CONST}VAR target: FSRef; VAR inAlias: AliasHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7036, $A823;
	{$ENDC}

{
 *  FSNewAliasMinimal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSNewAliasMinimal({CONST}VAR target: FSRef; VAR inAlias: AliasHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7037, $A823;
	{$ENDC}

{
 *  FSIsAliasFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSIsAliasFile({CONST}VAR fileRef: FSRef; VAR aliasFileFlag: BOOLEAN; VAR folderFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7038, $A823;
	{$ENDC}


{
 *  FSResolveAliasWithMountFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSResolveAliasWithMountFlags(fromFile: {Const}FSRefPtr; inAlias: AliasHandle; VAR target: FSRef; VAR wasChanged: BOOLEAN; mountFlags: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7039, $A823;
	{$ENDC}


{
 *  FSResolveAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSResolveAlias(fromFile: {Const}FSRefPtr; alias: AliasHandle; VAR target: FSRef; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703A, $A823;
	{$ENDC}


{
 *  FSResolveAliasFileWithMountFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSResolveAliasFileWithMountFlags(VAR theRef: FSRef; resolveAliasChains: BOOLEAN; VAR targetIsFolder: BOOLEAN; VAR wasAliased: BOOLEAN; mountFlags: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703B, $A823;
	{$ENDC}


{
 *  FSResolveAliasFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSResolveAliasFile(VAR theRef: FSRef; resolveAliasChains: BOOLEAN; VAR targetIsFolder: BOOLEAN; VAR wasAliased: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703C, $A823;
	{$ENDC}


{
 *  FSFollowFinderAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSFollowFinderAlias(fromFile: FSRefPtr; alias: AliasHandle; logon: BOOLEAN; VAR target: FSRef; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703D, $A823;
	{$ENDC}

{
 *  FSUpdateAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FSUpdateAlias(fromFile: {Const}FSRefPtr; {CONST}VAR target: FSRef; alias: AliasHandle; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703E, $A823;
	{$ENDC}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AliasesIncludes}

{$ENDC} {__ALIASES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
