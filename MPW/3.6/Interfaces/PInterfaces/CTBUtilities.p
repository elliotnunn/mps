{
     File:       CTBUtilities.p
 
     Contains:   Communications Toolbox Utilities interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1988-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CTBUtilities;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CTBUTILITIES__}
{$SETC __CTBUTILITIES__ := 1}

{$I+}
{$SETC CTBUtilitiesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }

CONST
	curCTBUVersion				= 2;							{  version of Comm Toolbox Utilities }

																{     Error codes/types     }
	ctbuGenericError			= -1;
	ctbuNoErr					= 0;


TYPE
	CTBUErr								= OSErr;
	ChooseReturnCode 			= SInt16;
CONST
	chooseDisaster				= -2;
	chooseFailed				= -1;
	chooseAborted				= 0;
	chooseOKMinor				= 1;
	chooseOKMajor				= 2;
	chooseCancel				= 3;


TYPE
	NuLookupReturnCode 			= UInt16;
CONST
	nlOk						= 0;
	nlCancel					= 1;
	nlEject						= 2;


TYPE
	NameFilterReturnCode 		= UInt16;
CONST
	nameInclude					= 1;
	nameDisable					= 2;
	nameReject					= 3;


TYPE
	ZoneFilterReturnCode 		= UInt16;
CONST
	zoneInclude					= 1;
	zoneDisable					= 2;
	zoneReject					= 3;


																{     Values for hookProc items    }
	hookOK						= 1;
	hookCancel					= 2;
	hookOutline					= 3;
	hookTitle					= 4;
	hookItemList				= 5;
	hookZoneTitle				= 6;
	hookZoneList				= 7;
	hookLine					= 8;
	hookVersion					= 9;
	hookReserved1				= 10;
	hookReserved2				= 11;
	hookReserved3				= 12;
	hookReserved4				= 13;							{     "virtual" hookProc items    }
	hookNull					= 100;
	hookItemRefresh				= 101;
	hookZoneRefresh				= 102;
	hookEject					= 103;
	hookPreflight				= 104;
	hookPostflight				= 105;
	hookKeyBase					= 1000;


	{	  NuLookup structures/constants   	}

TYPE
	NLTypeEntryPtr = ^NLTypeEntry;
	NLTypeEntry = RECORD
		hIcon:					Handle;
		typeStr:				Str32;
	END;

	NLType								= ARRAY [0..3] OF NLTypeEntry;
	NBPReplyPtr = ^NBPReply;
	NBPReply = RECORD
		theEntity:				EntityName;
		theAddr:				AddrBlock;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	DialogHookProcPtr = FUNCTION(item: INTEGER; theDialog: DialogRef): INTEGER;
{$ELSEC}
	DialogHookProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	NameFilterProcPtr = FUNCTION({CONST}VAR theEntity: EntityName): INTEGER;
{$ELSEC}
	NameFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ZoneFilterProcPtr = FUNCTION(theZone: Str32): INTEGER;
{$ELSEC}
	ZoneFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DialogHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DialogHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NameFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NameFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ZoneFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ZoneFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDialogHookProcInfo = $000003A0;
	uppNameFilterProcInfo = $000000E0;
	uppZoneFilterProcInfo = $000000E0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewDialogHookUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewDialogHookUPP(userRoutine: DialogHookProcPtr): DialogHookUPP; { old name was NewDialogHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNameFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewNameFilterUPP(userRoutine: NameFilterProcPtr): NameFilterUPP; { old name was NewNameFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewZoneFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewZoneFilterUPP(userRoutine: ZoneFilterProcPtr): ZoneFilterUPP; { old name was NewZoneFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDialogHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDialogHookUPP(userUPP: DialogHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNameFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeNameFilterUPP(userUPP: NameFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeZoneFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeZoneFilterUPP(userUPP: ZoneFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDialogHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeDialogHookUPP(item: INTEGER; theDialog: DialogRef; userRoutine: DialogHookUPP): INTEGER; { old name was CallDialogHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeNameFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeNameFilterUPP({CONST}VAR theEntity: EntityName; userRoutine: NameFilterUPP): INTEGER; { old name was CallNameFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeZoneFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeZoneFilterUPP(theZone: Str32; userRoutine: ZoneFilterUPP): INTEGER; { old name was CallZoneFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InitCTBUtilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitCTBUtilities: CTBUErr;

{
 *  CTBGetCTBVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CTBGetCTBVersion: INTEGER;

{
 *  StandardNBP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StandardNBP(where: Point; prompt: Str255; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; VAR theReply: NBPReply): INTEGER;

{
 *  CustomNBP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CustomNBP(where: Point; prompt: Str255; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; userData: LONGINT; dialogID: INTEGER; filter: ModalFilterUPP; VAR theReply: NBPReply): INTEGER;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  NuLookup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NuLookup(where: Point; prompt: Str255; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; VAR theReply: NBPReply): INTEGER;

{
 *  NuPLookup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NuPLookup(where: Point; prompt: Str255; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; userData: LONGINT; dialogID: INTEGER; filter: ModalFilterUPP; VAR theReply: NBPReply): INTEGER;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CTBUtilitiesIncludes}

{$ENDC} {__CTBUTILITIES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
