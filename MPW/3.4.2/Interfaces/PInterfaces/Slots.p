{
 	File:		Slots.p
 
 	Contains:	Slot Manager Interfaces.
 
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
 UNIT Slots;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SLOTS__}
{$SETC __SLOTS__ := 1}

{$I+}
{$SETC SlotsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	OSUtils.p													}
{		Memory.p												}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	Finder.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	fCardIsChanged				= 1;							{Card is Changed field in StatusFlags field of sInfoArray}
	fCkForSame					= 0;							{For SearchSRT. Flag to check for SAME sResource in the table. }
	fCkForNext					= 1;							{For SearchSRT. Flag to check for NEXT sResource in the table. }
	fWarmStart					= 2;							{If this bit is set then warm start else cold start.}

	stateNil					= 0;							{State}
	stateSDMInit				= 1;							{:Slot declaration manager Init}
	statePRAMInit				= 2;							{:sPRAM record init}
	statePInit					= 3;							{:Primary init}
	stateSInit					= 4;							{:Secondary init}
{ flags for spParamData }
	fall						= 0;							{ bit 0: set=search enabled/disabled sRsrc's }
	foneslot					= 1;							{    1: set=search sRsrc's in given slot only }
	fnext						= 2;							{    2: set=search for next sRsrc }
{ Misc masks }
	catMask						= $08;							{ sets spCategory field of spTBMask (bit 3) }
	cTypeMask					= $04;							{ sets spCType    field of spTBMask (bit 2) }
	drvrSWMask					= $02;							{ sets spDrvrSW   field of spTBMask (bit 1) }
	drvrHWMask					= $01;							{ sets spDrvrHW	  field of spTBMask (bit 0) }

TYPE
	{
		SlotIntServiceProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => sqParameter 	A1.L
		Out:
		 <= return value	D0.W
	}
	SlotIntServiceProcPtr = Register68kProcPtr;  { register FUNCTION SlotIntService(sqParameter: LONGINT): INTEGER; }
	SlotIntServiceUPP = UniversalProcPtr;

CONST
	uppSlotIntServiceProcInfo = $0000B822; { Register FUNCTION (4 bytes in A1): 2 bytes in D0; }

FUNCTION NewSlotIntServiceProc(userRoutine: SlotIntServiceProcPtr): SlotIntServiceUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallSlotIntServiceProc(sqParameter: LONGINT; userRoutine: SlotIntServiceUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

TYPE
	SlotIntQElement = RECORD
		sqLink:					Ptr;									{ptr to next element}
		sqType:					INTEGER;								{queue type ID for validity}
		sqPrio:					INTEGER;								{priority}
		sqAddr:					SlotIntServiceUPP;						{interrupt service routine}
		sqParm:					LONGINT;								{optional A1 parameter}
	END;

	SQElemPtr = ^SlotIntQElement;

	SpBlock = RECORD
		spResult:				LONGINT;								{FUNCTION Result}
		spsPointer:				Ptr;									{structure pointer}
		spSize:					LONGINT;								{size of structure}
		spOffsetData:			LONGINT;								{offset/data field used by sOffsetData}
		spIOFileName:			Ptr;									{ptr to IOFile name for sDisDrvrName}
		spsExecPBlk:			Ptr;									{pointer to sExec parameter block.}
		spParamData:			LONGINT;								{misc parameter data (formerly spStackPtr).}
		spMisc:					LONGINT;								{misc field for SDM.}
		spReserved:				LONGINT;								{reserved for future expansion}
		spIOReserved:			INTEGER;								{Reserved field of Slot Resource Table}
		spRefNum:				INTEGER;								{RefNum}
		spCategory:				INTEGER;								{sType: Category}
		spCType:				INTEGER;								{Type}
		spDrvrSW:				INTEGER;								{DrvrSW}
		spDrvrHW:				INTEGER;								{DrvrHW}
		spTBMask:				SInt8;									{type bit mask bits 0..3 mask words 0..3}
		spSlot:					SInt8;									{slot number}
		spID:					SInt8;									{structure ID}
		spExtDev:				SInt8;									{ID of the external device}
		spHwDev:				SInt8;									{Id of the hardware device.}
		spByteLanes:			SInt8;									{bytelanes from card ROM format block}
		spFlags:				SInt8;									{standard flags}
		spKey:					SInt8;									{Internal use only}
	END;

	SpBlockPtr = ^SpBlock;

	SInfoRecord = RECORD
		siDirPtr:				Ptr;									{Pointer to directory}
		siInitStatusA:			INTEGER;								{initialization E}
		siInitStatusV:			INTEGER;								{status returned by vendor init code}
		siState:				SInt8;									{initialization state}
		siCPUByteLanes:			SInt8;									{0=[d0..d7] 1=[d8..d15]}
		siTopOfROM:				SInt8;									{Top of ROM= $FssFFFFx: x is TopOfROM}
		siStatusFlags:			SInt8;									{bit 0 - card is changed}
		siTOConst:				INTEGER;								{Time Out C for BusErr}
		siReserved:				ARRAY [0..1] OF SInt8;					{reserved}
		siROMAddr:				Ptr;									{ addr of top of ROM }
		siSlot:					SInt8;									{ slot number }
		siPadding:				ARRAY [0..2] OF SInt8;					{ reserved }
	END;

	SInfoRecPtr = ^SInfoRecord;

	SDMRecord = RECORD
		sdBEVSave:				ProcPtr;								{Save old BusErr vector}
		sdBusErrProc:			ProcPtr;								{Go here to determine if it is a BusErr}
		sdErrorEntry:			ProcPtr;								{Go here if BusErrProc finds real BusErr}
		sdReserved:				LONGINT;								{Reserved}
	END;

	FHeaderRec = RECORD
		fhDirOffset:			LONGINT;								{offset to directory}
		fhLength:				LONGINT;								{length of ROM}
		fhCRC:					LONGINT;								{CRC}
		fhROMRev:				SInt8;									{revision of ROM}
		fhFormat:				SInt8;									{format - 2}
		fhTstPat:				LONGINT;								{test pattern}
		fhReserved:				SInt8;									{reserved}
		fhByteLanes:			SInt8;									{ByteLanes}
	END;

	FHeaderRecPtr = ^FHeaderRec;

{ }
{ 	Extended Format header block  -  extended declaration ROM format header for super sRsrc directories.	<H2><SM0>}
{ }
	XFHeaderRec = RECORD
		fhXSuperInit:			LONGINT;								{Offset to SuperInit SExecBlock	<fhFormat,offset>}
		fhXSDirOffset:			LONGINT;								{Offset to SuperDirectory			<$FE,offset>}
		fhXEOL:					LONGINT;								{Psuedo end-of-list				<$FF,nil>}
		fhXSTstPat:				LONGINT;								{TestPattern}
		fhXDirOffset:			LONGINT;								{Offset to (minimal) directory}
		fhXLength:				LONGINT;								{Length of ROM}
		fhXCRC:					LONGINT;								{CRC}
		fhXROMRev:				SInt8;									{Revision of ROM}
		fhXFormat:				SInt8;									{Format-2}
		fhXTstPat:				LONGINT;								{TestPattern}
		fhXReserved:			SInt8;									{Reserved}
		fhXByteLanes:			SInt8;									{ByteLanes}
	END;

	XFHeaderRecPtr = ^XFHeaderRec;

	SEBlock = PACKED RECORD
		seSlot:					UInt8;									{Slot number.}
		sesRsrcId:				UInt8;									{sResource Id.}
		seStatus:				INTEGER;								{Status of code executed by sExec.}
		seFlags:				UInt8;									{Flags}
		seFiller0:				UInt8;									{Filler, must be SignedByte to align on odd boundry}
		seFiller1:				UInt8;									{Filler}
		seFiller2:				UInt8;									{Filler}
		seResult:				LONGINT;								{Result of sLoad.}
		seIOFileName:			LONGINT;								{Pointer to IOFile name.}
		seDevice:				UInt8;									{Which device to read from.}
		sePartition:			UInt8;									{The partition.}
		seOSType:				UInt8;									{Type of OS.}
		seReserved:				UInt8;									{Reserved field.}
		seRefNum:				UInt8;									{RefNum of the driver.}
		seNumDevices:			UInt8;									{ Number of devices to load.}
		seBootState:			UInt8;									{State of StartBoot code.}
	END;

{  Principle  }

FUNCTION SReadByte(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7000, $A06E, $3E80;
	{$ENDC}
FUNCTION SReadWord(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7001, $A06E, $3E80;
	{$ENDC}
FUNCTION SReadLong(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7002, $A06E, $3E80;
	{$ENDC}
FUNCTION SGetCString(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7003, $A06E, $3E80;
	{$ENDC}
FUNCTION SGetBlock(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7005, $A06E, $3E80;
	{$ENDC}
FUNCTION SFindStruct(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7006, $A06E, $3E80;
	{$ENDC}
FUNCTION SReadStruct(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7007, $A06E, $3E80;
	{$ENDC}
{  Special  }
FUNCTION SReadInfo(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7010, $A06E, $3E80;
	{$ENDC}
FUNCTION SReadPRAMRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7011, $A06E, $3E80;
	{$ENDC}
FUNCTION SPutPRAMRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7012, $A06E, $3E80;
	{$ENDC}
FUNCTION SReadFHeader(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7013, $A06E, $3E80;
	{$ENDC}
FUNCTION SNextSRsrc(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7014, $A06E, $3E80;
	{$ENDC}
FUNCTION SNextTypeSRsrc(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7015, $A06E, $3E80;
	{$ENDC}
FUNCTION SRsrcInfo(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7016, $A06E, $3E80;
	{$ENDC}
FUNCTION SDisposePtr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7017, $A06E, $3E80;
	{$ENDC}
FUNCTION SCkCardStat(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7018, $A06E, $3E80;
	{$ENDC}
FUNCTION SReadDrvrName(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7019, $A06E, $3E80;
	{$ENDC}
FUNCTION SFindSRTRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $701A, $A06E, $3E80;
	{$ENDC}
FUNCTION SFindDevBase(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $701B, $A06E, $3E80;
	{$ENDC}
FUNCTION SFindBigDevBase(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $701C, $A06E, $3E80;
	{$ENDC}
{  Advanced  }
FUNCTION InitSDeclMgr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7020, $A06E, $3E80;
	{$ENDC}
FUNCTION SPrimaryInit(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7021, $A06E, $3E80;
	{$ENDC}
FUNCTION SCardChanged(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7022, $A06E, $3E80;
	{$ENDC}
FUNCTION SExec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7023, $A06E, $3E80;
	{$ENDC}
FUNCTION SOffsetData(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7024, $A06E, $3E80;
	{$ENDC}
FUNCTION SInitPRAMRecs(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7025, $A06E, $3E80;
	{$ENDC}
FUNCTION SReadPBSize(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7026, $A06E, $3E80;
	{$ENDC}
FUNCTION SCalcStep(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7028, $A06E, $3E80;
	{$ENDC}
FUNCTION SInitSRsrcTable(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7029, $A06E, $3E80;
	{$ENDC}
FUNCTION SSearchSRT(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $702A, $A06E, $3E80;
	{$ENDC}
FUNCTION SUpdateSRT(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $702B, $A06E, $3E80;
	{$ENDC}
FUNCTION SCalcSPointer(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $702C, $A06E, $3E80;
	{$ENDC}
FUNCTION SGetDriver(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $702D, $A06E, $3E80;
	{$ENDC}
FUNCTION SPtrToSlot(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $702E, $A06E, $3E80;
	{$ENDC}
FUNCTION SFindSInfoRecPtr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $702F, $A06E, $3E80;
	{$ENDC}
FUNCTION SFindSRsrcPtr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7030, $A06E, $3E80;
	{$ENDC}
FUNCTION SDeleteSRTRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7031, $A06E, $3E80;
	{$ENDC}
FUNCTION OpenSlot(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION OpenSlotSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A200, $3E80;
	{$ENDC}
FUNCTION OpenSlotAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A600, $3E80;
	{$ENDC}
{  Device Manager Slot Support  }
FUNCTION SIntInstall(sIntQElemPtr: SQElemPtr; theSlot: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A075, $3E80;
	{$ENDC}
FUNCTION SIntRemove(sIntQElemPtr: SQElemPtr; theSlot: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A076, $3E80;
	{$ENDC}
FUNCTION SVersion(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7008, $A06E, $3E80;
	{$ENDC}
FUNCTION SetSRsrcState(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7009, $A06E, $3E80;
	{$ENDC}
FUNCTION InsertSRTRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $700A, $A06E, $3E80;
	{$ENDC}
FUNCTION SGetSRsrc(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $700B, $A06E, $3E80;
	{$ENDC}
FUNCTION SGetTypeSRsrc(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $700C, $A06E, $3E80;
	{$ENDC}
FUNCTION SGetSRsrcPtr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $701D, $A06E, $3E80;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SlotsIncludes}

{$ENDC} {__SLOTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
