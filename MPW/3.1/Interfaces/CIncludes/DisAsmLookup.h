/************************************************************

Created: Thursday, September 14, 1989 at 7:56 AM
	DisAsmLookup.h
	C Interface to the Macintosh Libraries


	<<< DisAsmLookup - Disassembler Lookup Routines Interface File >>>
	
	Copyright Apple Computer, Inc.	 1987-1989
	All rights reserved

************************************************************/


#ifndef __DISASMLOOKUP__
#define __DISASMLOOKUP__

#ifndef __TYPES__
#include <Types.h>
#endif

enum {_A0_,_A1_,_A2_,_A3_,_A4_,_A5_,_A6_,_A7_,_PC_,_ABS_,_TRAP_};
typedef unsigned char LookupRegs;

#ifdef __cplusplus
extern "C" {
#endif
pascal void Disassembler(long DstAdjust,short *BytesUsed,Ptr FirstByte,
	char *Opcode,char *Operand,char *Comment,Ptr LookUpProc);
pascal void InitLookup(Ptr PCRelProc,Ptr JTOffProc,Ptr TrapProc,Ptr AbsAddrProc,
	Ptr IdProc);
pascal void Lookup(Ptr PC,LookupRegs BaseReg,long Opnd,char *S);
pascal void LookupTrapName(unsigned short TrapWord,char *S);
pascal void ModifyOperand(char *operand);
char *validMacsBugSymbol(char *symStart,void *limit,char *symbol);
char *endOfModule(void *address,void *limit,char *symbol,void **nextModule);
char *showMacsBugSymbol(char *symStart,void *limit,char *operand,short *bytesUsed); 
#ifdef __cplusplus
}
#endif

#endif
