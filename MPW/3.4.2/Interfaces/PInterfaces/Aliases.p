{
 	File:		Aliases.p
 
 	Contains:	Alias Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
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
 UNIT Aliases;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ALIASES__}
{$SETC __ALIASES__ := 1}

{$I+}
{$SETC AliasesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}
{	OSUtils.p													}
{		MixedMode.p												}
{		Memory.p												}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	Finder.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	rAliasType					= 'alis';						{ Aliases are stored as resources of this type }
{ define alias resolution action rules mask }
	kARMMountVol				= $00000001;					{ mount the volume automatically }
	kARMNoUI					= $00000002;					{ no user interface allowed during resolution }
	kARMMultVols				= $00000008;					{ search on multiple volumes }
	kARMSearch					= $00000100;					{ search quickly }
	kARMSearchMore				= $00000200;					{ search further }
	kARMSearchRelFirst			= $00000400;					{ search target on a relative path first }
{ define alias record information types }
	asiZoneName					= -3;							{ get zone name }
	asiServerName				= -2;							{ get server name }
	asiVolumeName				= -1;							{ get volume name }
	asiAliasName				= 0;							{ get aliased file/folder/volume name }
	asiParentName				= 1;							{ get parent folder name }

{ define the alias record that will be the blackbox for the caller }

TYPE
	AliasRecord = RECORD
		userType:				OSType;									{ appl stored type like creator type }
		aliasSize:				INTEGER;								{ alias record size in bytes, for appl usage }
	END;

	AliasPtr = ^AliasRecord;
	AliasHandle = ^AliasPtr;

{ alias record information type }
	AliasInfoType = INTEGER;

	AliasFilterProcPtr = ProcPtr;  { FUNCTION AliasFilter(cpbPtr: CInfoPBPtr; VAR quitFlag: BOOLEAN; myDataPtr: Ptr): BOOLEAN; }
	AliasFilterUPP = UniversalProcPtr;

CONST
	uppAliasFilterProcInfo = $00000FD0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 1 byte result; }

FUNCTION NewAliasFilterProc(userRoutine: AliasFilterProcPtr): AliasFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallAliasFilterProc(cpbPtr: CInfoPBPtr; VAR quitFlag: BOOLEAN; myDataPtr: Ptr; userRoutine: AliasFilterUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewAlias(fromFile: ConstFSSpecPtr; {CONST}VAR target: FSSpec; VAR alias: AliasHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $A823;
	{$ENDC}
{ create a minimal new alias for a target and return alias record handle }
FUNCTION NewAliasMinimal({CONST}VAR target: FSSpec; VAR alias: AliasHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $A823;
	{$ENDC}
{ create a minimal new alias from a target fullpath (optional zone and server name) and return alias record handle  }
FUNCTION NewAliasMinimalFromFullPath(fullPathLength: INTEGER; fullPath: UNIV Ptr; zoneName: ConstStr32Param; serverName: ConstStr31Param; VAR alias: AliasHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $A823;
	{$ENDC}
{ given an alias handle and fromFile, resolve the alias, update the alias record and return aliased filename and wasChanged flag. }
FUNCTION ResolveAlias(fromFile: ConstFSSpecPtr; alias: AliasHandle; VAR target: FSSpec; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $A823;
	{$ENDC}
{ given an alias handle and an index specifying requested alias information type, return the information from alias record as a string. }
FUNCTION GetAliasInfo(alias: AliasHandle; index: AliasInfoType; VAR theString: Str63): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $A823;
	{$ENDC}
{ 
  Given a file spec, return target file spec if input file spec is an alias.
  It resolves the entire alias chain or one step of the chain.  It returns
  info about whether the target is a folder or file; and whether the input
  file spec was an alias or not. 
}
FUNCTION ResolveAliasFile(VAR theSpec: FSSpec; resolveAliasChains: BOOLEAN; VAR targetIsFolder: BOOLEAN; VAR wasAliased: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $A823;
	{$ENDC}
FUNCTION FollowFinderAlias(fromFile: ConstFSSpecPtr; alias: AliasHandle; logon: BOOLEAN; VAR target: FSSpec; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $A823;
	{$ENDC}
{ 
   Low Level Routines 
 Given an alias handle and fromFile, match the alias and return aliased filename(s) and needsUpdate flag
}
FUNCTION MatchAlias(fromFile: ConstFSSpecPtr; rulesMask: LONGINT; alias: AliasHandle; VAR aliasCount: INTEGER; aliasList: FSSpecArrayPtr; VAR needsUpdate: BOOLEAN; aliasFilter: AliasFilterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $A823;
	{$ENDC}
{ given a fromFile-target pair and an alias handle, update the lias record pointed to by alias handle to represent target as the new alias. }
FUNCTION UpdateAlias(fromFile: ConstFSSpecPtr; {CONST}VAR target: FSSpec; alias: AliasHandle; VAR wasChanged: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $A823;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AliasesIncludes}

{$ENDC} {__ALIASES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
