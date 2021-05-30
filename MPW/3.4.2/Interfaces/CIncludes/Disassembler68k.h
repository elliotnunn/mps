/*
	File:			Disassmbler68k.h
	
	Contains:		New interface to 68k Disassembler.
	
	Copyright:		© 1983-1995 by Apple Computer, Inc.
					All rights reserved.
	
	Rearchitect:	Chris Thomas
	
	Created:		In a quaint hut by the side of an obscure country
					road, Londonshire, England.
*/

#ifndef __DISASMLOOKUP__
#define __DISASMLOOKUP__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

/** distinguish the version **/
enum
{
	disassembler68kversion = 3
};

/** base register definitions  **/
typedef enum {_A0_, _A1_, _A2_, _A3_, _A4_, _A5_, _A6_, _A7_, _PC_, _ABS_, _TRAP_, _IMM_} LookupRegs;

/** MixedMode stuff and procedure definitions **/

/*
 *	note:	We decided against MixedMode for the simple reason that it would be useless
 *			in this situation.  Should this evaluation change, UPPs and stuff still exist.
 */
 
typedef pascal void (*PCRelativeProcPtr)		(SInt32 inRelativeAddress, unsigned char *outString);
typedef pascal void (*JumpTableOffsetProcPtr)	(SInt16 inA5offset, unsigned char *outString);
typedef pascal void (*TrapNameProcPtr)			(UInt16 inTrapWord, unsigned char *outString);
typedef pascal void (*AbsoluteAddrProcPtr)		(SInt32 inAbsoluteAddress , unsigned char *outString);
typedef pascal void (*RegisterOffsetProcPtr)	(LookupRegs inBaseReg, SInt32 inOffset, unsigned char *outString);
typedef pascal void (*ImmediateDataProcPtr)		(SInt32 inData, unsigned char *outString);
typedef pascal void (*LookupProcPtr)			(Ptr inPC, LookupRegs inBaseReg, SInt32 inOperand, unsigned char *outString);

typedef PCRelativeProcPtr		PCRelativeUPP;
typedef JumpTableOffsetProcPtr	JumpTableOffsetUPP;
typedef TrapNameProcPtr			TrapNameUPP;
typedef AbsoluteAddrProcPtr		AbsoluteAddressUPP;
typedef RegisterOffsetProcPtr	RegisterOffsetUPP;
typedef ImmediateDataProcPtr	ImmediateDataUPP;
typedef LookupProcPtr			LookupUPP;

#define CallPCRelativeProc(x, inAddress, outString) \
		x(inAddress, outString)

#define CallJumpTableProc(x, inAddress, outString) \
		x(inAddress, outString)

#define CallTrapNameProc(x, inAddress, outString) \
		x(inAddress, outString)

#define CallAbsoluteAddressProc(x, inAddress, outString) \
		x(inAddress, outString)

#define CallRegisterOffsetProc(x, inRegs, inAddress, outString) \
		x(inRegs, inAddress, outString)

#define CallImmediateDataProc(x, inAddress, outString) \
		x(inAddress, outString)

#define CallLookupProc(x, ptr, regs, value, string) \
		x(ptr, regs, value, string)

/** options & results **/

typedef enum
{
	dis68k_useClassicMnemonics = (1 << 0),			/*not impl- use old-style, capitalized, less accurate mnemonics*/
	dis68k_capitalize = (1 << 1),					/*not impl- capitalize the mnemonics, but with accuracy*/
	dis68k_use_C_Formatting = (1 << 2),				/*output C-style 0xHex instead of $Hex etc*/
	dis68k_default = 0								/*don't use any of the above options*/
}Dis68kOptions;

typedef enum
{
	dis68k_invalid =	(UInt32)	(1 << 0),	/* instruction is invalid - won't run on any 68k */
	dis68k_68000 =	(UInt32)			(1 << 1),	/* instruction runs on 68000 */
	dis68k_68010 =	(UInt32)			(1 << 2),	/* instruction runs on 68010 */
	dis68k_68020 =	(UInt32)			(1 << 3),	/* instruction runs on 68020 */
	dis68k_68030 =	(UInt32)			(1 << 4),	/* instruction runs on 68030 */
	dis68k_68040 =	(UInt32)			(1 << 5),	/* instruction runs on 68040 */
	dis68k_68060 =	(UInt32)			(1 << 5),	/* instruction runs on 68060 */
											/* %%% (need this option be seperate?)
											I think the 060 is just a hypersupercharged 040
											Leave a bit for it just in case*/
	dis68k_privileged =	(UInt32)		(1 << 7),	/* instruction is supervisor-mode */
	dis68k_branch =		(UInt32)		(1 << 8),	/* instruction might branch */
	dis68k_family =		(UInt32)					/* runs on any 68k cpu*/
		(dis68k_68000 | dis68k_68010 | dis68k_68020 | dis68k_68030 | dis68k_68040 | dis68k_68060),
	
	dis68k_010orLater = (UInt32)	(dis68k_family ^ dis68k_68000),
	dis68k_020orLater = (UInt32)	(dis68k_family ^ (dis68k_68000 | dis68k_68010)),
	
	dis68k_endz
}Dis68kResults;


/** implementation **/

#ifdef __cplusplus
extern "C" {
#endif

/*returns Dis68kResults*/
extern pascal UInt32 Disassembler(		long		commentAdjust,	 		/* Address adjustment (added to PC-relative commented values)	*/
										short		*bytesUsed, 			/* Bytes used up by 1 call		*/  
										Ptr			data,					/* Ptr to instruction to be disassembled	*/
										Str255		opcode,		 			/* Ptr to opcode string     	*/
										Str255		operand,	 			/* Ptr to operand string    	*/
										Str255		comment,	 			/* Ptr to comment string     	*/
									 	LookupUPP	 lookUpProc);			/* UPP to Lookup procedure		*/

extern pascal void Dis68kSetOptions(Dis68kOptions inOptions);

/* typed version of InitLookup */
extern pascal void SetLookupProcs(PCRelativeUPP pcrProc, JumpTableOffsetUPP jtoProc, TrapNameUPP trapProc,
					AbsoluteAddressUPP aaProc, RegisterOffsetUPP idProc, ImmediateDataUPP immProc);

extern pascal void InitLookup(Ptr pcrProc, Ptr jtoProc, Ptr trapProc,
					Ptr aaProc, Ptr idProc, Ptr immProc);

extern pascal void Lookup(	Ptr			PC,			/* Addr of extension/trap word		*/
							LookupRegs	BaseReg, 	/* Base register/lookup mode  		*/
							SInt32		Opnd,		/* Trap word, PC addr, disp.  		*/
							Str255		S);		 	/* Returned substitution			*/

extern pascal void LookupTrapName(unsigned short TrapWord, char *S);
extern pascal void ModifyOperand(char *operand);

extern pascal char *endOfModule(void *address, void *limit, char *symbol, void **nextModule);
extern pascal char *showMacsBugSymbol(char *symStart, void *limit, char *operand,
															 short *bytesUsed);

extern pascal char *validMacsBugSymbol(char *symStart, void *limit, char *symbol);

#ifdef __cplusplus
}
#endif
#endif
