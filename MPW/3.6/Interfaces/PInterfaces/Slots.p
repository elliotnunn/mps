{
     File:       Slots.p
 
     Contains:   Slot Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1986-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	fCardIsChanged				= 1;							{ Card is Changed field in StatusFlags field of sInfoArray }
	fCkForSame					= 0;							{ For SearchSRT. Flag to check for SAME sResource in the table.  }
	fCkForNext					= 1;							{ For SearchSRT. Flag to check for NEXT sResource in the table.  }
	fWarmStart					= 2;							{ If this bit is set then warm start else cold start. }

	stateNil					= 0;							{ State }
	stateSDMInit				= 1;							{ :Slot declaration manager Init }
	statePRAMInit				= 2;							{ :sPRAM record init }
	statePInit					= 3;							{ :Primary init }
	stateSInit					= 4;							{ :Secondary init }

																{  flags for spParamData  }
	fall						= 0;							{  bit 0: set=search enabled/disabled sRsrc's  }
	foneslot					= 1;							{     1: set=search sRsrc's in given slot only  }
	fnext						= 2;							{     2: set=search for next sRsrc  }

																{  Misc masks  }
	catMask						= $08;							{  sets spCategory field of spTBMask (bit 3)  }
	cTypeMask					= $04;							{  sets spCType    field of spTBMask (bit 2)  }
	drvrSWMask					= $02;							{  sets spDrvrSW   field of spTBMask (bit 1)  }
	drvrHWMask					= $01;							{  sets spDrvrHW    field of spTBMask (bit 0)  }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SlotIntServiceProcPtr = FUNCTION(sqParameter: LONGINT): INTEGER;
{$ELSEC}
	SlotIntServiceProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SlotIntServiceUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SlotIntServiceUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppSlotIntServiceProcInfo = $0000B822;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewSlotIntServiceUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewSlotIntServiceUPP(userRoutine: SlotIntServiceProcPtr): SlotIntServiceUPP; { old name was NewSlotIntServiceProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeSlotIntServiceUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeSlotIntServiceUPP(userUPP: SlotIntServiceUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeSlotIntServiceUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeSlotIntServiceUPP(sqParameter: LONGINT; userRoutine: SlotIntServiceUPP): INTEGER; { old name was CallSlotIntServiceProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	SlotIntQElementPtr = ^SlotIntQElement;
	SlotIntQElement = RECORD
		sqLink:					Ptr;									{ ptr to next element }
		sqType:					INTEGER;								{ queue type ID for validity }
		sqPrio:					INTEGER;								{ priority }
		sqAddr:					SlotIntServiceUPP;						{ interrupt service routine }
		sqParm:					LONGINT;								{ optional A1 parameter }
	END;

	SQElemPtr							= ^SlotIntQElement;
	SpBlockPtr = ^SpBlock;
	SpBlock = RECORD
		spResult:				LONGINT;								{ FUNCTION Result }
		spsPointer:				Ptr;									{ structure pointer }
		spSize:					LONGINT;								{ size of structure }
		spOffsetData:			LONGINT;								{ offset/data field used by sOffsetData }
		spIOFileName:			Ptr;									{ ptr to IOFile name for sDisDrvrName }
		spsExecPBlk:			Ptr;									{ pointer to sExec parameter block. }
		spParamData:			LONGINT;								{ misc parameter data (formerly spStackPtr). }
		spMisc:					LONGINT;								{ misc field for SDM. }
		spReserved:				LONGINT;								{ reserved for future expansion }
		spIOReserved:			INTEGER;								{ Reserved field of Slot Resource Table }
		spRefNum:				INTEGER;								{ RefNum }
		spCategory:				INTEGER;								{ sType: Category }
		spCType:				INTEGER;								{ Type }
		spDrvrSW:				INTEGER;								{ DrvrSW }
		spDrvrHW:				INTEGER;								{ DrvrHW }
		spTBMask:				SInt8;									{ type bit mask bits 0..3 mask words 0..3 }
		spSlot:					SInt8;									{ slot number }
		spID:					SInt8;									{ structure ID }
		spExtDev:				SInt8;									{ ID of the external device }
		spHwDev:				SInt8;									{ Id of the hardware device. }
		spByteLanes:			SInt8;									{ bytelanes from card ROM format block }
		spFlags:				SInt8;									{ standard flags }
		spKey:					SInt8;									{ Internal use only }
	END;

	SInfoRecordPtr = ^SInfoRecord;
	SInfoRecord = RECORD
		siDirPtr:				Ptr;									{ Pointer to directory }
		siInitStatusA:			INTEGER;								{ initialization E }
		siInitStatusV:			INTEGER;								{ status returned by vendor init code }
		siState:				SInt8;									{ initialization state }
		siCPUByteLanes:			SInt8;									{ 0=[d0..d7] 1=[d8..d15] }
		siTopOfROM:				SInt8;									{ Top of ROM= $FssFFFFx: x is TopOfROM }
		siStatusFlags:			SInt8;									{ bit 0 - card is changed }
		siTOConst:				INTEGER;								{ Time Out C for BusErr }
		siReserved:				ARRAY [0..1] OF SInt8;					{ reserved }
		siROMAddr:				Ptr;									{  addr of top of ROM  }
		siSlot:					SInt8;									{  slot number  }
		siPadding:				ARRAY [0..2] OF SInt8;					{  reserved  }
	END;

	SInfoRecPtr							= ^SInfoRecord;
	SDMRecordPtr = ^SDMRecord;
	SDMRecord = RECORD
		sdBEVSave:				ProcPtr;								{ Save old BusErr vector }
		sdBusErrProc:			ProcPtr;								{ Go here to determine if it is a BusErr }
		sdErrorEntry:			ProcPtr;								{ Go here if BusErrProc finds real BusErr }
		sdReserved:				LONGINT;								{ Reserved }
	END;

	FHeaderRecPtr = ^FHeaderRec;
	FHeaderRec = RECORD
		fhDirOffset:			LONGINT;								{ offset to directory }
		fhLength:				LONGINT;								{ length of ROM }
		fhCRC:					LONGINT;								{ CRC }
		fhROMRev:				SInt8;									{ revision of ROM }
		fhFormat:				SInt8;									{ format - 2 }
		fhTstPat:				LONGINT;								{ test pattern }
		fhReserved:				SInt8;									{ reserved }
		fhByteLanes:			SInt8;									{ ByteLanes }
	END;

	{
	   
	    Extended Format header block  -  extended declaration ROM format header for super sRsrc directories.    <H2><SM0>
	   
	}

	XFHeaderRecPtr = ^XFHeaderRec;
	XFHeaderRec = RECORD
		fhXSuperInit:			LONGINT;								{ Offset to SuperInit SExecBlock  <fhFormat,offset> }
		fhXSDirOffset:			LONGINT;								{ Offset to SuperDirectory         <$FE,offset> }
		fhXEOL:					LONGINT;								{ Psuedo end-of-list          <$FF,nil> }
		fhXSTstPat:				LONGINT;								{ TestPattern }
		fhXDirOffset:			LONGINT;								{ Offset to (minimal) directory }
		fhXLength:				LONGINT;								{ Length of ROM }
		fhXCRC:					LONGINT;								{ CRC }
		fhXROMRev:				SInt8;									{ Revision of ROM }
		fhXFormat:				SInt8;									{ Format-2 }
		fhXTstPat:				LONGINT;								{ TestPattern }
		fhXReserved:			SInt8;									{ Reserved }
		fhXByteLanes:			SInt8;									{ ByteLanes }
	END;

	SEBlockPtr = ^SEBlock;
	SEBlock = PACKED RECORD
		seSlot:					UInt8;									{ Slot number. }
		sesRsrcId:				UInt8;									{ sResource Id. }
		seStatus:				INTEGER;								{ Status of code executed by sExec. }
		seFlags:				UInt8;									{ Flags }
		seFiller0:				UInt8;									{ Filler, must be SignedByte to align on odd boundry }
		seFiller1:				UInt8;									{ Filler }
		seFiller2:				UInt8;									{ Filler }
		seResult:				LONGINT;								{ Result of sLoad. }
		seIOFileName:			LONGINT;								{ Pointer to IOFile name. }
		seDevice:				UInt8;									{ Which device to read from. }
		sePartition:			UInt8;									{ The partition. }
		seOSType:				UInt8;									{ Type of OS. }
		seReserved:				UInt8;									{ Reserved field. }
		seRefNum:				UInt8;									{ RefNum of the driver. }
		seNumDevices:			UInt8;									{  Number of devices to load. }
		seBootState:			UInt8;									{ State of StartBoot code. }
		filler:					SInt8;
	END;

	{	  Principle  	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  SReadByte()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION SReadByte(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7000, $A06E, $3E80;
	{$ENDC}

{
 *  SReadWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SReadWord(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7001, $A06E, $3E80;
	{$ENDC}

{
 *  SReadLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SReadLong(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7002, $A06E, $3E80;
	{$ENDC}

{
 *  SGetCString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SGetCString(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7003, $A06E, $3E80;
	{$ENDC}

{
 *  SGetBlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SGetBlock(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7005, $A06E, $3E80;
	{$ENDC}

{
 *  SFindStruct()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SFindStruct(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7006, $A06E, $3E80;
	{$ENDC}

{
 *  SReadStruct()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SReadStruct(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7007, $A06E, $3E80;
	{$ENDC}

{  Special  }
{
 *  SReadInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SReadInfo(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7010, $A06E, $3E80;
	{$ENDC}

{
 *  SReadPRAMRec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SReadPRAMRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7011, $A06E, $3E80;
	{$ENDC}

{
 *  SPutPRAMRec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SPutPRAMRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7012, $A06E, $3E80;
	{$ENDC}

{
 *  SReadFHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SReadFHeader(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7013, $A06E, $3E80;
	{$ENDC}

{
 *  SNextSRsrc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SNextSRsrc(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7014, $A06E, $3E80;
	{$ENDC}

{
 *  SNextTypeSRsrc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SNextTypeSRsrc(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7015, $A06E, $3E80;
	{$ENDC}

{
 *  SRsrcInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SRsrcInfo(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7016, $A06E, $3E80;
	{$ENDC}

{
 *  SDisposePtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SDisposePtr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7017, $A06E, $3E80;
	{$ENDC}

{
 *  SCkCardStat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SCkCardStat(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7018, $A06E, $3E80;
	{$ENDC}

{
 *  SReadDrvrName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SReadDrvrName(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7019, $A06E, $3E80;
	{$ENDC}

{
 *  SFindSRTRec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SFindSRTRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701A, $A06E, $3E80;
	{$ENDC}

{
 *  SFindDevBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SFindDevBase(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701B, $A06E, $3E80;
	{$ENDC}

{
 *  SFindBigDevBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SFindBigDevBase(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701C, $A06E, $3E80;
	{$ENDC}

{  Advanced  }
{
 *  InitSDeclMgr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitSDeclMgr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7020, $A06E, $3E80;
	{$ENDC}

{
 *  SPrimaryInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SPrimaryInit(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7021, $A06E, $3E80;
	{$ENDC}

{
 *  SCardChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SCardChanged(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7022, $A06E, $3E80;
	{$ENDC}

{
 *  SExec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SExec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7023, $A06E, $3E80;
	{$ENDC}

{
 *  SOffsetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SOffsetData(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7024, $A06E, $3E80;
	{$ENDC}

{
 *  SInitPRAMRecs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SInitPRAMRecs(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7025, $A06E, $3E80;
	{$ENDC}

{
 *  SReadPBSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SReadPBSize(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7026, $A06E, $3E80;
	{$ENDC}

{
 *  SCalcStep()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SCalcStep(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7028, $A06E, $3E80;
	{$ENDC}

{
 *  SInitSRsrcTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SInitSRsrcTable(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7029, $A06E, $3E80;
	{$ENDC}

{
 *  SSearchSRT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSearchSRT(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702A, $A06E, $3E80;
	{$ENDC}

{
 *  SUpdateSRT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SUpdateSRT(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702B, $A06E, $3E80;
	{$ENDC}

{
 *  SCalcSPointer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SCalcSPointer(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702C, $A06E, $3E80;
	{$ENDC}

{
 *  SGetDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SGetDriver(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702D, $A06E, $3E80;
	{$ENDC}

{
 *  SPtrToSlot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SPtrToSlot(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702E, $A06E, $3E80;
	{$ENDC}

{
 *  SFindSInfoRecPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SFindSInfoRecPtr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702F, $A06E, $3E80;
	{$ENDC}

{
 *  SFindSRsrcPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SFindSRsrcPtr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7030, $A06E, $3E80;
	{$ENDC}

{
 *  SDeleteSRTRec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SDeleteSRTRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7031, $A06E, $3E80;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  OpenSlot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OpenSlot(paramBlock: ParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  OpenSlotSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OpenSlotSync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A200, $3E80;
	{$ENDC}

{
 *  OpenSlotAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OpenSlotAsync(paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A600, $3E80;
	{$ENDC}

{  Device Manager Slot Support  }
{
 *  SIntInstall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SIntInstall(sIntQElemPtr: SQElemPtr; theSlot: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A075, $3E80;
	{$ENDC}

{
 *  SIntRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SIntRemove(sIntQElemPtr: SQElemPtr; theSlot: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A076, $3E80;
	{$ENDC}

{
 *  SVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SVersion(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7008, $A06E, $3E80;
	{$ENDC}

{
 *  SetSRsrcState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetSRsrcState(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7009, $A06E, $3E80;
	{$ENDC}

{
 *  InsertSRTRec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InsertSRTRec(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700A, $A06E, $3E80;
	{$ENDC}

{
 *  SGetSRsrc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SGetSRsrc(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700B, $A06E, $3E80;
	{$ENDC}

{
 *  SGetTypeSRsrc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SGetTypeSRsrc(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700C, $A06E, $3E80;
	{$ENDC}

{
 *  SGetSRsrcPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SGetSRsrcPtr(spBlkPtr: SpBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $701D, $A06E, $3E80;
	{$ENDC}



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SlotsIncludes}

{$ENDC} {__SLOTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
