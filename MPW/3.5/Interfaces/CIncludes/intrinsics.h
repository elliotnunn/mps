/************************************************************

	Intrinsics.h
	
    Copyright Apple Computer,Inc.  1996, 1998
    All rights reserved

	Instruction intrinsics are pseudo-functions which may be expanded  
	inline by the compiler to provide direct access to selected PowerPC 
	machine instructions.  If compiler support is not provided for inline
	expansion then references to these functions will generate external 
	function references.  MrC[pp] versions 2.0 and later recognize the
	intrinsics and perform inlining but earlier versions of MrC do not.
	
	With exceptions noted below, the function's name and prototype follow 
	from the machine instruction's name and operands.  The function return 
	value corresponds to the instruction's destination operand, e.g. FABS; 
	the function returns void if there is no destination operand, e.g. STHBRX.  
	The function's arguments agree in number and correspond with the
	instruction's source operands.  The correspondence is also shown by 
	the function argument names in relation to the instruction template 
	in the comment next to each function.

	The PowerPC architecture manuals describe these instructions in detail.
	
	Naming exception: __setflm does not correspond to a machine instruction.
	It uses two instructions, MFFS and MTFSF, to store the low 32 bits of 
	its double argument into FPSCR and return the previous value of FPSCR 
	in the low 32 bits of its return value.
	
************************************************************/
 
#ifndef __INTRINSICS__
#define __INTRINSICS__

#include <ConditionalMacros.h>

#if TARGET_CPU_PPC

#ifdef __cplusplus
extern "C" {
#endif

int __abs(int rB);										/* SRAWI rA,rB,31; XOR rT,rB,rA; SUB rD,rT,rA */
int __cntlzw(unsigned int rS);							/* CNTLZW	rA,rS */
void __dcbf(void * rA, int rB);							/* DCBF		rA,rB */
void __dcbt(void *rA, int rB);							/* DCBT		rA,rB */
void __dcbst(void *rA, int rB);							/* DCBST	rA,rB */
void __dcbtst(void *rA, int rB);						/* DCBTST	rA,rB */
void __dcbz(void *rA, int rB);							/* DCBZ		rA,rB */
void __eieio(void);										/* EIEIO */
double __fabs(double frB);								/* FABS		frD,frB */
float __fabsf(float frB);								/* FABS		frD,frB */
double __fmadd(double frA,double frC,double frB);		/* FMADD	frD,frA,frC,frB */
float __fmadds(float frA,float frC,float frB);			/* FMADDS	frD,frA,frC,frB */
double __fmsub(double frA,double frC,double frB);		/* FMSUB	frD,frA,frC,frB */	
float __fmsubs(float frA,float frC,float frB);			/* FMSUBS	frD,frA,frC,frB */
double __fnabs(double frB);								/* FNABS	frD,frB */
float __fnabsf(float frB);								/* FNABS	frD,frB */
double __fnmadd(double frA,double frC,double frB);		/* FNMADD	frD,frA,frC,frB */
double __fnmsub(double frA,double frC,double frB);		/* FNMSUB	frD,frA,frC,frB */
float __fnmadds(float frA,float frC,float frB);			/* FNMADDS	frD,frA,frC,frB */
float __fnmsubs(float frA,float frC,float frB);			/* FNMSUBS	frD,frA,frC,frB */
double __frsqrte(double frB);							/* FRSQRTE	frD,frB */ 
float __fres(float frB);								/* FRES		frD,frB */
double __fsel(double frA,double frC,double frB);		/* FSEL		frD,frA,frC,frB */
double __fsqrt(double frB);								/* FSQRT	frD,frB */
float __fsqrts(float frB);								/* FSQRTS	frD,frB */
void __icbi(void *rA, int rB);							/* ICBI		rA,rB */
void __isync(void);										/* ISYNC */
long __labs(long rB);									/* SRAWI rA,rB,31; XOR rT,rB,rA; SUB rD,rT,rA */
unsigned int __lhbrx(void *rA, int rB);					/* LHBRX	rD,rA,rB */
unsigned int __lwbrx(void *rA, int rB);					/* LWBRX	rD,rA,rB */
double __mffs(void);									/* MFFS		frD */
unsigned int __mfxer(void);								/* MFSPR	rD,1 */
void __mtfsb0(unsigned int BT);							/* MTFSB0	BT */
void __mtfsb1(unsigned int BT);							/* MTFSB1	BT */
int __mulhw(int rA, int rB);							/* MULHW	rD,rA,rB */
unsigned int __mulhwu(unsigned int rA, unsigned int rB);/* MULHWU	rD,rA,rB */
int __rlwimi(int rA,int rS,int SH,int MB,int ME);		/* RLWIMI	rA,rS,SH,MB,ME */
int __rlwinm(int rS,int SH,int MB,int ME);				/* RLWINM	rA,SH,MB,ME */
int __rlwnm(int rS,int rB,int MB,int ME);				/* RLWNM	rA,rS,rB,MB,ME */
double __setflm(double frB);							/* MFFS	frD; MTFSF 255,frB */
void __sthbrx(unsigned short rS, void *rA, int rB);		/* STHBRX	rS,rA,rB */
void __stwbrx(unsigned int rS, void *rA, int rB);		/* STWBRX	rS,rA,rB */
void __sync(void);										/* SYNC */

#ifdef __cplusplus
}
#endif

#endif /* TARGET_CPU_PPC */

#endif /* __INTRINSICS__ */
