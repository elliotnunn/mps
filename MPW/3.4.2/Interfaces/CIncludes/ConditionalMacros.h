/*
 	File:		ConditionalMacros.h
 
 	Contains:	Compile time feature switches to achieve platform independent sources.
 
 	Version:	Technology:	Universal Interface Files 2.1
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __CONDITIONALMACROS__
#define __CONDITIONALMACROS__

/*

	Set up UNIVERSAL_INTERFACES_VERSION
	
		0x214 => version 2.1.4
		0x212 => version 2.1.2
		0x210 => version 2.1
		This conditional did not exist prior to version 2.1
*/
#define UNIVERSAL_INTERFACES_VERSION 0x0214

/****************************************************************************************************
	GENERATINGPOWERPC		- Compiler is generating PowerPC instructions
	GENERATING68K			- Compiler is generating 68k family instructions

		Invariant:
			GENERATINGPOWERPC != GENERATING68K
 ****************************************************************************************************/
#ifdef GENERATINGPOWERPC
	#ifndef GENERATING68K
#define GENERATING68K !GENERATINGPOWERPC
	#endif
#endif
#ifdef GENERATING68K
	#ifndef GENERATINGPOWERPC
#define GENERATINGPOWERPC !GENERATING68K
	#endif
#endif
#ifndef GENERATINGPOWERPC
	#if defined(powerc) || defined(__powerc)
#define GENERATINGPOWERPC 1
	#else
#define GENERATINGPOWERPC 0
	#endif
#endif
#ifndef GENERATING68K
	#if GENERATINGPOWERPC
#define GENERATING68K 0
	#else
#define GENERATING68K 1
	#endif
#endif

/****************************************************************************************************
	GENERATING68881			- Compiler is generating mc68881 floating point instructions
	
		Invariant:
			GENERATING68881 => GENERATING68K
 ****************************************************************************************************/
#if GENERATING68K
	#if defined(applec) || defined(__SC__)
		#ifdef mc68881
#define GENERATING68881 1
		#endif
	#else
		#ifdef __MWERKS__
			#if __MC68881__
#define GENERATING68881 1
			#endif
		#endif
	#endif
#endif
#ifndef GENERATING68881
#define GENERATING68881 0
#endif

/****************************************************************************************************
	GENERATINGCFM			- Code being generated assumes CFM calling conventions
	CFMSYSTEMCALLS			- No A-traps.  Systems calls are made using CFM and UPP's

		Invariants:
			GENERATINGPOWERPC => GENERATINGCFM
			GENERATINGPOWERPC => CFMSYSTEMCALLS
			CFMSYSTEMCALLS => GENERATINGCFM
****************************************************************************************************/
#if GENERATINGPOWERPC || defined(__CFM68K__)
#define GENERATINGCFM 1
#define CFMSYSTEMCALLS 1
#else
#define GENERATINGCFM 0
#define CFMSYSTEMCALLS 0
#endif
/*

	Set up SystemSevenFiveOrLater, SystemSevenOrLater, and SystemSixOrLater

*/
#ifndef SystemSevenFiveOrLater
#define SystemSevenFiveOrLater 0
#endif
#ifndef SystemSevenOrLater
	#if GENERATINGCFM
#define SystemSevenOrLater 1
	#else
#define SystemSevenOrLater SystemSevenFiveOrLater
	#endif
#endif
#ifndef SystemSixOrLater
#define SystemSixOrLater SystemSevenOrLater
#endif

/****************************************************************************************************

	OLDROUTINENAMES			- "Old" names for Macintosh system calls are allowed in source code.
							  (e.g. DisposPtr instead of DisposePtr). The names of system routine
							  are now more sensitive to change because CFM binds by name.  In the 
							  past, system routine names were compiled out to just an A-Trap.  
							  Macros have been added that each map an old name to its new name.  
							  This allows old routine names to be used in existing source files,
							  but the macros only work if OLDROUTINENAMES is true.  This support
							  will be removed in the near future.  Thus, all source code should 
							  be changed to use the new names! You can set OLDROUTINENAMES to false
							  to see if your code has any old names left in it.
	
	OLDROUTINELOCATIONS     - "Old" location of Macintosh system calls are used.  For example, c2pstr 
							  has been moved from Strings to TextUtils.  It is conditionalized in
							  Strings with OLDROUTINELOCATIONS and in TextUtils with !OLDROUTINELOCATIONS.
							  This allows developers to upgrade to newer interface files without suddenly
							  all their code not compiling becuase of "incorrect" includes.  But, it
							  allows the slow migration of system calls to more understandable file
							  locations.  OLDROUTINELOCATIONS currently defaults to true, but eventually
							  will default to false.

****************************************************************************************************/
#ifndef OLDROUTINENAMES
#define OLDROUTINENAMES 1
#endif
#ifndef OLDROUTINELOCATIONS
#define OLDROUTINELOCATIONS 1
#endif

/****************************************************************************************************

	C specific conditionals

	CGLUESUPPORTED			- Interface library will support "C glue" functions (function names
							  are: all lowercase, use C strings instead of pascal strings, use 
							  Point* instead of Point).

	PRAGMA_ALIGN_SUPPORTED	- Compiler supports "#pragma align=..." directives. The only compilers that
							  can get by without supporting the pragma are old classic 68K compilers
							  that will only be used to compile older structs that have 68K alignment
							  anyways.  
	
	PRAGMA_IMPORT_SUPPORTED	- Compiler supports "#pragma import on/off" directives.  These directives
							  were introduced with the SC compiler which supports CFM 68K.  The directive
							  is used to tell the compiler which functions will be called through a 
							  transition vector (instead of a simple PC-relative offset).  This allows 
							  the compiler to generate better code.  Since System Software functions are
							  implemented as shared libraries and called through transition vectors,
							  all System Software functions are declared with "#pragma import on".
							  
		Invariants:
			PRAGMA_IMPORT_SUPPORTED => CFMSYSTEMCALLS
			GENERATINGPOWERPC => PRAGMA_ALIGN_SUPPORTED
			
****************************************************************************************************/
#ifndef CGLUESUPPORTED
	#ifdef THINK_C
#define CGLUESUPPORTED 0
	#else
#define CGLUESUPPORTED 1
	#endif
#endif

/* All PowerPC compilers support pragma align */
/* For 68K, only Metrowerks and SC 8.0 support pragma align */
#ifndef PRAGMA_ALIGN_SUPPORTED
	#if GENERATINGPOWERPC || defined(__MWERKS__) || ( defined(__SC__) && (__SC__ >= 0x0800) )
		#define  PRAGMA_ALIGN_SUPPORTED 1
	#else
		#define  PRAGMA_ALIGN_SUPPORTED 0
	#endif
#endif

/* pragma import on/off is supported by: Metowerks CW7 and later, SC 8.0 and later, MrC 2.0 and later */
/* pragma import reset is supported by: Metrowerks and MrC 2.0.2 and later, but not yet by SC */
#ifndef PRAGMA_IMPORT_SUPPORTED
	#if ( defined(__MWERKS__) && (__MWERKS__ >= 0x0700) ) || ( defined(__SC__) && (__SC__ >= 0x0800) )
		#define  PRAGMA_IMPORT_SUPPORTED 1
	#elif defined(__MRC__) && (__MRC__  >= 0x0200) && (__MRC__ < 0x0700) /* MrC 1.0 used 0x0704 and 0x0800 */
		#define  PRAGMA_IMPORT_SUPPORTED 1
	#else
		#define  PRAGMA_IMPORT_SUPPORTED 0
	#endif
#endif


/****************************************************************************************************

	Set up old "USES..." conditionals to support 1.0 universal interface files

	The USESxxx names are old, but cannot be removed yet because source code that
	uses them might still compile, but do the wrong thing. 
	
****************************************************************************************************/
#ifndef USES68KINLINES
#define USES68KINLINES GENERATING68K
#endif
#define USESCODEFRAGMENTS GENERATINGCFM
#define USESROUTINEDESCRIPTORS GENERATINGCFM

/****************************************************************************************************

	The following macros isolate the use of inlines from the routine prototypes.
	A routine prototype will always be followed by on of these inline macros with
	a list of the opcodes to be inlined.  On the 68K side, the appropriate inline
	code will be generated.  On platforms that use code fragments, the macros are
	essentially NOPs.
	
****************************************************************************************************/
#if GENERATING68K && !GENERATINGCFM
#define ONEWORDINLINE(trapNum) = trapNum
#define TWOWORDINLINE(w1,w2) = {w1,w2}
#define THREEWORDINLINE(w1,w2,w3) = {w1,w2,w3}
#define FOURWORDINLINE(w1,w2,w3,w4)  = {w1,w2,w3,w4}
#define FIVEWORDINLINE(w1,w2,w3,w4,w5) = {w1,w2,w3,w4,w5}
#define SIXWORDINLINE(w1,w2,w3,w4,w5,w6)	 = {w1,w2,w3,w4,w5,w6}
#define SEVENWORDINLINE(w1,w2,w3,w4,w5,w6,w7) 	 = {w1,w2,w3,w4,w5,w6,w7}
#define EIGHTWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8) 	 = {w1,w2,w3,w4,w5,w6,w7,w8}
#define NINEWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8,w9) 	 = {w1,w2,w3,w4,w5,w6,w7,w8,w9}
#define TENWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8,w9,w10)  = {w1,w2,w3,w4,w5,w6,w7,w8,w9,w10}
#define ELEVENWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11) 	 = {w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11}
#define TWELVEWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12) 	 = {w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12}
#else
#define ONEWORDINLINE(trapNum)
#define TWOWORDINLINE(w1,w2)
#define THREEWORDINLINE(w1,w2,w3)
#define FOURWORDINLINE(w1,w2,w3,w4)
#define FIVEWORDINLINE(w1,w2,w3,w4,w5)
#define SIXWORDINLINE(w1,w2,w3,w4,w5,w6)
#define SEVENWORDINLINE(w1,w2,w3,w4,w5,w6,w7)
#define EIGHTWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8)
#define NINEWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8,w9)
#define TENWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8,w9,w10)
#define ELEVENWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11)
#define TWELVEWORDINLINE(w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12)
#endif
#endif /* __CONDITIONALMACROS__ */
