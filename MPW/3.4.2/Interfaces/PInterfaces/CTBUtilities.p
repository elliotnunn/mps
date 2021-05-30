{
 	File:		CTBUtilities.p
 
 	Contains:	Communications Toolbox Utilities interfaces.
 
 	Version:	Technology:	System 7.5
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
 UNIT CTBUtilities;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CTBUTILITIES__}
{$SETC __CTBUTILITIES__ := 1}

{$I+}
{$SETC CTBUtilitiesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	Errors.p													}
{	Menus.p														}
{		Quickdraw.p												}
{			QuickdrawText.p										}
{	Controls.p													}
{	Windows.p													}
{		Events.p												}
{			OSUtils.p											}
{	TextEdit.p													}

{$IFC UNDEFINED __STANDARDFILE__}
{$I StandardFile.p}
{$ENDC}
{	Files.p														}
{		Finder.p												}

{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{	version of Comm Toolbox Utilities	}
	curCTBUVersion				= 2;
{    Error codes/types    }
	ctbuGenericError			= -1;
	ctbuNoErr					= 0;

	
TYPE
	CTBUErr = OSErr;


CONST
	chooseDisaster				= -2;
	chooseFailed				= -1;
	chooseAborted				= 0;
	chooseOKMinor				= 1;
	chooseOKMajor				= 2;
	chooseCancel				= 3;

	
TYPE
	ChooseReturnCode = INTEGER;


CONST
	nlOk						= 0;
	nlCancel					= 1;
	nlEject						= 2;

	
TYPE
	NuLookupReturnCode = INTEGER;


CONST
	nameInclude					= 1;
	nameDisable					= 2;
	nameReject					= 3;

	
TYPE
	NameFilterReturnCode = INTEGER;


CONST
	zoneInclude					= 1;
	zoneDisable					= 2;
	zoneReject					= 3;

	
TYPE
	ZoneFilterReturnCode = INTEGER;

	DialogHookProcPtr = ProcPtr;  { FUNCTION DialogHook(item: INTEGER; theDialog: DialogPtr): INTEGER; }
	DialogHookUPP = UniversalProcPtr;

CONST
	uppDialogHookProcInfo = $000003A0; { FUNCTION (2 byte param, 4 byte param): 2 byte result; }

FUNCTION NewDialogHookProc(userRoutine: DialogHookProcPtr): DialogHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDialogHookProc(item: INTEGER; theDialog: DialogPtr; userRoutine: DialogHookUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

CONST
{	Values for hookProc items		}
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
	hookReserved4				= 13;
{	"virtual" hookProc items	}
	hookNull					= 100;
	hookItemRefresh				= 101;
	hookZoneRefresh				= 102;
	hookEject					= 103;
	hookPreflight				= 104;
	hookPostflight				= 105;
	hookKeyBase					= 1000;

{	NuLookup structures/constants	}

TYPE
	NLTypeEntry = RECORD
		hIcon:					Handle;
		typeStr:				Str32;
	END;

	NLType = ARRAY [0..3] OF NLTypeEntry;

	NBPReply = RECORD
		theEntity:				EntityName;
		theAddr:				AddrBlock;
	END;

	NameFilterProcPtr = ProcPtr;  { FUNCTION NameFilter((CONST)VAR theEntity: EntityName): INTEGER; }
	NameFilterUPP = UniversalProcPtr;

CONST
	uppNameFilterProcInfo = $000000E0; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewNameFilterProc(userRoutine: NameFilterProcPtr): NameFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallNameFilterProc(VAR theEntity: EntityName; userRoutine: NameFilterUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
TYPE
	ZoneFilterProcPtr = ProcPtr;  { FUNCTION ZoneFilter(theZone: ConstStr32Param): INTEGER; }
	ZoneFilterUPP = UniversalProcPtr;

CONST
	uppZoneFilterProcInfo = $000000E0; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewZoneFilterProc(userRoutine: ZoneFilterProcPtr): ZoneFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallZoneFilterProc(theZone: ConstStr32Param; userRoutine: ZoneFilterUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION InitCTBUtilities: CTBUErr;
FUNCTION CTBGetCTBVersion: INTEGER;
FUNCTION StandardNBP(where: Point; prompt: ConstStr255Param; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; VAR theReply: NBPReply): INTEGER;
FUNCTION CustomNBP(where: Point; prompt: ConstStr255Param; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; userData: LONGINT; dialogID: INTEGER; filter: ModalFilterUPP; VAR theReply: NBPReply): INTEGER;
{$IFC OLDROUTINENAMES }
FUNCTION NuLookup(where: Point; prompt: ConstStr255Param; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; VAR theReply: NBPReply): INTEGER;
FUNCTION NuPLookup(where: Point; prompt: ConstStr255Param; numTypes: INTEGER; VAR typeList: NLType; nameFilter: NameFilterUPP; zoneFilter: ZoneFilterUPP; hook: DialogHookUPP; userData: LONGINT; dialogID: INTEGER; filter: ModalFilterUPP; VAR theReply: NBPReply): INTEGER;
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CTBUtilitiesIncludes}

{$ENDC} {__CTBUTILITIES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
