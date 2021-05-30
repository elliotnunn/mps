/************************************************************

    ctype.h
    Testing and mapping character values.

    Copyright Apple Computer,Inc.  1995, 2000-2001
    All rights reserved

************************************************************/


#ifndef __CTYPE__
#define __CTYPE__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
	#define _UPP    (unsigned char)0x01    /* upper case    */
	#define _LOW    (unsigned char)0x02    /* lower case    */
	#define _DIG    (unsigned char)0x04    /* decimal digit */
	#define _WSP    (unsigned char)0x08    /* white space   */
	#define _PUN    (unsigned char)0x10    /* punctuation   */
	#define _CTL    (unsigned char)0x20    /* control       */
	#define _BLA    (unsigned char)0x40    /* blank, ' '    */
	#define _HEX    (unsigned char)0x80    /* hex digit     */
#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
    #pragma import on
#endif

#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
	extern const char * __p_CType;
#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */

#if __cplusplus
extern "C" {
#endif  /* __cplusplus */

extern int isalnum(int c);
extern int isalpha(int c);
extern int iscntrl(int c);
extern int isdigit(int c);
extern int isgraph(int c);
extern int islower(int c);
extern int isprint(int c);
extern int ispunct(int c);
extern int isspace(int c);
extern int isupper(int c);
extern int isxdigit(int c);
extern int tolower(int c);
extern int toupper(int c);

#if CALL_NOT_IN_CARBON || __MPWINTERNAL__

	/*
	 * WARNING:  These macros are not strictly ANSI compliant.  They do not distinguish
	 * between EOF (-1) and 0xFF.  However, since only the "C" locale is currently
	 * supported, and since in the "C" locale both EOF and 0xFF will fail all these
	 * tests, there is no pratical difference.
	 */
	
	#define isalnum(c)   ((int)(__p_CType[(unsigned char)(c)] & (_UPP | _LOW | _DIG)))
	#define isalpha(c)   ((int)(__p_CType[(unsigned char)(c)] & (_UPP | _LOW)))
	#define iscntrl(c)   ((int)(__p_CType[(unsigned char)(c)] & _CTL))
	#define isdigit(c)   ((int)(__p_CType[(unsigned char)(c)] & _DIG))
	#define isgraph(c)   ((int)(__p_CType[(unsigned char)(c)] & (_UPP | _LOW | _DIG | _PUN)))
	#define islower(c)   ((int)(__p_CType[(unsigned char)(c)] & _LOW))
	#define isprint(c)   ((int)(__p_CType[(unsigned char)(c)] & (_UPP | _LOW | _DIG | _PUN | _BLA)))
	#define ispunct(c)   ((int)(__p_CType[(unsigned char)(c)] & _PUN))
	#define isspace(c)   ((int)(__p_CType[(unsigned char)(c)] & _WSP))
	#define isupper(c)   ((int)(__p_CType[(unsigned char)(c)] & _UPP))
	#define isxdigit(c)  ((int)(__p_CType[(unsigned char)(c)] & _HEX))

#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */

/*
 * Apple library extentions.  The prefered mechanism for enabling these is by defining
 * __useAppleExts__.  In the absence of this symbol, the __STDC__ symbol is used to 
 * enable or disable these extentions.
 */

#if defined (__useAppleExts__) || \
     (defined (applec) && ! defined (__STDC__)) || \
     (defined (__PPCC__) && __STDC__ == 0)


extern int isascii (int c);
#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
	#define isascii(c)   ((int)( (unsigned int) (c) <= (unsigned char)0x7F ))
#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */

/*
 * WARNING:  These macros are not strictly ANSI compliant.  Strict compliance would
 * require that, if "c" were not in the proper range, then the original value of
 * "c" would be returned.  It is the user's responsibility to ensure that "c" is
 * in the proper range before using one of these two macros.
 */

#define __tolower(c)   ((int)((unsigned char)(c) - (unsigned char)'A' + (unsigned char)'a'))
#define __toupper(c)   ((int)((unsigned char)(c) - (unsigned char)'a' + (unsigned char)'A'))

extern int toascii (int c);
#if CALL_NOT_IN_CARBON || __MPWINTERNAL__
	#define toascii(c)   ((int)((unsigned char)(c) & (unsigned char)0x7F))
#endif  /* CALL_NOT_IN_CARBON || __MPWINTERNAL__ */

#endif  /* __useAppleExts__ */

#if __cplusplus
}
#endif  /* __cplusplus */

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
    #pragma import off
#endif

#endif  /* __CTYPE__ */
