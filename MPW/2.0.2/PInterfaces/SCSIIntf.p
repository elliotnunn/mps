{
  File: SCSIIntf.p

 Copyright Apple Computer, Inc. 1986-1987
 All Rights Reserved
}


UNIT SCSIIntf;

  INTERFACE

	USES {$U MemTypes.p} MemTypes,
	{$U Quickdraw.p} Quickdraw,
	{$U OSIntf.p} OSIntf;

	CONST

	{Transfer instruction operation codes}
	scInc = 1;			{SCINC instruction}
	scNoInc = 2;		{SCNOINC instruction}
	scAdd = 3;			{SCADD instruction}
	scMove = 4;			{SCMOVE instruction}
	scLoop = 5;			{SCLOOP instruction}
	scNOP = 6;			{SCNOP instruction}
	scStop = 7;			{SCSTOP instruction}
	scComp = 8;			{SCCOMP instruction}

	{SCSI Manager result codes}
	scCommErr = 2;		{communications error (operation timeout)}
	scArbNBErr = 3;		{ arbitration timeout waiting for not BSY }
	scBadParmsErr = 4;	{bad parameter or TIB opcode}
	scPhaseErr = 5;		{SCSI bus not in correct phase for attempted operation}
	scCompareErr = 6; 	{data compare error}
	scMgrBusyErr = 7; 	{ SCSI Manager busy }
	scSequenceErr = 8;	{ attempted operation is out of sequence }
	scBusTOErr = 9;		{ CPU bus timeout }
	scComplPhaseErr = 10; { SCSI bus wasn't in Status phase }

	sbSIGWord = $4552;
	pMapSIG = $504D;

	TYPE

	SCSIInstr = RECORD
			scOpcode: INTEGER;		{operation code}
			scParam1: LONGINT;		{first parameter}
			scParam2: LONGINT;		{second parameter}
			END;

	Block0 = PACKED RECORD
			sbSig: INTEGER; 		{ unique value for SCSI block 0 }
			sbBlkSize: INTEGER; 	{ block size of device }
			sbBlkCount: LONGINT;	{ number of blocks on device }
			sbDevType: INTEGER; 	{ device type }
			sbDevId: INTEGER;		{ device id }
			sbData: LONGINT;		{ not used }
			sbDrvrCount: INTEGER;	{ driver descriptor count }
			ddBlock: LONGINT;		{ 1st driver's starting block }
			ddSize: INTEGER;		{ size of 1st driver (512-byte blks) }
			ddType: INTEGER;		{ system type (1 for Mac+) }
			ddPad: ARRAY[0..242] OF INTEGER; { 512 bytes long, currently unused }
			END;

	Partition = PACKED RECORD
			pmSig: INTEGER; 					{ unique value for map entry blk }
			pmSigPad: INTEGER;					{ currently unused }
			pmMapBlkCnt: LONGINT;				{ # of blks in partition map }
			pmPyPartStart: LONGINT; 			{ first physical block of partition }
			pmPartBlkCnt: LONGINT;				{ number of blocks in partition }
			pmPartName: ARRAY[0..31] OF CHAR;	{ ASCII partition name }
			pmParType: ARRAY[0..31] OF CHAR;	{ ASCII partition type }
			pmLgDataStart: LONGINT; 			{ log. # of partition's 1st data blk }
			pmDataCnt: LONGINT; 				{ # of blks in partition's data area }
			pmPartStatus: LONGINT;				{ bit field for partition status }
			pmLgBootStart: LONGINT; 			{ logical blk of partition's boot code }
			pmBootSize: LONGINT;				{ number of bytes in boot code }
			pmBootAddr: LONGINT;				{ memory load address of boot code }
			pmBootAddr2: LONGINT;				{ currently unused }
			pmBootEntry: LONGINT;				{ entry point of boot code }
			pmBootEntry2: LONGINT;				{ currently unused }
			pmBootCksum: LONGINT;				{ checksum of boot code }
			pmProcessor: ARRAY[0..15] OF CHAR;	{ ASCII for the processor type }
			pmPad: ARRAY[0..187] OF INTEGER;	{ 512 bytes long, currently unused }
			END;


	FUNCTION SCSIReset: OSErr;

	FUNCTION SCSIGet: OSErr;

	FUNCTION SCSISelect(targetID: INTEGER): OSErr;

	FUNCTION SCSICmd(buffer: Ptr; count: INTEGER): OSErr;

	FUNCTION SCSIRead(tibPtr: Ptr): OSErr;

	FUNCTION SCSIRBlind(tibPtr: Ptr): OSErr;

	FUNCTION SCSIWrite(tibPtr: Ptr): OSErr;

	FUNCTION SCSIWBlind(tibPtr: Ptr): OSErr;

	FUNCTION SCSIComplete(VAR stat, message: INTEGER; wait: LONGINT): OSErr;

	FUNCTION SCSIStat: INTEGER;

{************** NEW SCSI FUNCTIONS *****************}

FUNCTION SCSISelAtn(targetID: INTEGER): OSErr;

FUNCTION SCSIMsgIn(VAR message: INTEGER): OSErr;

FUNCTION SCSIMsgOut(message: INTEGER): OSErr;


END.

