{
  File: SCSIIntf.p

 Version: 1.0

 Copyright Apple Computer, Inc. 1986
 All Rights Reserved

}

{
 This file defines the interface to the SCSI manager. Any
 program using it must link to the file SCSITraps.

}

UNIT SCSIIntf;

  INTERFACE

	USES {$U MemTypes.p} MemTypes,
	  {$U Quickdraw.p} Quickdraw,
	  {$U OSIntf.p} OSIntf;

	CONST

	  {Transfer instruction operation codes}
	  scInc = 1; {SCINC instruction}
	  scNoInc = 2; {SCNOINC instruction}
	  scAdd = 3; {SCADD instruction}
	  scMove = 4; {SCMOVE instruction}
	  scLoop = 5; {SCLOOP instruction}
	  scNOP = 6; {SCNOP instruction}
	  scStop = 7; {SCSTOP instruction}
	  scComp = 8; {SCCOMP instruction}

	  {SCSI Manager result codes}
	  scBadParmsErr = 4; {unrecognized instruction}
	  scCommErr = 2; {breakdown in SCSI protocols}
	  scCompareErr = 6; {data comparison error in read}
	  scPhaseErr = 5; {phase error}

	TYPE

	  SCSIInstr = RECORD
					scOpcode: INTEGER; {operation code}
					scParam1: LONGINT; {first parameter}
					scParam2: LONGINT; {second parameter}
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

END.
