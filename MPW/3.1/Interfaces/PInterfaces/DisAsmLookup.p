{
Created: Thursday, September 14, 1989 at 7:54 AM
	DisAsmLookup.p
	Pascal Interface to the Macintosh Libraries

	<<< DisAsmLookup - Disassembler Lookup Routines Interface File >>>
	
	Copyright Apple Computer, Inc.	 1987-1989
	All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT DisAsmLookup;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingDisAsmLookup}
{$SETC UsingDisAsmLookup := 1}

{$I+}
{$SETC DisAsmLookupIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := DisAsmLookupIncludes}

TYPE

LookupRegs = (_A0_,_A1_,_A2_,_A3_,_A4_,_A5_,_A6_,_A7_,_PC_,_ABS_,_TRAP_);

DisAsmStr80 = String[80];



PROCEDURE Disassembler(DstAdjust: LONGINT;VAR BytesUsed: INTEGER;FirstByte: UNIV Ptr;
	VAR Opcode: UNIV DisAsmStr80;VAR Operand: UNIV DisAsmStr80;VAR Comment: UNIV DisAsmStr80;
	LookUpProc: UNIV Ptr);
PROCEDURE InitLookup(PCRelProc: UNIV Ptr;JTOffProc: UNIV Ptr;TrapProc: UNIV Ptr;
	AbsAddrProc: UNIV Ptr;IdProc: UNIV Ptr);
PROCEDURE Lookup(PC: UNIV Ptr;BaseReg: LookupRegs;Opnd: UNIV LongInt;VAR S: DisAsmStr80);
PROCEDURE LookupTrapName(TrapWord: UNIV Integer;VAR S: UNIV DisAsmStr80);
PROCEDURE ModifyOperand(VAR Operand: UNIV DisAsmStr80);
FUNCTION validMacsBugSymbol(symStart: UNIV Ptr;limit: UNIV Ptr;symbol: StringPtr): StringPtr; C;
FUNCTION endOfModule(address: UNIV Ptr;limit: UNIV Ptr;symbol: StringPtr;
	VAR nextModule: UNIV Ptr): StringPtr; C;
FUNCTION showMacsBugSymbol(symStart: UNIV Ptr;limit: UNIV Ptr;operand: StringPtr;
	VAR bytesUsed: INTEGER): StringPtr; C;

{$ENDC}    { UsingDisAsmLookup }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}

