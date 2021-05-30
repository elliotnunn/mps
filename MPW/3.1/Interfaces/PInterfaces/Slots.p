{
Created: Friday, August 19, 1988 at 5:36 AM
	Slots.p
	Pascal Interface to the Macintosh Libraries

	Copyright Apple Computer, Inc.	1986-1988
	All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT Slots;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingSlots}
{$SETC UsingSlots := 1}

{$I+}
{$SETC SlotsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingOSEvents}
{$I $$Shell(PInterfaces)OSEvents.p}
{$ENDC}
{$IFC UNDEFINED UsingOSUtils}
{$I $$Shell(PInterfaces)OSUtils.p}
{$ENDC}
{$IFC UNDEFINED UsingFiles}
{$I $$Shell(PInterfaces)Files.p}
{$ENDC}
{$SETC UsingIncludes := SlotsIncludes}

CONST
fCardIsChanged = 1; 								{Card is Changed field in StatusFlags field of sInfoArray}
fCkForSame = 0; 									{For SearchSRT. Flag to check for SAME sResource in the table. }
fCkForNext = 1; 									{For SearchSRT. Flag to check for NEXT sResource in the table. }
fWarmStart = 2; 									{If this bit is set then warm start else cold start.}
stateNil = 0;										{State}
stateSDMInit = 1;									{:Slot declaration manager Init}
statePRAMInit = 2;									{:sPRAM record init}
statePInit = 3; 									{:Primary init}
stateSInit = 4; 									{:Secondary init}


TYPE

SQElemPtr = ^SlotIntQElement;
SlotIntQElement = RECORD
	sqLink: Ptr;									{ptr to next element}
	sqType: INTEGER;								{queue type ID for validity}
	sqPrio: INTEGER;								{priority}
	sqAddr: ProcPtr;								{interrupt service routine}
	sqParm: LONGINT;								{optional A1 parameter}
	END;

SpBlockPtr = ^SpBlock;
SpBlock = PACKED RECORD
	spResult: LONGINT;								{FUNCTION Result}
	spsPointer: Ptr;								{structure pointer}
	spSize: LONGINT;								{size of structure}
	spOffsetData: LONGINT;							{offset/data field used by sOffsetData}
	spIOFileName: Ptr;								{ptr to IOFile name for sDisDrvrName}
	spsExecPBlk: Ptr;								{pointer to sExec parameter block.}
	spStackPtr: Ptr;								{old Stack pointer.}
	spMisc: LONGINT;								{misc field for SDM.}
	spReserved: LONGINT;							{reserved for future expansion}
	spIOReserved: INTEGER;							{Reserved field of Slot Resource Table}
	spRefNum: INTEGER;								{RefNum}
	spCategory: INTEGER;							{sType: Category}
	spCType: INTEGER;								{Type}
	spDrvrSW: INTEGER;								{DrvrSW}
	spDrvrHW: INTEGER;								{DrvrHW}
	spTBMask: SignedByte;							{type bit mask bits 0..3 mask words 0..3}
	spSlot: SignedByte; 							{slot number}
	spID: SignedByte;								{structure ID}
	spExtDev: SignedByte;							{ID of the external device}
	spHwDev: SignedByte;							{Id of the hardware device.}
	spByteLanes: SignedByte;						{bytelanes from card ROM format block}
	spFlags: SignedByte;							{standard flags}
	spKey: SignedByte;								{Internal use only}
	END;

SInfoRecPtr = ^SInfoRecord;
SInfoRecord = PACKED RECORD
	siDirPtr: Ptr;									{Pointer to directory}
	siInitStatusA: INTEGER; 						{initialization E}
	siInitStatusV: INTEGER; 						{status returned by vendor init code}
	siState: SignedByte;							{initialization state}
	siCPUByteLanes: SignedByte; 					{0=[d0..d7] 1=[d8..d15]}
	siTopOfROM: SignedByte; 						{Top of ROM= $FssFFFFx: x is TopOfROM}
	siStatusFlags: SignedByte;						{bit 0 - card is changed}
	siTOConst: INTEGER; 							{Time Out C for BusErr}
	siReserved: PACKED ARRAY [0..1] OF SignedByte;	{reserved}
	END;

SDMRecord = PACKED RECORD
	sdBEVSave: ProcPtr; 							{Save old BusErr vector}
	sdBusErrProc: ProcPtr;							{Go here to determine if it is a BusErr}
	sdErrorEntry: ProcPtr;							{Go here if BusErrProc finds real BusErr}
	sdReserved: LONGINT;							{Reserved}
	END;

FHeaderRecPtr = ^FHeaderRec;
FHeaderRec = PACKED RECORD
	fhDirOffset: LONGINT;							{offset to directory}
	fhLength: LONGINT;								{length of ROM}
	fhCRC: LONGINT; 								{CRC}
	fhROMRev: SignedByte;							{revision of ROM}
	fhFormat: SignedByte;							{format - 2}
	fhTstPat: LONGINT;								{test pattern}
	fhReserved: SignedByte; 						{reserved}
	fhByteLanes: SignedByte;						{ByteLanes}
	END;

SEBlock = PACKED RECORD
	seSlot: SignedByte; 							{Slot number.}
	sesRsrcId: SignedByte;							{sResource Id.}
	seStatus: INTEGER;								{Status of code executed by sExec.}
	seFlags: SignedByte;							{Flags}
	seFiller0: SignedByte;							{Filler, must be SignedByte to align on odd boundry}
	seFiller1: SignedByte;							{Filler}
	seFiller2: SignedByte;							{Filler}
	seResult: LONGINT;								{Result of sLoad.}
	seIOFileName: LONGINT;							{Pointer to IOFile name.}
	seDevice: SignedByte;							{Which device to read from.}
	sePartition: SignedByte;						{The partition.}
	seOSType: SignedByte;							{Type of OS.}
	seReserved: SignedByte; 						{Reserved field.}
	seRefNum: SignedByte;							{RefNum of the driver.}
	seNumDevices: SignedByte;						{ Number of devices to load.}
	seBootState: SignedByte;						{State of StartBoot code.}
	END;



FUNCTION SIntInstall(sIntQElemPtr: SQElemPtr;theSlot: INTEGER): OSErr;
FUNCTION SIntRemove(sIntQElemPtr: SQElemPtr;theSlot: INTEGER): OSErr;
FUNCTION SReadByte(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadWord(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadLong(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SGetCString(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SGetBlock(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SFindStruct(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadStruct(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadInfo(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadPRAMRec(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SPutPRAMRec(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadFHeader(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SNextSRsrc(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SNextTypeSRsrc(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SRsrcInfo(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SCkCardStat(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadDrvrName(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SFindDevBase(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SFindBigDevBase(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION InitSDeclMgr(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SPrimaryInit(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SCardChanged(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SExec(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SOffsetData(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SInitPRAMRecs(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadPBSize(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SCalcStep(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SInitSRsrcTable(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SSearchSRT(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SUpdateSRT(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SCalcSPointer(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SGetDriver(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SPtrToSlot(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SFindSInfoRecPtr(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SFindSRsrcPtr(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SDeleteSRTRec(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION OpenSlot(paramBlock: ParmBlkPtr;aSync: BOOLEAN): OSErr;

{$ENDC}    { UsingSlots }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}

