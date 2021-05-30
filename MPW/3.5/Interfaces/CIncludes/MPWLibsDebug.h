/************************************************************

    MPWLibsDebug.h
	
    Used to disable/enable extended argument-checking with the
	debugging versions of certain MPW libraries. 

    Copyright Apple Computer,Inc.  1996
    All rights reserved


 ************************************************************/

#ifndef __MPWLIBDEBUG__
#define __MPWLIBDEBUG__

#if defined(__powerpc) || defined(powerpc) || defined (__CFM68K__) 
    #pragma import on
#endif

#if __cplusplus
extern "C" {
#endif  /* __cplusplus */

extern short AssertMPWLibsGlobal;
	/* Set AssertsGlobal to 0 to turn off all assertion-checking. */
	/* Default value is 1. */

extern short AssertOnSettingErrno;
	/* Set AssertOnSettingErrno to 1 to turn on assertions that indicate */
	/* that errno has been set to non-zero. */
	/* The default value is 0. */

extern short AssertOnCharRange;
	/* Set AssertOnCharRange to 1 to check that an int argument representing 		*/
	/* a character falls within 0...UCHAR_MAX (0...255 for MrC and SC). 			*/
	/* Since ctype functions allow EOF, the check also 								*/
	/* allows -1 for those functions only. 											*/
	/* The default value for AssertOnCharRange is 0. 								*/

extern short AssertOnZeroLengths; 
	/* Set AssertOnZeroLengths to 1 to check that length arguments are not 			*/
	/* equal to zero for functions like memcpy(), malloc(), realloc(), calloc(), 	*/
	/* fread, fwrite, memchr, memcchr, memmove(), etc. 								*/
	/* The default value for AssertOnZeroLengths is 0. 								*/

extern short AssertOnNullsExceptZeroSize; 
	/* Set AssertOnNullsExceptZeroSize to 1 to avoid assertions on NULL pointers	 	*/
	/* when the size/length argument to a function is zero.  Set to 0 to always 	*/
	/* generate assertions when pointers are equal to NULL.							*/
	/* The default value for AssertOnNullsExceptZeroSize is 1. 						*/

extern short AssertOnNullFrees;
	/* Set AssertOnNullFrees to 1 to check that the pointer input argument 			*/
	/* to free() is not null. 														*/
	/* The default value for AssertOnNullFrees is 0. 								*/

extern short AssertOnNullReallocs;
	/* Set AssertOnNullReallocs to 1 to check that the pointer input argument 		*/
	/* to realloc() is not null. 													*/
	/* The default value for AssertOnNullReallocs is 0. 							*/

void __DebugMallocHeap( void );
	/* Call this function at program-exit to check that all allocations made by 	*/
	/* malloc/calloc have been freed. 								*/

#if __cplusplus
}
#endif  /* __cplusplus */

#if defined(__powerpc) || defined(powerpc) || defined (__CFM68K__) 
    #pragma import off
#endif

#endif  /* __MPWLIBDEBUG__ */
